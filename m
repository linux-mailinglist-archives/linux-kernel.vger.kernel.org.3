Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73466529480
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350158AbiEPW6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350007AbiEPW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B9642EC3;
        Mon, 16 May 2022 15:57:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e3so17604760ios.6;
        Mon, 16 May 2022 15:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0whoQsHeXptrD3TNBMDfcpTVQVx7yqX9gABSaE73ckE=;
        b=AjOW5QKHWAhuW8wlCA8uuv2ZQT1FNjJDoVWdRAg9V4oMd1YtwLUqQZVDxiv/rbW71G
         tDRTWR9Job2tMXwm4Qd8Ii/ebOOvCikKkxjmZrBLO7ISvABeNVw6gvCLoASZz5A5pXkO
         2bN2fkk04CX99rIuougRR1DDpjTLdlW3z+ihfirjoo2HTNidV3pvGzBWVYgh96HuwnW0
         UCf9qP6aDTPW1iDEu1RvSp4uR1BITAHIy69wuCgUtAna9woMD6giGXzerTkJfuxaz0uw
         XDXaoC2eMmQa4b1Be17Zhmfqngw3hKXPfmYkxXSju1ug26b57seHZvjLaJAjhjRR7K+E
         cBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0whoQsHeXptrD3TNBMDfcpTVQVx7yqX9gABSaE73ckE=;
        b=DMahzUMRxxGwAVfhpDtM86zKJCGcKQcQ3ElqCU5xsuSW1Loi1yQlDSpiC6FZDw+Vx5
         qe74U/cNaWHLIUeQOvDFey1CILi+YX6aAE6AUAm+XtQcrjIDj00CixjN3AaHCxkA930e
         YdUHSNhaaCutS7z6YHrrZgYbHql5peAzoI+yfFlWjD7WbQ711REruzp2592SmylgW93S
         0B96zPm5HTiBHAfceK7F2d9lhQKybtOnT+T6bWbI1IuHe6C7Km0xEEqGAiXKn6kBNcv+
         qVTZ7DrBZ85BFlAD5GskovyjD5lNB3G8dgzTaEgWmKRps6njQt45oTPB6UNlQH00uGoZ
         DJzQ==
X-Gm-Message-State: AOAM533i4l/YL9C/e4XsDDT9rFC5IqT9g861GNo/sTB2DrU59to0zkiT
        s0VRJ6pV/Aiy1yz5PGuhAuQ=
X-Google-Smtp-Source: ABdhPJxJyh+nGZnbHrXoqOEA6GXq4pUukckz/GPygz5+sl0Mlr8SK0ojc44qkJAMzCz0Rf5asl73WQ==
X-Received: by 2002:a05:6638:2416:b0:32d:be90:ecae with SMTP id z22-20020a056638241600b0032dbe90ecaemr10896364jat.156.1652741843354;
        Mon, 16 May 2022 15:57:23 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:22 -0700 (PDT)
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
Subject: [PATCH v2 18/27] drm_print: interpose drm_*dbg with forwarding macros
Date:   Mon, 16 May 2022 16:56:31 -0600
Message-Id: <20220516225640.3102269-19-jim.cromie@gmail.com>
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

change drm_dev_dbg & drm_dbg to macros, which forward to the renamed
functions (with __ prefix added).

Those functions sit below the categorized layer of macros implementing
the DRM debug.category API, and implement most of it.  These are good
places to insert dynamic-debug jump-label mechanics, which will allow
DRM to avoid the runtime cost of drm_debug_enabled().

no functional changes.

memory cost baseline: (unchanged)
bash-5.1# drms_load
[    9.220389] dyndbg:   1 debug prints in module drm
[    9.224426] ACPI: bus type drm_connector registered
[    9.302192] dyndbg:   2 debug prints in module ttm
[    9.305033] dyndbg:   8 debug prints in module video
[    9.627563] dyndbg: 127 debug prints in module i915
[    9.721505] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[   10.091345] dyndbg: 2196 debug prints in module amdgpu
[   10.106589] [drm] amdgpu kernel modesetting enabled.
[   10.107270] amdgpu: CRAT table not found
[   10.107926] amdgpu: Virtual CRAT table created for CPU
[   10.108398] amdgpu: Topology: Add CPU node
[   10.168507] dyndbg:   3 debug prints in module wmi
[   10.329587] dyndbg:   3 debug prints in module nouveau

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 10 +++++-----
 include/drm/drm_print.h     |  9 +++++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index e49ffda0a47e..e77b49c7725b 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -266,8 +266,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		 const char *format, ...)
+void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
+		   const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -288,9 +288,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 
 	va_end(args);
 }
-EXPORT_SYMBOL(drm_dev_dbg);
+EXPORT_SYMBOL(__drm_dev_dbg);
 
-void __drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -307,7 +307,7 @@ void __drm_dbg(enum drm_debug_category category, const char *format, ...)
 
 	va_end(args);
 }
-EXPORT_SYMBOL(__drm_dbg);
+EXPORT_SYMBOL(___drm_dbg);
 
 void __drm_err(const char *format, ...)
 {
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index a157485bf573..383feb0d34fe 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -339,7 +339,7 @@ __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...);
 __printf(3, 4)
-void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
+void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 		 const char *format, ...);
 
 /**
@@ -388,6 +388,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}								\
 })
 
+#define drm_dev_dbg(dev, cat, fmt, ...)				\
+	__drm_dev_dbg(dev, cat, fmt, ##__VA_ARGS__)
+
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
  *
@@ -489,10 +492,12 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
  */
 
 __printf(2, 3)
-void __drm_dbg(enum drm_debug_category category, const char *format, ...);
+void ___drm_dbg(enum drm_debug_category category, const char *format, ...);
 __printf(1, 2)
 void __drm_err(const char *format, ...);
 
+#define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+
 /* Macros to make printk easier */
 
 #define _DRM_PRINTK(once, level, fmt, ...)				\
-- 
2.35.3

