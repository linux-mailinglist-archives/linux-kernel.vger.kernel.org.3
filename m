Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B085280CC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiEPJWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiEPJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:22:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDE271B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:22:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n8so13877732plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=edsKQMhpUP9JbGHKl4r1CA5YqJYsqUBJ5fksFtI74wQ=;
        b=qJfBqJF6RgEYMAVVvNO6cabjgklbRG+BreGRSnxASIxMJYRd9tlz4QaDFREumaPw9H
         4jQ8nA17iUqp6kuSV2fig4TFd2qK5OKpruFOSdXyI9ciTCn07qIO2OWXoNrT3G+N5ivL
         zgJUWG3ufznIVsQmnkRi7woUgDNUA23EDc34oxZPI4qPIXr1KFtyZ7LKyek9+Kj5BbSV
         A6xKrdNnWlKu4i396Zpd2F2OmSK+dVHk9c3t5ATTNC8b1hJsbsAxUBxzlj1jT74YER+r
         7fjsUDT+E95q7ojeQ/1/eUrUSBDel3T43ejOb+GJY0iZ2PHls1w3m3uXxFiv5wNdwrnS
         pB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=edsKQMhpUP9JbGHKl4r1CA5YqJYsqUBJ5fksFtI74wQ=;
        b=HhDLRWCHKJ0KPVe4QiqSDflkreSCp1AEoQLf0HfhZ5J6tRA4p+RG44mu+LBDUNy92d
         +7z6J/SkUlPWLHTadiXQxI327iIlShk/+a9DvfCJ+2RHg8vblsdMA+TbkItbPj/V1RXR
         urmXNEix/Cihv7AfO8K34/2P6u/AZS7RsRMlvtSK8fYvDH0uV0wxENa0jZYfODMe8C4B
         MUH2YIFmZJ7CxPl1fZQ3Q9aCi7oLeXzZDo8RD+ptVTFmeyR3kbvv1UROF8vRUG3j799F
         SDwn3NfFkvTmvP+CaN4MK5L4dqW7Hi61eb5U5UtWf+S9r9YCG+HX9WQ1EbaTGq+SLPCM
         1jjg==
X-Gm-Message-State: AOAM5309rab3BYnUAW+4WTjt+yOjt0aD5/TfiRjHAeewFB1/Zl28V1Sy
        bhbROBK25/oPByOFndqAJcw=
X-Google-Smtp-Source: ABdhPJwDP10UJm5hoYqBWTEz8yOQ/gZ23lsZU3aruKeYJGUdfeQ/5IANOfaiv+DbH4BQK6pVrOwV6w==
X-Received: by 2002:a17:90b:4a01:b0:1dc:b062:da0e with SMTP id kk1-20020a17090b4a0100b001dcb062da0emr18414091pjb.87.1652692965554;
        Mon, 16 May 2022 02:22:45 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b0015e8d4eb1f6sm6690192plh.64.2022.05.16.02.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:22:45 -0700 (PDT)
Date:   Mon, 16 May 2022 17:22:41 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Message-ID: <14c3886173dfa4597f0704547c414cfdbcd11d16.1652618244.git.wanngchenng@gmail.com>
References: <cover.1652618244.git.wanngchenng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1652618244.git.wanngchenng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'tmpU1b' returns from r8712_read8(padapter, EE_9346CR) is 0,
'mac[6]' will not be initialized.

BUG: KMSAN: uninit-value in r871xu_drv_init+0x2d54/0x3070 drivers/staging/rtl8712/usb_intf.c:541
 r871xu_drv_init+0x2d54/0x3070 drivers/staging/rtl8712/usb_intf.c:541
 usb_probe_interface+0xf19/0x1600 drivers/usb/core/driver.c:396
 really_probe+0x653/0x14b0 drivers/base/dd.c:596
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
 really_probe+0x653/0x14b0 drivers/base/dd.c:596
 __driver_probe_device+0x3e9/0x530 drivers/base/dd.c:752
 driver_probe_device drivers/base/dd.c:782 [inline]
 __device_attach_driver+0x79f/0x1120 drivers/base/dd.c:899
 bus_for_each_drv+0x2d6/0x3f0 drivers/base/bus.c:427
 __device_attach+0x593/0x8e0 drivers/base/dd.c:970
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:1017
 bus_probe_device+0x17b/0x3e0 drivers/base/bus.c:487
 device_add+0x1fff/0x26e0 drivers/base/core.c:3405
 usb_new_device+0x1b8e/0x2950 drivers/usb/core/hub.c:2566
 hub_port_connect drivers/usb/core/hub.c:5358 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
 port_event drivers/usb/core/hub.c:5660 [inline]
 hub_event+0x58e3/0x89e0 drivers/usb/core/hub.c:5742
 process_one_work+0xdb6/0x1820 kernel/workqueue.c:2307
 worker_thread+0x10b3/0x21e0 kernel/workqueue.c:2454
 kthread+0x3c7/0x500 kernel/kthread.c:377
 ret_from_fork+0x1f/0x30

Local variable mac created at:
 r871xu_drv_init+0x1771/0x3070 drivers/staging/rtl8712/usb_intf.c:394
 usb_probe_interface+0xf19/0x1600 drivers/usb/core/driver.c:396

KMSAN: uninit-value in r871xu_drv_init
https://syzkaller.appspot.com/bug?id=3cd92b1d85428b128503bfa7a250294c9ae00bd8

Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
Reported-by: <syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com>
Tested-by: <syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com>
---
 drivers/staging/rtl8712/usb_intf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index ee4c61f85a07..50dcd3ecb685 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -538,13 +538,13 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 		} else {
 			AutoloadFail = false;
 		}
-		if (((mac[0] == 0xff) && (mac[1] == 0xff) &&
+		if ((!AutoloadFail) ||
+		    ((mac[0] == 0xff) && (mac[1] == 0xff) &&
 		     (mac[2] == 0xff) && (mac[3] == 0xff) &&
 		     (mac[4] == 0xff) && (mac[5] == 0xff)) ||
 		    ((mac[0] == 0x00) && (mac[1] == 0x00) &&
 		     (mac[2] == 0x00) && (mac[3] == 0x00) &&
-		     (mac[4] == 0x00) && (mac[5] == 0x00)) ||
-		     (!AutoloadFail)) {
+		     (mac[4] == 0x00) && (mac[5] == 0x00))) {
 			mac[0] = 0x00;
 			mac[1] = 0xe0;
 			mac[2] = 0x4c;
-- 
2.33.1

