Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6450FB39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349383AbiDZKqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbiDZKpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:45:30 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE3CB;
        Tue, 26 Apr 2022 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650969357; x=1682505357;
  h=from:to:cc:subject:date:message-id;
  bh=QfEX8tV1drJ4rEHqLXyrW2XLgcYgtO2Wd5PQkGlBvRw=;
  b=iqy9t2LYLeM6ueGvEzJqSOGLeP+TUrbrll5G5geR4IOFsYc0K2pb3EQO
   7k+IPF4OS/ehtqiOrmjNNSRloXkQH3RKfP9lzE4A/thYccroCaLXpaLCS
   E0aL9G6eytQRr75JkgXOqGYjKyoKjGRLoHkcjUxfIaHIb3pNHBPCVe3Zp
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 26 Apr 2022 03:35:56 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 26 Apr 2022 03:35:55 -0700
X-QCInternal: smtphost
Received: from hu-c-spathi-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.108.59])
  by ironmsg01-blr.qualcomm.com with ESMTP; 26 Apr 2022 16:05:33 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 212714)
        id ECA273085; Tue, 26 Apr 2022 16:05:32 +0530 (+0530)
From:   Srinivasarao Pathipati <quic_spathi@quicinc.com>
To:     digetx@gmail.com, axboe@kernel.dk, quic_kamasali@quicinc.com,
        quic_nitirawa@quicinc.com, avri.altman@wdc.com,
        quic_spathi@quicinc.com, quic_merez@quicinc.com, s.shtylyov@omp.ru,
        quic_sayalil@quicinc.com, colyli@suse.de, cw9316.lee@samsung.com,
        dsterba@suse.com, joel@jms.id.au, quic_sbhanu@quicinc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ram Prakash Gupta <rampraka@codeaurora.org>,
        Nitin Rawat <nitirawa@codeaurora.org>
Subject: [PATCH V1] FROMLIST: mmc: core: Export core functions required for clk scaling
Date:   Tue, 26 Apr 2022 16:05:30 +0530
Message-Id: <1650969330-9711-1-git-send-email-quic_spathi@quicinc.com>
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

From: Ram Prakash Gupta <rampraka@codeaurora.org>

Export core function required for clk scaling post design change.
This would help make clk scaling part of vendor module.

Bug: 192337957
Link: https://lore.kernel.org/lkml/1571668177-3766-2-git-send-email-
rampraka@codeaurora.org/
Signed-off-by: Nitin Rawat <nitirawa@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>

Signed-off-by: kamasali <quic_kamasali@quicinc.com>
Signed-off-by: Srinivasarao Pathipati <quic_spathi@quicinc.com>
---
 drivers/mmc/core/core.c  |  3 +++
 drivers/mmc/core/core.h  |  2 +-
 drivers/mmc/core/mmc.c   | 20 +++++++++++++-------
 drivers/mmc/core/queue.c |  1 +
 include/linux/mmc/mmc.h  |  9 +++++++++
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8cc2b74..7fc77d1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -920,6 +920,7 @@ void mmc_set_clock(struct mmc_host *host, unsigned int hz)
 	host->ios.clock = hz;
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_clock);
 
 int mmc_execute_tuning(struct mmc_card *card)
 {
@@ -1003,6 +1004,7 @@ void mmc_set_initial_state(struct mmc_host *host)
 
 	mmc_crypto_set_initial_state(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_initial_state);
 
 /**
  * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
@@ -1266,6 +1268,7 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
 	host->ios.timing = timing;
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_timing);
 
 /*
  * Select appropriate driver type for host.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index f5f3f62..a086152 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -42,7 +42,7 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
 void mmc_init_erase(struct mmc_card *card);
 
 void mmc_set_chip_select(struct mmc_host *host, int mode);
-void mmc_set_clock(struct mmc_host *host, unsigned int hz);
+extern void mmc_set_clock(struct mmc_host *host, unsigned int hz);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b4bcebc..2a642fc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -975,7 +975,7 @@ static int mmc_select_powerclass(struct mmc_card *card)
 /*
  * Set the bus speed for the selected speed mode.
  */
-static void mmc_set_bus_speed(struct mmc_card *card)
+void mmc_set_bus_speed(struct mmc_card *card)
 {
 	unsigned int max_dtr = (unsigned int)-1;
 
@@ -995,7 +995,7 @@ static void mmc_set_bus_speed(struct mmc_card *card)
  * If the bus width is changed successfully, return the selected width value.
  * Zero is returned instead of error value if the wide width is not supported.
  */
-static int mmc_select_bus_width(struct mmc_card *card)
+int mmc_select_bus_width(struct mmc_card *card)
 {
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_8,
@@ -1060,11 +1060,12 @@ static int mmc_select_bus_width(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_bus_width);
 
 /*
  * Switch to the high-speed mode
  */
-static int mmc_select_hs(struct mmc_card *card)
+int mmc_select_hs(struct mmc_card *card)
 {
 	int err;
 
@@ -1078,11 +1079,12 @@ static int mmc_select_hs(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_hs);
 
 /*
  * Activate wide bus and DDR if supported.
  */
-static int mmc_select_hs_ddr(struct mmc_card *card)
+int mmc_select_hs_ddr(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	u32 bus_width, ext_csd_bits;
@@ -1151,8 +1153,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_hs_ddr);
 
-static int mmc_select_hs400(struct mmc_card *card)
+int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 	unsigned int max_dtr;
@@ -1246,6 +1249,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	       __func__, err);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mmc_select_hs400);
 
 int mmc_hs200_to_hs400(struct mmc_card *card)
 {
@@ -1524,7 +1528,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 /*
  * Activate High Speed, HS200 or HS400ES mode if supported.
  */
-static int mmc_select_timing(struct mmc_card *card)
+int mmc_select_timing(struct mmc_card *card)
 {
 	int err = 0;
 
@@ -1559,12 +1563,13 @@ static int mmc_select_timing(struct mmc_card *card)
 	mmc_set_bus_speed(card);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_select_timing);
 
 /*
  * Execute tuning sequence to seek the proper bus operating
  * conditions for HS200 and HS400, which sends CMD21 to the device.
  */
-static int mmc_hs200_tuning(struct mmc_card *card)
+int mmc_hs200_tuning(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
 
@@ -1579,6 +1584,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 
 	return mmc_execute_tuning(card);
 }
+EXPORT_SYMBOL_GPL(mmc_hs200_tuning);
 
 /*
  * Handle the detection and initialisation of a card.
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 7b07520..cb679a7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -68,6 +68,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
 
 	return MMC_ISSUE_SYNC;
 }
+EXPORT_SYMBOL_GPL(mmc_issue_type);
 
 static void __mmc_cqe_recovery_notifier(struct mmc_queue *mq)
 {
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6..2884634 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -449,4 +449,13 @@ static inline bool mmc_ready_for_data(u32 status)
 
 #define mmc_driver_type_mask(n)		(1 << (n))
 
+struct mmc_card;
+
+extern int mmc_select_bus_width(struct mmc_card *card);
+extern int mmc_select_hs(struct mmc_card *card);
+extern int mmc_select_hs_ddr(struct mmc_card *card);
+extern int mmc_select_hs400(struct mmc_card *card);
+extern int mmc_hs200_tuning(struct mmc_card *card);
+extern int mmc_select_timing(struct mmc_card *card);
+
 #endif /* LINUX_MMC_MMC_H */
-- 
2.7.4

