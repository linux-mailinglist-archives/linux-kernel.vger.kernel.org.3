Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF44E259F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244396AbiCULxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346965AbiCULww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:52 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5B315B05B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=k2S5I6Iv385ASD
        dHgH6U1H/WEVCqefhmjYtrjjjQKg4=; b=sNpb5cWGveFIaKOfuGIP4pi08hDAtm
        E8nvrHHNabLwIA9zl6t9aD1IQJ7nStBIjG4R4yBOg+QHKvbeKZm12SpUfdo6As1b
        hii3yaaQAHXE6Zt8Xm/DNSgaPuflVz6qK+p+cbaMOe3nryFqBZfO4BF7zDvba/xn
        aOnaQu1xp2SpQ=
Received: (qmail 860460 invoked from network); 21 Mar 2022 12:51:11 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 12:51:11 +0100
X-UD-Smtp-Session: l3s3148p1@Bt/YHLnaEKcgAQnoAFxnAN8BywfgXJ9V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 08/10] mmc: core: improve API to make clear hw_reset from bus_ops is for cards
Date:   Mon, 21 Mar 2022 12:50:54 +0100
Message-Id: <20220321115059.21803-9-wsa+renesas@sang-engineering.com>
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

To make it unambiguous that bus_ops->hw_reset() is for cards and not for
controllers, we a) add 'card' to the function name and b) make the
function argument mmc_card instead of mmc_host. All users are converted,
too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 4 ++--
 drivers/mmc/core/core.h | 2 +-
 drivers/mmc/core/mmc.c  | 6 +++---
 drivers/mmc/core/sd.c   | 8 ++++----
 drivers/mmc/core/sdio.c | 6 +++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3498b341acaf..1d874b064202 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -969,7 +969,7 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
 }
 
 /*
- * Set initial state after a power cycle or a hw_reset.
+ * Set initial state after a power cycle or a card_hw_reset.
  */
 void mmc_set_initial_state(struct mmc_host *host)
 {
@@ -2009,7 +2009,7 @@ int mmc_card_hw_reset(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	int ret;
 
-	ret = host->bus_ops->hw_reset(host);
+	ret = host->bus_ops->card_hw_reset(card);
 	if (ret < 0)
 		pr_warn("%s: tried to HW reset card, got error %d\n",
 			mmc_hostname(host), ret);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index f5f3f623ea49..c54270a6d457 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -27,7 +27,7 @@ struct mmc_bus_ops {
 	int (*runtime_resume)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
 	int (*shutdown)(struct mmc_host *);
-	int (*hw_reset)(struct mmc_host *);
+	int (*card_hw_reset)(struct mmc_card *);
 	int (*sw_reset)(struct mmc_host *);
 	bool (*cache_enabled)(struct mmc_host *);
 	int (*flush_cache)(struct mmc_host *);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e7ea45386c22..1857f398298b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2215,9 +2215,9 @@ static int mmc_can_reset(struct mmc_card *card)
 	return 1;
 }
 
-static int _mmc_hw_reset(struct mmc_host *host)
+static int _mmc_card_hw_reset(struct mmc_card *card)
 {
-	struct mmc_card *card = host->card;
+	struct mmc_host *host = card->host;
 
 	/*
 	 * In the case of recovery, we can't expect flushing the cache to work
@@ -2249,7 +2249,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.runtime_resume = mmc_runtime_resume,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
-	.hw_reset = _mmc_hw_reset,
+	.card_hw_reset = _mmc_card_hw_reset,
 	.cache_enabled = _mmc_cache_enabled,
 	.flush_cache = _mmc_flush_cache,
 };
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 68df6b2f49cc..c4a08ee8cdcc 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1784,10 +1784,10 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
-static int mmc_sd_hw_reset(struct mmc_host *host)
+static int mmc_sd_card_hw_reset(struct mmc_card *card)
 {
-	mmc_power_cycle(host, host->card->ocr);
-	return mmc_sd_init_card(host, host->card->ocr, host->card);
+	mmc_power_cycle(card->host, card->ocr);
+	return mmc_sd_init_card(card->host, card->ocr, card);
 }
 
 static const struct mmc_bus_ops mmc_sd_ops = {
@@ -1799,7 +1799,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.resume = mmc_sd_resume,
 	.alive = mmc_sd_alive,
 	.shutdown = mmc_sd_suspend,
-	.hw_reset = mmc_sd_hw_reset,
+	.card_hw_reset = mmc_sd_card_hw_reset,
 	.cache_enabled = sd_cache_enabled,
 	.flush_cache = sd_flush_cache,
 };
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 25799accf8a0..30242faf703e 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1128,9 +1128,9 @@ static int mmc_sdio_runtime_resume(struct mmc_host *host)
  * Returns 0 if the HW reset was executed synchronously, returns 1 if the HW
  * reset was asynchronously scheduled, else a negative error code.
  */
-static int mmc_sdio_hw_reset(struct mmc_host *host)
+static int mmc_sdio_card_hw_reset(struct mmc_card *card)
 {
-	struct mmc_card *card = host->card;
+	struct mmc_host *host = card->host;
 
 	/*
 	 * In case the card is shared among multiple func drivers, reset the
@@ -1175,7 +1175,7 @@ static const struct mmc_bus_ops mmc_sdio_ops = {
 	.runtime_suspend = mmc_sdio_runtime_suspend,
 	.runtime_resume = mmc_sdio_runtime_resume,
 	.alive = mmc_sdio_alive,
-	.hw_reset = mmc_sdio_hw_reset,
+	.card_hw_reset = mmc_sdio_card_hw_reset,
 	.sw_reset = mmc_sdio_sw_reset,
 };
 
-- 
2.30.2

