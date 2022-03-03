Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEB64CB8B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiCCIXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiCCIWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:22:48 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D29171EDE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:22:04 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f14so4943777ioz.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGcsQzhyoGAuXCpkoy+gsqGBuEcPDcpsVsFI3DXumdg=;
        b=OixVEehL9ANrT2zhtiRd4XIk7w5Q7oJMspYugHz7E/VCe/R7dWCXWTSWAQllK+kuoh
         R4kCIRwfwF3zF4G4HAGVRErDHJ/c3vNyo60zmQhfZAlmTwwLyn5MrKGFOksP3v1/Tlrs
         viLG+NokFA7DYRA3t5wr9M8XB+xin/5trZFMx+N1le/VVuZ1LXRm+JQ3q4qr3cBqzCHM
         PakY/r2pax7lr7j3SmpmP/M77HT7x/0nKY86/l/aayR9+JLsTvPMwJpV5IIo894EZaOz
         w7x2ixhnCeUxwCZIwiTFEB1UGSuK/Af4Ce08Kv7WesqXxT8fV0Fq1ku7dc3lHimu3b/z
         QPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGcsQzhyoGAuXCpkoy+gsqGBuEcPDcpsVsFI3DXumdg=;
        b=nDiebm/TwJDOnE3O0j+nGXZdoo4Q44iX53uX/s9eOnGaq7Q0yw3dyF8mTfhn38xc2o
         ig/4RwWlB67Ymb8PVGI+jS3ICVN/YRPoY+BuWdLgRPNQPktb6y6S5I69Lt3mw8rwzBse
         MleWJHRqwoaPT9ELkOaiM72eR7MMjRizqkQ54ZxRwGd8xPpJyJA2Rk0lMVVbmh1TAgSr
         XI0kXi51bFduncPeXQwmdD3+VJnOf675QW7S3HdaeSmRd+KmxtGbjrO6DSXmZRXbGMu9
         9PDRyXVIO4VYvFu5kcc8LGeqIlodjpWMSXyLDljvc323uenklXRYCOVJw24Janpg7hQ1
         9Msg==
X-Gm-Message-State: AOAM5309Zsj7hBtIMHtM+bknH47h36B5a64vTphNNwzTj06Y9n2j/J4/
        Q0dhHJZLo3v98QPLNWxuFx0Alw==
X-Google-Smtp-Source: ABdhPJw0LSc59v5YxhZFPkcaz13OBR70lMJURLf852F5z2dXlxHKXkoLJ8ISN/z1sbCaLv1R+ekJsQ==
X-Received: by 2002:a05:6602:150a:b0:632:c10c:55ff with SMTP id g10-20020a056602150a00b00632c10c55ffmr26399404iow.16.1646295723428;
        Thu, 03 Mar 2022 00:22:03 -0800 (PST)
Received: from localhost.localdomain ([182.64.85.91])
        by smtp.gmail.com with ESMTPSA id l187-20020a6b3ec4000000b0060523f4e92dsm1204569ioa.28.2022.03.03.00.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 00:22:03 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v3 1/2] clk: qcom: gcc: Add UFS_CARD and UFS_PHY GDSCs for SM8150
Date:   Thu,  3 Mar 2022 13:51:39 +0530
Message-Id: <20220303082140.240745-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303082140.240745-1-bhupesh.sharma@linaro.org>
References: <20220303082140.240745-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the UFS_CARD and UFS_PHY GDSC defines & driver structures
for SM8150.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/clk/qcom/gcc-sm8150.c               | 20 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sm8150.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 245794485719..ef0f26c43ec1 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -3448,6 +3448,24 @@ static struct clk_branch gcc_video_xo_clk = {
 	},
 };
 
+static struct gdsc ufs_card_gdsc = {
+	.gdscr = 0x75004,
+	.pd = {
+		.name = "ufs_card_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR,
+};
+
+static struct gdsc ufs_phy_gdsc = {
+	.gdscr = 0x77004,
+	.pd = {
+		.name = "ufs_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR,
+};
+
 static struct gdsc usb30_prim_gdsc = {
 		.gdscr = 0xf004,
 		.pd = {
@@ -3714,6 +3732,8 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
 };
 
 static struct gdsc *gcc_sm8150_gdscs[] = {
+	[UFS_CARD_GDSC] = &ufs_card_gdsc,
+	[UFS_PHY_GDSC] = &ufs_phy_gdsc,
 	[USB30_PRIM_GDSC] = &usb30_prim_gdsc,
 	[USB30_SEC_GDSC] = &usb30_sec_gdsc,
 };
diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
index 3e1a91876610..1bd65cc581c3 100644
--- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
+++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
@@ -241,6 +241,8 @@
 #define GCC_USB_PHY_CFG_AHB2PHY_BCR				28
 
 /* GCC GDSCRs */
+#define UFS_CARD_GDSC                                          2
+#define UFS_PHY_GDSC                                           3
 #define USB30_PRIM_GDSC                     4
 #define USB30_SEC_GDSC						5
 
-- 
2.35.1

