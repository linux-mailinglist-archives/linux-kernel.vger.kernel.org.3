Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7186557834
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiFWKwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiFWKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:52:02 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F5C4B416;
        Thu, 23 Jun 2022 03:51:58 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C1364E0002;
        Thu, 23 Jun 2022 10:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655981517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eOnREmjkRmZWXjlITmYHHvZiPZ/RIqrCWToz3hX41C4=;
        b=ovrxSQHKKOiTeOdkLHzgi8zf619MWczw6rdGJGYRofvl3rA9eA5jtFNNW1lkPZR5qWdzbV
        9NREpiK+7v/OIFuzXHGorxHvusafWTMB39pXIuoTs1k9YT8Vs8SMz0ubV1PsscQGsCOr1J
        /SLwMKiFklW2254dDLEinhFdTKjkKXEJo802nw4ZpHP1UgnQPO6GnMcU22VkGXQ+gpbLK1
        cOsbhDw0qPF7jG9k+fsFkbRNodTh1ghbMSXpfoZSDXFd4QKChZ6SiTquvB5Iow+P4U7Nrg
        UHWBAlz0JMtZ+CHdLZlcc1MzHGW2Q6j1F3+9fzxrZS9Mj8owqD4+QlFeDPLmsA==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v1 1/2] of: base: populate of_root node if not set
Date:   Thu, 23 Jun 2022 12:50:43 +0200
Message-Id: <20220623105044.152832-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623105044.152832-1-clement.leger@bootlin.com>
References: <20220623105044.152832-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabling CONFIG_OF on a platform where of_root is not populated by
firmware, we end up without a root node. In order to apply overlays and
create subnodes of the root node, we need one. Create this root node
by unflattening an empty builtin dtb with of_fdt_unflatten().

Co-developed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/of/Makefile       |  2 +-
 drivers/of/base.c         | 18 ++++++++++++++++--
 drivers/of/empty_root.dts |  6 ++++++
 3 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..ce56c8b95c83 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y = base.o device.o platform.o property.o
+obj-y = base.o empty_root.dtb.o device.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
diff --git a/drivers/of/base.c b/drivers/of/base.c
index d4f98c8469ed..43e0f027a49c 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_fdt.h>
 #include <linux/of_graph.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -163,6 +164,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
 		phandle_cache[handle_hash] = NULL;
 }
 
+extern const char __dtb_empty_root_begin[];
+
 void __init of_core_init(void)
 {
 	struct device_node *np;
@@ -176,6 +179,18 @@ void __init of_core_init(void)
 		pr_err("failed to register existing nodes\n");
 		return;
 	}
+
+	if (!of_root) {
+		void *dt;
+		const unsigned long *fdt = (const unsigned long *)
+							__dtb_empty_root_begin;
+		dt = of_fdt_unflatten_tree(fdt, NULL, &of_root);
+		if (!dt) {
+			pr_err("Failed to setup empty root dt\n");
+			return;
+		}
+	}
+
 	for_each_of_allnodes(np) {
 		__of_attach_node_sysfs(np);
 		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
@@ -184,8 +199,7 @@ void __init of_core_init(void)
 	mutex_unlock(&of_mutex);
 
 	/* Symlink in /proc as required by userspace ABI */
-	if (of_root)
-		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
+	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
 }
 
 static struct property *__of_find_property(const struct device_node *np,
diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
new file mode 100644
index 000000000000..cf9e97a60f48
--- /dev/null
+++ b/drivers/of/empty_root.dts
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+/ {
+
+};
-- 
2.36.1

