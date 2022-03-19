Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7F4DE511
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 02:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbiCSBxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 21:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiCSBxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 21:53:50 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23242BA3DF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:52:29 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id kx13-20020a17090b228d00b001c6715c9847so7398109pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2GCQYtNCvHneKPvqBxPgh7d4klDBlXKREmCz25G780=;
        b=So2FKFlBbMD2uXtFKZMbtzcFA7RW/QQvMo7auHkc61XysLXkTxezMyrEYFonuuNa/s
         K+iAOpT4cx+d4e4ligVQ9HTFGJ67kY8kUQaSPnOUFx4kSWVpFMO611LA7oB5jLihETNx
         24JVPyKKIy/TnmXWkSJ+0yjs0GQ8No0A3QA4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2GCQYtNCvHneKPvqBxPgh7d4klDBlXKREmCz25G780=;
        b=Yh1NvdpipnYImsteL4TFohrprk05e3s2A2N7XxQFCSux2+phAu4zhc7kjfLYETWtuK
         JVYl14+Xac3dSXP6lj8Z7msa0AEDYFKS4WgqvkYepf/g9+J7K5e/+dHVGjy+jgXd930p
         wdPer9Y6BOgklYyWN2d5ronj3rEPVb38YYrBZFHrBnt0Vu3VDiAPR8FiJ5Bfn2+5ESi0
         pKL8nP1tRI4Fd5Ave5GYNrF1xMHaevTCEtNOniaJOKQGSB4AnG22OYExALMoudhkGYmf
         vzE6s9rAeLbgCKaey/pHZdOi1vTY9tber1UC8Ica7otsihbLoSDKoRks1hchW202r4vZ
         pIpA==
X-Gm-Message-State: AOAM530Vta4its15HMF6cPWYEvXkGjv+J2x0NPBOno/ooyFhwjtcyG02
        HqOdWUDQggg3gi6vWv8UNdlB6w==
X-Google-Smtp-Source: ABdhPJydSlMDaH/0+OWuuH5oo0/PLeGUj3t9jjA3cCV/2EPN1v2GkZ/tWrwr4jUvProJ1Ai6yjCiQw==
X-Received: by 2002:a17:903:41c7:b0:154:25bf:7d20 with SMTP id u7-20020a17090341c700b0015425bf7d20mr2270392ple.113.1647654749482;
        Fri, 18 Mar 2022 18:52:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:bd64:9503:150c:fb20])
        by smtp.gmail.com with UTF8SMTPSA id y34-20020a056a00182200b004f71c56a7e8sm10734724pfa.213.2022.03.18.18.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 18:52:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] mmc: core: Set HS clock speed before sending HS CMD13
Date:   Fri, 18 Mar 2022 18:52:22 -0700
Message-Id: <20220318185139.v2.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
Fixes: 4f25580fb84d ("mmc: core: changes frequency to hs_max_dtr when selecting hs400es")
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Use ext_csd.hs200_max_dtr for HS200
 * Retest on top of 3b6c472822f8 ("mmc: core: Improve fallback to speed
   modes if eMMC HS200 fails")

 drivers/mmc/core/mmc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e7ea45386c22..b75fa4b67964 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1385,12 +1385,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	}
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
+
+	/*
+	 * Bump to HS frequency. Some cards don't handle SEND_STATUS reliably
+	 * at the initial frequency.
+	 */
+	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
+
 	err = mmc_switch_status(card, true);
 	if (err)
 		goto out_err;
 
-	mmc_set_clock(host, card->ext_csd.hs_max_dtr);
-
 	/* Switch card to DDR with strobe bit */
 	val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1482,6 +1487,12 @@ static int mmc_select_hs200(struct mmc_card *card)
 		old_timing = host->ios.timing;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
+		/*
+		 * Bump to HS200 frequency. Some cards don't handle SEND_STATUS
+		 * reliably at the initial frequency.
+		 */
+		mmc_set_clock(host, card->ext_csd.hs200_max_dtr);
+
 		/*
 		 * For HS200, CRC errors are not a reliable way to know the
 		 * switch failed. If there really is a problem, we would expect
-- 
2.35.1.894.gb6a874cedc-goog

