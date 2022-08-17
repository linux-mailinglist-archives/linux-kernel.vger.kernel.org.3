Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BDE596FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbiHQNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiHQNWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:22:54 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F067175
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:22:51 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id b4so5137843uaw.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc;
        bh=RhWwjvk6tYh/PbRXecVWj4vI12F8ZEOLSvwdYa4caHM=;
        b=NH+4PFPUWUXUuytFY+WW5Aof5nU3h0Ve57aKMMxz8ZVEoB3BxhZ7CEU9WT2WvrFBMj
         1+0Spdf5j7dhwoz64hQVOYjBZ60ZHrk5wOSxqQvGvUmR6YRQSiYTDrCFQ65hmpH9Oqse
         ClKfiA609j3/AoLWVllScoTe2bo2V+l4peclg/KESAs2E/U8TA0JXeP1TQF/nHbwWt0A
         JCBsbtuB0QTy5O190Hy1gP3ebyPxLduZEUqFexn8zhSqKCjZgzyPNn0IkOTWwWxFJy6y
         UPCcV4jU5H0xdtjwZW5aKoPVbJ95WPVFz92casIHBhG16eiuNG03KCU5R6pfkc7zBx2a
         oEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc;
        bh=RhWwjvk6tYh/PbRXecVWj4vI12F8ZEOLSvwdYa4caHM=;
        b=0iDDCxz1od4W3F7ULjsjRqa4OgfDO7xYSwehWLPDr9FuJW/MAZ3HxI88jpe3p24mR/
         L8mH+pKcQpTzP7v5Gkot4kmvu5WUcI6IVNjhBJI1uFhBcIP0rrUZ2FxrCvqfVGnxkp8E
         vcLr0BAZCqSedt0z27ACdzFhW0mmJFwBJ2wtoBNMqff52QbcB1ut0FLCy1jjDlJqTGTY
         oMG9a3V9ywksntOHYDenPvgbAA0fwwUjVZik12IuPQJYSwjJvd/fVpQEEjOpyAYYiEXC
         GXAi5DcK0cFRQst8IiBx3Ac2S1zlstD736GOi4pRj/CXx/uIwWmCDnNUuTzxYzVZ3t3w
         CuCw==
X-Gm-Message-State: ACgBeo2pRNvnUsHt7BSlqwSBYmM62Byu6BKSMzClszUWhF6HaPGEEpro
        uIIBk0xGHdMfZ7Y3aY3oUV9CvWCCaV8=
X-Google-Smtp-Source: AA6agR6xNRa5SHrCGz82WGuwIXkq57ehtmiv7PEr8cW2n1ukgHpuTSUTEkxl1RTApyh9Sh9ILus3YQ==
X-Received: by 2002:ab0:16de:0:b0:382:9f1e:af88 with SMTP id g30-20020ab016de000000b003829f1eaf88mr10525296uaf.39.1660742570684;
        Wed, 17 Aug 2022 06:22:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.239.32])
        by smtp.gmail.com with ESMTPSA id y24-20020a67bd18000000b003575368c463sm8319916vsq.21.2022.08.17.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 06:22:50 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46AE74035A; Wed, 17 Aug 2022 10:22:47 -0300 (-03)
Date:   Wed, 17 Aug 2022 10:22:47 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Ramalingam C <ramalingam.c@intel.com>
Subject: [PATCH FYI 1/1] tools headers UAPI: Sync drm/i915_drm.h with the
 kernel sources
Message-ID: <Yvzrp9RFIeEkb5fI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
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

  a913bde810fc464d ("drm/i915: Update i915 uapi documentation")
  525e93f6317a08a0 ("drm/i915/uapi: add NEEDS_CPU_ACCESS hint")
  141f733bb3abb000 ("drm/i915/uapi: expose the avail tracking")
  3f4309cbdc849637 ("drm/i915/uapi: add probed_cpu_visible_size")
  a50794f26f52c66c ("uapi/drm/i915: Document memory residency and Flat-CCS capability of obj")

