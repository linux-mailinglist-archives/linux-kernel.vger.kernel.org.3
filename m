Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E920358208F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiG0G6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiG0G6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:58:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6634D237DF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:37 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p21so11154033ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zf+Atw6W9ce++rwB/xGOClK+4e2ERQWgmlZE86UF1IM=;
        b=pWEXfRpu4h+qdx1v4koHmcFO0UMlVVqZfQOqzNjlU/ITs69iC5dpx9CDW+pSe0DwUz
         Q+clVhbX0xpJI2x15bh5zNWqm7HPA6yA+mZEypEHjhGaMV7Mq7vi8KDLgFUCDXRux6Xx
         2D9kBDMzqPGQRQuPEB439yBvroL1T1Za9HvrtnaB+NtPfXxqIQ5PJDGqN9h3VvlUei0n
         Mz37Ee1DdolFLG1NPcFXpzOoFxZdsYcNfcxKJp4rVFQHZdLgQ3bl/WnwnAS1065xck8q
         OJIFHShXUjEuBmHCNRTFElC8vzFZrkVfxK2So4lNBOOeOO+t10U2Bd3LwUH9FtNypW4t
         BvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zf+Atw6W9ce++rwB/xGOClK+4e2ERQWgmlZE86UF1IM=;
        b=q2+Q012ySYaRm3UFHfVWubdoGjeUjLZMB0KOvYfkLw0JNC/85kEJ7ilHA9bREa2UOh
         5ThNS5VMPSXpCk6196qel2pN+LfYvkfeoVWFwqEfpghgQK3ONM+pBK1CFa63amoGPPu1
         gWx57BNRXW8H7Rrtdm1bqOnvpcCMxu8zc0KCSA8+shax7b0tBdcS0qn5BrilNbhQG8Ta
         VBy9DbyWCME/AwymEgZqI6jke55N9eeHAT9fAAYgr0CS1oN0NV1kfNEV6JWe1htgh/F1
         aq1qWJ3eHOpbXG33mX/4P147kRHHZ0UNnOoXBM/SCtdRbyAQHS8qL9O+tmJ1p0MYcCq3
         A0mw==
X-Gm-Message-State: AJIora90r7xlPW1KYGST7F28pI/LmHvgFpyt4K5G9Fbdmx+r/rYigNs9
        zAJUfqOTqwLQ0SbqL9k8QbWPsW2E6mkbMjKM
X-Google-Smtp-Source: AGRyM1uoZKDq+iMybJKb7vij/n3rKU9b1HMxqMPWDCzZjTtM1aIne7HA6CGk30k+0G/F9/mMIf5JtQ==
X-Received: by 2002:a2e:b88d:0:b0:25e:5aa:749d with SMTP id r13-20020a2eb88d000000b0025e05aa749dmr5142163ljp.48.1658905115779;
        Tue, 26 Jul 2022 23:58:35 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w29-20020a197b1d000000b0047f647414efsm3623827lfc.190.2022.07.26.23.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:58:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/5] ARM: multi_v7_defconfig: enable more Qualcomm drivers
Date:   Wed, 27 Jul 2022 08:58:27 +0200
Message-Id: <20220727065830.10681-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220727065830.10681-1-krzysztof.kozlowski@linaro.org>
References: <20220727065830.10681-1-krzysztof.kozlowski@linaro.org>
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

