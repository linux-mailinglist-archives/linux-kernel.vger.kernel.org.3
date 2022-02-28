Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92024C6F24
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiB1OSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbiB1OSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:18:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF73233;
        Mon, 28 Feb 2022 06:17:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D59EB80E5A;
        Mon, 28 Feb 2022 14:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0C3C340E7;
        Mon, 28 Feb 2022 14:17:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lK1Nq3YY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1646057841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8njSc7ZKJrHgkHgh9VAGEgtzPPG9/NLCjrG9eKCKM5s=;
        b=lK1Nq3YYJFOOd2EkVbyD3rJ32HEMOWJlAalnjrmPTtXeSegv01C2RzhRo8sweZFArkZ96q
        +LJ27WyPqcDpSgR326i8376M8WnkjXejJfGX7KIo25X7mqoy+v/m09bcIb61WuMKt85LOV
        k/ErVeqNVPu731SDHUMnQPunQG+Mae0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 153bc29b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 28 Feb 2022 14:17:21 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id h126so5883413ybc.1;
        Mon, 28 Feb 2022 06:17:21 -0800 (PST)
X-Gm-Message-State: AOAM530Sl7RvlyKQSV4gNko9jGxLbZJuudTX/1nTiyt1Dz1JN6xFMaPW
        IRbQJn6WLOLm55OISKM8T7j8jy6NROa7GTQGfAY=
X-Google-Smtp-Source: ABdhPJy/k9ukSRCEXr6leJG5D5DS5uCbRO8uGJ+1mgry+ocC2D49N7KT58CI/8cRGk/jjb/SCybnuT5zPjKN7p/wVak=
X-Received: by 2002:a25:238d:0:b0:619:3e19:b06b with SMTP id
 j135-20020a25238d000000b006193e19b06bmr18399019ybj.382.1646057840476; Mon, 28
 Feb 2022 06:17:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:71a8:b0:167:24f9:2d40 with HTTP; Mon, 28 Feb 2022
 06:17:19 -0800 (PST)
In-Reply-To: <YhzWE1NqYQFKeL5B@linutronix.de>
References: <CAHmME9pTfwbs9xUJy_jrdPcrhSyVixSXBM==9EuB8v7ufWe9Pw@mail.gmail.com>
 <20220224152937.12747-1-Jason@zx2c4.com> <YhzWE1NqYQFKeL5B@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Feb 2022 15:17:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9r7bRh+CeBh98UMVCFgmeMWHQ=r3b-8odgV0tR45hOTbw@mail.gmail.com>
Message-ID: <CAHmME9r7bRh+CeBh98UMVCFgmeMWHQ=r3b-8odgV0tR45hOTbw@mail.gmail.com>
Subject: Re: [PATCH v2] random: do crng pre-init loading in worker rather than irq
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Hey Sebastian,

On 2/28/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2022-02-24 16:29:37 [+0100], Jason A. Donenfeld wrote:
>> Taking spinlocks from IRQ context is problematic for PREEMPT_RT. That
>> is, in part, why we take trylocks instead. But apparently this still
>> trips up various lock dependency analyzers. That seems like a bug in the
>> analyzers that should be fixed, rather than having to change things
>> here.
>
> Could you please post a lockdep report so I can take a look?

I thought the problem with lockdep was stated by you somewhere in this thread?
https://lore.kernel.org/lkml/YfOqsOiNfURyvFRX@linutronix.de/
"But even then we need to find a way to move the crng init part
(crng_fast_load()) out of the hard-IRQ."
And Jonathan posted two related (?) splats he ran into.

I may have gotten that all wrong, in which case, I'll just excise that
part from the commit message. I'm pretty sure you want this patch
either way, right?

Jason
