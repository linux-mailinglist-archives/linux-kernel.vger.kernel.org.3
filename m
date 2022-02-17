Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E54B96FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiBQDtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:49:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiBQDtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:49:04 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5268C4E3B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:50 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id d7so1365111ilf.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+vGdwnLXxq+vC4sl8UqWBm6MtHqZ6WUpG5Xunn2VjE=;
        b=aWO7UUGoKdXAsOZ3ARe2QJZJsrpeOf90ACB+ee6E79imlC7MDWWeD+AJr3qahesHxu
         nJovj3uldI2xz69oSyxx+syBvSgbjfhTqygbS8A0KPRXtBpX0LMFKLZ6CB+56OaSzBqb
         hfTdtez1ED7QAtIvGY62HlNG2fIjyr7ow9Skk12dszA/e817Qatb3b1lQgFjQQZ0JiZj
         WWc36Ta/bs/CspzWamVlOMcvgjtO94zzf8D8v9NxDy0gmnlhRwmPysV4iMJOn928huyw
         /tizg//HbxArKb+EFHMAnLKG/J1xmrK4YIYMjh//d11ltRHZXwWiLDMFTkhaeV9fDWZs
         a1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+vGdwnLXxq+vC4sl8UqWBm6MtHqZ6WUpG5Xunn2VjE=;
        b=wMoPrVaF+kL6U11PCX0yUTDkPzm9mTM30Yhb1SInM6s2vp8NfT0E9nO980jGFKZ+hh
         EIstKMBtM1VykkK01Bhf5Y/DnU0/InExAnjce8YzRB5TQMMqBlqt3pAB2eEFWo9OrGnq
         E4rWLHLVf1L4HTa6fxQZd1C1dh0ZwPPlYzogWqnxIwz+aH2EHtVro6md3RMVsWvDeCcH
         mjBaDd70l4xOmEXU5PXGZB4CKR1Av4zWvi85lIIv0inqUmHKAM562NiT1Yt4/qJBrf9R
         fT629YJymG4GdwxzB0ezlv072/kRLEiNACzZkywYvn2VySov7j/sK8+BS+M2ELAPfvAC
         jDIg==
X-Gm-Message-State: AOAM530vuZhZnBGD4nRyMxJmR+03lEZny3y6xUlv0iYmQMwXxVCxfZPK
        5txSIyMFchxJdIr1EPlKUC4=
X-Google-Smtp-Source: ABdhPJz3VeOj8gAqU2/ZIke90ZJ3eMraSlFGZ9r9Aru1QvXJbSIWXwhnlF3/c5ShXmdBBtEfbc0lQA==
X-Received: by 2002:a05:6e02:1a41:b0:2be:6abe:103d with SMTP id u1-20020a056e021a4100b002be6abe103dmr765171ilv.204.1645069730202;
        Wed, 16 Feb 2022 19:48:50 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::1b19])
        by smtp.googlemail.com with ESMTPSA id l16sm1127874ilc.54.2022.02.16.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 19:48:49 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 09/13] drm_print: wrap drm_*_dbg in dyndbg jumplabel
Date:   Wed, 16 Feb 2022 20:48:25 -0700
Message-Id: <20220217034829.64395-10-jim.cromie@gmail.com>
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

For CONFIG_DRM_USE_DYNAMIC_DEBUG=y, wrap drm_dbg() & drm_dev_dbg() in
one of dyndbg's Factory macros: _dynamic_func_call_no_desc().
This makes the (~4000) callsites controllable, typically by class:

  # 0 is DRM_UT_CORE
  #> echo module drm class 0 +p > /proc/dynamic_debug/control

 =N: keeps direct forwarding: drm_*_dbg -> __drm_*_dbg()

I added the CONFIG_DRM_USE_DYNAMIC_DEBUG item because of the .data
footprint cost of per-callsite control; 56 bytes/site * ~2k,4k
callsites (for i915, amdgpu), which is significant enough that a user
might not want it.  Using CONFIG_DYNAMIC_DEBUG_CORE only eliminates
the builtin portion, leaving only drm modules, but still 200k of
module data is a lot.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig  | 12 ++++++++++++
 drivers/gpu/drm/Makefile |  2 ++
 include/drm/drm_print.h  | 12 ++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index b1f22e457fd0..ec14a1cd4449 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -63,6 +63,18 @@ config DRM_DEBUG_MM
 
 	  If in doubt, say "N".
 
+config DRM_USE_DYNAMIC_DEBUG
+	bool "use dynamic debug to implement drm.debug"
+	default y
+	depends on DRM
+	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
+	depends on JUMP_LABEL
+	help
+	  Use dynamic-debug to avoid drm_debug_enabled() runtime overheads.
+	  Due to callsite counts in DRM drivers (~4k in amdgpu) and 56
+	  bytes per callsite, the .data costs can be substantial, and
+	  are therefore configurable.
+
 config DRM_DEBUG_SELFTEST
 	tristate "kselftests for DRM"
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 301a44dc18e3..24e6410d6c0e 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
+CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+
 drm-y       :=	drm_aperture.o drm_auth.o drm_cache.o \
 		drm_file.o drm_gem.o drm_ioctl.o \
 		drm_drv.o \
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 4bed99326631..06f0ee06be1f 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -383,8 +383,14 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}								\
 })
 
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define drm_dev_dbg(dev, cat, fmt, ...)				\
 	__drm_dev_dbg(dev, cat, fmt, ##__VA_ARGS__)
+#else
+#define drm_dev_dbg(dev, cat, fmt, ...)				\
+	_dynamic_func_call_no_desc(fmt, __drm_dev_dbg,			\
+				   dev, cat, fmt, ##__VA_ARGS__)
+#endif
 
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
@@ -491,7 +497,13 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+#else
+#define __drm_dbg(cat, fmt, ...)					\
+	_dynamic_func_call_no_desc(fmt, ___drm_dbg,			\
+				   cat, fmt, ##__VA_ARGS__)
+#endif
 
 /* Macros to make printk easier */
 
-- 
2.35.1

