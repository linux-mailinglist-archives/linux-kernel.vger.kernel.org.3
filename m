Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EC5AC715
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiIDVoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiIDVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:42 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784DA2C64D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:33 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k9so701142ils.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Yb6CWV+TDDmM9onUuCxvFgBnmtmfnm46mq8t0HXB9jg=;
        b=lHCcfKuE75YvbApb3Q3ZrFKS/VLaGwoG8AzIOt7lRvkN6SBFDFxisWcCRiGMiVWTmH
         Kt63m7En4yLxNz7W7gTVWvhHgavhPV4rIN/E8gjWDoz36fXVQ8TufnV5YiPONZdg0wA9
         PSC+3lVcstXByssTzg5qYKmlsp30bseonqBYHx7jAS4+G7wvrNp/c/1zAFFPf+Zb+I+C
         bM52a0v8IgrcQsDr4+T74tV0XI154yB2HOw02ZrUn321+0Geo88H4CTT7pj1lgDKjIx/
         lz/D5+FWjXkDEy4M7lN8ydHYZ3SpeaGHxvF6OeZEhZdGSQrj5iVYVDwQgerulqIfnVFo
         NX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Yb6CWV+TDDmM9onUuCxvFgBnmtmfnm46mq8t0HXB9jg=;
        b=bvO9hXo32eRk72xuUsux6jTJYNMsUJAJetkKBIHV91Ns5kU018zKkig/p03Pzew8oN
         MXUbh1IzITY/T2jRl12Jp/3N6zIbNbCshekUN4L0IRNU82Ko21DcRbfSZpr6hIifHhcx
         W9wUprLlZOv4xaODV+9qxYRqYsQUhTJeulPU/siNplYSfuKVKehTSN6Bmz0d4fmvGZz0
         BOiHwmNSmoFM5QTj7VF7Vhg23ouEWOS1qI8pXhXRKr4Zr+vHDJgxs7edctu1L7/rKzX+
         O4/H164V3OqJhy7qkWrFERo4U+HgcRx3dDj1VYhBQ00nMxLXfMpWPmN7hjH8vYYuuNL8
         nRLQ==
X-Gm-Message-State: ACgBeo0JEzuXbH0l/RmTAFuW2LHEZ5wwDIritTeyJWc0m5Axv5K4vj9R
        TpaF4CttN+vMiT2Qwr8mH+w=
X-Google-Smtp-Source: AA6agR5Cx+ajN8UUSivj7N6vamViDhkJkE8U1oCqTJYgtKCcaD95EUgEYEoUpvP503z2jlMiKd37Xg==
X-Received: by 2002:a92:6a0d:0:b0:2e5:afe7:8d95 with SMTP id f13-20020a926a0d000000b002e5afe78d95mr24687711ilc.262.1662327752155;
        Sun, 04 Sep 2022 14:42:32 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:31 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 23/57] drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.
Date:   Sun,  4 Sep 2022 15:41:00 -0600
Message-Id: <20220904214134.408619-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DECLARE_DYNDBG_CLASSMAP across DRM:

 - in .c files, since macro defines/initializes a record

 - in drivers, $mod_{drv,drm,param}.c
   ie where param setup is done, since a classmap is param related

 - in drm/drm_print.c
   since existing __drm_debug param is defined there,
   and we ifdef it, and provide an elaborated alternative.

 - in drm_*_helper modules:
   dp/drm_dp - 1st item in makefile target
   drivers/gpu/drm/drm_crtc_helper.c - random pick iirc.

Since these modules all use identical CLASSMAP declarations (ie: names
and .class_id's) they will all respond together to "class DRM_UT_*"
query-commands:

  :#> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control

NOTES:

This changes __drm_debug from int to ulong, so BIT() is usable on it.

DRM's enum drm_debug_category values need to sync with the index of
their respective class-names here.  Then .class_id == category, and
dyndbg's class FOO mechanisms will enable drm_dbg(DRM_UT_KMS, ...).

Though DRM needs consistent categories across all modules, thats not
generally needed; modules X and Y could define FOO differently (ie a
different NAME => class_id mapping), changes are made according to
each module's private class-map.

No callsites are actually selected by this patch, since none are
class'd yet.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++++
 drivers/gpu/drm/display/drm_dp_helper.c | 13 ++++++++++++
 drivers/gpu/drm/drm_crtc_helper.c       | 13 ++++++++++++
 drivers/gpu/drm/drm_print.c             | 27 +++++++++++++++++++++++--
 drivers/gpu/drm/i915/i915_params.c      | 12 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 13 ++++++++++++
 include/drm/drm_print.h                 |  3 ++-
 7 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index de7144b06e93..97e184f44a52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -38,6 +38,8 @@
 #include <linux/mmu_notifier.h>
 #include <linux/suspend.h>
 #include <linux/cc_platform.h>
+#include <linux/fb.h>
+#include <linux/dynamic_debug.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -185,6 +187,18 @@ int amdgpu_vcnfw_log;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
+DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"DRM_UT_CORE",
+			"DRM_UT_DRIVER",
+			"DRM_UT_KMS",
+			"DRM_UT_PRIME",
+			"DRM_UT_ATOMIC",
+			"DRM_UT_VBL",
+			"DRM_UT_STATE",
+			"DRM_UT_LEASE",
+			"DRM_UT_DP",
+			"DRM_UT_DRMRES");
+
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
 	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 92990a3d577a..cbb9c4d6d8f2 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/string_helpers.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -40,6 +41,18 @@
 
 #include "drm_dp_helper_internal.h"
 
+DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"DRM_UT_CORE",
+			"DRM_UT_DRIVER",
+			"DRM_UT_KMS",
+			"DRM_UT_PRIME",
+			"DRM_UT_ATOMIC",
+			"DRM_UT_VBL",
+			"DRM_UT_STATE",
+			"DRM_UT_LEASE",
+			"DRM_UT_DP",
+			"DRM_UT_DRMRES");
+
 struct dp_aux_backlight {
 	struct backlight_device *base;
 	struct drm_dp_aux *aux;
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 457448cc60f7..7d86020b5244 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -32,6 +32,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -50,6 +51,18 @@
 
 #include "drm_crtc_helper_internal.h"
 
+DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"DRM_UT_CORE",
+			"DRM_UT_DRIVER",
+			"DRM_UT_KMS",
+			"DRM_UT_PRIME",
+			"DRM_UT_ATOMIC",
+			"DRM_UT_VBL",
+			"DRM_UT_STATE",
+			"DRM_UT_LEASE",
+			"DRM_UT_DP",
+			"DRM_UT_DRMRES");
+
 /**
  * DOC: overview
  *
diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index f783d4963d4b..ec32df35a3e3 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned int __drm_debug;
+unsigned long __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -52,7 +52,30 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
 "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
-module_param_named(debug, __drm_debug, int, 0600);
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+module_param_named(debug, __drm_debug, ulong, 0600);
+#else
+/* classnames must match vals of enum drm_debug_category */
+DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"DRM_UT_CORE",
+			"DRM_UT_DRIVER",
+			"DRM_UT_KMS",
+			"DRM_UT_PRIME",
+			"DRM_UT_ATOMIC",
+			"DRM_UT_VBL",
+			"DRM_UT_STATE",
+			"DRM_UT_LEASE",
+			"DRM_UT_DP",
+			"DRM_UT_DRMRES");
+
+static struct ddebug_class_param drm_debug_bitmap = {
+	.bits = &__drm_debug,
+	.flags = "p",
+	.map = &drm_debug_classes,
+};
+module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
+#endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
 {
diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
index 6fc475a5db61..d1e4d528cb17 100644
--- a/drivers/gpu/drm/i915/i915_params.c
+++ b/drivers/gpu/drm/i915/i915_params.c
@@ -29,6 +29,18 @@
 #include "i915_params.h"
 #include "i915_drv.h"
 
+DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"DRM_UT_CORE",
+			"DRM_UT_DRIVER",
+			"DRM_UT_KMS",
+			"DRM_UT_PRIME",
+			"DRM_UT_ATOMIC",
+			"DRM_UT_VBL",
+			"DRM_UT_STATE",
+			"DRM_UT_LEASE",
+			"DRM_UT_DP",
+			"DRM_UT_DRMRES");
+
 #define i915_param_named(name, T, perm, desc) \
 	module_param_named(name, i915_modparams.name, T, perm); \
 	MODULE_PARM_DESC(name, desc)
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 561309d447e0..fd99ec0f4257 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/mmu_notifier.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_crtc_helper.h>
@@ -70,6 +71,18 @@
 #include "nouveau_svm.h"
 #include "nouveau_dmem.h"
 
+DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
+			"DRM_UT_CORE",
+			"DRM_UT_DRIVER",
+			"DRM_UT_KMS",
+			"DRM_UT_PRIME",
+			"DRM_UT_ATOMIC",
+			"DRM_UT_VBL",
+			"DRM_UT_STATE",
+			"DRM_UT_LEASE",
+			"DRM_UT_DP",
+			"DRM_UT_DRMRES");
+
 MODULE_PARM_DESC(config, "option string to pass to driver core");
 static char *nouveau_config;
 module_param_named(config, nouveau_config, charp, 0400);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index b3b470440e46..668273e36c2c 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -35,7 +35,7 @@
 #include <drm/drm.h>
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned int __drm_debug;
+extern unsigned long __drm_debug;
 
 /**
  * DOC: print
@@ -275,6 +275,7 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
  *
  */
 enum drm_debug_category {
+	/* These names must match those in DYNAMIC_DEBUG_CLASSBITS */
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
-- 
2.37.2

