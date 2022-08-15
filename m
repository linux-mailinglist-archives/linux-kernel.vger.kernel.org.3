Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F33592CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiHOK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiHOK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:28:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A1012763
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:27:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so6392551pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=synaptics-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=W2j7ewYbeLSNWuzIqc1xEbXaBADfpeLfAFAjW++lCBc=;
        b=rt5BEqabSkaU0iXYkJLA8lGerrAHA6AVow7bg0qafSvzb0p6ZTKl2lur09EVlGkjL7
         5LsxkTitp0bWSrAC4BxSg7DAMlRxOx0D9QiB9rgkbKrbxVaYCASFOFW62egbak2JeKeN
         B1DQnm9swm+2KGvI+uwf17js/ISRXn8+xZPJ/bn05WlMsVhUTjF7M/6JoViSr2BF4lJe
         47xBR2NxHOZBB2be8NlEUh2z7S/1ZtjNqOFZLQEw970Yydp67kwxVad7x4D0QMeG/TRM
         aWsW7yvekVdf3XMBuNoKzMZXqt+BNaomz0HKLtz/IKUUmCOM2ElszUwIly7oQ7t3QFC2
         QrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=W2j7ewYbeLSNWuzIqc1xEbXaBADfpeLfAFAjW++lCBc=;
        b=8OFvdgx0wkti+E1AQtZGi/Rkkrc6WfJCuNIINRwNv0asduK1xZnObvst5p9LxdJ4Pa
         +iuYkonukFqdY6/F4N4hqb0vBlHyArrZ00z+8s22hMi59av2LGtRWUtmjjoHn5GYar0d
         Xv+Xq2Nf+WY6lKklWx1qnWohwfpjoMAudo3ApYaexH2SNLM34EE3iGBJbjPaWZOFoU7D
         R4u2pvq2FVIlVjlju/PkwkE9h6JCgq4P8KHQkVKioEmpBk86XS6NcuJGQoY0TOqI/0fu
         Edjgh7hF5mTPDIH8uythWR2RYtpBwA/lRrBCg7+d4S61KTF+wE2IPJQsZSOQXCJi8GIh
         WFdA==
X-Gm-Message-State: ACgBeo1M+KheFXK4EqDKZy0H6qzE3JKARCFQFMB9ZRg7PJyzrkBt1E04
        ySdfKegClfREMRKZkrZLy9i0RQ==
X-Google-Smtp-Source: AA6agR43EBmCwP3kE2mjV/aHllieOgtOIpUmNuEAfW4XY18JNv1EKoXYZ3K7ydC/mU4cWAdAFEnOJA==
X-Received: by 2002:a17:902:ecc7:b0:16e:ff60:4286 with SMTP id a7-20020a170902ecc700b0016eff604286mr15607022plh.28.1660559278592;
        Mon, 15 Aug 2022 03:27:58 -0700 (PDT)
Received: from margeyang-ThinkPad-T440.synaptics-inc.local ([63.222.17.37])
        by smtp.gmail.com with ESMTPSA id im9-20020a170902bb0900b001725a63746dsm4504817plb.186.2022.08.15.03.27.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Aug 2022 03:27:58 -0700 (PDT)
From:   margeyang <marge.yang@synaptics.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        benjamin.tissoires@redhat.com
Cc:     marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com,
        Marge Yang <marge.yang@synaptics.corp-partner.google.com>
Subject: [PATCH V3] Input: synaptics-rmi4 - filter incomplete relative packet.
Date:   Mon, 15 Aug 2022 18:27:53 +0800
Message-Id: <1660559273-5387-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>

RMI4 F03 supports the Stick function,
it's designed to support relative packet.
This patch supports the following case.
When relative packet can't be reported completely,
it may miss one byte or two byte.
New Synaptics firmware will report PARITY error.
When timeout error or parity error happens,
RMI4 driver will sends 0xFE command and
ask FW to Re-send stick packet again.

Signed-off-by: Marge Yang<marge.yang@synaptics.corp-partner.google.com>
---
 drivers/input/rmi4/rmi_f03.c | 77 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index c194b1664b10..05076db83808 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -23,8 +23,12 @@
 #define RMI_F03_BYTES_PER_DEVICE_SHIFT	4
 #define RMI_F03_QUEUE_LENGTH		0x0F
 
+#define RMI_F03_RESET_STYK		0xFE
+
 #define PSMOUSE_OOB_EXTRA_BTNS		0x01
 
