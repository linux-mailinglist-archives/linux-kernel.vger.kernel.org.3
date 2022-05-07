Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8851EA1E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387371AbiEGUkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345154AbiEGUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:40:14 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A756D1401C;
        Sat,  7 May 2022 13:36:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y3so20088413ejo.12;
        Sat, 07 May 2022 13:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTfXR0xPMf1GwhzCgPtnYbCFhGYrMS55yt3GLmdVE6Y=;
        b=nE3hyDr/dmSO1jLuH3Q7369AG/hxuQ98kISyIjkiAxQ0GNB2/2rVyXOtT3WUnbNsWE
         sC2eSiVuVFBcb+rPuNwzBCBQRG8MEHi2vLOQIaPrhHnmmoUPD8ScJJq4Kdv1vpP9fZF7
         cw+GCxumvdNLSsqpCFLk2htR1YSd6TdQvTOC5x//X9pE7GzvzYiytFLh6orwZ1nskEG+
         6qLh/r/aDCShoOzTjhNi7aeZgIi8v/5cWqvFW6xme+Wxf7oVeh5SIUC9Cf70fp/02ZbM
         6rmVBuSJVy7X5U9xaduWfIgAR6EpJlur6F3Jjghh7XGOfAnuuTWZupP2/95TGFPjVBb4
         hpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTfXR0xPMf1GwhzCgPtnYbCFhGYrMS55yt3GLmdVE6Y=;
        b=qTYbswABQTzdI6+b6JdXCYn9fs9xhr/zuvqnMf+4yovcNgQeLfKnJIOv0rLvHsSIca
         5WNUHr/B80fjfyKdIDbBU/fy2i+SWJ+kU2TGx6g71v+Ugy8zIcPoqeuRHJx0iUXJ0MIZ
         13ghzul0Mh6Wr6xpBaRJ3r5H18bANoU6o9NT+dTU3DETqi+h/sTOMGJGCEPmmmUqAnFA
         mj43rEJdcAnFWOxdatmkxupsT7Um0Z+aLLGX/hnxKpzu9wpypEBvBrQ82Ennia9B+oAH
         /MCJfiqzJsd9S+XdXhKpNIZ3TuRCh9cpNMgPuuRviSUCysg1pP7w+lfEF5dxq6Ln4nz8
         gkwA==
X-Gm-Message-State: AOAM533HWagqPmHrKxdKzmkZiMeIFtClAPdrj8GqAYAvDdnK7l+DWtm6
        FLgijuOEwcQlpxJXkQAOLbgCCo2d14lYgg==
X-Google-Smtp-Source: ABdhPJxuG/q5Bd5k9ModQiEN1ygyUaknJ4C5akMeIlhG1GxwD8sVb/K2s1MUaPA9XeWhQRDxoHwQfQ==
X-Received: by 2002:a17:907:3f26:b0:6f4:dc59:3cfe with SMTP id hq38-20020a1709073f2600b006f4dc593cfemr8602191ejc.528.1651955785253;
        Sat, 07 May 2022 13:36:25 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id eb20-20020a170907281400b006f4c557b7d2sm3283456ejc.203.2022.05.07.13.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:36:24 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/6] dt-bindings: clock: Add support for IPQ8074 APSS clock controller
Date:   Sat,  7 May 2022 22:36:16 +0200
Message-Id: <20220507203620.399028-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507203620.399028-1-robimarko@gmail.com>
References: <20220507203620.399028-1-robimarko@gmail.com>
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

