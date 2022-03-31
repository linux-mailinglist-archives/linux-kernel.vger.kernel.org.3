Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7CC4EE1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiCaTlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbiCaTkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:40:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103D23F9F5;
        Thu, 31 Mar 2022 12:38:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 092A01F47266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755489;
        bh=rqMU1/6TJ46L9lH5r2+bP74ysDX3ywT+LO6k1I+k3Bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9lbdHIAvXLk56s++dH+TARP3iPn8nxqBL43DHyHw063RYlN3TCEBrYyFCaE0LiP9
         rGMCV/SOgX8KwJWC0Ihv8exLfF4D8ER9ORtY2rTYGBsSItbcvqnQ5llHSkSUZVXoMS
         qHB12chJCWDhbw6Zk4uEgSXS/d5TG3qw8AcPV1Xms2x0QfbvlRddxzfwndEv4IRobN
         HbrG8GRarM6+xbaMW2Y11TsETJMU5FD6WJXUYvJZgavz2rdNrCpgElXJ5loFoJHXFM
         14rhrTNPNloz9KXCVzwnj+l+7fT+t3D/KrlFV4mjrMDvLo1udPFCKEpk41R+gSXuLA
         qfu1iCs6k1FhQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/23] media: hantro: Stop using H.264 parameter pic_num
Date:   Thu, 31 Mar 2022 15:37:23 -0400
Message-Id: <20220331193726.289559-22-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
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
2.34.1

