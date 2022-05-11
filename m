Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171E3523163
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiEKLXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236759AbiEKLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:23:07 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DE2D21B179
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=B0dnG
        fiHXPq1n0V7Jsi0dZM7lOgcpwaB3P9VpDq1GxI=; b=O1tEpuRkOUIr4BzSKpnWO
        VEkdn+lNSQiOqMOYFV87gC530sLDYGkedKI8KXZmVo8ex14RjtBXcHDJQFQoS805
        nioDNZyECpAAAsrArrh0KMhSNzJSiQiXi9B+u7I4ZNABRfRYFLeQCRPggGMwir7w
        u+pHrZkuRbsU1nNIdEvgGE=
Received: from ubuntu.localdomain (unknown [58.213.83.157])
        by smtp3 (Coremail) with SMTP id DcmowAC3yZpPnHtiu6XLBQ--.48916S4;
        Wed, 11 May 2022 19:21:52 +0800 (CST)
From:   Bernard Zhao <zhaojunkui2008@126.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bernard Zhao <zhaojunkui2008@126.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] staging/rtl8712: fix potential memory leak
Date:   Wed, 11 May 2022 04:21:44 -0700
Message-Id: <20220511112147.753316-1-zhaojunkui2008@126.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowAC3yZpPnHtiu6XLBQ--.48916S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF47uw4UAr1fCrWrJrW5KFg_yoWrWr1kpF
        43C3s0krWkXrn5Grsrtr1UZFn5AaykuF4qkaySqw1S9F18Arn8t34DCrya9r4UAFWvy345
        AF1DJryv9ryDJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zix9N3UUUUU=
X-Originating-IP: [58.213.83.157]
X-CM-SenderInfo: p2kd0y5xqn3xasqqmqqrswhudrp/1tbiuRD9qlpD86ItSQAAsS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is found by google syzbot, the link is:
https://syzkaller.appspot.com/bug?id=3a325b8389fc41c1bc94de0f4ac437ed13cce584
memory leak log:
BUG: memory leak
unreferenced object 0xffff88810ff9b3c0 (size 192):
  comm "kworker/0:2", pid 3653, jiffies 4294942228 (age 8.250s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 d8 b3 f9 0f 81 88 ff ff  ................
  backtrace:
    [<00000000e0748eb7>] usb_alloc_urb+0x66/0xe0
    [<00000000fe5a9432>] r8712_os_recvbuf_resource_alloc+0x1b/0x80
    [<00000000923fed72>] r8712_init_recv_priv+0x96/0x210
    [<000000000038512f>] _r8712_init_recv_priv+0x134/0x150
    [<0000000066e70a4e>] r8712_init_drv_sw+0xa0/0x1d0
    [<000000001d2974c0>] r871xu_drv_init.cold+0x104/0x7d1
    [<000000001d449ce2>] usb_probe_interface+0x177/0x370
    [<00000000cd123d34>] really_probe+0x159/0x4a0
    [<00000000364585cc>] driver_probe_device+0x84/0x100
    [<0000000048b74bde>] __device_attach_driver+0xee/0x110
    [<00000000c358ab15>] bus_for_each_drv+0xb7/0x100
    [<00000000bfa9b076>] __device_attach+0x122/0x250
    [<0000000048fe302a>] bus_probe_device+0xc6/0xe0
    [<000000002ceae175>] device_add+0x5be/0xc30
    [<00000000e4813a0d>] usb_set_configuration+0x9d9/0xb90
    [<00000000cbb8c98f>] usb_generic_driver_probe+0x8c/0xc0

For this issue，I see that the following call sequence causing
some memory leaks:
usb_probe_interface
 r871xu_drv_init
  r8712_init_drv_sw
   _r8712_init_recv_priv
    r8712_init_recv_priv//void type function
     for (i = 0; i < NR_RECVBUFF;
      if (r8712_os_recvbuf_resource_alloc(padapter, precvbuf))
       r8712_os_recvbuf_resource_alloc
        precvbuf->purb = usb_alloc_urb
         kmalloc

       break;// if error branch. Here may be some memory leak,
             // break directly after r8712_os_recvbuf_resource_alloc
             // fail, and no cleanup operation is done.

And also the size of the memory leak can be seen in the log is
192 bytes, I check the size of the usb_alloc_urb application is
usb_alloc_urb(0,
 -> kmalloc(struct_size(urb, iso_frame_desc, iso_packets))
  -> sizeof(struct urb)+iso_packets*sizeof(struct iso_frame_desc)
iso_packets is 0, so the size of the actual application is
sizeof(struct urb) -> the calculation result is 192, which matches
the size of the leak point.

After that cleanup, the precvbuf->purb maybe used for long time
So I add kmemleak_not_leak to avoid false positive report.

This patch syzbot test OK:
2022/05/11 06:15 14m zhaojunkui2008@126.com patch upstream OK

Signed-off-by: Bernard Zhao <zhaojunkui2008@126.com>
Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index 0ffb30f1af7e..8bf8e6d5b005 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -19,6 +19,7 @@
 #include <linux/if_ether.h>
 #include <linux/ip.h>
 #include <net/cfg80211.h>
+#include <linux/kmemleak.h>
 
 #include "osdep_service.h"
 #include "drv_types.h"
@@ -51,12 +52,20 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
 	for (i = 0; i < NR_RECVBUFF; i++) {
 		INIT_LIST_HEAD(&precvbuf->list);
 		spin_lock_init(&precvbuf->recvbuf_lock);
-		if (r8712_os_recvbuf_resource_alloc(padapter, precvbuf))
+		if (r8712_os_recvbuf_resource_alloc(padapter, precvbuf)) {
+			int j = i;
+
+			while (j-- > 0) {
+				r8712_os_recvbuf_resource_free(padapter, precvbuf);
+				precvbuf--;
+			}
 			break;
+		}
 		precvbuf->ref_cnt = 0;
 		precvbuf->adapter = padapter;
 		list_add_tail(&precvbuf->list,
 			      &(precvpriv->free_recv_buf_queue.queue));
+		kmemleak_not_leak(precvbuf->purb);
 		precvbuf++;
 	}
 	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
-- 
2.33.1

