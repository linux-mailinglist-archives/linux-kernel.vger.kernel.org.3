Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6B4872BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346339AbiAGFaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346223AbiAGFaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:09 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CF8C061201;
        Thu,  6 Jan 2022 21:30:08 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q5so5820647ioj.7;
        Thu, 06 Jan 2022 21:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JbeTRv2Fyfg8UJiPWSnBwDsjkhtsGcD/brFxy1OI2So=;
        b=VK9Dj9vp/R6vihhAELn97CTPOQgU/Fn1YhQ4WuPOYiEBxoo0M5cBeUusxl5g7Ha4Ks
         WrSXQpzI9UTEbJuljMm74kc+SOYx4WA60VHSaWlMnqZLGSpzXGYHb5CjApMc8ayRHXdb
         WVxj63BzSSHT1ezgUPu83Zo54NGeKs9Zr8fg9VJ5Cce/XGIJIhdo3KaIQVI41J2/2Lf+
         ih/u+bokNAuNDPcsOTLlcmCFeGVo1AadQJrR31RrPEgAU2ShgFfYB6nhOEK8TtKNUXzi
         6mTbi2qAxMgfIuE5P3OOX5a39/63S/9+7gqCBnDd1OoaXvruf1pURBiPx2C3jbSLyZ5B
         2b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbeTRv2Fyfg8UJiPWSnBwDsjkhtsGcD/brFxy1OI2So=;
        b=Wc2dLcYtoa9tGQtdFoXG6g0wEx8ZP/DMbcoO+ihLgMfQRpG6v4sawpZG48SYDwGwrt
         7rzqmw5/+9yb4L79vTGSYiCO+hH5u7DQtL5srTXbd9zjoBVQm8XjmVleNcfqo1ga0gcT
         XiBJn5SKUaIaLWVrN9FyrSiMOTOQCVvwKB2snd7vVyc4U81u0vPU4HIY7GksNQGnh2ZS
         IrgUwn0EgxvqPCzvIinVeKzIutSWh0TVE1Sgc8hjNj+D7QfhUu1rHBcOhRhIDih7WHgO
         LKZW3vEDBf9Rv/kfayGz+wC07UpVVFs1URHQ/yrHTJo2xdaUYluU5xz5zMAaVuGev6Er
         Xy8g==
X-Gm-Message-State: AOAM532DBtoqPVK6PXnYVhRqdyI3LX2Tec0lE8SIAoCDGp8UbWlMQ07K
        IaRHBZNf++jXtKqPIGawJxU=
X-Google-Smtp-Source: ABdhPJyyRxeOryfv21hSwrmrhXKwCfWI/bo+N4N54ntb26BYYZ7XqFH1lAI3RsHnWdKPEMsyhDvqMQ==
X-Received: by 2002:a02:b603:: with SMTP id h3mr30604302jam.233.1641533408224;
        Thu, 06 Jan 2022 21:30:08 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:07 -0800 (PST)
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
Subject: [PATCH v11 15/19] drm_print: use _dynamic_func_call_no_desc_cls
Date:   Thu,  6 Jan 2022 22:29:38 -0700
Message-Id: <20220107052942.1349447-16-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrade the current use of _dynamic_func_call_no_desc(), adding the
suffix and the category arg.  The arg has been available via the
macros implementing the drm.debug api, but dyndbg lacked a simple way
to represent it and use it until recently.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 8d6b74270c50..0c704610c770 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
+#include <linux/dynamic_debug.h>
 
 #include <drm/drm.h>
 
@@ -414,8 +415,8 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	__drm_dev_dbg(dev, eCat, fmt, ##__VA_ARGS__)
 #else
 #define drm_dev_dbg(dev, eCat, fmt, ...)				\
-	_dynamic_func_call_no_desc(fmt, __drm_dev_dbg,			\
-				   dev, eCat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_no_desc_cls(fmt, eCat, __drm_dev_dbg,	\
+				       dev, eCat, fmt, ##__VA_ARGS__)
 #endif
 
 /**
@@ -524,11 +525,11 @@ __printf(1, 2)
 void __drm_err(const char *format, ...);
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-#define __drm_dbg(fmt, ...)		___drm_dbg(fmt, ##__VA_ARGS__)
+#define __drm_dbg(fmt, ...)		___drm_dbg(NULL, fmt, ##__VA_ARGS__)
 #else
 #define __drm_dbg(eCat, fmt, ...)					\
-	_dynamic_func_call_no_desc(fmt, ___drm_dbg,			\
-				   eCat, fmt, ##__VA_ARGS__)
+	_dynamic_func_call_no_desc_cls(fmt, eCat, ___drm_dbg,		\
+				       eCat, fmt, ##__VA_ARGS__)
 #endif
 
 /* Macros to make printk easier */
-- 
2.33.1

