Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC13458F721
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiHKE7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbiHKE7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:59:50 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B087CB58;
        Wed, 10 Aug 2022 21:59:47 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 27B4w4gc000522-27B4w4gf000522
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Aug 2022 12:58:08 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Oliver Neukum <oneukum@suse.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+bb25f85e5aa482864dc0@syzkaller.appspotmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: airspy: fix memory leak in airspy probe
Date:   Thu, 11 Aug 2022 12:57:00 +0800
Message-Id: <20220811045701.31152-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

The commit ca9dc8d06ab6 ("media: airspy: respect the DMA coherency
 rules") moves variable buf from stack to heap, however, it only frees
buf in the error handling code, missing deallocation in the success
path.

Fix this by freeing buf in the success path since this variable does not
have any references in other code.

Fixes: ca9dc8d06ab6 ("media: airspy: respect the DMA coherency rules")
Reported-by: syzbot+bb25f85e5aa482864dc0@syzkaller.appspotmail.com
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/media/usb/airspy/airspy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/airspy/airspy.c b/drivers/media/usb/airspy/airspy.c
index 240a7cc56777..7b1c40132555 100644
--- a/drivers/media/usb/airspy/airspy.c
+++ b/drivers/media/usb/airspy/airspy.c
@@ -1070,6 +1070,10 @@ static int airspy_probe(struct usb_interface *intf,
 				ret);
 		goto err_free_controls;
 	}
+
+	/* Free buf if success*/
+	kfree(buf);
+
 	dev_info(s->dev, "Registered as %s\n",
 			video_device_node_name(&s->vdev));
 	dev_notice(s->dev, "SDR API is still slightly experimental and functionality changes may follow\n");
-- 
2.35.1

