Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692FC552BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345570AbiFUHVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346482AbiFUHVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:21:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F622505
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g25so25492090ejh.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/EcOWoOuIse/hvQ+oqlKU0lIbd1LkUUo/9oXAhtRbA=;
        b=LbqdqeXvHaDpcKkgE/5jv+iHaxhFG8nHt/LObC0/wQM2dlGqKWQOjxpybNl5ITV3iq
         x1Q21GlBZTG7ZRClnkl/fwWPfdFoVI6CEVRgLoOZIWpXmF/dC9slhtFk8kouyhUVDAsM
         afEUozQ9hP7y5yXYOx0YTjKr9uRDE2mvy1J7CGdIqPHY0ohi53Qny8COHRDq3l0ARJdG
         12/Gs94gSu6Ku1rAh3V7dWRL4xuk+UGyqh2hJqu0lAdXrQHwiWI/UOt+j4KM4w5jUg4Y
         DIAeoPToqPDmBke/w9hrwvmD3qn6L2zggRtq+yt646Z1mOnLwW3AZUD37Qk113pKiMsk
         bmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/EcOWoOuIse/hvQ+oqlKU0lIbd1LkUUo/9oXAhtRbA=;
        b=UkWLiGyY97aNpNJpXo9PMNwmnVmRxjDg+tjwg2NXG5fsJL4XuiXJv8jGjg6zz9Py01
         R3+h67TVoLi01nAsaUCdCM8bBJejhkuUy4Z9O3dvmy/HHIrLHTJ0KhXTFL4habo/LCfv
         FcuJ3Y3Gty5NTG2DYMPzooe6/tAjZEM2El9dBXF225VX/34rFNAF5QXnuDDNOmLL/tvQ
         QcHirbbzPqW2fehFqXJeQp5pRzmi5BJb+0g3OQA+DzZ99PLtecQwMTm5giShdvgL+CVF
         PdvysO5RQxXHbXxsqrtcCNx2jd5ACSrvNt1l2mTAp+4cFLEw2F84HS5wZIuAnstfldGc
         Q2ng==
X-Gm-Message-State: AJIora9+JQTIOX0hmaj+JRZQ05hWEmeJuio1ibWwf42iteoNUDBdBjIK
        WPVdmqmWeTHpv9uCfLgwFAevhfsGvdY=
X-Google-Smtp-Source: AGRyM1vmykp6H3Y7haeFNYSTgDp2SeGPwB5hGbzrZ2Avqa/HZIDol+cs2KIbjm2MU5/hGGmzXs8DNQ==
X-Received: by 2002:a17:906:51d6:b0:712:c9:8a1b with SMTP id v22-20020a17090651d600b0071200c98a1bmr25086132ejk.656.1655796074886;
        Tue, 21 Jun 2022 00:21:14 -0700 (PDT)
Received: from localhost.localdomain.info (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b00722e771007fsm50711ejo.37.2022.06.21.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 00:21:14 -0700 (PDT)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP)
Subject: [PATCH v2 1/4] drm/etnaviv: add simple moving average (SMA)
Date:   Tue, 21 Jun 2022 09:20:47 +0200
Message-Id: <20220621072050.76229-2-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621072050.76229-1-christian.gmeiner@gmail.com>
References: <20220621072050.76229-1-christian.gmeiner@gmail.com>
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

This adds a SMA algorithm inspired by Exponentially weighted moving
average (EWMA) algorithm found in the kernel.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_sma.h | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_sma.h

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sma.h b/drivers/gpu/drm/etnaviv/etnaviv_sma.h
new file mode 100644
index 000000000000..81564d5cbdc3
--- /dev/null
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sma.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Etnaviv Project
+ */
+
+#ifndef __ETNAVIV_SMA_H__
+#define __ETNAVIV_SMA_H__
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+
+/*
+ * Simple moving average (SMA)
+ *
+ * This implements a fixed-size SMA algorithm.
+ *
+ * The first argument to the macro is the name that will be used
+ * for the struct and helper functions.
+ *
+ * The second argument, the samples, expresses how many samples are
+ * used for the SMA algorithm.
+ */
+
+#define DECLARE_SMA(name, _samples) \
+    struct sma_##name { \
+        unsigned long pos; \
+        unsigned long sum; \
+        unsigned long samples[_samples]; \
+    }; \
+    static inline void sma_##name##_init(struct sma_##name *s) \
+    { \
+        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
+        memset(s, 0, sizeof(struct sma_##name)); \
+    } \
+    static inline unsigned long sma_##name##_read(struct sma_##name *s) \
+    { \
+        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
+        return s->sum / _samples; \
+    } \
+    static inline void sma_##name##_add(struct sma_##name *s, unsigned long val) \
+    { \
+        unsigned long pos = READ_ONCE(s->pos); \
+        unsigned long sum = READ_ONCE(s->sum); \
+        unsigned long sample = READ_ONCE(s->samples[pos]); \
+      \
+        BUILD_BUG_ON(!__builtin_constant_p(_samples));	\
+      \
+       WRITE_ONCE(s->sum, sum - sample + val); \
+       WRITE_ONCE(s->samples[pos], val); \
+       WRITE_ONCE(s->pos, pos + 1 == _samples ? 0 : pos + 1); \
+    }
+
+#endif /* __ETNAVIV_SMA_H__ */
-- 
2.36.1

