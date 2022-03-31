Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7523C4EE1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbiCaTjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbiCaTj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:39:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4351F160C;
        Thu, 31 Mar 2022 12:37:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id E0A2B1F4724B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648755456;
        bh=RzISFmgzdgSdtW0+/gjxICIzsCqQWUTem2X0Qdl07rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8JxZJhCDdx9Qxk6/3g0ArBQAL6zq/4nDv4o4se2D/r8x9FqDSTG1Gmclg/ipJvOd
         QVlZiS09IZSS6knovbP88HF2IV7HrZE1F3rhavI2rX4E0451TzvLMBrUwygzg1GjGI
         irNuFE3v7ose8uwUbKL2ZQSLKbjzcElTY/HxaeP2BDXzjK85i+gTlt8+YOVA47lGj6
         7d+S7kJOkvLXM5m7rWGukhvKJ9TAGX/mCC6sFzvZCD+1PsYD2j/I2gdHM/oH4ueAsy
         aKVOeo7LNLz2HOR4LEw51uhN5GKXsZa77yUZ14AZ1Bgg11PvsIE/kVhKqYEApsz9Cg
         DE6LjQf5fnoCw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/23] media: v4l2-mem2mem: Trace on implicit un-hold
Date:   Thu, 31 Mar 2022 15:37:04 -0400
Message-Id: <20220331193726.289559-3-nicolas.dufresne@collabora.com>
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

If the timestamp of the src buffer differs from the timestamp of a held
dst buffer, the held buffer is implicitly removed and marked as done.
Add a trace to help debugging if someone hits that case.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 675e22895ebe..fbcd79763e8f 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -336,6 +336,7 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
 	if (src && dst && dst->is_held &&
 	    dst->vb2_buf.copied_timestamp &&
 	    dst->vb2_buf.timestamp != src->vb2_buf.timestamp) {
+		dprintk("src and dst timestamp mismatch, removing held capture buffer.\n");
 		dst->is_held = false;
 		v4l2_m2m_dst_buf_remove(m2m_ctx);
 		v4l2_m2m_buf_done(dst, VB2_BUF_STATE_DONE);
-- 
2.34.1

