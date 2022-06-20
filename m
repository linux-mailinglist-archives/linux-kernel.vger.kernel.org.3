Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09355264A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244328AbiFTVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiFTVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:13:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373D10D8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEF0DB8125A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D8C341C4;
        Mon, 20 Jun 2022 21:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655759587;
        bh=gXALsYyc82ePOFLS8t2xIbS1pFQ7VsfVtZPWiN5pWS8=;
        h=Date:From:To:Cc:Subject:From;
        b=qQxbxOQfQPwOPABynWcaLKmsBIsOi910tGlWE7bISSx/HrkcXN9Y1CSf5UPj3SStG
         a4tS6zfKY0dtzmP0Q72reX6+CTrDzqoouJf3mMu37BbgiZaeY/M+nagcr2jk17cIcO
         LICcwiswVUKbH42noyJhELaIlSUQn14+OfshIyIgRRwKpqEYPw3KTWUjpkETw8glWK
         kYGVlDTUZXnx8ynYNFlmWE3eaYkzD5NEsUyBOhGuUMI0s2L/hxcxJZIpvkC/wQRNr+
         56yixlV2FHOgk2b9kKpftdcFLi6PTkbIub8JNknjK1IUEe6Tf7Ii4Y7aTG81bbyEAZ
         fzDmfH5YNVT5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE9E34096F; Mon, 20 Jun 2022 18:13:04 -0300 (-03)
Date:   Mon, 20 Jun 2022 18:13:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Harrison <John.C.Harrison@intel.com>,
        Matt Atwood <matthew.s.atwood@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync drm/i915_drm.h with the
 kernel sources
Message-ID: <YrDi4ALYjv9Mdocq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used not to be copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick up the changes in:

  ecf8eca51f33dbfd ("drm/i915/xehp: Add compute engine ABI")
  991b4de3275728fd ("drm/i915/uapi: Add kerneldoc for engine class enum")
  c94fde8f516610b0 ("drm/i915/uapi: Add DRM_I915_QUERY_GEOMETRY_SUBSLICES")
  1c671ad753dbbf5f ("drm/i915/doc: Link query items to their uapi structs")
  a2e5402691e23269 ("drm/i915/doc: Convert perf UAPI comments to kerneldoc")
  462ac1cdf4d7acf1 ("drm/i915/doc: Convert drm_i915_query_topology_info comment to kerneldoc")
  034d47b25b2ce627 ("drm/i915/uapi: Document DRM_I915_QUERY_HWCONFIG_BLOB")
  78e1fb3112c0ac44 ("drm/i915/uapi: Add query for hwconfig blob")

That don't add any new ioctl, so no changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: John Harrison <John.C.Harrison@intel.com>
Cc: Matt Atwood <matthew.s.atwood@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 353 +++++++++++++++++++++++-------
 1 file changed, 272 insertions(+), 81 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 05c3642aaece4429..a2def7b270097836 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -154,25 +154,77 @@ enum i915_mocs_table_index {
 	I915_MOCS_CACHED,
 };
 
