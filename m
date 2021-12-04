Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203F346844C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384865AbhLDLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384738AbhLDK7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28188C061359
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu18so12973731lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ZsaCGjkX57VU37ZwPgn6ut1UEGl/i4rIkhwzK9YXBM=;
        b=VbjZssCqahnEymdQXcugkZM7CINrIXO5t9jSAm+Eh1GBeOrM029IZ7lisGsN2PjAAr
         GAtNyIdsfkAv3UL58N7abxCO+OfvpgnJ74wF4M/7t1xV1yFH3QfACbyE9A5Qy2bq8eX5
         mnDtxBPIOKugY0cN7RXl9Of+xgZPnk9JtTOmBtqzGRvAPnkFmN/0GmOlQLhy5fQzeKhV
         TviY0fd40sOg/8Np4s+rmVC2GVPDWvpjjRVkadRz27Eo6bWinsXoRCjSRyIZURsqbm3X
         c6jPzBhz2S3o37CaQtbVCXcJy6bEIUyZvzJX3QMvVykNijnjBCfg3DW3Ao+Pz04+NlyG
         K07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ZsaCGjkX57VU37ZwPgn6ut1UEGl/i4rIkhwzK9YXBM=;
        b=1fM8XZjcoYJzWJIAplBHFrxvrJVwfOg8B7y67M9FavInmsBqKopFtuyGHYASsJY0SW
         4APxe79taOBgPf7itwxCske88mxr7mM+iysRi9ziax2lQFX2ItFK6Zw4amwfgUkFh7+U
         LGw78QzqUMul6GSbhFc4Of1EkEGSIMijS3+i12eMrJYzUzgKkLqzjcprICsOP3biwju0
         8kLZnEIx/GUgGpo6AeLrw2mtyhCcncTbuArd0q5tBV3bcY6jYZeb5c2D//PexZvY9nb9
         x+vIZLv1K92L4BUg/AAAYcK5eIvOtcRVYZ86693cXYBmuGI5tey3BvquBx/Dpj2j9WXs
         ZjWw==
X-Gm-Message-State: AOAM533u5+NVs5GR8xOmsziCOVigsKmU9SJLwB/ikZMztLBwLeiJjLHw
        leEcXtFN5R0YhHm6m0oUDik=
X-Google-Smtp-Source: ABdhPJzrSS7wNoxNyAhHl4z41bEtVkFVwiO6lKZhMVCjLQSo3N3FFW3/Lz5atIf67FXVDwU2xT4v+g==
X-Received: by 2002:a05:6512:13aa:: with SMTP id p42mr22646580lfa.474.1638615343479;
        Sat, 04 Dec 2021 02:55:43 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:43 -0800 (PST)
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
Subject: [PATCH 9/9] drm/i915/gvt: Constify vgpu_types
Date:   Sat,  4 Dec 2021 11:55:27 +0100
Message-Id: <20211204105527.15741-10-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so make it const to allow the compiler to put it
in read-only memory. While at it, make name a const char*.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/i915/gvt/vgpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index fa6b92615799..8dddd0a940a1 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -77,7 +77,7 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu)
 #define VGPU_WEIGHT(vgpu_num)	\
 	(VGPU_MAX_WEIGHT / (vgpu_num))
 
-static struct {
+static const struct {
 	unsigned int low_mm;
 	unsigned int high_mm;
 	unsigned int fence;
@@ -88,7 +88,7 @@ static struct {
 	 */
 	unsigned int weight;
 	enum intel_vgpu_edid edid;
-	char *name;
+	const char *name;
 } vgpu_types[] = {
 /* Fixed vGPU type table */
 	{ MB_TO_BYTES(64), MB_TO_BYTES(384), 4, VGPU_WEIGHT(8), GVT_EDID_1024_768, "8" },
-- 
2.34.1

