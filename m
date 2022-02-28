Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691B4C7E92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiB1XoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiB1XoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F686C3C32
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4EEwWZZAjwW/ysDjBUtGda9incLc4VBnaTI9ZWPATn8=;
        b=gfBjr9vXt78gbCGwygD9WcsI7IOiXv/FGz/3ah3vJQqxjsv/NCiaXuV84G++j7vUjUlMcf
        tlR8F59/GrBWRFLZ/7w4Qp2Mf9oE7oZrM4P788oGXKDNu7M7Pl9CEU3Jlt4MGwmDnU9eBU
        19fItdl/FJtIqAySxXi1EnShgYAFNPY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-wh-D7DqNPn6GH7tEfAjdYQ-1; Mon, 28 Feb 2022 18:43:28 -0500
X-MC-Unique: wh-D7DqNPn6GH7tEfAjdYQ-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b003815245c642so316636wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EEwWZZAjwW/ysDjBUtGda9incLc4VBnaTI9ZWPATn8=;
        b=JuU+8HQSxYS+9bvqHbP0KyvhnCdae78eyugih9U/nFVzk03gdkmSl4G7qj7WrhBW1u
         QimXgC4tf1+ruU9FL9TgFFmAi6DsHjCumjgjYKUYMqb4AG5+QQMgFfg4YyJLGnIPPHk8
         xFgEccCmLnRusT5zGKDikZUV9UCSm/gQSxexLm7TEUVIWwyTIn44k0pnKowJVHtqXLoa
         B5VRO1jemjG2NKnWJUwSzjbXyaofSqZ8K4jHiKzVxj0mwvMBDwWJI8oXwbqVf7ZoyWcm
         sWhC0tFp+MBWn34NbdKt9rjArEA8uhoxrgIqJ7wUuLOKs8wzn80WSN5EiODyW1yjFcXr
         I9fQ==
X-Gm-Message-State: AOAM532Gzpqfzjaw3AwAeSrVekB//VNY7aYlhvdqK6Fq+Gcnk9fjzXQL
        MXSeVgapnEnWjPSQvPQ/xgPBHMYzKDqdydy0Fn+B+5KK3BDeDPE1V08jbgGqZ7+JOARAp0GBXUc
        7RCfJsRXcXfBHLUshsPony9k=
X-Received: by 2002:adf:9bd9:0:b0:1ef:5b29:3170 with SMTP id e25-20020adf9bd9000000b001ef5b293170mr14630748wrc.28.1646091807196;
        Mon, 28 Feb 2022 15:43:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgAWJRgzfQDyBZpe5K/zqzlYmdu+PAAENqR0tnGcDP4HDQmpPqyvlJxF5CdTyafUynljWE/w==
X-Received: by 2002:adf:9bd9:0:b0:1ef:5b29:3170 with SMTP id e25-20020adf9bd9000000b001ef5b293170mr14630739wrc.28.1646091807003;
        Mon, 28 Feb 2022 15:43:27 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f21-20020a5d58f5000000b001ea99c3397dsm12368091wrd.21.2022.02.28.15.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:25 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 01/14] module: Move all into module/
Date:   Mon, 28 Feb 2022 23:43:09 +0000
Message-Id: <20220228234322.2073104-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

This patch moves all module related code into a separate directory,
modifies each file name and creates a new Makefile. Note: this effort
is in preparation to refactor core module code.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 MAINTAINERS                                         |  2 +-
 kernel/Makefile                                     |  5 +----
 kernel/module/Makefile                              | 12 ++++++++++++
 kernel/{module_decompress.c => module/decompress.c} |  2 +-
 kernel/{module-internal.h => module/internal.h}     |  0
 kernel/{module.c => module/main.c}                  |  2 +-
 kernel/{module_signing.c => module/signing.c}       |  2 +-
 7 files changed, 17 insertions(+), 8 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 rename kernel/{module-internal.h => module/internal.h} (100%)
 rename kernel/{module.c => module/main.c} (99%)
 rename kernel/{module_signing.c => module/signing.c} (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd86ed9fbc79..463bdb829db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13012,7 +13012,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
-F:	kernel/module.c
+F:	kernel/module/
 
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
diff --git a/kernel/Makefile b/kernel/Makefile
index 56f4ee97f328..717075b65deb 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -29,7 +29,6 @@ KCOV_INSTRUMENT_softirq.o := n
 KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
-KCOV_INSTRUMENT_module.o := n
 KCOV_INSTRUMENT_extable.o := n
 KCOV_INSTRUMENT_stacktrace.o := n
 # Don't self-instrument.
@@ -53,6 +52,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-$(CONFIG_MODULES) += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,9 +66,6 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
new file mode 100644
index 000000000000..cdd5c61b8c7f
--- /dev/null
+++ b/kernel/module/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux kernel module support
+#
+
+# These are called from save_stack_trace() on slub debug path,
+# and produce insane amounts of uninteresting coverage.
+KCOV_INSTRUMENT_module.o := n
+
+obj-y += main.o
+obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
+obj-$(CONFIG_MODULE_SIG) += signing.o
diff --git a/kernel/module_decompress.c b/kernel/module/decompress.c
similarity index 99%
rename from kernel/module_decompress.c
rename to kernel/module/decompress.c
index ffef98a20320..d14d6443225a 100644
--- a/kernel/module_decompress.c
+++ b/kernel/module/decompress.c
@@ -12,7 +12,7 @@
 #include <linux/sysfs.h>
 #include <linux/vmalloc.h>
 
-#include "module-internal.h"
+#include "internal.h"
 
 static int module_extend_max_pages(struct load_info *info, unsigned int extent)
 {
diff --git a/kernel/module-internal.h b/kernel/module/internal.h
similarity index 100%
rename from kernel/module-internal.h
rename to kernel/module/internal.h
diff --git a/kernel/module.c b/kernel/module/main.c
similarity index 99%
rename from kernel/module.c
rename to kernel/module/main.c
index 46a5c2ed1928..34a2b0cf3c3e 100644
--- a/kernel/module.c
+++ b/kernel/module/main.c
@@ -58,7 +58,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/audit.h>
 #include <uapi/linux/module.h>
-#include "module-internal.h"
+#include "internal.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
diff --git a/kernel/module_signing.c b/kernel/module/signing.c
similarity index 97%
rename from kernel/module_signing.c
rename to kernel/module/signing.c
index 8723ae70ea1f..8aeb6d2ee94b 100644
--- a/kernel/module_signing.c
+++ b/kernel/module/signing.c
@@ -12,7 +12,7 @@
 #include <linux/string.h>
 #include <linux/verification.h>
 #include <crypto/public_key.h>
-#include "module-internal.h"
+#include "internal.h"
 
 /*
  * Verify the signature on a module.
-- 
2.34.1

