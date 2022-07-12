Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B515715D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiGLJdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiGLJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 732E29FE18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657618401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C8hxIj8W6IqTe1eGgWCKuGOk0xM/C1HXIo4o+0ApBic=;
        b=QkNbrCq1S+ovLAgh7RzMK7E2ZhWBqYUkvxuvjGH34ImSbIqQ6uEqsrgpRLySU28fkrxBd0
        LeQrG0Asx6gC8DQ+EPwtqYe31cFLjWAnrX2RlbrvdWayCSTcHLZuM4FCMCFyhum21D4l8U
        IwMfA0E3jP6LtsqPkc9Qsl+nM/xhYdY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-H-vhAaBbNqK4-mAX75j4Vw-1; Tue, 12 Jul 2022 05:33:12 -0400
X-MC-Unique: H-vhAaBbNqK4-mAX75j4Vw-1
Received: by mail-pj1-f69.google.com with SMTP id oc6-20020a17090b1c0600b001ef75cb2382so7295898pjb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C8hxIj8W6IqTe1eGgWCKuGOk0xM/C1HXIo4o+0ApBic=;
        b=FnUv78/EyOF32HgU7/+Eebep5hg+ePJe4d9vjUuT98a7sRgMPMdBMeni1nDINsf368
         9mDxSmZs5ip6tdNUabQQTD2o/YnUVIs/sl5GDhI8eB4bqCmyHa54OFJQxBgctntMWUAb
         GvfDMjML5iabKweMF5M80BmCwAZ0kjOlYaX+ida7PHIijoTuqgIQIUL+IbGh/lzefMxv
         ZVwLcXnm62lGYWPvCMbL7xFLPQGTGebaGF4CU6vT/em2A8Ksk19lGQmEko+1rjkU4BRL
         q8AO/A9XqM0gIo4NqtfEPSXZxG3xNRJj2+d9DAD4fkTdRu9jhfXLuGcvP6R8Fjzevz8b
         GLKQ==
X-Gm-Message-State: AJIora9kgpTliYBF+juHT+kTor/+Lb7ZL0Cnt1NcSJGOPYQAwdhnCO5j
        0k3Nj/X1fXLhbLU2VYCy/lXWaiSOoSG+woRlbWewZOyaxutJNFPqAWUNreocli8meOaPFF83iQc
        WK7AVQkq8DEwZFjDJto1SWONy
X-Received: by 2002:a17:90b:3143:b0:1f0:3971:37ae with SMTP id ip3-20020a17090b314300b001f0397137aemr3053910pjb.223.1657618390970;
        Tue, 12 Jul 2022 02:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOFdkJayybBuHE8OnzykQjiCZL0lFlbFjIsgPcu72kuqlDypFwfzh30+3NjLaon1pSkzF5jw==
X-Received: by 2002:a17:90b:3143:b0:1f0:3971:37ae with SMTP id ip3-20020a17090b314300b001f0397137aemr3053889pjb.223.1657618390754;
        Tue, 12 Jul 2022 02:33:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b0015e8d4eb26esm6247747pli.184.2022.07.12.02.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 02:33:09 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH] ima: force signature verification when CONFIG_KEXEC_SIG is configured
Date:   Tue, 12 Jul 2022 17:33:01 +0800
Message-Id: <20220712093302.49490-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, an unsigned kernel could be kexec'ed when IMA arch specific
policy is configured unless lockdown is enabled. Enforce kernel
signature verification check in the kexec_file_load syscall when IMA
arch specific policy is configured.

Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")
Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h            |  3 +++
 kernel/kexec_file.c              | 11 ++++++++++-
 security/integrity/ima/ima_efi.c |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..4b8e8d5bcea9 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -134,6 +134,9 @@ typedef int (kexec_cleanup_t)(void *loader_data);
 #ifdef CONFIG_KEXEC_SIG
 typedef int (kexec_verify_sig_t)(const char *kernel_buf,
 				 unsigned long kernel_len);
+void set_kexec_sig_enforced(void);
+#else
+static inline void set_kexec_sig_enforced(void) {}
 #endif
 
 struct kexec_file_ops {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 145321a5e798..f9261c07b048 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -29,6 +29,15 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#ifdef CONFIG_KEXEC_SIG
+static bool sig_enforce = IS_ENABLED(CONFIG_KEXEC_SIG_FORCE);
+
+void set_kexec_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+#endif
+
 static int kexec_calculate_store_digests(struct kimage *image);
 
 /*
@@ -159,7 +168,7 @@ kimage_validate_signature(struct kimage *image)
 					   image->kernel_buf_len);
 	if (ret) {
 
-		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
+		if (sig_enforce) {
 			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
 			return ret;
 		}
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 71786d01946f..ae3fe4cb8d86 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2018 IBM Corporation
  */
 #include <linux/efi.h>
+#include <linux/kexec.h>
 #include <linux/module.h>
 #include <linux/ima.h>
 #include <asm/efi.h>
@@ -67,6 +68,8 @@ const char * const *arch_get_ima_policy(void)
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
 		if (IS_ENABLED(CONFIG_MODULE_SIG))
 			set_module_sig_enforced();
+		if (IS_ENABLED(CONFIG_KEXEC_SIG))
+			set_kexec_sig_enforced();
 		return sb_arch_rules;
 	}
 	return NULL;
-- 
2.35.3

