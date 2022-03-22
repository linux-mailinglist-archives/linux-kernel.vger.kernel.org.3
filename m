Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4024E3F77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiCVNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbiCVNZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:25:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A31260D;
        Tue, 22 Mar 2022 06:23:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dmitry.osipenko)
        with ESMTPSA id C68931F44055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647955432;
        bh=UUZgFPZsB8wcF1U1Mz8f6AVwvcWgacxvmEXGc0YZ/vY=;
        h=From:To:Cc:Subject:Date:From;
        b=WKpbgnfNeQ9DyrcI12UfHBreowSfUOHF2rQp2qynaOTsqV8ZvKeBPL9j0Ysz+dFbv
         ev8TnK4xQHXmzmpHUBsUjxWbNpTCBmVvtOVUd7n3vWST3woPEJH9BZ37mD1EVgnCWW
         TrKI6bx8XGxKhECDMzBlcCC/0mcAXlT1JIRpACiilzrQk4J35kSN+9l/xjmgVGZzLx
         KIcSgbmlhQ9sZQa8AgIbfhoB43BnThIKq+jgIfq5KD1FC1+uX0dDSvvkX6ccR8sT2B
         RszIyixlTXDl4+TGv+MhokLSm6jexnd+mCyLETAy51V3Ha5vzSXyMwyb1Bm7sPNr5d
         YnWDZo7NbRvbw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Boris Brezillon <bbrezillon@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Laura Nao <laura.nao@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v1] media: videobuf2: Allow applications customize data offsets of capture buffers
Date:   Tue, 22 Mar 2022 16:23:29 +0300
Message-Id: <20220322132329.6527-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.35.1
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

Use data offsets provided by applications for multi-planar capture
buffers. This allows V4L to import and use dma-bufs exported by other
subsystems in cases where application wants to customize data offsets
of capture buffers in order to meet hardware alignment requirements of
both dma-buf exporter and importer.

This feature is wanted for providing a better support of media hardware
found on Chromebooks. In particular display and camera ISP hardware of
Rockchip and MediaTek SoCs require special handling by userspace because
display h/w has specific alignment requirements that don't match default
alignments expected by V4L and there is a need to customize the data
offsets in case of multi-planar formats.

Some drivers already have preliminary support for data offsets
customization of capture buffers, like NVIDIA Tegra video decoder driver
for example, and V4L allows applications to provide data offsets for
multi-planar output buffers, let's support such customization for the
capture buffers as well.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 Documentation/userspace-api/media/v4l/buffer.rst | 9 ++++++++-
 drivers/media/common/videobuf2/videobuf2-v4l2.c  | 7 +++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/buffer.rst b/Documentation/userspace-api/media/v4l/buffer.rst
index 4638ec64db00..75b1929e2acb 100644
--- a/Documentation/userspace-api/media/v4l/buffer.rst
+++ b/Documentation/userspace-api/media/v4l/buffer.rst
@@ -369,13 +369,20 @@ struct v4l2_plane
       - ``data_offset``
       - Offset in bytes to video data in the plane. Drivers must set this
 	field when ``type`` refers to a capture stream, applications when
-	it refers to an output stream.
+	it refers to an output or capture stream.
 
 	.. note::
 
 	   That data_offset is included  in ``bytesused``. So the
 	   size of the image in the plane is ``bytesused``-``data_offset``
 	   at offset ``data_offset`` from the start of the plane.
+
+	   For capture planes data_offset may be specified by applications
+	   and by drivers. Driver may override application's offset or error
+	   out buffer if offset can't be satisfied by hardware. This allows
+	   applications to customize data offsets of imported dma-bufs.
+	   Handling of application's offsets is driver-dependent, application
+	   must use the resulting buffer offset.
     * - __u32
       - ``reserved[11]``
       - Reserved for future use. Should be zeroed by drivers and
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 6edf4508c636..929107a431cc 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -263,6 +263,13 @@ static int vb2_fill_vb2_v4l2_buffer(struct vb2_buffer *vb, struct v4l2_buffer *b
 						psrc->bytesused : pdst->length;
 				pdst->data_offset = psrc->data_offset;
 			}
+		} else {
+			for (plane = 0; plane < vb->num_planes; ++plane) {
+				struct vb2_plane *pdst = &planes[plane];
+				struct v4l2_plane *psrc = &b->m.planes[plane];
+
+				pdst->data_offset = psrc->data_offset;
+			}
 		}
 	} else {
 		/*
-- 
2.35.1

