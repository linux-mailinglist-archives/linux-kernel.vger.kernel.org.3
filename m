Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0376B4E2AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiCUOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350104AbiCUOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:33:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983A5D1A8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:32:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j18so11334280wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPNbf4VBXaKauQrD5GdOw/7C1sM2aDR3HnxDjhZ0elg=;
        b=K04KZ2llvCIBVjpLXRbj+FItZXFlk4ZVLcXMU/n3uOzyXQkjIt2p8UQRjAN1JRYeHw
         odN5bc3b7y61QwvNr5Voo9HYGe+n6sUBYkPIHRCLkL2b8MpipkOPtqLac92fMqy93U/2
         9Xve7ZthNZPcBZUKdMEkBljxtgCh7T6f6FGbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPNbf4VBXaKauQrD5GdOw/7C1sM2aDR3HnxDjhZ0elg=;
        b=qAFkZ8w9rZzE+yAha0gbw05EpebRUjYC1oPY4Ldx+fRz5O9Wmo/Gvn5Gt8fkb7DLFU
         w6AmuVM7U/W6cbEP29juEdfO3Qf6b38ql0k6i+1k3UXZZOb4MMfMitVwdeCYgBVToVQP
         yJozQ8NSNVHM5E3Kei1jfe/s6Aj67lzUQPpenWyQNQ5dSowp1VlOcKGQjaJXswJAG8fk
         GNtW6QsOZiYaD7hdmXOEpkP/Iht2tnSdKKReJE3h4jBCxNcppUQuIgpg1HMfm1DsftRh
         2Y4Eh/2JyLQhOtKb/xEKqz2X9+hsBS+Z/nyuaFungKwQ3+pNfGtT1ALAyPReFEnIHS1x
         IqSw==
X-Gm-Message-State: AOAM532oCuBz45hUgHAz+bu0DsPKS4CBUewzr8roWxekkmk6uzT4GD5a
        QzNCFxaSqaTFvgEd3ig/nYnqqA==
X-Google-Smtp-Source: ABdhPJxAUNMAkxYkB4uOST35byIe9LqZT6SPgd/wDbe3ZFo/1vnlqpEDwMr6f9llJhrZuMausBRxrg==
X-Received: by 2002:adf:ea06:0:b0:203:ed67:6093 with SMTP id q6-20020adfea06000000b00203ed676093mr15652317wrm.596.1647873152722;
        Mon, 21 Mar 2022 07:32:32 -0700 (PDT)
Received: from fabiobaltieri-linux.lan ([37.228.205.1])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b00389efe9c512sm19092793wmq.23.2022.03.21.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:32:32 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: add mfd/cros_ec definitions
Date:   Mon, 21 Mar 2022 14:32:19 +0000
Message-Id: <20220321143222.2523373-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
In-Reply-To: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
References: <20220321143222.2523373-1-fabiobaltieri@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 000000000000..e02414eae622
--- /dev/null
+++ b/include/dt-bindings/mfd/cros_ec.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
2.35.1.894.gb6a874cedc-goog

