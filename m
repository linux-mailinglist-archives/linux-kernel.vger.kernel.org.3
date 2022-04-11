Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE314FBECD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiDKORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347053AbiDKOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA911A2A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=s8xuUGjwcKo5fWROZ9CmBLT3xMVuKw5Sj08i33D+KcM=; b=MY1b4YSDZGZ9Q9TqIxwgVvghVQ
        iA8Cj/jHUFOiezYD+xWSfY0GnNre0lwRR34bTjvx2ve6mqmAFjc3apVTuajyAp0FYnSJ89uif2mDW
        mRD1DfLmNqMXIEmZxnH/CcMxIdPRPI8Wp3wCuKtkowBmtEt+J4jJqbpR6puxR1mt3xLsBzFXk6OXJ
        +F3IsnaxsXuVP/VTtkDFbm+p6RrBVvBRQSOWBWwYef8x35D8bpgqk2yQzBiGFRNBYPXyKyZhvTRFi
        0wodZ6fOz6AjSgQaTY+Y0Vm03M9tJl34otwLRzlT9EfZheCFauNNUWV31tBOk5bWkMAUJ1aUBuxvz
        BQ6Wb4ug==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoB-009KM5-Gv; Mon, 11 Apr 2022 14:14:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/34] drm/i915/gvt: cleanup the Makefile
Date:   Mon, 11 Apr 2022 16:13:34 +0200
Message-Id: <20220411141403.86980-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match the style of the main i915 Makefile in the gvt-specfic one and
remove the GVT_DIR and GVT_SOURCE variables.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/Makefile | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index 4d70f4689479c..f2f6ea02714ec 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -1,8 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
-GVT_DIR := gvt
-GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
-	interrupt.o gtt.o cfg_space.o opregion.o mmio.o display.o edid.o \
-	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
-	fb_decoder.o dmabuf.o page_track.o
 
-i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
+i915-y += \
+	gvt/gvt.o \
+	gvt/aperture_gm.o \
+	gvt/handlers.o \
+	gvt/vgpu.o \
+	gvt/trace_points.o \
+	gvt/firmware.o \
+	gvt/interrupt.o \
+	gvt/gtt.o \
+	gvt/cfg_space.o \
+	gvt/opregion.o \
+	gvt/mmio.o \
+	gvt/display.o \
+	gvt/edid.o \
+	gvt/execlist.o \
+	gvt/scheduler.o \
+	gvt/sched_policy.o \
+	gvt/mmio_context.o \
+	gvt/cmd_parser.o \
+	gvt/debugfs.o \
+	gvt/fb_decoder.o \
+	gvt/dmabuf.o \
+	gvt/page_track.o
-- 
2.30.2

