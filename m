Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A285601F8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiF2ODY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiF2ODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:03:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF4A2AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ay16so32820741ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=LpTe8FwbGqoJk3kp55roOlCrBzmDsqfQfEEnkukpAMUNhc7DbkjRgZNPwX+l0QQkkz
         fC1vx/rdx2W/KvSQhvCPQ+h4FlbFBgf1KGcnPkCjJXL0jBYRjj2jBRnmQqcRMewNGAjY
         WqG7rsCIY9zhb76+J8IgubIXntHkptGqlj5r7XWp0/FQILr9cF6EMLUSrEtI7lQjl0hx
         wjIrx9PoAorST/LcOZa/hDg/moypP8Al0lKRURaW2LuPj0Vy2fxUzDzT1P5uKD1rtbat
         vpKvkt+KTWXmFj0czDmNFgCmM9MMvyeMxyk9FR9HwGTmZO5p26+kqYHMcRIpZatrAvtm
         N4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4c6eL6FkT3F5Q2UMeh1SdTOW/jzEthp0aJ+P51R6LI=;
        b=ipGmwAS/pXzytMNfygcEFv1z52wuh3se0sRu0FppJ1WqpgoEmuHMAWOvEd4ODEHfnj
         2t3iRjXREuf6IWlsmF3oHq3gKYqOqEWe/WJR7hX77LbciiXxg6AYPIqSm1eHYxb/ZeKC
         +YqXgCJN0KZZAlgIv2gcMUzK3Lcs9Z7lyM1PU5DTKmgBMmBnBc0tRW/FSEY69Dc4VbL2
         DgZgrytzgzTEdZosA4QX8EqAjh5FFoV0PhssCQUTDkEh1i+5hazPp0sjzjBIS16XGE4j
         HLxJIDjaksShRmezTNSzSh+PRM4Xm6Kq8GmYEX6M6pDSzR+xLu5nAVTDqz6ilR9LqNc9
         R3Vw==
X-Gm-Message-State: AJIora95hfmzd6mSKNdV9ZehrwbL3+QYDwo9jrP1EyvvURDm2wS/HnI5
        WTofbqOf/R9mRfvIdFSnAilgRQ==
X-Google-Smtp-Source: AGRyM1sNztz1JnKP/6ZDYjEJBjoxKO1bZe82BqAsqvrWIBBxeUjTqGe/5xmvjaKXNMpTIuftgCMh6g==
X-Received: by 2002:a17:907:1dde:b0:72a:4bc2:1625 with SMTP id og30-20020a1709071dde00b0072a4bc21625mr380829ejc.144.1656511390545;
        Wed, 29 Jun 2022 07:03:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090660c900b007262a5e2204sm7739260ejk.153.2022.06.29.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:03:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v6 3/4] arm64: defconfig: enable Qualcomm Bandwidth Monitor
Date:   Wed, 29 Jun 2022 16:03:01 +0200
Message-Id: <20220629140302.236715-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
References: <20220629140302.236715-1-krzysztof.kozlowski@linaro.org>
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

