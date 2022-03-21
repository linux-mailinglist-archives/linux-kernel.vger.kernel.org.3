Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B334E257C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346870AbiCULwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346860AbiCULwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:36 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53E6542A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=XONJQws0G0Qd59
        eaonfUHwUQhTZBr7Wfsr5JDj17GTA=; b=G0t2rTisIsPREuGN/cwg4ekOnRu/mS
        oE+vDdrHFZw0E+QQuJ9plH5bfLEEVocYZwFYYy23ND4bQF6mbJYHSwd2BP7MhtXZ
        tneEVvEQsNkr3gBTPXAJrfVEuPR7TbTJMklyPP8jB+M4ZrHsECx1yqwA7MK6XPbV
        fvF6q+RTst8oc=
Received: (qmail 860209 invoked from network); 21 Mar 2022 12:51:06 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 12:51:06 +0100
X-UD-Smtp-Session: l3s3148p1@zJ2NHLnaAqcgAQnoAFxnAN8BywfgXJ9V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 01/10] mmc: core: improve API to make clear mmc_hw_reset is for cards
Date:   Mon, 21 Mar 2022 12:50:47 +0100
Message-Id: <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it unambiguous that mmc_hw_reset() is for cards and not for
controllers, we a) add 'card' to the function name and b) make the
function argument mmc_card instead of mmc_host. A fallback is provided
until all users are converted.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/block.c    |  2 +-
 drivers/mmc/core/core.c     | 18 +++++++++++++-----
 drivers/mmc/core/mmc_test.c |  3 +--
 include/linux/mmc/core.h    |  1 +
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4e67c1403cc9..74674a4650b0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -993,7 +993,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 		return -EEXIST;
 
 	md->reset_done |= type;
-	err = mmc_hw_reset(host);
+	err = mmc_card_hw_reset(host->card);
 	/* Ensure we switch back to the correct partition */
 	if (err) {
 		struct mmc_blk_data *main_md =
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 368f10405e13..71e75196bc53 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1984,7 +1984,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 }
 EXPORT_SYMBOL(mmc_set_blocklen);
 
-static void mmc_hw_reset_for_init(struct mmc_host *host)
+/* we can't use mmc_card as a parameter, it is not populated yet */
+static void mmc_card_hw_reset_for_init(struct mmc_host *host)
 {
 	mmc_pwrseq_reset(host);
 
@@ -1994,8 +1995,8 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 }
 
 /**
- * mmc_hw_reset - reset the card in hardware
- * @host: MMC host to which the card is attached
+ * mmc_card_hw_reset - reset the card in hardware
+ * @card: card to be reset
  *
  * Hard reset the card. This function is only for upper layers, like the
  * block layer or card drivers. You cannot use it in host drivers (struct
@@ -2003,8 +2004,9 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
  *
  * Return: 0 on success, -errno on failure
  */
-int mmc_hw_reset(struct mmc_host *host)
+int mmc_card_hw_reset(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	int ret;
 
 	ret = host->bus_ops->hw_reset(host);
@@ -2014,6 +2016,12 @@ int mmc_hw_reset(struct mmc_host *host)
 
 	return ret;
 }
+EXPORT_SYMBOL(mmc_card_hw_reset);
+
+int mmc_hw_reset(struct mmc_host *host)
+{
+	return mmc_card_hw_reset(host->card);
+}
 EXPORT_SYMBOL(mmc_hw_reset);
 
 int mmc_sw_reset(struct mmc_host *host)
@@ -2045,7 +2053,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 	 * Some eMMCs (with VCCQ always on) may not be reset after power up, so
 	 * do a hardware reset if possible.
 	 */
-	mmc_hw_reset_for_init(host);
+	mmc_card_hw_reset_for_init(host);
 
 	/*
 	 * sdio_reset sends CMD52 to reset card.  Since we do not know
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index e6a2fd2c6d5c..bfcae8f79cbd 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -2325,10 +2325,9 @@ static int mmc_test_profile_sglen_r_nonblock_perf(struct mmc_test_card *test)
 static int mmc_test_reset(struct mmc_test_card *test)
 {
 	struct mmc_card *card = test->card;
-	struct mmc_host *host = card->host;
 	int err;
 
-	err = mmc_hw_reset(host);
+	err = mmc_card_hw_reset(card);
 	if (!err) {
 		/*
 		 * Reset will re-enable the card's command queue, but tests
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 71101d1ec825..25a7cf69d919 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -176,6 +176,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
 int mmc_hw_reset(struct mmc_host *host);
+int mmc_card_hw_reset(struct mmc_card *card);
 int mmc_sw_reset(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
 
-- 
2.30.2

