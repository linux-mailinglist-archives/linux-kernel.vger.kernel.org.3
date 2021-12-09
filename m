Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB8646E445
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhLIIgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhLIIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:36:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8CAC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 00:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fyCt+Na28XXba2KV4kePYVgvsEEky23cSo4ML/g/LYE=; b=d7hrcDLvoJZShUBJ5eAkPGUyrl
        3PHMS8FBNp7ePkFUD6iYiPgBmslEI8BF+/MQELkypuAC6xb6Lg1jJQnpDx2yrMbU6NWZsy5XoylKd
        YkCmPx9+D7DpMBl++QtGvOvKi5ANvpdSBcTigCMNr8L0fKpd+6BZUCygsY1dXcv0l5CmLNB3dKYSa
        Qro2FHuEbDaNJvjdBr2il0B1f0jSUqovj3KUfNgEDNyiGL9CTuzH2W+kC4lr03arffZ6w9yPkDcVo
        OdnAUT08+0/Si8iVI5FdF96kzED42HUnPkPV6j7DZf6EodoDLD6pkK7hE80P6vRUgQksYA+OEv/H0
        8MoNCo5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvErR-009B1V-0b; Thu, 09 Dec 2021 08:33:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41BBD9817E0; Thu,  9 Dec 2021 09:33:05 +0100 (CET)
Date:   Thu, 9 Dec 2021 09:33:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [RFC][PATCH 3/5] refcount: Improve out-of-line code-gen
Message-ID: <20211209083305.GN16608@worktop.programming.kicks-ass.net>
References: <20211208183655.251963904@infradead.org>
 <20211208183906.548393311@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208183906.548393311@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 07:36:58PM +0100, Peter Zijlstra wrote:
> Allow a number of ops to tail-call refcount_warn_saturate() in order
> to generate smaller out-of-line code.
> 
>    text    data     bss     dec     hex filename
>   97341    4985    1116  103442   19412 defconfig-build/kernel/events/core.o
>   97299    4985    1116  103400   193e8 defconfig-build/kernel/events/core.o
> 

This patch also makes GCC do worse code-gen on the fast path, so I'll
drop it.

For some obscure raisin it causes this:

ring_buffer_put:
    a950:       f0 ff 0f                lock decl (%rdi)
    a953:       7c 20                   jl     a975 <ring_buffer_put+0x25>
    a955:       74 01                   je     a958 <ring_buffer_put+0x8>
    a957:       c3                      ret


ring_buffer_put:
    a940:       53                      push   %rbx
    a941:       48 89 fb                mov    %rdi,%rbx
    a944:       f0 ff 0f                lock decl (%rdi)
    a947:       7c 04                   jl     a94d <ring_buffer_put+0xd>
    a949:       74 10                   je     a95b <ring_buffer_put+0x1b>
    a94b:       5b                      pop    %rbx
    a94c:       c3                      ret

Which is just unacceptible...
