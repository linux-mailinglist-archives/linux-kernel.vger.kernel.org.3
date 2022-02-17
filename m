Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42CA4BA93B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiBQTHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:07:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbiBQTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:06:59 -0500
X-Greylist: delayed 6358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 11:06:43 PST
Received: from msr9.hinet.net (msr9.hinet.net [168.95.4.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8632B254
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:06:43 -0800 (PST)
Received: from laptop.lan (111-253-217-22.dynamic-ip.hinet.net [111.253.217.22])
        by msr9.hinet.net (8.15.2/8.15.2) with ESMTP id 21HG6WIc096094;
        Fri, 18 Feb 2022 00:06:32 +0800
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>, Lin@protonmail.com
Subject: [PATCH] input: stmfts: #define STMFTS_RETRY_COUNT 3
Date:   Fri, 18 Feb 2022 01:06:24 +0900
Message-Id: <20220217160624.20936-1-linmengbo0689@protonmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=Xvg/hXJ9 c=1 sm=1 tr=0 ts=620e728a
        a=QmhVwYW7bC54/XG34QDJIg==:117 a=QmhVwYW7bC54/XG34QDJIg==:17
        a=sfOm8-O8AAAA:8 a=fnsQhsnqeVFlupmvOtAA:9 a=TvTJqdcANYtsRzA46cdi:22
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        SPOOFED_FREEMAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add #define STMFTS_RETRY_COUNT 3 to retry stmfts_command() 3 times.
Without it, STMFTS_SYSTEM_RESET or STMFTS_SLEEP_OUT may return -110 to
failed attempt due to no event received for completion.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 drivers/input/touchscreen/stmfts.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index bc11203c9cf7..d36be85a980e 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -68,6 +68,7 @@
 #define STMFTS_DATA_MAX_SIZE	(STMFTS_EVENT_SIZE * STMFTS_STACK_DEPTH)
 #define STMFTS_MAX_FINGERS	10
 #define STMFTS_DEV_NAME		"stmfts"
+#define STMFTS_RETRY_COUNT	3
 
 enum stmfts_regulators {
 	STMFTS_REGULATOR_VDD,
@@ -317,19 +318,20 @@ static irqreturn_t stmfts_irq_handler(int irq, void *dev)
 
 static int stmfts_command(struct stmfts_data *sdata, const u8 cmd)
 {
-	int err;
+	int err, retry;
 
 	reinit_completion(&sdata->cmd_done);
 
-	err = i2c_smbus_write_byte(sdata->client, cmd);
-	if (err)
-		return err;
-
-	if (!wait_for_completion_timeout(&sdata->cmd_done,
-					 msecs_to_jiffies(1000)))
-		return -ETIMEDOUT;
+	for (retry = 0; retry < STMFTS_RETRY_COUNT; retry++) {
+		err = i2c_smbus_write_byte(sdata->client, cmd);
+		if (err)
+			return err;
 
-	return 0;
+		if (wait_for_completion_timeout(&sdata->cmd_done,
+						msecs_to_jiffies(1000)))
+			return 0;
+	}
+	return -ETIMEDOUT;
 }
 
 static int stmfts_input_open(struct input_dev *dev)
-- 
2.30.2

