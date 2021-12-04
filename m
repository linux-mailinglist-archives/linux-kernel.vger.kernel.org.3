Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32E7468449
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384789AbhLDK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384727AbhLDK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:07 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A15C061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:41 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id i63so11210887lji.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruXRve/GlUdLdEDYaUOifA1lUCUJXWdxTJEvuumUifQ=;
        b=MIJDV/2eWWclyWyD6qEyVllFzvqSaBiUOIOyQlKbG/3fqBQb5vAXWpp4ZoZEeSFs+W
         Xk+yE3Jgw8yvSn9ndrXnrAlq9CKep+C5cjraC+zzwf9Eus8GKi9N7mer8KF93E/aOej3
         IUu7ocsIcDYu5yqNOwt98008LSHrk8YeUmY6w5HG3zY6JD6R2vCkUVBPJquKZnoszsUX
         +sSrCMK5UEmUe0VajerYj0LtNMlqYq59TC5o0WtG1qXid1OyCIpVy/pUSJlgWCcdmQmo
         LdF+Rv2eUgR+ljhBHIYCBdKoqhXWB0h++GQTlLaHM0UfsQEUUwNxgbJMbEOlyUEtTXcQ
         D3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruXRve/GlUdLdEDYaUOifA1lUCUJXWdxTJEvuumUifQ=;
        b=5S0y3sEdi4VUd07NkAaRv4kRlaL9DRebmkZM4/Q4aWBKSJ+zheCmtNqeBD4LBxqw4A
         s86eKER0GOu4AMYegjtQYzpmnfbQXC6meAC7WBXPH4ZzaT5wzWqVq81jIr2xKEy4cGKm
         JbIV6PoUVG+HF9eyyjLitL4zEQF3/lEX/IE4HKRmJjtSHenmv2zyfvs3/UkMTI8s0d5+
         NWgzkEFiIfQmo2T0+KoXGleVI2KT0/iMSvgsZVl4sfi/0lbyIsfCFZ3HHbr3iuHp/Qo7
         TpBk+Hu8UOJ3W9tLBbwmbFZ+W6UXhat4CndeQJ/HOlUMNM6DpDHrZefdfYO9v1wKRwql
         y6HQ==
X-Gm-Message-State: AOAM531cLiduhk86Sn03fJhyYXLKSXzoO0jjU4QqwLXGtqJYH1dAMsQx
        DIlcOEYOGn4IpLZNAs0jtiM=
X-Google-Smtp-Source: ABdhPJy2El7rztlBv1liaSflPNwardluUjHPPvs5OMe3GdnrapbiU7s49r3lY3D5gJcm/qDK3WPveA==
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr24987306ljb.456.1638615339927;
        Sat, 04 Dec 2021 02:55:39 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:39 -0800 (PST)
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
Subject: [PATCH 5/9] drm/i915/gvt: Constify gvt_mmio_block
Date:   Sat,  4 Dec 2021 11:55:23 +0100
Message-Id: <20211204105527.15741-6-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/i915/gvt/gvt.h      |  2 +-
 drivers/gpu/drm/i915/gvt/handlers.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 0c0615602343..0ebffc327528 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -272,7 +272,7 @@ struct intel_gvt_mmio {
 /* Value of command write of this reg needs to be patched */
 #define F_CMD_WRITE_PATCH	(1 << 8)
 
-	struct gvt_mmio_block *mmio_block;
+	const struct gvt_mmio_block *mmio_block;
 	unsigned int num_mmio_block;
 
 	DECLARE_HASHTABLE(mmio_info_table, INTEL_GVT_MMIO_HASH_BITS);
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index cde0a477fb49..5e85a77da257 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -3627,11 +3627,11 @@ static int init_bxt_mmio_info(struct intel_gvt *gvt)
 	return 0;
 }
 
-static struct gvt_mmio_block *find_mmio_block(struct intel_gvt *gvt,
-					      unsigned int offset)
+static const struct gvt_mmio_block *find_mmio_block(struct intel_gvt *gvt,
+						    unsigned int offset)
 {
 	unsigned long device = intel_gvt_get_device_type(gvt);
-	struct gvt_mmio_block *block = gvt->mmio.mmio_block;
+	const struct gvt_mmio_block *block = gvt->mmio.mmio_block;
 	int num = gvt->mmio.num_mmio_block;
 	int i;
 
@@ -3670,7 +3670,7 @@ void intel_gvt_clean_mmio_info(struct intel_gvt *gvt)
  * accessible (should have no F_CMD_ACCESS flag).
  * otherwise, need to update cmd_reg_handler in cmd_parser.c
  */
-static struct gvt_mmio_block mmio_blocks[] = {
+static const struct gvt_mmio_block mmio_blocks[] = {
 	{D_SKL_PLUS, _MMIO(DMC_MMIO_START_RANGE), 0x3000, NULL, NULL},
 	{D_ALL, _MMIO(MCHBAR_MIRROR_BASE_SNB), 0x40000, NULL, NULL},
 	{D_ALL, _MMIO(VGT_PVINFO_PAGE), VGT_PVINFO_SIZE,
@@ -3753,7 +3753,7 @@ int intel_gvt_for_each_tracked_mmio(struct intel_gvt *gvt,
 	int (*handler)(struct intel_gvt *gvt, u32 offset, void *data),
 	void *data)
 {
-	struct gvt_mmio_block *block = gvt->mmio.mmio_block;
+	const struct gvt_mmio_block *block = gvt->mmio.mmio_block;
 	struct intel_gvt_mmio_info *e;
 	int i, j, ret;
 
@@ -3871,7 +3871,7 @@ int intel_vgpu_mmio_reg_rw(struct intel_vgpu *vgpu, unsigned int offset,
 	struct drm_i915_private *i915 = vgpu->gvt->gt->i915;
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_mmio_info *mmio_info;
-	struct gvt_mmio_block *mmio_block;
+	const struct gvt_mmio_block *mmio_block;
 	gvt_mmio_func func;
 	int ret;
 
-- 
2.34.1

