Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04121581600
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiGZPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbiGZPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:06:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E142E9DA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m12so21991552lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zf+Atw6W9ce++rwB/xGOClK+4e2ERQWgmlZE86UF1IM=;
        b=t8jRIVH2Jgs+63JFHB6dXrvZFEi4zlLDp2OJE9G5VlXCyt7niyPHgamL8t76KtfPbw
         ORV+yASi4K3O4rC98H/5Q8urTjXwJyYMW7U/G1VXcjW6G6y5jIfaFjBwtTGcl41XioMv
         k0Iu8XmIVDipPe7xNofQ1BwQtDSIRhEeabl573mxEtZwqO/bo8buK/tsr44UPko2cJNa
         leibi2hTCXEEvnsqZsLDCGwh5hoKjx3F7r+e3gVS2JO6wrNzSJNFEVF99yDsYhoxvb6T
         sZiatvzgJvtdONXiNGJDDTTLH7yl4eLCDawH06MMHI3Fr2VDvJYHa2pE/7ALL/+5VpSe
         Tn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zf+Atw6W9ce++rwB/xGOClK+4e2ERQWgmlZE86UF1IM=;
        b=TxYlwee26h4fsQhHPB+BGr26kmWWViwP7804kf+3WZDc1Lp72yYHz0ORDQSAn3kp2z
         yuxbmJdvIIixoQIyJUg8gDNVbArOOmu+RlAVAZHv40Zt95xuOBfEFmY5+cR0s+6cIdwU
         gQkdsNSqX/w7itynigtgHwGpWlBiBAcCfzg4bbXSbmDukQvbxr2Q6hBYZsTC5zdZAi5B
         YPKNITbof+S5XxZtCHXKIqy3Roo6oSGLbbLUdnlTZ5wiPqT8Vob6w+RidJOLnGAr0w8j
         pbwDFwiVfxMBbuzYE6d4ZNNoLdxj1XQ9xTytiu48SoGeaQona+rHwtXDaVWQS4TiTQjQ
         wowQ==
X-Gm-Message-State: AJIora+OjpqXhM1/ygPbjyzZ+X7bwAxXI4Y1vo5xaoVB5mmkP+a1QqbY
        FjyGoJVktUQfgkelYPqRv5wqcw==
X-Google-Smtp-Source: AGRyM1taY4mwJsiQlIKI4aO7XHnTqlgPEIVbk1Oxa7W76jDrggoak906bc9JOjlPsftGTvndNx9vOA==
X-Received: by 2002:a05:6512:ea5:b0:48a:77a6:f9f with SMTP id bi37-20020a0565120ea500b0048a77a60f9fmr6214328lfb.60.1658847989774;
        Tue, 26 Jul 2022 08:06:29 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a26-20020a194f5a000000b0048a95c16849sm836620lfk.282.2022.07.26.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:06:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/5] ARM: multi_v7_defconfig: enable more Qualcomm drivers
Date:   Tue, 26 Jul 2022 17:06:06 +0200
Message-Id: <20220726150609.140472-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
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
1. Command DB (used in SDX55 and SDX65).
2. On Chip Memory - OCMEM (used in MSM8974)
3. RPMh and RPMh Power domain (used in SDX55 and SDX65).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 5a5c772eedab..a23cdd352d23 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1070,9 +1070,13 @@ CONFIG_ASPEED_LPC_CTRL=m
 CONFIG_ASPEED_LPC_SNOOP=m
 CONFIG_ASPEED_P2A_CTRL=m
 CONFIG_RASPBERRYPI_POWER=y
+CONFIG_QCOM_COMMAND_DB=m
 CONFIG_QCOM_CPR=y
 CONFIG_QCOM_GSBI=y
+CONFIG_QCOM_OCMEM=m
 CONFIG_QCOM_RMTFS_MEM=m
+CONFIG_QCOM_RPMH=y
+CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_RPMPD=y
 CONFIG_QCOM_SMEM=y
 CONFIG_QCOM_SMD_RPM=y
-- 
2.34.1

