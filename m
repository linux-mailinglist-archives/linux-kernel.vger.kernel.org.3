Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E1E4F51E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389237AbiDFC0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiDEVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:17:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0D470F5A;
        Tue,  5 Apr 2022 13:44:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id D73C21F4480B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191483;
        bh=CR0Uld+xP65yR8nRZHFwyooNDEbFE3R+SnqsqiS63yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1zrHd5GzMeP0J2r7wzyt2CkELpIBsCmOdeHajueB6w5uHTNNWbd4xrBwSg190YC+
         qY9zVQtj18o/NTCY0jLPY85TF3yzf+XJO0Elce1b+V1heD0cWT4ysV67/1xCV8TU+2
         5rTXQRQdJ4AtPATChiiDib8i2siED0BdVw4mVnKHzVdlF001F7tVA0twPF3TzhVMfX
         hkyvfIM3+cp1smEMdMkdVj5LR7+sVunPEGagcRiTLsB/E7je3yWVONTlMyGV1oSzlf
         GM/XRLeNlsAeZlHDlOyf91V1mmnhgBrzISaxJyW3Tx+XjXdbkk7DSE759UZxiwIs0f
         zhMWWNLlKKXNQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org
Subject: [PATCH v3 02/24] media: v4l2-mem2mem: Trace on implicit un-hold
Date:   Tue,  5 Apr 2022 16:44:03 -0400
Message-Id: <20220405204426.259074-3-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
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

If the timestamp of the src buffer differs from the timestamp of a held
dst buffer, the held buffer is implicitly removed and marked as done.
Add a trace to help debugging if someone hits that case.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 675e22895ebe..d1d29d6ab024 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -336,6 +336,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 	if (src && dst && dst->is_held &&
 	    dst->vb2_buf.copied_timestamp &&
 	    dst->vb2_buf.timestamp != src->vb2_buf.timestamp) {
+		dprintk("Timestamp mismatch, returning held capture buffer\n");
 		dst->is_held = false;
 		v4l2_m2m_dst_buf_remove(m2m_ctx);
 		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_DONE);
-- 
2.34.1

