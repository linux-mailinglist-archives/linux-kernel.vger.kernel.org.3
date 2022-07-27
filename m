Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28D2582091
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiG0G6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiG0G6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:58:37 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF8E23BDE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u20so11013790ljk.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eisBk8K76hL/6j8y0uK6ovihXn9SM7gdqW9PXqAyLVk=;
        b=TrMQopd4ZttN/SXv8rUBJgLzP7UH92Up7MVWM9FXc2k3+aY5xryIyKrj/JkSKI3/hG
         TLofQkT869mkrtQdCpxnwCMxreJeo863fjtWwV82QznlCrXtLM9RPSlWVh41epir8h8Y
         LAluqgDFBvs5niRRFP88KUmUqoPBxUZ3UKLRFbOM/xVUE92oTvx9obDiz44hC/qNMJS5
         s8sTk6piEg24YmUrxCP8iUYnIWDkf9g+T8Paonjy10mwkPLb/9MQRlv/ODnHCaxDpKy2
         S/mypSCVdVyiO1v6C5+rTPsD0YUfQBRkgmD6tT1PCI773GiBJ90eXH6XILPiwa9r0s3e
         0OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eisBk8K76hL/6j8y0uK6ovihXn9SM7gdqW9PXqAyLVk=;
        b=Tr8cWfLulorkzy4q7upiol4xOF30Pz0l8VmiOprlj8KJ5ML8/vs8ADhFlGZDwbAjKk
         7ecIadOEPrYl8l5kj7ZYYahRiGXO9W0y9a8uHEE9Aov0Rj//OPq8eVgO43k1R1NZ6Wdg
         cVkUAj5kKJAWFWM3kj8+8EM4YaGpFF1TSeoyJhPuu2YoGuMFVb0XPw5XFnkNC9pTAbhR
         LUzWENai6KNeoL5srtYqaAF2EqKNFTdf5lnFT1ZZ8FhcFcjMzUBmMms4qOCmBUtEFulO
         LzJT2adQzHQkKI5Ng1BoA1EI2lspjEmNad0/LVkB5YiYqGbsijAmOUqRDwBidb8abGkz
         6RHQ==
X-Gm-Message-State: AJIora8Mvepdkv+HYCULfLc/LHJWeuw2bpQtG3m41VGDiWKTRUx83nDh
        L0b0X0EHXORQmRKFbJG1XrftucJb1PRggza8
X-Google-Smtp-Source: AGRyM1t/X7EjxzMAQ7R5kZye63XoYu2ayjZUJNqd7oSZYbPPZzxrv9PXKizxa8Byrx0pCimjv5IU0A==
X-Received: by 2002:a2e:b16b:0:b0:25e:153e:dabc with SMTP id a11-20020a2eb16b000000b0025e153edabcmr2150140ljm.247.1658905114538;
        Tue, 26 Jul 2022 23:58:34 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w29-20020a197b1d000000b0047f647414efsm3623827lfc.190.2022.07.26.23.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:58:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
Date:   Wed, 27 Jul 2022 08:58:26 +0200
Message-Id: <20220727065830.10681-2-krzysztof.kozlowski@linaro.org>
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
1. socinfo driver to provide some basic information about the
   SoC being used.
2. Remote filesystem memory driver (used in MSM8974).
3. RPM Power domain (used in MSM8226).
4. Sleep stats driver (used in MSM8916, MSM8974 and APQ8084).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5cd935ee148a..829bdf8a37cc 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -247,12 +247,16 @@ CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_OCMEM=y
 CONFIG_QCOM_PM=y
+CONFIG_QCOM_RMTFS_MEM=y
+CONFIG_QCOM_RPMPD=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
+CONFIG_QCOM_SOCINFO=y
+CONFIG_QCOM_STATS=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
-- 
2.34.1

