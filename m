Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A6558F39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 05:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiFXDn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 23:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiFXDnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 23:43:47 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262434BB7;
        Thu, 23 Jun 2022 20:43:46 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t16so2993660qvh.1;
        Thu, 23 Jun 2022 20:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8c693hWUGJUPaGBdaxJh+jhQOSw8GXU559QqqTBvCM=;
        b=iSZ+Ttp73BFerzudnll/eUm+uefTUoofXz6bTlRzTfn86NgCyFMh81ZlBsxnYBETr9
         Mu1+tbl3Rhr/92FNokhpf2V4MB3Kxu/lqoUE25zlbUUa8x6bwRo8BlTjm15hSSAq7wnw
         +8XMcZg+HNnwnadF9oj3u0PWLNvGts1rPHXC2IU9hqd7d6vm9xW3ME2G1mWXDUNU7/lD
         vScU4FXyI60zAijeweKJA3lOn5POG9CluiRzwAK97OibQGXJMFUsPC+wSx1JC8tshd3D
         EtcH3322rXjGy+iQEny5qF3zq/PUwdtoiz9o58qbBqpjXK5HKjLKcG/eC9WgMlW/3C0B
         JDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8c693hWUGJUPaGBdaxJh+jhQOSw8GXU559QqqTBvCM=;
        b=SfAsbUjflFxVphBgQdeFUtcY4obEvtb6EaYBxIrBUPvkedaQt/YS6dwKpWOw8D3yUk
         G8RBWP29clHIBJlrLDdjwvAOERGIB2gHYydcBYKWCDIxQDz/vPoyuxk/jRbi8VOrkusH
         0ifRzIw6gG5eMvAxmqJS5gOOHFBAJaT9ZwMjWTvGtXaz0i5ppKoaSQXviYbcW3OxFmso
         VKqgNTzknB3TToZM7yqopF/TjjEQVYGYpypv71gM2iehMfYErFI2CqsA44MFdQUGmy/+
         khIazZ7OhSRZ8cwn7+n9lUNW0OnaRjQbNyBmNmgESzSiHfqQ63NMq9Q+p+n2IEQKjB3H
         DAAg==
X-Gm-Message-State: AJIora/xOcxTR5nvx81IGui3QyXJIpU+1LAVGo3Dje/Y75rPFbI1+yR6
        bBc0PHFZNQBHGbndRxZkIsdAxKGcYPtnkQ==
X-Google-Smtp-Source: AGRyM1u7H7UmwToZUqRExOjslgxS3zVf07WMUdkfsMT6/JFCuGjoLP/Sb3cQ0i0c8RHGpAi069+uZQ==
X-Received: by 2002:a05:6214:e42:b0:470:5138:a496 with SMTP id o2-20020a0562140e4200b004705138a496mr15647895qvc.100.1656042225543;
        Thu, 23 Jun 2022 20:43:45 -0700 (PDT)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:bdf1:2a9b:4f43:67ef])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a454300b006aef6a244a4sm1048691qkp.129.2022.06.23.20.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 20:43:42 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/2]  of: create of_root if no dtb provided
Date:   Thu, 23 Jun 2022 22:43:26 -0500
Message-Id: <20220624034327.2542112-2-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624034327.2542112-1-frowand.list@gmail.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

 When enabling CONFIG_OF on a platform where of_root is not populated by
 firmware, we end up without a root node. In order to apply overlays and
 create subnodes of the root node, we need one. Create this root node
 by unflattening an empty builtin dtb.

 If firmware provides a flattened device tree (FDT) then the FDT is
 unflattened via setup_arch().  setup_of() is called immediately
 after setup_arch(), and will create the default root node if it
 does not exist.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

This patch modifies init/main.c.  It was not clear to me whether
to add Linus to the distribution, or if the change should flow
through Rob.  (I did not add Linus.)

 drivers/of/Makefile    |  2 +-
 drivers/of/fdt.c       | 19 ++++++++++++++++++-
 include/linux/of_fdt.h |  2 ++
 init/main.c            |  2 ++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index e0360a44306e..cbae92c5ed02 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,7 +2,7 @@
 obj-y = base.o device.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
-obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index a8f5b6532165..d439ded3b6c6 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -33,6 +33,12 @@
 
 #include "of_private.h"
 
+/*
+ * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
+ * scripts/Makefile.lib
+ */
+extern void *__dtb_empty_root_begin;
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
  */
 void __init unflatten_device_tree(void)
 {
-	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
+	if (!initial_boot_params) {
+		initial_boot_params = (void *) __dtb_empty_root_begin;
+		unflatten_and_copy_device_tree();
+	} else {
+		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
+	}
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
 	of_alias_scan(early_init_dt_alloc_memory_arch);
@@ -1373,6 +1384,12 @@ void __init unflatten_and_copy_device_tree(void)
 	unflatten_device_tree();
 }
 
+void __init setup_of(void)
+{
+	if (!of_root)
+		unflatten_device_tree();
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
 			       struct bin_attribute *bin_attr,
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..4566876db351 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const void *default_match,
 /* Other Prototypes */
 extern void unflatten_device_tree(void);
 extern void unflatten_and_copy_device_tree(void);
+extern void setup_of(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_EARLY_FLATTREE */
@@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
 static inline void unflatten_device_tree(void) {}
 static inline void unflatten_and_copy_device_tree(void) {}
+static inline void of_setup(void) {}
 #endif /* CONFIG_OF_EARLY_FLATTREE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/init/main.c b/init/main.c
index 0ee39cdcfcac..8b3a60d14bea 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
+#include <linux/of_fdt.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
@@ -949,6 +950,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	pr_notice("%s", linux_banner);
 	early_security_init();
 	setup_arch(&command_line);
+	setup_of();
 	setup_boot_config();
 	setup_command_line(command_line);
 	setup_nr_cpu_ids();
-- 
Frank Rowand <frank.rowand@sony.com>

