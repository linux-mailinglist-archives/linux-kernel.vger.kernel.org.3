Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B27572EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbiGMHVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGMHVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47E13BA152
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657696877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bzHcA1yQj57CCPYm74jUoouv+RLrdBI+n61plkR9Go=;
        b=MFKJGyFoex48bbIRmOswUJsYPG5wodEwgrasX/VU+vhulaKcshfQ8Hj2FiR+fmqGars6HW
        xVkTgtSo7eY7TLXvoCXmvaB47C8iTEmW72bDaRcHc5ntGL8ELVfkBNtOeyov3yGx3aNIwM
        1wAhgkUAfgMhVRuLN6G/lAmaAZfOmwQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-lCP0JD7TOf60zgwSCA9WWg-1; Wed, 13 Jul 2022 03:21:16 -0400
X-MC-Unique: lCP0JD7TOf60zgwSCA9WWg-1
Received: by mail-pg1-f200.google.com with SMTP id q132-20020a632a8a000000b00411eb01811fso4661548pgq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bzHcA1yQj57CCPYm74jUoouv+RLrdBI+n61plkR9Go=;
        b=v+Cj2sxIlx6TWPbtGHYtSZfx1nZTYJE99yXtKntdNUW2vPLxz4ANvgsgs9X1Lw1hHl
         duvXg37xe45V9mqiw9D/gXheNgPCKQnOr65Qq8YZl1B8fwbhp5OpSqy0sMhx/HtjasiT
         sWYWSLe4Gy7fldSYqJe+4De20iWAM5pKVU5KNambAija+Vs8CCWY9wZgaE+AWmL94WZF
         txDccrELYKr9IIxVNDVGS0qKuamPYcDgf3YEQfD1WWoPv5PKXMKZjAU6Wt1mU+NsHg0i
         Vo9u8as7W+4bBdr4+PM4sKYcWym850s5XjBC2NO4iWdsoCCFd6qzY1gTihVT15UKlsBy
         Kw/g==
X-Gm-Message-State: AJIora95fBN3DP9IbE6976UyJnIv8J7vFmt/hHF/+Tki3ZTwmX/G3ndY
        OjRbnQ64XNfkz4wr5FaAo2CriPMtfydRG3DGzFZtbzzKy2Npg6Q0+vCnnESplWj7owVf/lIejQH
        9m1mchS1YRCAXpEAYHp55uGAV
X-Received: by 2002:a17:902:e153:b0:16b:dccf:5a89 with SMTP id d19-20020a170902e15300b0016bdccf5a89mr2137309pla.69.1657696874946;
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBQYf48YTRO3J0cXEwN13e016x/uaZqgH8q/LrUIWqrRZZ1fxgfGwjni6KBVsTw3wzYIRdGg==
X-Received: by 2002:a17:902:e153:b0:16b:dccf:5a89 with SMTP id d19-20020a170902e15300b0016bdccf5a89mr2137291pla.69.1657696874696;
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
Received: from localhost ([240e:3a1:31b:3d30:c711:d753:abde:647d])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b0016c5b2a16ffsm2912305plb.142.2022.07.13.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 00:21:14 -0700 (PDT)
From:   Coiby Xu <coxu@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
Subject: [PATCH v2] ima: force signature verification when CONFIG_KEXEC_SIG is configured
Date:   Wed, 13 Jul 2022 15:21:11 +0800
Message-Id: <20220713072111.230333-1-coxu@redhat.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712093302.49490-1-coxu@redhat.com>
References: <20220712093302.49490-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
v2
 - don't include linux/kexec.h since it's already been included in
   linux/ima.h
 - fix build errors when KEXEC_FILE/KEXEC_CORE is disable as caught by
   kernel test robot <lkp@intel.com>

---
 include/linux/kexec.h            |  6 ++++++
 kernel/kexec_file.c              | 11 ++++++++++-
 security/integrity/ima/ima_efi.c |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ce6536f1d269..475683cd67f1 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -452,6 +452,12 @@ static inline int kexec_crash_loaded(void) { return 0; }
 #define kexec_in_progress false
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_KEXEC_SIG
+void set_kexec_sig_enforced(void);
+#else
+static inline void set_kexec_sig_enforced(void) {}
+#endif
+
 #endif /* !defined(__ASSEBMLY__) */
 
 #endif /* LINUX_KEXEC_H */
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
index 71786d01946f..9db66fe310d4 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -67,6 +67,8 @@ const char * const *arch_get_ima_policy(void)
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

