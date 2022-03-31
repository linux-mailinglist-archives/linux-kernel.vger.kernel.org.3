Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C84D4EDA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiCaNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiCaNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:00:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149914EA02
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f6-20020a1c3806000000b0038e4a0fc5easo862092wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9w3ZU2FP1Rv3cljPhXS0CpszxfyekTzsqMLGoLCCSm8=;
        b=llpzdZ2QoUIy9Tl0HxXnxvtUoVjm9IgVG5PX86hpKe72UlB1I5Lq+qPkd3R+eHJoA2
         EhH3UJig8Z4xLiD+fmzidq5eoc0HkacxizCfKsEm2oLn90plB55zQ7pVM2DNmlvkKDI8
         RcyFXcCbhcSlE+Rq0X68yBVT3e6e2TbkzwYts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9w3ZU2FP1Rv3cljPhXS0CpszxfyekTzsqMLGoLCCSm8=;
        b=hT3ZGqpB6svEquiGr2m/32BJAr5ahIJmh0ejGbHRBm19wRar3vgC7mWpl0Dv/EHQu0
         /mFXvmhhGa4IXBLDLBV40ehbca2LdPobo8Z3WBoVHwVs/cpX8MiGtDC2GHMnEczv42vf
         eVnTkiytO8kTHKgrZtbimG8GGCSA5cTNYXSdhiYp8lqVNkeoKjGuOFmd1fSaXLVhT7WK
         eLJEZLZeyNMpwQEMwiKmI4cbg9wISK9cpuNSQZlZLOYGyyYcGKI5fqD5COQfQr/nzNbV
         aBAwP59Yb27q2bwsPiajLoq3Icp6TN+1XNp/UyIwnDvrp/X7aII6DJOCSM4aMU0Zi9Hl
         hByw==
X-Gm-Message-State: AOAM531z/lNoVyWAeB20xDeipELlU+qe9lB/gec53aFeF9IkVPGbcn6G
        geGq+ngyqYbtj1mpdfUgA3VEvQ==
X-Google-Smtp-Source: ABdhPJw/bvvxGSAdxaxfDR7i8xQQgyJ4xG4agDhOyHyIbNnyenaBkh8+NJdEuQEXlJHU37EUBxUwZQ==
X-Received: by 2002:a05:600c:378d:b0:38b:e12f:edde with SMTP id o13-20020a05600c378d00b0038be12feddemr4636148wmr.69.1648731502654;
        Thu, 31 Mar 2022 05:58:22 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm8230695wmq.9.2022.03.31.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:58:22 -0700 (PDT)
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Baltieri <fabiobaltieri@chromium.org>
Subject: [PATCH v2 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Thu, 31 Mar 2022 12:58:15 +0000
Message-Id: <20220331125818.3776912-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
In-Reply-To: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
References: <20220331125818.3776912-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dt-bindings include file for cros_ec devicetree definition, define
a pair of special purpose PWM channels in it.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
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
2.35.1.1021.g381101b075-goog

