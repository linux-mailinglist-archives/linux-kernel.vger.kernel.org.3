Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35850F924
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347744AbiDZJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348770AbiDZJti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:49:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445DD559B;
        Tue, 26 Apr 2022 02:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650963904; x=1682499904;
  h=from:to:cc:subject:date:message-id;
  bh=7KB1mY/ZPltwoWdk1EE4etbSQeuQjO4pGlCbzmCABGo=;
  b=maqaNwHpG7xQaStitqdRwa9+iuQrYe4J1g3zjXV/EnegLnqOzWlBPR53
   YLNqoFB3b3Fv8FhseJUqt3hATz76Zs5UzErZmS94Hlv6mo2EjpxrS2zjP
   1a2fqPGPzG+QySy4nvvELaJnR0AWeaZ57VHMYltlwqux39hxDHHvoy9S8
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 02:04:35 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2022 02:04:33 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Apr 2022 14:34:15 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id 2FC083AE1; Tue, 26 Apr 2022 14:34:14 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     ulf.hansson@linaro.org, avri.altman@wdc.com,
        linus.walleij@linaro.org, shawn.lin@rock-chips.com,
        merez@codeaurora.org, s.shtylyov@omp.ru, huijin.park@samsung.com,
        briannorris@chromium.org, digetx@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kamasali <quic_kamasali@quicinc.com>,
        Srinivasarao Pathipati <quic_spathi@quicinc.com>
Subject: [PATCH V1] mmc: core: Add partial initialization support
Date:   Tue, 26 Apr 2022 14:34:12 +0530
Message-Id: <1650963852-4173-1-git-send-email-quic_spathi@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maya Erez <merez@codeaurora.org>

This change adds the ability to partially initialize
the MMC card by using card Sleep/Awake sequence (CMD5).
Card will be sent to Sleep state during runtime/system suspend
and will be woken up during runtime/system resume.
By using this sequence the card doesn't need full initialization
which gives time reduction in system/runtime resume path.

Signed-off-by: Maya Erez <merez@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Signed-off-by: kamasali <quic_kamasali@quicinc.com>
Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 drivers/mmc/core/mmc.c   | 149 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/mmc/card.h |   4 ++
 include/linux/mmc/host.h |   2 +
 3 files changed, 146 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9ab915b..8691c00 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1942,7 +1942,14 @@ static int mmc_sleep_busy_cb(void *cb_data, bool *busy)
 	return 0;
 }
 
-static int mmc_sleep(struct mmc_host *host)
+static int mmc_can_sleepawake(struct mmc_host *host)
+{
+	return host && (host->caps2 & MMC_CAP2_SLEEP_AWAKE) && host->card &&
+		(host->card->ext_csd.rev >= 3);
+
+}
+
+static int mmc_sleepawake(struct mmc_host *host, bool sleep)
 {
 	struct mmc_command cmd = {};
 	struct mmc_card *card = host->card;
@@ -1953,14 +1960,17 @@ static int mmc_sleep(struct mmc_host *host)
 	/* Re-tuning can't be done once the card is deselected */
 	mmc_retune_hold(host);
 
-	err = mmc_deselect_cards(host);
-	if (err)
-		goto out_release;
+	if (sleep) {
+		err = mmc_deselect_cards(host);
+		if (err)
+			goto out_release;
+	}
 
 	cmd.opcode = MMC_SLEEP_AWAKE;
 	cmd.arg = card->rca << 16;
-	cmd.arg |= 1 << 15;
 	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
+	if (sleep)
+		cmd.arg |= 1 << 15;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
 	if (err)
@@ -1982,6 +1992,9 @@ static int mmc_sleep(struct mmc_host *host)
 
 	err = __mmc_poll_for_busy(host, 0, timeout_ms, &mmc_sleep_busy_cb, host);
 
+	if (!sleep)
+		err = mmc_select_card(card);
+
 out_release:
 	mmc_retune_release(host);
 	return err;
@@ -2080,6 +2093,66 @@ static int _mmc_flush_cache(struct mmc_host *host)
 			pr_err("%s: cache flush error %d\n",
 			       mmc_hostname(host), err);
 	}
