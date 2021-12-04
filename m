Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82445468447
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384766AbhLDK71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384725AbhLDK7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:05 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7A6C061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:39 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id j18so11092483ljc.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRw9Z/k7zeeiNfBUE+umq2119RMum5Jsk+yzoGV5ttU=;
        b=mffbyXP3UEabJcohGAVBweaKlRVvaLvWhp40NNMlB15F0iAULi7Qvwj0TyvQIFCQlh
         3Gp2LHiOj/UsV+qXK1IRpMQ+2pOAX2mTcHeAvqlptWx8xhMuYXe5ij+7y31uDB96v2iE
         piaWlw/naJfy+HJoU8ICm7i+u6w6/wwupaa29wSYjMOUuX2IHxpBVmyy/HprzjDZOAUj
         hUQwcdqJLmWBWQbncHt2KNtZxA0s5QVh6runclkelo/elM+jfmlAjAjcdyxHCAmFu60u
         O93i051wihWOBOW+WutVeeOttoIa1DmJmBxB+RnYBXOYfFB0OY3qaMs2v3WKCw+Hh7Qv
         VSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRw9Z/k7zeeiNfBUE+umq2119RMum5Jsk+yzoGV5ttU=;
        b=hpvjCX555tMBk6HdIx0pyIN8byfIbTq6iK/Ti6BD+ifOPi6R+5ZU3GHKQg2XbcV40M
         WDpSxnXkeyYouwmgjFrSSAl4d/KFXUl7kprePnF3MR22bynLjHsKDo9iRCTKMHzBypqP
         DYBKKFxjPqCRcL1f3oaN1y30ILOZXP/1bCTdlR4XQZ0H/WA3enqOajHo7z+tq1d/hCUg
         gJv258ntmV5Oa2BSJEJkkoAkEuDJtjjQdBTX9MuE8teeivEnln4d7gFh7UvOFcmjW7DA
         8fWUT24XRgweYrTpyuTFxUIqpMWsdnbb84HHpawRTDxXLarVPLuGK8lT+GyTGwBqDzg0
         IrDw==
X-Gm-Message-State: AOAM530P6joPlH++FnvrbrbypC504wzr244BTWcjACWf8k4sJkEN8hVJ
        7zhAMNaqWt5AWxa4yXRhXyw=
X-Google-Smtp-Source: ABdhPJzm3adkZwkrbPosQPC+A83POT4UTPAfvrjJhT/oRuC2hlF4cf5i+N1oOCcqIgXtmDRF15SaKA==
X-Received: by 2002:a05:651c:54d:: with SMTP id q13mr24237727ljp.498.1638615337926;
        Sat, 04 Dec 2021 02:55:37 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:37 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/9] drm/i915/gvt: Constify intel_gvt_irq_ops
Date:   Sat,  4 Dec 2021 11:55:21 +0100
Message-Id: <20211204105527.15741-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/i915/gvt/interrupt.c | 10 +++++-----
 drivers/gpu/drm/i915/gvt/interrupt.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/interrupt.c b/drivers/gpu/drm/i915/gvt/interrupt.c
index 614b951d919f..9ccc6b1ecc28 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.c
+++ b/drivers/gpu/drm/i915/gvt/interrupt.c
@@ -176,7 +176,7 @@ int intel_vgpu_reg_imr_handler(struct intel_vgpu *vgpu,
 	unsigned int reg, void *p_data, unsigned int bytes)
 {
 	struct intel_gvt *gvt = vgpu->gvt;
-	struct intel_gvt_irq_ops *ops = gvt->irq.ops;
+	const struct intel_gvt_irq_ops *ops = gvt->irq.ops;
 	u32 imr = *(u32 *)p_data;
 
 	trace_write_ir(vgpu->id, "IMR", reg, imr, vgpu_vreg(vgpu, reg),
@@ -206,7 +206,7 @@ int intel_vgpu_reg_master_irq_handler(struct intel_vgpu *vgpu,
 	unsigned int reg, void *p_data, unsigned int bytes)
 {
 	struct intel_gvt *gvt = vgpu->gvt;
-	struct intel_gvt_irq_ops *ops = gvt->irq.ops;
+	const struct intel_gvt_irq_ops *ops = gvt->irq.ops;
 	u32 ier = *(u32 *)p_data;
 	u32 virtual_ier = vgpu_vreg(vgpu, reg);
 
@@ -246,7 +246,7 @@ int intel_vgpu_reg_ier_handler(struct intel_vgpu *vgpu,
 {
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct drm_i915_private *i915 = gvt->gt->i915;
-	struct intel_gvt_irq_ops *ops = gvt->irq.ops;
+	const struct intel_gvt_irq_ops *ops = gvt->irq.ops;
 	struct intel_gvt_irq_info *info;
 	u32 ier = *(u32 *)p_data;
 
@@ -604,7 +604,7 @@ static void gen8_init_irq(
 	SET_BIT_INFO(irq, 25, PCU_PCODE2DRIVER_MAILBOX, INTEL_GVT_IRQ_INFO_PCU);
 }
 
-static struct intel_gvt_irq_ops gen8_irq_ops = {
+static const struct intel_gvt_irq_ops gen8_irq_ops = {
 	.init_irq = gen8_init_irq,
 	.check_pending_irq = gen8_check_pending_irq,
 };
@@ -626,7 +626,7 @@ void intel_vgpu_trigger_virtual_event(struct intel_vgpu *vgpu,
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_irq *irq = &gvt->irq;
 	gvt_event_virt_handler_t handler;
-	struct intel_gvt_irq_ops *ops = gvt->irq.ops;
+	const struct intel_gvt_irq_ops *ops = gvt->irq.ops;
 
 	handler = get_event_virt_handler(irq, event);
 	drm_WARN_ON(&i915->drm, !handler);
diff --git a/drivers/gpu/drm/i915/gvt/interrupt.h b/drivers/gpu/drm/i915/gvt/interrupt.h
index 6c47d3e33161..0989e180ed54 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.h
+++ b/drivers/gpu/drm/i915/gvt/interrupt.h
@@ -203,7 +203,7 @@ struct intel_gvt_irq_map {
 
 /* structure containing device specific IRQ state */
 struct intel_gvt_irq {
-	struct intel_gvt_irq_ops *ops;
+	const struct intel_gvt_irq_ops *ops;
 	struct intel_gvt_irq_info *info[INTEL_GVT_IRQ_INFO_MAX];
 	DECLARE_BITMAP(irq_info_bitmap, INTEL_GVT_IRQ_INFO_MAX);
 	struct intel_gvt_event_info events[INTEL_GVT_EVENT_MAX];
-- 
2.34.1

