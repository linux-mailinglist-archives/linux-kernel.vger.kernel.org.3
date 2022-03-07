Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D332B4CF056
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbiCGDij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiCGDig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:38:36 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854E81D335
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:37:43 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id t28so12245930qtc.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 19:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8QDW6UTeACG0rxiBS0sXV29w6Hm1L3x1pOFTfvYoco=;
        b=UhDaNU/OrDgPzFSsT5SCnxIwq87nhnmtuQuM4tjqdzHdgqnILE8CJ/5WoqsDd1NfRj
         Wf60DfpiTanh1y94UjU2VDJX/sqZfL2Ic8/r46b6MdHiXc5raQZjTZJ0x42Ur1bwXIWn
         hV+imsHf+UqzqIsj+Cwe7gPLCtQwx5822jZ0eAg6qpFVPgjdsY0kxkIB9zaOQOmzI15q
         MOWAYK2WJFbQssZ14oyTtArpSSmrKQQZW/RAgv/+XzY5aqjU9trs41wgRW7SZsQFt1Zs
         xE8xuOsaLLsd0c+8Oi/DbooMvqW4hedc0nbNyuSzOpxKZzhVl5v0OJKlhfz6hmdQ1LKp
         JLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c8QDW6UTeACG0rxiBS0sXV29w6Hm1L3x1pOFTfvYoco=;
        b=3wlWOIH8HEf1VRDCXlAEDS5iT4J7gsF2HdIyyiO32P45RtXAmz/ZhDAkdEcYKZqKky
         Al2B2CTonrfUrZrQgpn4Z7WmHmIkplFRpm2CwxW7Cn1d2o6XxQzKaUb82xitqzpduOLn
         CYidfm0Q/tBdpbPxggiw07OavMoLt2w8ByWG74fbnlYlmE8pHDpZV3mG5Zgunq0mldIq
         m44sEdKj5McWd+5c7FsFwOQyAFEwqwq53UFngSLGLfdnxyX2JFZYooU/hxlT9HxpaX5Z
         Ykunze7VKz3T5jN/lnfLUeAC5cIF5QSic2yOs6CFQ1bUwdt2zOdhXP0K4AfRpcNaxJkF
         OIRA==
X-Gm-Message-State: AOAM531FCiZJjQUSqoiXK1nWA9QFMJkkn5LVicdeJTbhz4t5scflJrPU
        iHUxc+bfsy/xCFb+UjptfSw=
X-Google-Smtp-Source: ABdhPJyu3R+8i2+3mJ/KhdZFBP3OPT4qaN62eRtGea7/E0LLLU7O564YBX3PGJ/syyQRh8JNZ6XpSw==
X-Received: by 2002:a05:622a:110d:b0:2d4:e4c4:6b with SMTP id e13-20020a05622a110d00b002d4e4c4006bmr7882247qty.425.1646624262759;
        Sun, 06 Mar 2022 19:37:42 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x23-20020a05620a14b700b00648eb7f4ce5sm5462544qkj.35.2022.03.06.19.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:37:42 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     nm@ti.com
Cc:     ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] soc:ti:omap_prm: Use of_device_get_match_data()
Date:   Mon,  7 Mar 2022 03:37:36 +0000
Message-Id: <20220307033736.2075221-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/soc/ti/omap_prm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index f32e1cbbe8c5..913b964374a4 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -941,23 +941,20 @@ static int omap_prm_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct omap_prm_data *data;
 	struct omap_prm *prm;
-	const struct of_device_id *match;
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
 
-	match = of_match_device(omap_prm_id_table, &pdev->dev);
-	if (!match)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENOTSUPP;
 
 	prm = devm_kzalloc(&pdev->dev, sizeof(*prm), GFP_KERNEL);
 	if (!prm)
 		return -ENOMEM;
 
-	data = match->data;
-
 	while (data->base != res->start) {
 		if (!data->base)
 			return -EINVAL;
-- 
2.25.1

