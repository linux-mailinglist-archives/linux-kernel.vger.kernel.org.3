Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299804610C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbhK2JHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbhK2JFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:05:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CCDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 00:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TovPf+jjuvo5NCOy/tvJhW4DOAeLEg6t2wBTn9RiJg4=; b=uOxAywY8BYwoSJAbaHl4lyBWLB
        s7K3MAMb+Ygghi8h4fBbNIsDozTkzMf0ZoQRNmf7EDpYx0VQ15YMdDzusu9lCCUW8Eh6j9MTcXnZ0
        60M/fzolwZKQTnxVRXk0v5dTX6Ac9uOpq6xU2Y+pp1IIPHezG7cWGjJ1B3y9Ip1TkNUWzSkSyCzYp
        yPfWbhCS3/yAZdc6nIipEBZM/ykLAPuQD3AcVe5lI3MnZ0d85EQIs9zB/fMpf6ydROCwG/XSBj16E
        sw3lMB7aowjLL2K1w4m/GV0q/wHUU/cmjdnjKPHhySUpQEWO0BhzlKjHZ7SekgAlQ5uBQJNsQrLhl
        G6e9qtjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrcMi-006iHy-Hk; Mon, 29 Nov 2021 08:50:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3C4430002F;
        Mon, 29 Nov 2021 09:50:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A6C120167FEC; Mon, 29 Nov 2021 09:50:23 +0100 (CET)
Date:   Mon, 29 Nov 2021 09:50:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.16-rc3
Message-ID: <YaSUT2roW6SH2OxM@hirez.programming.kicks-ass.net>
References: <163811728418.767205.14544746031342483043.tglx@xen13>
 <CAHk-=wh1AZLCtx6Uk1JKpknaHgoLi_DM7221LoRpU6Y_3im03A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh1AZLCtx6Uk1JKpknaHgoLi_DM7221LoRpU6Y_3im03A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 09:15:10AM -0800, Linus Torvalds wrote:
> On Sun, Nov 28, 2021 at 8:35 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >  - down_read_trylock() is suboptimal when the lock is contended and
> >    multiple readers trylock concurrently. That's due to the initial value
> >    being read non-atomically which results in at least two compare exchange
> >    loops. Making the initial readout atomic reduces this significantly.
> >    Whith 40 readers by 11% in a benchmark which enforces contention on
> >    mmap_sem.
> 
> This was an intentional optimization to avoid unnecessary cache
> protocol cycles for when the lock isn't contended - first getting a
> cacheline for read ownership, only to then get it for write.
> 
> But I guess we don't have any good benchmarks for non-contention, so ...
> 
> I also hope that maybe modern hardware is smart enough to see "I will
> write to it later" and avoid the "get line for shared access only to
> get it for exclusive access immediately afterwards" issue.

Yes, I raised that same point, otoh those numbers are not showing that.
They did lightly contended, but I suppose not cache-cold.
