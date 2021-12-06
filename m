Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973646A344
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbhLFRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:45:55 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:41881 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244056AbhLFRpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:45:47 -0500
Received: by mail-ot1-f53.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so14565485otl.8;
        Mon, 06 Dec 2021 09:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vc6ZF6yfR161Iy9YEu2UCYzkCAfCd05DdfhoxW7W4EU=;
        b=jqp4yQ4BUO8BRC8wrPwH2ObHqop5sP+6ChCfL3JdAACZ9vYA8JDTUKvmMpm4sz95e6
         ikuD/MCoSccieuX2eSZwqZ35LBweYni0v2pV/nhct+YBwkxbqaLxLQmWJTNhO9hHXD5e
         CO++xTZ4EegUsACT5TP/QENDxg74vK0ukSOMv4JnDGQoCo6dg/S6el7JyYsLnsPx6yqw
         Zsf0VHA07YNP4OrUrU/wicRG/jG833qzNCjqCQouOEr3pA7ct1gSOMEgD+W2XuEO++f9
         iRnGqqLOwNoXUUjx8eM5rAiQhQREU7jM0JXM/By8tF3NO4jzjAnlnZA6mbxyIMUyVj+K
         lywA==
X-Gm-Message-State: AOAM531AF0Sc6iuWpsO8hqZ17n/Otey5NFl7P+BDH6gZgJ7fZLV5GdyL
        J/kodecPbpN18qTQbtdZLw==
X-Google-Smtp-Source: ABdhPJxs33y9Av1DViRAnqMVJEr8N+KkQLyPDSxpKGGpjvKRfbmD6Dl+yo3q2zrNM9YtYL0wINMQeg==
X-Received: by 2002:a05:6830:18b:: with SMTP id q11mr31724041ota.113.1638812536823;
        Mon, 06 Dec 2021 09:42:16 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id q22sm2317228ots.62.2021.12.06.09.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:42:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: memory-controllers: ti,gpmc: Drop incorrect unevaluatedProperties
Date:   Mon,  6 Dec 2021 11:42:15 -0600
Message-Id: <20211206174215.2297796-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 'unevaluatedProperties' support implemented, the TI GPMC example
has a warning:

Documentation/devicetree/bindings/mtd/ti,gpmc-onenand.example.dt.yaml: memory-controller@6e000000: onenand@0,0: Unevaluated properties are not allowed ('compatible', '#address-cells', '#size-cells', 'partition@0', 'partition@100000' were unexpected)

The child node definition for GPMC is not a complete binding, so specifying
'unevaluatedProperties: false' for it is not correct and should be
dropped.

Fixup the unnecessary 'allOf' while we're here.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/memory-controllers/ti,gpmc.yaml      | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
index 25b42d68f9b3..85d024f01eba 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
@@ -119,11 +119,8 @@ patternProperties:
       The child device node represents the device connected to the GPMC
       bus. The device can be a NAND chip, SRAM device, NOR device
       or an ASIC.
+    $ref: "ti,gpmc-child.yaml"
 
-    allOf:
-      - $ref: "ti,gpmc-child.yaml"
-
-    unevaluatedProperties: false
 
 required:
   - compatible
-- 
2.32.0

