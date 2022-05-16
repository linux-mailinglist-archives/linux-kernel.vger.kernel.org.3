Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB85A5281E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiEPKXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242498AbiEPKXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:23:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43EDF0B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:20 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id bh5so2192789plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=304UY58xJZ+d2CkQooSXCSWWtYW1Q2iHG2puQFFW3wk=;
        b=TVrqS+L9G/q2rbodkQRoJPGzhMf2BPdNYw7FBBOap7cujZkLJN/HgS00hqAD+4eiNx
         TwFVPXjnc1k87mNghh6HMrJ7ZRmjtxW3Sz8Y1egdbjz1iK13UVUtSo9PN4r3MfqVFM9W
         sGzOpiwNENmW4tNkb3El0KH+0HgCAjqrPDbWGQoKxx/ZKitejeBHdR0UJd4al+Q05o/b
         mpw4b4hPBJPQ8mQgGhBou3w5oZ9DX/XHrNdE2lVytllAzl9yV+BZQXoAsFLeVi4o2QlI
         +LCoVhg+HfjgFKqq1mm5OCS06/Ivfxdz7EDPWGWl+0CEnQvCMo49R/0pes1f1a9EF9M2
         6iZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=304UY58xJZ+d2CkQooSXCSWWtYW1Q2iHG2puQFFW3wk=;
        b=um6riXlFpz8Q/W0OiQqAj6439fd0Cmdvt8fp33jXRAgFG0nWuCiBUX+j2pjdQOPuhp
         bIjUxWJaGEiE6/3+1PNMN7gHhXcHZN2Rdif4fS/oXOL/NiftoB8poXLur8YjLj84dBz+
         OOIRoqPIHKP86r4jIQaNZS0v8Ddt5k/YJkwhGF5bwE3DYQMqe/RJTKnr7lnEb22bC2ls
         FZksNlaQLmOX8YGjvGWd0NbCU+Mdg+bdoTZQJigZ7QNX01Y0p6L1R5gbhls0rB1fDPNU
         jV7c63Tup1GZ9EY3y+ldw+QHMb/iFoK4HI2xv3rYDHyV58KUBN/BLsCm11BGcSsJbhoN
         xcoQ==
X-Gm-Message-State: AOAM532m3feqg62TYNU3Snch6KAxBPIDdWsWoK+lyOlVDE0JTdPMowQt
        3GJn67d2HBwoWiYQM5ajUP105w==
X-Google-Smtp-Source: ABdhPJzLO2sspgSF1GMFuqfn3V6NhOrHC6osoIFEG23hv3578fqx7SBZnJ4T/3rONCHLN0+TuozGow==
X-Received: by 2002:a17:902:a9ca:b0:161:54a6:af3f with SMTP id b10-20020a170902a9ca00b0016154a6af3fmr9856256plr.48.1652696599775;
        Mon, 16 May 2022 03:23:19 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0050dc76281e4sm6472731pfa.190.2022.05.16.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 03:23:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 3/7] mm: memory_hotplug: enumerate all supported section flags
Date:   Mon, 16 May 2022 18:22:07 +0800
Message-Id: <20220516102211.41557-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220516102211.41557-1-songmuchun@bytedance.com>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
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

We are almost running out of free slots, only one bit is available in the
worst case (powerpc with 256k pages).  However, there are still some free
slots on other architectures (e.g. x86_64 has 10 bits available, arm64
has 8 bits available with worst case of 64K pages).  We have hard coded
those numbers in code, it is inconvenient to use those bits on other
architectures except powerpc.  So transfer those section flags to
enumeration to make it easy to add new section flags in the future. Also,
move SECTION_TAINT_ZONE_DEVICE into the scope of CONFIG_ZONE_DEVICE
to save a bit on non-zone-device case.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/kconfig.h |  1 +
 include/linux/mmzone.h  | 37 +++++++++++++++++++++++++++++--------
 mm/memory_hotplug.c     |  6 ++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index 20d1079e92b4..7044032b9f42 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -10,6 +10,7 @@
 #define __LITTLE_ENDIAN 1234
 #endif
 
+#define __ARG_PLACEHOLDER_ 0,
 #define __ARG_PLACEHOLDER_1 0,
 #define __take_second_arg(__ignored, val, ...) val
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..af057e20b9d7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1418,16 +1418,37 @@ extern size_t mem_section_usage_size(void);
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
+#define ENUM_SECTION_FLAG(MAPPER)						\
+	MAPPER(MARKED_PRESENT)							\
+	MAPPER(HAS_MEM_MAP)							\
+	MAPPER(IS_ONLINE)							\
+	MAPPER(IS_EARLY)							\
+	MAPPER(TAINT_ZONE_DEVICE, CONFIG_ZONE_DEVICE)				\
+	MAPPER(MAP_LAST_BIT)
+
+#define __SECTION_SHIFT_FLAG_MAPPER_0(x)
+#define __SECTION_SHIFT_FLAG_MAPPER_1(x)	SECTION_##x##_SHIFT,
+#define __SECTION_SHIFT_FLAG_MAPPER(x, ...)	\
+	__PASTE(__SECTION_SHIFT_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
+
+#define __SECTION_FLAG_MAPPER_0(x)
+#define __SECTION_FLAG_MAPPER_1(x)		SECTION_##x = BIT(SECTION_##x##_SHIFT),
+#define __SECTION_FLAG_MAPPER(x, ...)		\
+	__PASTE(__SECTION_FLAG_MAPPER_, IS_ENABLED(__VA_ARGS__))(x)
+
+enum {
+	ENUM_SECTION_FLAG(__SECTION_SHIFT_FLAG_MAPPER)
+	ENUM_SECTION_FLAG(__SECTION_FLAG_MAPPER)
+};
+
 #define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT		6
+#define SECTION_NID_SHIFT		SECTION_MAP_LAST_BIT_SHIFT
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 111684878fd9..aef3f041dec7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -655,12 +655,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 
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
-- 
2.11.0

