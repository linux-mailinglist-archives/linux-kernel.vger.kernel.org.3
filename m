Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E49468445
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384747AbhLDK7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384719AbhLDK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:02 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A035C061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:37 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u22so11156849lju.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMWhXajJiO5/ngjUzSyRmg7Q56WNQVKtCHyObQxH9Wg=;
        b=cIym/fh9aHVFDhGAj0hvUz+OG75vxQxF2mMByqcvJk603QAr9P5yDTOIY17tko55Dp
         03rxl8fgbhQSebhWCp+fayAWUnbM3PSB/KhTnawZjO9msrffBLMcb8d6yQ328A5Ydl4F
         m+FpG3ce6TUa5a00X2v9BvqdPLZu1+Ng/tZ+rzs9gtbeWgwzkVsfgUB06dPqCN3y2eMH
         WKHIQzKFzQcL5GJ1UhDTzX7OJvhAaYlnfyFNZCDdQ2G53ohQCrSyqu7S+5LWWu4sQdHY
         y/eQbrMBgreF0AE/LfpVuUY4CtYEx3F/hP2Z/XlYbdUBNXaXkMPob/lhfi5R2E3YKRhV
         OTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMWhXajJiO5/ngjUzSyRmg7Q56WNQVKtCHyObQxH9Wg=;
        b=jiEnMDaZIB/0sUzwv+vFlGY/0oPCr/DbETl6wcVnOJ2QFOg1rntuZ/AS6+xnpaTuGF
         Ojcnk4yDLXIWNonJs7p6p6Hc2EUUY7Ca4lVA5trVAeBTtM3L+6LCqOfAwMUp4V/4D31g
         Xw48DXsGcdaXfaUouu8td1vPtgAWeLo+pzlIuWnc1A29aUa2Z5Yxdqn/RO3rBxHoyY56
         ubYeVddNvS6WGL6Dd7GMKpDMXznYAygI2Qywck57xTk4ZzFNIP/LVGUj0HnbTLUP0t4u
         n5fUCWGD6T/v3Uef9O+mOWW6067jvTNxA3Q0dM9gFCwTvM3afUHS02hj1rqmd2EwG61v
         Hu4A==
X-Gm-Message-State: AOAM5312bTD047IEyPoAKR8akCxp6gvh0Zk2+d4JW0D4WxlEegeYWbKr
        L9GwXB11bTFFg4gYkVhNZFQ=
X-Google-Smtp-Source: ABdhPJzAvK3lM4MuYvqgdryJD+si4iT6GqCmZFbOMDBg7ckgsqI2GdDZzUmpmowYddV/Bb34pDqc1Q==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9mr23107843ljj.27.1638615335817;
        Sat, 04 Dec 2021 02:55:35 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:35 -0800 (PST)
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
Subject: [PATCH 1/9] drm/i915/gvt: Constify intel_gvt_gtt_pte_ops
Date:   Sat,  4 Dec 2021 11:55:19 +0100
Message-Id: <20211204105527.15741-2-rikard.falkeborn@gmail.com>
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
 drivers/gpu/drm/i915/gvt/gtt.c | 4 ++--
 drivers/gpu/drm/i915/gvt/gtt.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 53d0cb327539..6efa48727052 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -516,7 +516,7 @@ static struct intel_gvt_gtt_pte_ops gen8_gtt_pte_ops = {
 	.set_pfn = gen8_gtt_set_pfn,
 };
 
-static struct intel_gvt_gtt_gma_ops gen8_gtt_gma_ops = {
+static const struct intel_gvt_gtt_gma_ops gen8_gtt_gma_ops = {
 	.gma_to_ggtt_pte_index = gma_to_ggtt_pte_index,
 	.gma_to_pte_index = gen8_gma_to_pte_index,
 	.gma_to_pde_index = gen8_gma_to_pde_index,
@@ -2097,7 +2097,7 @@ unsigned long intel_vgpu_gma_to_gpa(struct intel_vgpu_mm *mm, unsigned long gma)
 	struct intel_vgpu *vgpu = mm->vgpu;
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_gtt_pte_ops *pte_ops = gvt->gtt.pte_ops;
-	struct intel_gvt_gtt_gma_ops *gma_ops = gvt->gtt.gma_ops;
+	const struct intel_gvt_gtt_gma_ops *gma_ops = gvt->gtt.gma_ops;
 	unsigned long gpa = INTEL_GVT_INVALID_ADDR;
 	unsigned long gma_index[4];
 	struct intel_gvt_gtt_entry e;
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index 3bf45672ef98..d0d598322404 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -92,7 +92,7 @@ struct intel_gvt_gtt_gma_ops {
 
 struct intel_gvt_gtt {
 	struct intel_gvt_gtt_pte_ops *pte_ops;
-	struct intel_gvt_gtt_gma_ops *gma_ops;
+	const struct intel_gvt_gtt_gma_ops *gma_ops;
 	int (*mm_alloc_page_table)(struct intel_vgpu_mm *mm);
 	void (*mm_free_page_table)(struct intel_vgpu_mm *mm);
 	struct list_head oos_page_use_list_head;
-- 
2.34.1

