Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1980F4CEAEC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiCFLO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiCFLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:13:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B6D56775
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:12:36 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 067D23F628
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565147;
        bh=fptfaOUAaErRHK6yyvwk8Ba2q3vPhWe6MKEfwn6hivY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ErLRB5j7AU1MhHNB2TxS6tT6ZkwuxolAdOyGzXzzwa2p+Y2pkIxfo7PtcoQiRUvsu
         LOMJuBQI6SIr093o7dvjS6eKfuk/kBK6ymF+AjEVqskMEvG1Kcbm6IOyps8AoJ3S1p
         02a4iubtKsii4gRqdTWHWhRmdLqFegfvgC3XCrYj+0t52IGh/eluuMZeOiydc5kvOl
         gSJp92zER6oDaR/65fdr5VgOudVUi3G8QSr9kPaCR0JC9bUeZEgKXETwx2OcGZkqbD
         865tcca+66EbS7PoIxS5kwPUmfjP0AN5Zud9mKYgxMgp/quPEfmQ7gaiDHWgytDYkZ
         uJahMJrdAMVkA==
Received: by mail-ed1-f69.google.com with SMTP id b24-20020a50e798000000b0041631767675so850565edn.23
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fptfaOUAaErRHK6yyvwk8Ba2q3vPhWe6MKEfwn6hivY=;
        b=27QhjOsJMOThQnExoURqBuWubYPeONYs30XVmU3WPjfHLD5FMBilOzyMUUTqpHG178
         OHCf3UVKkYKV984K/MB7H/jb2Sh6957zUepvk85P7F5bvW7H700GkI3GD53e0Pn6sYzi
         d9fp0rVEGr/sYyaTH99R2/UG4llOfmf5vu1M1HiezPCmxiUAhLcDavQ7Kdb/Ay9GWzGZ
         TfRdj+XFSrPWbizf89h10Fm94iyrZKemAPXyd9nlWZiqoaCbjZGt+WoaO/lNrRcUV4lO
         mNfyCXzhiPfQjfRI7m1jpphH10OiP9YLqjd6cY54fI5+FKB1ycstMB9uyRVmDAJytmrT
         smyQ==
X-Gm-Message-State: AOAM533g5kyToL5MeX/kGK4SYgVlw2ypvi7Ekv7rsw5NTEuVCN5gtg7P
        sK/9Dn+i9/jdMJ/kGBHgRDJF2k9bircRkKUClHO6rM/uxw2DW7OCj4q2gXRjaje0IFww3NpUzUz
        CnwyAY/jxSAwKl8jjAvMf6SQerVcGiURxk/+vsM6nrw==
X-Received: by 2002:a17:906:4fc7:b0:6da:92b2:f572 with SMTP id i7-20020a1709064fc700b006da92b2f572mr5333891ejw.184.1646565109082;
        Sun, 06 Mar 2022 03:11:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJya7NhXOCbqGIagE53ZCTSIPIL5hGs6/ccWmxHFezSS2trgYWXGqqPKbwVvYlPcyFRrUXKq6w==
X-Received: by 2002:a17:906:4fc7:b0:6da:92b2:f572 with SMTP id i7-20020a1709064fc700b006da92b2f572mr5333879ejw.184.1646565108853;
        Sun, 06 Mar 2022 03:11:48 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:48 -0800 (PST)
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
Subject: [PATCH v3 12/12] arm64: dts: qcom: sm8350: drop duplicated ref_clk in UFS
Date:   Sun,  6 Mar 2022 12:11:25 +0100
Message-Id: <20220306111125.116455-13-krzysztof.kozlowski@canonical.com>
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

ref_clk clock in UFS node is already there with a <0 0> frequency, which
matches other DTSI files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index d242bab69c2e..02589b3beb7c 100644
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
 			freq-table-hz =
-				<75000000 300000000>,
 				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
-- 
2.32.0

