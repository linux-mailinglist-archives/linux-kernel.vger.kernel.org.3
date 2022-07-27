Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0909582093
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiG0G6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiG0G6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:58:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA8248E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id p22so8997424lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tsu9Z892G73WwW+ufE+jDoXKbM/bsXcQ+B+f1ENFggU=;
        b=dpAzI9QXe7OOSEBzqCc7VPjzeRLf9qIMgeOCHSNZ3ZDWevVHMvdzaiTneBzPolQJ2U
         lBA+3r2OE9ZmJ1Ye88oauiAfa88Ynd/wTOJlYo4wac8StHet5oObj7MH+/FzwvcJrACj
         k5xv41UA7AMkjuyChEIvOOI9tTnfYc2uVSdGuqa//+wuhdYShMjGb85NRBcozOwzGGWs
         BKrngvK/69c4hhgtwoSgJt/IyjkMfRcghA1d2GEemZg4T6ax1XyoyFEAg58wswtDevjg
         Vx5qcA+XBSd5CsevvpqTiCSJVHnDaB6eOzxwfGmUJm24uQCXUXGV7TqrTc8Pl+6ZWNvA
         Fguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tsu9Z892G73WwW+ufE+jDoXKbM/bsXcQ+B+f1ENFggU=;
        b=yrzXN+tnifVN4YtHLJtDdxa3RDyrBrswJhfi8SfYVlBlgsonUE/GDPilYKvUcSkxjB
         3IpMmkZ6ued8vb18ZCHPx5JSR3gHsvGlQzwyHoQGRSAZYup2QtL9doxiSwPaoyWwffcF
         Wi7/dR8zqvKpVtw7NyQeCK4VeP+D0NUeYzXTqlJ1qXyvgM/X+Plt7iqeIdM0GaxFCB6u
         IMXWtVXPj1lyeBBxkhg6EnPbX4Sh72HU4vV0LA8BX8zLMkFrRdTyVpweaTQH9N096seR
         Eq7RIINPkmgomD22JRzYWn+U4tjwuRrUV0RX2yBadI8wWFpwaQu6Ld3t/23Hk86CMp5m
         hQpQ==
X-Gm-Message-State: AJIora/11CV/Rem5yL+PXpkvMtZuJ1zRMtcg5TEjAscHu4yIJswwaUAQ
        +tw8e4BR5Ls+94HppY2exfa1GA==
X-Google-Smtp-Source: AGRyM1thbYSRFIB2mQRnFM1qyZOAOY4z+rB4P2/8fyeWpkyvTwLqQknHUl7Kq6v8jSNyar7RQdDQdw==
X-Received: by 2002:a05:651c:248:b0:25d:4f99:683d with SMTP id x8-20020a05651c024800b0025d4f99683dmr7544548ljn.366.1658905117120;
        Tue, 26 Jul 2022 23:58:37 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w29-20020a197b1d000000b0047f647414efsm3623827lfc.190.2022.07.26.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:58:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 3/5] arm64: defconfig: enable more Qualcomm drivers
Date:   Wed, 27 Jul 2022 08:58:28 +0200
Message-Id: <20220727065830.10681-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727065830.10681-1-krzysztof.kozlowski@linaro.org>
References: <20220727065830.10681-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Qualcomm drivers:
1. Last Level Cache Controller (many platforms supported).
2. On Chip Memory - OCMEM (used in MSM8992 and MSM8994)
3. Subsystem Power Manager - SPM (used in MSM8916 and SDM660).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 29d86eb839b7..eb9d48fedc0f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1112,6 +1112,8 @@ CONFIG_QCOM_AOSS_QMP=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_CPR=y
 CONFIG_QCOM_GENI_SE=y
+CONFIG_QCOM_LLCC=m
+CONFIG_QCOM_OCMEM=m
 CONFIG_QCOM_RMTFS_MEM=m
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
@@ -1121,6 +1123,7 @@ CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_SOCINFO=m
+CONFIG_QCOM_SPM=m
 CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_QCOM_APR=m
-- 
2.34.1

