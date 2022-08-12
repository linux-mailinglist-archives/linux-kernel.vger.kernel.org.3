Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628C590D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiHLIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiHLIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:44:31 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F457A8CDA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:44:28 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id MQG1oHcRkr8wyMQGNoLawX; Fri, 12 Aug 2022 10:43:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660293807; bh=zTsu9YvjjwpwF7zSkRalIemgq9HBKFWhACD/LncT3zM=;
        h=From:To:Subject:Date:MIME-Version;
        b=CGndxdDczVlyGFXDgQaNxvhP9AD1SU3PD6jvWOEXIgyaURr9g5gljDBjv33MYJL04
         diIex1ISS7ZZdZM1v4BnwvCn0N45muG4XlD8DBDIvHQyM3B2t1We8hYMFct89Qje7V
         27ELT4Yr856mX0j8h4Dx47zc5Ge5daYmk8Qj9ctpcR762wgzsOcHY1aMZ1SFmJnChJ
         4iqfDvH3UNjKARhj7ZxfqHxhbQrXTTNIAFhJ22OP9mcsvXSddDShlLwmr7o9e3Jq4o
         tNKfLxVCEkHa3GHEuJJnXlq83syGoIgjVtTrLOuyhIfy8EoX7zkoqmY80ddmtJg9LP
         5J6oPeIcyp1IQ==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v3 2/3] ads7846: always set last command to PWRDOWN
Date:   Fri, 12 Aug 2022 10:42:47 +0200
Message-Id: <20220812084248.9270-3-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812084248.9270-1-l.ellero@asem.it>
References: <20220812084248.9270-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIjPLdLp0rMab/osJp5kJNC0XwiH54YatJ+DoN1ji7KN2sRRTjVi9ClcIM7g6gLaDzeKkRJ0i9e+H1aabXAkgCxOTYe2Y7MW44Mg071wRAs2DpMB3VaA
 FL2HIsgYeODftPLVK9XV6pNvJq1P+oVEZW3Cv5W4xs/N53t5R3hKxj8wcyhWI7TRjH6SGHm4vLHppNF+AaBEBBAvH3V5voty6cF+iJAzu23uuPvMfO6tmaH1
 0gaaYgOwbEjhdA6y8S/qQ7VwEmIWWQP88CvdOdVg0GgNa5TYWBmwYnAg2olnmT5sJakrW2BzKFIsR0isrAANWpj8icg4rr8cKeessp1oNNr+a5gtUkBWML3h
 udkLF1Tuw7KIZmZdOfIknIHFIL+FZ1qdrc7qHw0wnDwRqApPrjbAp885QA1EhK6zfcUdxqx2+YPYgbuEubtBpHuHGLkx1fhfaue1UN7a23JRgJChL9MWw0X4
 uH7+E0jcOyL+ngwH/LD4xTXm/pBlTiGlzHuOkU4K++OhBxwiLeqNd0ZqSC9tsvq9yCozHNDjr49cOBq4TjV+yt5ANNYBJPZ9JOO0MyU9ilEs1qxmNjUYdXo+
 //X7MIfwFm42TuM+Q7ubleg3
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controllers that report pressure (e.g. ADS7846) use 5 commands and the
correct sequence is READ_X, READ_Y, READ_Z1, READ_Z2, PWRDOWN.

Controllers that don't report pressure (e.g. ADS7845/ADS7843) use only 3
commands and the correct sequence should be READ_X, READ_Y, PWRDOWN. But
the sequence sent was incorrect: READ_X, READ_Y, READ_Z1.

This patch fixes it.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
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