That don't add any new ioctl, so no changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: Ramalingam C <ramalingam.c@intel.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 387 +++++++++++++++++++++++-------
 1 file changed, 300 insertions(+), 87 deletions(-)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index b28ff5d881457af5..520ad2691a99d166 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -751,14 +751,27 @@ typedef struct drm_i915_irq_wait {
 
 /* Must be kept compact -- no holes and well documented */
 
-typedef struct drm_i915_getparam {
+/**
+ * struct drm_i915_getparam - Driver parameter query structure.
+ */
+struct drm_i915_getparam {
+	/** @param: Driver parameter to query. */
 	__s32 param;
-	/*
+
+	/**
+	 * @value: Address of memory where queried value should be put.
+	 *
 	 * WARNING: Using pointers instead of fixed-size u64 means we need to write
 	 * compat32 code. Don't repeat this mistake.
 	 */
 	int __user *value;
-} drm_i915_getparam_t;
+};
+
+/**
+ * typedef drm_i915_getparam_t - Driver parameter query structure.
+ * See struct drm_i915_getparam.
+ */
+typedef struct drm_i915_getparam drm_i915_getparam_t;
 
 /* Ioctl to set kernel params:
  */
@@ -1239,76 +1252,119 @@ struct drm_i915_gem_exec_object2 {
 	__u64 rsvd2;
 };
 
+/**
+ * struct drm_i915_gem_exec_fence - An input or output fence for the execbuf
+ * ioctl.
+ *
+ * The request will wait for input fence to signal before submission.
+ *
+ * The returned output fence will be signaled after the completion of the
+ * request.
+ */
 struct drm_i915_gem_exec_fence {
-	/**
-	 * User's handle for a drm_syncobj to wait on or signal.
-	 */
+	/** @handle: User's handle for a drm_syncobj to wait on or signal. */
 	__u32 handle;
 
+	/**
+	 * @flags: Supported flags are:
+	 *
+	 * I915_EXEC_FENCE_WAIT:
+	 * Wait for the input fence before request submission.
+	 *
+	 * I915_EXEC_FENCE_SIGNAL:
+	 * Return request completion fence as output
+	 */
+	__u32 flags;
 #define I915_EXEC_FENCE_WAIT            (1<<0)
 #define I915_EXEC_FENCE_SIGNAL          (1<<1)
 #define __I915_EXEC_FENCE_UNKNOWN_FLAGS (-(I915_EXEC_FENCE_SIGNAL << 1))
-	__u32 flags;
 };
 
-/*
- * See drm_i915_gem_execbuffer_ext_timeline_fences.
- */
-#define DRM_I915_GEM_EXECBUFFER_EXT_TIMELINE_FENCES 0
-
-/*
+/**
+ * struct drm_i915_gem_execbuffer_ext_timeline_fences - Timeline fences
+ * for execbuf ioctl.
+ *
  * This structure describes an array of drm_syncobj and associated points for
  * timeline variants of drm_syncobj. It is invalid to append this structure to
  * the execbuf if I915_EXEC_FENCE_ARRAY is set.
  */
 struct drm_i915_gem_execbuffer_ext_timeline_fences {
+#define DRM_I915_GEM_EXECBUFFER_EXT_TIMELINE_FENCES 0
+	/** @base: Extension link. See struct i915_user_extension. */
 	struct i915_user_extension base;
 
 	/**
-	 * Number of element in the handles_ptr & value_ptr arrays.
+	 * @fence_count: Number of elements in the @handles_ptr & @value_ptr
+	 * arrays.
 	 */
 	__u64 fence_count;
 
 	/**
-	 * Pointer to an array of struct drm_i915_gem_exec_fence of length
-	 * fence_count.
+	 * @handles_ptr: Pointer to an array of struct drm_i915_gem_exec_fence
+	 * of length @fence_count.
 	 */
 	__u64 handles_ptr;
 
 	/**
-	 * Pointer to an array of u64 values of length fence_count. Values
-	 * must be 0 for a binary drm_syncobj. A Value of 0 for a timeline
-	 * drm_syncobj is invalid as it turns a drm_syncobj into a binary one.
+	 * @values_ptr: Pointer to an array of u64 values of length
+	 * @fence_count.
+	 * Values must be 0 for a binary drm_syncobj. A Value of 0 for a
+	 * timeline drm_syncobj is invalid as it turns a drm_syncobj into a
+	 * binary one.
 	 */
 	__u64 values_ptr;
 };
 
+/**
+ * struct drm_i915_gem_execbuffer2 - Structure for DRM_I915_GEM_EXECBUFFER2
+ * ioctl.
+ */
 struct drm_i915_gem_execbuffer2 {
-	/**
-	 * List of gem_exec_object2 structs
-	 */
+	/** @buffers_ptr: Pointer to a list of gem_exec_object2 structs */
 	__u64 buffers_ptr;
+
+	/** @buffer_count: Number of elements in @buffers_ptr array */
 	__u32 buffer_count;
 
-	/** Offset in the batchbuffer to start execution from. */
+	/**
+	 * @batch_start_offset: Offset in the batchbuffer to start execution
+	 * from.
+	 */
 	__u32 batch_start_offset;
-	/** Bytes used in batchbuffer from batch_start_offset */
+
+	/**
+	 * @batch_len: Length in bytes of the batch buffer, starting from the
+	 * @batch_start_offset. If 0, length is assumed to be the batch buffer
+	 * object size.
+	 */
 	__u32 batch_len;
+
+	/** @DR1: deprecated */
 	__u32 DR1;
+
+	/** @DR4: deprecated */
 	__u32 DR4;
+
+	/** @num_cliprects: See @cliprects_ptr */
 	__u32 num_cliprects;
+
 	/**
-	 * This is a struct drm_clip_rect *cliprects if I915_EXEC_FENCE_ARRAY
-	 * & I915_EXEC_USE_EXTENSIONS are not set.
+	 * @cliprects_ptr: Kernel clipping was a DRI1 misfeature.
+	 *
+	 * It is invalid to use this field if I915_EXEC_FENCE_ARRAY or
+	 * I915_EXEC_USE_EXTENSIONS flags are not set.
 	 *
 	 * If I915_EXEC_FENCE_ARRAY is set, then this is a pointer to an array
-	 * of struct drm_i915_gem_exec_fence and num_cliprects is the length
-	 * of the array.
+	 * of &drm_i915_gem_exec_fence and @num_cliprects is the length of the
+	 * array.
 	 *
 	 * If I915_EXEC_USE_EXTENSIONS is set, then this is a pointer to a
-	 * single struct i915_user_extension and num_cliprects is 0.
+	 * single &i915_user_extension and num_cliprects is 0.
 	 */
 	__u64 cliprects_ptr;
+
+	/** @flags: Execbuf flags */
+	__u64 flags;
 #define I915_EXEC_RING_MASK              (0x3f)
 #define I915_EXEC_DEFAULT                (0<<0)
 #define I915_EXEC_RENDER                 (1<<0)
@@ -1326,10 +1382,6 @@ struct drm_i915_gem_execbuffer2 {
 #define I915_EXEC_CONSTANTS_REL_GENERAL (0<<6) /* default */
 #define I915_EXEC_CONSTANTS_ABSOLUTE 	(1<<6)
 #define I915_EXEC_CONSTANTS_REL_SURFACE (2<<6) /* gen4/5 only */
-	__u64 flags;
-	__u64 rsvd1; /* now used for context info */
-	__u64 rsvd2;
-};
 
 /** Resets the SO write offset registers for transform feedback on gen7. */
 #define I915_EXEC_GEN7_SOL_RESET	(1<<8)
@@ -1432,9 +1484,23 @@ struct drm_i915_gem_execbuffer2 {
  * drm_i915_gem_execbuffer_ext enum.
  */
 #define I915_EXEC_USE_EXTENSIONS	(1 << 21)
-
 #define __I915_EXEC_UNKNOWN_FLAGS (-(I915_EXEC_USE_EXTENSIONS << 1))
 
+	/** @rsvd1: Context id */
+	__u64 rsvd1;
+
+	/**
+	 * @rsvd2: in and out sync_file file descriptors.
+	 *
+	 * When I915_EXEC_FENCE_IN or I915_EXEC_FENCE_SUBMIT flag is set, the
+	 * lower 32 bits of this field will have the in sync_file fd (input).
+	 *
+	 * When I915_EXEC_FENCE_OUT flag is set, the upper 32 bits of this
+	 * field will have the out sync_file fd (output).
+	 */
+	__u64 rsvd2;
+};
+
 #define I915_EXEC_CONTEXT_ID_MASK	(0xffffffff)
 #define i915_execbuffer2_set_context_id(eb2, context) \
 	(eb2).rsvd1 = context & I915_EXEC_CONTEXT_ID_MASK
@@ -1814,19 +1880,58 @@ struct drm_i915_gem_context_create {
 	__u32 pad;
 };
 
+/**
+ * struct drm_i915_gem_context_create_ext - Structure for creating contexts.
+ */
 struct drm_i915_gem_context_create_ext {
-	__u32 ctx_id; /* output: id of new context*/
+	/** @ctx_id: Id of the created context (output) */
+	__u32 ctx_id;
+
+	/**
+	 * @flags: Supported flags are:
+	 *
+	 * I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS:
+	 *
+	 * Extensions may be appended to this structure and driver must check
+	 * for those. See @extensions.
+	 *
+	 * I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE
+	 *
+	 * Created context will have single timeline.
+	 */
 	__u32 flags;
 #define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS	(1u << 0)
 #define I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE	(1u << 1)
 #define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
 	(-(I915_CONTEXT_CREATE_FLAGS_SINGLE_TIMELINE << 1))
+
+	/**
+	 * @extensions: Zero-terminated chain of extensions.
+	 *
+	 * I915_CONTEXT_CREATE_EXT_SETPARAM:
+	 * Context parameter to set or query during context creation.
+	 * See struct drm_i915_gem_context_create_ext_setparam.
+	 *
+	 * I915_CONTEXT_CREATE_EXT_CLONE:
+	 * This extension has been removed. On the off chance someone somewhere
+	 * has attempted to use it, never re-use this extension number.
+	 */
 	__u64 extensions;
+#define I915_CONTEXT_CREATE_EXT_SETPARAM 0
+#define I915_CONTEXT_CREATE_EXT_CLONE 1
 };
 
+/**
+ * struct drm_i915_gem_context_param - Context parameter to set or query.
+ */
 struct drm_i915_gem_context_param {
+	/** @ctx_id: Context id */
 	__u32 ctx_id;
+
+	/** @size: Size of the parameter @value */
 	__u32 size;
+
+	/** @param: Parameter to set or query */
 	__u64 param;
 #define I915_CONTEXT_PARAM_BAN_PERIOD	0x1
 /* I915_CONTEXT_PARAM_NO_ZEROMAP has been removed.  On the off chance
@@ -1973,6 +2078,7 @@ struct drm_i915_gem_context_param {
 #define I915_CONTEXT_PARAM_PROTECTED_CONTENT    0xd
 /* Must be kept compact -- no holes and well documented */
 
+	/** @value: Context parameter value to be set or queried */
 	__u64 value;
 };
 
@@ -2371,23 +2477,29 @@ struct i915_context_param_engines {
 	struct i915_engine_class_instance engines[N__]; \
 } __attribute__((packed)) name__
 
+/**
+ * struct drm_i915_gem_context_create_ext_setparam - Context parameter
+ * to set or query during context creation.
+ */
 struct drm_i915_gem_context_create_ext_setparam {
-#define I915_CONTEXT_CREATE_EXT_SETPARAM 0
+	/** @base: Extension link. See struct i915_user_extension. */
 	struct i915_user_extension base;
+
+	/**
+	 * @param: Context parameter to set or query.
+	 * See struct drm_i915_gem_context_param.
+	 */
 	struct drm_i915_gem_context_param param;
 };
 
-/* This API has been removed.  On the off chance someone somewhere has
- * attempted to use it, never re-use this extension number.
- */
-#define I915_CONTEXT_CREATE_EXT_CLONE 1
-
 struct drm_i915_gem_context_destroy {
 	__u32 ctx_id;
 	__u32 pad;
 };
 
-/*
+/**
+ * struct drm_i915_gem_vm_control - Structure to create or destroy VM.
+ *
  * DRM_I915_GEM_VM_CREATE -
  *
  * Create a new virtual memory address space (ppGTT) for use within a context
@@ -2397,20 +2509,23 @@ struct drm_i915_gem_context_destroy {
  * The id of new VM (bound to the fd) for use with I915_CONTEXT_PARAM_VM is
  * returned in the outparam @id.
  *
- * No flags are defined, with all bits reserved and must be zero.
- *
  * An extension chain maybe provided, starting with @extensions, and terminated
  * by the @next_extension being 0. Currently, no extensions are defined.
  *
  * DRM_I915_GEM_VM_DESTROY -
  *
- * Destroys a previously created VM id, specified in @id.
+ * Destroys a previously created VM id, specified in @vm_id.
  *
  * No extensions or flags are allowed currently, and so must be zero.
  */
 struct drm_i915_gem_vm_control {
+	/** @extensions: Zero-terminated chain of extensions. */
 	__u64 extensions;
+
+	/** @flags: reserved for future usage, currently MBZ */
 	__u32 flags;
+
+	/** @vm_id: Id of the VM created or to be destroyed */
 	__u32 vm_id;
 };
 
@@ -3207,36 +3322,6 @@ struct drm_i915_gem_memory_class_instance {
  * struct drm_i915_memory_region_info - Describes one region as known to the
  * driver.
  *
- * Note that we reserve some stuff here for potential future work. As an example
- * we might want expose the capabilities for a given region, which could include
- * things like if the region is CPU mappable/accessible, what are the supported
- * mapping types etc.
- *
- * Note that to extend struct drm_i915_memory_region_info and struct
- * drm_i915_query_memory_regions in the future the plan is to do the following:
- *
- * .. code-block:: C
- *
- *	struct drm_i915_memory_region_info {
- *		struct drm_i915_gem_memory_class_instance region;
- *		union {
- *			__u32 rsvd0;
- *			__u32 new_thing1;
- *		};
- *		...
- *		union {
- *			__u64 rsvd1[8];
- *			struct {
- *				__u64 new_thing2;
- *				__u64 new_thing3;
- *				...
- *			};
- *		};
- *	};
- *
- * With this things should remain source compatible between versions for
- * userspace, even as we add new fields.
- *
  * Note this is using both struct drm_i915_query_item and struct drm_i915_query.
  * For this new query we are adding the new query id DRM_I915_QUERY_MEMORY_REGIONS
  * at &drm_i915_query_item.query_id.
@@ -3248,14 +3333,81 @@ struct drm_i915_memory_region_info {
 	/** @rsvd0: MBZ */
 	__u32 rsvd0;
 
-	/** @probed_size: Memory probed by the driver (-1 = unknown) */
+	/**
+	 * @probed_size: Memory probed by the driver
+	 *
+	 * Note that it should not be possible to ever encounter a zero value
+	 * here, also note that no current region type will ever return -1 here.
+	 * Although for future region types, this might be a possibility. The
+	 * same applies to the other size fields.
+	 */
 	__u64 probed_size;
 
-	/** @unallocated_size: Estimate of memory remaining (-1 = unknown) */
+	/**
+	 * @unallocated_size: Estimate of memory remaining
+	 *
+	 * Requires CAP_PERFMON or CAP_SYS_ADMIN to get reliable accounting.
+	 * Without this (or if this is an older kernel) the value here will
+	 * always equal the @probed_size. Note this is only currently tracked
+	 * for I915_MEMORY_CLASS_DEVICE regions (for other types the value here
+	 * will always equal the @probed_size).
+	 */
 	__u64 unallocated_size;
 
-	/** @rsvd1: MBZ */
-	__u64 rsvd1[8];
+	union {
+		/** @rsvd1: MBZ */
+		__u64 rsvd1[8];
+		struct {
+			/**
+			 * @probed_cpu_visible_size: Memory probed by the driver
+			 * that is CPU accessible.
+			 *
+			 * This will be always be <= @probed_size, and the
+			 * remainder (if there is any) will not be CPU
+			 * accessible.
+			 *
+			 * On systems without small BAR, the @probed_size will
+			 * always equal the @probed_cpu_visible_size, since all
+			 * of it will be CPU accessible.
+			 *
+			 * Note this is only tracked for
+			 * I915_MEMORY_CLASS_DEVICE regions (for other types the
+			 * value here will always equal the @probed_size).
+			 *
+			 * Note that if the value returned here is zero, then
+			 * this must be an old kernel which lacks the relevant
+			 * small-bar uAPI support (including
+			 * I915_GEM_CREATE_EXT_FLAG_NEEDS_CPU_ACCESS), but on
+			 * such systems we should never actually end up with a
+			 * small BAR configuration, assuming we are able to load
+			 * the kernel module. Hence it should be safe to treat
+			 * this the same as when @probed_cpu_visible_size ==
+			 * @probed_size.
+			 */
+			__u64 probed_cpu_visible_size;
+
+			/**
+			 * @unallocated_cpu_visible_size: Estimate of CPU
+			 * visible memory remaining.
+			 *
+			 * Note this is only tracked for
+			 * I915_MEMORY_CLASS_DEVICE regions (for other types the
+			 * value here will always equal the
+			 * @probed_cpu_visible_size).
+			 *
+			 * Requires CAP_PERFMON or CAP_SYS_ADMIN to get reliable
+			 * accounting.  Without this the value here will always
+			 * equal the @probed_cpu_visible_size. Note this is only
+			 * currently tracked for I915_MEMORY_CLASS_DEVICE
+			 * regions (for other types the value here will also
+			 * always equal the @probed_cpu_visible_size).
+			 *
+			 * If this is an older kernel the value here will be
+			 * zero, see also @probed_cpu_visible_size.
+			 */
+			__u64 unallocated_cpu_visible_size;
+		};
+	};
 };
 
 /**
@@ -3329,11 +3481,11 @@ struct drm_i915_query_memory_regions {
  * struct drm_i915_gem_create_ext - Existing gem_create behaviour, with added
  * extension support using struct i915_user_extension.
  *
- * Note that in the future we want to have our buffer flags here, at least for
- * the stuff that is immutable. Previously we would have two ioctls, one to
- * create the object with gem_create, and another to apply various parameters,
- * however this creates some ambiguity for the params which are considered
- * immutable. Also in general we're phasing out the various SET/GET ioctls.
+ * Note that new buffer flags should be added here, at least for the stuff that
+ * is immutable. Previously we would have two ioctls, one to create the object
+ * with gem_create, and another to apply various parameters, however this
+ * creates some ambiguity for the params which are considered immutable. Also in
+ * general we're phasing out the various SET/GET ioctls.
  */
 struct drm_i915_gem_create_ext {
 	/**
@@ -3341,7 +3493,6 @@ struct drm_i915_gem_create_ext {
 	 *
 	 * The (page-aligned) allocated size for the object will be returned.
 	 *
-	 *
 	 * DG2 64K min page size implications:
 	 *
 	 * On discrete platforms, starting from DG2, we have to contend with GTT
@@ -3353,7 +3504,9 @@ struct drm_i915_gem_create_ext {
 	 *
 	 * Note that the returned size here will always reflect any required
 	 * rounding up done by the kernel, i.e 4K will now become 64K on devices
-	 * such as DG2.
+	 * such as DG2. The kernel will always select the largest minimum
+	 * page-size for the set of possible placements as the value to use when
+	 * rounding up the @size.
 	 *
 	 * Special DG2 GTT address alignment requirement:
 	 *
@@ -3377,14 +3530,58 @@ struct drm_i915_gem_create_ext {
 	 * is deemed to be a good compromise.
 	 */
 	__u64 size;
+
 	/**
 	 * @handle: Returned handle for the object.
 	 *
 	 * Object handles are nonzero.
 	 */
 	__u32 handle;
-	/** @flags: MBZ */
+
+	/**
+	 * @flags: Optional flags.
+	 *
+	 * Supported values:
+	 *
+	 * I915_GEM_CREATE_EXT_FLAG_NEEDS_CPU_ACCESS - Signal to the kernel that
+	 * the object will need to be accessed via the CPU.
+	 *
+	 * Only valid when placing objects in I915_MEMORY_CLASS_DEVICE, and only
+	 * strictly required on configurations where some subset of the device
+	 * memory is directly visible/mappable through the CPU (which we also
+	 * call small BAR), like on some DG2+ systems. Note that this is quite
+	 * undesirable, but due to various factors like the client CPU, BIOS etc
+	 * it's something we can expect to see in the wild. See
+	 * &drm_i915_memory_region_info.probed_cpu_visible_size for how to
+	 * determine if this system applies.
+	 *
+	 * Note that one of the placements MUST be I915_MEMORY_CLASS_SYSTEM, to
+	 * ensure the kernel can always spill the allocation to system memory,
+	 * if the object can't be allocated in the mappable part of
+	 * I915_MEMORY_CLASS_DEVICE.
+	 *
+	 * Also note that since the kernel only supports flat-CCS on objects
+	 * that can *only* be placed in I915_MEMORY_CLASS_DEVICE, we therefore
+	 * don't support I915_GEM_CREATE_EXT_FLAG_NEEDS_CPU_ACCESS together with
+	 * flat-CCS.
+	 *
+	 * Without this hint, the kernel will assume that non-mappable
+	 * I915_MEMORY_CLASS_DEVICE is preferred for this object. Note that the
+	 * kernel can still migrate the object to the mappable part, as a last
+	 * resort, if userspace ever CPU faults this object, but this might be
+	 * expensive, and so ideally should be avoided.
+	 *
+	 * On older kernels which lack the relevant small-bar uAPI support (see
+	 * also &drm_i915_memory_region_info.probed_cpu_visible_size),
+	 * usage of the flag will result in an error, but it should NEVER be
+	 * possible to end up with a small BAR configuration, assuming we can
+	 * also successfully load the i915 kernel module. In such cases the
+	 * entire I915_MEMORY_CLASS_DEVICE region will be CPU accessible, and as
+	 * such there are zero restrictions on where the object can be placed.
+	 */
+#define I915_GEM_CREATE_EXT_FLAG_NEEDS_CPU_ACCESS (1 << 0)
 	__u32 flags;
+
 	/**
 	 * @extensions: The chain of extensions to apply to this object.
 	 *
@@ -3443,6 +3640,22 @@ struct drm_i915_gem_create_ext {
  * At which point we get the object handle in &drm_i915_gem_create_ext.handle,
  * along with the final object size in &drm_i915_gem_create_ext.size, which
  * should account for any rounding up, if required.
+ *
+ * Note that userspace has no means of knowing the current backing region
+ * for objects where @num_regions is larger than one. The kernel will only
+ * ensure that the priority order of the @regions array is honoured, either
+ * when initially placing the object, or when moving memory around due to
+ * memory pressure
+ *
+ * On Flat-CCS capable HW, compression is supported for the objects residing
+ * in I915_MEMORY_CLASS_DEVICE. When such objects (compressed) have other
+ * memory class in @regions and migrated (by i915, due to memory
+ * constraints) to the non I915_MEMORY_CLASS_DEVICE region, then i915 needs to
+ * decompress the content. But i915 doesn't have the required information to
+ * decompress the userspace compressed objects.
+ *
+ * So i915 supports Flat-CCS, on the objects which can reside only on
+ * I915_MEMORY_CLASS_DEVICE regions.
  */
 struct drm_i915_gem_create_ext_memory_regions {
 	/** @base: Extension link. See struct i915_user_extension. */
-- 
2.37.1

