Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B94557DC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiFWO3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiFWO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D56F93669B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655994543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WD6aAT4eAfkhBAGxc5usx5w9FCyTvm/RJ0Dv5y8ZHUg=;
        b=AX8jefxIh3rkcyL5lW4atqvY4ECnnPpWBV5erURxzfQSbe8yMfjMfQ61f6FuuEYcgzASyN
        SLEXj5MXZ/7uvThAeRA01z5Jr6JsIXnxaeAW2UKn+jV0yjQ/VU1cbraQw/pq6nq7dxPYO7
        RoipA5B4LIS7oGdx/12RAvM1mdSOvgw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-bxxKNnUkPXKcrAgIYcYEMQ-1; Thu, 23 Jun 2022 10:29:02 -0400
X-MC-Unique: bxxKNnUkPXKcrAgIYcYEMQ-1
Received: by mail-qv1-f71.google.com with SMTP id kj4-20020a056214528400b0044399a9bb4cso20499467qvb.15
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WD6aAT4eAfkhBAGxc5usx5w9FCyTvm/RJ0Dv5y8ZHUg=;
        b=PFOS7WI0XZ4Hdyz1+dlE1JA3bqGsCnLcohnD5QbM6cRysNI88quV4no1WT3lcyEiDl
         X2etLoiheFi4FZUkNBx7iNhZI2pCloZseDEj7WkzNlmkDdvSPr/Wsf6jXgL//2vfpJgj
         DGBxCd9h46lXJFTCroMrL/oxdXPu6Izlm1DXkiIhPXOUr/4WoXVvqTfI8p0GPMifZDST
         lW90/3FrbmQEOQrNY0t1ecSw/Hg9hY0GijmE9PlF++yv33UcOE9+7wgJ89LFr9YS02s0
         /Qka/t+zuhNZn5zFeW/kqhW5cxRWD31PYgqXuB8EE7juxuduv1nC73XepNttSGzb5iJd
         n0uQ==
X-Gm-Message-State: AJIora8veomI9TcVVvoxWom8iIZBGVcixhKR9888tgn88P5lHaf/uBEb
        uK6su2hdyiEpJToy8uu42gAz5GlAsdFeuwmCPnNOtvsqNGGI5YqrmI49g4IyIuTCDLY8+qnJZtr
        ixdF5VdFchn/qKAY/XfeoJX/z
X-Received: by 2002:a05:6214:b69:b0:470:4d46:a399 with SMTP id ey9-20020a0562140b6900b004704d46a399mr14931858qvb.68.1655994542067;
        Thu, 23 Jun 2022 07:29:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s3HQBpI082cjSWrflbTXyicJSxjqvis1d5yO6iArcXxXYDi5XlJzjhdU6+uUThw6LfTCvY2Q==
X-Received: by 2002:a05:6214:b69:b0:470:4d46:a399 with SMTP id ey9-20020a0562140b6900b004704d46a399mr14931452qvb.68.1655994536929;
        Thu, 23 Jun 2022 07:28:56 -0700 (PDT)
Received: from xps13.redhat.com (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id d124-20020a379b82000000b006a6ae9150fesm18412531qke.41.2022.06.23.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 07:28:56 -0700 (PDT)
From:   Brian Masney <bmasney@redhat.com>
To:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
Subject: [PATCH] clk: qcom: sc8280xp: add parent to gcc_ufs_phy_axi_clk for sa8540p
Date:   Thu, 23 Jun 2022 10:28:37 -0400
Message-Id: <20220623142837.3140680-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sa8540p automotive board has the same SOC as the sc8280xp. In order
to get the first UFS controller working on the sa8540p,
GCC_UFS_REF_CLKREF_CLK needs to be setup as a parent to
GCC_UFS_PHY_AXI_CLK.

This clock name came from the DTS for the downstream MSM 5.4 kernel
sources for the sa8540p. It also references GCC_UFS_CARD_CLKREF_CLK,
however that wasn't needed to get the first UFS controller working.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
I originally added this under GCC_UFS_PHY_PHY_AUX_CLK since that's
what's in the downstream DTS. I was getting errors about
GCC_UFS_PHY_AXI_CLK being stuck at off so I moved it there.

Also I don't have access to any documentation for this board so I'm
hoping that someone with docs access can verify that this is the
appropriate place to put this.

 drivers/clk/qcom/gcc-sc8280xp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
index 4b894442fdf5..4639b50da418 100644
--- a/drivers/clk/qcom/gcc-sc8280xp.c
+++ b/drivers/clk/qcom/gcc-sc8280xp.c
@@ -5685,6 +5685,19 @@ static struct clk_branch gcc_ufs_phy_ahb_clk = {
 	},
 };
 
+static struct clk_branch gcc_ufs_ref_clkref_clk = {
+	.halt_reg = 0x8c058,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8c058,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_ref_clkref_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
 static struct clk_branch gcc_ufs_phy_axi_clk = {
 	.halt_reg = 0x77010,
 	.halt_check = BRANCH_HALT_VOTED,
@@ -5696,6 +5709,7 @@ static struct clk_branch gcc_ufs_phy_axi_clk = {
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_ufs_phy_axi_clk",
 			.parent_hws = (const struct clk_hw*[]){
+				&gcc_ufs_ref_clkref_clk.clkr.hw,
 				&gcc_ufs_phy_axi_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
@@ -5899,19 +5913,6 @@ static struct clk_branch gcc_ufs_phy_unipro_core_hw_ctl_clk = {
 	},
 };
 
-static struct clk_branch gcc_ufs_ref_clkref_clk = {
-	.halt_reg = 0x8c058,
-	.halt_check = BRANCH_HALT,
-	.clkr = {
-		.enable_reg = 0x8c058,
-		.enable_mask = BIT(0),
-		.hw.init = &(const struct clk_init_data) {
-			.name = "gcc_ufs_ref_clkref_clk",
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
 static struct clk_branch gcc_usb2_hs0_clkref_clk = {
 	.halt_reg = 0x8c044,
 	.halt_check = BRANCH_HALT,
-- 
2.36.1

