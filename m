Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2675849DEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiA0KJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238785AbiA0KJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:09:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BCC061714;
        Thu, 27 Jan 2022 02:09:55 -0800 (PST)
Received: from tatooine.ideasonboard.com (unknown [IPv6:2a01:e0a:169:7140:5181:dd0b:bfdb:a530])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F3A249C;
        Thu, 27 Jan 2022 11:09:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643278192;
        bh=/fGvvkR4Sa0NHwILdZ9hjvMmpD9G6PKyPaotRM6R0Dk=;
        h=From:To:Cc:Subject:Date:From;
        b=FP7MtAEKDCg24bCxr9RiDyJ47qgQ2eSRZdP3PkImteGlSZ3dVmndENtJI5+cKc5lo
         niB5fZNCbDfIix3g/kz6hY73JSrWctLMJ7zdSs0PFSg+MvtKxak6sOZyvNBJS07p12
         weMhR1F6LM5cZ/Qp4hMuKwjvWR3mVuxoOtCkNVCA=
From:   Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     lars@metafoo.de, mchehab@kernel.org, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Subject: [PATCH] media: adv7180: Fix media bus format
Date:   Thu, 27 Jan 2022 11:09:47 +0100
Message-Id: <20220127100947.150555-1-jeanmichel.hautbois@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MEDIA_BUS_FMT_UYVY8_2X8 isn't correct for CSI-2. Use
MEDIA_BUS_FMT_UYVY8_1X16 instead.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
---
 drivers/media/i2c/adv7180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index d9a99fcfacb1..cbededfb6b3f 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -655,7 +655,7 @@ static int adv7180_enum_mbus_code(struct v4l2_subdev *sd,
 	if (code->index != 0)
 		return -EINVAL;
 
-	code->code = MEDIA_BUS_FMT_UYVY8_2X8;
+	code->code = MEDIA_BUS_FMT_UYVY8_1X16;
 
 	return 0;
 }
@@ -665,7 +665,7 @@ static int adv7180_mbus_fmt(struct v4l2_subdev *sd,
 {
 	struct adv7180_state *state = to_state(sd);
 
-	fmt->code = MEDIA_BUS_FMT_UYVY8_2X8;
+	fmt->code = MEDIA_BUS_FMT_UYVY8_1X16;
 	fmt->colorspace = V4L2_COLORSPACE_SMPTE170M;
 	fmt->width = 720;
 	fmt->height = state->curr_norm & V4L2_STD_525_60 ? 480 : 576;
-- 
2.32.0

