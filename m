Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F88514869
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358636AbiD2Lq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358599AbiD2Lqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:46:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5729F252AB;
        Fri, 29 Apr 2022 04:43:36 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e24so10413219wrc.9;
        Fri, 29 Apr 2022 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8OkAwRbkHWcFbANoUbxBUbD6cV4qvLXIuN4HbbAMGs=;
        b=Ut1dlQTh4t1c+ch6/VG1doi1BCn9s5DjSLJp2RkSj4rpQ16ngBJEaOA5tm9IO4oo5U
         89l3qqVRK2PCI0vqycKRPuD4yk5zMibBIjf9C/MGFsSkLsgI5nyqnE7NHNvm1Yog5+DM
         W4jgiq7dwp88dsP9MeHbHmPP/jy3sW6RDCtQ1va8NxMmotTGV8g9CyVstkKoNz4ryetp
         /hjLSECGo6tX72hCzcYx09bXn8MWtRDZ3Q0eh0KPJr+GCYad1GvKoGey7iXTfFN827IL
         dakKOcKLeedLDMw7wYrJdJ5qJAkvabFOijIu5falxMpDK3oMC9eltOEvHmrl3+f+l4Gc
         5P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8OkAwRbkHWcFbANoUbxBUbD6cV4qvLXIuN4HbbAMGs=;
        b=0Js/e/3SnGDP7FwCCQHO1tCPWPmIOBw2mpSuqkgzwK7j15E3B3SxISWwhf12i9KacL
         6hz9YTIzG/q24bIL8qqieC6RgocLf3EwffvhagmXnu3MLYqW4t2I3XYkA9HkvdMnKxQn
         ywLr5L84+xL+ZbgC7aZ0/FwGUETIyaBvjE747eIPn0h/KAyKCsknroUAeQAtwZQ3+PyD
         KU2DwLKB1zs8DK/+Io6nh3apnNOa2cOp8N+5NJSSei0xp4uLyTRyWN/817XenFLZTX8A
         x7j1Tcjyr22dbwz6DRhzeAKmU5GhR5lPTklxmjbnPCNVVsHe1pkoLmRvjvwdqEq4rC5m
         s8QQ==
X-Gm-Message-State: AOAM530wQGTft/JRgkzeR7ue7M7UPvPGblpZCTmkgKQv/MVJ/ExX+njo
        OjJ19UjJoXSNnU/Vj1zRZIQ=
X-Google-Smtp-Source: ABdhPJwaMbSZi7RDy5+PiQ0JDW5YF7MWEubEQcP5zGT6WmDaJN4YKChkvRDEsNdTZrPNxUbZCBrN9A==
X-Received: by 2002:a5d:584f:0:b0:20a:83aa:ad2a with SMTP id i15-20020a5d584f000000b0020a83aaad2amr31244602wrf.610.1651232614808;
        Fri, 29 Apr 2022 04:43:34 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-183.xnet.hr. [88.207.99.183])
        by smtp.googlemail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm2990900wml.5.2022.04.29.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:43:34 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/6] clk: qcom: Add DT bindings for IPQ8074 APSS clock controller
Date:   Fri, 29 Apr 2022 13:43:26 +0200
Message-Id: <20220429114330.59026-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429114330.59026-1-robimarko@gmail.com>
References: <20220429114330.59026-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT-binding for the IPQ8074 APSS clock controller.

Signed-off-by: Robert Marko <robimarko@gmail.com>
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

