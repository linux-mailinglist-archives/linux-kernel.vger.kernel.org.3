Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E764B26C6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350405AbiBKNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:06:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350394AbiBKNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:06:13 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C4F05;
        Fri, 11 Feb 2022 05:06:12 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id n24so9754120ljj.10;
        Fri, 11 Feb 2022 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QOZGevQGicR/4MkXAylsEnnmSbv+cCBrPCN/jkqNkh8=;
        b=eCZCn1FmAZxUuMEtpttv+KsWo7SwhcG/TpxpuSl+CJ1TkCD9kX+4YuN033rLRqjVbB
         COEB6eYs5kPbYM+lvMrP+/NoUg2zAu+N/r0aso39xSo/JEahMvA2ccHLvib9uvBu5Svp
         C5n+Ehizm3QJg7NpbYZPLm2BofR8A6eibHw16MJ803VjBtyBlBD5gSzgk7dmCV+TrKY0
         snent26UPAX2zdPuUtvehBjiJVWmRx7J6Pq8yO5aXCR6VEr+5ZnnB4JNx7GRjxo5/1LD
         G5QJfceGRpDWr87fSo8JSsRZiJBkG4A9f+pUXsb9QMqOl2yr3DZ3DRULi4aa+IHOQBlV
         OBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QOZGevQGicR/4MkXAylsEnnmSbv+cCBrPCN/jkqNkh8=;
        b=KfDdJ5dQIe2AY86m1xT+IfuNsybQe3B5EqP2S46oDegmwHKkkWx3JDg29MIccCqPMA
         o1ZvcuNV18S70+sfM5bWfX0o1XIvzob9Yobq43xrv5nUzwziZBiSJl+KruotyjIqm+YW
         cQcQ2Y43u8FcGhV9uria3q6FfFJUgeOhJobSPkGUOgtuiYARBaLd2mtVTNolvkBa5GTO
         Tg7a990j30titzhcPuUx7P68OSs3erIYdMK/g04EWCS73iwjvYBbBxAvhLf8zaVX5dO/
         O6KKbV1n5ef/Dqy/bJ9wf9OFdj99ArG5IjRG65VCzBCWM1mUTVtKTMebhOxwC+ZCtqX9
         8DMQ==
X-Gm-Message-State: AOAM533OBLUpTIFVM4QZgEyVISdIyHJ4F4B8X9YAajcv9NueCumimCcI
        0EGYe6TvGmSx5U3I1vVFdG4=
X-Google-Smtp-Source: ABdhPJzBevgFzgppACuqmRMqskbqEtIQ/liEcKObs5ceSG/hjKKZgV3iJ9hpb9+QiyO+mgjTxxCMwg==
X-Received: by 2002:a2e:a786:: with SMTP id c6mr930312ljf.385.1644584770532;
        Fri, 11 Feb 2022 05:06:10 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id b13sm3111094lfv.175.2022.02.11.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:06:10 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/3] dt-bindings: nvmem: brcm,nvram: add NVMEM cell to example
Date:   Fri, 11 Feb 2022 14:05:53 +0100
Message-Id: <20220211130554.13062-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211130554.13062-1-zajec5@gmail.com>
References: <20220124160300.25131-1-zajec5@gmail.com>
 <20220211130554.13062-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVRAM doesn't have cells at hardcoded addresses. They are stored in
internal struct (custom & dynamic format) . It's still important to
define relevant cells in DT so NVMEM consumers can reference them.

One of cells set in almost every device is "et0macaddr" containing MAC
address. Add it to example to show how it can be referenced.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Add children nodes description per Rob's request
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 8c3f0cd22821..fc1df9d1c4d4 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -27,11 +27,23 @@ properties:
   reg:
     maxItems: 1
 
+patternProperties:
+  ".*":
+    description: |
+      Each child node represents one NVRAM entry (variable). Node name has to
+      match variable name as internally defined in the NVRAM.
+
+      Some of common NVRAM variables are: "board_id", "boardflags", "boot_wait",
+      "clkfreq", "et0macaddr", "sdram_config", "wait_time".
+
 unevaluatedProperties: false
 
 examples:
   - |
     nvram@1eff0000 {
-            compatible = "brcm,nvram";
-            reg = <0x1eff0000 0x10000>;
+        compatible = "brcm,nvram";
+        reg = <0x1eff0000 0x10000>;
+
+        mac: et0macaddr {
+        };
     };
-- 
2.34.1

