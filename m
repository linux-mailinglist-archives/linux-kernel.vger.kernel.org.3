Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921A950FE18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350346AbiDZNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350315AbiDZNBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38417E21D;
        Tue, 26 Apr 2022 05:58:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 357771F4398F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977882;
        bh=CR0Uld+xP65yR8nRZHFwyooNDEbFE3R+SnqsqiS63yI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfUx0XBD1y7yy1+Nfm9IpGmZ9onovXxyqFs5+/7/NUnbcF92hMSndIS3Bw49UATy3
         MiDj9S6OLVmUMPZOmD5YMFCChSuuDUnaV3nOtlmdrptn6WlGZMQUXCGVcnxi1a0QYx
         TjdKAhI5PkBqat5/wCZfnKT3vvvYNYMpxCnDeuKOfBldx7Djsyo1ulZybWEU4NLt1N
         KMMQUrp55POy6wnaFDscb7yiMUJYe6Ny68u/rDSv3qhUZIVYpPZg4jNVvQEkXv/z/a
         eI3NGaO5BK+yf4XWoaErYP+zpvEbtmZcjYmCoIsbCBIkd+sZdbtVBre7WihsX0yYAh
         wjaaZAMkzOxPA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/24] media: v4l2-mem2mem: Trace on implicit un-hold
Date:   Tue, 26 Apr 2022 08:57:28 -0400
Message-Id: <20220426125751.108293-3-nicolas.dufresne@collabora.com>
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