+#define RELATIVE_PACKET_SIZE		3
+
 struct f03_data {
 	struct rmi_function *fn;
 
@@ -33,6 +37,11 @@ struct f03_data {
 
 	unsigned int overwrite_buttons;
 
+	int iwritecommandcounter;
+	unsigned int ipacketindex;
+	unsigned int serio_flagsArry[RELATIVE_PACKET_SIZE];
+	u8 ob_dataArry[RELATIVE_PACKET_SIZE];
+
 	u8 device_count;
 	u8 rx_queue_length;
 };
@@ -88,6 +97,7 @@ static int rmi_f03_pt_write(struct serio *id, unsigned char val)
 		return error;
 	}
 
+	f03->iwritecommandcounter++;
 	return 0;
 }
 
@@ -107,6 +117,8 @@ static int rmi_f03_initialize(struct f03_data *f03)
 		return error;
 	}
 
+	f03->iwritecommandcounter = 0;
+	f03->ipacketindex = 0;
 	f03->device_count = query1 & RMI_F03_DEVICE_COUNT;
 	bytes_per_device = (query1 >> RMI_F03_BYTES_PER_DEVICE_SHIFT) &
 				RMI_F03_BYTES_PER_DEVICE;
@@ -284,6 +296,22 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
 		ob_data = obs[i + RMI_F03_OB_DATA_OFFSET];
 		serio_flags = 0;
 
+		if (ob_status & (RMI_F03_OB_FLAG_TIMEOUT | RMI_F03_OB_FLAG_PARITY)) {
+			//  Send resend command to stick when timeout or parity error.
+			//  Driver can receive the last stick packet.
+			unsigned char val = RMI_F03_RESET_STYK;
+
+			error = rmi_write(f03->fn->rmi_dev, f03->fn->fd.data_base_addr, val);
+			if (error) {
+				dev_err(&f03->fn->dev,
+					"%s: Failed to rmi_write to F03 TX register (%d).\n",
+					__func__, error);
+				return error;
+			}
+			f03->ipacketindex = 0;
+			break;
+		}
+
 		if (!(ob_status & RMI_F03_RX_DATA_OFB))
 			continue;
 
@@ -298,7 +326,54 @@ static irqreturn_t rmi_f03_attention(int irq, void *ctx)
 			serio_flags & SERIO_TIMEOUT ?  'Y' : 'N',
 			serio_flags & SERIO_PARITY ? 'Y' : 'N');
 
-		serio_interrupt(f03->serio, ob_data, serio_flags);
+		if (f03->iwritecommandcounter > 0) {
+			// Read Acknowledge Byte after writing the PS2 command.
+			// It is not trackpoint data.
+			serio_interrupt(f03->serio, ob_data, serio_flags);
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
+			if ((f03->ipacketindex == 0) && (ob_data & ((BIT(7)|BIT(6))))) {
+				dev_err(&f03->fn->dev,
+				"%s: X or Y is overflow. (%x)\n",
+				__func__, ob_data);
+				break;
+			} else if ((f03->ipacketindex == 0) && !(ob_data & BIT(3))) {
+				dev_err(&f03->fn->dev,
+				"%s: New BIT 3 is not 1 for the first byte\n",
+				__func__);
+				break;
+			}
+			if (f03->ipacketindex >= RELATIVE_PACKET_SIZE)
+				f03->ipacketindex = 0;
+
+			f03->ob_dataArry[f03->ipacketindex] = ob_data;
+			f03->serio_flagsArry[f03->ipacketindex] = serio_flags;
+			f03->ipacketindex++;
+
+			if (f03->ipacketindex == RELATIVE_PACKET_SIZE)	{
+				serio_interrupt(f03->serio, f03->ob_dataArry[0],
+				 f03->serio_flagsArry[0]);
+				serio_interrupt(f03->serio, f03->ob_dataArry[1],
+				 f03->serio_flagsArry[1]);
+				serio_interrupt(f03->serio, f03->ob_dataArry[2],
+				 f03->serio_flagsArry[2]);
+				f03->ipacketindex = 0;
+			}
+		}
+	}
+	if (f03->iwritecommandcounter > 0) {
+		f03->ipacketindex = 0;
+		f03->iwritecommandcounter = f03->iwritecommandcounter - 1;
 	}
 
 	return IRQ_HANDLED;
-- 
2.22.0.windows.1

