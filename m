Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914D64F502C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1840742AbiDFBLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384292AbiDEORz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:17:55 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF52E09C;
        Tue,  5 Apr 2022 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649163839;
  x=1680699839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqLQ/tqybbZnxatnOYByhvJNRJCuF0z9AxMtXu1mnFM=;
  b=BN7xY1k3tnaA8FsLsMcHISuo5ayWMEKb1NRR/sF1Q1hb2t2nQWsiPvDI
   v8BBNuJ4vprWFxbGQSlnpY6q+VyUJs1lEEgqegfs2iZ7TZxbIYRHLyibN
   eReB0awLH423zCVP4uJKOjNbsAfFSFn5T0VemaMiMyzwIBD475ZRVkTbc
   1KscjZaRmuaIVorI8WuVbPaqwKFLvH/g+6rsXMMD6Qgyr/RQ7QCK+TzlO
   TUDUTK6nXcABuxsdZhAwUf/KKdhswKx4FZynpO1GQaMsj1IvvHgxgqlm/
   0t2F8YOzNA8dEBVMLGnjzWstZ3WWeRzWOwlX5DPKtmFhOymMBB2O90mJ/
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <vigneshr@ti.com>, <richard@nod.at>, <miquel.raynal@bootlin.com>,
        <joern@lazybastard.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: reserved-memory: Add phram
Date:   Tue, 5 Apr 2022 15:03:48 +0200
Message-ID: <20220405130350.1640985-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405130350.1640985-1-vincent.whitchurch@axis.com>
References: <20220405130350.1640985-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings to allow MTD/block devices to be created in reserved-memory
regions using the "phram" driver.

This allows things like partitioning to be specified via the existing
devicetree bindings.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2:
    - Add note on what "phram" means.
    - Use /schemas/mtd/mtd.yaml instead of relative pathUse /schemas/mtd/mtd.yaml instead of relative path.

 .../bindings/reserved-memory/phram.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/phram.yaml b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
new file mode 100644
index 000000000000..318415b56afe
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/phram.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MTD/block device in RAM
+
+description: |
+  Use the reserved memory region as an MTD or block device.  The "phram" node
+  is named after the "MTD in PHysical RAM" driver which provides an
+  implementation of this functionality in Linux.
+
+  If no-map is not set, cached mappings will be used for the memory region.
+
+maintainers:
+  - Vincent Whitchurch <vincent.whitchurch@axis.com>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+  - $ref: "/schemas/mtd/mtd.yaml"
+
+properties:
+  compatible:
+    const: phram
+
+  reg:
+    description: region of memory that contains the MTD/block device
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        phram: flash@12340000 {
+            compatible = "phram";
+            label = "rootfs";
+            reg = <0x12340000 0x00800000>;
+        };
+    };
-- 
2.34.1

