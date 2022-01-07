Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB74872C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbiAGFax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346163AbiAGFaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:30:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D0C0611FD;
        Thu,  6 Jan 2022 21:30:06 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id l3so5788597iol.10;
        Thu, 06 Jan 2022 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O69jwEK6BGWuT7bxOYDKnQEBPlUpFxQn3cSq5pD/L6c=;
        b=kjIfxzNx9rucec9vax5OFMutL6FvvqBipuTamNE+LERXDRo6gx8l/eHFoPN6aT+3aN
         839At6W/5jr7R8zFP3y1+IwGhQE39mEt7TDVl3kRBKxcuorV8/pxARug/hXVBmf569pS
         JrT3PgROyKCagtD+A6Gwn+Zi0Ha6/M1YNlHEvnWCqADuPkOrlo5g3V3KeXEu50IoqxNI
         VxzhW5roni2KOcI2LE+/afrWFB7QTwTKMr9s5K6OdYPK/lzQNU95S8l0TmNIsgmOCR4f
         0MoIrxeICOcqDG3fniszaXgabKKQoGpnyxn6NaSlmPuvSP+XUpFOGumJBlcrv7/XAJfv
         jWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O69jwEK6BGWuT7bxOYDKnQEBPlUpFxQn3cSq5pD/L6c=;
        b=eUTnPaPvISGfEHNQi4N9J/Z7IRn7ibsEvZPh+jZMuQkslYMA5Ozl8HoZMnO/i1og3z
         KNWjvwRv44J+z69LlfXPyrkYd36jhEH8dVzZFon+BoBx6N48oB7f/v2jvKDkYEz4pjOx
         X5cVfcqqlUnSLk9qUG4D0lJBLx3wOe+xMpb1K4SPSkGSq6MLwQZgqnvJX7c1hyqU5G6X
         6WAJxckrM6KvBajikeElQTJFEco0P5dMv5KEpqTHAVCovfbgp9yR/AQUwpHYrDndja7P
         cmECqmTaTswpvx6/spEfJ3qnxgiP34ovEmTFN6X74xA8i0cPUQ10o6gy6r7+nOOgZD3Y
         tYOw==
X-Gm-Message-State: AOAM532LWro+23T1r4n6gXNM+qHvIeC6xHOqPiyzklcoENh7HCNh8YBv
        m3Uy8ZRf7QALP44Q+UhX1EU=
X-Google-Smtp-Source: ABdhPJxTkXRmMBve2LtAb8XAmhR2+L3R66b7dP6c1YxaZdMVvWReyuf74i4hY6RdW4AdcGIW1ZI0lw==
X-Received: by 2002:a05:6638:370c:: with SMTP id k12mr28932444jav.25.1641533405766;
        Thu, 06 Jan 2022 21:30:05 -0800 (PST)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id c18sm1843446iod.18.2022.01.06.21.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:30:05 -0800 (PST)
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
Subject: [PATCH v11 13/19] drm_print: refine drm_debug_enabled for dyndbg+jump-label
Date:   Thu,  6 Jan 2022 22:29:36 -0700
Message-Id: <20220107052942.1349447-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107052942.1349447-1-jim.cromie@gmail.com>
References: <20220107052942.1349447-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use dynamic-debug's jump-label optimization in drm-debug,
its clarifying to refine drm_debug_enabled into 3 uses:

1.   drm_debug_enabled - legacy, public
2. __drm_debug_enabled - optimized for dyndbg jump-label enablement.
3.  _drm_debug_enabled - pr_debug instrumented, observable

1. The legacy version always checks the bits.

2. is privileged, for use by __drm_dbg(), __drm_dev_dbg(), which do an
early return unless the category is enabled (free of call/NOOP side
effects).  For dyndbg builds, debug callsites are selectively
"pre-enabled", so __drm_debug_enabled() short-circuits to true there.
Remaining callers of 1 may be able to use 2, case by case.

3. is 1st wrapped in a macro, with a pr_debug, which reports each
usage in /proc/dynamic_debug/control, making it observable in the
logs.  The macro lets the pr_debug see the real caller, not the inline
function.

When plugged into 1, it identified ~10 remaining callers of the
function, leading to the follow-on cleanup patch, and would allow
activating the pr_debugs, estimating the callrate, and the potential
savings by using the wrapper macro.

It is unused ATM, but it fills out the picture.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 5dd6713c14f2..aab29dd6cad1 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -265,7 +265,7 @@ void __drm_dev_dbg(const struct device *dev, enum drm_debug_category category,
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
@@ -290,7 +290,7 @@ void ___drm_dbg(enum drm_debug_category category, const char *format, ...)
 	struct va_format vaf;
 	va_list args;
 
-	if (!drm_debug_enabled(category))
+	if (!__drm_debug_enabled(category))
 		return;
 
 	va_start(args, format);
-- 
2.33.1

