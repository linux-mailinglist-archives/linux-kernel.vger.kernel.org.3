Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF558468448
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384736AbhLDK7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384723AbhLDK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9067C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n12so12873645lfe.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J16kucgpxxFj0SceQv3cDVzmFp/VklNjZX1TRul+m8Y=;
        b=KTxS8CAlcFPuXjGbMPumG7q97zGouOde1CcmY7L/uLuhADnM4BcoJMaeom0EXCX84t
         pny52CZzamXSPOcEbdxdNpKGjGeanjhnAT56YOLMDbwy6NgskLRwtl29B+r7HOWTrSEP
         3YJbDPxh1P7Hxb5p/8UtPbREgpkKOXWnS/rZJVrSZ/agE9Ih+6o7nzIHAle49Mkth6fs
         AniTatkRxe5vpY2hGkli8edWmJbyz34xDpWZPmbAPO1Di55UFktRXW0U+8XWCjtGh8YX
         Y6FzqFJ8BC8YDfuJ4/r4TMHLD8Iqco18BRrI0hdg03pH44+5ngMJ9G/OpWhKkZFpjqx8
         65qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J16kucgpxxFj0SceQv3cDVzmFp/VklNjZX1TRul+m8Y=;
        b=WPsi7mTDXLOS2DYaHcBWUHWVzbLAUNb30S51cdwamDjgKSKlU/y/qF3KgPJ+s7ZItc
         sxrPU9Nf0VmYXzdPwrS1QJcEL0TBJ+mGYcv5KGevpmcO2pdz8r7zr1sWxEshcTFq4oBR
         tQe0JvqOYDVu2CrrMIRE4bYj0LsdLo4ATwZ1NqblnrOODTO4c4Hs6UTkj0bV7Igvq6mg
         EUPLomYmPQG+DZMJA1WkziWPYspguxDRfOfHEi39qrwa45bbJyV/HJabxlH4rJROE+ES
         18Up2Jl9nHUwCohz3N245dr1nXrMtSRIGWPCBjTlrW5opGFkjv8g79WYYfIqTjU/13As
         8ZoA==
X-Gm-Message-State: AOAM532zFYcFuZEQWaLe+Ld1K8PJBuHS/dxW40O5hsQr3RzetPlUDy9z
        phgzPE1Qmp9FSjlkOGjXPpMc//hGBE9uzg==
X-Google-Smtp-Source: ABdhPJxnHBBiPnzp0Q9S5ostX7DrJZwnx/uVFjAfrciWbmhTvWDenGzboQjNhJgA/NdKbesvHKcvRQ==
X-Received: by 2002:a05:6512:3ca4:: with SMTP id h36mr23357327lfv.411.1638615338968;
        Sat, 04 Dec 2021 02:55:38 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:38 -0800 (PST)
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
Subject: [PATCH 4/9] drm/i915/gvt: Constify intel_gvt_sched_policy_ops
Date:   Sat,  4 Dec 2021 11:55:22 +0100
Message-Id: <20211204105527.15741-5-rikard.falkeborn@gmail.com>
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
 drivers/gpu/drm/i915/gvt/sched_policy.c | 2 +-
 drivers/gpu/drm/i915/gvt/scheduler.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/sched_policy.c b/drivers/gpu/drm/i915/gvt/sched_policy.c
index 036b74fe9298..c077fb4674f0 100644
--- a/drivers/gpu/drm/i915/gvt/sched_policy.c
+++ b/drivers/gpu/drm/i915/gvt/sched_policy.c
@@ -368,7 +368,7 @@ static void tbs_sched_stop_schedule(struct intel_vgpu *vgpu)
 	vgpu_data->active = false;
 }
 
-static struct intel_gvt_sched_policy_ops tbs_schedule_ops = {
+static const struct intel_gvt_sched_policy_ops tbs_schedule_ops = {
 	.init = tbs_sched_init,
 	.clean = tbs_sched_clean,
 	.init_vgpu = tbs_sched_init_vgpu,
diff --git a/drivers/gpu/drm/i915/gvt/scheduler.h b/drivers/gpu/drm/i915/gvt/scheduler.h
index 7c86984a842f..1f391b3da2cc 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.h
+++ b/drivers/gpu/drm/i915/gvt/scheduler.h
@@ -56,7 +56,7 @@ struct intel_gvt_workload_scheduler {
 	wait_queue_head_t waitq[I915_NUM_ENGINES];
 
 	void *sched_data;
-	struct intel_gvt_sched_policy_ops *sched_ops;
+	const struct intel_gvt_sched_policy_ops *sched_ops;
 };
 
 #define INDIRECT_CTX_ADDR_MASK 0xffffffc0
-- 
2.34.1