-/*
+/**
+ * enum drm_i915_gem_engine_class - uapi engine type enumeration
+ *
  * Different engines serve different roles, and there may be more than one
- * engine serving each role. enum drm_i915_gem_engine_class provides a
- * classification of the role of the engine, which may be used when requesting
- * operations to be performed on a certain subset of engines, or for providing
- * information about that group.
+ * engine serving each role.  This enum provides a classification of the role
+ * of the engine, which may be used when requesting operations to be performed
+ * on a certain subset of engines, or for providing information about that
+ * group.
  */
 enum drm_i915_gem_engine_class {
+	/**
+	 * @I915_ENGINE_CLASS_RENDER:
+	 *
+	 * Render engines support instructions used for 3D, Compute (GPGPU),
+	 * and programmable media workloads.  These instructions fetch data and
+	 * dispatch individual work items to threads that operate in parallel.
+	 * The threads run small programs (called "kernels" or "shaders") on
+	 * the GPU's execution units (EUs).
+	 */
 	I915_ENGINE_CLASS_RENDER	= 0,
+
+	/**
+	 * @I915_ENGINE_CLASS_COPY:
+	 *
+	 * Copy engines (also referred to as "blitters") support instructions
+	 * that move blocks of data from one location in memory to another,
+	 * or that fill a specified location of memory with fixed data.
+	 * Copy engines can perform pre-defined logical or bitwise operations
+	 * on the source, destination, or pattern data.
+	 */
 	I915_ENGINE_CLASS_COPY		= 1,
+
+	/**
+	 * @I915_ENGINE_CLASS_VIDEO:
+	 *
+	 * Video engines (also referred to as "bit stream decode" (BSD) or
+	 * "vdbox") support instructions that perform fixed-function media
+	 * decode and encode.
+	 */
 	I915_ENGINE_CLASS_VIDEO		= 2,
+
+	/**
+	 * @I915_ENGINE_CLASS_VIDEO_ENHANCE:
+	 *
+	 * Video enhancement engines (also referred to as "vebox") support
+	 * instructions related to image enhancement.
+	 */
 	I915_ENGINE_CLASS_VIDEO_ENHANCE	= 3,
 
-	/* should be kept compact */
+	/**
+	 * @I915_ENGINE_CLASS_COMPUTE:
+	 *
+	 * Compute engines support a subset of the instructions available
+	 * on render engines:  compute engines support Compute (GPGPU) and
+	 * programmable media workloads, but do not support the 3D pipeline.
+	 */
+	I915_ENGINE_CLASS_COMPUTE	= 4,
+
+	/* Values in this enum should be kept compact. */
 
+	/**
+	 * @I915_ENGINE_CLASS_INVALID:
+	 *
+	 * Placeholder value to represent an invalid engine class assignment.
+	 */
 	I915_ENGINE_CLASS_INVALID	= -1
 };
 
-/*
+/**
+ * struct i915_engine_class_instance - Engine class/instance identifier
+ *
  * There may be more than one engine fulfilling any role within the system.
  * Each engine of a class is given a unique instance number and therefore
  * any engine can be specified by its class:instance tuplet. APIs that allow
@@ -180,10 +232,21 @@ enum drm_i915_gem_engine_class {
  * for this identification.
  */
 struct i915_engine_class_instance {
-	__u16 engine_class; /* see enum drm_i915_gem_engine_class */
-	__u16 engine_instance;
+	/**
+	 * @engine_class:
+	 *
+	 * Engine class from enum drm_i915_gem_engine_class
+	 */
+	__u16 engine_class;
 #define I915_ENGINE_CLASS_INVALID_NONE -1
 #define I915_ENGINE_CLASS_INVALID_VIRTUAL -2
+
+	/**
+	 * @engine_instance:
+	 *
+	 * Engine instance.
+	 */
+	__u16 engine_instance;
 };
 
 /**
@@ -2657,24 +2720,65 @@ enum drm_i915_perf_record_type {
 	DRM_I915_PERF_RECORD_MAX /* non-ABI */
 };
 
-/*
+/**
+ * struct drm_i915_perf_oa_config
+ *
  * Structure to upload perf dynamic configuration into the kernel.
  */
 struct drm_i915_perf_oa_config {
-	/** String formatted like "%08x-%04x-%04x-%04x-%012x" */
+	/**
+	 * @uuid:
+	 *
+	 * String formatted like "%\08x-%\04x-%\04x-%\04x-%\012x"
+	 */
 	char uuid[36];
 
+	/**
+	 * @n_mux_regs:
+	 *
+	 * Number of mux regs in &mux_regs_ptr.
+	 */
 	__u32 n_mux_regs;
+
+	/**
+	 * @n_boolean_regs:
+	 *
+	 * Number of boolean regs in &boolean_regs_ptr.
+	 */
 	__u32 n_boolean_regs;
+
+	/**
+	 * @n_flex_regs:
+	 *
+	 * Number of flex regs in &flex_regs_ptr.
+	 */
 	__u32 n_flex_regs;
 
-	/*
-	 * These fields are pointers to tuples of u32 values (register address,
-	 * value). For example the expected length of the buffer pointed by
-	 * mux_regs_ptr is (2 * sizeof(u32) * n_mux_regs).
+	/**
+	 * @mux_regs_ptr:
+	 *
+	 * Pointer to tuples of u32 values (register address, value) for mux
+	 * registers.  Expected length of buffer is (2 * sizeof(u32) *
+	 * &n_mux_regs).
 	 */
 	__u64 mux_regs_ptr;
+
+	/**
+	 * @boolean_regs_ptr:
+	 *
+	 * Pointer to tuples of u32 values (register address, value) for mux
+	 * registers.  Expected length of buffer is (2 * sizeof(u32) *
+	 * &n_boolean_regs).
+	 */
 	__u64 boolean_regs_ptr;
+
+	/**
+	 * @flex_regs_ptr:
+	 *
+	 * Pointer to tuples of u32 values (register address, value) for mux
+	 * registers.  Expected length of buffer is (2 * sizeof(u32) *
+	 * &n_flex_regs).
+	 */
 	__u64 flex_regs_ptr;
 };
 
