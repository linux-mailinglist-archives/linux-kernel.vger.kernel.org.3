Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9006480E75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhL2BTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 20:19:21 -0500
Received: from out162-62-57-252.mail.qq.com ([162.62.57.252]:52355 "EHLO
        out162-62-57-252.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235852AbhL2BTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1640740756;
        bh=WvxjNp4mxs5JJlFm50v/ht5B/mXkeVyuR1ccnIuBqUg=;
        h=From:To:Cc:Subject:Date;
        b=eSA0uDDmjYUaw5J2pSIh3aJmqDxKjYY6kWB1yv9/yIxqbziJn98eDLJllZvsMoOyo
         IrRanZ7GoRM1jZGopx3I2rZKLpYrMhW6WP6VvSKON9qjpJR/gM+PYFu8uDgPSqx7Ru
         vtRjjfSRCdLHlwIkSf9aPXD5gd2XZaX3ry/liEGs=
Received: from localhost.localdomain ([159.226.95.43])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 3F08A269; Wed, 29 Dec 2021 09:15:48 +0800
X-QQ-mid: xmsmtpt1640740548tx6pvlod5
Message-ID: <tencent_87FD00188928D6688137C8FA9ECB86180505@qq.com>
X-QQ-XMAILINFO: M3vv73qU6a4uNI9+SWxaWGGCAT51lMsfXjFDT5p3ZY8CFlJYHrlgrUrbYCKEv3
         49R53m7J6Y1kvl3foq55iGpzls7XvuMKwUMURjNeQBPz/lDkxDuH4L28UrEk3C2GkXuAg1BsgOK3
         j6tFeHM3ViDWqufj45q4ZrXiiFA3KQzGqsKQQpCFaL3jtEqmVNRmDmMVe5/mebIU5LZmFvGY3Cjw
         OwC19V5nvIMDzg43MR84f0H+x+f7gs9R/sLtQQXC0VZwzrJGHQnnkcw/hBLPbbhzX4/uuhcURUpk
         eUIvdulErc8nuXZoHdXvhU7NpQWPg/lUong1xH/ZgwUXqWbzEqfKgeD22naJ9mhjQkf9/+Bx/zGd
         BQp+Yct7LHpxU4eidkiMcm57OLFA6p8ZqAk7Cbr9WzTIGGErEkXaXCfgDvlD83hyS1rLgd4v+Q6a
         AhCFXB8VVFXbJB5ttJEySjg9wvExdj6eOndRUEMcXPZM4REOMTVxfmFOXGi67KSndCKMm25OCKoy
         AINJ7srtAOPZY2kqXJ7d5RqgbqZcIEVdMAOiigv1xwURB1xTdIDWfTw9XIHps1mx9rIkziwochPn
         udo1SPZz8W7kj1LDrJ4ORULXslAJBTQ8kAqFESNYa7Rf4nesx03MR2K3DG5xS0BQkuvLjEwMKJT4
         67OL7hLdRFH1nuubfXPf0NZpWfgKY1a6AlA5gPPiSyW9wrxfL69Jkjh6bzNJ09R6zVmnmPGU7mvG
         bH3KNL6eoDBMdwlsfb8qM2lcYj04Nu1S43Ti+D3BI6+mQIBMiYTyaHJ9fw6ZlkTMuzQcBy6tiVhu
         DNpx3UH3HNqk6ck4SWLmwPlKtjtkn/dIZ2Gcjk14ddqf1jZkknXu+F
From:   Peiwei Hu <jlu.hpw@foxmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Peiwei Hu <jlu.hpw@foxmail.com>
Subject: [PATCH] media: ir_toy: free before error exiting
Date:   Wed, 29 Dec 2021 09:15:18 +0800
X-OQ-MSGID: <20211229011518.2973032-1-jlu.hpw@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use goto for error handling instead of returning directly

Signed-off-by: Peiwei Hu <jlu.hpw@foxmail.com>
---
 drivers/media/rc/ir_toy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/ir_toy.c b/drivers/media/rc/ir_toy.c
index 7e98e7e3aace..196806709259 100644
--- a/drivers/media/rc/ir_toy.c
+++ b/drivers/media/rc/ir_toy.c
@@ -458,7 +458,7 @@ static int irtoy_probe(struct usb_interface *intf,
 	err = usb_submit_urb(irtoy->urb_in, GFP_KERNEL);
 	if (err != 0) {
 		dev_err(irtoy->dev, "fail to submit in urb: %d\n", err);
-		return err;
+		goto free_rcdev;
 	}
 
 	err = irtoy_setup(irtoy);
-- 
2.25.1

