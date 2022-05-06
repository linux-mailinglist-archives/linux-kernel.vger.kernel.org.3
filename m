Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338851CF48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388470AbiEFDTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388465AbiEFDTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:19:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA0A11A0D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:15:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id iq10so5919268pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GqJiXmf/yR4F5NdPu8U00YuMrcdHySiedhjp2AtvKqY=;
        b=PJJNQHdLyFyNubBFfaWLnlkskNGMNgu0yYgM/qmqXrlWzpeaHdP2uFu9ZZISlW4Hh/
         68WhcO/GRuP3kT3IePXEaqzb3wji0oCzgjapsgzvpg10alklCudp3UiJfq1mvlP+UB7p
         kF+4GoNvYGS74Fs/h52uhJCSjj3pVasX3ZvZDs81arpqzLPQK6QV90dR0cACLXoJpUFw
         +WdzOY5gUgKTwgRznb/OmETm5jcW0X6FO5kSEGMfimRoYf93aZ9x/3bVgKqu6+fYFh3I
         VWCo1oxLmevEOExzylzCjOS2oKkYvX1a4wZ0jOvNOiCrj9lb7LLAJkJL46Ele+vu7JyA
         NCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GqJiXmf/yR4F5NdPu8U00YuMrcdHySiedhjp2AtvKqY=;
        b=yJ72m7o7SGE9BeIwOqu/Zo5UZ3ENwVtlbq9ViS73AhHj7tblW0hBRiBKnHupeDr8tN
         9jBumQqj+UxZWhElyJ4ckAhzgcles8kbWYstekTvt5Nmk1s13923PZp1W6e2OTzxFjPi
         /vi/8GywgN5fX2i/t8sBWbqf6D/y2Q7mMxgoXyzJ29l4QoE+k5G5XprQb9f/ZJxXpSi/
         YmyEGpnJtxwxsjcIEek8iOPtKgBibrkamhA+Y3eiA0LpdA0GL+nnmGKvyMrLO7ryJZMr
         +IuclSiiOEWYryR+ooBA1SGNKGavqpsruRChzP5IZEng/+5UurRCMAQrmIg/RG2WnT8n
         Wbdw==
X-Gm-Message-State: AOAM5320Ez/rTNBrnpNrsy2yGVbA5gWkSJ2h18Ga5Z0tXajbQZmAYav3
        6f+VhjJCmtN6BW1zaj622sleWXxOr70=
X-Google-Smtp-Source: ABdhPJwR/U2V+dA3aTdeIaBdoLrZNuet4mu5nXIyfthtaz1V9im5DzInUTr6t7Xc12/bhaUc7fkbIQ==
X-Received: by 2002:a17:902:a502:b0:15e:c251:b769 with SMTP id s2-20020a170902a50200b0015ec251b769mr1326392plq.115.1651806922315;
        Thu, 05 May 2022 20:15:22 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902b40600b0015e8d4eb1f5sm394545plr.63.2022.05.05.20.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:15:22 -0700 (PDT)
Date:   Fri, 6 May 2022 11:15:17 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] staging: rtl8712: fix uninit-value in usb_read8() and
 friends
Message-ID: <b9b7a6ee02c02aa28054f5cf16129977775f3cd9.1651760402.git.wanngchenng@gmail.com>
References: <cover.1651760402.git.wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651760402.git.wanngchenng@gmail.com>
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

