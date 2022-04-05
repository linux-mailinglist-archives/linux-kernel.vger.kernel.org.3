Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B624F4F69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837968AbiDFAta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447346AbiDEPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:46:20 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48936972A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 07:21:14 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso4079228wma.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AxU4sa8Q3Vc8i3PPINAb0+zKHHjXN87FdHl8DAkuO3A=;
        b=FXRzPVIxVwymFA22cVrY4G9XF+i6IJeIFm36Ivz6IzidBy8nhsDs4LElaYBJvgYczS
         /ZfALuvngPVtoxp2uhnjlCoH8sKQjUd4Y8Z3B74wQ59EnEgYtTtNyvG06VsuftNQpRUM
         pEEKyJfDF8doBr5LBf/SevUG8rHPEVEselas1nPySjiL3BcYOXg4Dx5/19wwJ+abhGdH
         yv4MtmZCBEosOU6BkcIM4TKOQOOKuXZzI7m+9w9HXJ9jI6EbpHYvDnSiqkCx+Yn0ObTJ
         pZEi3NUbwvwcSXvC1wmVQcxJetdUVz59WAgxYVg2CM51mpTtQw+OLRQpBPsi/EVI2ij0
         QH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AxU4sa8Q3Vc8i3PPINAb0+zKHHjXN87FdHl8DAkuO3A=;
        b=YDGKb2vvOlreZxNBlKJoqRdAIDpQIN4JfwmF5ori3pT9w/8FYUkDftF+t4LOO7cvA1
         rMjVXrbsvvc/BO/LltehxfUvKAfn4rRmvxKfJqlPZdY17gKUJ6WZ6ReKQ2ESytK5rKmO
         ty8ItJu7XN6BvykD3jmGxWhR1sEHcXNDB78TIssV53qKnWpuOnQqy11wFYMg9nZlrrQM
         QcSqUGS9LjOyA07YReoT5DdBI4PAQL0ko8RKSnBjJDTjZdSLoFJLN7WPOJKIg0tBC/jb
         kU1HWdXRzieGRnYJPTG8TcagM0fQBJpahAYI07w4ZCkx9tfgWjYX1UxNKuKLH8+c7wTL
         jFcA==
X-Gm-Message-State: AOAM533JxLzHvwBkmmzXLCskOPvTrnzoYaLuGAcGh+x+ZZ/bk/WxOxRw
        yeuLehiLGAQd0ZS04Up7G9tUt4IRiWCP8IV1Wf4=
X-Google-Smtp-Source: ABdhPJy8yRbBfp7JJ9vsoLLwfEai6IIn9u2k9X2YUED5leE66rVPOiM8Nomw1qVKZQ5XYCsabUFPzbI21h5FTwSwa0U=
X-Received: from sene.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:27c4])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:1c11:b0:38b:4924:9a77 with
 SMTP id j17-20020a05600c1c1100b0038b49249a77mr383558wms.0.1649168472631; Tue,
 05 Apr 2022 07:21:12 -0700 (PDT)
Date:   Tue,  5 Apr 2022 14:19:54 +0000
In-Reply-To: <20220405141954.1489782-1-sebastianene@google.com>
Message-Id: <20220405141954.1489782-2-sebastianene@google.com>
Mime-Version: 1.0
References: <20220405141954.1489782-1-sebastianene@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH 1/2] dt-bindings: watchdog: Add qemu,vm-watchdog compatible
From:   Sebastian Ene <sebastianene@google.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, will@kernel.org,
        qperret@google.com, maz@kernel.org,
        Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This watchdog can be used to detect stalls on vCPUs.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 .../devicetree/bindings/watchdog/vm-wdt.yaml  | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/vm-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/vm-wdt.yaml b/Documentation/devicetree/bindings/watchdog/vm-wdt.yaml
new file mode 100644
index 000000000000..5365c963a7f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/vm-wdt.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/vm-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: VM watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Sebastian Ene <sebastianene@google.com>
+
+properties:
+  compatible:
+    enum:
+      - qemu,vm-watchdog
+  clock:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The watchdog internal clock measure in Hz used to decrement the
+      watchdog counter register on each tick.
+      Defaults to 10 if unset.
+  timeout-sec:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The watchdog expiration timeout measured in seconds.
+      Defaults to 8 if unset.
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog {
+      compatible = "qemu,vm-watchdog";
+      clock = <10>;
+      timeout-sec = <8>;
+    };
+
+...
-- 
2.35.1.1094.g7c7d902a7c-goog

