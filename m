Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24814B9715
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiBQDth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiBQDtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:17 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4ECC0506
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:54 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id c14so1374976ilm.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Al57ZNKX5lnblKHtWXH/Bsh3z6Q/ha1M5NnWcexkJRI=;
        b=V0r7t+t0Kk8YqhDL5yttmCVdcakOAJfOvunaP5rUIXFehX50brE0txV/ZP/yfOIiJ0
         OZOMuTviWiLPhKj6tYIt+g1vii30xz4wooVCZaC1Sf0se7ci4nGLIYuNE2MHe+fqWJv6
         SUd9Gn7k9KBrlbJ51tAD6K8Rn9LOerLRVIIlqlxyQOioGqU8chuma2FAB0o2HF0mpXOs
         EabrXT7RY8/P2i99gy5Ft3xcRe1gpyfpDE9jfckgpO9vjSLMN83CqB2PQRC6rwXFly/M
         +lEeEu1AtjaTnaxUJFl7Ucop5hD5N/MkNhLu+FTKEb6ZI/OBs3rZe9v4rgSYKctmBxgf
         FeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Al57ZNKX5lnblKHtWXH/Bsh3z6Q/ha1M5NnWcexkJRI=;
        b=A0xgUwUQ3j7bpUlYYz5C5oa3eenNVFlEG6BG0XywW3kqWDrdEAD8/Vbl4A5zMwEno0
         ajc0Yh0nhJZIgKW++fzCd/L7CQylHxZ7ErxZeCXK0TjttFLpxj7w2cq6ioIBrFFTr62f
         CEWjN0FyxnE3iczk2C7XEPJCW80g1t6oh/qCJogOZzqaKvOomoxKDd3sWLJ+BDv3174J
         za5TS0o5/+PynZH4Jcx3eT7UhWHF3PZQPmLZSGiqxhpZ2zNAuAJ4bJiabyuL6j3TH7Sh
         JrCBvGcYYFFRqL06eT8qyZ7BJnB5QKVoj3E/Q7+tBq7t6T+LUpW4lopG1+79CrjWUF+l
         //Dg==
X-Gm-Message-State: AOAM532XDpSUFfJo4bwllqt57PONjrIA6xcP7GQvMSZUeRFu/INDUWOZ
        ksQ2pZjJX/BnJU6C08gGcVU=
X-Google-Smtp-Source: ABdhPJwpadjkqlwkn/peOpycjU/cPxWs8v84Mc4rTvbPvVHvXR0owgAgjr32VA6mTQgW+Q005SRNiQ==
X-Received: by 2002:a92:d242:0:b0:2b9:a33b:9068 with SMTP id v2-20020a92d242000000b002b9a33b9068mr786669ilg.144.1645069733685;
        Wed, 16 Feb 2022 19:48:53 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:53 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 13/13] drm_print: use DEFINE_DYNAMIC_DEBUG_CLASSBITS for drm.debug
Date:   Wed, 16 Feb 2022 20:48:29 -0700
Message-Id: <20220217034829.64395-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217034829.64395-1-jim.cromie@gmail.com>
References: <20220217034829.64395-1-jim.cromie@gmail.com>
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
it then toggles those flags along with the "p".  This would undo any
customizations a user added once the sysfs-knob is used.  Still, there
may be cases/reasons.

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

