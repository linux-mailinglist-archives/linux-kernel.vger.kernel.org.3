Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942C4C90D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiCAQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbiCAQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:47 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A159427CD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:47:00 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q4so13053836ilt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EdO1ZIStJEydDaNsVVTQjhQ+J41BBA4J8A/jLwHByaA=;
        b=dT5dHERfA7NfWxTqoX5UtBav5p4kPFdv7+9TmqWHP2bK+wtMIESMJrFmYKma5Icf0g
         +7nH1hhjR4WQRsb9PMzzil9FEypu4su5C84YyCt6kDqnr1M6NLcZDGU/SwMSpwj2DFos
         2vfYqxcM6kV8dFiT0U/ekaSAV9UJ41JUIN8voJPJ/Th/mun4QzZUEITNp47YhjnH1sGf
         RHg66r1G4QkiH7zmyGmQD42lVmIsQf3Kekrsvrnm5ksV+v6PLwvKvC/5CNI7DJQjGb1P
         L89SbkL5rK2xjVuAKdrnLoDaf54r35tPdpRGmlTIY1LYozgr3fHBjpLQLrcKRj0+9wPd
         JzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EdO1ZIStJEydDaNsVVTQjhQ+J41BBA4J8A/jLwHByaA=;
        b=YvVKmni7GXcn8PzUt2VHFMqJLCBuiD2ewvDEHLZz0utM6ZbqwBJpeGufaYNLAT0Hgv
         7xn+NJshx5HOaiCIKRsF2xvK6EyOZJudW4PB3diQUzCscmwEl+zSuTxZNm+Kg9FbnGDn
         Ub7P0eG40hc6pqQN7hOGY51OWQ0HDoDBf7b43wIXdLkN74gNNhwDCKUidZvuIIE1Qi7g
         8ztCOQdlEmp2IdTm6fkY3yiFgC/khuQxGykva63By4z0PBa3WOOujbbaMQULeD6cx8mV
         91mu1jS1PB8+oCg6UYncLR5RrYbyEgjL4vdQSAwPSCFnJyD3ht4buuDNseglgkfTWWAL
         kZmQ==
X-Gm-Message-State: AOAM532yp/5Qslvyc5jCXQDOE3qDIHcIn/QtKd7Xar0tOs5CJXfydYnH
        bk/pRGOqqDKQobh8/TGCjHg=
X-Google-Smtp-Source: ABdhPJy5GYUXGxdbJtTLoRtjbRmr21Q8zu5mMzrgQM87ZqsoqtWRy3CiT7iy1mU5TW1fmPqVkcyi4A==
X-Received: by 2002:a05:6e02:1be9:b0:2c2:85a8:50cc with SMTP id y9-20020a056e021be900b002c285a850ccmr24316094ilv.131.1646153219788;
        Tue, 01 Mar 2022 08:46:59 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:59 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 13/13] drm_print: use DEFINE_DYNAMIC_DEBUG_CLASSBITS for drm.debug
Date:   Tue,  1 Mar 2022 09:46:29 -0700
Message-Id: <20220301164629.3814634-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301164629.3814634-1-jim.cromie@gmail.com>
References: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

if CONFIG_DRM_USE_DYNAMIC_DEBUG=y, use new macro to create the sysfs
bitmap to control drm.debug callsites.

DEFINE_DYNAMIC_DEBUG_CLASSBITS( debug, __drm_debug, "p",
	"drm.debug - control summary",
	/* inline vector of _ddebug.class_id's to be controlled, max 14 vals */
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

The @_flgs used here is "p", so this bitmap enables input to syslog
only, matching legacy behavior.

Also, no "fmlt" decorator flags are used here; that is discouraged, as
it then toggles those flags along with the "p".  This would overwrite
any customizations a user added since the sysfs-knob was last used.
Still, there may be cases/reasons.

_ddebug.class_id is uint:4, values 0-14 are valid. 15 is reserved for
non-classified callsites (regular pr_debugs).  Using it terminates the
scan, don't use it halfway through your list.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 20 ++++++++++++++++++--
 include/drm/drm_print.h     |  4 ++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index c9b2a2ab0d3d..d916daa384e5 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -38,7 +38,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned int __drm_debug;
+unsigned long __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -50,7 +50,23 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
 "\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
-module_param_named(debug, __drm_debug, int, 0600);
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+module_param_named(debug, __drm_debug, ulong, 0600);
+#else
+DEFINE_DYNAMIC_DEBUG_CLASSBITS(debug, __drm_debug, "p",
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
index 13d52b60f388..419140bf992d 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -36,7 +36,7 @@
 #include <drm/drm.h>
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned int __drm_debug;
+extern unsigned long __drm_debug;
 
 /**
  * DOC: print
@@ -527,7 +527,7 @@ __printf(1, 2)
 void __drm_err(const char *format, ...);
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-#define __drm_dbg(fmt, ...)		___drm_dbg(NULL, fmt, ##__VA_ARGS__)
+#define __drm_dbg(cat, fmt, ...)	___drm_dbg(NULL, cat, fmt, ##__VA_ARGS__)
 #else
 #define __drm_dbg(cat, fmt, ...)					\
 	_dynamic_func_call_cls(cat, fmt, ___drm_dbg,			\
-- 
2.35.1

