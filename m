Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D053B327
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiFBFvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 01:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiFBFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 01:51:13 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4FF2AA019;
        Wed,  1 Jun 2022 22:51:10 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 2525oSaA027428-2525oSaD027428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 2 Jun 2022 13:50:32 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        gushengxian <gushengxian@yulong.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Johan Hovold <johan@kernel.org>,
        Oliver Neukum <oneukum@suse.com>, Sean Young <sean@mess.org>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: flexcop-usb: fix sanity check of bNumEndpoints
Date:   Thu,  2 Jun 2022 13:50:24 +0800
Message-Id: <20220602055027.849014-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
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

Commit d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type
") adds a sanity check for endpoint[1], but fails to modify the sanity
check of bNumEndpoints.

Fix this by modifying the sanity check of bNumEndpoints to 2.

Fixes: d725d20e81c2 ("media: flexcop-usb: sanity checking of endpoint type")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/media/usb/b2c2/flexcop-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 7835bb0f32fc..eb54bfdda01f 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -509,7 +509,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 		return ret;
 	}
 
-	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
+	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 2)
 		return -ENODEV;
 	if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[1].desc))
 		return -ENODEV;
-- 
2.25.1

