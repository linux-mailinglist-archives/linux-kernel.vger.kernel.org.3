Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CB847ABEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhLTOkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:40:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53444 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhLTOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:39:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7026FCE10FE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC7C36AE9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:39:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y/lupr/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640011151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6mk0wweobXC6bY9QhqHNnrsqTuSl59WVSOND1X3qZC8=;
        b=Y/lupr/wqDSZwM7z4tajrGRR+Th3enrDCy/70hl1digmwNMMdt/GsImRLPDKOCbLM/rD4h
        IN39pwMZKmqmfpVh0RX2VQCASGaKLczPlAbDCGF+LhPOoeW8cx2o/eTOro/qQq2G6DactU
        7DFHoz3KTJ42NVAKkFC4TIw50Ix/LvM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e63aa15b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 20 Dec 2021 14:39:10 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id f9so29369871ybq.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:39:10 -0800 (PST)
X-Gm-Message-State: AOAM532adWZmHYvPqVSRqi7i5WBIuGQotr3/v3vX+HS6ERDQ6CIT7r5j
        LbWEmk7PA6zGQiRB0Bne+T0CXPC5alcwJQVeiVQ=
X-Google-Smtp-Source: ABdhPJyAH82jcMLvDcsgezyVo1cVZnepbg/THsmGf6P59QD/ltWmat9+HQFK0BvmzKvfFOPskiQGXD1v9EBQeKD1W5g=
X-Received: by 2002:a05:6902:727:: with SMTP id l7mr23372496ybt.115.1640011149808;
 Mon, 20 Dec 2021 06:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-6-bigeasy@linutronix.de> <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
 <20211207201037.h46573oa5nfj33xq@linutronix.de>
In-Reply-To: <20211207201037.h46573oa5nfj33xq@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 20 Dec 2021 15:38:58 +0100
X-Gmail-Original-Message-ID: <CAHmME9pzdXyD0oRYyCoVUSqqsA9h03-oR7kcNhJuPEcEMTJYgw@mail.gmail.com>
Message-ID: <CAHmME9pzdXyD0oRYyCoVUSqqsA9h03-oR7kcNhJuPEcEMTJYgw@mail.gmail.com>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Sebastian,

Sorry for the delay getting back to you.

I think I understand the motivation for this patchset, and maybe it'll
turn out to be the only way of accomplishing what RT needs. But I
really don't like complicating the irq ingestion flow like that,
splitting the captured state into two pieces, and having multiple
entry points. It makes the whole thing more difficult to analyze and
maintain. Again, maybe we'll *have* to do this ultimately, but I want
to make sure we at least explore the alternatives fully.

One thing you brought up is that the place where a spinlock becomes
problematic for RT is if userspace goes completely nuts with
RNDRESEEDCRNG. If that's really the only place where contention might
be harmful, can't we employ other techniques there instead? For
example, just ratelimiting the frequency at which RNDRESEEDCRNG can be
called _before_ taking that lock, using the usual ratelimit.h
structure? Or, alternatively, what about a lock that very heavily
prioritizes acquisitions from the irq path rather than from the
userspace path? I think Herbert might have had a suggestion there
related to the net stack's sock lock?

Jason
