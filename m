Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BA4BE4F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355901AbiBULRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:17:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355873AbiBULPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1434CF6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u5so12596509ple.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehNQdlI9mPXdldG87wHGJGXW6GsgTB2HkJJp4vDiMvs=;
        b=qlaVWsO4wSTU3J0DH2Hpj3dMsi97mWHbdhECMnS3joUeasrk2uCdT2Jsmn+qIr9fLe
         rViNtkASpFYzpkolR6zh0SSWu6KdwdyStVhbZtvJPmsetjJYkEodcgwRZToKocOqYzXp
         2aONPUD1l/wjsooqbu2AT9/xm2Es0hJdg6t1ldwpTs1qoGcNK3P0NOimVfqpqulx8+jY
         A9E6Y7dM5wGAqY3f7dDQHAVGyZZ2KSNUulpKOWtTqp5ppCG94DDmaysD/n5TwvITPAj3
         wRKyP8MX8+1pwmDbCM0zemfWRrbDL5678sUQC/T8/T70yB9PPlieHMoRTd3hFflEyvqy
         ROkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehNQdlI9mPXdldG87wHGJGXW6GsgTB2HkJJp4vDiMvs=;
        b=uU/PIAqo8WRfgragZny2QrXCxc9VBdTFP4jCBEqpmsXq9CTvqZS5Ur9PPVnM5+DVED
         o3hFZWCju9BhoJ7SYa52GxKETkyV7mf/cn/LqYWsBSToEMWzaIlpYNgriXT86l/WT8v2
         hdwcHrcHnmDqr2tsagB85o23MJObyNxArlu0+oN1SgrdCMgFi9C28U6QKoi0Tis2HNkG
         3LoR0XFIL7Bm/o4nCC6nT+xpe2DlWOhMTRihlOT43OoiT5RdFhTI06aLlvetGYxYAxY5
         6xMgXnBsNOv0/yD7PpHXBoCDnhlm6ATqGAbNM0ewx/oYjW2O1FPQw9PmtlLTNITblTWT
         7cYw==
X-Gm-Message-State: AOAM533Ej8GdTlNSPOP1BEX2C6ejwXJb7iGIQSppVCW8owx0rOYGLkL+
        q419r2z+rCAoVmqy9cfgqLo=
X-Google-Smtp-Source: ABdhPJxy1hS2KmSmwp4qNm1k1FKMOHVd+tQ3HzzZmVsC3p1rRBWwpEZvPh4IIAH8r4LS58T0mexUGQ==
X-Received: by 2002:a17:902:b091:b0:14b:4b27:48d1 with SMTP id p17-20020a170902b09100b0014b4b2748d1mr18959339plr.52.1645440843472;
        Mon, 21 Feb 2022 02:54:03 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id u6sm2214725pfk.203.2022.02.21.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:54:03 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported size
Date:   Mon, 21 Feb 2022 10:53:34 +0000
Message-Id: <20220221105336.522086-4-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220221105336.522086-1-42.hyeyoo@gmail.com>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SLAB's kfree() does not support freeing an object that is allocated from
kmalloc_large(). Fix this as SLAB do not pass requests larger than
KMALLOC_MAX_CACHE_SIZE directly to page allocator.

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/slab.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 37bde99b74af..aeda3e863f2b 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -564,15 +564,19 @@ static __always_inline __alloc_size(1) void *kmalloc_large(size_t size, gfp_t fl
  *	Try really hard to succeed the allocation but fail
  *	eventually.
  */
+#ifndef CONFIG_SLOB
 static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
-#ifndef CONFIG_SLOB
 		unsigned int index;
-#endif
-		if (size > KMALLOC_MAX_CACHE_SIZE)
-			return kmalloc_large(size, flags);
-#ifndef CONFIG_SLOB
+
+		if (size > KMALLOC_MAX_CACHE_SIZE) {
+			if (IS_ENABLED(CONFIG_SLUB))
+				return kmalloc_large(size, flags);
+			else
+				return NULL;
+		}
+
 		index = kmalloc_index(size);
 
 		if (!index)
@@ -581,10 +585,17 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 		return kmem_cache_alloc_trace(
 				kmalloc_caches[kmalloc_type(flags)][index],
 				flags, size);
-#endif
 	}
 	return __kmalloc(size, flags);
 }
+#else
+static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
+{
+	if (__builtin_constant_p(size) && size > KMALLOC_MAX_CACHE_SIZE)
+		return kmalloc_large(size, flags);
+	return __kmalloc(size, flags);
+}
+#endif
 
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
-- 
2.33.1

