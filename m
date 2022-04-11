Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFB64FC059
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347832AbiDKPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347794AbiDKPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:23:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9812E326F0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:21:19 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c7so23632435wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Av8EzP8d6KVoQi/yXwkBOAZabP9Xc8kXclRu9dT4+Lw=;
        b=MSW2higryDgsOhw0ZJDq4mbqycpFHp4ZK/5IKr30dVw+TG88282lZo+8u8kF2+sS/8
         t7IICscSNVmaDq9/jbHn0OPrQNhH/FUIc99pHP882qHAHVm/kjNMO4jfZ8UpZnnCK8yK
         7z+7lovGGpwh2g0cUNRsIxYVVn8En0/LjjELY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Av8EzP8d6KVoQi/yXwkBOAZabP9Xc8kXclRu9dT4+Lw=;
        b=xwEVc9fYm0cAC0wHRxGS+3d8MjShTkASFz/vrI558UpfwU1yzHXCMDkUDzt5JXTiKy
         pyrKMUm/lmgE76seV9bPCzQabsFIHTPobkZFIkKOu9J1q+EkDR4+WhaJ6LiQnmmAK8Hg
         v8LVuK4eFB+eFzW3skb5OGFBZxJZ4+uAW3qUocUAdNQaNx7AfkSB8Dep8p2cgY6YRgcy
         jazuCkc/lzIAO9mh7LsfNw6WrEjuPpWp9VYHj64T42fGXhDYt+H6douqqsffrOhESkBt
         2DiDwRGUlPVLQaNJ3mYysNgZc/K6094LTojC0/6IhYGDn+jiiBtOFsCsQ9eRlSYqnk+P
         6qgQ==
X-Gm-Message-State: AOAM532YA3rVA3LQVsI6ZnvcG36Sb28YWSBiJEOnrhLQffvNWJ3AWLM6
        e8ZY2P4qd6qXYUPPFUh0EMO6Xg==
X-Google-Smtp-Source: ABdhPJxPthidGCKrnPvf9IHSua1gxQPSnNJCQzeeFUq0J9nt1iiyJPKPkuaIafZ/E669DST2+ymPrA==
X-Received: by 2002:a05:6000:3ca:b0:207:a389:ca09 with SMTP id b10-20020a05600003ca00b00207a389ca09mr6481526wrg.628.1649690477827;
        Mon, 11 Apr 2022 08:21:17 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm19512832wrb.63.2022.04.11.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:21:17 -0700 (PDT)
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
Subject: [PATCH v3 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Mon, 11 Apr 2022 15:21:11 +0000
Message-Id: <20220411152114.2165933-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
In-Reply-To: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
References: <20220411152114.2165933-1-fabiobaltieri@chromium.org>
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
2.35.1.1178.g4f1659d476-goog

