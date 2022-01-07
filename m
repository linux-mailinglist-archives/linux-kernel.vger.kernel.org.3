Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0194F4872BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiAGFak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346227AbiAGFaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:14 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B772DC061245;
        Thu,  6 Jan 2022 21:30:13 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q5so5820814ioj.7;
        Thu, 06 Jan 2022 21:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQJWjrpvTcrk4L61/TAk/KIkMk45wkVxi65EcBB2wtY=;
        b=d2IudHU+bG8/bgad7PeXNNcoFRsOkHVCShVHm/vs56LEwWSHNLuOiFpEy9DKP9l6Tr
         NRBxvirumd6cXxSnkNLyfQ8A+72NlcNsvL7hvZj4qmTJqiiF7Csdbvt56vxPZKgm+KVa
         LrSlrBhRhlCqqGdxdNHqwGpDCyTnA+YPYbfsQ7G96lw32cSPWQqyRz6ZiwfsJR6RI6by
         O/u4dN98TOOAoUCbAY7mPaIye9Ia4ZItYtBJMihh1+Ydm/s5SHgsKj5zmzh/47Sa491b
         AMMv+xW6DkrMNDF0c1KBxG7IMcy/cHwsIMDRlFUpK5z1bz9+nVuZCJuiiCAmG8ZEJ5nx
         Qodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQJWjrpvTcrk4L61/TAk/KIkMk45wkVxi65EcBB2wtY=;
        b=niy51DWjezcZgjqN9F3M+8tYIfD7rzSTrOLGEhmvJk2EtZ8RuLsMadJHrWAWmm4CDp
         np1P3TcWizh+ewQctLpYBY+xeOnqDJDGsCv/T+xUBhYehuuhRhwLkej3cgK89ZXk+QmM
         0cZyfeBGCB1Nv8rzs+wQZRM9zg7gDpRnvsHQtzeOBDrrh0f80ZvpRin4/s0Ua68ht8lr
         9W902dI/MGm78YeGGyfW6U5B5EeCCAhS09oGWbJUUYweQdROZ7BodG8Hmo//0dgb1uwR
         uehAuovumuXSzfeGL2j+TASPIT6cOo+O6AOnR47HA8hrtZ6pDBYhQCQwNZ+F7TvZeoxY
         FuRA==
X-Gm-Message-State: AOAM530M4kQZd/tqvx1ypzadrhOVuQFsGScCZkTSCLArNI2sRuNouGy2
        5+zprnaD4rYnjRW5y0zXGDA=
X-Google-Smtp-Source: ABdhPJyGlqD7G+Do4+iTOVF8S6gJU+ENiyjS7KIHnyFyCqamp+AFbBw5NgCHK7Jn+6e1D4PE8CKoHg==
X-Received: by 2002:a05:6602:2218:: with SMTP id n24mr29175293ion.182.1641533413048;
        Thu, 06 Jan 2022 21:30:13 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:12 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v11 19/19] drm_print: use DEFINE_DYNAMIC_DEBUG_CLASSBITS for drm.debug
Date:   Thu,  6 Jan 2022 22:29:42 -0700
Message-Id: <20220107052942.1349447-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if CONFIG_DRM_USE_DYNDBG=y, use new macro to create the sysfs bitmap
to control drm.debug callsites.

DEFINE_DYNAMIC_DEBUG_CLASSBITS( debug, __drm_debug,
	"drm.debug - control summary",
	/* inline vector of dyndbg.class_id (uint:4, 0 is reserved) */
	DRM_UT_CORE,
	DRM_UT_DRIVER,
	DRM_UT_KMS,
	DRM_UT_PRIME,
	DRM_UT_ATOMIC,
	DRM_UT_VBL,
	DRM_UT_STATE,
	DRM_UT_LEASE,
	DRM_UT_DP,
	DRM_UT_DRMRES );

NOTES:

dyndbg.class_id is uint:4, values 1-15 are valid. 0 is reserved
primarily for non-classified callsites (aka: prdbgs), and is thus
available to mark the end of the vector (and is added by the macro).

RFC: how to fold this in, with multiple macro expansion ?
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 20 ++++++++++++++++++--
 include/drm/drm_print.h     |  2 +-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 0a15a4ec5ead..0de562e5306a 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -41,7 +41,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned int __drm_debug;
+unsigned long __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -53,7 +53,23 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
 "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
-module_param_named(debug, __drm_debug, int, 0600);
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+module_param_named(debug, __drm_debug, ulong, 0600);
+#else
+DEFINE_DYNAMIC_DEBUG_CLASSBITS(debug, __drm_debug,
+	"enable drm.debug categories - 1 bit per category",
+	DRM_UT_CORE,
+	DRM_UT_DRIVER,
+	DRM_UT_KMS,
+	DRM_UT_PRIME,
+	DRM_UT_ATOMIC,
+	DRM_UT_VBL,
+	DRM_UT_STATE,
+	DRM_UT_LEASE,
+	DRM_UT_DP,
+	DRM_UT_DRMRES);
+#endif
 
 void __drm_puts_coredump(struct drm_printer *p, const char *str)
 {
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 6d43b81a0ee4..ebed5ba2dc24 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -36,7 +36,7 @@
 #include <drm/drm.h>
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned int __drm_debug;
+extern unsigned long __drm_debug;
 
 /**
  * DOC: print
-- 
2.33.1

