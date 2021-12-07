Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FA46C49C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhLGUcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbhLGUcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:32:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBA1C061574;
        Tue,  7 Dec 2021 12:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=htAfEvBh1haq0xkYScON/97SvVrSU/nSd7InMPgsr10=; b=YW0Bedd0oeI+SHiUFPencx2dkE
        /1+f9wKKxd9aADgLWDqoZbD8wJAOGOeOCfGiyywM1TzYhL57kqrK6r/JOMUGPquf/z4e2Uu0IZxS0
        Vsvsdp7GyFoexc4ngkFEY7Bc8vgPCRgpIIolww0DigeTqjHXMRoxoU1dIf7aBnjbHUfU1blN4/m3a
        3uykyKd7M91pF14f5RX2T+R1GbSwHQw4A4/KxMjHD4hz7iqqF2f+XQXGTOe+b5I4w0MvXlBN0soXw
        dCm9ojQSnXIjeu19RnvXzqM7/dxLYh0wzcTuZ/2gflUPWeROfkGqJZ1OyJ+RDIeUlbbs3Hq+STQij
        tT1iOkOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muh4f-007kAn-OB; Tue, 07 Dec 2021 20:28:30 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D312981654; Tue,  7 Dec 2021 21:28:31 +0100 (CET)
Date:   Tue, 7 Dec 2021 21:28:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <20211207202831.GA18361@worktop.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 02:28:22PM +0100, Peter Zijlstra wrote:

> For refcount_inc(), as extracted from alloc_perf_context(), I get:
> 
>     4b68:       b8 01 00 00 00          mov    $0x1,%eax
>     4b6d:       f0 0f c1 43 28          lock xadd %eax,0x28(%rbx)
>     4b72:       85 c0                   test   %eax,%eax
>     4b74:       74 1b                   je     4b91 <alloc_perf_context+0xf1>
>     4b76:       8d 50 01                lea    0x1(%rax),%edx
>     4b79:       09 c2                   or     %eax,%edx
>     4b7b:       78 20                   js     4b9d <alloc_perf_context+0xfd>
> 
> the best I can seem to find is: https://godbolt.org/z/ne5o6eEEW

Argh.. __atomic_add_fetch() != __atomic_fetch_add(); much confusion for
GCC having both. With the right primitive it becomes:

        movl    $1, %eax
        lock xaddl      %eax, (%rdi)
        testl   %eax, %eax
        je      .L5
        js      .L6

Which makes a whole lot more sense.
