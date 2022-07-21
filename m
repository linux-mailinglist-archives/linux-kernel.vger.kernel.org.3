Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D410857D060
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiGUPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiGUPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:54:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9F5B7A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:54:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n18so3488600lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3Gu/8nTWxZTQK0cjVHFrSqiW7UgZie3lj03csp3tX0=;
        b=mF+QqxkqZLGCr7T+xMb++6bMhQsDSpIq9j6JdcP9lYiHHzrlmlhxcNaxCtSZDxMztI
         Xxyju4ceukGile0plauGzFJmBgTUzTio+0icnLN+57MwtlefBlXr3RyW0mknMl9gQJ0f
         pw/hfKNNEtb5wEMBCPXhJmvaKSKnnVGq4JIakXz7FkVeSyHqm12o7XvKTFJ9bkJHNuso
         gbPl0HPOomp7UI8C5dAtwp2Q7mQGJHn4dU+zHPadCaFyFIfen8mjTGl4nqPLUHE+acxH
         5PQ7Zmvfut27V9/wSz7J3o0nlCy7E8nWJEKMEFIzPTNV/+TcVJRD3Cg9hG/O+HrF+wur
         YJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3Gu/8nTWxZTQK0cjVHFrSqiW7UgZie3lj03csp3tX0=;
        b=2d5YHPXTZexhGTQvi4ylH9jS8teu69kOjoPaKGTV3zvPBh3hKjMAjZ3BZw49NiP1zb
         z/pyLR+JM1D7ccRiHy8cP7GawBpYq+pYp6Y6we2ZWSjkn7NSWzJJh0Ijv7G3sOrR0req
         UuM9zioiSIjThz8GK5EEKLQnhwkI0Ekg21utCPVwMG1q4WXsWpLuNbY+iWG8djSdj2KS
         CgEAcbZ3EnzheLBIua+2jr3S50HfURWL4iVBKve6Ch1cIezHMENNblq5ikKzyqh8PlIg
         /NfT+O1AymmLQN56Jmtc0kXbDVVRNn2+xnfOsNXmVHp1SDJ31tckGTsJGDS09VfW+Wgn
         4DPA==
X-Gm-Message-State: AJIora8Tt15yrQUMAxXLXYh0QwqDIeiiIOUJLlvt0/963zxwu49jrGEi
        MPHY6r4I6koum2dOrD3W1eMVHw==
X-Google-Smtp-Source: AGRyM1tOUSGEkCReki05uRPzSPQFqYt3xnhJnnwNEJ4d2eS1MYIsdJ2ptd1N/AHLmVrFt6SwuRknmA==
X-Received: by 2002:a19:f817:0:b0:48a:68d4:a8d2 with SMTP id a23-20020a19f817000000b0048a68d4a8d2mr1998741lff.445.1658418840954;
        Thu, 21 Jul 2022 08:54:00 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512214e00b0048110fd06c4sm516432lfr.53.2022.07.21.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:54:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] ARM: qcom_defconfig: enable socinfo driver
Date:   Thu, 21 Jul 2022 17:53:54 +0200
Message-Id: <20220721155356.248319-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
References: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
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

Enable the Qualcomm socinfo driver to provide some basic information
about the SoC being used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 5cd935ee148a..563a396bfb23 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -253,6 +253,7 @@ CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
 CONFIG_QCOM_RPMH=y
 CONFIG_QCOM_RPMHPD=y
+CONFIG_QCOM_SOCINFO=y
 CONFIG_QCOM_WCNSS_CTRL=y
 CONFIG_EXTCON_QCOM_SPMI_MISC=y
 CONFIG_IIO=y
-- 
2.34.1

