Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A92518850
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiECPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiECPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:23:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667933DDF6;
        Tue,  3 May 2022 08:19:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id A99681F43FFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651591175;
        bh=Lzclz0U3PP1cu2Zk2o7bgbp4dAMVqW5utV/LmtxRt/8=;
        h=From:To:Cc:Subject:Date:From;
        b=No+GYtV7o4MzLGjC8LKJubPV8clRjS7feBQujvJ4NGgRzHhV+lf68pxiYSotIiQbh
         4qz6KfqEnD4DoCvAQg66QA2ysWV2wWaYMyzyv/Do+3SfucSYp7G4U1bZNBOqI6bC7O
         ABgqCgJuOA/+0tSxLTUNhMGOcZaEtpxBiBGMEnxkGSFAd+XzFhxGGHrL/w8gfl2IDh
         7GqLB81jS6KJO/dZKrnauPLzmG+pf9z61YcuQHgdVgJv0MpKYFSOfS+2XjrB7jj5ZR
         g8DX4a1zeh4eGdD336KDNAhixfR6gBKCJzQIJH4q7jX47PYvqrZFavOVbxbYvd9Onf
         8MgcZuAeSB40g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4] media: hantro: HEVC: unconditionnaly set pps_{cb/cr}_qp_offset values
Date:   Tue,  3 May 2022 17:19:20 +0200
Message-Id: <20220503151920.802417-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always set pps_cb_qp_offset and pps_cr_qp_offset values in Hantro/G2
register whatever is V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT
flag value.
The vendor code does the same to set these values.
This fixes conformance test CAINIT_G_SHARP_3.

Fluster HEVC score is increase by one with this patch.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
This patch has been tested with these branches:
- GStreamer: https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_aligned_with_kernel_5.15
- Linux: https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/WIP_HEVC_UAPI_V6

It is the setup used to prepare version 6 of the patches to move HEVC
uAPI to stable.

Fluster score was 77/147 before these series of patches and is now
124/147.

 drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index 6deb31b7b993..503f4b028bc5 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -194,13 +194,8 @@ static void set_params(struct hantro_ctx *ctx)
 		hantro_reg_write(vpu, &g2_max_cu_qpd_depth, 0);
 	}
 
-	if (pps->flags & V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT) {
-		hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
-		hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
-	} else {
-		hantro_reg_write(vpu, &g2_cb_qp_offset, 0);
-		hantro_reg_write(vpu, &g2_cr_qp_offset, 0);
-	}
+	hantro_reg_write(vpu, &g2_cb_qp_offset, pps->pps_cb_qp_offset);
+	hantro_reg_write(vpu, &g2_cr_qp_offset, pps->pps_cr_qp_offset);
 
 	hantro_reg_write(vpu, &g2_filt_offset_beta, pps->pps_beta_offset_div2);
 	hantro_reg_write(vpu, &g2_filt_offset_tc, pps->pps_tc_offset_div2);
-- 
2.32.0