+	return err;
+}
+
+static int mmc_cache_card_ext_csd(struct mmc_host *host)
+{
+	int err;
+	u8 *ext_csd;
+	struct mmc_card *card = host->card;
+
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err || !ext_csd) {
+		pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+	/* only cache read/write fields that the sw changes */
+	card->ext_csd.raw_ext_csd_cmdq = ext_csd[EXT_CSD_CMDQ_MODE_EN];
+	card->ext_csd.raw_ext_csd_cache_ctrl = ext_csd[EXT_CSD_CACHE_CTRL];
+	card->ext_csd.raw_ext_csd_bus_width = ext_csd[EXT_CSD_BUS_WIDTH];
+	card->ext_csd.raw_ext_csd_hs_timing = ext_csd[EXT_CSD_HS_TIMING];
+
+	kfree(ext_csd);
+
+	return 0;
+}
+
+static int mmc_test_awake_ext_csd(struct mmc_host *host)
+{
+	int err;
+	u8 *ext_csd;
+	struct mmc_card *card = host->card;
+
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err) {
+		pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
+			mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	/* only compare read/write fields that the sw changes */
+	pr_debug("%s: %s: type(cached:current) cmdq(%d:%d) cache_ctrl(%d:%d) bus_width (%d:%d) timing(%d:%d)\n",
+		mmc_hostname(host), __func__,
+		card->ext_csd.raw_ext_csd_cmdq,
+		ext_csd[EXT_CSD_CMDQ_MODE_EN],
+		card->ext_csd.raw_ext_csd_cache_ctrl,
+		ext_csd[EXT_CSD_CACHE_CTRL],
+		card->ext_csd.raw_ext_csd_bus_width,
+		ext_csd[EXT_CSD_BUS_WIDTH],
+		card->ext_csd.raw_ext_csd_hs_timing,
+		ext_csd[EXT_CSD_HS_TIMING]);
+	err = !((card->ext_csd.raw_ext_csd_cmdq ==
+			ext_csd[EXT_CSD_CMDQ_MODE_EN]) &&
+		(card->ext_csd.raw_ext_csd_cache_ctrl ==
+			ext_csd[EXT_CSD_CACHE_CTRL]) &&
+		(card->ext_csd.raw_ext_csd_bus_width ==
+			ext_csd[EXT_CSD_BUS_WIDTH]) &&
+		(card->ext_csd.raw_ext_csd_hs_timing ==
+			ext_csd[EXT_CSD_HS_TIMING]));
+
+	kfree(ext_csd);
 
 	return err;
 }
@@ -2103,8 +2176,12 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	    ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend ||
 	     (host->caps2 & MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND)))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
-		err = mmc_sleep(host);
+	if (mmc_can_sleepawake(host)) {
+		memcpy(&host->cached_ios, &host->ios, sizeof(host->cached_ios));
+		 mmc_cache_card_ext_csd(host);
+	}
+	if (mmc_can_sleep(host->card))
+		err = mmc_sleepawake(host, true);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 
@@ -2117,6 +2194,48 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	return err;
 }
 
