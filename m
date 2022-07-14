Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6E857554E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbiGNSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiGNSqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:46:04 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CEF6B247
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:46:03 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h132so2350928pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzXP+vXdjYyDu382JAcOQCgNko9sM9CbLymKz90vfi4=;
        b=JDXGv5/QpSFa7dfFioltvaPc9IQ9RfiMKSVI1A9t5EAG1SuSA9V8UPFuRiEqyRbknm
         ldhnO6aJ7EMCPUrNvszf2VpKuZAs3Q7HTewfXl89dca35gw19nWbYf43WQVCycNd06ls
         GLCV6kYvRmCJ1qbaQnowF3bPpkv0mTGrX+OVORQCWmqt4BCdAICyy7/rQ2im2ykTkkHJ
         GghA3t8TUGedw9rM/bOHJV5yXzV8Ih/KfS6D/Mn8mzT6Lao5UZhc/T+buyd0adofVTXs
         E2d0YCy3E1hdN4xetNAeeu2YOJ3muzMYpYZz1lr1Pm8pF2LOeW6rf2AetxwscPgYqn1I
         ytzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=JzXP+vXdjYyDu382JAcOQCgNko9sM9CbLymKz90vfi4=;
        b=QJxFxF3IyViOrj5aT/Ci1BEMNCCHcSTaTYt5rvGLmudF8u5zc/hveTwjUIqBWpH2LC
         yrbAMMiiyhL5oZO84pbREQZj4dHQ+WcIlXklJyurRj8UOmkaFPGBis4zaMSV6KGRPGfX
         Z6fBYIIcADc5LvaDLnKy2RtZ3os5hUv/nUnDjKmwMA8GT9ji9V7TCpdb5xv4YT8HYvzD
         2TvIgzrdjp+29Tjq7Q5q+Obsii0Zp5KWg/nArB55ezktDAFrxD5Mb2bcZYFePgPQQriw
         A5M4gXfqHXRCRZ2MX+OiKdEcTAJMm0yKIGiTJ/P0eE3hCuDfaYoB22Lvcpr5TpG7wmPN
         9gaQ==
X-Gm-Message-State: AJIora9LxS61l357dsCTr0atyWBNpABL18PhZQl7/SrlshEUk/bs1dYd
        LBBKVwJBXPisNUelY+N/EN4=
X-Google-Smtp-Source: AGRyM1tQs1MKHS+UjO4sI1iWg7cnyp6gD9ZEhmzbb9c8gJ2orozUfEiOzlWIZbX0k5yiG44xXoL3fQ==
X-Received: by 2002:a63:2a89:0:b0:412:4d97:c687 with SMTP id q131-20020a632a89000000b004124d97c687mr8982923pgq.575.1657824362498;
        Thu, 14 Jul 2022 11:46:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ij19-20020a170902ab5300b0016b865ea2ddsm1798469plb.85.2022.07.14.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:46:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Richard Weinberger <richard@nod.at>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] um: Replace to_phys() and to_virt() with less generic function names
Date:   Thu, 14 Jul 2022 11:46:00 -0700
Message-Id: <20220714184600.3981953-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to_virt() and to_phys() are very generic and may be defined by drivers.
As it turns out, commit 9409c9b6709e ("pmem: refactor pmem_clear_poison()")
did exactly that. This results in build errors such as the following
when trying to build um:allmodconfig.

drivers/nvdimm/pmem.c: In function ‘pmem_dax_zero_page_range’:
./arch/um/include/asm/page.h:105:20: error:
			too few arguments to function ‘to_phys’
  105 | #define __pa(virt) to_phys((void *) (unsigned long) (virt))
      |                    ^~~~~~~

Use less generic function names for the um specific to_phys() and to_virt()
functions to fix the problem and to avoid similar problems in the future.

Fixes: 9409c9b6709e ("pmem: refactor pmem_clear_poison()")
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/um/include/asm/page.h      | 4 ++--
 arch/um/include/shared/mem.h    | 4 ++--
 arch/um/os-Linux/skas/process.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/page.h b/arch/um/include/asm/page.h
index 95af12e82a32..cdbd9653aa14 100644
--- a/arch/um/include/asm/page.h
+++ b/arch/um/include/asm/page.h
@@ -102,8 +102,8 @@ extern unsigned long uml_physmem;
  * casting is the right thing, but 32-bit UML can't have 64-bit virtual
  * addresses
  */
-#define __pa(virt) to_phys((void *) (unsigned long) (virt))
-#define __va(phys) to_virt((unsigned long) (phys))
+#define __pa(virt) uml_to_phys((void *) (unsigned long) (virt))
+#define __va(phys) uml_to_virt((unsigned long) (phys))
 
 #define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
 #define pfn_to_phys(pfn) PFN_PHYS(pfn)
diff --git a/arch/um/include/shared/mem.h b/arch/um/include/shared/mem.h
index 4862c91d4213..98aacd544108 100644
--- a/arch/um/include/shared/mem.h
+++ b/arch/um/include/shared/mem.h
@@ -9,12 +9,12 @@
 extern int phys_mapping(unsigned long phys, unsigned long long *offset_out);
 
 extern unsigned long uml_physmem;
-static inline unsigned long to_phys(void *virt)
+static inline unsigned long uml_to_phys(void *virt)
 {
 	return(((unsigned long) virt) - uml_physmem);
 }
 
-static inline void *to_virt(unsigned long phys)
+static inline void *uml_to_virt(unsigned long phys)
 {
 	return((void *) uml_physmem + phys);
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 87d3129e7362..c316c993a949 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -251,7 +251,7 @@ static int userspace_tramp(void *stack)
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGWINCH, SIG_IGN);
 
-	fd = phys_mapping(to_phys(__syscall_stub_start), &offset);
+	fd = phys_mapping(uml_to_phys(__syscall_stub_start), &offset);
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 	if (addr == MAP_FAILED) {
@@ -261,7 +261,7 @@ static int userspace_tramp(void *stack)
 	}
 
 	if (stack != NULL) {
-		fd = phys_mapping(to_phys(stack), &offset);
+		fd = phys_mapping(uml_to_phys(stack), &offset);
 		addr = mmap((void *) STUB_DATA,
 			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 			    MAP_FIXED | MAP_SHARED, fd, offset);
@@ -534,7 +534,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	struct stub_data *data = (struct stub_data *) current_stack;
 	struct stub_data *child_data = (struct stub_data *) new_stack;
 	unsigned long long new_offset;
-	int new_fd = phys_mapping(to_phys((void *)new_stack), &new_offset);
+	int new_fd = phys_mapping(uml_to_phys((void *)new_stack), &new_offset);
 
 	/*
 	 * prepare offset and fd of child's stack as argument for parent's
-- 
2.35.1

