Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94464EEE80
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbiDANxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346492AbiDANw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:52:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E81C6490;
        Fri,  1 Apr 2022 06:51:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 821301F41C6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648821065;
        bh=4ga0haARvqzGPiyyyt4tWRKPqw/63CPmbmTUs4qGJ3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhpkztki5+AjyK5hQG+xNcDGcijGvtqA5JVjwtmg8LtTtw6i/WnWsUdqDwRbhHJgF
         upxSgAY0ngHLzGa9FTnU6VWZnRjnKIZ7MoOQ5/+dJp7evVlvRwVuTYfm4JLMAuEBAp
         el7LarJicw6tjsmzr0vOp25tAR8VwSbLxh/a+615yI+ZBV+FWr12onZF41/lyT4RCk
         4FiWczSy5/IuhuMWxg3KIQ2iRc22OglqkDFkxXRkzKOknq4wD83JiA1FOxKDh1O2fS
         72F4BUfNj/2WqhNBPDoINQeJ7NAwJUET8HcuAMCvyDxw6y4MGznBFHRYMVIIsvjELv
         TMwNBeZNYRuPQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, arnd@arndb.de,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nfraprado@collabora.com,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/2] dt-bindings: mfd: syscon: Add support for regmap fast-io
Date:   Fri,  1 Apr 2022 15:50:48 +0200
Message-Id: <20220401135048.23245-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
References: <20220401135048.23245-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscon driver now enables the .fast_io regmap configuration when
the 'fast-io' property is found in a syscon node.

Keeping in mind that, in regmap, fast_io is checked only if we are
not using hardware spinlocks, allow the fast-io property only if
there is no hwlocks reference (and vice-versa).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 13baa452cc9d..85a2e83b5861 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -83,11 +83,26 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [1, 2, 4, 8]
 
+  fast-io:
+    description:
+      Indicates that this bus has a very fast IO, for which
+      acquiring a mutex would be significant overhead.
+      When present, regmap will use a spinlock instead.
+    type: boolean
+
   hwlocks:
     maxItems: 1
     description:
       Reference to a phandle of a hardware spinlock provider node.
 
+if:
+  required:
+    - hwlocks
+then:
+  not:
+    required:
+      - fast-io
+
 required:
   - compatible
   - reg
-- 
2.35.1

