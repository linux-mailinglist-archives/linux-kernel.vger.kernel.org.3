Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D0857C66E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiGUIg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiGUIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:36:18 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBB112C66D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:36:17 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ERe9oJVIEtk1HEReNojXui; Thu, 21 Jul 2022 10:35:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1658392517; bh=oXXlmEclM46t4RqiuezLEhwkrU0aTDxl/RW2gMphcr8=;
        h=From:To:Subject:Date:MIME-Version;
        b=AvkcOWOWDD2SZ70cqTpzw4J1vkOtzHSY69J7jMG/ZcCtHU2Qa5gi7EiUO8v1ms+I4
         UUGLcIshsjCapYYeTtNLyG4ZMR1mr87gETYlDc7ziEgyTai1tB/1GWkcdapa/itslb
         j9SDnh+6KJiJM2s+Sgj7UWRwWfqFV8JeAIjlFXrZ/Wtlh1OwfVbDvlf+cyvQafRWBb
         Y07hWyhqSzX1HkqAb6rtXOehk7UkUKwJihOrQZFL2xsaPNRVVjELl1qssuTrwXBuv2
         FbypfNIlaxPI+MzxTXuPem/GY9Dl7DtJTtPj7gapSdU6PO4gR/ndyjzR7+SHpgnPdi
         mndMVkWWlKivw==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v2 2/3] ads7846: always set last command to PWRDOWN
Date:   Thu, 21 Jul 2022 10:34:57 +0200
Message-Id: <20220721083458.6412-3-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIl+SynEE+I3wFjmDDjGBOacdtbrBOC5L4m2I/bpYsYtF9lh7yNqSkKqgiT+h+fFwu3S74nT8eGzQ7LX9QsGBkPoDyZzxFS9sTxdDxEmtwm88Ea1mlJm
 c1LMcRVYwJ7jgDUZ1p99qeBp2N8lMjlqxhuHbHF/DnRON+uSB5S37gT4Qja/FFeBXT2pUowVYS+wjDaK9CGMNQOkV25bbk0VxyTjmaNEwP2xWkCyvZXbbkMu
 m3s4FxZ9D3oxUNv0RFOoeVWr5BEBUJuxR+gTnM3hcyHjdV0JiwLx/J/3BRYETR/Ldidz4VZijhDw98pZzWu/cg6wnFPDkByWXkKTf4to65RZsR6hfzk2EBGD
 AH8zPrF5Qz4yG0TqhB8mTqaHxLjljjQ5/WScTTOBFH1loxJ7IhZGD+n+CWorMRXU2rzyZsksIvNs/YblQKWDEeBghoX9F7rpkJg49OI2m9Cv2dIqebb7wRm1
 NlUMorI3yS8ghEt8W+o9ja16VOEu0hNmi1WiNYfRTNDjO/P1vvmkSLuQR6GW7F8Fe/q9Km39pFjjYr/SrZf8bL3QFYFSV63Sko/m6q+SFieXu2a7AV1vRetn
 124=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ellero <l.ellero@asem.it>

Controllers that report pressure (e.g. ADS7846) use 5 commands and the
correct sequence is READ_X, READ_Y, READ_Z1, READ_Z2, PWRDOWN.

Controllers that don't report pressure (e.g. ADS7845/ADS7843) use only 3
commands and the correct sequence should be READ_X, READ_Y, PWRDOWN. But
the sequence sent was incorrect: READ_X, READ_Y, READ_Z1.

This patch fixes it.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
Changes for v2:
 - elaborate commit message

 drivers/input/touchscreen/ads7846.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 24605c40d039..9e15cdf6faa0 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1066,6 +1066,9 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
 		unsigned int max_count;
 
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
 		if (ads7846_cmd_need_settle(cmd_idx))
 			max_count = packet->count + packet->count_skip;
 		else
@@ -1102,7 +1105,12 @@ static int ads7846_setup_spi_msg(struct ads7846 *ts,
 
 	for (cmd_idx = 0; cmd_idx < packet->cmds; cmd_idx++) {
 		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
-		u8 cmd = ads7846_get_cmd(cmd_idx, vref);
+		u8 cmd;
+
+		if (cmd_idx == packet->cmds - 1)
+			cmd_idx = ADS7846_PWDOWN;
+
+		cmd = ads7846_get_cmd(cmd_idx, vref);
 
 		for (b = 0; b < l->count; b++)
 			packet->tx[l->offset + b].cmd = cmd;
-- 
2.25.1

