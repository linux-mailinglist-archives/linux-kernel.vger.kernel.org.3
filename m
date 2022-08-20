Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF0759B02D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiHTT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiHTT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:58:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC9FDF88
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so7040058pfb.7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=0zartni4WWKXkld6e1WeGJpYpeF1RS1wwjz0ltPgHus=;
        b=U95uH/zNEa/TQ4D+jYVIJdvJ8GymR00qdKpot0h8As14wkzSPTEvQEUOOjDDmW6ZRV
         duFLC6eaowNl1KDOXwMk4uTMxZ5UbDsurrvbsi/DpNewV779jBdMR+RH//XZYFSY5Vdj
         XFjWhC6fpzKWPk0ZP7eJXs6Neq/i2NwlLlzaj/uhjxIjFIJgaZkHFDM6zvL8Kl3SFe4S
         Nq/wNxJb9ivY6SfmkvdXFohdpjnwjxFksyvJU4/a4q6mzgyWfb0rfswD451bxN4dCh6Q
         AZgJDSjJszuIc0m7RqxY1qdt+nbACAVcuLvJNTtt1wIFOz2OahFXCWEv5L2xlp3w+FW2
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=0zartni4WWKXkld6e1WeGJpYpeF1RS1wwjz0ltPgHus=;
        b=dU2Pb/c/ZReCIydZpIv2BoIFPn8cYJWo0J4kxe1z9A7lTOL9L9mcy8HqRxx6LBawNV
         lR/k/qCMFU+/k4K0tLLKPvPydsYLF675kQ5RyGLYgLchi1NFUZMwzM6jzO2xa07Oq+Ds
         JKouGzADgF810Kaj6UvOKxMQdtqL1C1CHgLcTvRo6DzmBd2BO05OS+fmZxAuhWbNbfYT
         +8FlllttIFeAp/AJ4u1ZLd2B+9kajIuCWrbaTAJkGIiKMqah0g4eQr6hMG74t7RBM78e
         qXPdQvm3tvRxc4vevKoUOexK6gfrbpmw3H6xr/Xhlaplhlb/gKy41s93yqqecHd2cv3x
         l0wQ==
X-Gm-Message-State: ACgBeo2orUGKeQOvThbO2J6b7neZG9hPalPZzgkFrXfgVKWM6+mCYnWO
        SVUdHAeZcLG2qQFQsMUGFcedXV93SPgh5zuO
X-Google-Smtp-Source: AA6agR7EpSBOnin4/WKnF0P/ZYB5n/9+bKy1kJfNuoM4SGkFRNSu7jH2CbMw7hR+06qrxYA1QEJOzg==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:6680 with SMTP id t2-20020a056a0021c200b0052bff446680mr13809251pfj.57.1661025495792;
        Sat, 20 Aug 2022 12:58:15 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005363bc65bb1sm2316794pfb.91.2022.08.20.12.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 12:58:15 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 01/17] dt-bindings: arm: add AMD Pensando boards
Date:   Sat, 20 Aug 2022 12:57:34 -0700
Message-Id: <20220820195750.70861-2-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220820195750.70861-1-brad@pensando.io>
References: <20220820195750.70861-1-brad@pensando.io>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brad Larson <blarson@amd.com>

Document the compatible for AMD Pensando Elba SoC boards.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 .../devicetree/bindings/arm/amd,pensando.yaml | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/amd,pensando.yaml

diff --git a/Documentation/devicetree/bindings/arm/amd,pensando.yaml b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
new file mode 100644
index 000000000000..e5c2591834a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/amd,pensando.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/amd,pensando.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD Pensando SoC Platforms
+
+maintainers:
+  - Brad Larson <blarson@amd.com>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+
+      - description: Boards with Pensando Elba SoC
+        items:
+          - enum:
+              - amd,pensando-elba-ortano
+          - const: amd,pensando-elba
+
+additionalProperties: true
+
+...
-- 
2.17.1

