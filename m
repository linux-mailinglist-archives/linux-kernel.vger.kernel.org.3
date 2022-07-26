Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17752581603
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiGZPGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiGZPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:06:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408B2ED5B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w18so5758991lje.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T3qVhbIcSdGEti9fhWWV+LyyzVsTFGP7Y5rCFSxl0MY=;
        b=hU70+XV+SD7FBJKv+w+/xF/8wK3fuWKmRSTRT7EcXtFTZUEzl3WzxysaiSCe50c6cm
         39XCYdoy23iwsU+kBwJMYWM1k4E3UpN9XSAQHHpji+lMgtRDX/vSKwMQ7odmGlqv33On
         2M3epAysVBPvOc72YqLvV0TjVLquLhzWM+LYNsNugO1r9YnsfxqYq1f44k6qxuKU66A9
         QKIpVtlhMyDWdu7GEdDdxE9ae2ZKXKLL47AYMHCpF80EYQxVNM6ZSU6lh8ClSKWjo8xy
         aU2Ba3qYNvjBu53MYTns3/EXhYHCWlqXw18ArrS6KO0KV97jeulkm+de8VB54UNbwugs
         NUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3qVhbIcSdGEti9fhWWV+LyyzVsTFGP7Y5rCFSxl0MY=;
        b=R4ZGkZLVQppVbyWgpfz5+0DoqDmC6e02jEJlHINXl/pjA10t1d/JyZwmM9IWcjOZOt
         GEfzPdvZsTp5T6Zm1UWE+Q6i2+8VQP60OUi1lMG7IBmPBZpSPA/awgXAKbpub0oxS5+P
         6Q5TjxU9WDYHNBVXgEh9zXrsXmLFUqpu78CWeQ+/qp53d5Fc7IeUx9xgsqwfUmbOs2GT
         8GCJY7KH6Dzw4g4Za0RKZWfwhErgZT7iYnLvviXGlarBohx9cWRtWkvg+P6GD6tC6GVc
         ekdan9MFnSg8b5JQAoR1ixae937ttEoVOVWUiNuvcOlLArqAnk8FJn/5Ofz4JAaX8XHw
         ouYQ==
X-Gm-Message-State: AJIora9bv7dNeUvbW/K2BXMMNEYN7ZUY0gmYRYLuK6M8CumKagqKgQwN
        XclIf/DglDEfvgp7Gqj5cDuLQg==
X-Google-Smtp-Source: AGRyM1svuo1ptN5wfF9GyHVO/RM9Zxn2Goc/QLcCwSCUIyknguy5NeQKHG+1gqBP+xh8fdpdf3XBbQ==
X-Received: by 2002:a05:651c:1048:b0:25d:d77b:16d7 with SMTP id x8-20020a05651c104800b0025dd77b16d7mr5846614ljm.60.1658847990976;
        Tue, 26 Jul 2022 08:06:30 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id a26-20020a194f5a000000b0048a95c16849sm836620lfk.282.2022.07.26.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:06:30 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 3/5] arm64: defconfig: enable more Qualcomm drivers
Date:   Tue, 26 Jul 2022 17:06:07 +0200
Message-Id: <20220726150609.140472-4-krzysztof.kozlowski@linaro.org>
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
1. Last Level Cache Controller (many platforms supported).
2. On Chip Memory - OCMEM (used in MSM8992 and MSM8994)
3. Subsystem Power Manager - SPM (used in MSM8916 and SDM660).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

