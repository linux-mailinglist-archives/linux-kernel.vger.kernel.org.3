Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F71586769
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiHAK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiHAK1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:32 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D942419C38;
        Mon,  1 Aug 2022 03:27:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t22so2381905pjy.1;
        Mon, 01 Aug 2022 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5YVwMbfoYCofIWCorsteoCV1pt7aCEVid0X5JBcygY=;
        b=Y+lx3Dwm1gkBmrkas25JUF15WSaRBt8UhZa+Nr5YzrMDbiK2+wZekQHXeATtlzKzLB
         aorpp0O/x0i8UVqAxvGqWOU+pAu+KQ5HDGznBxfO5m1LySNfz35MKzKZ6YHoieMufzHy
         01BVxdB+aCzyThk7qP/T/i/UrNW13V4tDfxjnqDELSQ4Jqn+G3TCZmz9EuQiblIPaXzj
         TvfLBMXqpAExhomORPvXnY7ZMTTBHvu6ceNZlcmC/XVunjrk8MpMxfQJ5IqvHEyUsRdx
         YEowOvuNCaud13azGongKR4A4eyO9ZT29flerZtCV95fGmMfQ8mebQ2CLYaiRa+faPpW
         fQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5YVwMbfoYCofIWCorsteoCV1pt7aCEVid0X5JBcygY=;
        b=dyUPsSQqa4emVeeiQVOdGj3gYNIOzFGqCWpC/8tYU/32kIJm9+vjG/5feL+zKr6+Qi
         DjjSul4BZnyR6CkgMJJNHbb1TldXaq0GA7cHaJykSskgcETCHhom+wr1hqzcU8Bd5fD2
         E2zNCSks31N3RrppC3PXwX7RQENKgk8CmKSMftK8gSDpZMPLxSECuk5fWwHYBoHne42k
         Vcq1rHgPcFvV2Hx+XQZDQy5CCC7H351jaxYP4qQRbSsSCe+68+NR9591XNLrkRTSW/pX
         U6g5Qho3k22+lQI3W5YFQ/qM0yychPD6DTW0G0ZNnkT0uAG4tXxugJLGeRBx6qNtu+/W
         7aPw==
X-Gm-Message-State: ACgBeo18NVsaVuAKuJnxpt/jPZfRjrGvQ646Wb49ubLbvHtAFw//V09J
        KUF/GvKeA2p9yu5/v+dVTcU=
X-Google-Smtp-Source: AA6agR413BUb0F1GXJaukYg7s1OSc3wndvXfdZS6iFk+Odl1NEbVqGLO2xjgdowqCkhojUSxx+LnDA==
X-Received: by 2002:a17:90b:3947:b0:1f5:104:f8cd with SMTP id oe7-20020a17090b394700b001f50104f8cdmr4270191pjb.26.1659349645692;
        Mon, 01 Aug 2022 03:27:25 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:25 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 4/7] usb: typec: tcpci_rt1711h: Add initial phy setting
Date:   Mon,  1 Aug 2022 18:14:44 +0800
Message-Id: <20220801101447.86207-5-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index df7bfe299987..33d8ea95b7c1 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -20,6 +20,9 @@
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
 
+#define RT1711H_PHYCTRL1	0x80
+#define RT1711H_PHYCTRL2	0x81
+
 #define RT1711H_RTCTRL8		0x9B
 
 /* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
@@ -107,8 +110,18 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
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

