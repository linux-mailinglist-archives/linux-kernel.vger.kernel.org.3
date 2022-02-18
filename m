Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07B14BC1D8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbiBRV0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:26:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbiBRVZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DD082402C1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPUuU8/wCW1qP4n+cpgW0WPpf5qATzz9w+DjJOgqH1k=;
        b=AsTEkyIEBsYFO9837Xqn2lgwGSGjqsaIb7erHmiwzEsNNiN366UdBGQRZA2vXHkQKH7eVa
        V9HYByJHv3yaWNbFAeSlP1kYqdB7/qlekjSPmJuctV28QtXMamjGnW+ZYIlyodFItdiJ/g
        mTZlnL7vWMLtp2KpBWBOCClORrF4Nmg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-596R-h3mP_2E0WkN8vmHoQ-1; Fri, 18 Feb 2022 16:25:15 -0500
X-MC-Unique: 596R-h3mP_2E0WkN8vmHoQ-1
Received: by mail-wm1-f71.google.com with SMTP id 125-20020a1c0283000000b0037bf720e6a8so6463939wmc.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPUuU8/wCW1qP4n+cpgW0WPpf5qATzz9w+DjJOgqH1k=;
        b=zVUzztzbDdIYx6pkdGxMhpiLxw/4h83nPu1kNFzRkAb3oC+dtaEu1XAcQAba0etrbd
         G/A/uG2fZajhBTYIbE5wbqZxM4jIYLxTP4c7z3clVB40R2X+6y9mB8aYLUyNbbjZVD86
         X/kAjWHk5fvQpRGVC/hEmIUE1/EfMcv56fhCjPyMb18bOkkd491g3VeSiVRsFMEZJzG7
         Agi3F1xXRwIfNYPtQEtpSTkExy3Gzb85imJXkOfnDfwEeuIx6UlxVhGsmBdWVGcHtbPH
         6STUDpvfp/XC4pKfbteJ75tgWRWmPaELKQ9UtBeNwQdXAr7jYorGcjytiX+Tvy1DOBEx
         IsyA==
X-Gm-Message-State: AOAM5312eh3Zg2MBHzsMjyUJRg5Vhlv9lVwhXLSHKYHXP/uxppkP4dE9
        A+ZEGpVVQd/KwnU2Gy6dzTqOwD6p3QWmyJaxO95jRNIgzT2KBLWY7NRKE6bfcI8nynHsOSTKJT8
        zCtMeP02EXY+2WQ2ym7TDb6c=
X-Received: by 2002:adf:ecc5:0:b0:1e5:7908:966b with SMTP id s5-20020adfecc5000000b001e57908966bmr7169897wro.661.1645219514332;
        Fri, 18 Feb 2022 13:25:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1bDwGyCe3fdOy1XA3oeI4R4NKw2Ep8j5BTykIngcZyjVI2YIxemEDiVkrdxvwl8vfECY9fQ==
X-Received: by 2002:adf:ecc5:0:b0:1e5:7908:966b with SMTP id s5-20020adfecc5000000b001e57908966bmr7169873wro.661.1645219513960;
        Fri, 18 Feb 2022 13:25:13 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o4sm562796wms.9.2022.02.18.13.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:25:13 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 01/13] module: Move all into module/
Date:   Fri, 18 Feb 2022 21:24:59 +0000
Message-Id: <20220218212511.887059-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218212511.887059-1-atomlin@redhat.com>
References: <20220218212511.887059-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

This patch moves all module related code into a separate directory,
modifies each file name and creates a new Makefile. Note: this effort
is in preparation to refactor core module code.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 MAINTAINERS                                         | 2 +-
 kernel/Makefile                                     | 5 +----
 kernel/module/Makefile                              | 9 +++++++++
 kernel/{module_decompress.c => module/decompress.c} | 2 +-
 kernel/{module-internal.h => module/internal.h}     | 0
 kernel/{module.c => module/main.c}                  | 2 +-
 kernel/{module_signature.c => module/signature.c}   | 0
 kernel/{module_signing.c => module/signing.c}       | 2 +-
 8 files changed, 14 insertions(+), 8 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module_decompress.c => module/decompress.c} (99%)
 rename kernel/{module-internal.h => module/internal.h} (100%)
 rename kernel/{module.c => module/main.c} (99%)
 rename kernel/{module_signature.c => module/signature.c} (100%)
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
index 56f4ee97f328..3a6380975c57 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -53,6 +53,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,10 +67,6 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
-obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
new file mode 100644
index 000000000000..2902fc7d0ef1
--- /dev/null
+++ b/kernel/module/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux kernel module support
+#
+
+obj-$(CONFIG_MODULES) += main.o
+obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
+obj-$(CONFIG_MODULE_SIG) += signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
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
diff --git a/kernel/module_signature.c b/kernel/module/signature.c
similarity index 100%
rename from kernel/module_signature.c
rename to kernel/module/signature.c
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

