Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6F57394F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236623AbiGMOx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiGMOxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:53:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBFB21803;
        Wed, 13 Jul 2022 07:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66AEAB82011;
        Wed, 13 Jul 2022 14:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3597C34114;
        Wed, 13 Jul 2022 14:53:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VnEbdD4F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657724029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ux4sG/EYzthqBMSH9pl5QpI8bHI1zUoLzdMJcDTink=;
        b=VnEbdD4FhKAoq1aqyrR+6BlIEDGmLS2bHnkDp4fOnAaEmucOc4u/+8uOuik3blUw0TVFZQ
        FhQ+iaekrmswqVuLpMgn3Y+rJtYkZODu7rdEpBSMEgWxaXw45jlbWwOrQp0lkkfJFMoq1s
        4gXik1/ssTCwo9eBW1lFbsZTZb/rmaA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 770f9dfd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 13 Jul 2022 14:53:48 +0000 (UTC)
Received: by mail-il1-f180.google.com with SMTP id d4so5588646ilc.8;
        Wed, 13 Jul 2022 07:53:48 -0700 (PDT)
X-Gm-Message-State: AJIora/xrWBU3Avua5QyDmjQRMEhZycIQA8sgHBYoD1qEjYSvKKF+gKs
        q+/AE/pCNUQWJoMtNJJ8jf66bNY6tZVIvrj1dCI=
X-Google-Smtp-Source: AGRyM1tx7PdAgyK0fhCMi+jZrwlTNaBqNltTxVsI9MH+MGZ2lzjviA9zkGvcMezTGttxqqQMBYjero2U0idajKc4wbQ=
X-Received: by 2002:a05:6e02:148d:b0:2dc:9a63:aab9 with SMTP id
 n13-20020a056e02148d00b002dc9a63aab9mr2078406ilk.6.1657724027025; Wed, 13 Jul
 2022 07:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220422132027.1267060-1-Jason@zx2c4.com> <eb74e1b8-af7e-21e8-658f-af6c7975264e@arm.com>
 <Ys7ZURKkoHw8Bp+q@zx2c4.com> <653f4dd9-1325-22f5-1fe0-79e0ec9d2283@arm.com>
In-Reply-To: <653f4dd9-1325-22f5-1fe0-79e0ec9d2283@arm.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 13 Jul 2022 16:53:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
Message-ID: <CAHmME9rrQVm72P6cLL4dUnSw+9nnXszDbQXRd3epRaQgKTy8BQ@mail.gmail.com>
Subject: Re: [PATCH] random: vary jitter iterations based on cycle counter speed
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

Hi Vladimir,

On Wed, Jul 13, 2022 at 4:52 PM Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>
> Hi Jason,
>
> On 7/13/22 15:40, Jason A. Donenfeld wrote:
> > Hi Vladimir,
> >
> > On Wed, Jul 13, 2022 at 03:31:05PM +0100, Vladimir Murzin wrote:
> >> I've just seen on the platform with slow(ish) timer that it is now considered
> >> as a source of entropy with samples_per_bit set to 27 (5.19-rc6 has MAX_SAMPLES_PER_BIT
> >> set to 32). Because of that I see significant delays and I'm trying to understand what
> >> could be wrong with my setup.
> >>
> >> I observe one credit_init_bits(1) call (via entropy_timer()) per ~970 schedule() calls.
> >> Is that somewhat expected? Does it make sense at all?
> >
> > How slow are we talking? Seconds? Minutes? Is it too slow? It's possible
> > that MAX_SAMPLES_PER_BIT=32 is a bit high as a threshold and I should
> > reduce that a bit.
> >
>
> TBH, I run out of patience and never seen it completes, more then seconds. I just was
> curious how much it is should take to get crng_ready() return true.

Ooof. Yea, running this in a VM with various settings I can see that
the current maximum is problematic. I'll fix that up and send a patch.

Jason
