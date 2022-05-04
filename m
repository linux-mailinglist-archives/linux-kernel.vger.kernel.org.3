Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD5519992
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbiEDIVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346127AbiEDIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:21:32 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F822BDF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:17:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l18so1415807ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=O6GbIkgJZE5Z6glq7Iv2emVY00yo6pcgnwtnrebV2k4=;
        b=ur/0KL9Fhaf7eYBEvSL291bNaCYRN55DUwp8WCBgMYvdAcjjBUF1mB02qqKIsoAtHf
         +hDN/7Z004Dg4IywRI5N4h137KL0DLdcF9jO4qgsa9drkhDfIZiDv+a7WX6UBWXu5P2T
         0Bn7cfBL95hejAZmK3VTyU/GQuJDH9q+JR+wGB2GFDyw1F9FJS0L4rjTJFsmMMfIEK8+
         V3ccPgCQEblCxvfQgZ/vsKjfvrAE7rSyfvc5mIabMrgebJtwHj+CqeqvmOhqUCwy7CRF
         2Q8UXVoZjfzH7XkWGjI/VeSWCJPgcQ0GmuEK34h4mF+pFkUxApGiwRuga7AJJ6ZVo/Gy
         XecA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6GbIkgJZE5Z6glq7Iv2emVY00yo6pcgnwtnrebV2k4=;
        b=sL86G7+gRhO/GN9I5FqCnY3WjGhuCnNZBuvlnBKKNRczZVHzfD9tweKut/tJ62majN
         H+gIIr5ZX2s1PfbUGeudc0StZ9u8XazVCwE9WbYoloV6jcViujDuN68sp4HHakENl3VK
         jm0b+gC0X2My7zzhLZ9fsu5+lP+CWGnyJoP0m5/tVd0YJUP45E6KPTu5YWem55KtvMYM
         o1uzeOG2rNa01mmablxlSacJln4a6HONBjbVEt4gznPjeD+U0oy7gAUpC0p1k8pG+5iw
         BMbjMpeolXatAztu5v+Ddu4WoCudNPHTXtlrziPHUFGEzpRiuMP+lFs5hbcWpST5MGN3
         CmHA==
X-Gm-Message-State: AOAM533sq0ONtbH2thwYcuyU9K7IO7NLPDipU56k/Kws0cOlAQ5/644W
        6uO+rJgUqWPpbK9Qe4pzl0Nozg==
X-Google-Smtp-Source: ABdhPJw8cwfUkl3cLE4Gx+H/jj1KdfjNqfXkg98cWmonAuCaRjNsaNnMBDBwVQQSS/yKkpS8GHFk5w==
X-Received: by 2002:a17:906:c156:b0:6f3:9e3c:5cc8 with SMTP id dp22-20020a170906c15600b006f39e3c5cc8mr19000557ejc.17.1651652276973;
        Wed, 04 May 2022 01:17:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l21-20020a056402345500b0042617ba6393sm8781322edc.29.2022.05.04.01.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:17:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 4/5] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Wed,  4 May 2022 10:17:34 +0200
Message-Id: <20220504081735.26906-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
References: <20220504081735.26906-1-krzysztof.kozlowski@linaro.org>
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
2.32.0

