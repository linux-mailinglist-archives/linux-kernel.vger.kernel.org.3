Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0EE4A020C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbiA1Ujp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238856AbiA1Ujk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JV4WzeMBxzAOtiGbJsE6/WwOSD8dA4tNDcXqNuD6cVU=;
        b=FboyR/uo1030jotymSUg15EQ18DVcHPCp7JHtivRPl5f7hpTEgtRrweL+m5FFYsabTfqX7
        Whn8FvYzvWyo+t/Wtf6bDPWQ+smQOYBkZb+wl7/dBpY44/U8kjeNCWBjJXBVNC0B+cl/y+
        aFtfd2+/LF89del3QryMDLv4c4zCYlU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-xM9XmDMkPC6LVs_KnjLcaQ-1; Fri, 28 Jan 2022 15:39:38 -0500
X-MC-Unique: xM9XmDMkPC6LVs_KnjLcaQ-1
Received: by mail-wm1-f69.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so1681327wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JV4WzeMBxzAOtiGbJsE6/WwOSD8dA4tNDcXqNuD6cVU=;
        b=jjNz1vz9IEi0WeTsS4GtnIkkuZcNgEDizcLtv0ifWrF9OSRJD1sipKjFeUAewtjPRh
         glSvhBSA1qMZ4ap0pB0CZtRLe7ate3mu1KIUpfAjkzha5VEaJ4ZgFdCM1UwQ9fFmcsZ9
         N3TR3vDAA//wzu3XHAmuKSAwxQgtl464waE+U2Fqa05WpDypZJ5+LAARFSnxGJvwAB6e
         8Bt4o3cIoagJFG25D8FrlINVRt/ua4TI/sqmjgQei/cZlEo6ncOV/+7A5SUfldEOn4qV
         tT4zsIUq7sASClm4NxtPksYaoZkw5/JYzx5MV/zhnP75T9vIRSHuz5BBws2QXOYgXDyi
         WekQ==
X-Gm-Message-State: AOAM531Bt9A8+LgGa2nksDT3uSCisGB5xJLguhiznZzIJHvl/tj4Ifbo
        i1o3Xu+4KDkKswHUV8z+IH+cSlsxnXAOFbHG7JV/2n8Z2vfJEc/OY1ghlq7bC0JAyZAV/c27YC7
        8UEVR0QKEoyIv/pWRMC0/24w=
X-Received: by 2002:a05:6000:1e1b:: with SMTP id bj27mr8365760wrb.657.1643402377396;
        Fri, 28 Jan 2022 12:39:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwat6ybFLb9gq0x9VWY0GfMIL4ymq66PC7SK70+KVL+qPaj3vREMNy9pj2QUs5R9Xd6zRb2Yg==
X-Received: by 2002:a05:6000:1e1b:: with SMTP id bj27mr8365738wrb.657.1643402377137;
        Fri, 28 Jan 2022 12:39:37 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d2sm5383316wru.40.2022.01.28.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:36 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 01/13] module: Move all into module/
Date:   Fri, 28 Jan 2022 20:39:22 +0000
Message-Id: <20220128203934.600247-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128203934.600247-1-atomlin@redhat.com>
References: <20220128203934.600247-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index acd112c42255..a98f4700acb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12976,7 +12976,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
 F:	include/linux/module.h
-F:	kernel/module.c
+F:	kernel/module/main.c
 
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
index b01c69c2ff99..c153fd8a4444 100644
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
index 387ee77bdbd6..d8c6269af6cf 100644
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

