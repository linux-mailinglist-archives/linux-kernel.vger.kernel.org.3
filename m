Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A0149DBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiA0Hrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:47:52 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:35201 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237484AbiA0Hru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:47:50 -0500
X-UUID: 9c316d2c6932470e8201b3f3e6b85e66-20220127
X-CPASD-INFO: ffe746053608457fb7a2ff90aa18ca17@r7afV2FoXmVfVnKEg3iCoIJokWKWkll
        _o5tRaJGRXVeVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3taifV2RkYA==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: ffe746053608457fb7a2ff90aa18ca17
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:224.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:98.0,IP:-2.0,MAL:0.0,ATTNUM:0.
        0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CFO
        B:0.0,SPC:0.0,SIG:-5,AUF:106,DUF:31942,ACD:176,DCD:278,SL:0,AG:0,CFC:0.38,CFS
        R:0.058,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 9c316d2c6932470e8201b3f3e6b85e66-20220127
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: 9c316d2c6932470e8201b3f3e6b85e66-20220127
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2133356184; Thu, 27 Jan 2022 16:00:26 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxiujiang@kylinos.cn
Subject: [PATCH] usb: atm: Make use of the helper macro kthread_run()
Date:   Thu, 27 Jan 2022 15:47:44 +0800
Message-Id: <20220127074744.845537-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Repalce kthread_create/wake_up_process() with kthread_run()
to simplify the code.

Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
---
 drivers/usb/atm/usbatm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index e3a49d837609..24ba739a85e0 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -976,7 +976,7 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
 {
 	struct task_struct *t;
 
-	t = kthread_create(usbatm_do_heavy_init, instance, "%s",
+	t = kthread_run(usbatm_do_heavy_init, instance, "%s",
 			instance->driver->driver_name);
 	if (IS_ERR(t)) {
 		usb_err(instance, "%s: failed to create kernel_thread (%ld)!\n",
@@ -985,7 +985,6 @@ static int usbatm_heavy_init(struct usbatm_data *instance)
 	}
 
 	instance->thread = t;
-	wake_up_process(t);
 	wait_for_completion(&instance->thread_started);
 
 	return 0;
-- 
2.30.0

