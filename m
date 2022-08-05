Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2358A6E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbiHEHSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236316AbiHEHSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:18:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F06FA1C;
        Fri,  5 Aug 2022 00:18:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d20so1537131pfq.5;
        Fri, 05 Aug 2022 00:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmQvfTLfhSexD9Eu2cDWkazSz8+Yx4MBahcS3Xy6S+Q=;
        b=JAKhImu3eGgYN6HOXihH6/c/bb7lHbLwfwWYgYh2T2VvoDNj38ySz6uhHOsANgpOFW
         Lsy4TpYGhYt6fsf0YKfDri6YKemLuJHJi7JnrFvFI/9M/4T3v25ZZ549CvfKevXodLlp
         kv33BT1SjRym9itPtEpxvmm94mafo88v9Wg2jqBS9DQNy7AUDZ1vzkzXp8WqWaNpo5Ia
         Y7z83FcVY+EPsastjdJB4abRaD//aEHTOW6ieAJsZQm85C3EnpTgvYW5dOUk0qeX2Zan
         eFAiJFVjhica/8UnZpINZNMrLkUHBerjdIuIYJRlM3yxcJPY18V8CkmKD1uYNveWUMNj
         NKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmQvfTLfhSexD9Eu2cDWkazSz8+Yx4MBahcS3Xy6S+Q=;
        b=YZYvchpID3YPRriIeGXCA8xMxFyaHp54+tS68NWKUIrEViZLNhVeqvXI9HOkW/zNhd
         gu9V2S2AU5SGRg2Mwwelw1yYj3a3PAcUq+t2x6Z8Pzm9iKzba0YuYDyAypOV2mQd5xIs
         hjsiocoVxfX4O5Ck/jKFZ+oTG4QoTRbzGzUCDjrdxVJ31Zeb+4/yT8wqD2cyqMt/oDHZ
         7j+TDwigO7SLTmcsnwb5NSE9nNNnr3RhXLiBg6MOYSKJXVVNzAIO1bG/pXs4MSHOPPYD
         wzKyWDDrgXGKmtCDM/RSqboVluelPNVYgMo+azbPM+wBG5CeTxbiDZay1afn/e4pNQqj
         BwHw==
X-Gm-Message-State: ACgBeo32Sy0vKLPyeTQ8MmY6x3Bp7L9LaP4xoAHB33G/qQFIJXPz4FGS
        mBgEQABoaAfDf4D7Sw7DWCM=
X-Google-Smtp-Source: AA6agR7xYlDesKGSE+vAQqDfsv7sf27mKnxcGVl9UmTspDmudfGeeoDRnFGwmIJIBB3tY0+/wIs8+Q==
X-Received: by 2002:a05:6a00:b89:b0:52b:2bc7:68ab with SMTP id g9-20020a056a000b8900b0052b2bc768abmr5724112pfj.80.1659683879503;
        Fri, 05 Aug 2022 00:17:59 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:17:59 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 3/7] usb: typec: tcpci_rt1711h: Add regulator support when source vbus
Date:   Fri,  5 Aug 2022 15:17:09 +0800
Message-Id: <20220805071714.150882-4-gene.chen.richtek@gmail.com>
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

Add regulator support when source vbus

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index f2f1fb0..fb19d7b 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -14,6 +14,7 @@
 #include <linux/usb/tcpci.h>
 #include <linux/usb/tcpm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
@@ -41,6 +42,8 @@ struct rt1711h_chip {
 	struct tcpci_data data;
 	struct tcpci *tcpci;
 	struct device *dev;
+	struct regulator *vbus;
+	bool src_en;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -104,6 +107,26 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 
 	/* dcSRC.DRP : 33% */
 	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+
+}
+
+static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
+			    bool src, bool snk)
+{
+	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	int ret;
+
+	if (chip->src_en == src)
+		return 0;
+
+	if (src)
+		ret = regulator_enable(chip->vbus);
+	else
+		ret = regulator_disable(chip->vbus);
+
+	if (!ret)
+		chip->src_en = src;
+	return ret;
 }
 
 static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
@@ -247,7 +270,12 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	chip->vbus = devm_regulator_get(&client->dev, "vbus");
+	if (IS_ERR(chip->vbus))
+		return PTR_ERR(chip->vbus);
+
 	chip->data.init = rt1711h_init;
+	chip->data.set_vbus = rt1711h_set_vbus;
 	chip->data.set_vconn = rt1711h_set_vconn;
 	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
 	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
-- 
2.7.4

