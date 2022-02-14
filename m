Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464904B528D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354839AbiBNOBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:01:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiBNOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:01:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA8BCBF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:01:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85DECB80F10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A10C340EF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:01:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NdbhdFJx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644847258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MamBCqt1HeU/i9SyTy3u63WAu8BB7npWk5waT1JwMQ=;
        b=NdbhdFJxA07/IXUTTO+hc0mhxD6MqDfvMmi9xZAMAOFIX6ygWZaTjzKGwmlw+kPfcw136G
        nOKtJBDfplc2p1v8DClxIhcfv/9ict47V4e2QHAlbLTmkkncNgkhsNSJhOjYuL4ZeTVtmX
        bQpnRDQoXR9jYB9X2UatEHiF2J/kS8g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 569c388d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 14 Feb 2022 14:00:57 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id y129so46308369ybe.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:00:57 -0800 (PST)
X-Gm-Message-State: AOAM533KozJkgUChl8R73ILDGlx/oZYo7KuvWsvxo7CHkppamCG3/9pY
        d3cNtQIX24qFwriRWj7MN/qBSF+iFxcL3sjWtjU=
X-Google-Smtp-Source: ABdhPJzxn8IDygBbNUP6VGounBqAyjtXNkmuw0InzxY6YGu9I8vgB5hkgIQ8MFTqVbHw9J7k9vdWqCginYP1Rx07GtA=
X-Received: by 2002:a81:1084:: with SMTP id 126mr13994076ywq.231.1644847256506;
 Mon, 14 Feb 2022 06:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20220214134838.980159-1-Jason@zx2c4.com>
In-Reply-To: <20220214134838.980159-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 14 Feb 2022 15:00:45 +0100
X-Gmail-Original-Message-ID: <CAHmME9q4Wu3=Tsm4xoBv_s6EsOuJd5UfjcA+WsmZeUDsj1uSWQ@mail.gmail.com>
Message-ID: <CAHmME9q4Wu3=Tsm4xoBv_s6EsOuJd5UfjcA+WsmZeUDsj1uSWQ@mail.gmail.com>
Subject: Re: [PATCH] random: invalidate crngs and batches on cpuhp teardown
To:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

This is the follow up I alluded to in my earlier email. If we get the
cpuhp notifier working correctly, per
<https://lore.kernel.org/lkml/20220214133735.966528-1-Jason@zx2c4.com/>,
then this patch here should be an easy and correct extension.

I was wondering, though, how common this general pattern is, and
whether there's an opportunity at some point down the road for a more
general mechanism. Right now, we have this:

static DEFINE_PER_CPU(struct crng, crngs) = {
    .generation = ULONG_MAX,
    .lock = INIT_LOCAL_LOCK(crngs.lock),
};

What we're running into is that we want the structure to have that
contents immediately after the CPU boots up (which is why this patch
and the previous one sets it during teardown). Maybe other things also
find themselves wanting this too, such that we could have something
called:

static DEFINE_PER_CPU_HPINIT(struct crng, crngs) = {
    .generation = ULONG_MAX,
    .lock = INIT_LOCAL_LOCK(crngs.lock),
};

These would go in a separate linker section, and cpuhp would memcpy
the various sections in at the appropriate time.

Does this seem feasible / desirable? Or is the use case we've found
here actually pretty niche so this wouldn't help with much? Anyhow,
I'm mostly just curious, and intend to move ahead with the approach of
the patch here, but thought I'd mention this.

Jason
