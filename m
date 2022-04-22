Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8950BE03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbiDVRMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiDVRMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65F48D6A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:09:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j6so6245214pfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkPfqDmkY8KImet371CZtiMwqL3xYv7MY5i6YutDB18=;
        b=ncN4W2vOsDVnoc4oVw2ea+O0cnzBA5VAH5VyP1AwfaAk/0a+naaEIZglGAd6BLAQ1t
         3qqSPad0w/EsbLBXcE+ECn5NkxfffSq79EKErg+z0BDss3Y06cSBGG2996bjzDmhULGC
         5PTjFL1z3g5ZEdSIRUkfXH3lM86FZ3+ymoiZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LkPfqDmkY8KImet371CZtiMwqL3xYv7MY5i6YutDB18=;
        b=SiNCJmkbuFXSTGry7CTo7wvGpzverT4cwIw+3qY0RvetQem4nMGZIVJNRWn2T7AAD+
         cdFn40uq+lD/YjIr8bWqOyyilTs0XBal44H77UovkZopI8H3t1oeBVsozYSzQopa8d6R
         5ApVYdv26oUXsGNLtwqo/7OJm7thdYfkWEt1TpasVtYZprQ13vTzZ3nLhVLG0nCNSIhi
         M9ugsuE8PZec6G1yWe3pZqcazaIE+S5NNr4NprpVMNMgtCa224SiEPzdJLZcspsH3H7b
         i6QNmOvfPTlIxO3BRcUsky9ZHBXxG2sWWGepLtfBMoye/oqWM5BKR1aj3RfDvU/NzRHB
         Eoqg==
X-Gm-Message-State: AOAM532goBDqceaYKh/SMs2r6yTsJWu5zcPr3V7bLV+ZsKwYC7ZJWrBa
        dZiwy6TtmaduNb3FeyHU2kQyEA==
X-Google-Smtp-Source: ABdhPJwxploMckz9Ou9GObHKrr8g2ZfpK6OuIjmriImWrIGfGFFzqCuOY0nLaezjKdWv75Y18HAiWg==
X-Received: by 2002:a05:6a00:1749:b0:50a:8eed:b824 with SMTP id j9-20020a056a00174900b0050a8eedb824mr6002522pfc.50.1650647345159;
        Fri, 22 Apr 2022 10:09:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:e283:652b:fb2e:829f])
        by smtp.gmail.com with UTF8SMTPSA id gi21-20020a17090b111500b001d903861194sm496915pjb.30.2022.04.22.10.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:09:04 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v4] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Fri, 22 Apr 2022 10:08:53 -0700
Message-Id: <20220422100824.v4.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
some eMMC don't respond to SEND_STATUS commands very reliably if they're
still running at a low initial frequency. As mentioned in that commit,
JESD84-B51 P49 suggests a sequence in which the host:
1. sets HS_TIMING
2. bumps the clock ("<= 52 MHz")
3. sends further commands

It doesn't exactly require that we don't use a lower-than-52MHz
frequency, but in practice, these eMMC don't like it.

The aforementioned commit tried to get that right for HS400ES, although
it's unclear whether this ever truly worked as committed into mainline,
as other changes/refactoring adjusted the sequence in conflicting ways:

08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode
switch")

53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode
for mmc")

In any case, today we do step 3 before step 2. Let's fix that, and also
apply the same logic to HS200/400, where this eMMC has problems too.

Resolves errors like this seen when booting some RK3399 Gru/Scarlet
systems:

[    2.058881] mmc1: CQHCI version 5.10
[    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
[    2.209804] mmc1: mmc_select_hs400es failed, error -84
[    2.215597] mmc1: error -84 whilst initialising MMC card
[    2.417514] mmc1: mmc_select_hs400es failed, error -110
[    2.423373] mmc1: error -110 whilst initialising MMC card
[    2.605052] mmc1: mmc_select_hs400es failed, error -110
[    2.617944] mmc1: error -110 whilst initialising MMC card
[    2.835884] mmc1: mmc_select_hs400es failed, error -110
[    2.841751] mmc1: error -110 whilst initialising MMC card

Ealier versions of this patch bumped to 200MHz/HS200 speeds too early,
which caused issues on, e.g., qcom-msm8974-fairphone-fp2. (Thanks for
the report Luca!) After a second look, it appears that aligns with
JESD84 / page 45 / table 28, so we need to keep to lower (HS / 52 MHz)
rates first.

Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
Fixes: 4f25580fb84d ("mmc: core: changes frequency to hs_max_dtr when selecting hs400es")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Link: https://lore.kernel.org/linux-mmc/11962455.O9o76ZdvQC@g550jk/
Reported-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v4:
 * Revert to hs_max_dtr for HS200, due to issues reported by Luca Weiss
   <luca@z3ntu.xyz>; Luca, feel free to provide a "Tested-by: ..." reply
   if you'd like that included
 * Drop the "redundant clock rate" changes, as they aren't needed any
   more

Changes in v3:
 * Use mmc_set_bus_speed() to help choose the right clock rate
 * Avoid redundant clock rate changes
 * Restore clock rate on failed HS200 switch

Changes in v2:
 * Use ext_csd.hs200_max_dtr for HS200
 * Retest on top of 3b6c472822f8 ("mmc: core: Improve fallback to speed
   modes if eMMC HS200 fails")

 drivers/mmc/core/mmc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5d8d9f72476f..82ca62c8669c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1384,13 +1384,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
 		goto out_err;
 	}
 
+	/*
+	 * Bump to HS timing and frequency. Some cards don't handle
+	 * SEND_STATUS reliably at the initial frequency.
+	 */
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
+	mmc_set_bus_speed(card);
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
-	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
-
 	/* Switch card to DDR with strobe bit */
 	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1448,7 +1452,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
 static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	unsigned int old_timing, old_signal_voltage;
+	unsigned int old_timing, old_signal_voltage, old_clock;
 	int err = -EINVAL;
 	u8 val;
 
@@ -1479,8 +1483,17 @@ static int mmc_select_hs200(struct mmc_card *card)
 				   false, true, MMC_CMD_RETRIES);
 		if (err)
 			goto err;
+
+		/*
+		 * Bump to HS timing and frequency. Some cards don't handle
+		 * SEND_STATUS reliably at the initial frequency.
+		 * NB: We can't move to full (HS200) speeds until after we've
+		 * successfully switched over.
+		 */
 		old_timing = host->ios.timing;
+		old_clock = host->ios.clock;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
+		mmc_set_clock(card->host, card->ext_csd.hs_max_dtr);
 
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
@@ -1493,8 +1506,10 @@ static int mmc_select_hs200(struct mmc_card *card)
 		 * mmc_select_timing() assumes timing has not changed if
 		 * it is a switch error.
 		 */
-		if (err == -EBADMSG)
+		if (err == -EBADMSG) {
+			mmc_set_clock(host, old_clock);
 			mmc_set_timing(host, old_timing);
+		}
 	}
 err:
 	if (err) {
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

