Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2265518D96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiECUAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiECUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:00:08 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953D13FBE1;
        Tue,  3 May 2022 12:56:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gh6so35513254ejb.0;
        Tue, 03 May 2022 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTfXR0xPMf1GwhzCgPtnYbCFhGYrMS55yt3GLmdVE6Y=;
        b=TqCJPmQv+Y9x8pClvLoNB5xM2gTnrsP3TME0h5TS3nFqB/PdYTG1/UciEAVcXqpWiS
         f01NtXOMx6A8/LJCN0IRQ7LjbBwcowo+2fZRVEjqF6KZYLvBa3o3yJHBXE8kzKbb2N4L
         Bgt6kg6Jk1wDS6f1YNTZjQmTc1+zEg8tUmtzyJHfiLoKqfln8Co98RZSi5PkeXKiSStd
         c1yWsqYlFxrZmBoT59Q+RAQOGBiGPJk49isDrQozCCx6WJ/eUvLZ9O3sQoKBGJuKHW5j
         JqhtgEc2AeYP1DwI3wk21OfQj4b1o4uA4j9jUbabX8m8WKPTiG6O8qSean34B+n7Ttfg
         k3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTfXR0xPMf1GwhzCgPtnYbCFhGYrMS55yt3GLmdVE6Y=;
        b=AQ6bZrffpRyUUm2gTKRPFP/Fl2g5aRSN9eRcRi5SN+MWHKosRQypuXMt7Pc0wsL2xe
         AvzQF/eOMNKdiSyEn7dFaKN7GE3XKiy2MW0Y3uNqnzimvlnz4XQdLoRrpwxRa7gGAMIL
         CfNkRiaHEuUJ+iLyhyy3cveUhkGXUAyaBXG207Slj68byxpTnGpXzhzGIYg4fGgKlEPZ
         UKCPHJFYKJbH16ZC/1gv+7Pkbd1TWlWYU08mG5x0k4GvkQACRKfHnvkDkzegWk5ACIkF
         owbz1T1H6rbaU3zyaTGtX3f5oSZzVlvhNJD4ONixyT9ggTSZKnZuDryyaIDdrC0F639W
         76Xg==
X-Gm-Message-State: AOAM533LdsdOrNRpVYkr7HCgmOgDpzutUHm/SgkjEiB8aQgCFsQPtPM6
        cvdXRUng9ycwDp0U2QwkHr4=
X-Google-Smtp-Source: ABdhPJwSgE730HjvEIp3jz9m3z46PaYLcSFPYfMDS9A6brHG8udSJOjYj8eNgfnirC6sRdhltCn4xg==
X-Received: by 2002:a17:907:3da2:b0:6f4:78d8:7c23 with SMTP id he34-20020a1709073da200b006f478d87c23mr6358986ejc.233.1651607792997;
        Tue, 03 May 2022 12:56:32 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id i8-20020aa7c708000000b0042617ba63absm8229270edq.53.2022.05.03.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:56:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/6] dt-bindings: clock: Add support for IPQ8074 APSS clock controller
Date:   Tue,  3 May 2022 21:56:01 +0200
Message-Id: <20220503195605.4015616-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503195605.4015616-1-robimarko@gmail.com>
References: <20220503195605.4015616-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding for the IPQ8074 APSS clock controller which provides
clocks to the CPU cores.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Correct subject
---
 include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h

diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
new file mode 100644
index 000000000000..df07766b0146
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
+#define _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
+
+#define APSS_PLL_EARLY				0
+#define APSS_PLL				1
+#define APCS_ALIAS0_CLK_SRC			2
+#define APCS_ALIAS0_CORE_CLK			3
+
+#endif
-- 
2.35.1

