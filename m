Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CA0567ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiGFGln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiGFGll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:41:41 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3761AD92
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rZuPa
        xkJ0zTc4Mk9Dxc6rPY18b/MAW3ZpJp5vwPFIxI=; b=Ji4gW5Nqy9jZ8MsqfNqNd
        Qpt4DzlFGvuVfI4bYro8jhtHs+SNWhKE1zs6Pidl5rKqSStvwWIcSudHHVSEqYrd
        Yx08ztomlmifzhzObv1yHzYKgw0fX3baogiCjgE4t1O+jLAl74oECfEBkVdtTnvo
        q8T/j0URo0STwZrFb6KY6A=
Received: from bf-rmsz-11.ccdomain.com (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAB3xfo+LsViMSQJNg--.19989S2;
        Wed, 06 Jul 2022 14:39:59 +0800 (CST)
From:   Zhongjun Tan <hbut_tan@163.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, bas@basnieuwenhuizen.nl, cai.huoqing@linux.dev
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Zhongjun Tan <tanzhongjun@coolpad.com>
Subject: [PATCH] drm/amd/display: Fix unsigned expression compared with zero
Date:   Wed,  6 Jul 2022 14:39:51 +0800
Message-Id: <20220706063951.54122-1-hbut_tan@163.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAB3xfo+LsViMSQJNg--.19989S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw4kJFy8Jw4kGry8Ww4xXrb_yoW8JrW7pw
        4fKF1Ygw45XF1Iga4fCF18WFW5Gr93GF4xtrW3Awn8Aw1DAFWUXa4akrWUGa47Wa97uF1S
        y3WDCr47tF1vyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jP739UUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: xkex3sxwdqqiywtou0bp/1tbiWB82xluHzQmvgQAAsB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongjun Tan <tanzhongjun@coolpad.com>

Fix unsigned expression compared with zero

Signed-off-by: Zhongjun Tan <tanzhongjun@coolpad.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 548cdef8a8ad..21e4af38b8c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -244,8 +244,8 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
 	bool req128_c = false;
 	bool surf_linear = (pipe_src_param->sw_mode == dm_sw_linear);
 	bool surf_vert = (pipe_src_param->source_scan == dm_vert);
-	unsigned int log2_swath_height_l = 0;
-	unsigned int log2_swath_height_c = 0;
+	int log2_swath_height_l = 0;
+	int log2_swath_height_c = 0;
 	unsigned int detile_buf_size_in_bytes = mode_lib->ip.det_buffer_size_kbytes * 1024;
 
 	full_swath_bytes_packed_l = rq_param->misc.rq_l.full_swath_bytes;
-- 
2.29.0

