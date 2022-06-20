Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DFF551696
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241253AbiFTLHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbiFTLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:07:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5815807
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:07:22 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l6so1261221plg.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mM7s3v4b97sYa4DNCsb4b4pY8OOrPntnEzMKTxkrZCM=;
        b=gIu6W0ZIr/zYXLZR0jiYfFo6E18oWdKoXjARFWXS+zZf7fY/UQtXQsa0q11G5ojxlh
         QPaT79UFh/2Be873OwRYKLBoDMkwtiApXCRGrvc9Qu1E40kH4y9DOZ1Wlkt3mbSVY4f4
         AJZeBzIYxFP2CPQ3ucPs8G377XblLDiz1tZ2bV9v2/CMkAcEY7wGx5AN82RVvaoz18nZ
         mv9nljhR8AXVEmfjx2gbRaPS3SF3IoVSwH3UwVA0lPUBiiiP8kjxlkY5iFcPdlv8Pf9h
         I0oGIkmib6iaVtMoK9CVeiRgrZnLV2u5xwvz72yAlNeUQAdANv09B3o3ZkNysai1sQxM
         Bmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mM7s3v4b97sYa4DNCsb4b4pY8OOrPntnEzMKTxkrZCM=;
        b=xgWw/f85jO+faVRsNn+rHnnOmZu7+/BPhcKS62h0sEl2ASNUPvVvUJ5AqHNHIeJR3q
         fNbiLsosRWzle3H1I0NwakIVdbGEFueyrmkJz/1d/EEobNL0J+mbWKa2zISQvp1aQ04U
         HUh3o3V0g9uHFssp6kfWdkkWRYXYVQ0gZLGNZiCQkcc9gfcT0gMXBjdtIQddgxZU7dbZ
         +f25+BtJrRZjLvGjE70o0oIvFCbhIHqo9z87gLjmL4vT3Eg7uTmycmuoQEjf08A3jVZC
         PKXazOa1OxTAvejofg4Iaj+EYc8777oSMM2zLOIroTbiXJo03ARm1yEUjJwBxOcBILiH
         Vu3g==
X-Gm-Message-State: AJIora8J7lWZMw+YaqYJrcSOACkNQAxKnjQMwNqJxYad6RZzkpX/MY+y
        dr/PAPncXuTS4aTJyA5TSAh60w==
X-Google-Smtp-Source: AGRyM1uFiRFO3G72OlGQJs4sGnpULsAK3KSRtJN9Fgt8rFs5zX6qpNiEZwdJU5OUBW4nsQpQGLcK2A==
X-Received: by 2002:a17:902:7042:b0:16a:2156:c325 with SMTP id h2-20020a170902704200b0016a2156c325mr5882728plt.166.1655723242390;
        Mon, 20 Jun 2022 04:07:22 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b0016a214e4afasm2385962plb.125.2022.06.20.04.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:07:22 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 1/2] mm: memory_hotplug: enumerate all supported section flags
Date:   Mon, 20 Jun 2022 19:06:15 +0800
Message-Id: <20220620110616.12056-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220620110616.12056-1-songmuchun@bytedance.com>
References: <20220620110616.12056-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are almost running out of section flags, only one bit is available in
the worst case (powerpc with 256k pages).  However, there are still some
free bits (in ->section_mem_map) on other architectures (e.g. x86_64 has
10 bits available, arm64 has 8 bits available with worst case of 64K
pages).  We have hard coded those numbers in code, it is inconvenient to
use those bits on other architectures except powerpc.  So transfer those
section flags to enumeration to make it easy to add new section flags in
the future. Also, move SECTION_TAINT_ZONE_DEVICE into the scope of
CONFIG_ZONE_DEVICE to save a bit on non-zone-device case.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmzone.h | 41 ++++++++++++++++++++++++++++++++---------
 mm/memory_hotplug.c    |  6 ++++++
 mm/sparse.c            |  2 +-
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..2b5757752333 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1418,16 +1418,32 @@ extern size_t mem_section_usage_size(void);
  *      (equal SECTION_SIZE_BITS - PAGE_SHIFT), and the
  *      worst combination is powerpc with 256k pages,
  *      which results in PFN_SECTION_SHIFT equal 6.
- * To sum it up, at least 6 bits are available.
+ * To sum it up, at least 6 bits are available on all architectures.
+ * However, we can exceed 6 bits on some other architectures except
+ * powerpc (e.g. 15 bits are available on x86_64, 13 bits are available
+ * with the worst case of 64K pages on arm64) if we make sure the
+ * exceeded bit is not applicable to powerpc.
  */
-#define SECTION_MARKED_PRESENT		(1UL<<0)
-#define SECTION_HAS_MEM_MAP		(1UL<<1)
-#define SECTION_IS_ONLINE		(1UL<<2)
-#define SECTION_IS_EARLY		(1UL<<3)
-#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
-#define SECTION_MAP_LAST_BIT		(1UL<<5)
-#define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT		6
+enum {
+	SECTION_MARKED_PRESENT_BIT,
+	SECTION_HAS_MEM_MAP_BIT,
+	SECTION_IS_ONLINE_BIT,
+	SECTION_IS_EARLY_BIT,
+#ifdef CONFIG_ZONE_DEVICE
+	SECTION_TAINT_ZONE_DEVICE_BIT,
+#endif
+	SECTION_MAP_LAST_BIT,
+};
+
+#define SECTION_MARKED_PRESENT		BIT(SECTION_MARKED_PRESENT_BIT)
+#define SECTION_HAS_MEM_MAP		BIT(SECTION_HAS_MEM_MAP_BIT)
+#define SECTION_IS_ONLINE		BIT(SECTION_IS_ONLINE_BIT)
+#define SECTION_IS_EARLY		BIT(SECTION_IS_EARLY_BIT)
+#ifdef CONFIG_ZONE_DEVICE
+#define SECTION_TAINT_ZONE_DEVICE	BIT(SECTION_TAINT_ZONE_DEVICE_BIT)
+#endif
+#define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
+#define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
@@ -1466,12 +1482,19 @@ static inline int online_section(struct mem_section *section)
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
+#ifdef CONFIG_ZONE_DEVICE
 static inline int online_device_section(struct mem_section *section)
 {
 	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
 
 	return section && ((section->section_mem_map & flags) == flags);
 }
+#else
+static inline int online_device_section(struct mem_section *section)
+{
+	return 0;
+}
+#endif
 
 static inline int online_section_nr(unsigned long nr)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 1f1a730c4499..6662b86e9e64 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -670,12 +670,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 
 }
 
+#ifdef CONFIG_ZONE_DEVICE
 static void section_taint_zone_device(unsigned long pfn)
 {
 	struct mem_section *ms = __pfn_to_section(pfn);
 
 	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
 }
+#else
+static inline void section_taint_zone_device(unsigned long pfn)
+{
+}
+#endif
 
 /*
  * Associate the pfn range with the given zone, initializing the memmaps
diff --git a/mm/sparse.c b/mm/sparse.c
index cb3bfae64036..e5a8a3a0edd7 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -281,7 +281,7 @@ static unsigned long sparse_encode_mem_map(struct page *mem_map, unsigned long p
 {
 	unsigned long coded_mem_map =
 		(unsigned long)(mem_map - (section_nr_to_pfn(pnum)));
-	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > (1UL<<PFN_SECTION_SHIFT));
+	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
 	BUG_ON(coded_mem_map & ~SECTION_MAP_MASK);
 	return coded_mem_map;
 }
-- 
2.11.0

