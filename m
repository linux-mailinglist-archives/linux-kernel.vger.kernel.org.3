Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650E74D929E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344464AbiCOCc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbiCOCcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:32:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A0473A2;
        Mon, 14 Mar 2022 19:31:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u2so144150ple.10;
        Mon, 14 Mar 2022 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9uu0BO1cWnfVavnPfeDvFpIkMrKn9I+vsSKrB80KBw=;
        b=GwrHexRnr5Gy00IPEs/Ce7Z+A6W9SgCGiYDhEOEnSXTBfNgc4/BHZ0hQwbUOEjC4ym
         iets8BBZK6uCGK1UdOJGVaX/cNHwpjRtf+tzX8duo1czsI1DeRKRMNDPni5tRbx8fiFB
         W42totbs9fxhb9fNVPJSEuRE5JueJokWf8IHdcCUReVOHZujr0jeqjW/poYoFhzudeHF
         oJX+1vHW20g+8J1XMAWrGEZvE+50z2m1hKc9Xss0ivzLkVsOo8K2bVqkDThLjokg6AqU
         LgKPnXhKK89yZKsMZwf7VfLIaH+waGNxV4NHEzrbSP/H1l1tndc+Bn5ovjLWVf3S8S6n
         PvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9uu0BO1cWnfVavnPfeDvFpIkMrKn9I+vsSKrB80KBw=;
        b=iGrgwA4aSjFw6Sv/iq6hnaokv6BYh1zY9hGmnxFMeYr/g9S1POwO5/dd6xq58JAbJz
         vhN0jTQOw5JBxnMMCr0tUsaK0s7ivyaYmi5QzYYeLnTJ0d43HM2ovld7DS+HFyFb5dEA
         bbq5Lt2vamLM9jYEt7l3yht96aRhRYV9YuP6VqivJKAj8rTvXu58LUE1MNhvpLtA/p1w
         RobQTbF2LE65/nsoEtFcg7VR0mt0QIuAyEsf/ZwQYgHR1K0un1zQj8kpkpo2YxEtzbn7
         GRDQ69Pu8kudbPtVz7r9OTFEuFD+9r1avyBFb2OHIO69cmbsB6JAfJYvmgGv+uUe0HIo
         64gw==
X-Gm-Message-State: AOAM5313WbkVO1eCWu8KSqUbcdts+ZFD1ilUfrUhgyA5pNoRSXkDS+1d
        ybyqO2uF7ed+jCs8d/uxAdY=
X-Google-Smtp-Source: ABdhPJwJhmMkGE1cQxSbgTcYRqc8CCIDKRr3vabntZMSxoaZPN8Fp4YyuenBhmhUlZBPnOoMPNePww==
X-Received: by 2002:a17:903:11cf:b0:153:4723:61de with SMTP id q15-20020a17090311cf00b00153472361demr14222481plh.50.1647311473161;
        Mon, 14 Mar 2022 19:31:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t7-20020a17090a510700b001bf5f79a770sm851576pjh.15.2022.03.14.19.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:31:12 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, fabian@ritter-vogt.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fotg210-udc: Use platform_get_irq() to get the interrupt
Date:   Tue, 15 Mar 2022 02:31:08 +0000
Message-Id: <20220315023108.2118232-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
for requesting IRQ's resources any more, as they can be not ready yet in
case of DT-booting.

platform_get_irq() instead is a recommended way for getting IRQ even if
it was not retrieved earlier.

It also makes code simpler because we're getting "int" value right away
and no conversion from resource to int is required.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/gadget/udc/fotg210-udc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index fdca28e72a3b..f8501ed4886a 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -1087,11 +1087,12 @@ static int fotg210_udc_remove(struct platform_device *pdev)
 
 static int fotg210_udc_probe(struct platform_device *pdev)
 {
-	struct resource *res, *ires;
+	struct resource *res;
 	struct fotg210_udc *fotg210 = NULL;
 	struct fotg210_ep *_ep[FOTG210_MAX_NUM_EP];
 	int ret = 0;
 	int i;
+	int irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1099,11 +1100,9 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ires = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!ires) {
-		pr_err("platform_get_resource IORESOURCE_IRQ error.\n");
-		return -ENODEV;
-	}
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	ret = -ENOMEM;
 
@@ -1176,7 +1175,7 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 
 	fotg210_disable_unplug(fotg210);
 
-	ret = request_irq(ires->start, fotg210_irq, IRQF_SHARED,
+	ret = request_irq(irq, fotg210_irq, IRQF_SHARED,
 			  udc_name, fotg210);
 	if (ret < 0) {
 		pr_err("request_irq error (%d)\n", ret);
@@ -1192,7 +1191,7 @@ static int fotg210_udc_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_udc:
-	free_irq(ires->start, fotg210);
+	free_irq(irq, fotg210);
 
 err_req:
 	fotg210_ep_free_request(&fotg210->ep[0]->ep, fotg210->ep0_req);
-- 
2.25.1

