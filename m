Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A8655E2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiF0HM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiF0HMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:12:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E7926F2;
        Mon, 27 Jun 2022 00:12:54 -0700 (PDT)
Received: from localhost (dynamic-089-204-138-228.89.204.138.pool.telefonica.de [89.204.138.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E4DEE6601822;
        Mon, 27 Jun 2022 08:12:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656313973;
        bh=LKns0N+pXDiYy8iu2jscLOkCSsGN0DimPC9HxCSoaiE=;
        h=From:To:Cc:Subject:Date:From;
        b=jzo/RzwBWL5gV7LVsER3H4GJOn9KFtthbwLlBMHlKDML+XitBqgFVabHGA1Dn25lw
         IGfjjpmK2OzqHAinnsedmMx61cJ22k0a4SC6vSsWk3oJY8wj4imKlXAxJ8J1ij30WT
         yPLhg1H3504f7cX7JaPw1jCnQq93WbUXoprkUCytE2rOuH64Y27OftTa4Hm9qHfhQT
         TUI7CYGkoHqLg5juqtDroF1Q2AVPJwPQM0YNfQLEg5clL4RGTYo33Ugj+NKIsWmOGI
         uAP6lpxfYlhlvRNXIZKoiIeLxRtyDEXHzux5Y34Wuo94atqjoNOF88/N8QbwOqzrEt
         W2+RujwbtGCAQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: Fix incorrect P010 chroma order description
Date:   Mon, 27 Jun 2022 09:12:23 +0200
Message-Id: <20220627071224.16787-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chroma order of P010 is `CbCr`,
match with the descriptions in `include/uapi/linux/videodev2.h` and the
documentation.

Fixes: 5374d8fb75f31 Add P010 video format

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index e2526701294e..e03362c8aef9 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1306,7 +1306,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
 	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
 	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
-	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
+	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
 	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
 	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;
-- 
2.25.1

