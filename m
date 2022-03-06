Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13734CEACD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiCFLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiCFLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:12:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD860CF6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:11:48 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 639AD3F62E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565105;
        bh=xb1NVPmzCu//acWeZYDa5U/h0JIp5bKXDfT7rDv6gyY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CMG5g3dgHgKCD90u05vIsomchSxBmlCi37/4Dc102Qbud1/gWSzSLOZqV5jSVkAhC
         EaJLLfWxvwjklEVvNPs1Ktr/DQTKIua/Vn2dPzt+OhKLqD+lfVOD+XLzhHmK7NesGf
         I+fKh8+uBDzbU6UU/rfacLN2QXBzQ09NGBKqv5BKXIMl9wDrhTDOpkNEvlmfCh5Y+N
         C1ut1FxBUGbIluxTG6q04aV1rCpC74sH2oIyWM903j/WlchfDM36E60evToYQ5AR5l
         hqlPwismeoxsQ4C+g8UA1ewroMCGWQ3xPHw+vRf9CDUZ3WvavAQoFeBREyv/4eIcuI
         ZazXWox46HWNg==
Received: by mail-ed1-f72.google.com with SMTP id l8-20020a056402028800b0041636072ef0so730289edv.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xb1NVPmzCu//acWeZYDa5U/h0JIp5bKXDfT7rDv6gyY=;
        b=g2/YtO7PMI93aezSNO+K46R4ZgL8S0e2yohd7his9GFRT7RPe14WQWjnRxDefG2Mc/
         Hatr3CETewMoJxRGfZzQyYRakuJjvorLzzqOJ3kRnO5IlDfUkTbMFU88fpICnxSjHlAb
         NBuszcIeAhSlUQW1YXZ4eT+oM/88lKhW1cvmOng8MxWCswnN6qld67bDK57HOhN++X10
         8fwpc5KbgWZ04bpNqJ1hwEARk3rbtnScWXcPs0oIt26qohuffR2/zPAn0WPxeCLpwqmE
         /K56kwfsMfJkpyBTvuEMzhbmmX19Urn42GwEguQA2GzZ56h+5EpJ++gFYMmAN1SVyGg0
         50FA==
X-Gm-Message-State: AOAM532MLrsMVoiStBNoIi98g0k/l+2detF3LThz9NVEi5l9+566fdHc
        43dfWEklnC1Ea2aNijc7zyWrnsuD5/ORR/oOz5SC3eJwvvPWin6RCXTFoSDgwU8RIHG7BiL7mz4
        e8fO7eYIQXjXi9nH+WsUQ2YYkK7M+HiWpK8LF8OeIfQ==
X-Received: by 2002:a17:906:3ad1:b0:6ce:a880:7745 with SMTP id z17-20020a1709063ad100b006cea8807745mr5480165ejd.46.1646565104764;
        Sun, 06 Mar 2022 03:11:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkqOPNZGWUEHHQJ1DdvnKzAnwvejxildLb9k95BB+Ex4BtuNUf/GcST/RwEz/yOnL8XuyPOQ==
X-Received: by 2002:a17:906:3ad1:b0:6ce:a880:7745 with SMTP id z17-20020a1709063ad100b006cea8807745mr5480132ejd.46.1646565104528;
        Sun, 06 Mar 2022 03:11:44 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 09/12] arm64: dts: hisilicon: align 'freq-table-hz' with dtschema in UFS
Date:   Sun,  6 Mar 2022 12:11:22 +0100
Message-Id: <20220306111125.116455-10-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT schema expects 'freq-table-hz' property to be an uint32-matrix,
which is also easier to read.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 8bd6d7e8a474..6b3057a09251 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1045,8 +1045,8 @@ ufs: ufs@ff3b0000 {
 			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
 				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0
-					 0 0>;
+			freq-table-hz = <0 0>,
+					<0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index 636c8817df7e..3125c3869c69 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -671,8 +671,8 @@ ufs: ufs@ff3c0000 {
 			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
 				 <&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
 			clock-names = "ref_clk", "phy_clk";
-			freq-table-hz = <0 0
-					 0 0>;
+			freq-table-hz = <0 0>,
+					<0 0>;
 			/* offset: 0x84; bit: 12 */
 			resets = <&crg_rst 0x84 12>;
 			reset-names = "rst";
-- 
2.32.0

