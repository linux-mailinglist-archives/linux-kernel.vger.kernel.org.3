Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E8529487
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbiEPW6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349922AbiEPW51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:27 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E04616E;
        Mon, 16 May 2022 15:57:19 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f4so17616874iov.2;
        Mon, 16 May 2022 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfS8WUqxRbYLHzWszspkTXnIl4N1CgLbVdRhg+W+v5Q=;
        b=JSGyNtm+oykZkHkIegb7uQ2SxKJPwMiwzdUaWO7Y68laVB1orKGZ22JvbSz51Iww/h
         gPNYoIjd9ufV70PTbI2TafWd8gA/m0eqDbLqH34XEEl0cl2U/pYsxQ542O+e9l8Ara4a
         GX/AhbnmxBIvZveJmefUpwmlks8127t2Y1LSPOYd+/bMRI9FqwfNyklwDWGRNGFzpjSZ
         tJKQYBLwQuOhZpYBr3J2GdSAiIbq9zJBea0YLp2Cz7tAo/s9ySOH34KryQQjD/FlcD+1
         3y2laHAjc9g8moUIhK5R9MdVXcT7VMZOwplQccCjN80c0qW8VyM3SvZK5mFo8uHsY//K
         eBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfS8WUqxRbYLHzWszspkTXnIl4N1CgLbVdRhg+W+v5Q=;
        b=VZZaN0EfwlW3/rJiYWlelirsLaYSYYIHNXLZ5bTw0VmWwUxzlZx1Pgju548F2o+EXB
         bD8m0qwNP8RpiZnB62N56UkKTVAPRUrkq7R5lBhBDcwENHbJOO4Ju0FBoLggNQuV/b6F
         Sw+Iyc4sgGsBzDD1/F4l0LyEBrmZM4u+PhMLz9jRH+j2SN6XMHTcr9RJnFhWKgvrU9Wy
         WxkKRYDS6InS24hRUIBmGMouX9JyrGDJmqditdGQOjO0ed5DQWDkSf9mnZSkb5dp5swD
         AR9gKK4YVEWbJMpAWQ6BKWr4q7v8TXFvqSXS0wc0Xzv8PG0Miin7pI1rU+bV61UWZ8iS
         T3mQ==
X-Gm-Message-State: AOAM532pnHip7jGbCZiUvMZSV2MQtRA+uB8JYJnAaGSIEndzhGx/XZ6n
        R3DgUTwJD5Pb0drcR2qfO0g=
X-Google-Smtp-Source: ABdhPJwAlu9u50ELwUlPAYiYw2vARy3pg1Ca3hYkCtMjkUDC6LJazLHQKGeJOm7jyHLQVeZGT4le8g==
X-Received: by 2002:a05:6638:516:b0:32e:26e7:30b3 with SMTP id i22-20020a056638051600b0032e26e730b3mr4987356jar.287.1652741839166;
        Mon, 16 May 2022 15:57:19 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:18 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v2 15/27] drm: POC drm on dyndbg - map class-names to drm_debug_category's
Date:   Mon, 16 May 2022 16:56:28 -0600
Message-Id: <20220516225640.3102269-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

Invoke DYNAMIC_DEBUG_CLASSES from drm_drv.h.  This declares a
maybe-unused struct ddebug_known_classes_map var, initialized with:

. var: passed to dynamic_debug_register_classes()
. class-names: "DRM_UT_CORE", "DRM_UT_DRIVER", "DRM_UT_KMS", etc.
  These names map to .class_id's by their index, ie: 0-30.

Then in 4 test-case drm-drivers (drm, i915, amdgpu, nouveau); call
dynamic_debug_register_classes(var).  i915 also gets an adaptor func,
and calls it 1st in the array of initialization helpers, since early
logging might be valuable for diagnosing setup problems.

Since these modules all use the same class-names, they all will
respond together to class FOO changes:

  #> echo class DRM_UT_KMS +p > /proc/dynamic_debug/control

NOTES:

DRM uses enum drm_debug_category across modules and common core, so
our class-names => index map must apply across them too, hence
drm_drv.h invokes the macro once for everyone.

DRM's enum drm_debug_category values need to sync with the index of
their respective class-names here.  Then .class_id == category, and
dyndbg's class FOO mechanisms will work.  Once enum drm_debug_category
is naturalized (value inits dropped, yielding 0..N), then this
condition holds true:

     assert(!strcmp(classes[DRM_UT_KMS],"DRM_UT_KMS"));

Though DRM needs consistent categories across all modules, thats not
generally needed; modules X and Y could define FOO differently (ie
different corresponding .class_id) and things would work.

