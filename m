Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D547586561
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiHAGsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiHAGro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:47:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F7B63E3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:47:17 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h28so3400896pfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UockhMzW1MKAwp8ZPFnrYbu87PaXsC6GeLfvEKDP3s8=;
        b=vbHnDb2Py1FWhiTAR+HmRBbaKgVwqP5YPOTlVGXOOAgRryXqb4GZKOtg/pKParMpRe
         LPHUioLQCkXsss0eTx8kvuOIbYNKbZxY244k/0Q+eQTnDP39nhF8QaV+2rhYTVOH6tqL
         oGL69kNa7/OwFlJLBP3ZFqFFRGXtvSLHEsPVr+nig71mCcaYe7s+69R0JJjVrMEV4PRu
         mNI2LrnJLaRGHXY0e32WU0GIVOzEKwAQBG596hUCTBPwz9oizuxjv6MAvdAVtP/UVJVU
         V0qqYcNDzE6Z1anegdrQbSTKGp4JJ+CgaJAw3qp8FuMc8go4EG/s+h+zKTdb+f+Yn2kt
         J45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UockhMzW1MKAwp8ZPFnrYbu87PaXsC6GeLfvEKDP3s8=;
        b=nSsF9PiiCtn9h9WNd3PonQsDd18++UECsIWn2ZGl5h1s0OXR198QBeL8UyhGNdFkEm
         9AnsLvPTNXjJOYyvWc6lbq5jrEDMNWMt8O5xsf0plb9V58qmjDxMf4qB19HkULo/yX9x
         V4lotvjz1pbmBmxU7Rc9+fuvX+gA8LKQbjSgG74f9N8LeAfgTY+e9BXf4ggmigoTBSVW
         xnAZF5Jl59LET9lQbbs1kF/YLrl8Ksr80vOxxnwY8+0mfZJQwpmN501bvSyTXPYxV7P1
         c0cC0mFvAh18hsosK9v7eoG+0Mkj0sM5bmXJXvElGhS1e90Fn6iu9hQKHYlxd37pCyAu
         SUaw==
X-Gm-Message-State: ACgBeo3J0oRVK9eWQ/pHr6meWXel2lSAqA89D1C77rke+E/ltmQ0vvQX
        5jABOZLSK0292XtWjNI89qtscQ==
X-Google-Smtp-Source: AGRyM1teMxs7nXdi0Y0OlAxCIQ0k2o6fXAR9xhbrozkRGKrFRQXyYDvsnIByKbmXFxDFxwBALpRmxw==
X-Received: by 2002:a62:3346:0:b0:52a:c0cb:ae8 with SMTP id z67-20020a623346000000b0052ac0cb0ae8mr14830623pfz.37.1659336436976;
        Sun, 31 Jul 2022 23:47:16 -0700 (PDT)
Received: from localhost.localdomain ([63.222.17.38])
        by smtp.gmail.com with ESMTPSA id h6-20020a17090a130600b001f4d711e165sm4249841pja.11.2022.07.31.23.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jul 2022 23:47:16 -0700 (PDT)
From:   margeyang <marge.yang@synaptics.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     marge.yang@tw.synaptics.com, derek.chegn@tw.synaptcs.com,
        vincent.huang@tw.synaptics.com,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: [PATCH] Input: synaptics-rmi4 - add support for F03
Date:   Mon,  1 Aug 2022 14:47:05 +0800
Message-Id: <1659336425-2614-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>

RMI4 F03 supports the Stick function,
it's designed to support relative packet.
This patch adds to support complete relative packet.
When timeout error or parity error happens,
sends 0xFE command to ask Re-send stick packet again.
Supports some conditions to filter wrong relative packet.

Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
---
 drivers/input/rmi4/rmi_f03.c | 82 ++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index c194b1664b10..57f03dfcb4ff 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -23,8 +23,12 @@
 #define RMI_F03_BYTES_PER_DEVICE_SHIFT	4
 #define RMI_F03_QUEUE_LENGTH		0x0F
 
+#define RMI_F03_RESET_STYK 0xFE
+
 #define PSMOUSE_OOB_EXTRA_BTNS		0x01
 
+#define RELATIVE_PACKET_SIZE		0x03
+
 struct f03_data {
 	struct rmi_function *fn;
 
@@ -36,7 +40,8 @@ struct f03_data {
 	u8 device_count;
 	u8 rx_queue_length;
 };
-
+int iwritecommandcounter;
+unsigned int ipacketindex;
 int rmi_f03_overwrite_button(struct rmi_function *fn, unsigned int button,
 			     int value)
 {
@@ -87,7 +92,7 @@ static int rmi_f03_pt_write(struct serio *id, unsigned char val)
 			__func__, error);
 		return error;
 	}
