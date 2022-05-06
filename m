Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F263551D727
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391591AbiEFMDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385170AbiEFMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:03:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F72D59305
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:59:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so6679201pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqJiXmf/yR4F5NdPu8U00YuMrcdHySiedhjp2AtvKqY=;
        b=AXPcpbVvE9CtwugDeEOIv/vX7bF9/PoiIn5DGX/teXTfrMjcjWyeiJkEHipJUfUEKz
         BRpv6fFaUisXjToCVnHP2HAyES2YfmS6NV7WT/vJ5FwF5jm7n1dNFCKjhLWjcKX2pf9L
         iSP5Dh+jFr8/dkGxK73TgTysXEQ2xhpePPCyEqzMDXXzIpku6VyRMaE79uJ0ZCz37pqS
         bkPudPlYYlo+2Nt7A4CNwKmk+1sGHrSSRvsNcGexDTAf5t4gbbts74JDqLqPkImR0Xz7
         2vWuM8qKcmWGYAHIkanBC/Pw6nBHmatnSF1TcLiy8orco4VPi+oRbv78jimhp4rMIzRe
         +wDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqJiXmf/yR4F5NdPu8U00YuMrcdHySiedhjp2AtvKqY=;
        b=1nRdTMTAIHg4KzC6+Cy52vT6+1jkOU/+Ys2pB7JOQnQA7AG3Wg9oDKhfoNz6LGEMVf
         6tUCaByBpcAu3T8OTJcL/AOAnsIcY9jc2MGJkzVYoLhZP9SC7XTVGLt3xiTkOfNDIVqP
         4hzfxmVa69aPZt0j9jHkjUwiab2kI0zqqy8bH/VTBY5TfI89qRKHPY7ZdrEWSviexRcC
         4ndfrbSvJtt+G7Oyh+rIuR6LQBi6JdIVdznsmI5P53M6sOOu0eKTim+clVpTWHN16oDx
         kyw5wyaV0x5BO0PTL5EpPkzGXlYIpKVO4lTvZvOQlEjT3SRA7IU26SfxcC017lzYS2V+
         QjIg==
X-Gm-Message-State: AOAM533fygb7SHSIGAFZRiUDdwQ7t34AEumA9xZ8yHDs4EwI95FTr+sZ
        dGJ9t+nAYZgsLJz2J0JAtPY=
X-Google-Smtp-Source: ABdhPJz5yQHjfhioE4maKHg7mVcei4mTA2n1AmNlN7k+xCgP+acfvZkoiI/xRrjuKzHHLyyfeIezKg==
X-Received: by 2002:a17:90b:610:b0:1d9:4008:cfee with SMTP id gb16-20020a17090b061000b001d94008cfeemr3813211pjb.71.1651838388082;
        Fri, 06 May 2022 04:59:48 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id ck3-20020a17090afe0300b001cd4989feebsm7075501pjb.55.2022.05.06.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 04:59:47 -0700 (PDT)
Date:   Fri, 6 May 2022 19:59:42 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: rtl8712: fix uninit-value in usb_read8() and
 friends
Message-ID: <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651833575.git.wanngchenng@gmail.com>
References: <cover.1651833575.git.wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651833575.git.wanngchenng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When r8712_usbctrl_vendorreq() returns negative, 'data' in
usb_read{8,16,32} will not be initialized.

