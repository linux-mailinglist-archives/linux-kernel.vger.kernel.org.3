Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB13751BA26
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348786AbiEEIXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347028AbiEEIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:20:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7573B4926B
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:16:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 162DA1F45F;
        Thu,  5 May 2022 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FLxbtpzBQ9VbjqIE6K+qmcx5CrSY4iyn10JST4u0ffI=;
        b=ay1jpywDJoybUwQoo2dUHqa0To7OTJNg/ZM1r+YNMOd3surTH0G/97x0mDb7bzCvSiLOI7
        f/RB5om3S2Zi8OUxDTeYZWcLhK99ITR1to9+YrZTjmC80uSFFispkwJWb2V16Rh7jJZTJq
        zLC6uOkeYylneNsL4LOKmBK0ZhYQJF8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D700013B12;
        Thu,  5 May 2022 08:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wL4gM+uHc2K1BwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 05 May 2022 08:16:43 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3 01/21] xen: update grant_table.h
Date:   Thu,  5 May 2022 10:16:20 +0200
Message-Id: <20220505081640.17425-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220505081640.17425-1-jgross@suse.com>
References: <20220505081640.17425-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update include/xen/interface/grant_table.h to its newest version.

This allows to drop some private definitions in grant-table.c and
include/xen/grant_table.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 drivers/xen/grant-table.c           |   8 +-
 include/xen/grant_table.h           |   2 -
 include/xen/interface/grant_table.h | 161 +++++++++++++++++-----------
 3 files changed, 103 insertions(+), 68 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 8ccccace2a4f..6ea31ea26008 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -66,8 +66,6 @@
 
 #include <asm/sync_bitops.h>
 
-/* External tools reserve first few grant table entries. */
-#define NR_RESERVED_ENTRIES 8
 #define GNTTAB_LIST_END 0xffffffff
 
 static grant_ref_t **gnttab_list;
@@ -1465,12 +1463,12 @@ int gnttab_init(void)
 	nr_init_grefs = nr_grant_frames *
 			gnttab_interface->grefs_per_grant_frame;
 
-	for (i = NR_RESERVED_ENTRIES; i < nr_init_grefs - 1; i++)
+	for (i = GNTTAB_NR_RESERVED_ENTRIES; i < nr_init_grefs - 1; i++)
 		gnttab_entry(i) = i + 1;
 
 	gnttab_entry(nr_init_grefs - 1) = GNTTAB_LIST_END;
-	gnttab_free_count = nr_init_grefs - NR_RESERVED_ENTRIES;
-	gnttab_free_head  = NR_RESERVED_ENTRIES;
+	gnttab_free_count = nr_init_grefs - GNTTAB_NR_RESERVED_ENTRIES;
+	gnttab_free_head  = GNTTAB_NR_RESERVED_ENTRIES;
 
 	printk("Grant table initialized\n");
 	return 0;
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index dfd5bf31cfb9..7d0f2f0037b8 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -57,8 +57,6 @@
 #define INVALID_GRANT_REF          ((grant_ref_t)-1)
 #define INVALID_GRANT_HANDLE       ((grant_handle_t)-1)
 
-#define GNTTAB_RESERVED_XENSTORE 1
-
 /* NR_GRANT_FRAMES must be less than or equal to that configured in Xen */
 #define NR_GRANT_FRAMES 4
 
