Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2D04BC1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbiBRV0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:26:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiBRVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:25:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 214382402C1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTqJ9ZbJUCgx8VrF++WoBF0cwmRu2Y/rNRNUF4x8BCg=;
        b=hSRjPNl2igdotrW7hpJVF570X04Qxyvqll1IOx71y/TDJkJXG6JsY0Ldcvu3xoqPqWEOyC
        H4FwOLPbX3rqwPw32T0YitdDozDTDtv8y7PJORMsx+gMMopWjc2W5WM/yVLNytSk24KjQj
        mmXrrxyuVLdVE6uhGubKYSX4x1r2Jqw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-hkX32_i9NUy6BzbXG2Mzqw-1; Fri, 18 Feb 2022 16:25:18 -0500
X-MC-Unique: hkX32_i9NUy6BzbXG2Mzqw-1
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso6464747wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTqJ9ZbJUCgx8VrF++WoBF0cwmRu2Y/rNRNUF4x8BCg=;
        b=yRgL3o2bdX26K2imZivaa7nFBIkfgQo7VIfaHd8AaiLe7xwpGWs98M/KHn/Nj0Gzm2
         VVTSuJH0rCBO2k7x68oBMnt9Jakk13DsDmCrpX5nCW+U+bJXLW0yR8VD2gvoiVCrXFUx
         4Wr9/cagkkRaJf3ul48MUR+L2/TqvFSEerRbHH1OCpA9HmdYtFQeDn9nYAzY+SSJ+oaA
         sgvJnsQRmXza8+v4aspOMuJaPPpvSRt8p0qwNKETwoUZFuntP+Rn2FQeMACNDR558oM8
         K8XE0HIYzsk1CvZGXhb041gr+3o2ppr6Ft2Q4GH3T5yBphNmi5D/Mc8CN4P+mW/IZpNW
         mwEw==
X-Gm-Message-State: AOAM533p59QLxc+h2r2QytD5XTrL1b2iSK6kaQwLV1xL50mrGvec4Njt
        arvxnMRsPX0tWBwnrLUXr7E45EfPy7c8JmG5fc4oD3kObviN7EKMSBScqAJWa/hajgk3OOebSNO
        m/7Q+F/u9//s1P2R6tPNkOKs=
X-Received: by 2002:a05:6000:1813:b0:1e7:6ac7:d6be with SMTP id m19-20020a056000181300b001e76ac7d6bemr7502145wrh.54.1645219517038;
        Fri, 18 Feb 2022 13:25:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw22CPgUBXuOIWwUF4Vs7kU+E/iFFGVYUTwCba+1kpLI1JYsMJISA7h2h1doT5as8bFZQJxAw==
X-Received: by 2002:a05:6000:1813:b0:1e7:6ac7:d6be with SMTP id m19-20020a056000181300b001e76ac7d6bemr7502137wrh.54.1645219516801;
        Fri, 18 Feb 2022 13:25:16 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c7417000000b0037bf902737esm560539wmc.9.2022.02.18.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:25:16 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 03/13] module: Make internal.h and decompress.c more compliant
Date:   Fri, 18 Feb 2022 21:25:01 +0000
Message-Id: <20220218212511.887059-4-atomlin@redhat.com>
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

