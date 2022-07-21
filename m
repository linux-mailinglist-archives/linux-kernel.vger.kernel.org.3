Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B359F57C43B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiGUGMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiGUGMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219C7AB34;
        Wed, 20 Jul 2022 23:12:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id r24so895870plg.3;
        Wed, 20 Jul 2022 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pwyKcg194H4QO3VdCUZ/f9cmXrK4hIaWcesJcv68aM=;
        b=MrlMZr9GI2jwKVd1keTJceu9SVOCG/RKmLX/D7nIZVlR+o3ltwcLTG2Wep2pT1L46v
         KpdFZCiQs4mBgYemwI7TD46X0dr05pFyINJa4qy9uECHixk477NUnIg+49kuHKYbM95K
         J+pkfkC2LyRxdtgOwOWPumXEBhDiIcZL1cmWQ8S3MzBjcBDh3FJUkbVQdIM3kzs7r1sf
         xPeaIcCqGi2O7vfmpkK9stJCLw/bkcyGQ+JXcx1EKBWkAa18mjLgNMrtKceNVEEKVekD
         CGWiCyd0Q0wYRXKxfLFNC1cf7Y09Bif5qeSrCfe/eluG0Mta1vmRGFxhLQbv4rwR6ZMT
         BhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pwyKcg194H4QO3VdCUZ/f9cmXrK4hIaWcesJcv68aM=;
        b=zfW6IX7vXOKD2zwpJCQlNRA2ZHJ6J6RcZXUQSYqPzSFMoofO3Hsx53GnFMEBV0b6TL
         b0EEr8repgoC7ynhXnx/OVGGVKLcLSC/lCJBtGG4aQoDIME5r/jwyRhaB0o5zgQGExX8
         wOtYtPgeQURcj/9Z1IPnkfG5o0a4CYdNsAJbTUQVsvB/kZxnpyfpYxGHG4FXLuY7Dzl5
         IljbgZnUBkI5eXTRRks3gJE2DltXqRVF27mG0696ZJ6La9KFanG8Rvm3Aq8A7FSgMkv6
         EQVPgw3FF5P7ek/zsMMbTFJgb7bso49L2klQPWyU16+O6zjfCZE3rXMY3HRjCfW2xi+R
         WdpQ==
X-Gm-Message-State: AJIora+DOsKcoFj7HiQqbxpsKBq5Wl0I2JCrtMfGGW0f9a04PAqi8xIi
        086Tk/wQKCAdyD2hsnvVQMIaCDeDEQg=
X-Google-Smtp-Source: AGRyM1sVMzEvjBoulO9EZjW5+s+Wrx6ov32xfiZ9FJHhylrB35dhzLunOd7fGkdE0HVfDPFHblbDew==
X-Received: by 2002:a17:902:a38e:b0:16d:a30:8a4a with SMTP id x14-20020a170902a38e00b0016d0a308a4amr13060012pla.42.1658383922247;
        Wed, 20 Jul 2022 23:12:02 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:12:01 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 4/6] usb: typec: tcpci_rt1711h: Add initial phy setting
Date:   Thu, 21 Jul 2022 14:11:42 +0800
Message-Id: <20220721061144.35139-5-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
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
rx filter deglitech time and BMC-encoded wait time

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 52c9594e531d..e65b568959e9 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -18,6 +18,9 @@
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
 
+#define RT1711H_PHYCTRL1	0x80
+#define RT1711H_PHYCTRL2	0x81
+
 #define RT1711H_RTCTRL8		0x9B
 
 /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
@@ -105,8 +108,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 		return ret;
 
 	/* dcSRC.DRP : 33% */
-	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+	ret = rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
+	if (ret < 0)
+		return ret;
+
+	/* Enable phy discard retry, retry count 7, rx filter deglitech 100 us */
+	ret = rt1711h_write8(chip, RT1711H_PHYCTRL1, 0xF1);
+	if (ret < 0)
+		return ret;
 
+	/* Decrease wait time of BMC-encoded 1 bit from 2.67us to 2.55us */
+	/* wait time : (val * .4167) us */
+	return rt1711h_write8(chip, RT1711H_PHYCTRL2, 62);
 }
 
 static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
-- 
2.25.1

