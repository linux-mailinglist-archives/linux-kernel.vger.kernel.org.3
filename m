Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69525561AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbiF3NFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiF3NFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:05:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2EE2018A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:05:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fi2so38839606ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=Ht0e+SQ/tCfndvpNkgtbEAxFUR+Y4eT6IQr0bXtoJSTLwOg4dWylov9HyS2AuiM7PZ
         Dq/wGvA3vP/H2IueyBXSIXjV3rRhcDsj7osW7Wmjgi6qPqL/6UZMqhyIOySqhWjG+Q2W
         /RN9XPCJZqU1CEmT5/bNu33uANM1H44hB42LR39bCAZv9Q70L/aRQXrg5sZxU07KcMur
         BrqWtoReRMvMLLHBRljJXFdZgrn2iGxUJISZe0X7U8v/E/QJpQMdQlVuVvqD5bQnXkUx
         KYMR/vlrVzvmwW2IH+MJAYevqH4Tv0elNvZiAvdlhn0sksjJ9nIybzK/2vLYlQQiw3QM
         WTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=09QTbPEP73tjW7mTmjOj0eVoQuasGh2higJhfNncbNji6MSXzW+Yyekx8sH0CI7ht0
         rAN8+QUjMUdFvMsNX908ru6J5qhqIZpRKPLsm9zNhth+hAEP2Y+o5JwTqkhlKRNgU2TT
         1wQtfMm9I5ZmJ4PDSPPG31Gh9wBq24BjP1Zwde6m0SuHtM4obGmqGU3YCdzbloYvb58z
         /BK1wOVDXOOzMbN8qzCGsTd0hUjLW/ABrFMeoRtYUM2+5R0kXCJ80XIMwyzULOyAuRs0
         ovjmJj2N601qu3MO/ktIojmbC5G025Lkct/+wjDb1WVsfps9wVuL6PFixt4vGon5DzD9
         2aIQ==
X-Gm-Message-State: AJIora/l80Az+LqMCI5sHCgOvgYXr9+MV1Ue18moluEs6TwUutGO0CuW
        bOQHvFrO9yScjP/EgN3b1BskSA==
X-Google-Smtp-Source: AGRyM1tIVL9qS0sBInJEGGVapTnBwdlvN6RbOEoTWUhByH5eGquJtssMpnBzJuKe5zxa0HrFiU15Vg==
X-Received: by 2002:a17:907:2bd6:b0:72a:3f51:8093 with SMTP id gv22-20020a1709072bd600b0072a3f518093mr7111316ejc.134.1656594348758;
        Thu, 30 Jun 2022 06:05:48 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm9124967ejh.76.2022.06.30.06.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:05:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v7 3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Thu, 30 Jun 2022 15:05:40 +0200
Message-Id: <20220630130541.563001-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
References: <20220630130541.563001-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Qualcomm Bandwidth Monitor to allow scaling interconnects
depending on bandwidth usage between CPU and memory.  This is used
already on Qualcomm SDM845 SoC.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6906b83f5e45..6edbcfd3f4ca 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1096,6 +1096,7 @@ CONFIG_QCOM_SOCINFO=m
 CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_QCOM_APR=m
+CONFIG_QCOM_ICC_BWMON=m
 CONFIG_ARCH_R8A77995=y
 CONFIG_ARCH_R8A77990=y
 CONFIG_ARCH_R8A77950=y
-- 
2.34.1

