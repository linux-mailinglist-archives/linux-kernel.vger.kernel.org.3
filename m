Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A304C5C8F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiB0PbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiB0Pa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:30:59 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B003FBEB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:30:22 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a1so10583377qvl.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=N/u0A+od7mnhmo0ttIWI5u7uH+VOP2c9hsLk6Rwvuq64MmCYpSUikT2vIoUFHRLRqZ
         r/nNbb8nJEuaxvG+lwFVbHdMAaQl/aHXMKgUdPnrkmU+p6mF368niIveTyT44NZgNbiD
         tcgSoRjSqUIzc7UVGKPrdhLRbYZTSwbLWPtMMg5jip9EVZcXGFzbq73HndfBS/zzneLB
         gYg25f3GfePVUS7hxy422+gIp8HxHACeAQnlOrvGgMawRq8Fs3+WI5Cu7O1z+qe3xFDn
         wZFVVRZFXTDRH8kl3hBXtCXDrMjskt7w1Spo7ZR1FzxXqr8G/gWpntJNbmCr36MltT2t
         ARKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtUJySmbIWUCXkZt6OYhMWHmPcZgwTz+ISBAU3SmGDQ=;
        b=EOzB6IF/7k6imGcnZN1T6F9ctDs6QTqjH/qDtQtZtehuoZxvnWwJSiLEEK/SkIoLp8
         FEIgkwhs1cwaWoHVHkU/VGAbFoen7MBGmLUfKBcXeFRu/OkwafdGGVk/9CrkrsD1Z7bP
         9rB9WofAq63CVfXaAj0c3J71waJdY4VB8eZBHWnC8/qE4Rzohh5YMg7Yq8geOMwPFY9C
         3rLmstuzy/4ENPQVulAiUvOMkQ7YZ0QZlWDkrZn0qhnOwJc7Gq/c9f3a4U3rWoG3mnu5
         il41LE10TfOAnNSUQwWaMXCkM5l/YzYbZRiyqk59ZvHz90dw5ryBXSwLgwzOryfG8Ot/
         gQwg==
X-Gm-Message-State: AOAM533L/ZJzLZjEIPtMqs6LGd5FzGYzpXTUfjQPu6MGH1XQhevFS/3a
        PnzFcEwsc4+wrWeKcUjMZxuaJoowRjbvmA==
X-Google-Smtp-Source: ABdhPJwwGqnRp4WZw5csveWAlg4LO4iYmZynP772sOMTPLXz4bRnXBhnjOE5u7jMT9BtKP+KiczALw==
X-Received: by 2002:ad4:5b89:0:b0:432:e725:2594 with SMTP id 9-20020ad45b89000000b00432e7252594mr5004735qvp.84.1645975821762;
        Sun, 27 Feb 2022 07:30:21 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:21 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] soc: rockchip: set dwc3 clock for rk3566
Date:   Sun, 27 Feb 2022 10:30:12 -0500
Message-Id: <20220227153016.950473-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227153016.950473-1-pgwipeout@gmail.com>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
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

