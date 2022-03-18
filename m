Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FBD4DD7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 11:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiCRKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiCRKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:10:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D751FAA21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so7912000pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwEC4WbmrPNUQyCrBW01Ge/3AIxEgFtA8vMHcjbrgUI=;
        b=pFHhxarl1w/haQopvFTYGEKrEjTDEhvc8Y1ROTjzbsriOVSGD0TQodxuvP1n0E6JNC
         4JTGW8wGVt/u3qZ1fafuRXfUKMC8dbMNbHQ8FtNmDVtslx/osFnOLyluZYRPKeqd7WO+
         kvpsqJPYVkqB55mTsG9Yq5kqf8C1hiz/b7R/LOmdtescHgXs6yhEs6goe7fm3VvJf0e4
         OYqI0i+ACvgaq5PU/BoG6nz3FGrsEyCldcGViA+PAL+a/6gg1X06B4Ba4LeT5H21Gz0G
         MHe9kY0KO2xqSlMlgbddMN6fpgag/+X2DGKiKFxyIRJ3EjN7GbIH/M/+gsCUZf8+maC8
         9J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwEC4WbmrPNUQyCrBW01Ge/3AIxEgFtA8vMHcjbrgUI=;
        b=KDQ69qrKMwyBidMrRQp/LEL+nEkJbxiXFtgXdA8I46UAifDH5Ho02i1yzbJapS1VqK
         ciiqrzzEX/GmO9v7felXDIYu82AYbUAGCTQxJkGzRYk7K/OkR+Ygj8+DTqICN6y2vzU1
         Vr7Y7UC+xmudQoJGBrVocs4766dK5eFZLDdvoJKygyQgjaqdVMk0LYotmXKGRF+J/D8f
         8hBUgm2BoDBYSb/gdlkS3n+fS7yBTRqVhAPQhn7e+QsPYVrDH08CQPI1pl2S4WqnWxYU
         nW9Q4EpGxzBRgL1WAgnFPKO8r51b397MkTcknRZU9Xbb17edg20vJirGQvw3ui2Rut1u
         Xwhg==
X-Gm-Message-State: AOAM531g0geC3Xdz1kUiEGeu6/1Ct6m70lXf/GPQPiLXwGbnUNJt1nr3
        bDwEwxpje/90yXcS3dpVStnrig==
X-Google-Smtp-Source: ABdhPJwDnJVONODWzHybiJauSNnambY6vz8I3zJjMpEe1c+AtPn5LnIfdtAUWQvTdXzU3GQHegb/cA==
X-Received: by 2002:a17:902:e74b:b0:152:fef9:a56 with SMTP id p11-20020a170902e74b00b00152fef90a56mr9624097plf.58.1647598159884;
        Fri, 18 Mar 2022 03:09:19 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004fa042e8216sm9541252pfj.2.2022.03.18.03.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 03:09:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/4] mm: memory_hotplug: override memmap_on_memory when hugetlb_free_vmemmap=on
Date:   Fri, 18 Mar 2022 18:07:18 +0800
Message-Id: <20220318100720.14524-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220318100720.14524-1-songmuchun@bytedance.com>
References: <20220318100720.14524-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When "hugetlb_free_vmemmap=on" and "memory_hotplug.memmap_on_memory"
are both passed to boot cmdline, the variable of "memmap_on_memory"
will be set to 1 even if the vmemmap pages will not be allocated from
the hotadded memory since the former takes precedence over the latter.
In the next patch, we want to enable or disable the feature of freeing
vmemmap pages of HugeTLB via sysctl.  We need a way to know if the
feature of memory_hotplug.memmap_on_memory is enabled when enabling
the feature of freeing vmemmap pages since those two features are not
compatible, however, the variable of "memmap_on_memory" cannot indicate
this nowadays.  Do not set "memmap_on_memory" to 1 when both parameters
are passed to cmdline, in this case, "memmap_on_memory" could indicate
if this feature is enabled by the users.

Also introduce mhp_memmap_on_memory() helper to move the definition of
"memmap_on_memory" to the scope of CONFIG_MHP_MEMMAP_ON_MEMORY.  In the
next patch, mhp_memmap_on_memory() will also be exported to be used in
hugetlb_vmemmap.c.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory_hotplug.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 416b38ca8def..da594b382829 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -42,14 +42,36 @@
 #include "internal.h"
 #include "shuffle.h"
 
+#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
+static int memmap_on_memory_set(const char *val, const struct kernel_param *kp)
+{
+	if (hugetlb_free_vmemmap_enabled())
+		return 0;
+	return param_set_bool(val, kp);
+}
+
+static const struct kernel_param_ops memmap_on_memory_ops = {
+	.flags	= KERNEL_PARAM_OPS_FL_NOARG,
+	.set	= memmap_on_memory_set,
+	.get	= param_get_bool,
+};
 
 /*
  * memory_hotplug.memmap_on_memory parameter
  */
 static bool memmap_on_memory __ro_after_init;
-#ifdef CONFIG_MHP_MEMMAP_ON_MEMORY
-module_param(memmap_on_memory, bool, 0444);
+module_param_cb(memmap_on_memory, &memmap_on_memory_ops, &memmap_on_memory, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
+
+static inline bool mhp_memmap_on_memory(void)
+{
+	return memmap_on_memory;
+}
+#else
+static inline bool mhp_memmap_on_memory(void)
+{
+	return false;
+}
 #endif
 
 enum {
@@ -1288,9 +1310,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       altmap as an alternative source of memory, and we do not exactly
 	 *       populate a single PMD.
 	 */
-	return memmap_on_memory &&
-	       !hugetlb_free_vmemmap_enabled() &&
-	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
+	return mhp_memmap_on_memory() &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
 	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
@@ -2074,7 +2094,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
 	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
 	 * the same granularity it was added - a single memory block.
 	 */
-	if (memmap_on_memory) {
+	if (mhp_memmap_on_memory()) {
 		nr_vmemmap_pages = walk_memory_blocks(start, size, NULL,
 						      get_nr_vmemmap_pages_cb);
 		if (nr_vmemmap_pages) {
-- 
2.11.0

