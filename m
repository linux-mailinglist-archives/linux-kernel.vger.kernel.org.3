Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D3150CB63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiDWOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiDWOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:44:25 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E95D080A;
        Sat, 23 Apr 2022 07:41:25 -0700 (PDT)
Received: from g550jk.localnet (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BC581CAE5B;
        Sat, 23 Apr 2022 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650724883; bh=BIfSWu7v2lgpz9edEm/FgQbjWjN5ZtnItWkbbsxl6Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SeYpb55do4rv9Mt2RniftzH6LcLYOEsFVSIj/Te9mJ7TxUh1WDYZ98L/U37j7tUGF
         SX4kP4mGbUyB+DTeQs96SG8j0tOE5X40pHKeIEHKuorX9dFDuO1++wPyX9oFmzxq6x
         FuB7EIZ287XRIt80w+dvKNJAEXwBKKgb2hzWAyOI=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v4] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Sat, 23 Apr 2022 16:41:23 +0200
Message-ID: <2235553.ElGaqSPkdT@g550jk>
In-Reply-To: <20220422100824.v4.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
References: <20220422100824.v4.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On Freitag, 22. April 2022 19:08:53 CEST Brian Norris wrote:
> Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> some eMMC don't respond to SEND_STATUS commands very reliably if they're
> still running at a low initial frequency. As mentioned in that commit,
> JESD84-B51 P49 suggests a sequence in which the host:
> 1. sets HS_TIMING
> 2. bumps the clock ("<= 52 MHz")
> 3. sends further commands
> 
> It doesn't exactly require that we don't use a lower-than-52MHz
> frequency, but in practice, these eMMC don't like it.
> 
> The aforementioned commit tried to get that right for HS400ES, although
> it's unclear whether this ever truly worked as committed into mainline,
> as other changes/refactoring adjusted the sequence in conflicting ways:
> 
> 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode
> switch")
> 
> 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode
> for mmc")
> 
> In any case, today we do step 3 before step 2. Let's fix that, and also
> apply the same logic to HS200/400, where this eMMC has problems too.
> 
> Resolves errors like this seen when booting some RK3399 Gru/Scarlet
> systems:
> 
> [    2.058881] mmc1: CQHCI version 5.10
> [    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using
> ADMA [    2.209804] mmc1: mmc_select_hs400es failed, error -84
> [    2.215597] mmc1: error -84 whilst initialising MMC card
> [    2.417514] mmc1: mmc_select_hs400es failed, error -110
> [    2.423373] mmc1: error -110 whilst initialising MMC card
> [    2.605052] mmc1: mmc_select_hs400es failed, error -110
> [    2.617944] mmc1: error -110 whilst initialising MMC card
> [    2.835884] mmc1: mmc_select_hs400es failed, error -110
> [    2.841751] mmc1: error -110 whilst initialising MMC card
> 
> Ealier versions of this patch bumped to 200MHz/HS200 speeds too early,
> which caused issues on, e.g., qcom-msm8974-fairphone-fp2. (Thanks for
> the report Luca!) After a second look, it appears that aligns with
> JESD84 / page 45 / table 28, so we need to keep to lower (HS / 52 MHz)
> rates first.
> 
> Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed
> mode switch") Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when
> switching to HS mode for mmc") Fixes: 4f25580fb84d ("mmc: core: changes
> frequency to hs_max_dtr when selecting hs400es") Cc: Shawn Lin
> <shawn.lin@rock-chips.com>
> Link: https://lore.kernel.org/linux-mmc/11962455.O9o76ZdvQC@g550jk/
> Reported-by: Luca Weiss <luca@z3ntu.xyz>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Verified on qcom-apq8026-lg-lenok which also showed the same error with the 
last revision of this patch.

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca

> ---
> 
> Changes in v4:
>  * Revert to hs_max_dtr for HS200, due to issues reported by Luca Weiss
>    <luca@z3ntu.xyz>; Luca, feel free to provide a "Tested-by: ..." reply
>    if you'd like that included
>  * Drop the "redundant clock rate" changes, as they aren't needed any
>    more
> 
> Changes in v3:
>  * Use mmc_set_bus_speed() to help choose the right clock rate
>  * Avoid redundant clock rate changes
>  * Restore clock rate on failed HS200 switch
> 
> Changes in v2:
>  * Use ext_csd.hs200_max_dtr for HS200
>  * Retest on top of 3b6c472822f8 ("mmc: core: Improve fallback to speed
>    modes if eMMC HS200 fails")
> 
>  drivers/mmc/core/mmc.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 



