Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2488E4CCFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiCDIYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiCDIYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:24:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB9E188A39
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:23:43 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 094943F043
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646382222;
        bh=ZiYRxpOW7H2aZXVGftBTBKxNVAmOlSnEmG+mhO4BaDY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NwAAcEmuSDzo7Nv6REGPbQgtWeW745+OtrP48TsAt3KT0uamFeO0eX/5cpc6yQnH1
         0M4cc8fp+C9f+M0mPkYYhmRnmFCzSCUrc/QEd4Oq5WTjKI4vdcfhBo2kjs8hUpFnvJ
         YVfwtWJxtoV4ovMW902EW1ZocWhkA2hog/pZplpLdrKUFZvAnE358ufSv4GFxwrB1Q
         +yFnAe1g+WXy8wOxk5LHiJt5Ce47sShqXbFM41zVKd57iRFdE3Cs+gNrHDrGwIxG1d
         s2pzaLkupSs4G/p82mvN/ATYElYUy5BVsUI/YlvYN8iXr16wN5nmVaamEciAn3wf6W
         zCy3Ng1kfEOqw==
Received: by mail-ed1-f72.google.com with SMTP id h17-20020a05640250d100b004133863d836so4254813edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:23:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZiYRxpOW7H2aZXVGftBTBKxNVAmOlSnEmG+mhO4BaDY=;
        b=u5HIsYudHRUwTBg4r18aNXIEKRopR5PM+kKujkgtWHpcspa9vDLok8m7EB81PpaGBq
         ER3CaHIDUBlIpgaUXFL3OLr+8sV9aYf+a44wkgkl9kEw9CkubLXUHPran7+cDuAh15Gs
         OqladYLG8sieTkK1BjlvY7S53n14eY6IZQcjQul4EqxWFLSW1DZFlNvkftVK6j8z7WO6
         R3eliXSeKYUMeK8//icvq/KP/0AAfoLqtkYbbxo5rtppqecIOZx2VqkKMYCbaX6XhN90
         dyGUva5PzYAWpOUuwoNJjxd7p7oV7j0ks9hPmM3cH2q5T2aLCIzH2kdAn+qDO/8uRSc3
         woew==
X-Gm-Message-State: AOAM530Jg6OoMvIy7KUSAFtyDHlYRoOuJcOP+1d5xIOWcsjQ02E1DCP7
        PwVGwyLAI9W7j71/IEzNRZC7KT06E0w12D20rCPSGW+AWX1hdmMoJ+2/zDdrwVG4LxED34KXpK4
        L0U1FfIn9qGp83nyvQtqI4AAjcT2OGJTg/XOVTGia4w==
X-Received: by 2002:a05:6402:1747:b0:415:ee04:47e1 with SMTP id v7-20020a056402174700b00415ee0447e1mr4319835edx.229.1646382221559;
        Fri, 04 Mar 2022 00:23:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymNu+F3GhI0EoxAO1JnqYf8iYX7ONBqok5BdmaWvsgdXQ/lTtlN2VBlZGOa8cXV9X27tyBAA==
X-Received: by 2002:a05:6402:1747:b0:415:ee04:47e1 with SMTP id v7-20020a056402174700b00415ee0447e1mr4319821edx.229.1646382221393;
        Fri, 04 Mar 2022 00:23:41 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id g2-20020aa7c842000000b0041314b98872sm1786256edt.22.2022.03.04.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:23:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] memory: emif: remove unneeded ENOMEM error messages
Date:   Fri,  4 Mar 2022 09:23:39 +0100
Message-Id: <20220304082339.230938-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory subsystem already prints message about failed memory
allocation, there is no need to do it in the drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/emif.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 762d0c0f0716..c7ebdabcc7f2 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1025,10 +1025,8 @@ static struct emif_data *__init_or_module get_device_details(
 	temp	= devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	dev_info = devm_kzalloc(dev, sizeof(*dev_info), GFP_KERNEL);
 
-	if (!emif || !pd || !dev_info) {
-		dev_err(dev, "%s:%d: allocation error\n", __func__, __LINE__);
+	if (!emif || !pd || !dev_info)
 		goto error;
-	}
 
 	memcpy(temp, pd, sizeof(*pd));
 	pd = temp;
@@ -1067,9 +1065,6 @@ static struct emif_data *__init_or_module get_device_details(
 		temp = devm_kzalloc(dev, sizeof(*cust_cfgs), GFP_KERNEL);
 		if (temp)
 			memcpy(temp, cust_cfgs, sizeof(*cust_cfgs));
-		else
-			dev_warn(dev, "%s:%d: allocation error\n", __func__,
-				__LINE__);
 		pd->custom_configs = temp;
 	}
 
@@ -1084,8 +1079,6 @@ static struct emif_data *__init_or_module get_device_details(
 			memcpy(temp, pd->timings, size);
 			pd->timings = temp;
 		} else {
-			dev_warn(dev, "%s:%d: allocation error\n", __func__,
-				__LINE__);
 			get_default_timings(emif);
 		}
 	} else {
@@ -1098,8 +1091,6 @@ static struct emif_data *__init_or_module get_device_details(
 			memcpy(temp, pd->min_tck, sizeof(*pd->min_tck));
 			pd->min_tck = temp;
 		} else {
-			dev_warn(dev, "%s:%d: allocation error\n", __func__,
-				__LINE__);
 			pd->min_tck = &lpddr2_jedec_min_tck;
 		}
 	} else {
-- 
2.32.0

