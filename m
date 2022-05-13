Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEA9526B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384333AbiEMUcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384503AbiEMUav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346E81996;
        Fri, 13 May 2022 13:30:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 20D1E1F46491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473803;
        bh=alVT6vQf62mKVLIbN1ZQcw7iCvLKw2erGbicRcgWoFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7/OJULvIcqwg6BCOeOzihRiWBBA1N2k0JlV3VV3gUA558pAkZH8uMs+dxR8TK/VU
         xTGC9GVIWPX0ODnx0xEGeIkXJLKjC2A/97uQDSuJugCBBppKZ7h836g8QkzCynZyvP
         OZPhu2DMF2q7J/6QVvRsEBR/nOeCZW4D08LnKQDSLbHG4ZwjV/c+VFxTz1a/+y/B0v
         YsbXrHTOvLjBgHEclouJ/bKS2men49VFmZgjpDh8ACltoaV9xfN6ZKxfohlar+2BCs
         VjDItssViDl5W3DrGQpLkg8iBaoGzcoLiuWELrzejuOww1qVCOr/nvqsmK1JMfQEhy
         y3xub2XUcvCEA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/20] media: hantro: Stop using H.264 parameter pic_num
Date:   Fri, 13 May 2022 16:29:19 -0400
Message-Id: <20220513202922.13846-18-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
References: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
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

The hardware expects FrameNumWrap or long_term_frame_idx. Picture
numbers are per field, and are mostly used during the memory
management process, which is done in userland. This fixes two
ITU conformance tests:

  - MR6_BT_B
  - MR8_BT_B

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/staging/media/hantro/hantro_h264.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_h264.c b/drivers/staging/media/hantro/hantro_h264.c
index 0b4d2491be3b..228629fb3cdf 100644
--- a/drivers/staging/media/hantro/hantro_h264.c
+++ b/drivers/staging/media/hantro/hantro_h264.c
@@ -354,8 +354,6 @@ u16 hantro_h264_get_ref_nbr(struct hantro_ctx *ctx, unsigned int dpb_idx)
 
 	if (!(dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 		return 0;
-	if (dpb->flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
-		return dpb->pic_num;
 	return dpb->frame_num;
 }
 
-- 
2.34.3

