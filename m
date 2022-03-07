Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD254CFD0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiCGLfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiCGLfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:35:39 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78407193D5;
        Mon,  7 Mar 2022 03:34:45 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g1so13505161pfv.1;
        Mon, 07 Mar 2022 03:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=o2TUOqL7Gj4mlejca+dXKhqX+S5Wl6c+nk3MzcmnOGU=;
        b=UKARoSukGsSQA8t8WZtHWUTlKTCrxkNh5fCDeTQ6DDqzOk+Bt0BCvIzdh8g0siSdH3
         0jVoyD/2BcWpvUeyduyX0TmdrIlsGxOCXLNboiGcXybpBl0hDDy1/S0xEL/bOQ6jDbRD
         UtDR07ypIbHutUZg3amRq38Rx/wRrQWiGx0SHbzKKV381/7xR4oU58tlF3fn3vFowwmY
         /5My+QqLOnTx/R54m7bPzpZAsL3Ezco0GajmD7ZMTnwyS2fHDu1ScDYjpaWoTuBNmR1o
         r0KcZ207pO1lpoxKreNxna/CQ7SUmOLdoFkVAOw+QEhpozDKz1yOQl0gH8Z6vOVm2JOk
         qZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o2TUOqL7Gj4mlejca+dXKhqX+S5Wl6c+nk3MzcmnOGU=;
        b=Q6RP08Y+X5U/6NP4fw6Gut+6DJwPfpkHck7bRztwWCJe/F+swxqHLg3FcGiudbYDnP
         +dwJEcrDvRzABU8pNHXJLAsj81N7V4iWLTzy1Wq6gnFH0m6pduRJHTj52nHElfF6KzRa
         tkWL+SdYl4cQHJZyqVezYARuoa3/xl6YEs9UuG5/uYAQv12GBPspEF71psNYALg8CMp0
         C/JnGucg4QULbAOdh5RfJbM6QXNqdG57+a+b7qAnq7ZGXXPZzRnMNTX/lKLQ+hvJ0C6V
         n7hZDOJ8cACwdCSbyuITp1gXMSGj3nWDwxJk87T/bEA6QAx96G7T9hW99XSAMunUCQPr
         jYQQ==
X-Gm-Message-State: AOAM530DD1WwhzV87jxp7JLLIhD8fdTs+E6d0DPdb3Xy6b564MG+GkyF
        1Z6x61Y9lMS97OvAGEgQvnBQmmW2GOiyxOPqYFsMbg==
X-Google-Smtp-Source: ABdhPJwRHD21H7N+UUvk56LAoC2esABvsT2VtSSXPkhLlpf/fO3yhYxj12yO58zjYMhjnjOHdr8NYw==
X-Received: by 2002:a65:5bce:0:b0:372:cada:865d with SMTP id o14-20020a655bce000000b00372cada865dmr9263748pgr.199.1646652885036;
        Mon, 07 Mar 2022 03:34:45 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id q12-20020a17090a178c00b001bd036e11fdsm18522965pja.42.2022.03.07.03.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 03:34:44 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Henry Yen <henry.yen@mediatek.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] thermal: mediatek: Fix some leaks in mtk_thermal_probe
Date:   Mon,  7 Mar 2022 11:34:38 +0000
Message-Id: <20220307113438.21338-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful 'of_iomap()' call, it must be undone
by a corresponding 'iounmap()' call

Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/thermal/mtk_thermal.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..9d7461a5c2c1 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -1035,13 +1035,15 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	if (auxadc_phys_base == OF_BAD_ADDR) {
 		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_umap_auxadc;
 	}
 
 	apmixedsys = of_parse_phandle(np, "mediatek,apmixedsys", 0);
 	if (!apmixedsys) {
 		dev_err(&pdev->dev, "missing apmixedsys node\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_umap_auxadc;
 	}
 
 	apmixed_base = of_iomap(apmixedsys, 0);
@@ -1051,17 +1053,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	if (apmixed_phys_base == OF_BAD_ADDR) {
 		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto  err_umap_apmixed;
 	}
 
 	ret = device_reset_optional(&pdev->dev);
 	if (ret)
-		return ret;
+		goto err_umap_apmixed;
 
 	ret = clk_prepare_enable(mt->clk_auxadc);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
-		return ret;
+		goto err_umap_apmixed;
 	}
 
 	ret = clk_prepare_enable(mt->clk_peri_therm);
@@ -1099,6 +1102,10 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	clk_disable_unprepare(mt->clk_peri_therm);
 err_disable_clk_auxadc:
 	clk_disable_unprepare(mt->clk_auxadc);
+err_umap_apmixed:
+	iounmap(apmixed_base);
+err_umap_auxadc:
+	iounmap(auxadc_base);
 
 	return ret;
 }
-- 
2.17.1