diff --git a/include/xen/interface/grant_table.h b/include/xen/interface/grant_table.h
index 3eeabbc7ee09..cebbd99f1f84 100644
--- a/include/xen/interface/grant_table.h
+++ b/include/xen/interface/grant_table.h
@@ -19,7 +19,8 @@
 
 /* Some rough guidelines on accessing and updating grant-table entries
  * in a concurrency-safe manner. For more information, Linux contains a
- * reference implementation for guest OSes (arch/xen/kernel/grant_table.c).
+ * reference implementation for guest OSes (drivers/xen/grant_table.c, see
+ * http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=drivers/xen/grant-table.c;hb=HEAD
  *
  * NB. WMB is a no-op on current-generation x86 processors. However, a
  *     compiler barrier will still be required.
@@ -80,8 +81,9 @@ typedef uint32_t grant_ref_t;
  */
 
 /*
- * Version 1 of the grant table entry structure is maintained purely
- * for backwards compatibility.  New guests should use version 2.
+ * Version 1 of the grant table entry structure is maintained largely for
+ * backwards compatibility.  New guests are recommended to support using
+ * version 2 to overcome version 1 limitations, but to default to version 1.
  */
 struct grant_entry_v1 {
     /* GTF_xxx: various type and flag information.  [XEN,GST] */
@@ -89,12 +91,21 @@ struct grant_entry_v1 {
     /* The domain being granted foreign privileges. [GST] */
     domid_t  domid;
     /*
-     * GTF_permit_access: Frame that @domid is allowed to map and access. [GST]
-     * GTF_accept_transfer: Frame whose ownership transferred by @domid. [XEN]
+     * GTF_permit_access: GFN that @domid is allowed to map and access. [GST]
+     * GTF_accept_transfer: GFN that @domid is allowed to transfer into. [GST]
+     * GTF_transfer_completed: MFN whose ownership transferred by @domid
+     *                         (non-translated guests only). [XEN]
      */
     uint32_t frame;
 };
 
+/* The first few grant table entries will be preserved across grant table
+ * version changes and may be pre-populated at domain creation by tools.
+ */
+#define GNTTAB_NR_RESERVED_ENTRIES     8
+#define GNTTAB_RESERVED_CONSOLE        0
+#define GNTTAB_RESERVED_XENSTORE       1
+
 /*
  * Type of grant entry.
  *  GTF_invalid: This grant entry grants no privileges.
@@ -111,10 +122,13 @@ struct grant_entry_v1 {
 #define GTF_type_mask       (3U<<0)
 
 /*
- * Subflags for GTF_permit_access.
+ * Subflags for GTF_permit_access and GTF_transitive.
  *  GTF_readonly: Restrict @domid to read-only mappings and accesses. [GST]
  *  GTF_reading: Grant entry is currently mapped for reading by @domid. [XEN]
  *  GTF_writing: Grant entry is currently mapped for writing by @domid. [XEN]
+ * Further subflags for GTF_permit_access only.
+ *  GTF_PAT, GTF_PWT, GTF_PCD: (x86) cache attribute flags to be used for
+ *                             mappings of the grant [GST]
  *  GTF_sub_page: Grant access to only a subrange of the page.  @domid
  *                will only be allowed to copy from the grant, and not
  *                map it. [GST]
@@ -125,6 +139,12 @@ struct grant_entry_v1 {
 #define GTF_reading         (1U<<_GTF_reading)
 #define _GTF_writing        (4)
 #define GTF_writing         (1U<<_GTF_writing)
+#define _GTF_PWT            (5)
+#define GTF_PWT             (1U<<_GTF_PWT)
+#define _GTF_PCD            (6)
+#define GTF_PCD             (1U<<_GTF_PCD)
+#define _GTF_PAT            (7)
+#define GTF_PAT             (1U<<_GTF_PAT)
 #define _GTF_sub_page       (8)
 #define GTF_sub_page        (1U<<_GTF_sub_page)
 
@@ -164,8 +184,7 @@ struct grant_entry_header {
 };
 
 /*
- * Version 2 of the grant entry structure, here is a union because three
- * different types are suppotted: full_page, sub_page and transitive.
+ * Version 2 of the grant entry structure.
  */
 union grant_entry_v2 {
     struct grant_entry_header hdr;
@@ -180,9 +199,9 @@ union grant_entry_v2 {
      * field of the same name in the V1 entry structure.
      */
     struct {
-	struct grant_entry_header hdr;
-	uint32_t pad0;
-	uint64_t frame;
+        struct grant_entry_header hdr;
+        uint32_t pad0;
+        uint64_t frame;
     } full_page;
 
     /*
@@ -191,10 +210,10 @@ union grant_entry_v2 {
      * in frame @frame.
      */
     struct {
-	struct grant_entry_header hdr;
-	uint16_t page_off;
-	uint16_t length;
-	uint64_t frame;
+        struct grant_entry_header hdr;
+        uint16_t page_off;
+        uint16_t length;
+        uint64_t frame;
     } sub_page;
 
     /*
@@ -202,12 +221,15 @@ union grant_entry_v2 {
      * grant @gref in domain @trans_domid, as if it was the local
      * domain.  Obviously, the transitive access must be compatible
      * with the original grant.
+     *
+     * The current version of Xen does not allow transitive grants
+     * to be mapped.
      */
     struct {
-	struct grant_entry_header hdr;
-	domid_t trans_domid;
-	uint16_t pad0;
-	grant_ref_t gref;
+        struct grant_entry_header hdr;
+        domid_t trans_domid;
+        uint16_t pad0;
+        grant_ref_t gref;
     } transitive;
 
     uint32_t __spacer[4]; /* Pad to a power of two */
@@ -219,6 +241,21 @@ typedef uint16_t grant_status_t;
  * GRANT TABLE QUERIES AND USES
  */
 
+#define GNTTABOP_map_grant_ref        0
+#define GNTTABOP_unmap_grant_ref      1
+#define GNTTABOP_setup_table          2
+#define GNTTABOP_dump_table           3
+#define GNTTABOP_transfer             4
+#define GNTTABOP_copy                 5
+#define GNTTABOP_query_size           6
+#define GNTTABOP_unmap_and_replace    7
+#define GNTTABOP_set_version          8
+#define GNTTABOP_get_status_frames    9
+#define GNTTABOP_get_version          10
+#define GNTTABOP_swap_grant_ref	      11
+#define GNTTABOP_cache_flush	      12
+/* ` } */
+
 /*
  * Handle to track a mapping created via a grant reference.
  */
@@ -227,7 +264,7 @@ typedef uint32_t grant_handle_t;
 /*
  * GNTTABOP_map_grant_ref: Map the grant entry (<dom>,<ref>) for access
  * by devices and/or host CPUs. If successful, <handle> is a tracking number
- * that must be presented later to destroy the mapping(s). On error, <handle>
+ * that must be presented later to destroy the mapping(s). On error, <status>
  * is a negative status code.
  * NOTES:
  *  1. If GNTMAP_device_map is specified then <dev_bus_addr> is the address
@@ -241,7 +278,6 @@ typedef uint32_t grant_handle_t;
  *     host mapping is destroyed by other means then it is *NOT* guaranteed
  *     to be accounted to the correct grant reference!
  */
-#define GNTTABOP_map_grant_ref        0
 struct gnttab_map_grant_ref {
     /* IN parameters. */
     uint64_t host_addr;
@@ -266,7 +302,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_map_grant_ref);
  *  3. After executing a batch of unmaps, it is guaranteed that no stale
  *     mappings will remain in the device or host TLBs.
  */
-#define GNTTABOP_unmap_grant_ref      1
 struct gnttab_unmap_grant_ref {
     /* IN parameters. */
     uint64_t host_addr;
@@ -286,7 +321,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_unmap_grant_ref);
  *  2. Only a sufficiently-privileged domain may specify <dom> != DOMID_SELF.
  *  3. Xen may not support more than a single grant-table page per domain.
  */
-#define GNTTABOP_setup_table          2
 struct gnttab_setup_table {
     /* IN parameters. */
     domid_t  dom;
@@ -301,7 +335,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_setup_table);
  * GNTTABOP_dump_table: Dump the contents of the grant table to the
  * xen console. Debugging use only.
  */
-#define GNTTABOP_dump_table           3
 struct gnttab_dump_table {
     /* IN parameters. */
     domid_t dom;
@@ -311,17 +344,17 @@ struct gnttab_dump_table {
 DEFINE_GUEST_HANDLE_STRUCT(gnttab_dump_table);
 
 /*
- * GNTTABOP_transfer_grant_ref: Transfer <frame> to a foreign domain. The
- * foreign domain has previously registered its interest in the transfer via
- * <domid, ref>.
+ * GNTTABOP_transfer: Transfer <frame> to a foreign domain. The foreign domain
+ * has previously registered its interest in the transfer via <domid, ref>.
  *
  * Note that, even if the transfer fails, the specified page no longer belongs
  * to the calling domain *unless* the error is GNTST_bad_page.
+ *
+ * Note further that only PV guests can use this operation.
  */
-#define GNTTABOP_transfer                4
 struct gnttab_transfer {
     /* IN parameters. */
-    xen_pfn_t mfn;
+    xen_pfn_t     mfn;
     domid_t       domid;
     grant_ref_t   ref;
     /* OUT parameters. */
@@ -352,21 +385,20 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_transfer);
 #define _GNTCOPY_dest_gref        (1)
 #define GNTCOPY_dest_gref         (1<<_GNTCOPY_dest_gref)
 
-#define GNTTABOP_copy                 5
 struct gnttab_copy {
-	/* IN parameters. */
-	struct {
-		union {
-			grant_ref_t ref;
-			xen_pfn_t   gmfn;
-		} u;
-		domid_t  domid;
-		uint16_t offset;
-	} source, dest;
-	uint16_t      len;
-	uint16_t      flags;          /* GNTCOPY_* */
-	/* OUT parameters. */
-	int16_t       status;
+    /* IN parameters. */
+    struct gnttab_copy_ptr {
+        union {
+            grant_ref_t ref;
+            xen_pfn_t   gmfn;
+        } u;
+        domid_t  domid;
+        uint16_t offset;
+    } source, dest;
+    uint16_t      len;
+    uint16_t      flags;          /* GNTCOPY_* */
+    /* OUT parameters. */
+    int16_t       status;
 };
 DEFINE_GUEST_HANDLE_STRUCT(gnttab_copy);
 
@@ -377,7 +409,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_copy);
  *  1. <dom> may be specified as DOMID_SELF.
  *  2. Only a sufficiently-privileged domain may specify <dom> != DOMID_SELF.
  */
-#define GNTTABOP_query_size           6
 struct gnttab_query_size {
     /* IN parameters. */
     domid_t  dom;
@@ -399,7 +430,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_query_size);
  *  2. After executing a batch of unmaps, it is guaranteed that no stale
  *     mappings will remain in the device or host TLBs.
  */
-#define GNTTABOP_unmap_and_replace    7
 struct gnttab_unmap_and_replace {
     /* IN parameters. */
     uint64_t host_addr;
@@ -412,14 +442,12 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_unmap_and_replace);
 
 /*
  * GNTTABOP_set_version: Request a particular version of the grant
- * table shared table structure.  This operation can only be performed
- * once in any given domain.  It must be performed before any grants
- * are activated; otherwise, the domain will be stuck with version 1.
- * The only defined versions are 1 and 2.
+ * table shared table structure.  This operation may be used to toggle
+ * between different versions, but must be performed while no grants
+ * are active.  The only defined versions are 1 and 2.
  */
-#define GNTTABOP_set_version          8
 struct gnttab_set_version {
-    /* IN parameters */
+    /* IN/OUT parameters */
     uint32_t version;
 };
 DEFINE_GUEST_HANDLE_STRUCT(gnttab_set_version);
@@ -436,7 +464,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_set_version);
  *  1. <dom> may be specified as DOMID_SELF.
  *  2. Only a sufficiently-privileged domain may specify <dom> != DOMID_SELF.
  */
-#define GNTTABOP_get_status_frames     9
 struct gnttab_get_status_frames {
     /* IN parameters. */
     uint32_t nr_frames;
@@ -451,7 +478,6 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_get_status_frames);
  * GNTTABOP_get_version: Get the grant table version which is in
  * effect for domain <dom>.
  */
-#define GNTTABOP_get_version          10
 struct gnttab_get_version {
     /* IN parameters */
     domid_t dom;
@@ -461,27 +487,38 @@ struct gnttab_get_version {
 };
 DEFINE_GUEST_HANDLE_STRUCT(gnttab_get_version);
 
+/*
+ * GNTTABOP_swap_grant_ref: Swap the contents of two grant entries.
+ */
+struct gnttab_swap_grant_ref {
+    /* IN parameters */
+    grant_ref_t ref_a;
+    grant_ref_t ref_b;
+    /* OUT parameters */
+    int16_t status;             /* GNTST_* */
+};
+DEFINE_GUEST_HANDLE_STRUCT(gnttab_swap_grant_ref);
+
 /*
  * Issue one or more cache maintenance operations on a portion of a
  * page granted to the calling domain by a foreign domain.
  */
-#define GNTTABOP_cache_flush          12
 struct gnttab_cache_flush {
     union {
         uint64_t dev_bus_addr;
         grant_ref_t ref;
     } a;
-    uint16_t offset;   /* offset from start of grant */
-    uint16_t length;   /* size within the grant */
-#define GNTTAB_CACHE_CLEAN          (1<<0)
-#define GNTTAB_CACHE_INVAL          (1<<1)
-#define GNTTAB_CACHE_SOURCE_GREF    (1<<31)
+    uint16_t offset; /* offset from start of grant */
+    uint16_t length; /* size within the grant */
+#define GNTTAB_CACHE_CLEAN          (1u<<0)
+#define GNTTAB_CACHE_INVAL          (1u<<1)
+#define GNTTAB_CACHE_SOURCE_GREF    (1u<<31)
     uint32_t op;
 };
 DEFINE_GUEST_HANDLE_STRUCT(gnttab_cache_flush);
 
 /*
- * Bitfield values for update_pin_status.flags.
+ * Bitfield values for gnttab_map_grant_ref.flags.
  */
  /* Map the grant entry for access by I/O devices. */
 #define _GNTMAP_device_map      (0)
@@ -531,6 +568,7 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_cache_flush);
 #define GNTST_bad_copy_arg    (-10) /* copy arguments cross page boundary.   */
 #define GNTST_address_too_big (-11) /* transfer page address too large.      */
 #define GNTST_eagain          (-12) /* Operation not done; try again.        */
+#define GNTST_no_space        (-13) /* Out of space (handles etc).           */
 
 #define GNTTABOP_error_msgs {                   \
     "okay",                                     \
@@ -545,7 +583,8 @@ DEFINE_GUEST_HANDLE_STRUCT(gnttab_cache_flush);
     "bad page",                                 \
     "copy arguments cross page boundary",       \
     "page address size too large",              \
-    "operation not done; try again"             \
+    "operation not done; try again",            \
+    "out of space",                             \
 }
 
 #endif /* __XEN_PUBLIC_GRANT_TABLE_H__ */
-- 
2.35.3

