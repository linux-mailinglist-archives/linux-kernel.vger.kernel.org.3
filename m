Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E886F4BFBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiBVPCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiBVPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:01:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711C510F201
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:11 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E303B41270
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645542006;
        bh=LfKEooVWXSt0X9amI75MXA0ImuzcwyjqGr8txR6hCCo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Xpq+NWbyj+VlCotybwRWDbRayC5t9YCiN5vr/RhTjDkb9JfEuIWlrZD+ahkx78qVE
         0gvfA4pi5IyOrqMpgVVCfmZeVFP+e2+fmXobZAnqcrV2s3Ulk8qS1MDJYP7/i3aISw
         MIhC83Z6Z4oeith0Ju/BnFccxxsOTEhoqv2X2BDORP/cCNqRuKOCVOhG6wz+uP+Ht0
         LZxkDMXIEm3jLmESBwmYT3iZ5K7to2i4FqCZFpEYIDNJAJgI1qlA8qAJITrPTy5IK4
         bH2YSHoVaw1ZuIpn8UPPKNP8UJhmBE2o4B0qBVBEJcZC/MsLjqGZO6dvS5NZ+A8Zob
         +DX5F3bqnz9xA==
Received: by mail-ed1-f72.google.com with SMTP id d11-20020a50c88b000000b00410ba7a14acso12094751edh.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfKEooVWXSt0X9amI75MXA0ImuzcwyjqGr8txR6hCCo=;
        b=otc55xra9RbhELV3NhGgoveOwJRgY2xm1LLb3osbfeRnnFRSutbmKhOdPgGNqztvig
         jwDIAg6TeuSllGNuqLfLdTz4J/yMZYNt1/80Ho5AzDuBko3pCPDreOAu76bjAFSreENT
         GjEcmbcYqpIXADD4SAMVJnf/DZgLMN5fzuPPP0dNVgPUC7Ok/c41qStlhoK3w0tcSecv
         6c1YC2v6QkcANBpT4zEam7IspxbzRzMoYdgXYdWDqpihsVahUOzoO9lTSuIzk8PO6wEY
         8qGgHzvYPyo2SZahw7izS+tK6MqTzu8W08hfWpEgdthxruD3IOCtY7rhXFYhuBFvFqj8
         zaCA==
X-Gm-Message-State: AOAM531WL1sa/HmEKqAyGlXWsFg9BnralOHuF0kHc82Cndx3k2ziAaSl
        HJUzfd5y8ukirMwSBUE4mxhLi1X7/NYtzcWI/NK4bVkcPYdFxvs1Nxvha7en/0EJ5+vSli9MGiW
        w3BDkHiJcMzt5V4E23iq9NBhLz6mcqlLf20BDF0/UrA==
X-Received: by 2002:a17:906:70c2:b0:6cf:e1cc:4d8c with SMTP id g2-20020a17090670c200b006cfe1cc4d8cmr20090154ejk.696.1645542004850;
        Tue, 22 Feb 2022 07:00:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyR3qbd+Iftv6XGp15bvvgUICPOPWMYZg+AzIuOxdejdmzbh/iz1wm8C/0MI15ezn8MGt0S6w==
X-Received: by 2002:a17:906:70c2:b0:6cf:e1cc:4d8c with SMTP id g2-20020a17090670c200b006cfe1cc4d8cmr20090120ejk.696.1645542004625;
        Tue, 22 Feb 2022 07:00:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id m2sm2467960ejb.20.2022.02.22.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 07:00:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 15/15] arm64: dts: qcom: sm8350: drop duplicated ref_clk in UFS
Date:   Tue, 22 Feb 2022 15:58:54 +0100
Message-Id: <20220222145854.358646-16-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
References: <20220222145854.358646-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ref_clk clock in UFS node is already there with a <0 0> frequency, which
matches other DTSI files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a26bd3f13d4a..cb6442c9e761 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1916,7 +1916,6 @@ ufs_mem_hc: ufshc@1d84000 {
 			iommus = <&apps_smmu 0xe0 0x0>;
 
 			clock-names =
-				"ref_clk",
 				"core_clk",
 				"bus_aggr_clk",
 				"iface_clk",
@@ -1926,7 +1925,6 @@ ufs_mem_hc: ufshc@1d84000 {
 				"rx_lane0_sync_clk",
 				"rx_lane1_sync_clk";
 			clocks =
-				<&rpmhcc RPMH_CXO_CLK>,
 				<&gcc GCC_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				<&gcc GCC_UFS_PHY_AHB_CLK>,
@@ -1936,7 +1934,6 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
 			freq-table =
-				<75000000 300000000>,
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-- 
2.32.0

