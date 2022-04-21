Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06B350AB27
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442309AbiDUWGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 18:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380775AbiDUWGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 18:06:54 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6F4EDD2;
        Thu, 21 Apr 2022 15:04:03 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 81EE8CC10C;
        Thu, 21 Apr 2022 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650578641; bh=CH9hWu/6r4ubmkinPIzws6ZjZ/RzGXMtPD9Ku7VxRYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=upBJdaq+7Qspuuk16wpjuFLoXFzh7y+dptU1zeB/a2JGaJjKadktI3QiF2XU6Ne4o
         2auS3I9vBd8iMlOApKFmyLb5ySNFxaYJS+l0H+UCegFZJpLUcFifxHFzp4EibpWZQY
         I5z26UisGsSkxEbYfh9K4r81U0YU1xpFUzt/FOts=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexeymin@postmarketos.org
Subject: Re: [PATCH v3] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Fri, 22 Apr 2022 00:04:01 +0200
Message-ID: <4731277.31r3eYUQgx@g550jk>
In-Reply-To: <YmG9sdJ8RoKH4gUS@google.com>
References: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid> <11962455.O9o76ZdvQC@g550jk> <YmG9sdJ8RoKH4gUS@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Donnerstag, 21. April 2022 22:25:21 CEST Brian Norris wrote:
> Hi Luca,
> 
> On Thu, Apr 21, 2022 at 08:46:42PM +0200, Luca Weiss wrote:
> > On Mittwoch, 6. April 2022 16:55:40 CEST Ulf Hansson wrote:
> > > To get this thoroughly tested, I have applied it to my next branch, for
> > > now.
> > > 
> > > If it turns out that there are no regressions being reported, I think
> > > we should move the patch to the fixes branch (to get it included for
> > > v5.18) and then also tag it for stable. So, I will get back to this in
> > > a couple of weeks.
> > 
> > Unfortunately this patch breaks internal storage on
> > qcom-msm8974-fairphone-fp2
> That is indeed unfortunate :( So we should definitely not pick it to
> fixes/stable, at least not yet. And if we can't come to a solution soon,
> maybe revert it entirely, or at least drop the HS200 portions of the
> change. (The systems that inspired this change are OK at HS400ES, FWIW,
> so the HS200 changes are just a bonus.)
> 
> > With this patch (included in linux-next-20220421) it fails to initialize:
> > 
> > [    1.868608] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci]
> > using ADMA 64-bit
> > [    1.925220] mmc0: mmc_select_hs200 failed, error -110
> > [    1.925285] mmc0: error -110 whilst initialising MMC card
> > 
> > After reverting this patch, it works fine again.
> > 
> > [    1.908835] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci]
> > using ADMA 64-bit
> > [    1.964700] mmc0: new HS200 MMC card at address 0001
> > [    1.965388] mmcblk0: mmc0:0001 BWBC3R 29.1 GiB
> > [    1.975106]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
> > p15
> > p16 p17 p18 p19 p20
> > [    1.982545] mmcblk0boot0: mmc0:0001 BWBC3R 4.00 MiB
> > [    1.988247] mmcblk0boot1: mmc0:0001 BWBC3R 4.00 MiB
> > [    1.993287] mmcblk0rpmb: mmc0:0001 BWBC3R 4.00 MiB, chardev (242:0)
> 
> As a bit of a (semi-educated) shot in the dark: can you try the appended
> patch? That's what my patch v1 did, but I changed it due to review
> comments. (Either way worked for my systems.) After re-reading the
> HS200-specific portions of the spec (JESD84-B51 page 45 / 6.6.2.2), it's
> possible setting all the way to 200 MHz this early was a bit
> overagressive, and we should be keeping a max of 52 MHz at this point.

It looks like with the original patch in, plus your attached patch on top it 
seems to work as well. Thanks!

Regards
Luca

> 
> Thanks for testing and reporting.
> 
> Brian
> 
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1491,7 +1491,7 @@ static int mmc_select_hs200(struct mmc_card *card)
>  		old_timing = host->ios.timing;
>  		old_clock = host->ios.clock;
>  		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> -		mmc_set_bus_speed(card);
> +		mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
> 
>  		/*
>  		 * For HS200, CRC errors are not a reliable way to know 
the




