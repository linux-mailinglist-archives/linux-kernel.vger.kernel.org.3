Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79614EE1D6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiCaTjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240779AbiCaTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D9B2102AA;
        Thu, 31 Mar 2022 12:37:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 300941F4724D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755458;
        bh=RrVHdlTOtkGYblUxkaOs8WkHp5+WDfAbFJ5ZboXk3tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zi8EIAxPwcX4aRMfL7d91NXXfjHGmzyE7d5YlfyJFimNZvfte0AFF3kdVetq7/jQ8
         SHDzIqgSlp2U00OIVmZUryvMOarEIl6hNXGTTe2rsUlfHFyKM/TNiv83qUAwxYWitU
         e0LshldRfnvfBzvDTNH2D6HtkKqnSlgfIkvieLX9ue+aomb27kFQtzbw5J2A5nc5rm
         6zWLF3OsMNlBEw0g17XjwClK2DV1qlRv98JTZ8JLxGM78tky9EN9A94slez3cccAIf
         gZCq/VpQ35UM2JUiwA+BLBZDMqCGulg1UDpMOd+2bXLBVmefG71lYvC/ycd8+j/5x7
         cIjSRNUvOnj3w==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/23] media: videobuf2-v4l2: Warn on holding buffers without support
Date:   Thu, 31 Mar 2022 15:37:05 -0400
Message-Id: <20220331193726.289559-4-nicolas.dufresne@collabora.com>
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

From: Sebastian Fricke <sebastian.fricke@collabora.com>

Using V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF flag without specifying the
subsystem flag VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF, results in
silently ignoring it.
Warn the user via a debug print when the flag is requested but ignored
by the videobuf2 framework.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 6edf4508c636..812c8d1962e0 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -329,8 +329,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 		 */
 		vbuf->flags &= ~V4L2_BUF_FLAG_TIMECODE;
 		vbuf->field = b->field;
-		if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF))
+		if (!(q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF)) {
+			if (vbuf->flags & V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF)
+				dprintk(q, 1,
+					"Request holding buffer (%d), unsupported on output queue\n",
+					b->index);
 			vbuf->flags &= ~V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF;
+		}
 	} else {
 		/* Zero any output buffer flags as this is a capture buffer */
 		vbuf->flags &= ~V4L2_BUFFER_OUT_FLAGS;
-- 
2.34.1

