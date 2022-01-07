Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0B54872B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346270AbiAGFaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346092AbiAGF37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:29:59 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E7C061245;
        Thu,  6 Jan 2022 21:29:59 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id v18so3782668ilm.11;
        Thu, 06 Jan 2022 21:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KuUpo8N7O6zfCcQlim8LLc328KIOMpVIHmOBAPahhn4=;
        b=bJ/n5Q/dPqC+YFPh92aeruYamwdqsuJZrluEKsrTDhwqmu8Fb4JTaPyRt5ppFFUgkJ
         +naYVaSeN+LIgNQsfRVtctMtWqzkwjq2WzzFqJ2qE/B91Y6WH3a1gVw7PtofKY+9/jKk
         HpuSX9xGFF3YYHcYpHzZkkXHQ8i6RFqifCkt6raVeU7hilf1KPsiARZKkm2pjgnt+fzg
         DtS6h+lnsUno5cNenvFVUBSx745HI3tL0Bbfg2E9KMDsfcvIYLSA4tiaIHUKZzW5Ciw9
         yZH5W9pJ5bVQtZERKqmG6p9llU0RE8hgM4ymHzrKsH5TmcEfxPwjM940iF8HakEwvs60
         amXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KuUpo8N7O6zfCcQlim8LLc328KIOMpVIHmOBAPahhn4=;
        b=Sa5ri439yKxhd2+XojRf82piZwbMEyy8HewypAqUaqN/RmvZ4Uerz/rSxdKQvZmJBa
         t149PD4v1w6o16Rc7KbLxSDkCKeIeRKaiTdKEmaXXyEgnXN4k25zrkYU8aP5Mh/M8L5K
         tg9GBs9x2uUDw8JRMXVYSLh+jjKKnM0DGZKPlNSMw1i2+nOyGbi5dt3cV9gmvB4iz+Jr
         AuNWfnVEA7N2O6FIGFEDK66iUDou2PG8IQIMUqbp+v2xLfBv1cV9C82NCKosAhel4n4u
         T2wd8wrHIK8rIud+MPU0sut7HV/udz895PaBarb5Z9nYseDrG2rFar/9fXbi4eRbWMr5
         9IHA==
X-Gm-Message-State: AOAM531JIdfbNmlXIlo1D6s2FJANyti4UyFuX32z/CB2YTHDAHLZSei9
        szlqNk6bB7ABIg4kFWbPzlQ=
X-Google-Smtp-Source: ABdhPJy2rvSWBjxrv0s0L+Dd40rEcbOGWkDTDS7wEKky+oaA8kMgIOWAJ3OBBEACDrV+n0KZGzNJKA==
X-Received: by 2002:a05:6e02:20c9:: with SMTP id 9mr29967785ilq.108.1641533398507;
        Thu, 06 Jan 2022 21:29:58 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:29:58 -0800 (PST)
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
Subject: [PATCH v11 07/19] drm_print: condense enum drm_debug_category
Date:   Thu,  6 Jan 2022 22:29:30 -0700
Message-Id: <20220107052942.1349447-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum drm_debug_category has 10 hardcoded values, which could be
"simplified" as sequential BIT(x)s.  But lets take it one step
further, removing the explicit initializations (other than starting at
1), and move the BIT() operation into drm_debug_enabled().

This gives us a more compact representation (4 bits), without loss of
info; all DRM.debug api calls pass an enum parameter (and not a bit-OR
of them), and the bitmask-iness of the enum's values is merely a
micro-optimization to avoid doing BIT(category) at runtime.  I doubt
the extra bit-shift would be measurable here.

And the 4-bit representation means it fits into struct
_ddebug.class_id (commit:HEAD~1), setting up for further integration.

The enum starts at 1, which respects the "reservation" of 0 as a
special case; it is a non-category, and shouldn't get treated like one.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/drm/drm_print.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 22fabdeed297..b4355bfd7888 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -279,49 +279,49 @@ enum drm_debug_category {
 	 * @DRM_UT_CORE: Used in the generic drm code: drm_ioctl.c, drm_mm.c,
 	 * drm_memory.c, ...
 	 */
-	DRM_UT_CORE		= 0x01,
+	DRM_UT_CORE = 1,
 	/**
 	 * @DRM_UT_DRIVER: Used in the vendor specific part of the driver: i915,
 	 * radeon, ... macro.
 	 */
-	DRM_UT_DRIVER		= 0x02,
+	DRM_UT_DRIVER,
 	/**
 	 * @DRM_UT_KMS: Used in the modesetting code.
 	 */
-	DRM_UT_KMS		= 0x04,
+	DRM_UT_KMS,
 	/**
 	 * @DRM_UT_PRIME: Used in the prime code.
 	 */
-	DRM_UT_PRIME		= 0x08,
+	DRM_UT_PRIME,
 	/**
 	 * @DRM_UT_ATOMIC: Used in the atomic code.
 	 */
-	DRM_UT_ATOMIC		= 0x10,
+	DRM_UT_ATOMIC,
 	/**
 	 * @DRM_UT_VBL: Used for verbose debug message in the vblank code.
 	 */
-	DRM_UT_VBL		= 0x20,
+	DRM_UT_VBL,
 	/**
 	 * @DRM_UT_STATE: Used for verbose atomic state debugging.
 	 */
-	DRM_UT_STATE		= 0x40,
+	DRM_UT_STATE,
 	/**
 	 * @DRM_UT_LEASE: Used in the lease code.
 	 */
-	DRM_UT_LEASE		= 0x80,
+	DRM_UT_LEASE,
 	/**
 	 * @DRM_UT_DP: Used in the DP code.
 	 */
-	DRM_UT_DP		= 0x100,
+	DRM_UT_DP,
 	/**
 	 * @DRM_UT_DRMRES: Used in the drm managed resources code.
 	 */
-	DRM_UT_DRMRES		= 0x200,
+	DRM_UT_DRMRES
 };
 
 static inline bool drm_debug_enabled(enum drm_debug_category category)
 {
-	return unlikely(__drm_debug & category);
+	return unlikely(__drm_debug & BIT(category));
 }
 
 /*
-- 
2.33.1

