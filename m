Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B4F4F9923
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiDHPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbiDHPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:14:47 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2F100E29
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 08:12:44 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 75so2197354qkk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=gUyAAC9v3ERVIgec02ALPphf34Xi2rpE30HcoIEAl12wO4+4DmF+INCjvNlfP6//bX
         LwNdSlQN0FMAj17eSK4o8Y4ekWNq0q3JwACdWjTpuD3oUxuhKo+Kd0S7QgbS/V5iNtdN
         EHH9p8BbZFmm8y8aHyfORhDOffQAIrbvlpYeueXZzHn40gmwlQ7V8qyv+6PgjsmKPr3R
         1bjdeg3X4XsKH+97mtRF5tllilSgjXurlrXajiLamwAmN+bqGr9E8VfF2lZlYvNjua75
         GPNcU0jkdtcKoBIgMDTYcgSjlkRrtGT/y6H15NVDAkfe/1i/s8WERY/cg4xcGay2LtUB
         E5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=2rJZSGQAeIwfA53pmg/S07SVl9X+/UsCsBTQORiBYy+heYcko8DN1wGRuKY+SrCs9J
         RVAcG1nJYPJrv73lCqMFDFW2kyGX+8L+6Z8WJv/13pUUIMy2RllNY6p+28p7zPB17Lau
         CkpxlN+c1an2/WvlKCtDZGD5oaDNQ7diwUGouLlIilJXxEsAMeK/ParR/HbPW6grjMWq
         Iy2eHSeAr06qny/u3aOlTv5r9BN7peWlq4BBN3z/4YJMQLihp2y9QGu8BA7Ktep7lL/t
         mz4e+yaxTQ5blZ4x2g0eD0jcWT0ce3yQm+lYx6pwPq4eOMq4QI9w3zV67EMk3QaIgWzN
         w3KQ==
X-Gm-Message-State: AOAM530mBjpHiv9Z9LUnra8o8Xf0Kl5QBdA4f5SkgyWARUuKPx8kEPSP
        a/oqB2dmrVuHP+g5TiqAmZouFfAz8rX7gA==
X-Google-Smtp-Source: ABdhPJzO2WStjiG85MQLNiiZOS4kkxy+rUxW75KBCuvwTjYqenTUZaIskskKwgBfYUIyVOsllhj0Ag==
X-Received: by 2002:a05:620a:228f:b0:67a:f432:af72 with SMTP id o15-20020a05620a228f00b0067af432af72mr13360897qkh.603.1649430763374;
        Fri, 08 Apr 2022 08:12:43 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 191-20020a3707c8000000b0069a13545fcfsm2266052qkh.123.2022.04.08.08.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:12:43 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] soc: rockchip: set dwc3 clock for rk3566
Date:   Fri,  8 Apr 2022 11:12:34 -0400
Message-Id: <20220408151237.3165046-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408151237.3165046-1-pgwipeout@gmail.com>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
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

