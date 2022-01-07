Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DE4872C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346461AbiAGFbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbiAGFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:04 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A3C061201;
        Thu,  6 Jan 2022 21:30:03 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x6so5757478iol.13;
        Thu, 06 Jan 2022 21:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agBSgkgkW/lOUa/a1e2VO231rW5BNQTBTfk7cJDbplk=;
        b=HAk3291JdByrBv+FlaCYSm7Og7Bv51IGb1/URK9sxt4hUoGrvKjKdIty96hALwR/56
         hez4koMRHtjeS7rnGaNo6hBBnYB7M2baJcHRYh7mUipsSy2UXAENXWDvUWyAzZhodemo
         G+KsjM6aTfXFF2lCIyhxEjxyPXjVGvrKg/SXNvf7Xy0QWtieoBRZC5kWZX1ycVJwwxVc
         pV+JJQgTPFZpraYMQMqfpixURgyaJfQ38P/IMQU9z13yeIVMizzfKazBnAdAvJDxGWze
         EBJ0fniTa40LiDCC2M3o4sbSaBLDCVSksKcXd3oU/6WKoHmfR58b4Pxc5t15V75MJu6S
         kXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agBSgkgkW/lOUa/a1e2VO231rW5BNQTBTfk7cJDbplk=;
        b=f5d1mDAND5uXQo5xUWGKc2RyAh4MB/0TOLHnoxa6PcFB5CVxE3PJ3HBDx7/dCUSOoD
         PUf3h2HdrdbMjKLzTGggBr5WVQWcs2n3z+1WzVT2GJZaEfhieJXEFUzpWbL2HzryKE4D
         QMYdb/02NF5OkKGjnmkrv5CdaW+BS7PxvYZ0bgUytiQ7advIUKf1LNWebBov9kUlroqe
         i6N10uDSE0UP7zk8JWMwfNIAdwbD8M3fhHd01U0vV7HMP5uoIFMBlB5I3ohYm/NU+Ws9
         dshOs4cu7eS8TyYFBRUq2kJeeyUex1XXnjaSzrVvP1gP4R9gzad3XAwck2d9DFGkMFQB
         RGcw==
X-Gm-Message-State: AOAM531bX1BusGzH+eRmbXXohRxzKNoIuYE1xFE3sz/tNT+vCLKJLxjl
        drPhwQQKM4FhURnH/p0HuxI=
X-Google-Smtp-Source: ABdhPJz5Pwl1TXvRhFAHC/C/RtcA8HwmVdUMjfOUZVBgrqnxSM4Fa/HYaYOvHoAIy1tgjh4vXNkRfA==
X-Received: by 2002:a05:6602:493:: with SMTP id y19mr29526904iov.126.1641533403267;
        Thu, 06 Jan 2022 21:30:03 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:02 -0800 (PST)
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
Subject: [PATCH v11 11/19] drm_print: wrap drm_dev_dbg in _dynamic_func_call_no_desc
Date:   Thu,  6 Jan 2022 22:29:34 -0700
Message-Id: <20220107052942.1349447-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make drm_dev_dbg() macro CONFIG_DRM_USE_DYNAMIC_DEBUG dependent:

 =N  direct forwarding: drm_dev_dbg -> __drm_dev_dbg()
 =Y  wrap __drm_dev_dbg in _dynamic_func_call_no_desc().

This adds the metadata which creates a /proc/dynamic_debug/control
entry for each callsite, and exposes it for selective enablement.

NB: include header in header so wrapper is available

proof of function:

bash-5.1# grep 'ring test' /proc/dynamic_debug/control
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:453 [amdgpu]amdgpu_ring_test_helper =xf "ring test on %s succeeded\012"

less
    452         else
    453                 DRM_DEV_DEBUG(adev->dev, "ring test on %s succeeded\n",
    454                               ring->name);
drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c lines 417-454/458 byte 12536/12575 100%  (press RETURN)

new prdbg callsite counts:
bash-5.1# drms_load
[   20.533990] dyndbg:   1 debug prints in module drm
[   20.535637] ACPI: bus type drm_connector registered
[   20.624951] dyndbg:   2 debug prints in module ttm
[   20.627853] dyndbg:   8 debug prints in module video
[   20.922442] dyndbg: 127 debug prints in module i915
[   20.984159] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[   21.310216] dyndbg: 2196 debug prints in module amdgpu
[   21.324537] [drm] amdgpu kernel modesetting enabled.
[   21.325092] amdgpu: CRAT table not found
[   21.325512] amdgpu: Virtual CRAT table created for CPU
[   21.326009] amdgpu: Topology: Add CPU node
[   21.401137] dyndbg:   3 debug prints in module wmi
[   21.532540] dyndbg:   3 debug prints in module nouveau

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index f8fa5af11310..1eef315a0a65 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -383,8 +383,14 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	}								\
 })
 
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
 #define drm_dev_dbg(dev, eCat, fmt, ...)				\
 	__drm_dev_dbg(dev, eCat, fmt, ##__VA_ARGS__)
+#else
+#define drm_dev_dbg(dev, eCat, fmt, ...)				\
+	_dynamic_func_call_no_desc(fmt, __drm_dev_dbg,			\
+				   dev, eCat, fmt, ##__VA_ARGS__)
+#endif
 
 /**
  * DRM_DEV_DEBUG() - Debug output for generic drm code
-- 
2.33.1

