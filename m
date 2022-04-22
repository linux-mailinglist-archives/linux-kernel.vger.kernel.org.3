Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535F950ACB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442882AbiDVAVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiDVAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:21:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4581C44A23
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:18:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id w16so5727pfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+RTuxQG+iRskVek8AslHlw0bjVggzNF9ZagfuFsVepE=;
        b=IKr+r+Z8C8SUwykQDfgF89BIbef6yZCy/3wM/eKiL8OI1PAs9JrAmpiUOJfzfLVEIv
         BLPVuNaR1x23cr2pGguL6QOKA5XsZDauAdoll3byo/YnbdSD/yRBk0piBGXDfuBKApxU
         Tac8GoQCOruN+l+j52SjYhQTdaPqjJzmuEW1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+RTuxQG+iRskVek8AslHlw0bjVggzNF9ZagfuFsVepE=;
        b=MZkR4SA5M+lFe5arD5gB6VJJLTtK0/VPU9RDSylWASCzMLcprQJE3IIEDDcKNr8Q3g
         mf2HUrmmV2vQ4fBjyjomOGZ6I0R6M3F3G2pT5vP8GM9yJ5kMLbhGCKr/6PUNoyYSYnBW
         V8WHQeHGYYtGTy+snNL4rAjFif3wlpxEk31Yl/N/A976O5VG4QaTITDi7Ll+qArmVR/E
         6VLfUXH8jWblSAjYJPt36esWJwHxJ1iX/LIbFYl4DZTZ/Rcm0ZFrgoCUhgzAq2z66rtx
         vgWrafpv722rSkWK0HOqLRYl5+nYltzkXs/jFXTHwTbmn5TDXnN+Ne1FWe+KyZ7xu4zK
         0jmg==
X-Gm-Message-State: AOAM533/DtopQtcqAW3Lf75RcNCN3AmYWfsGW75nVAtO218RXQHXeElb
        fW3NWgkRb6uR04aDx9XgOwVMrQ==
X-Google-Smtp-Source: ABdhPJz/X2920kZyunQU+DSg1Y/mOIUiVAZdv6gtSgyWMKFT7kamaUSr7Hb8BJVD0k6CpO48oiX9vw==
X-Received: by 2002:a63:1c5c:0:b0:398:f69b:1996 with SMTP id c28-20020a631c5c000000b00398f69b1996mr1691632pgm.370.1650586736686;
        Thu, 21 Apr 2022 17:18:56 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:e283:652b:fb2e:829f])
        by smtp.gmail.com with ESMTPSA id n59-20020a17090a5ac100b001cd498dc153sm4856572pji.3.2022.04.21.17.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 17:18:56 -0700 (PDT)
Date:   Thu, 21 Apr 2022 17:18:53 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexeymin@postmarketos.org
Subject: [PATCH] mmc: core: Don't set HS200 clock rate prematurely
Message-ID: <YmH0bU5VEnaVds5H@google.com>
References: <20220330132946.v3.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <11962455.O9o76ZdvQC@g550jk>
 <YmG9sdJ8RoKH4gUS@google.com>
 <4731277.31r3eYUQgx@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4731277.31r3eYUQgx@g550jk>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c7ec586fe55 ("mmc: core: Set HS clock speed before sending HS
CMD13") fixes problems with certain eMMC, but introduced new ones with
others:

  qcom-msm8974-fairphone-fp2:

  [    1.868608] mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA 64-bit
  [    1.925220] mmc0: mmc_select_hs200 failed, error -110
  [    1.925285] mmc0: error -110 whilst initialising MMC card

It appears we've overshot the acceptable clock rate here; while JESD84
suggests that we can bump to 52 MHz before switching (CMD6) to HS400, it
does *not* say we can switch to 200 MHz before switching to HS200 (see
page 45 / table 28). Use the HS bounds (typically 52 MHz) instead of the
HS200 bounds (which are only applicable after we successfully switch).

Link: https://lore.kernel.org/lkml/11962455.O9o76ZdvQC@g550jk/
Fixes: 1c7ec586fe55 ("mmc: core: Set HS clock speed before sending HS CMD13")
Reported-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Hi Luca,

On Fri, Apr 22, 2022 at 12:04:01AM +0200, Luca Weiss wrote:
> It looks like with the original patch in, plus your attached patch on top it 
> seems to work as well. Thanks!

Awesome! I've written up a formal patch (surrounding this), with my best
understanding of an explanation. Thanks again.

Ulf, please let me know whether you're happier with this, or whether we
should (partially?) revert.

Brian
 
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9ab915b5737a..f0bbac364682 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1491,7 +1491,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 		old_timing = host->ios.timing;
 		old_clock = host->ios.clock;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
-		mmc_set_bus_speed(card);
+		mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
 
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

