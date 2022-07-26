Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63520581604
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiGZPGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239507AbiGZPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:06:31 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A6321E1C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:30 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u17so6674048lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WBC3cRdwEN7IaGLoOBMSBVtCWphr8Vu53IZt/e5uLb4=;
        b=gfvUgBcXnaPlisQypHUGVgiFh92jA0TJZm+r1c0Af6MhjQAx0jgBGNINZMD7FroG50
         vSjQbCb6h66z8yXOxnLi19zWBYgsRIYILTzPh28LcuxhdvVWRIRFw/mqlWsmIELm4BwR
         JJoVH40ul3lchXKfEvmcQUPxzfey/ZuC4qx0Cx5E1DSfSrmpmwc6FJpUCd61L85BS7b7
         kX7qfRc8uBvvuLcB9VD+pMny29mPQvDuQFTevLn/BD5q9mDOdiEaGgWrXole+EhQ2TwN
         nkTZ3Ha0J6UKkUrIHKGcDod/k/7yojy98mUYhKJSBf9JBmvSi64tW9tEbNj4P/KDIirP
         I6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WBC3cRdwEN7IaGLoOBMSBVtCWphr8Vu53IZt/e5uLb4=;
        b=iTFXKeYa1VkOtQh4nEq5m8OGx4iwtyCLLJNhZel4niU3IKtYbrfxJUqvLFIlYxD1b3
         kmAgvQzOvfxuM235neLrbDICPqGtwxYzU7Vwg9DokzuMBh3gugoa2H3wMed7GPG2GL13
         RZyXEfmRGm8jWOsT0FYyw2taYI4Nkp8mC6+EkWApcypwUasgU63yfgI49LZIlzzYKRBi
         WcNbzpMXySzLZR6cbXa4Q5Kqq3xxSOiDVqaDTQRyrylrTh3G/Y9EGxx3hi7iz9LE+NQv
         yy7QBXJPvvEPNsSsItH/x+7WA9T3NdPNHDd3uVIZb/x20K9LkxacN6Rxl/Si/HTNEvB5
         B/Vw==
X-Gm-Message-State: AJIora8QQu3i3L0OBMfXnE2upOWAsx7f6paNzTq9gHPGjKFkIH87lrlS
        wrgqNrz3CF0xeSHQzCOxS9J22wpzS+w0uw==
X-Google-Smtp-Source: AGRyM1sBeBGwlBO9329JOEZxYQV9wcAGYvHQS0fNiqZpVXIubAH9sj3pu08Wky4kb9+pouED4NZwUQ==
X-Received: by 2002:a2e:7314:0:b0:25d:d79a:550c with SMTP id o20-20020a2e7314000000b0025dd79a550cmr5689036ljc.260.1658847988470;
        Tue, 26 Jul 2022 08:06:28 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a26-20020a194f5a000000b0048a95c16849sm836620lfk.282.2022.07.26.08.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:06:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
Date:   Tue, 26 Jul 2022 17:06:05 +0200
Message-Id: <20220726150609.140472-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
References: <20220726150609.140472-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5cd935ee148a..f02448187eac 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -247,12 +247,15 @@ CONFIG_QCOM_COMMAND_DB=y
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
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
-- 
2.34.1

