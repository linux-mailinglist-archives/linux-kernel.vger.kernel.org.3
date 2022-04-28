Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3275130FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbiD1KNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiD1KMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:12:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719B433A0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:04:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i5so6005244wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGhXnVH0ggOkw3OApNhk6r1wBoAuFoy4h6Is9/5uMkc=;
        b=eVRmZnZEGzasLOjDwCJhqMfwLwbT5pTUBZz6prR0DxyB7mVpuF5mXRRscz37OTa6Z6
         IWgu+Ynv9/cl2cdN4wSHOsVXgZJVCwTcuqwymlKwTuIvCSftKXKEsqQ9zbfpbJSLV5az
         hKI1onvYoOUpIqh1c5R75pCR06jDSYjWNR99w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGhXnVH0ggOkw3OApNhk6r1wBoAuFoy4h6Is9/5uMkc=;
        b=kJ9y0QgQdhciaYcVXDTl/BXkRdGHqgkydcLACgdNmUAq2Z8DrxCl1fdrRbzrGX3fS1
         AT4jTCLQdbEbxEIdV+odEfbuIJPnu0JbAbqeZUwZsboblTs1fKzJ0n9XlkoiCzMWsjbM
         227xFP8RYsIX66M9B1GYZWI+P+zAgodjPiVnhDc4kM/P0dYbWQ14neTl/gwnHxEQWGSG
         be5vHYI7U2rwytLvrr8q/vMjLq0+vriZ4mac4zepHFYiGBU/BZSIxQsjNjTq+iVdooau
         uknCZRKrlQdXE+/7+dwv7C2Uwa2bCC6gNY1FQCyKwQtu73uLrREcDT8yG4GxVUXk3Ydz
         Rkcw==
X-Gm-Message-State: AOAM532iJkXCjGdPWLEdQ3OFkx5b08moUdvyl7oVRawGSNu8v+fRCHFY
        zyFrr1xZe+pLnG66zLwsHV79eA==
X-Google-Smtp-Source: ABdhPJzjbUoBwlDopMyW33l1lxY0cYudO9Yi5cAIdOYzcQJ+ApQfht6chf1e6HDKMOFqWFP1chBB4g==
X-Received: by 2002:a5d:620c:0:b0:20a:b1dc:eabe with SMTP id y12-20020a5d620c000000b0020ab1dceabemr24962689wru.711.1651140271218;
        Thu, 28 Apr 2022 03:04:31 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0020a792848eesm15080449wru.82.2022.04.28.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 03:04:30 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Thu, 28 Apr 2022 10:04:18 +0000
Message-Id: <20220428100421.247471-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220428100421.247471-1-fabiobaltieri@chromium.org>
References: <20220428100421.247471-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-bindings include file for cros_ec devicetree definition, define
a pair of special purpose PWM channels in it.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/mfd/cros_ec.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/dt-bindings/mfd/cros_ec.h

diff --git a/include/dt-bindings/mfd/cros_ec.h b/include/dt-bindings/mfd/cros_ec.h
new file mode 100644
index 000000000000..3b29cd049578
--- /dev/null
+++ b/include/dt-bindings/mfd/cros_ec.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * DTS binding definitions used for the Chromium OS Embedded Controller.
+ *
+ * Copyright (c) 2022 The Chromium OS Authors. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_MFD_CROS_EC_H
+#define _DT_BINDINGS_MFD_CROS_EC_H
+
+/* Typed channel for keyboard backlight. */
+#define CROS_EC_PWM_DT_KB_LIGHT		0
+/* Typed channel for display backlight. */
+#define CROS_EC_PWM_DT_DISPLAY_LIGHT	1
+/* Number of typed channels. */
+#define CROS_EC_PWM_DT_COUNT		2
+
+#endif
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

