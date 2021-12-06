Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D246918F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhLFIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbhLFIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:35:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9404C061746;
        Mon,  6 Dec 2021 00:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RAOjWEnjdaxO+mN2MflQwOdw7ogQKwCubfs0WO8EAXU=; b=Xbf8ivWkigmBQIlw+0NkBCXonb
        M8ekMTu9Ou1WaLNpwBz/7CvWGASD6CplmbkMzMJ/w2eizNsKFqEAmly75oLyGDGT5WFDlM52RNQAu
        +Dm7ppuft5tEm3idLjW4jENEBtOiKsBUmNS/9+M3oitHTaB2uEwpbh0reCTPGUjRHS9CYIQyXezA0
        OPvxIlVNKawrBhu2C+I2Bgg+ibJsYGuFEJvtlM9tygvaPAIOTAIYalfRSntvXEE5+ENqRJyPDXLCY
        PMFErOv5rUwdtKHLcP91d7ZGVoErLX0nQhdBNN1tK5lBMWD0t10pir8S2p2CrMXPP35VkbqPXhVw4
        aonJxp5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mu9PL-002WHD-My; Mon, 06 Dec 2021 08:31:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93E69300252;
        Mon,  6 Dec 2021 09:31:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A46B2B32066D; Mon,  6 Dec 2021 09:31:34 +0100 (CET)
Date:   Mon, 6 Dec 2021 09:31:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        keescook@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya2zfVAwh4aQ7KVd@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2021 at 10:53:49PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 03, 2021 at 08:35:40AM -0700, Jens Axboe wrote:
> > refcount_t is not as expensive as it used to be, but it's still more
> > expensive than the io_uring method of using atomic_t and just checking
> > for potential over/underflow.
> > 
> > This borrows that same implementation, which in turn is based on the
> > mm implementation from Linus.
> 
> If refcount_t isn't good enough for a normal kernel fast path we have
> a problem.  Can we discuss that with the maintainers instead of coming
> up with our home grown schemes again?

Quite; and for something that pretends to be about performance, it also
lacks any actual numbers to back that claim.

The proposed implementation also doesn't do nearly as much as the
refcount_t one does.

Anyway refcount_t is just a single "lock xadd" and a few branches, where
does it go wrong? Do you have perf output to compare between them?
