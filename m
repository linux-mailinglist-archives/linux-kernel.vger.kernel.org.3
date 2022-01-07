Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724AD4872B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbiAGFaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiAGFaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:03 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D329C06118A;
        Thu,  6 Jan 2022 21:30:02 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id s6so5907617ioj.0;
        Thu, 06 Jan 2022 21:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhZr/5fj4D2TZDy+BWecHE7NyGhS8joUKN+lZK3t0TY=;
        b=K1cqGUH7tn5pqvS315M3pFn/EFgcikByySyyak0mzM8JxMmudF/Sy8JlBB45ADlq0Q
         h3CiSMrawE2whBb2mbSZHfWmdYLREJEPfTxr2b57R9R9ti6BcFDmuwPnfc30I6vac+uo
         0jgJdiQfW3YX3b0jCY4Zedd3eZYKYcAy0/Ljpc7Ux/RDzjusBmBRulIh3mdm3kt/MeCh
         kgVrbYG5Wn+1Om+V/PAKYveiBwWwfF2yrt+J3KGHW7ZFrQVLbAs6kWOSTFyXYfFdf8S4
         rnKX3cl1t4lBkgUwrXL0UnyIa6OAOygh6uNnNmKUmP8c3hKPDPzTiShoBKW0tJ00tVf6
         fA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhZr/5fj4D2TZDy+BWecHE7NyGhS8joUKN+lZK3t0TY=;
        b=3vYZu50C22t19O5v1NMbxBOAaVWj2TVmihVshWlhZ4RS5xkVrz6GRReXdU5nXtchBM
         GF3Z8KuI5EMtky88hGspOoruFB+FnK7dtZCUYbYR6Gp4g6QkLZL+HWcpywpLNOZuEjUM
         /yBpwCQ2wmBpQsCyDdKJzIXxxGScS0CjTnmvD6J3TU2SCwdiJ1WDktT8OluHdDxX2zeL
         OGORmDPNrW9FL2mvSm7k2Grcy6DruEKEafUPlvE/hTiJZI6u/Ks+jO6Pf7BOVBGbMGdn
         SiRs7wUjod+x5pwdu50ehG3VQ4ybPJJmrUgUgjaWkWMYzpK7O/pnlVe5PtDakqgFUR17
         oZiQ==
X-Gm-Message-State: AOAM533YuYIsB43mP2d1+qMMRCBmhpUyg3Lmcn2NJw9wipvLBOQNdXuY
        Gy3KT6LUaebUKedWdJYtbmU=
X-Google-Smtp-Source: ABdhPJzl4z5cci7KuMClhyTbFxtElPWbEhb9xNZirTd547D1CieexOjnCBEvzsszS6inI5KOM8xk0A==
X-Received: by 2002:a05:6638:52e:: with SMTP id j14mr27122583jar.98.1641533402035;
        Thu, 06 Jan 2022 21:30:02 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:01 -0800 (PST)
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
Subject: [PATCH v11 10/19] drm_print: interpose drm_dev_dbg, __drm_dbg with forwarding macros
Date:   Thu,  6 Jan 2022 22:29:33 -0700
Message-Id: <20220107052942.1349447-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dev_dbg() & _drm_dbg() sit below the categorized layer of the DRM
debug API, and thus implement most of it.  These are good places to
insert dynamic-debug jump-label mechanics, allowing DRM to avoid the
runtime cost of drm_debug_enabled().

Set up for this by changing the func names by adding '__' prefixes,
and define forwarding macros to the new names.

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
index cfcb89ffd89d..5dd6713c14f2 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -259,8 +259,8 @@ void drm_dev_printk(const struct device *dev, const char *level,
 }
 EXPORT_SYMBOL(drm_dev_printk);
 
-void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
-		 const char *format, ...)
+void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
+		   const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -283,9 +283,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}
 	va_end(args);
 }
-EXPORT_SYMBOL(drm_dev_dbg);
+EXPORT_SYMBOL(__drm_dev_dbg);
 
-void __drm_dbg(enum drm_debug_category category, const char *format, ...)
+void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -304,7 +304,7 @@ void __drm_dbg(enum drm_debug_category category, const char *format, ...)
 
 	va_end(args);
 }
-EXPORT_SYMBOL(__drm_dbg);
+EXPORT_SYMBOL(___drm_dbg);
 
 void __drm_err(const char *format, ...)
 {
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index b4355bfd7888..f8fa5af11310 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -334,7 +334,7 @@ __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
 		    const char *format, ...);
 __printf(3, 4)
-void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
+void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 		 const char *format, ...);
 
 /**
@@ -383,6 +383,9 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}								\
 })
 
+#define drm_dev_dbg(dev, eCat, fmt, ...)				\
+	__drm_dev_dbg(dev, eCat, fmt, ##__VA_ARGS__)
+
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
  *
@@ -484,10 +487,12 @@ void drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
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
2.33.1