@@ -2685,12 +2789,24 @@ struct drm_i915_perf_oa_config {
  * @data_ptr is also depends on the specific @query_id.
  */
 struct drm_i915_query_item {
-	/** @query_id: The id for this query */
+	/**
+	 * @query_id:
+	 *
+	 * The id for this query.  Currently accepted query IDs are:
+	 *  - %DRM_I915_QUERY_TOPOLOGY_INFO (see struct drm_i915_query_topology_info)
+	 *  - %DRM_I915_QUERY_ENGINE_INFO (see struct drm_i915_engine_info)
+	 *  - %DRM_I915_QUERY_PERF_CONFIG (see struct drm_i915_query_perf_config)
+	 *  - %DRM_I915_QUERY_MEMORY_REGIONS (see struct drm_i915_query_memory_regions)
+	 *  - %DRM_I915_QUERY_HWCONFIG_BLOB (see `GuC HWCONFIG blob uAPI`)
+	 *  - %DRM_I915_QUERY_GEOMETRY_SUBSLICES (see struct drm_i915_query_topology_info)
+	 */
 	__u64 query_id;
-#define DRM_I915_QUERY_TOPOLOGY_INFO    1
-#define DRM_I915_QUERY_ENGINE_INFO	2
-#define DRM_I915_QUERY_PERF_CONFIG      3
-#define DRM_I915_QUERY_MEMORY_REGIONS   4
+#define DRM_I915_QUERY_TOPOLOGY_INFO		1
+#define DRM_I915_QUERY_ENGINE_INFO		2
+#define DRM_I915_QUERY_PERF_CONFIG		3
+#define DRM_I915_QUERY_MEMORY_REGIONS		4
+#define DRM_I915_QUERY_HWCONFIG_BLOB		5
+#define DRM_I915_QUERY_GEOMETRY_SUBSLICES	6
 /* Must be kept compact -- no holes and well documented */
 
 	/**
@@ -2706,14 +2822,17 @@ struct drm_i915_query_item {
 	/**
 	 * @flags:
 	 *
-	 * When query_id == DRM_I915_QUERY_TOPOLOGY_INFO, must be 0.
+	 * When &query_id == %DRM_I915_QUERY_TOPOLOGY_INFO, must be 0.
 	 *
-	 * When query_id == DRM_I915_QUERY_PERF_CONFIG, must be one of the
+	 * When &query_id == %DRM_I915_QUERY_PERF_CONFIG, must be one of the
 	 * following:
 	 *
-	 *	- DRM_I915_QUERY_PERF_CONFIG_LIST
-	 *      - DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID
-	 *      - DRM_I915_QUERY_PERF_CONFIG_FOR_UUID
+	 *	- %DRM_I915_QUERY_PERF_CONFIG_LIST
+	 *      - %DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID
+	 *      - %DRM_I915_QUERY_PERF_CONFIG_FOR_UUID
+	 *
+	 * When &query_id == %DRM_I915_QUERY_GEOMETRY_SUBSLICES must contain
+	 * a struct i915_engine_class_instance that references a render engine.
 	 */
 	__u32 flags;
 #define DRM_I915_QUERY_PERF_CONFIG_LIST          1
@@ -2771,66 +2890,112 @@ struct drm_i915_query {
 	__u64 items_ptr;
 };
 
-/*
- * Data written by the kernel with query DRM_I915_QUERY_TOPOLOGY_INFO :
- *
- * data: contains the 3 pieces of information :
- *
- * - the slice mask with one bit per slice telling whether a slice is
- *   available. The availability of slice X can be queried with the following
- *   formula :
- *
- *           (data[X / 8] >> (X % 8)) & 1
- *
- * - the subslice mask for each slice with one bit per subslice telling
- *   whether a subslice is available. Gen12 has dual-subslices, which are
- *   similar to two gen11 subslices. For gen12, this array represents dual-
- *   subslices. The availability of subslice Y in slice X can be queried
- *   with the following formula :
- *
- *           (data[subslice_offset +
- *                 X * subslice_stride +
- *                 Y / 8] >> (Y % 8)) & 1
- *
- * - the EU mask for each subslice in each slice with one bit per EU telling
- *   whether an EU is available. The availability of EU Z in subslice Y in
- *   slice X can be queried with the following formula :
+/**
+ * struct drm_i915_query_topology_info
  *
- *           (data[eu_offset +
- *                 (X * max_subslices + Y) * eu_stride +
- *                 Z / 8] >> (Z % 8)) & 1
+ * Describes slice/subslice/EU information queried by
+ * %DRM_I915_QUERY_TOPOLOGY_INFO
  */
 struct drm_i915_query_topology_info {
-	/*
+	/**
+	 * @flags:
+	 *
 	 * Unused for now. Must be cleared to zero.
 	 */
 	__u16 flags;
 
+	/**
+	 * @max_slices:
+	 *
+	 * The number of bits used to express the slice mask.
+	 */
 	__u16 max_slices;
+
+	/**
+	 * @max_subslices:
+	 *
+	 * The number of bits used to express the subslice mask.
+	 */
 	__u16 max_subslices;
+
+	/**
+	 * @max_eus_per_subslice:
+	 *
+	 * The number of bits in the EU mask that correspond to a single
+	 * subslice's EUs.
+	 */
 	__u16 max_eus_per_subslice;
 
-	/*
+	/**
+	 * @subslice_offset:
+	 *
 	 * Offset in data[] at which the subslice masks are stored.
 	 */
 	__u16 subslice_offset;
 
-	/*
+	/**
+	 * @subslice_stride:
+	 *
 	 * Stride at which each of the subslice masks for each slice are
 	 * stored.
 	 */
 	__u16 subslice_stride;
 
-	/*
+	/**
+	 * @eu_offset:
+	 *
 	 * Offset in data[] at which the EU masks are stored.
 	 */
 	__u16 eu_offset;
 
-	/*
+	/**
+	 * @eu_stride:
+	 *
 	 * Stride at which each of the EU masks for each subslice are stored.
 	 */
 	__u16 eu_stride;
 
+	/**
+	 * @data:
+	 *
+	 * Contains 3 pieces of information :
+	 *
+	 * - The slice mask with one bit per slice telling whether a slice is
+	 *   available. The availability of slice X can be queried with the
+	 *   following formula :
+	 *
+	 *   .. code:: c
+	 *
+	 *      (data[X / 8] >> (X % 8)) & 1
+	 *
+	 *   Starting with Xe_HP platforms, Intel hardware no longer has
+	 *   traditional slices so i915 will always report a single slice
+	 *   (hardcoded slicemask = 0x1) which contains all of the platform's
+	 *   subslices.  I.e., the mask here does not reflect any of the newer
+	 *   hardware concepts such as "gslices" or "cslices" since userspace
+	 *   is capable of inferring those from the subslice mask.
+	 *
+	 * - The subslice mask for each slice with one bit per subslice telling
+	 *   whether a subslice is available.  Starting with Gen12 we use the
+	 *   term "subslice" to refer to what the hardware documentation
+	 *   describes as a "dual-subslices."  The availability of subslice Y
+	 *   in slice X can be queried with the following formula :
+	 *
+	 *   .. code:: c
+	 *
+	 *      (data[subslice_offset + X * subslice_stride + Y / 8] >> (Y % 8)) & 1
+	 *
+	 * - The EU mask for each subslice in each slice, with one bit per EU
+	 *   telling whether an EU is available. The availability of EU Z in
+	 *   subslice Y in slice X can be queried with the following formula :
+	 *
+	 *   .. code:: c
+	 *
+	 *      (data[eu_offset +
+	 *            (X * max_subslices + Y) * eu_stride +
+	 *            Z / 8
+	 *       ] >> (Z % 8)) & 1
+	 */
 	__u8 data[];
 };
 
@@ -2951,52 +3116,68 @@ struct drm_i915_query_engine_info {
 	struct drm_i915_engine_info engines[];
 };
 
-/*
- * Data written by the kernel with query DRM_I915_QUERY_PERF_CONFIG.
+/**
+ * struct drm_i915_query_perf_config
+ *
+ * Data written by the kernel with query %DRM_I915_QUERY_PERF_CONFIG and
+ * %DRM_I915_QUERY_GEOMETRY_SUBSLICES.
  */
 struct drm_i915_query_perf_config {
 	union {
-		/*
-		 * When query_item.flags == DRM_I915_QUERY_PERF_CONFIG_LIST, i915 sets
-		 * this fields to the number of configurations available.
+		/**
+		 * @n_configs:
+		 *
+		 * When &drm_i915_query_item.flags ==
+		 * %DRM_I915_QUERY_PERF_CONFIG_LIST, i915 sets this fields to
+		 * the number of configurations available.
 		 */
 		__u64 n_configs;
 
-		/*
-		 * When query_id == DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_ID,
-		 * i915 will use the value in this field as configuration
-		 * identifier to decide what data to write into config_ptr.
+		/**
+		 * @config:
+		 *
+		 * When &drm_i915_query_item.flags ==
+		 * %DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_ID, i915 will use the
+		 * value in this field as configuration identifier to decide
+		 * what data to write into config_ptr.
 		 */
 		__u64 config;
 
-		/*
-		 * When query_id == DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID,
-		 * i915 will use the value in this field as configuration
-		 * identifier to decide what data to write into config_ptr.
+		/**
+		 * @uuid:
+		 *
+		 * When &drm_i915_query_item.flags ==
+		 * %DRM_I915_QUERY_PERF_CONFIG_DATA_FOR_UUID, i915 will use the
+		 * value in this field as configuration identifier to decide
+		 * what data to write into config_ptr.
 		 *
 		 * String formatted like "%08x-%04x-%04x-%04x-%012x"
 		 */
 		char uuid[36];
 	};
 
-	/*
+	/**
+	 * @flags:
+	 *
 	 * Unused for now. Must be cleared to zero.
 	 */
 	__u32 flags;
 
-	/*
-	 * When query_item.flags == DRM_I915_QUERY_PERF_CONFIG_LIST, i915 will
-	 * write an array of __u64 of configuration identifiers.
+	/**
+	 * @data:
 	 *
-	 * When query_item.flags == DRM_I915_QUERY_PERF_CONFIG_DATA, i915 will
-	 * write a struct drm_i915_perf_oa_config. If the following fields of
-	 * drm_i915_perf_oa_config are set not set to 0, i915 will write into
-	 * the associated pointers the values of submitted when the
+	 * When &drm_i915_query_item.flags == %DRM_I915_QUERY_PERF_CONFIG_LIST,
+	 * i915 will write an array of __u64 of configuration identifiers.
+	 *
+	 * When &drm_i915_query_item.flags == %DRM_I915_QUERY_PERF_CONFIG_DATA,
+	 * i915 will write a struct drm_i915_perf_oa_config. If the following
+	 * fields of struct drm_i915_perf_oa_config are not set to 0, i915 will
+	 * write into the associated pointers the values of submitted when the
 	 * configuration was created :
 	 *
-	 *         - n_mux_regs
-	 *         - n_boolean_regs
-	 *         - n_flex_regs
+	 *  - &drm_i915_perf_oa_config.n_mux_regs
+	 *  - &drm_i915_perf_oa_config.n_boolean_regs
+	 *  - &drm_i915_perf_oa_config.n_flex_regs
 	 */
 	__u8 data[];
 };
@@ -3134,6 +3315,16 @@ struct drm_i915_query_memory_regions {
 	struct drm_i915_memory_region_info regions[];
 };
 
+/**
+ * DOC: GuC HWCONFIG blob uAPI
+ *
+ * The GuC produces a blob with information about the current device.
+ * i915 reads this blob from GuC and makes it available via this uAPI.
+ *
+ * The format and meaning of the blob content are documented in the
+ * Programmer's Reference Manual.
+ */
+
 /**
  * struct drm_i915_gem_create_ext - Existing gem_create behaviour, with added
  * extension support using struct i915_user_extension.
-- 
2.36.1

