Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1B570149
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGKLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiGKLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:53:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9E27FF2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:53:03 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p9so4619032pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=s5dcqRWSlosu1e8M9/fVT5nKfHLvHBK+rQ6J/HdOtb6Y2X2HeVv+hqGtdaGoh6HSIG
         LqGKJMUJ1zeZflUMxjH8mHPVeYueKgstFqFI6OfPQDQvNK4cjMbaIjLzSz7JCggnLVZE
         TSQKgR2l514Q+dvxzAwh8wg+f/xLPdkFQGLNFIVM1+bwyky+QHbphksjwG46KOZFpcfy
         txvT5jx7bz4kzFbq/tvU+ohYT/XcjXAAUzxzawlULQybZZltjxOLgV4oyaxVX3n7bDnI
         bHCmSrhiCB4XAPVlRZygISycj/ELdXsI6GwlKkWLmuu2mWYy4x/UBXWdyujcWU5Pw40A
         8T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=SBMYGVOz7zkhRQqvat/4b3uUwAaqSVS+Ay9wWQfxPEEsWuhJYKWq5APuGS7VuA5BZt
         +vM/0l8Wv6vrMYqIgWW1Y66srCgRtrS0ruWr+v2HpjanqAD50cZP7ToYqyAM+XFX4l6V
         iqI4FM36ujSR0FrGFTCqqCAvvW/aeJIxhcEfT7+C0Bhh+8xG0NyPwzJ7byLc0WnjM0Uz
         hvGwg+eOXag4TkuK+aGgkW+pODutrfbt4Insgwdw2ZUNzoNLczf/AnG6jtUaf3rZZH/4
         wUrSG4QV8ciV42L+frbzU91yNyfs3TVrcgWlvtPcsKJI/OWWV/3FgRsrtpbh1UT1doL+
         Lq/w==
X-Gm-Message-State: AJIora/N8nAZ1UjSHDX+4MTCqyfDnLLTjeABRIFp6PaDyanSwZ+FA9JO
        AMhn87BlyEN3K5sDXy7d6qU38Q==
X-Google-Smtp-Source: AGRyM1t6aFVY3r0VNymzVMjKvxvVqlSEkc0YFirDUP1yxO8qV/3K2bSWrAKW2vW81hqGGkJLt0RI8g==
X-Received: by 2002:a17:902:e5c6:b0:16c:413c:fbff with SMTP id u6-20020a170902e5c600b0016c413cfbffmr6790571plf.62.1657540382458;
        Mon, 11 Jul 2022 04:53:02 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090a648e00b001eaec8cea55sm4586502pjj.57.2022.07.11.04.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 04:53:02 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 3/5] interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
Date:   Mon, 11 Jul 2022 19:52:38 +0800
Message-Id: <20220711115240.806236-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711115240.806236-1-leo.yan@linaro.org>
References: <20220711115240.806236-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit changes to use callback qcom_icc_xlate_extended().  This
is a preparation for population path tags from the interconnect DT
binding, it doesn't introduce functionality change for the existed DT
binding without path tags.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 7e8bcbb2f5db..8c9d5cc7276c 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 #include "smd-rpm.h"
+#include "icc-common.h"
 #include "icc-rpm.h"
 
 /* QNOC QoS */
@@ -414,7 +415,7 @@ int qnoc_probe(struct platform_device *pdev)
 	provider->dev = dev;
 	provider->set = qcom_icc_set;
 	provider->aggregate = icc_std_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
+	provider->xlate_extended = qcom_icc_xlate_extended;
 	provider->data = data;
 
 	ret = icc_provider_add(provider);
-- 
2.25.1

