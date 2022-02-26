Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA6B4C57B5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiBZSms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiBZSme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:34 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A727EDC8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:41:59 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 185so7317531qkh.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=GLCGWP2NbqUAt+NRaCS9PbZaUL79BYkVdjpvU9SCymlZdEK+v2Fj0Bcr+hG8TNlyr6
         myRfqA2boAT6LU6bTUFYK31FWtgXeW/V6UPxFjHexE0tFoYEKG9Tkg4DM5zNYGQWoddr
         iQ3sLhmYLnMDuLc2M6chCxFvV3b0jXFKw8lf5lS90aUARI/CvTE7EAfXVY9PFtNUW/EI
         D7rQp2uL3ar7vQZGsGLqjewXOvoyAm36B4eiJKWJua9vaTiQgzSp4yBI27EmW81MfL3N
         7SuPTS7dcy94V5vhHfGkvXqgYsCQOek4MIC0tTNQBosKIaOvPPxArmNnJlVh44GW5dJW
         VLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=xAVmT9LFLlbIQIq5uhWoerQrUuwvp/HONHtBOp4Hs4pSCMfI2IqwPPZ1Syf5nY/zgW
         5qe8PfbvdaT/K1NjSYJzTj4+qUq1lJidiCR2HF33N4Nvef1IoecuBAog6VfhDrBi7DiK
         I6jBBinMWaZU18yZVFc8bgD/WJM9gI0BCgV/Kz9iY8hg4zFXAWpVwu01GAtJPfUEwG6s
         3wpx4jidU7BqGf+BSienHdSGcDwP85zNWFE4GmM4uYhRvodhSyvOkcCTXkSdQtiV4hAq
         +EgMQ8exXeaODBifO2Ek5PJeOc5eqU2FqaodUl2/WfBdauerrj/YX+YmOZndLqbfGkJ6
         CWYg==
X-Gm-Message-State: AOAM532R3RdE+4xvVOZxjskKhg6EpkNlFo2ZwsqhLbAJR4ndHJYH+Ald
        6ZMyo72FJTzXtS5iwV2TnAU=
X-Google-Smtp-Source: ABdhPJwjzpEX1dev4bOXCiYiicnwVacVs9OJdVCEIhtaa9wFGKty4rqda6jqF/suyoCbaYJvEpzEgQ==
X-Received: by 2002:a05:620a:2941:b0:47e:144b:84a9 with SMTP id n1-20020a05620a294100b0047e144b84a9mr7826680qkp.32.1645900918443;
        Sat, 26 Feb 2022 10:41:58 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:41:58 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] soc: rockchip: set dwc3 clock for rk3566
Date:   Sat, 26 Feb 2022 13:41:40 -0500
Message-Id: <20220226184147.769964-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

The rk3566 dwc3 otg port clock is unavailable at boot, as it defaults to
the combophy as the clock source. As combophy0 doesn't exist on rk3566,
we need to set the clock source to the usb2 phy instead.

Add handling to the grf driver to handle this on boot.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/soc/rockchip/grf.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 494cf2b5bf7b..384461b70684 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -108,6 +108,20 @@ static const struct rockchip_grf_info rk3399_grf __initconst = {
 	.num_values = ARRAY_SIZE(rk3399_defaults),
 };
 
+#define RK3566_GRF_USB3OTG0_CON1	0x0104
+
+static const struct rockchip_grf_value rk3566_defaults[] __initconst = {
+	{ "usb3otg port switch", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(0, 1, 12) },
+	{ "usb3otg clock switch", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(1, 1, 7) },
+	{ "usb3otg disable usb3", RK3566_GRF_USB3OTG0_CON1, HIWORD_UPDATE(1, 1, 0) },
+};
+
+static const struct rockchip_grf_info rk3566_pipegrf __initconst = {
+	.values = rk3566_defaults,
+	.num_values = ARRAY_SIZE(rk3566_defaults),
+};
+
+
 static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	{
 		.compatible = "rockchip,rk3036-grf",
@@ -130,6 +144,9 @@ static const struct of_device_id rockchip_grf_dt_match[] __initconst = {
 	}, {
 		.compatible = "rockchip,rk3399-grf",
 		.data = (void *)&rk3399_grf,
+	}, {
+		.compatible = "rockchip,rk3566-pipe-grf",
+		.data = (void *)&rk3566_pipegrf,
 	},
 	{ /* sentinel */ },
 };
-- 
2.25.1