No callsites are actually selected here, since none are class'd yet.

bash-5.1# dmesg | grep register_class
[    7.095579] dyndbg: register_classes: drm
[    7.557109] dyndbg: register_classes: i915
[    8.096818] dyndbg: register_classes: amdgpu

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +++
 drivers/gpu/drm/drm_drv.c               |  2 ++
 drivers/gpu/drm/i915/i915_module.c      | 11 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  4 ++++
 include/drm/drm_drv.h                   | 14 ++++++++++++++
 include/drm/drm_print.h                 |  4 ++++
 6 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7fd0277b2805..addb991b4663 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2765,6 +2765,8 @@ static int __init amdgpu_init(void)
 	if (r)
 		goto error_fence;
 
+	dynamic_debug_register_classes(&drm_debug_classes);
+
 	DRM_INFO("amdgpu kernel modesetting enabled.\n");
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
@@ -2787,6 +2789,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_amdkfd_fini();
 	pci_unregister_driver(&amdgpu_kms_pci_driver);
 	amdgpu_unregister_atpx_handler();
+	dynamic_debug_unregister_classes(&drm_debug_classes);
 	amdgpu_sync_fini();
 	amdgpu_fence_slab_fini();
 	mmu_notifier_synchronize();
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 8214a0b1ab7f..16683fb169aa 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -1045,6 +1045,8 @@ static int __init drm_core_init(void)
 {
 	int ret;
 
+	dynamic_debug_register_classes(&drm_debug_classes);
+
 	drm_connector_ida_init();
 	idr_init(&drm_minors_idr);
 	drm_memcpy_init_early();
diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
index 65acd7bf75d0..31f00f973866 100644
--- a/drivers/gpu/drm/i915/i915_module.c
+++ b/drivers/gpu/drm/i915/i915_module.c
@@ -44,10 +44,21 @@ static int i915_check_nomodeset(void)
 	return 0;
 }
 
+static int i915_ddebug_classes_register(void)
+{
+	return dynamic_debug_register_classes(&drm_debug_classes);
+}
+static void i915_ddebug_classes_unregister(void)
+{
+	dynamic_debug_unregister_classes(&drm_debug_classes);
+}
+
 static const struct {
    int (*init)(void);
    void (*exit)(void);
 } init_funcs[] = {
+	{ .init = i915_ddebug_classes_register,
+	  .exit = i915_ddebug_classes_unregister },
 	{ .init = i915_check_nomodeset },
 	{ .init = i915_active_module_init,
 	  .exit = i915_active_module_exit },
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 561309d447e0..9a780b6d4796 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1355,6 +1355,8 @@ nouveau_drm_init(void)
 	driver_pci = driver_stub;
 	driver_platform = driver_stub;
 
+	dynamic_debug_register_classes(&drm_debug_classes);
+
 	nouveau_display_options();
 
 	if (nouveau_modeset == -1) {
@@ -1391,6 +1393,8 @@ nouveau_drm_exit(void)
 	nouveau_backlight_dtor();
 	nouveau_unregister_dsm_handler();
 
+	dynamic_debug_unregister_classes(&drm_debug_classes);
+
 #ifdef CONFIG_NOUVEAU_PLATFORM_DRIVER
 	platform_driver_unregister(&nouveau_platform_driver);
 #endif
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb8856..c2ffe12161b8 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -29,6 +29,7 @@
 
 #include <linux/list.h>
 #include <linux/irqreturn.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm_device.h>
 
@@ -43,6 +44,19 @@ struct drm_mode_create_dumb;
 struct drm_printer;
 struct sg_table;
 
+/* these must comport with enum drm_debug_category values */
+DYNAMIC_DEBUG_CLASSES(drm_debug_classes, "*", 0,
+		      "DRM_UT_CORE",
+		      "DRM_UT_DRIVER",
+		      "DRM_UT_KMS",
+		      "DRM_UT_PRIME",
+		      "DRM_UT_ATOMIC",
+		      "DRM_UT_VBL",
+		      "DRM_UT_STATE",
+		      "DRM_UT_LEASE",
+		      "DRM_UT_DP",
+		      "DRM_UT_DRMRES");
+
 /**
  * enum drm_driver_feature - feature flags
  *
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 22fabdeed297..5b7eedb0f477 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -274,6 +274,10 @@ static inline struct drm_printer drm_err_printer(const char *prefix)
  *   # echo 0xf > /sys/module/drm/parameters/debug
  *
  */
+/*
+ * These must be kept in sync with the class-names given in drm_drv.h
+ * DYNAMIC_DEBUG_CLASSES
+ */
 enum drm_debug_category {
 	/**
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
-- 
2.35.3

