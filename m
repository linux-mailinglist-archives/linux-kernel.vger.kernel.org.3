Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6B4FBEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbiDKOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347014AbiDKOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6E1E0EF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BLKPzt6UhuF0qWHtONyuatQ8VTYibdXrDV6MGR+HIHQ=; b=nG6hwjmN+lf16CyFUQTt37hva5
        avEQman3t2gqcLb5L4Dra7rS28UqtElcpPcL5WdYZetXO4/KiKAwESxlVuP2q9d4NU1B2/lbSPfnq
        dBuBCZf/3UeEdw8RtAGI4wjoNR8sT5/8+I457uDJPXKdfTyFFJVLyiqxTssR92iECrd0U+F0CdCu9
        vlkZI3TFN3Yvr6RLJkTAGJJ8+goFzWjadSejD1r3bH/lz0tI04yomis5Ul30X0Jtn/o8d4XT2V/FR
        IkvynxvFJAKNDIlzAYkqop9J7fMQm36wdrefcNR5p46/y9uRaet0C/74ZA+74D+vUKZ6xI2qGRJnQ
        Zb0QLagA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduo8-009KLU-Hr; Mon, 11 Apr 2022 14:14:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/34] drm/i915/gvt: don't override the include path
Date:   Mon, 11 Apr 2022 16:13:33 +0200
Message-Id: <20220411141403.86980-5-hch@lst.de>
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

drivers/gpu/drm/i915/gvt/Makefile is included
from drivers/gpu/drm/i915/Makefile and thus inherits the normal include
path relative to drivers/gpu/drm/i915/.  Fix up the gvt-specific trace
header and just do away with the include path manipulation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/Makefile | 1 -
 drivers/gpu/drm/i915/gvt/trace.h  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index ea8324abc784a..4d70f4689479c 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -5,5 +5,4 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
 	fb_decoder.o dmabuf.o page_track.o
 
-ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
 i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
diff --git a/drivers/gpu/drm/i915/gvt/trace.h b/drivers/gpu/drm/i915/gvt/trace.h
index 6d787750d279f..348f57f8301db 100644
--- a/drivers/gpu/drm/i915/gvt/trace.h
+++ b/drivers/gpu/drm/i915/gvt/trace.h
@@ -379,5 +379,5 @@ TRACE_EVENT(render_mmio,
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE trace
+#define TRACE_INCLUDE_FILE gvt/trace
 #include <trace/define_trace.h>
-- 
2.30.2

