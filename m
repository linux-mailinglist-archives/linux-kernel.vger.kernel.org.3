Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB74E25A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346935AbiCULxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346931AbiCULwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:50 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250F15A21C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=xWPaZrnm9z27Va
        /XtIjY8NA3lcLy58v4RnWPMq+zt4U=; b=RsJ7rkJKhSPu2AqcPTthRCoW/h9xbw
        /5Sk3LmIuYLtSgiwxLaHm5fgS3LtqmGnLKkUUjz296SlzmzzQYr/VgbA4UxMoNmC
        rGf20OVbsuSd0SDDpDKHdKEkwYMUfaN6I9CvDudJwCynssYgUwAJa6pw8HY6DvyJ
        1t/mCspig/a90=
Received: (qmail 860435 invoked from network); 21 Mar 2022 12:51:10 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 12:51:10 +0100
X-UD-Smtp-Session: l3s3148p1@U77HHLnaDqcgAQnoAFxnAN8BywfgXJ9V
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 07/10] mmc: core: improve API to make clear that mmc_sw_reset is for cards
Date:   Mon, 21 Mar 2022 12:50:53 +0100
Message-Id: <20220321115059.21803-8-wsa+renesas@sang-engineering.com>
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

To make it unambiguous that mmc_sw_reset() is for cards and not for
controllers, we a) add 'card' to the function name and b) make the
function argument mmc_card instead of mmc_host. There is no fallback
because there are currently no users.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c  | 5 +++--
 include/linux/mmc/core.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7a2985dde0e6..3498b341acaf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2018,8 +2018,9 @@ int mmc_card_hw_reset(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_card_hw_reset);
 
-int mmc_sw_reset(struct mmc_host *host)
+int mmc_card_sw_reset(struct mmc_card *card)
 {
+	struct mmc_host *host = card->host;
 	int ret;
 
 	if (!host->bus_ops->sw_reset)
@@ -2032,7 +2033,7 @@ int mmc_sw_reset(struct mmc_host *host)
 
 	return ret;
 }
-EXPORT_SYMBOL(mmc_sw_reset);
+EXPORT_SYMBOL(mmc_card_sw_reset);
 
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 7759502c8c67..c2616b61c191 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -176,7 +176,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
 int mmc_card_hw_reset(struct mmc_card *card);
-int mmc_sw_reset(struct mmc_host *host);
+int mmc_card_sw_reset(struct mmc_card *card);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
2.30.2

