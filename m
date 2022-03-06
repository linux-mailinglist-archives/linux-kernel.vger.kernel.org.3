Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E234CED10
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 19:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiCFSJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 13:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiCFSJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 13:09:06 -0500
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFE10FC6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 10:08:13 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id QvIenSw8RqMVEQvIfn0MA6; Sun, 06 Mar 2022 19:08:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 06 Mar 2022 19:08:12 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: [PATCH] media: aspeed: Fix an error handling path in aspeed_video_probe()
Date:   Sun,  6 Mar 2022 19:08:07 +0100
Message-Id: <7d1f5e853bccba4a70294d81419a0cf21ff91f41.1646590067.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dma_free_coherent() call is missing in the error handling path of the
probe, as already done in the remove function.

In fact, this call is included in aspeed_video_free_buf(). So use the
latter both in the error handling path of the probe and in the remove
function.
It is easier to see the relation with aspeed_video_alloc_buf() this way.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/media/platform/aspeed-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 51fb18453b81..e0b5d416b6ee 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1933,6 +1933,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
+		aspeed_video_free_buf(video, &video->jpeg);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
@@ -1964,8 +1965,7 @@ static int aspeed_video_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(v4l2_dev);
 
-	dma_free_coherent(video->dev, VE_JPEG_HEADER_SIZE, video->jpeg.virt,
-			  video->jpeg.dma);
+	aspeed_video_free_buf(video, &video->jpeg);
 
 	of_reserved_mem_device_release(dev);
 
-- 
2.32.0

