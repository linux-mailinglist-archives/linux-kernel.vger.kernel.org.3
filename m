Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA7450A85A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391524AbiDUSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386752AbiDUStg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:49:36 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6234BFF2;
        Thu, 21 Apr 2022 11:46:46 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AA167CEA67;
        Thu, 21 Apr 2022 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650566803; bh=xeUnZPF4UDer0MAwbuQnbTGsgs4bU482TfcXY10CNSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bvsyhu9jdtJZ6WJcL6x0eJMTBX/oTwBUviVVONYox3J8aUtKKotpVIuKOv80j6Drh
         LYbm+uQi1UfCutRr8qJwBbL/lwPqA+qjxTq4YVOACDjiDusDM1b3f7XWldrOuplV/V
         VREULos66IW8s7kV3U4H2N1HFXWx7tT+2r8XlEQ0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexeymin@postmarketos.org
Subject: Re: [PATCH v3] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Thu, 21 Apr 2022 20:46:42 +0200
Message-ID: <11962455.O9o76ZdvQC@g550jk>
In-Reply-To: <CAPDyKFpQGR3ughi+6rCLUiK07Jxd5y20oK9HBjYiO-+TE8-o=Q@mail.gmail.com>
References: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid> <CAPDyKFpQGR3ughi+6rCLUiK07Jxd5y20oK9HBjYiO-+TE8-o=Q@mail.gmail.com>
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

Hi Brian and Ulf,

On Mittwoch, 6. April 2022 16:55:40 CEST Ulf Hansson wrote:
> On Wed, 30 Mar 2022 at 22:30, Brian Norris <briannorris@chromium.org> wrote:
> > Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> > hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> > some eMMC don't respond to SEND_STATUS commands very reliably if they're
> > still running at a low initial frequency. As mentioned in that commit,
> > JESD84-B51 P49 suggests a sequence in which the host:
> > 1. sets HS_TIMING
> > 2. bumps the clock ("<= 52 MHz")
> > 3. sends further commands
> > 
> > It doesn't exactly require that we don't use a lower-than-52MHz
> > frequency, but in practice, these eMMC don't like it.
> > 
> > The aforementioned commit tried to get that right for HS400ES, although
> > it's unclear whether this ever truly worked as committed into mainline,
> > as other changes/refactoring adjusted the sequence in conflicting ways:
> > 
> > 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode
> > switch")
> > 
> > 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode
> > for mmc")
> > 
> > In any case, today we do step 3 before step 2. Let's fix that, and also
> > apply the same logic to HS200/400, where this eMMC has problems too.
> > 
> > Resolves errors like this seen when booting some RK3399 Gru/Scarlet
> > systems:
> > 
> > [    2.058881] mmc1: CQHCI version 5.10
> > [    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using
> > ADMA [    2.209804] mmc1: mmc_select_hs400es failed, error -84
> > [    2.215597] mmc1: error -84 whilst initialising MMC card
> > [    2.417514] mmc1: mmc_select_hs400es failed, error -110
> > [    2.423373] mmc1: error -110 whilst initialising MMC card
> > [    2.605052] mmc1: mmc_select_hs400es failed, error -110
> > [    2.617944] mmc1: error -110 whilst initialising MMC card
> > [    2.835884] mmc1: mmc_select_hs400es failed, error -110
> > [    2.841751] mmc1: error -110 whilst initialising MMC card
> > 
> > Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed
> > mode switch") Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when
> > switching to HS mode for mmc") Fixes: 4f25580fb84d ("mmc: core: changes
> > frequency to hs_max_dtr when selecting hs400es") Cc: Shawn Lin
> > <shawn.lin@rock-chips.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> 
> To get this thoroughly tested, I have applied it to my next branch, for now.
> 
> If it turns out that there are no regressions being reported, I think
> we should move the patch to the fixes branch (to get it included for
> v5.18) and then also tag it for stable. So, I will get back to this in
> a couple of weeks.

Unfortunately this patch breaks internal storage on qcom-msm8974-fairphone-fp2

With this patch (included in linux-next-20220421) it fails to initialize:

[    1.868608] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using 
ADMA 64-bit
[    1.925220] mmc0: mmc_select_hs200 failed, error -110
[    1.925285] mmc0: error -110 whilst initialising MMC card

After reverting this patch, it works fine again.

[    1.908835] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using 
ADMA 64-bit
[    1.964700] mmc0: new HS200 MMC card at address 0001
[    1.965388] mmcblk0: mmc0:0001 BWBC3R 29.1 GiB 
[    1.975106]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 
p16 p17 p18 p19 p20
[    1.982545] mmcblk0boot0: mmc0:0001 BWBC3R 4.00 MiB 
[    1.988247] mmcblk0boot1: mmc0:0001 BWBC3R 4.00 MiB 
[    1.993287] mmcblk0rpmb: mmc0:0001 BWBC3R 4.00 MiB, chardev (242:0)


Regards
Luca



