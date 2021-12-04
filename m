Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10431468446
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384719AbhLDK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384722AbhLDK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:04 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D12C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bu18so12973310lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b95RkMXv1TohTPIVCIvy8DhA7V0WtIhTlgTX8r5yr2Q=;
        b=Lm5mZGvDORQNh5UEQOnlAwTXHaLWBwFyFeIpvw6u5IhEhIJdQYLz+N61E8rvEbLZiv
         i7/xxvfAEtKnBhPiFugWNkYWFf8lJo50H5G89p1J2T3saYRn0ork/+nbmBAFt70TI8nu
         MLSLfb5teWK6VLWpin5ZIUG6LPgWCKrDiW7Om4NqnvVJ78ktO6l3n+PUGTj6seZQqfnM
         GLgmeyPJRQzR83joUBaxAwwbVR1wmG/34XlANox9E796Ut2QjyaXUThj996RKNG8SeXF
         7ZQpXRC9oznFg1GKu+lj4pcV9pbxy4Nsl6OFUODTwo8BG72IIWY8W3IrCXvO93IlQJJQ
         ff1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b95RkMXv1TohTPIVCIvy8DhA7V0WtIhTlgTX8r5yr2Q=;
        b=bB/NbjGoHaS4MRoSy6SIs6uSt/hObI6DDE0BKibwMRYt4AgPFvhX+/mtda4dZA7zjK
         q23I5BaAX1um9laz8gZQB/FJQ1A7yZxkXi63kmaum96o61t90od3l8BMfltZTzTOiHJh
         FbB27eEh2AMirkYnbPmYyN5THk3FPWgAhfOBatcO7urv2s+GGQeJvFG1/AaU9cbQ+AQO
         t+xvFC6e+KwkVCjBB5qbibmnlK7KkEIIQD7V2jpaBB4gZ4oaeDHm8TPWtpN+lHihtHpo
         zqLjDIbLHmBbT8v4suESLiM1bxgcUCFN0TwiR0HogML97Alp5v3zY2qe8g18vHlFZB9T
         DtJw==
X-Gm-Message-State: AOAM530WxnZkQ0yRC6KFtYv9ZnbmFq8jF9MG7+qm99MiMhfDUzCizYz/
        qW/qRiVl14jQ24fJBN7o9P4=
X-Google-Smtp-Source: ABdhPJztx3YPx6NtCubii7eP1fo6WEiVX1lqie7tJAfks65Gb1yiHcIqxmd0yclfHkhOJdKDMN580A==
X-Received: by 2002:a05:6512:39d6:: with SMTP id k22mr23631006lfu.559.1638615336976;
        Sat, 04 Dec 2021 02:55:36 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:36 -0800 (PST)
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
Subject: [PATCH 2/9] drm/i915/gvt: Constify intel_gvt_gtt_pte_ops
Date:   Sat,  4 Dec 2021 11:55:20 +0100
Message-Id: <20211204105527.15741-3-rikard.falkeborn@gmail.com>
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
 drivers/gpu/drm/i915/gvt/gtt.c | 62 +++++++++++++++++-----------------
 drivers/gpu/drm/i915/gvt/gtt.h |  2 +-
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 6efa48727052..c8cd6bf28ea8 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -499,7 +499,7 @@ DEFINE_PPGTT_GMA_TO_INDEX(gen8, l3_pdp, (gma >> 30 & 0x3));
 DEFINE_PPGTT_GMA_TO_INDEX(gen8, l4_pdp, (gma >> 30 & 0x1ff));
 DEFINE_PPGTT_GMA_TO_INDEX(gen8, pml4, (gma >> 39 & 0x1ff));
 
