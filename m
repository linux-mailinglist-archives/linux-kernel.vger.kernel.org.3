Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC74872B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346300AbiAGFaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346178AbiAGFaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:01 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B979C0611FF;
        Thu,  6 Jan 2022 21:30:01 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q5so5820401ioj.7;
        Thu, 06 Jan 2022 21:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8b7+tL+cd3XDbB0bbZH5A7VjNPtmy29zZLwMyQWQkLE=;
        b=o9vQsJKvZk6S9XjC7kUDkR8bIThbqDoiVc/MFm8MmQEHbsaeMN/xcxudj9lZNEuDS2
         eOakFvpgoWPfS98WTCBb2Mvx9Nd7zJfazbjcYzwDfvPeCikaTCIcVsHEM/f0dtg7U+r5
         Mxy5tmew79fxiPkP+utkESzS6eBvJq/vl8vrgG6RKL49FeNdfg9Uva65T5kqWbmsT2RL
         UNvpE5oQgPEiKC/MA3wbsVtVNo5OeD9NWOGOgTt9of7BCQXgfnFaX08notkcyK4K3Xu8
         NtgSn1MKeOW/hoNhyX+Rea60/xVtgItY1ByjzQXK8XrypaQ7LIDuzuSragynGLAcq/Aa
         S+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8b7+tL+cd3XDbB0bbZH5A7VjNPtmy29zZLwMyQWQkLE=;
        b=jLYFEYgeQpn7ra43xycBszBjrlxMpahtQTWzgNaFioSs90ZbEvIu1x0u8IYl5vyIdq
         dGFJ9hdz3YPm7I3oNRRBI+dF/UU/nAJ4iKI57mQYFjGbc51KVh8nnbdLrxkBul533SCG
         +CbWLTq5Xt/X9Mvq2m54Zr/SztGbSvPxBAR16kSfxpMSq5k3QCwrrO+UQfBtNAMz2QKe
         +iilExe0kTFd6r9bGyakQJY8tTr0KRe2zL0onI3fc1zNy69yMQuA+WABLyQnOUSQ/zH7
         JBI5kNpqrsPdgnpzKwASBxM4GX1ZDi1zMCTl22ubOA2VsCLmyjIwAxsDr0FVLeDZumbZ
         Ucxw==
X-Gm-Message-State: AOAM532ocT83P3MQNmgeY3Xn5xWMiIJehpFkVVGXCIOjOmulNR+pGSHJ
        +7tKl8AbnN1hCPo628nz84xs+gZLPgo=
X-Google-Smtp-Source: ABdhPJwNprmy0e1y9wsTmFZ4pycxzUQNGEbLySOh1tCB6yThFteXTFSOZg2I004I2+XHF7Nzrqyh6A==
X-Received: by 2002:a6b:f70e:: with SMTP id k14mr29152347iog.173.1641533400783;
        Thu, 06 Jan 2022 21:30:00 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:00 -0800 (PST)
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
Subject: [PATCH v11 09/19] drm_print: add CONFIG_DRM_USE_DYNAMIC_DEBUG
Date:   Thu,  6 Jan 2022 22:29:32 -0700
Message-Id: <20220107052942.1349447-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DRM.debug API is used thousands of times in drivers/gpu/drm/*; when
these are implemented using dynamic-debug, DYNAMIC_DEBUG_METADATA adds
a struct _ddebug (56 bytes) per site.

Since i915 will have ~2k callsites, and amdgpu ~4k, the memory costs
are substantial, and thus made configurable.

For a baseline:
bash-5.1# drms_load
[   10.923093] dyndbg:   1 debug prints in module drm
[   10.928345] ACPI: bus type drm_connector registered
[   11.034012] dyndbg:   2 debug prints in module ttm
[   11.038188] dyndbg:   8 debug prints in module video
[   11.551064] dyndbg: 127 debug prints in module i915
[   11.617106] AMD-Vi: AMD IOMMUv2 functionality not available on this system - This is not a bug.
[   12.084856] dyndbg: 2196 debug prints in module amdgpu
[   12.099040] [drm] amdgpu kernel modesetting enabled.
[   12.099790] amdgpu: CRAT table not found
[   12.100523] amdgpu: Virtual CRAT table created for CPU
[   12.100901] amdgpu: Topology: Add CPU node
[   12.165382] dyndbg:   3 debug prints in module wmi
[   12.356424] dyndbg:   3 debug prints in module nouveau

i915/gvt has pr_debugs that show up here
amdgpu has many pr_debugs from macro expansions

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

fixup-mk
---
 drivers/gpu/drm/Kconfig  | 12 ++++++++++++
 drivers/gpu/drm/Makefile |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 0039df26854b..4e7b865c3441 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -62,6 +62,18 @@ config DRM_DEBUG_MM
 
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
index 0dff40bb863c..60f4d7bc27eb 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,6 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
+CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+
 drm-y       :=	drm_aperture.o drm_auth.o drm_cache.o \
 		drm_file.o drm_gem.o drm_ioctl.o drm_irq.o \
 		drm_drv.o \
-- 
2.33.1