BUG: KMSAN: uninit-value in string_nocheck lib/vsprintf.c:643 [inline]
BUG: KMSAN: uninit-value in string+0x4ec/0x6f0 lib/vsprintf.c:725
 string_nocheck lib/vsprintf.c:643 [inline]
 string+0x4ec/0x6f0 lib/vsprintf.c:725
 vsnprintf+0x2222/0x3650 lib/vsprintf.c:2806
 va_format lib/vsprintf.c:1704 [inline]
 pointer+0x18e6/0x1f70 lib/vsprintf.c:2443
 vsnprintf+0x1a9b/0x3650 lib/vsprintf.c:2810
 vprintk_store+0x537/0x2150 kernel/printk/printk.c:2158
 vprintk_emit+0x28b/0xab0 kernel/printk/printk.c:2256
 dev_vprintk_emit+0x5ef/0x6d0 drivers/base/core.c:4604
 dev_printk_emit+0x1dd/0x21f drivers/base/core.c:4615
 __dev_printk+0x3be/0x440 drivers/base/core.c:4627
 _dev_info+0x1ea/0x22f drivers/base/core.c:4673
 r871xu_drv_init+0x1929/0x3070 drivers/staging/rtl8712/usb_intf.c:401
 usb_probe_interface+0xf19/0x1600 drivers/usb/core/driver.c:396
 really_probe+0x6c7/0x1350 drivers/base/dd.c:621
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:752
 driver_probe_device drivers/base/dd.c:782 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:899
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:970
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1017
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487
 device_add+0x1fff/0x26e0 drivers/base/core.c:3405
 usb_set_configuration+0x37e9/0x3ed0 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0x13c/0x300 drivers/usb/core/generic.c:238
 usb_probe_device+0x309/0x570 drivers/usb/core/driver.c:293
 really_probe+0x6c7/0x1350 drivers/base/dd.c:621
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:752
 driver_probe_device drivers/base/dd.c:782 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:899
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:970
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1017
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487
 device_add+0x1fff/0x26e0 drivers/base/core.c:3405
 usb_new_device+0x1b91/0x2950 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5363 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
 port_event drivers/usb/core/hub.c:5665 [inline]
 hub_event+0x58e3/0x89e0 drivers/usb/core/hub.c:5747
 process_one_work+0xdb6/0x1820 kernel/workqueue.c:2289
 worker_thread+0x10d0/0x2240 kernel/workqueue.c:2436
 kthread+0x3c7/0x500 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Local variable data created at:
 usb_read8+0x5d/0x130 drivers/staging/rtl8712/usb_ops.c:33
 r8712_read8+0xa5/0xd0 drivers/staging/rtl8712/rtl8712_io.c:29

Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
---
 drivers/staging/rtl8712/usb_ops.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_ops.c b/drivers/staging/rtl8712/usb_ops.c
index e64845e6adf3..af9966d03979 100644
--- a/drivers/staging/rtl8712/usb_ops.c
+++ b/drivers/staging/rtl8712/usb_ops.c
@@ -29,7 +29,8 @@ static u8 usb_read8(struct intf_hdl *intfhdl, u32 addr)
 	u16 wvalue;
 	u16 index;
 	u16 len;
-	__le32 data;
+	int status;
+	__le32 data = 0;
 	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
@@ -37,8 +38,10 @@ static u8 usb_read8(struct intf_hdl *intfhdl, u32 addr)
 	index = 0;
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 1;
-	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
-				requesttype);
+	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
+					 &data, len, requesttype);
+	if (status < 0)
+		return 0;
 	return (u8)(le32_to_cpu(data) & 0x0ff);
 }
 
@@ -49,7 +52,8 @@ static u16 usb_read16(struct intf_hdl *intfhdl, u32 addr)
 	u16 wvalue;
 	u16 index;
 	u16 len;
-	__le32 data;
+	int status;
+	__le32 data = 0;
 	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
@@ -57,8 +61,10 @@ static u16 usb_read16(struct intf_hdl *intfhdl, u32 addr)
 	index = 0;
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 2;
-	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
-				requesttype);
+	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
+					 &data, len, requesttype);
+	if (status < 0)
+		return 0;
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
@@ -69,7 +75,8 @@ static u32 usb_read32(struct intf_hdl *intfhdl, u32 addr)
 	u16 wvalue;
 	u16 index;
 	u16 len;
-	__le32 data;
+	int status;
+	__le32 data = 0;
 	struct intf_priv *intfpriv = intfhdl->pintfpriv;
 
 	request = 0x05;
@@ -77,8 +84,10 @@ static u32 usb_read32(struct intf_hdl *intfhdl, u32 addr)
 	index = 0;
 	wvalue = (u16)(addr & 0x0000ffff);
 	len = 4;
-	r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
-				requesttype);
+	status = r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
+					 &data, len, requesttype);
+	if (status < 0)
+		return 0;
 	return le32_to_cpu(data);
 }
 
-- 
2.33.1

