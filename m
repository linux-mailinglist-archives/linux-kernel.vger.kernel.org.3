Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B524695E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbhLFMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:47:18 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:53008
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243297AbhLFMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:47:16 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64F6F3F1D7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638794627;
        bh=2ccnvvjzh+vr27cmDIxMLKkuyPKdTXHoRsCzeOVPF7c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=eEmJYfaiZO+/iHRvWxq8KF1GbQir4H1bi4y4JgahBCNZVqqIT9ihpBxN96LgC7NKQ
         dy2oIc0VlduOjJijtyz4aCMYi4VtN4ZPYzk1nfh9dw3iqYkoYLiL0ufzj3B/LRGjx3
         3cAqCAeAgxpBBCbHNfztfVHGD3uYcxJu/B/HbexftnWtT7seEz6p8Kq0FlcPP/JZXH
         R2V1eLvbfXXbVKHog2Nt14KEH8eSaC8C78TCUle1bRqfXQ/1kFsmdz6pOaQfdKsvxs
         ztO4+pc1yL4VIX0Fq38VunhuN7VW1ubc8ZP+0U5AIXCok8G1zRpNJ/WjWo28O7rSkM
         DgzTSZRjksvhg==
Received: by mail-lj1-f197.google.com with SMTP id 83-20020a2e0556000000b00218db3260bdso3402573ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 04:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ccnvvjzh+vr27cmDIxMLKkuyPKdTXHoRsCzeOVPF7c=;
        b=1r/b5SINLU5XpRJ6DHiMS591MAgoOJWUHoaU3UaeJa9Fl0dQttx1uEqb6g69scljSA
         NLlRLXwcq82i/bPogBvpkvPGTt2gRoCbVqCXd1Rmpk8lhDPac+/NyaiOz7c7TeJ0nKUl
         63om/oaQJi3HkbHQHgMLmJwQjb3o1RczoBXXBPyE+SyTAGkqs1lPly/JrEJrbyrLp7aj
         rNq+UBIkAox3vt42/77Vwq+Za10aud3gmnFoucXmtPYBDm6N5XOPVXzJU8I3rRnhPTEm
         OLr9PQ36rqSx37CtjkvY5rKB9do9xpavcxPCDgzg4juvrSJsMK8JvLsOf+n6AI29f68I
         bvAg==
X-Gm-Message-State: AOAM533r3RbzbC/hTmhJlUk+Gzg/OD/IdnHdy5ftTryJv/ZoKf2CU9Yj
        tUjoG6TyGeMjIchZQsp/YxGosjB2EEIDFXTJR0KvV5NhwWHH6/E0QY9MhKgu73nOU1E4ro3k2+S
        OkYkoTRKkqfjU5hBldk4vhbgTq5RF9BErBoM14CUD5g==
X-Received: by 2002:a05:6512:1313:: with SMTP id x19mr35524123lfu.279.1638794626748;
        Mon, 06 Dec 2021 04:43:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEMmT5tdvgU9TQ9t8yV5F7fDNCa+/K4eYR8uaI1kK7FvQ6ULIl3dE3GYPMmHi49FXSHjzxDw==
X-Received: by 2002:a05:6512:1313:: with SMTP id x19mr35524106lfu.279.1638794626513;
        Mon, 06 Dec 2021 04:43:46 -0800 (PST)
Received: from localhost.localdomain (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u14sm1296006ljd.12.2021.12.06.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 04:43:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] regulator: dt-bindings: samsung,s5m8767: add missing op_mode to bucks
Date:   Mon,  6 Dec 2021 13:43:06 +0100
Message-Id: <20211206124306.14006-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While converting bindings to dtschema, the buck regulators lost
"op_mode" property.  The "op_mode" is a valid property for all
regulators (both LDOs and bucks), so add it.

Reported-by: Rob Herring <robh@kernel.org>
Fixes: fab58debc137 ("regulator: dt-bindings: samsung,s5m8767: convert to dtschema")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/regulator/samsung,s5m8767.yaml   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
index 80a63d47790a..c98929a213e9 100644
--- a/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
+++ b/Documentation/devicetree/bindings/regulator/samsung,s5m8767.yaml
@@ -51,6 +51,19 @@ patternProperties:
     description:
       Properties for single BUCK regulator.
 
+    properties:
+      op_mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 1
+        description: |
+          Describes the different operating modes of the regulator with power
+          mode change in SOC. The different possible values are:
+            0 - always off mode
+            1 - on in normal mode
+            2 - low power mode
+            3 - suspend mode
+
     required:
       - regulator-name
 
@@ -63,6 +76,18 @@ patternProperties:
       Properties for single BUCK regulator.
 
     properties:
+      op_mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        default: 1
+        description: |
+          Describes the different operating modes of the regulator with power
+          mode change in SOC. The different possible values are:
+            0 - always off mode
+            1 - on in normal mode
+            2 - low power mode
+            3 - suspend mode
+
       s5m8767,pmic-ext-control-gpios:
         maxItems: 1
         description: |
-- 
2.32.0

