Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B114BFA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiBVONp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiBVONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 664B9B12FE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTqJ9ZbJUCgx8VrF++WoBF0cwmRu2Y/rNRNUF4x8BCg=;
        b=AwbUB03nQM1M9eEhfDbIyUT+TnuMR/dIgtd4mvjLgJOzLy2/NUGqwybItQh/k82I92z28x
        8pfT5Z/sh+nEKZ7+gPSuD6RgRm50K7FP06ybs2bbGmxk/zdprCmBDVLu//Ak613CaUS3hk
        aw5CnfDPjla5rLCArCLh9OTs9+UbfmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-gvjDllLJMzmoiZBdkrsXgw-1; Tue, 22 Feb 2022 09:13:09 -0500
X-MC-Unique: gvjDllLJMzmoiZBdkrsXgw-1
Received: by mail-wm1-f69.google.com with SMTP id z15-20020a1c4c0f000000b00380d331325aso621349wmf.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTqJ9ZbJUCgx8VrF++WoBF0cwmRu2Y/rNRNUF4x8BCg=;
        b=jYsdvz6J0BoFfVFw33kiGXdi5ErAiv96+fedpFyYa5CGoIL7iVmVAJpfc5Ki5L0+U5
         73zK+3zUzaoMyjwvLxordWjN6ocg1ns6imHSNSSYg7VScJeB0I53kjldiN/vVZzU0Vx3
         zTy6KzivgQpKExMW5ntuRhElF+5kAtgf+UZC1WuTgna926IXmK3TtT0ektGSiI3NVfgP
         4OjGkdGiPUyFKvvJgk9dp8RmZGUTZwJk/1AMz9egxYWn+eMcvD7CICYub22i3zVtSLhy
         SChKNh4OZSwGHxfInzdXFmsU8G1hnalz3X0d3NMuA3lchWMGZ2452sBtsPDHTWC/lx13
         2BCg==
X-Gm-Message-State: AOAM531XB2qiUUptgjPUZZDvrqTo7gnxM6MK/eLGTAisVtaXhx8eoXbX
        HYZhYDC0rG/4SxfbylNiXDMHeeMt1ZfoTj1Uh5Zndp7mPoSKmDslp0pYe5kSFVTLItWyAys2FSu
        YB0j1FhPCG8miu3wm6KjCKtY=
X-Received: by 2002:a7b:c3d6:0:b0:380:e3af:7f72 with SMTP id t22-20020a7bc3d6000000b00380e3af7f72mr874954wmj.163.1645539187856;
        Tue, 22 Feb 2022 06:13:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXM1F62VRNxAEps4viqLt6oCxMM2/IbKOn2/cPImwQoKdlmDYfukPhKSKHF+Qi5X3lZPtnjg==
X-Received: by 2002:a7b:c3d6:0:b0:380:e3af:7f72 with SMTP id t22-20020a7bc3d6000000b00380e3af7f72mr874936wmj.163.1645539187700;
        Tue, 22 Feb 2022 06:13:07 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d1sm33255wmq.8.2022.02.22.06.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:07 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 03/13] module: Make internal.h and decompress.c more compliant
Date:   Tue, 22 Feb 2022 14:12:53 +0000
Message-Id: <20220222141303.1392190-4-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will address the following warning and style violations
generated by ./scripts/checkpatch.pl in strict mode:

  WARNING: Use #include <linux/module.h> instead of <asm/module.h>
  #10: FILE: kernel/module/internal.h:10:
  +#include <asm/module.h>

  CHECK: spaces preferred around that '-' (ctx:VxV)
  #18: FILE: kernel/module/internal.h:18:
  +#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG-1))

  CHECK: Please use a blank line after function/struct/union/enum declarations
  #69: FILE: kernel/module/internal.h:69:
  +}
  +static inline void module_decompress_cleanup(struct load_info *info)
						   ^
  CHECK: extern prototypes should be avoided in .h files
  #84: FILE: kernel/module/internal.h:84:
  +extern int mod_verify_sig(const void *mod, struct load_info *info);

  WARNING: Missing a blank line after declarations
  #116: FILE: kernel/module/decompress.c:116:
  +               struct page *page = module_get_next_page(info);
  +               if (!page) {

  WARNING: Missing a blank line after declarations
  #174: FILE: kernel/module/decompress.c:174:
  +               struct page *page = module_get_next_page(info);
  +               if (!page) {

  CHECK: Please use a blank line after function/struct/union/enum declarations
  #258: FILE: kernel/module/decompress.c:258:
  +}
  +static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);

Note: Fortunately, the multiple-include optimisation found in
include/linux/module.h will prevent duplication/or inclusion more than
once.

Fixes: f314dfea16a ("modsign: log module name in the event of an error")
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/decompress.c | 3 +++
 kernel/module/internal.h   | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index d14d6443225a..2fc7081dd7c1 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -113,6 +113,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 
 	do {
 		struct page *page = module_get_next_page(info);
+
 		if (!page) {
 			retval = -ENOMEM;
 			goto out_inflate_end;
@@ -171,6 +172,7 @@ static ssize_t module_xz_decompress(struct load_info *info,
 
 	do {
 		struct page *page = module_get_next_page(info);
+
 		if (!page) {
 			retval = -ENOMEM;
 			goto out;
@@ -256,6 +258,7 @@ static ssize_t compression_show(struct kobject *kobj,
 {
 	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
 }
+
 static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);
 
 static int __init module_decompress_sysfs_init(void)
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ea8c4c02614c..e0775e66bcf7 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -6,7 +6,8 @@
  */
 
 #include <linux/elf.h>
-#include <asm/module.h>
+#include <linux/compiler.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 
 #ifndef ARCH_SHF_SMALL
@@ -54,7 +55,7 @@ struct load_info {
 	} index;
 };
 
-extern int mod_verify_sig(const void *mod, struct load_info *info);
+int mod_verify_sig(const void *mod, struct load_info *info);
 
 #ifdef CONFIG_MODULE_DECOMPRESS
 int module_decompress(struct load_info *info, const void *buf, size_t size);
@@ -65,6 +66,7 @@ static inline int module_decompress(struct load_info *info,
 {
 	return -EOPNOTSUPP;
 }
+
 static inline void module_decompress_cleanup(struct load_info *info)
 {
 }
-- 
2.34.1

