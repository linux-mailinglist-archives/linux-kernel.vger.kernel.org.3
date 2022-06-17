Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5637954F8BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382544AbiFQN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382531AbiFQN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:58:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE536E24
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:58:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d5so3937441plo.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EMatSV1+t4qFy1NZ5GBQuBSsvAWCaC/xn6RiPVNR2iY=;
        b=DLgDdvgAiDYnxxGK0kizD0rVOn7tYa/8ez/L+HVhsX01j4WfdiAS7MSgpst303DfHZ
         L6bwt6PTV4zPEnsPg+50xx+ona2i2Z4YhG2RPzA+8j5v9tsVAUEMNYA3Yre14T6XU3pM
         degBA1XhN9KMMYkat8iu4BZrQ7o5IkOcQvskdrwGor6Zq+0VUBRw16zTxnzhEIcJrKPl
         4rNIyaqVLioAyijg/u5Z7aYJALFk1ywKDQg91qhVk+b3uE9fjUzdfhf5YAps+gnpNfwb
         K4DLEfTi+hOkveRn5qccdXKv5l6xGzrZh6COVf3d6zLzpf/byrjioEGsEC3Ot3dCoAvL
         zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMatSV1+t4qFy1NZ5GBQuBSsvAWCaC/xn6RiPVNR2iY=;
        b=rnucIyjX38qGTeqEnZUxITXu0tIYibsxMQktQ+dUbo/hi4AvZXYsSCz0oE40f+KK9h
         TbC3FnNlKWhf6TS9KHThkk1qbV+6W+PkK3X9A05kseouGz1I+1DGCqJsbCfvwNF/fxVs
         u+lV93sAdBxHTbN4TFGGOwEJo+7sCoflcZHr3KVEyEpmykASqvgI4bE/men69x5vNRID
         I2CctD4jds5MLI83JwGLTilQ64672U334k0knsZMRdZ9r94ndYjU5gKwFpF1L2zcJQbj
         7fwjtwV3AZRHXGv3HrWVGanNwBPR0zClZXB6n4qjyRVnUjoEcr7MonzLX3x9IirnjFfz
         8zBQ==
X-Gm-Message-State: AJIora8gSqpl7qNl2axHIHS83AyLiVqZZ1LIy8zG25fPfSvdKd0YlqKU
        MAflrU1J5dyFF4CWvrMIrMmhMA==
X-Google-Smtp-Source: AGRyM1vJNmuLAuXSWdMYIgHaMxFecDj98dF84vb69573D8juQRY+AEtOMLzRXelhvc3vm0JdgDSJ+w==
X-Received: by 2002:a17:90b:164a:b0:1e8:8e0c:88dc with SMTP id il10-20020a17090b164a00b001e88e0c88dcmr10823433pjb.237.1655474298733;
        Fri, 17 Jun 2022 06:58:18 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015e8d4eb277sm3605869plo.193.2022.06.17.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 06:58:12 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, corbet@lwn.net, david@redhat.com,
        mike.kravetz@oracle.com, osalvador@suse.de, paulmck@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 1/2] mm: memory_hotplug: enumerate all supported section flags
Date:   Fri, 17 Jun 2022 21:56:49 +0800
Message-Id: <20220617135650.74901-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220617135650.74901-1-songmuchun@bytedance.com>
References: <20220617135650.74901-1-songmuchun@bytedance.com>
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
 include/linux/mmzone.h | 44 +++++++++++++++++++++++++++++++++++---------
 mm/memory_hotplug.c    |  6 ++++++
 mm/sparse.c            |  2 +-
 3 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..932843c6459b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1418,16 +1418,35 @@ extern size_t mem_section_usage_size(void);
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
+enum {
+	SECTION_MARKED_PRESENT		= BIT(SECTION_MARKED_PRESENT_BIT),
+	SECTION_HAS_MEM_MAP		= BIT(SECTION_HAS_MEM_MAP_BIT),
+	SECTION_IS_ONLINE		= BIT(SECTION_IS_ONLINE_BIT),
+	SECTION_IS_EARLY		= BIT(SECTION_IS_EARLY_BIT),
+#ifdef CONFIG_ZONE_DEVICE
+	SECTION_TAINT_ZONE_DEVICE	= BIT(SECTION_TAINT_ZONE_DEVICE_BIT),
+#endif
+};
+
+#define SECTION_MAP_MASK		(~(BIT(SECTION_MAP_LAST_BIT) - 1))
+#define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
@@ -1466,12 +1485,19 @@ static inline int online_section(struct mem_section *section)
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