+static int mmc_partial_init(struct mmc_host *host)
+{
+	int err = 0;
+	struct mmc_card *card = host->card;
+
+	mmc_set_bus_width(host, host->cached_ios.bus_width);
+	mmc_set_timing(host, host->cached_ios.timing);
+	if (host->cached_ios.enhanced_strobe) {
+		host->ios.enhanced_strobe = true;
+		if (host->ops->hs400_enhanced_strobe)
+			host->ops->hs400_enhanced_strobe(host, &host->ios);
+	}
+	mmc_set_clock(host, host->cached_ios.clock);
+	mmc_set_bus_mode(host, host->cached_ios.bus_mode);
+
+	if (!mmc_card_hs400es(card) &&
+			(mmc_card_hs200(card) || mmc_card_hs400(card))) {
+		err = mmc_execute_tuning(card);
+		if (err) {
+			pr_err("%s: %s: Tuning failed (%d)\n",
+				mmc_hostname(host), __func__, err);
+			goto out;
+		}
+	}
+	/*
+	 * The ext_csd is read to make sure the card did not went through
+	 * Power-failure during sleep period.
+	 * A subset of the W/E_P, W/C_P register will be tested. In case
+	 * these registers values are different from the values that were
+	 * cached during suspend, we will conclude that a Power-failure occurred
+	 * and will do full initialization sequence.
+	 */
+	err = mmc_test_awake_ext_csd(host);
+	if (err) {
+		pr_debug("%s: %s: fail on ext_csd read (%d)\n",
+			mmc_hostname(host), __func__, err);
+		goto out;
+	}
+out:
+	return err;
+}
+
 /*
  * Suspend callback
  */
@@ -2139,7 +2258,7 @@ static int mmc_suspend(struct mmc_host *host)
  */
 static int _mmc_resume(struct mmc_host *host)
 {
-	int err = 0;
+	int err = -EINVAL;
 
 	mmc_claim_host(host);
 
@@ -2147,7 +2266,19 @@ static int _mmc_resume(struct mmc_host *host)
 		goto out;
 
 	mmc_power_up(host, host->card->ocr);
-	err = mmc_init_card(host, host->card->ocr, host->card);
+
+	if (mmc_can_sleepawake(host)) {
+		err = mmc_sleepawake(host, false);
+		if (!err)
+			err = mmc_partial_init(host);
+		else
+			pr_err("%s: %s: awake failed (%d), fallback to full init\n",
+				mmc_hostname(host), __func__, err);
+	}
+
+	if (err)
+		err = mmc_init_card(host, host->card->ocr, host->card);
+
 	mmc_card_clr_suspended(host->card);
 
 out:
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 37f9758..ed7f6f7 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -86,6 +86,8 @@ struct mmc_ext_csd {
 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
 	unsigned int		boot_ro_lock;		/* ro lock support */
 	bool			boot_ro_lockable;
+	u8			raw_ext_csd_cmdq;	/* 15 */
+	u8			raw_ext_csd_cache_ctrl;	/* 33 */
 	bool			ffu_capable;	/* Firmware upgrade support */
 	bool			cmdq_en;	/* Command Queue enabled */
 	bool			cmdq_support;	/* Command Queue supported */
@@ -96,7 +98,9 @@ struct mmc_ext_csd {
 	u8			raw_partition_support;	/* 160 */
 	u8			raw_rpmb_size_mult;	/* 168 */
 	u8			raw_erased_mem_count;	/* 181 */
+	u8			raw_ext_csd_bus_width;	/* 183 */
 	u8			strobe_support;		/* 184 */
+	u8			raw_ext_csd_hs_timing;	/* 185 */
 	u8			raw_ext_csd_structure;	/* 194 */
 	u8			raw_card_type;		/* 196 */
 	u8			raw_driver_strength;	/* 197 */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c38072e..a9ddf7a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -422,6 +422,7 @@ struct mmc_host {
 #else
 #define MMC_CAP2_CRYPTO		0
 #endif
+#define MMC_CAP2_SLEEP_AWAKE	(1 << 29)	/* Use Sleep/Awake (CMD5) */
 #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
@@ -441,6 +442,7 @@ struct mmc_host {
 	spinlock_t		lock;		/* lock for claim and bus ops */
 
 	struct mmc_ios		ios;		/* current io bus settings */
+	struct mmc_ios		cached_ios;
 
 	/* group bitfields together to minimize padding */
 	unsigned int		use_spi_crc:1;
-- 
2.7.4

