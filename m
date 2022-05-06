Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4206151D729
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391597AbiEFMDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380114AbiEFMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:03:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04A60DAA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:00:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 15so5936064pgf.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nLavEAR5Aau9+5bXqJeGR1zfvkVlJijBBWww/pFaBdg=;
        b=DeEyjUY/AE4zdNZnPtis7a7XGLtDDO3d/lJzBjqrUsP9rcMTrXZBtw+hwaySnho1Fh
         jrngQRa8MGUKkyTvWSQPHeUWHpai58VlWs0CzkvL9r4rhBQFX+4LJDXxvIm+KxfjQhgj
         zBBE+TUgiT8YlED78tDChevr6U/iNmpKQq0DzNGtXVe5BnkuFcr+zX30CXxTVGXiq7xi
         otEGboTuUFFtpY5K3ed8WZ6ncFyMOvcvMfbfqlcVc2+zaGW3YBLDuObRJeBMyWccOxZm
         GQpR+FSAVBBQJ/AGHPOn+6SDjVlq3cSkkcrbnIAb3bJ5ADvUTxMbethyv1Sti66/oMIy
         z4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLavEAR5Aau9+5bXqJeGR1zfvkVlJijBBWww/pFaBdg=;
        b=FVwDzcgqRXa8jxoprjZwi/N0Njfnda9eAf86Zq56FTYD8sLwfoaTGPzFl9qdQYYXBH
         i6h9i9jV5L44f799TaDxFonOnlH1KdhDCqYbS1pq+tnJq67ADPgw8mLbDKKvtm2RQ+b/
         MTqfP5OLz9RFB9eZ0AHA9ej3cykXskNdgMfJWU9r29De6IUlAI7H00ac68m8vv9/UYPN
         S6aZbJmId3wTLaY8IUf4cBn5452vAuL1lXIHO2Vfn3bWsrcE2YnR/GLTkMeqsZ7uwq6x
         dIen95qHQQqK9HvrXkfRJyEFnvks24tVleRRg9IzYHfFFsFGg/bdu8+ki0Sd4N0ve6OX
         RHkw==
X-Gm-Message-State: AOAM532n9eSxXFdx68epz+AWm9K+b8ixCAjOHB5BGW3MugJO3jz2GFlX
        0D/paRA2cyi0DUSL4MAm23Q=
X-Google-Smtp-Source: ABdhPJwg4XY20f0zcCWhvaiidVQyvulZHkhF/Z7tytzmQiJbJ12b4Fi553fBIbXUhmdMDZsdj2rzZQ==
X-Received: by 2002:a63:8542:0:b0:3ab:4911:ec35 with SMTP id u63-20020a638542000000b003ab4911ec35mr2503523pgd.356.1651838406739;
        Fri, 06 May 2022 05:00:06 -0700 (PDT)
Received: from localhost ([152.70.90.187])
        by smtp.gmail.com with ESMTPSA id be12-20020a056a001f0c00b0050dc76281basm3233819pfb.148.2022.05.06.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 05:00:06 -0700 (PDT)
Date:   Fri, 6 May 2022 19:59:59 +0800
From:   Wang Cheng <wanngchenng@gmail.com>
To:     dan.carpenter@oracle.com, paskripkin@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] staging: rtl8712: fix uninit-value in
 r871xu_drv_init()
Message-ID: <14c3886173dfa4597f0704547c414cfdbcd11d16.1651833575.git.wanngchenng@gmail.com>
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

Reported-and-tested-by: syzbot+6f5ecd144854c0d8580b@syzkaller.appspotmail.com
Signed-off-by: Wang Cheng <wanngchenng@gmail.com>
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

