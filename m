Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB654EE1F4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239582AbiCaTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbiCaTjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52546240581;
        Thu, 31 Mar 2022 12:38:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 006D21F47261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755482;
        bh=L/IEg8/gRB+ksIPpqGEbacLI5hKb4dkPkUIdTUf313k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/QXCvRIJgWwkAyOdtpt3s+KdDjWzN0fnPFot3fGjyCOCG30P5KLMKziHPG2YxxPu
         DCoIhPqN3ATybHM3LGenjmN6zIDzeqdiPnoipRBZ/XkCZKVB2azOdDKNRk3MjVN99i
         CVw8tH6n6PiMGaBeQOpGOtIGhigO8Ec5KFKEk//TOgFm99TVrRqxl1wB4+W4Xb01JF
         g85nox2wUHoGKIVDmso4qQPZJcCvzKO85vJmaLJRxLuNvbSXjg3f6r03C/Ns/7edvC
         daZGOIkiSguY/SqYhgNZ7N18UdZ97Y0Kso0OcjYhay8Wz7oC36QCaQnt8y7+bk83OK
         8r1MuPnkntV7Q==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/23] media: rkvdec: Enable capture buffer holding for H264
Date:   Thu, 31 Mar 2022 15:37:19 -0400
Message-Id: <20220331193726.289559-18-nicolas.dufresne@collabora.com>
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

In order to support interlaced video decoding, the driver must
allow holding the capture buffer so that the second field can
be decoded into it.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 4 ++++
 drivers/staging/media/rkvdec/rkvdec.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 1b805710e195..b6376eaa92d7 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -148,6 +148,7 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
 		.ops = &rkvdec_h264_fmt_ops,
 		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
 		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
+		.subsystem_flags = VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
@@ -404,6 +405,9 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
 	cap_fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
 	cap_fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
 
+	/* Enable format specific queue features */
+	vq->subsystem_flags |= desc->subsystem_flags;
+
 	return 0;
 }
 
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 2f4ea1786b93..e37f1a015fa0 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -81,6 +81,7 @@ struct rkvdec_coded_fmt_desc {
 	const struct rkvdec_coded_fmt_ops *ops;
 	unsigned int num_decoded_fmts;
 	const u32 *decoded_fmts;
+	u32 subsystem_flags;
 };
 
 struct rkvdec_dev {
-- 
2.34.1

