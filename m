Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405F4E8AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiC0WoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiC0Wmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:42:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24BA33347
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:03 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t11so17905145wrm.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eywd7FmH0eN0jrnWKgGdeR6AnFImC306XiX8oFPZwAs=;
        b=0r7A+Lg3dNKCPPbFiM+r2Qb3aWcF/p0TOhmyZ6fCihniTMpFEzKZY5YjYdsNTSAWqN
         PbIOYJQJQGdEkdV8sp8l3JBhwGeBtqFwUpJ+1QeYuCz1b1wRy4SiIbO3Emgxg/KnDiSk
         CiBOc5wGNfUwm6kxi3rSlwPV9GLoA6LojVJ8C5DoDvdw16bG4t+phKcX8xJGA5nh8o3p
         gA/Mc8yiLl633Fcxtld3vxHXvEhzxQVlb8rSLMYG4QWMhvCZwJMR1dkzQr2M0tvIcm6u
         DdQKBHdBDHeYvCXLr+mE3qAVoJ/8zWnxQEcQT9AOhtvxeW8nibWa2VC1ygUqee3lqp9q
         cvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eywd7FmH0eN0jrnWKgGdeR6AnFImC306XiX8oFPZwAs=;
        b=2kQq7mAk94x4/GcAJzqf0x9qtbJjiC/CEUoP3jKRHBqIQnsNYA8zvxmX+BQVDe6dZA
         oV/O7rWlQBI6dLTSYPBNBjlJQw59uxnuYqvbhhqES4nWZzz4tg5uysmzlzwLRuhiu7L8
         yAOGB8OTsNXjv46VUGLLqSbxqiez+hO9Ml1UZv6m7UZDcNHO0z3U5xza8Hhz7PFbKQTl
         WIMBQEadg7DnaM/l/wlO8ssCJIdCKR/o5Fu/y1MQ8q6YSqXr2RqhVbLAuoflHbq7Nsh3
         Eg/bqBoIBBFsS8qCPa2o3spdsh8/JL5w1baoLoxSuIt6d1ZQeE+CSxVm9JUG9QglpQu6
         Fq2Q==
X-Gm-Message-State: AOAM531tfzHpPaconrlmsznw6+wJe5/yy+MbVWL/S3B/V7nFpWlCx/Z8
        lsF9SZMhM8V4INkpOUOOeH37VgaQTURTCg==
X-Google-Smtp-Source: ABdhPJwVdJKuEHZkpHZx/kesrNtcrmsj08nZDeDz/JbXf7iTCc+i8rplDDOSSsSGAP4YKrlt21K5og==
X-Received: by 2002:adf:e987:0:b0:203:d6f6:71f3 with SMTP id h7-20020adfe987000000b00203d6f671f3mr20128642wrm.82.1648420862352;
        Sun, 27 Mar 2022 15:41:02 -0700 (PDT)
Received: from localhost.localdomain (2a02-8440-6341-357e-3074-96af-9642-0002.rev.sfr.net. [2a02:8440:6341:357e:3074:96af:9642:2])
        by smtp.gmail.com with ESMTPSA id v5-20020adfe4c5000000b001edc1e5053esm10400867wrm.82.2022.03.27.15.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 15:41:01 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
To:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: [PATCH v9 03/22] dt-bindings: mediatek,dp_phy: Add Display Port PHY binding
Date:   Mon, 28 Mar 2022 00:39:08 +0200
Message-Id: <20220327223927.20848-4-granquet@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220327223927.20848-1-granquet@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This phy controller is embedded in the Display Port Controller on mt8195 SoCs.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
new file mode 100644
index 000000000000..1f5ffca4e140
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2022 MediaTek
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Display Port PHY
+
+maintainers:
+  - CK Hu <ck.hu@mediatek.com>
+  - Jitao shi <jitao.shi@mediatek.com>
+
+description: |
+  Device tree bindings for the Mediatek (embedded) Display Port PHY
+  present on some Mediatek SoCs.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-dp-phy
+
+  mediatek,dp-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the Display Port node.
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - mediatek,dp-syscon
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    dp_phy: dp-phy {
+      compatible = "mediatek,mt8195-dp-phy";
+      mediatek,dp-syscon = <&dp_tx>;
+      #phy-cells = <0>;
+    };
-- 
2.34.1

