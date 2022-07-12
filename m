Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6D570FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiGLCAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiGLCAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:00:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1150C7CB4F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:00:09 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id j12so5984205plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=F7+XFiMayv44DZU1u90VfmYwY2lDY3XtWAg/SoBU2WdqVyiRqfO/MK4aaA1a+GI0/i
         AmRAGXmSTTBOoK9G68DhJMLf2LH5i2ZPgg1ZcJ9l8O4zoXXwlMax7YFxoVpAqECf7KPu
         5J2urz5HU8UqQUxKjcTQFiQG0j2/LprbKR1q0RTjYV1KSsRgWb+yEq6q+YNyh9ji2xkM
         1gJQ76pT7pxMceQVrA2rBj8S/IJ9brmRVEAmTBgF73GRbqqZF0GgSMEmXMu139/kcVLv
         3ngBg477iXfEe8EnSzzjpGr9+wJ4EK/tqJNFH6sfIM1ZsWtqj9RjLiUxhCns9W6b8XQ3
         6G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+gYIpHsZ47Eh2pxDFNpWAcmAPIFH2rD2QueXVUKLjQ=;
        b=JPC11SCyux5GhmvM7z3/Z+NGtGiEXFw5BKGSsvbn647437+s+TvbEqzeKHrg2RkGai
         k2dJlEkec7K+gP+IeXdKJ7INmnMlkIUtWRVFuu4wfvUQeigc/FpdjO13JJwAGfxXhW4/
         ML57jjxm5w3GN76TrcJRAkcFL/cnNIMa+TvxnlkRO81UjBwHtQmlVTP6fGywannqcD8b
         8PoxV+Hv3s5Sbcsfrg8smzIGXqo67USiozFANbg70JucI5MtfpMxA1OtF9s0tpJXMMJE
         RS2qGN6y/nAVTzWfuX0ZnpYLQ3vZLUsRA5orGdYgHBIQ5yama4DHpDdHMAA28viKCiJZ
         yM7w==
X-Gm-Message-State: AJIora9m4kdFv8muUqTL7adDakhxK2tdNrVAbqx242cmL0YyeaMqGMTc
        bKlxMSjKbUzuqPb+Cta3613KVQ==
X-Google-Smtp-Source: AGRyM1uVTipl6JQXD+xSwYRPGggDqLZ8DuA4ILpqrtlHnYeSwS/6TqN+dBNg+DMSiNiVAunngq9YZw==
X-Received: by 2002:a17:903:1210:b0:168:dc70:e9d8 with SMTP id l16-20020a170903121000b00168dc70e9d8mr21845995plh.92.1657591209040;
        Mon, 11 Jul 2022 19:00:09 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id x5-20020a17090a6b4500b001ef76dbae28sm5425821pjl.36.2022.07.11.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 19:00:08 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 3/5] interconnect: qcom: icc-rpm: Change to use qcom_icc_xlate_extended()
Date:   Tue, 12 Jul 2022 09:59:27 +0800
Message-Id: <20220712015929.2789881-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712015929.2789881-1-leo.yan@linaro.org>
References: <20220712015929.2789881-1-leo.yan@linaro.org>
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

