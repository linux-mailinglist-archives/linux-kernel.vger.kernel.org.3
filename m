Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC105515127
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379326AbiD2QyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378896AbiD2QyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:54:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24421D64CA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x18so11588669wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vYT8fSjJDS96ejvL4hWH6OGbqvNo7Bl75pPdJ8Clt8Q=;
        b=X1PPNDQKAG13Y3seC/DVsjwFByyQB7u1UHAUbk5/FTjrwIoP1zNGI4z3qlUypkLfaU
         qTBWLZUDMpgXLfpDd/Yw/xGYOJTjLEFUKF02xhRouYewSy9P2V3+qWQ4XuWS8lGQsiVU
         wdlJIYpMfGaVGmxJ2qnWUKcmsCyPJF7S0ejDhGHcAlNGPtqmX72f8imGj3EqKmRQiLgW
         l7xQ0UquRMUrXGc1+1OLiTEsaG5tLcD9M9Jn/yMgPz2DEAGZ/WCfu++1tsYkMxiCgorX
         P7Qi93v84Idr13gj+W6zKMBIXa3VY5ZLwkx81o/MHBQwhU+KY5RbMpPmiCh3mnZEiN9X
         9yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vYT8fSjJDS96ejvL4hWH6OGbqvNo7Bl75pPdJ8Clt8Q=;
        b=h7Gtjl8e62VEyAPKZeWb0t1Vmtl8peEnReq4/Pa3VQzL5X4pcEyiqBMOyYMGGqjUtR
         jS7giuqlqhgn2k8Nyu3//70PKAB3lZG/WRo8M6Wep6dI+Jq6QRXxsVOb4R4iqQevo0/7
         +5jsvZ4dslRM1OqiMjBlGw930Lyom1PGPHE+EyHyjo3owh/eNByvB4PYfJLfRcwMNHMv
         5Nw0LRTEEXuGubALrMCyq3DF5h6qy2uFRADybQgCXGbW903kUd0lYhnP6tjTxmkwX8WE
         +cYVpE0nMNwSGdg+GfNxG2nF/KxfKHFFewZeW9T8NhiVESOCGgPeJgR2jsOPGcp48aq2
         asUw==
X-Gm-Message-State: AOAM531ZKmh5mXELWUAaOjuQjiUpCVD0J2kUmAR3oFU3N2KVDamXe9dJ
        IXeetfh1xtlshFrx4sA2/xQE+g==
X-Google-Smtp-Source: ABdhPJz3pqxYJ5tRD8WGESzkY5/aW838FxKil4yNzZaIMEz86KyXJEhnEGNWmPDurK9rfUrT7Yr/6g==
X-Received: by 2002:a5d:6d50:0:b0:207:c10e:911 with SMTP id k16-20020a5d6d50000000b00207c10e0911mr15640wri.137.1651251056768;
        Fri, 29 Apr 2022 09:50:56 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id a16-20020a056000051000b00207b5d9f51fsm2848941wrf.41.2022.04.29.09.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:50:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the interrupt
Date:   Fri, 29 Apr 2022 17:50:50 +0100
Message-Id: <20220429165051.6187-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
References: <20220429165051.6187-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-By: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7040293c2ee8..0f29a08b4c09 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1526,13 +1526,11 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->base))
 		return PTR_ERR(ctrl->base);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "no slimbus IRQ resource\n");
-		return -ENODEV;
-	}
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
 
-	ret = devm_request_irq(dev, res->start, qcom_slim_ngd_interrupt,
+	ret = devm_request_irq(dev, ret, qcom_slim_ngd_interrupt,
 			       IRQF_TRIGGER_HIGH, "slim-ngd", ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "request IRQ failed\n");
-- 
2.21.0

