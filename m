Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B05486DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245667AbiAFXn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37919 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245650AbiAFXnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyE/rafatlrcvSG+3VXfXdUjnRRYymu/M4FMEAKWVLk=;
        b=LFfflWQot5SsDsuwi7CDWLcm0UVuoK+mjLms4koODye0GTkO3ZiNOW83j+So0feqBmWx+M
        GC1TaNnNW85q58vd8CFNHQLvBWz/lncaHEeQ5kntwIJ16q4sTIse3K+RXkoqpPP3LLbvQB
        Y2w4jad/giWUgD1Oz5tEgDkO/DFuKq4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-V6c8UH_HP5Gt2ke0XSRp3A-1; Thu, 06 Jan 2022 18:43:23 -0500
X-MC-Unique: V6c8UH_HP5Gt2ke0XSRp3A-1
Received: by mail-wm1-f69.google.com with SMTP id j8-20020a05600c1c0800b00346504f5743so3711201wms.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyE/rafatlrcvSG+3VXfXdUjnRRYymu/M4FMEAKWVLk=;
        b=zoVZwlECj19oupcyJ5rCbT07CTD27lc7boBJU6UA68AQbUoeWtjHUG0nOnaNUHqbky
         QGay2empoLR/mYO3317PEMPrzoYjiyw5GuD14wr2Bw7uiiOSs12HPquyz3/8gVyFrMiA
         dnxSmLMxU63MGd+BLUI8ozCgsdCYtDyUkhypyK1OYZ2IL3ddiA9tw8NRB2K82nwJbZ5l
         EQpMz5w7hbOKzx3wYleGEuQQxdfbXuPqp36wBDkYtpPbMzELqMdi2C1mk/oa/APNfBRV
         cbCyStP1Lmgy4rWSeZGxI6vXZHbHmnTqXUZBxLyNS6QUhtYNCPXk9hbneJsR67fvzjDE
         HcPw==
X-Gm-Message-State: AOAM532XgoLioL/WU4eq+STOPYz9H6Cx4NvesiaxKLelgcLFnWn+tc4O
        Yj5p9givtLezVrPL+6froSf0AIWuubBgHJYd6f9aUpuYXth35dAyOK/F2v9QdqWB7SkAKKkMLJ9
        DxohpjWGdpCwQzMvkueFHCo8=
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr53930757wru.214.1641512601960;
        Thu, 06 Jan 2022 15:43:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJhffB0dpg6oGHUQNFSFkg/qC08YbIqi4Mx30aFYk6lufiRoNcDdwwndLXBDpzZFYVo98Bqg==
X-Received: by 2002:a5d:4d91:: with SMTP id b17mr53930747wru.214.1641512601830;
        Thu, 06 Jan 2022 15:43:21 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l2sm3214313wru.83.2022.01.06.15.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:21 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 01/13] module: Move all into module/
Date:   Thu,  6 Jan 2022 23:43:07 +0000
Message-Id: <20220106234319.2067842-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
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
 kernel/Makefile                                   | 4 +---
 kernel/module/Makefile                            | 8 ++++++++
 kernel/{module-internal.h => module/internal.h}   | 0
 kernel/{module.c => module/main.c}                | 2 +-
 kernel/{module_signature.c => module/signature.c} | 0
 kernel/{module_signing.c => module/signing.c}     | 2 +-
 6 files changed, 11 insertions(+), 5 deletions(-)
 create mode 100644 kernel/module/Makefile
 rename kernel/{module-internal.h => module/internal.h} (100%)
 rename kernel/{module.c => module/main.c} (99%)
 rename kernel/{module_signature.c => module/signature.c} (100%)
 rename kernel/{module_signing.c => module/signing.c} (97%)

diff --git a/kernel/Makefile b/kernel/Makefile
index 4df609be42d0..466477d4dafe 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -53,6 +53,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += module/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
@@ -66,9 +67,6 @@ ifneq ($(CONFIG_SMP),y)
 obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
-obj-$(CONFIG_MODULES) += module.o
-obj-$(CONFIG_MODULE_SIG) += module_signing.o
-obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_CRASH_CORE) += crash_core.o
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
new file mode 100644
index 000000000000..a9cf6e822075
--- /dev/null
+++ b/kernel/module/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for linux kernel module support
+#
+
+obj-$(CONFIG_MODULES) += main.o
+obj-$(CONFIG_MODULE_SIG) += signing.o
+obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
diff --git a/kernel/module-internal.h b/kernel/module/internal.h
similarity index 100%
rename from kernel/module-internal.h
rename to kernel/module/internal.h
diff --git a/kernel/module.c b/kernel/module/main.c
similarity index 99%
rename from kernel/module.c
rename to kernel/module/main.c
index ed13917ea5f3..bc997c3e2c95 100644
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
2.31.1

