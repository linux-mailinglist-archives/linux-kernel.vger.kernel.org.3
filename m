Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D40750FDF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350367AbiDZNB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350322AbiDZNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C317F112;
        Tue, 26 Apr 2022 05:58:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 986A21F43991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977883;
        bh=BQPoxOAZCWnxNCOeZo2D/Nd5xmmLaOzP4aXydtQmwEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCMq/XYI1rT//EaxIr4tzjZMIi9SfAN1J+rxbo0nX1o4jG4rFJlV21qrb532VgoPi
         EEausR1Wl1NSrzYd+jfzayy0oZQjE5BI7jV38EemoScgGvtutOjtfDOghZfLlOdrFD
         a/4lzfJCPQH8WFiU/NWsOdcSzvcXMBcGxuLi/QUOTJUzgjNzTm1kbRZ/5/Z6gp4imz
         Z4JHsvPFxFNCK/NvXo6GVxqx5P3XPJMDaiRVBjtiaqHoH+0YGlzIrtBfU4nyLOF0Xo
         KRJ+jm1IBdnAFnMDJups+8ryQ8pIHfokEdpjIqk7b4h59bl8YB0PQw7s6Q6lqWjX9q
         wMAE8nt1ra+QQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/24] media: videobuf2-v4l2: Warn on holding buffers without support
Date:   Tue, 26 Apr 2022 08:57:29 -0400
Message-Id: <20220426125751.108293-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
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

