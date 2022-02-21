Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F44BE195
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377876AbiBUOga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:36:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378042AbiBUOg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:36:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB2E1C116
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98443B811B8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0880DC340F0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:35:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="T5TTZcfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645454157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZWqQucztzl4FMO8upbni3vH9WRsE2DJlKlbVztRZoI=;
        b=T5TTZcfUVNzi1UuVD1Sv4M5Gfa1uWebZtnEz3y2EM/ZbI85v7/FSTQu7x26jApWi6Omnq/
        hIsNsCH1UB7UAVvhNgM786UwNLcd9G1jnLJ4Ee/HoAjA/mQ+6icJzpc4YPJn/wrz4/0edb
        hmXpx2OxNxARYkt1PmmgOjUUfuHRV4Q=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5be08c28 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 21 Feb 2022 14:35:56 +0000 (UTC)
Received: by mail-yb1-f174.google.com with SMTP id y189so13169401ybe.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:35:56 -0800 (PST)
X-Gm-Message-State: AOAM533hOLXR2BnI/fnizgw3kU/nojWcUD3gNCRKqISYRRRSnwwj/nkp
        s+ZaPvawiU5/10a4iD6prsW+uOr78RCnC+8b8bk=
X-Google-Smtp-Source: ABdhPJx0GrQm2ETAXXUyfWLsSofotwSTZNfBq9JAl4lU3Htn6q2iDm1AkpeyoIFC4AsH3ekfrsal5pICYi5IbH7Jcss=
X-Received: by 2002:a25:d116:0:b0:61d:e8c9:531e with SMTP id
 i22-20020a25d116000000b0061de8c9531emr18996061ybg.637.1645454155557; Mon, 21
 Feb 2022 06:35:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oo5y08skaOOXg-q0T9pDs580dOotm6Wz0t96AssZr2Pw@mail.gmail.com>
 <20220210131304.97224-1-Jason@zx2c4.com> <YhMRf1tqgB/zSvAs@sol.localdomain>
In-Reply-To: <YhMRf1tqgB/zSvAs@sol.localdomain>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 21 Feb 2022 15:35:44 +0100
X-Gmail-Original-Message-ID: <CAHmME9pcFkPysTHHUCiPwqO0rv-i8X4nzNvomaSnyxbx3nauig@mail.gmail.com>
Message-ID: <CAHmME9pcFkPysTHHUCiPwqO0rv-i8X4nzNvomaSnyxbx3nauig@mail.gmail.com>
Subject: Re: [PATCH v2] random: tie batched entropy generation to base_crng generation
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAD_CREDIT,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 5:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > @@ -455,7 +453,7 @@ static size_t crng_fast_load(const void *cp, size_t len)
> >               src++; crng_init_cnt++; len--; ret++;
> >       }
> >       if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
> > -             invalidate_batched_entropy();
> > +             ++base_crng.generation;
> >               crng_init = 1;
> >       }
>
> This is an existing issue, but why doesn't crng_slow_load() do this too?

Because it's called by add_device_randomness(), which is mostly
ingesting static bytes, akin to what you get by running `dmidecode`
and such. The idea is that this is something that's good to mix, but
bad to credit. I think there was a CVE a few years back about this,
precipitating the change.

Jason
