Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ED258A6ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240460AbiHEHSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiHEHSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:18:16 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F2C74CE2;
        Fri,  5 Aug 2022 00:18:04 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so1930241pls.4;
        Fri, 05 Aug 2022 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ujg4hDDvyV4s7RmKQP40QabcGXdYDiqK7t+igL1GTqc=;
        b=J3uEOywwe0pFzy3VX05gPSwfkeohBApGj2UdiQkUW9SGez1S9KotXjqMCQtGSLBhXo
         jwzkcQ7oJmNrp3dqjR5niQyO9fPtcza7xUhgCa1sGHGpcVheG2HSIZ73/8rz7AmuHALA
         AdghWgzxDSBfC4/zwuh8w4MRRj4b1w6MvMsFCBP2DlUKIThYJmJN7Mw/9hStAoOH2Nai
         kMin8TIIfYQvxyPIvfQbEZoXP+wAoDqCuYsbk0DV5Kd/BeaBZ5fjtR7r3R1Yd72kKBPL
         QQJp1TfcJHKwktlYvwS9k2TJ5kkFJ80KSM8wWe15QyazCaxn8F4z6cbIeOKcx9fT1/nF
         T/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ujg4hDDvyV4s7RmKQP40QabcGXdYDiqK7t+igL1GTqc=;
        b=5jvltgAmzNySci7ETG5m9gLn9E/t6Fzvs5Quclk5UHgq+H6bGOTOMGxETGG6WLJpDm
         5j6DZgXp9Eo8AVEWIgnWorAC75hTbs55ktO9vkomZQKERe3yvHT6OIwpA4bSvKPX4AsZ
         XEsK1WZrXN74FscqIHoATg5gBoUYH4x5c3xh+lqlMGDfkZNEw38CdoeBPOomiGuUWL/A
         sFvQsibxPlKOnNnrvJRPrFy1LXgz9av/WqnSCBVaI+n3y3Rcd3P8cJeSoexmmcBQjRUt
         xb0S8RsFstfrP1HGXCJYIebToNLZYfqqEssIBRyvK/eNV92QZJ6qed1KE2EI9KpSGvlw
         X6eQ==
X-Gm-Message-State: ACgBeo3HH9DNz/jvg5R9e/MDgDw8H3t967B0kPqTMpyb7C/2YPv8iCmN
        DPQvCvl+v0kIQK00mdM+W74=
X-Google-Smtp-Source: AA6agR4R+Q+n5hbfkkc52HAhugGr23JgYwh+VNGWFJkq11ngBHDKLfijymiEX+8FlpqtN8yEN8PxhQ==
X-Received: by 2002:a17:90b:b13:b0:1f3:7ab:35b2 with SMTP id bf19-20020a17090b0b1300b001f307ab35b2mr14738615pjb.118.1659683883698;
        Fri, 05 Aug 2022 00:18:03 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:18:03 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 4/7] usb: typec: tcpci_rt1711h: Add initial phy setting
Date:   Fri,  5 Aug 2022 15:17:10 +0800
Message-Id: <20220805071714.150882-5-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add initial phy setting about phy dicard retry,
rx filter deglitch time and BMC-encoded wait time

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index fb19d7b..5c51d04 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -19,6 +19,9 @@
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
 
+#define RT1711H_PHYCTRL1	0x80
+#define RT1711H_PHYCTRL2	0x81
+
 #define RT1711H_RTCTRL8		0x9B
 
 /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
@@ -106,8 +109,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 		return ret;
 
 	/* dcSRC.DRP : 33% */
-	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+	if (ret < 0)
+		return ret;
+
+	/* Enable phy discard retry, retry count 7, rx filter deglitch 100 us */
+	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
+	if (ret < 0)
+		return ret;
 
+	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
+	/* wait time : (val * .4167) us */
+	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
 }
 
 static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
-- 
2.7.4

