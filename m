Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE9470A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242495AbhLJTk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbhLJTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:40:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C74C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 11:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tejRJRFNHQpqfcq3ScHn1iSS5sy5EtmQtgQoYR8GPuo=; b=CZL5+uyt0lLAz3+HswTb8YB5Az
        N0Lsfra372agCDbDD4zc7No/M6GZRJHJ2IoSA3mGe6EeEo4UT759Ve+0BOY7FLh2eTmf+91SGLr7+
        JAENv7wlMUP5hLJJXA1Rte/kXKW6xpMR6cINLlOE4GnD3IkArisNtOdgcH+khXHW726LPYUOJbFCh
        L1IGvULfjQoSr6v47DV9KnTApn896+PHXH3sVZW4QIozOu/3CTxbz4vl+vqH9Bqy1OcW8H5cq38hi
        WAECvpF6izzYrcL0xwX0m71wr9dNmHn4QRYnfLBkFzu+Kulrb7V4bcc6uwzLMkdjRR7yaeGtnaR5+
        nk2/a9vA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvlhf-00Ad7P-Ty; Fri, 10 Dec 2021 19:37:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 962B43002C5;
        Fri, 10 Dec 2021 20:37:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DAFA2C55516F; Fri, 10 Dec 2021 20:37:11 +0100 (CET)
Date:   Fri, 10 Dec 2021 20:37:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mark.rutland@arm.com,
        elver@google.com, keescook@chromium.org, hch@infradead.org,
        torvalds@linux-foundation.org, axboe@kernel.dk
Subject: Re: [PATCH v2 0/9] refcount: Improve code-gen
Message-ID: <YbOsZ3YlmCuDyPLk@hirez.programming.kicks-ass.net>
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210161618.645249719@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 05:16:18PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> Now with Linus' favourite refcount scheme on :-)
> 
> Changes since RFC:
> 
>  - more cleanups in scripts/atomic/
>  - rename atomic_*_ofl() to atomic_*_overflow() (null)
>  - alternative x86 refcount scheme (Linus)
>  - fix for refcount_dec_not_one()
>  - opt __refcount_add_not_zero(.i=1)
> 
> Boots x86_64 and builds a kernel.

All patches, including review comments so far (including dec;js) now at:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/wip.refcount

I'll see if I can update the documentation patch this weekend, otherwise
there's always next week :-)
