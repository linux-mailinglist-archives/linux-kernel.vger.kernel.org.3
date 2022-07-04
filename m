Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD465650D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiGDJcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiGDJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:31:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20561DFAC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:30:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so4841010pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=mgBMEF9ODZQVkR0YPeFmJcFby++vP7ojHIFMqqx+DvfqjT3kpW7KO7iLyqperK/CUo
         x5+4XGTli0eCQ7UpSlKIG6Vh11JVxKp+qdGHcJ3cugE8cED5ueVouaMEdauKYMUDdq3t
         ZIV4UfGY7+yK6GmAkl8Og/F7HLgQSfPteSH1iMU022QTtbxLhHQVcgxXKYUIMdO4Lv/0
         sabtJLaaz4PY4P1dMf4wFa41IvycwjsLNxxDz0pIl19K04ISQ1lfm7O4wQKQDinJwX6J
         3z+VVGQ/rBdZdmkOqVWcsW3d0ymOWgNzuLxY4UxkqJl8K3yHLVX9Hls/i9Zec++XaVFL
         iOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=hICEyEX98iugWkPnu68DAxuWr4sRDROh7YPMsZ9iOkX0v36NgvZ7AK0WW1t1fPMiAG
         edagiYQsRBPZQww+xJhUgDhoEV8FowjsXIOusJ7pL2j1br2i5FsjD/zI7ySl8Z30rXxh
         Ngz+kmSMr+mm4scgfKssCOISW9c201dNx7cIat6X6HgoRdEGoqYW0OxzVtaibivV20bn
         s38W8mI7zQ1dmuVRvkKuyi63A+bzD3Y1cbZAxTmo2Kn4al4DMMq9NM8uJfjHFMRnlwn6
         2Voat6iFfpg/mufPfACcTtkjiyKu9fda9yd7gErcsEKSdgepANa809QLYJkxF5+gofAr
         aUUg==
X-Gm-Message-State: AJIora+of5S6wJTE6VneMkdJf5p/CiOeqjgJ6ehIWx0RdeMvfRWPmApO
        4R0X09TRFVzavGsDl+nFuonU6g==
X-Google-Smtp-Source: AGRyM1sdnDHSYRH4NlqHGYzbbvTM5xpNo8iXR0ZGdgHks69aGD8NIipFy0fxwGyfLgMPdlHQS0nUhQ==
X-Received: by 2002:a17:90a:e391:b0:1ef:83c2:2527 with SMTP id b17-20020a17090ae39100b001ef83c22527mr7387822pjz.94.1656927048045;
        Mon, 04 Jul 2022 02:30:48 -0700 (PDT)
Received: from leo-build-box.lan ([154.3.32.171])
        by smtp.gmail.com with ESMTPSA id ms16-20020a17090b235000b001ef81bac701sm2926177pjb.42.2022.07.04.02.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 02:30:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 3/5] interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
Date:   Mon,  4 Jul 2022 17:30:27 +0800
Message-Id: <20220704093029.1126609-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704093029.1126609-1-leo.yan@linaro.org>
References: <20220704093029.1126609-1-leo.yan@linaro.org>
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