-
+	iwritecommandcounter++;
 	return 0;
 }
 
@@ -197,10 +202,12 @@ static int rmi_f03_register_pt(struct f03_data *f03)
 
 static int rmi_f03_probe(struct rmi_function *fn)
 {
+
 	struct device *dev = &fn->dev;
 	struct f03_data *f03;
 	int error;
-
+	iwritecommandcounter = 0;
+	ipacketindex = 0;
 	f03 = devm_kzalloc(dev, sizeof(struct f03_data), GFP_KERNEL);
 	if (!f03)
 		return -ENOMEM;
@@ -251,9 +258,12 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
 	const u8 ob_len = f03->rx_queue_length * RMI_F03_OB_SIZE;
 	u8 obs[RMI_F03_QUEUE_LENGTH * RMI_F03_OB_SIZE];
 	u8 ob_status;
+	static u8 ob_dataArry[RELATIVE_PACKET_SIZE];
 	u8 ob_data;
 	unsigned int serio_flags;
+	static unsigned int serio_flagsArry[RELATIVE_PACKET_SIZE];
 	int i;
+
 	int error;
 
 	if (drvdata->attn_data.data) {
@@ -284,6 +294,22 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
 		ob_data = obs[i + RMI_F03_OB_DATA_OFFSET];
 		serio_flags = 0;
 
+		if (ob_status & (RMI_F03_OB_FLAG_TIMEOUT | RMI_F03_OB_FLAG_PARITY)) {
+			//  Send resend command to stick when timeout or parity error.
+			//  Driver can receive the last stick packet.
+
+			error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr,
+			 RMI_F03_RESET_STYK);
+			if (error) {
+				dev_err(&f03->fn->dev,
+					"%s: Failed to rmi_write to F03 TX register (%d).\n",
+					__func__, error);
+				return error;
+			}
+			ipacketindex = 0;
+			break;
+		}
+
 		if (!(ob_status & RMI_F03_RX_DATA_OFB))
 			continue;
 
@@ -298,9 +324,57 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
 			serio_flags & SERIO_TIMEOUT ?  'Y' : 'N',
 			serio_flags & SERIO_PARITY ? 'Y' : 'N');
 
-		serio_interrupt(f03->serio, ob_data, serio_flags);
+		if (iwritecommandcounter > 0) {
+			// Read Acknowledge Byte after writing the PS2 command.
+			// It is not trackpoint data.
+			serio_interrupt(f03->serio, ob_data, serio_flags);
+
+		} else {
+			//   The relative-mode PS/2 packet format is as follows:
+			//
+			//              bit position            position (as array of bytes)
+			//     7   6   5   4   3   2   1   0
+			//   =================================+
+			//    Yov Xov DY8 DX8  1   M   R   L  | DATA[0]
+			//                DX[7:0]             | DATA[1]
+			//                DY[7:0]             | DATA[2]
+			//   =================================+
+			//		Yov: Y overflow
+			//    Xov: X overflow
+			if ((ipacketindex == 0) && (ob_data & ((BIT(7)|BIT(6))))) {
+				dev_err(&f03->fn->dev,
+				"%s: X or Y is overflow. (%x)\n",
+				__func__, ob_data);
+				break;
+			} else if ((ipacketindex == 0) && !(ob_data & BIT(3))) {
+				dev_err(&f03->fn->dev,
+				"%s: New BIT 3 is not 1 for the first byte\n",
+				__func__);
+			} else {
+				if (ipacketindex >= RELATIVE_PACKET_SIZE) {
+					ipacketindex = 0;
+				} else {
+					ob_dataArry[ipacketindex] = ob_data;
+					serio_flagsArry[ipacketindex] = serio_flags;
+					ipacketindex++;
+				}
+				if (ipacketindex == RELATIVE_PACKET_SIZE)	{
+					serio_interrupt(f03->serio, ob_dataArry[0],
+					 serio_flagsArry[0]);
+					serio_interrupt(f03->serio, ob_dataArry[1],
+					 serio_flagsArry[1]);
+					serio_interrupt(f03->serio, ob_dataArry[2],
+					 serio_flagsArry[2]);
+					ipacketindex = 0;
+				}
+			}
+		}
 	}
 
+	if (iwritecommandcounter > 0) {
+		ipacketindex = 0;
+		iwritecommandcounter = iwritecommandcounter - 1;
+	}
 	return IRQ_HANDLED;
 }
 
-- 
2.22.0.windows.1

