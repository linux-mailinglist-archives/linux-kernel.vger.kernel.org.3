Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEA2473C33
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 05:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhLNExw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 23:53:52 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:30177 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLNExv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 23:53:51 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BE4SSVb001929;
        Tue, 14 Dec 2021 12:28:28 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from JammyHuang-PC.aspeed.com (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Dec
 2021 12:53:47 +0800
From:   Jammy Huang <jammy_huang@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <mchehab@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <linux-media@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] media: aspeed: Fix no complete irq for non-64-aligned width
Date:   Tue, 14 Dec 2021 12:53:48 +0800
Message-ID: <20211214045348.13702-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BE4SSVb001929
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ast2500, engine will stop occasionally for 1360x768.

This is a bug which has been addressed, but the workaround is specific
for 1680 only. Here we make it more complete.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed-video.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 793b2adaa0f5..4d3e6b105d44 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1055,18 +1055,20 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 	/* Set capture/compression frame sizes */
 	aspeed_video_calc_compressed_size(video, size);
 
-	if (video->active_timings.width == 1680) {
+	if (!IS_ALIGNED(act->width, 64)) {
 		/*
 		 * This is a workaround to fix a silicon bug on A1 and A2
 		 * revisions. Since it doesn't break capturing operation of
 		 * other revisions, use it for all revisions without checking
-		 * the revision ID. It picked 1728 which is a very next
-		 * 64-pixels aligned value to 1680 to minimize memory bandwidth
+		 * the revision ID. It picked new width which is a very next
+		 * 64-pixels aligned value to minimize memory bandwidth
 		 * and to get better access speed from video engine.
 		 */
+		u32 width = ALIGN(act->width, 64);
+
 		aspeed_video_write(video, VE_CAP_WINDOW,
-				   1728 << 16 | act->height);
-		size += (1728 - 1680) * video->active_timings.height;
+				   width << 16 | act->height);
+		size = width * act->height;
 	} else {
 		aspeed_video_write(video, VE_CAP_WINDOW,
 				   act->width << 16 | act->height);
-- 
2.25.1