-static struct intel_gvt_gtt_pte_ops gen8_gtt_pte_ops = {
+static const struct intel_gvt_gtt_pte_ops gen8_gtt_pte_ops = {
 	.get_entry = gtt_get_entry64,
 	.set_entry = gtt_set_entry64,
 	.clear_present = gtt_entry_clear_present,
@@ -526,7 +526,7 @@ static const struct intel_gvt_gtt_gma_ops gen8_gtt_gma_ops = {
 };
 
 /* Update entry type per pse and ips bit. */
-static void update_entry_type_for_real(struct intel_gvt_gtt_pte_ops *pte_ops,
+static void update_entry_type_for_real(const struct intel_gvt_gtt_pte_ops *pte_ops,
 	struct intel_gvt_gtt_entry *entry, bool ips)
 {
 	switch (entry->type) {
@@ -553,7 +553,7 @@ static void _ppgtt_get_root_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index,
 		bool guest)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_PPGTT);
 
@@ -580,7 +580,7 @@ static void _ppgtt_set_root_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index,
 		bool guest)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
 
 	pte_ops->set_entry(guest ? mm->ppgtt_mm.guest_pdps :
 			   mm->ppgtt_mm.shadow_pdps,
@@ -596,7 +596,7 @@ static inline void ppgtt_set_shadow_root_entry(struct intel_vgpu_mm *mm,
 static void ggtt_get_guest_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_GGTT);
 
@@ -608,7 +608,7 @@ static void ggtt_get_guest_entry(struct intel_vgpu_mm *mm,
 static void ggtt_set_guest_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_GGTT);
 
@@ -619,7 +619,7 @@ static void ggtt_set_guest_entry(struct intel_vgpu_mm *mm,
 static void ggtt_get_host_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_GGTT);
 
@@ -629,7 +629,7 @@ static void ggtt_get_host_entry(struct intel_vgpu_mm *mm,
 static void ggtt_set_host_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *entry, unsigned long index)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = mm->vgpu->gvt->gtt.pte_ops;
 	unsigned long offset = index;
 
 	GEM_BUG_ON(mm->type != INTEL_GVT_MM_GGTT);
@@ -655,7 +655,7 @@ static inline int ppgtt_spt_get_entry(
 		bool guest)
 {
 	struct intel_gvt *gvt = spt->vgpu->gvt;
-	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	int ret;
 
 	e->type = get_entry_type(type);
@@ -684,7 +684,7 @@ static inline int ppgtt_spt_set_entry(
 		bool guest)
 {
 	struct intel_gvt *gvt = spt->vgpu->gvt;
-	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 
 	if (WARN(!gtt_type_is_entry(e->type), "invalid entry type\n"))
 		return -EINVAL;
@@ -947,7 +947,7 @@ static int ppgtt_invalidate_spt_by_shadow_entry(struct intel_vgpu *vgpu,
 		struct intel_gvt_gtt_entry *e)
 {
 	struct drm_i915_private *i915 = vgpu->gvt->gt->i915;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *s;
 	enum intel_gvt_gtt_type cur_pt_type;
 
@@ -984,7 +984,7 @@ static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
 		struct intel_gvt_gtt_entry *entry)
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	unsigned long pfn;
 	int type;
 
@@ -1072,7 +1072,7 @@ static int ppgtt_populate_spt(struct intel_vgpu_ppgtt_spt *spt);
 static struct intel_vgpu_ppgtt_spt *ppgtt_populate_spt_by_guest_entry(
 		struct intel_vgpu *vgpu, struct intel_gvt_gtt_entry *we)
 {
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *spt = NULL;
 	bool ips = false;
 	int ret;
@@ -1136,7 +1136,7 @@ static struct intel_vgpu_ppgtt_spt *ppgtt_populate_spt_by_guest_entry(
 static inline void ppgtt_generate_shadow_entry(struct intel_gvt_gtt_entry *se,
 		struct intel_vgpu_ppgtt_spt *s, struct intel_gvt_gtt_entry *ge)
 {
-	struct intel_gvt_gtt_pte_ops *ops = s->vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = s->vgpu->gvt->gtt.pte_ops;
 
 	se->type = ge->type;
 	se->val64 = ge->val64;
@@ -1159,7 +1159,7 @@ static inline void ppgtt_generate_shadow_entry(struct intel_gvt_gtt_entry *se,
 static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
 	struct intel_gvt_gtt_entry *entry)
 {
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	unsigned long pfn;
 
 	if (!HAS_PAGE_SIZES(vgpu->gvt->gt->i915, I915_GTT_PAGE_SIZE_2M))
@@ -1176,7 +1176,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	struct intel_vgpu_ppgtt_spt *spt, unsigned long index,
 	struct intel_gvt_gtt_entry *se)
 {
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *sub_spt;
 	struct intel_gvt_gtt_entry sub_se;
 	unsigned long start_gfn;
@@ -1223,7 +1223,7 @@ static int split_64KB_gtt_entry(struct intel_vgpu *vgpu,
 	struct intel_vgpu_ppgtt_spt *spt, unsigned long index,
 	struct intel_gvt_gtt_entry *se)
 {
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_gvt_gtt_entry entry = *se;
 	unsigned long start_gfn;
 	dma_addr_t dma_addr;
@@ -1254,7 +1254,7 @@ static int ppgtt_populate_shadow_entry(struct intel_vgpu *vgpu,
 	struct intel_vgpu_ppgtt_spt *spt, unsigned long index,
 	struct intel_gvt_gtt_entry *ge)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_gvt_gtt_entry se = *ge;
 	unsigned long gfn, page_size = PAGE_SIZE;
 	dma_addr_t dma_addr;
@@ -1308,7 +1308,7 @@ static int ppgtt_populate_spt(struct intel_vgpu_ppgtt_spt *spt)
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
 	struct intel_gvt *gvt = vgpu->gvt;
-	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *s;
 	struct intel_gvt_gtt_entry se, ge;
 	unsigned long gfn, i;
@@ -1351,7 +1351,7 @@ static int ppgtt_handle_guest_entry_removal(struct intel_vgpu_ppgtt_spt *spt,
 		struct intel_gvt_gtt_entry *se, unsigned long index)
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	int ret;
 
 	trace_spt_guest_change(spt->vgpu->id, "remove", spt,
@@ -1432,7 +1432,7 @@ static int sync_oos_page(struct intel_vgpu *vgpu,
 {
 	const struct intel_gvt_device_info *info = &vgpu->gvt->device_info;
 	struct intel_gvt *gvt = vgpu->gvt;
-	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *spt = oos_page->spt;
 	struct intel_gvt_gtt_entry old, new;
 	int index;
@@ -1603,7 +1603,7 @@ static int ppgtt_handle_guest_write_page_table(
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
 	int type = spt->shadow_page.type;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_gvt_gtt_entry old_se;
 	int new_present;
 	int i, ret;
@@ -1720,7 +1720,7 @@ static int ppgtt_handle_guest_write_page_table_bytes(
 		u64 pa, void *p_data, int bytes)
 {
 	struct intel_vgpu *vgpu = spt->vgpu;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	const struct intel_gvt_device_info *info = &vgpu->gvt->device_info;
 	struct intel_gvt_gtt_entry we, se;
 	unsigned long index;
@@ -1785,7 +1785,7 @@ static void invalidate_ppgtt_mm(struct intel_vgpu_mm *mm)
 	struct intel_vgpu *vgpu = mm->vgpu;
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_gtt *gtt = &gvt->gtt;
-	struct intel_gvt_gtt_pte_ops *ops = gtt->pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gtt->pte_ops;
 	struct intel_gvt_gtt_entry se;
 	int index;
 
@@ -1815,7 +1815,7 @@ static int shadow_ppgtt_mm(struct intel_vgpu_mm *mm)
 	struct intel_vgpu *vgpu = mm->vgpu;
 	struct intel_gvt *gvt = vgpu->gvt;
 	struct intel_gvt_gtt *gtt = &gvt->gtt;
-	struct intel_gvt_gtt_pte_ops *ops = gtt->pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gtt->pte_ops;
 	struct intel_vgpu_ppgtt_spt *spt;
 	struct intel_gvt_gtt_entry ge, se;
 	int index, ret;
@@ -2067,7 +2067,7 @@ static inline int ppgtt_get_next_level_entry(struct intel_vgpu_mm *mm,
 		struct intel_gvt_gtt_entry *e, unsigned long index, bool guest)
 {
 	struct intel_vgpu *vgpu = mm->vgpu;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_vgpu_ppgtt_spt *s;
 
 	s = intel_vgpu_find_spt_by_mfn(vgpu, ops->get_pfn(e));
@@ -2096,7 +2096,7 @@ unsigned long intel_vgpu_gma_to_gpa(struct intel_vgpu_mm *mm, unsigned long gma)
 {
 	struct intel_vgpu *vgpu = mm->vgpu;
 	struct intel_gvt *gvt = vgpu->gvt;
-	struct intel_gvt_gtt_pte_ops *pte_ops = gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = gvt->gtt.pte_ops;
 	const struct intel_gvt_gtt_gma_ops *gma_ops = gvt->gtt.gma_ops;
 	unsigned long gpa = INTEL_GVT_INVALID_ADDR;
 	unsigned long gma_index[4];
@@ -2221,7 +2221,7 @@ int intel_vgpu_emulate_ggtt_mmio_read(struct intel_vgpu *vgpu, unsigned int off,
 static void ggtt_invalidate_pte(struct intel_vgpu *vgpu,
 		struct intel_gvt_gtt_entry *entry)
 {
-	struct intel_gvt_gtt_pte_ops *pte_ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = vgpu->gvt->gtt.pte_ops;
 	unsigned long pfn;
 
 	pfn = pte_ops->get_pfn(entry);
@@ -2236,7 +2236,7 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 	struct intel_gvt *gvt = vgpu->gvt;
 	const struct intel_gvt_device_info *info = &gvt->device_info;
 	struct intel_vgpu_mm *ggtt_mm = vgpu->gtt.ggtt_mm;
-	struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = gvt->gtt.pte_ops;
 	unsigned long g_gtt_index = off >> info->gtt_entry_size_shift;
 	unsigned long gma, gfn;
 	struct intel_gvt_gtt_entry e = {.val64 = 0, .type = GTT_TYPE_GGTT_PTE};
@@ -2391,7 +2391,7 @@ static int alloc_scratch_pages(struct intel_vgpu *vgpu,
 {
 	struct drm_i915_private *i915 = vgpu->gvt->gt->i915;
 	struct intel_vgpu_gtt *gtt = &vgpu->gtt;
-	struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *ops = vgpu->gvt->gtt.pte_ops;
 	int page_entry_num = I915_GTT_PAGE_SIZE >>
 				vgpu->gvt->device_info.gtt_entry_size_shift;
 	void *scratch_pt;
@@ -2822,7 +2822,7 @@ void intel_vgpu_invalidate_ppgtt(struct intel_vgpu *vgpu)
 void intel_vgpu_reset_ggtt(struct intel_vgpu *vgpu, bool invalidate_old)
 {
 	struct intel_gvt *gvt = vgpu->gvt;
-	struct intel_gvt_gtt_pte_ops *pte_ops = vgpu->gvt->gtt.pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops = vgpu->gvt->gtt.pte_ops;
 	struct intel_gvt_gtt_entry entry = {.type = GTT_TYPE_GGTT_PTE};
 	struct intel_gvt_gtt_entry old_entry;
 	u32 index;
diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index d0d598322404..a3b0f59ec8bd 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -91,7 +91,7 @@ struct intel_gvt_gtt_gma_ops {
 };
 
 struct intel_gvt_gtt {
-	struct intel_gvt_gtt_pte_ops *pte_ops;
+	const struct intel_gvt_gtt_pte_ops *pte_ops;
 	const struct intel_gvt_gtt_gma_ops *gma_ops;
 	int (*mm_alloc_page_table)(struct intel_vgpu_mm *mm);
 	void (*mm_free_page_table)(struct intel_vgpu_mm *mm);
-- 
2.34.1

