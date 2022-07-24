Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39B57F73D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiGXVmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 17:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXVme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 17:42:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2FFDFFC;
        Sun, 24 Jul 2022 14:42:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d8so13478265wrp.6;
        Sun, 24 Jul 2022 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cI0tq8ocLXnomSpbghiVV7RxzqLowQvyj0zeXfaGRkk=;
        b=AYzHdSH4LYYxwPAVebBYfedRYqP0Wr9Hh+iqf8pYEMndrZnQ7pqItSGqypWj9Qnbd1
         eXFRu/Z8JVzRtSo8s6deeiLjHab7rGabOhMO8B0V+NL7dz2Wy3sG7Yo9xumTpMYUhJNG
         8oM39zmisit/HM55TUiQKQhlPNxm4N/pWkQQAw/qoBCLw8nFRTAZ6dswBvznnNeng4Dj
         VUYOIUsSMCXBCowS+db3eVv3M+0NYPqK/JUSD0bxykZQD40rS51IB+KQnBXSds68nftM
         h2/N3gbn4fsonG5eZx+TXlmbU4RLGSy1veZXODAz1j1unSFHGyFaGiRv3He+fXr7HJJH
         mL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cI0tq8ocLXnomSpbghiVV7RxzqLowQvyj0zeXfaGRkk=;
        b=45jglXf1tvFzeEZPmLFYvHqHOwhZjMWIEyZREccnxqhlogSERLvo4ahPCvT8Fx98+M
         ku9EJG5aVyfd4wTnEZ9fVeOBWfUJyPrvJcagyh+vStaemNHoWYCYjIcj5p+dY70/3qCc
         jh5ZWfkIfuazAE6wyxgyDdliB4AZpo2wEaco6IVLiXHgjmeRaCtPk68Z56uiZBpR63KP
         P8rtSnUgqGpf+br7CVIb2grX7a79uIXMpAaVuBTjr24Nh3LeK3g0sEHR2zWFolVhXh4L
         WbEZ+wIFGfleW+15o4g6jHUlhySOOA9ScdtcIYORIZjJ44aWN1/ReqSPSBTevIA/WXG3
         Tvhw==
X-Gm-Message-State: AJIora+fchS2N2zdkpbMMYDVpm1t23jFMCA37NgLr5wMsfSq+hVCMqDn
        B7pW+HEx4Gw+0lObDIs+kBi/ihRVrq6+kd44
X-Google-Smtp-Source: AGRyM1sSw/iFXQoSeyFqEEBVJH9oD0mhzGexSPkzEN8qhoy2RmTetkCyZv86IoZgtkp5+jXrDCDnXQ==
X-Received: by 2002:a05:6000:1545:b0:21e:6a2d:1e42 with SMTP id 5-20020a056000154500b0021e6a2d1e42mr5782677wry.660.1658698951095;
        Sun, 24 Jul 2022 14:42:31 -0700 (PDT)
Received: from localhost.localdomain ([84.255.184.16])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b0021db7b0162esm6322359wrr.105.2022.07.24.14.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 14:42:30 -0700 (PDT)
From:   Mazin Al Haddad <mazinalhaddad05@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     mchehab@kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Mazin Al Haddad <mazinalhaddad05@gmail.com>,
        syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com
Subject: [PATCH v2] media: dvb-usb: fix memory leak in dvb_usb_adapter_init()
Date:   Mon, 25 Jul 2022 00:41:02 +0300
Message-Id: <20220724214100.593287-1-mazinalhaddad05@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a memory leak in dvb_usb_adapter_init() reported by syzkaller. The 
problem is due to the error path exiting before incrementing 
num_adapters_initalized, which is used as a reference counter to free 
adapter's private data. There are multiple error paths that 
dvb_usb_adapter_init() can exit from before incrementing the counter, 
which lead to a memory leak as the current iteration is not accounted for.
Fix this by freeing the current iteration's adap->priv in each of the 
error paths.

Syz Report:
BUG: memory leak
unreferenced object 0xffff8881172f1a00 (size 512):
  comm "kworker/0:2", pid 139, jiffies 4294994873 (age 10.960s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff844af012>] dvb_usb_adapter_init drivers/media/usb/dvb-usb/dvb-usb-init.c:75 [inline]
    [<ffffffff844af012>] dvb_usb_init drivers/media/usb/dvb-usb/dvb-usb-init.c:184 [inline]
    [<ffffffff844af012>] dvb_usb_device_init.cold+0x4e5/0x79e drivers/media/usb/dvb-usb/dvb-usb-init.c:308
    [<ffffffff830db21d>] dib0700_probe+0x8d/0x1b0 drivers/media/usb/dvb-usb/dib0700_core.c:883
    [<ffffffff82d3fdc7>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
    [<ffffffff8274ab37>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff8274ab37>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:621
    [<ffffffff8274ae6c>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff8274ae6c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:752
    [<ffffffff8274af6a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:782
    [<ffffffff8274b786>] __device_attach_driver+0xf6/0x140 drivers/base/dd.c:899
    [<ffffffff82747c87>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:427
    [<ffffffff8274b352>] __device_attach+0x122/0x260 drivers/base/dd.c:970
    [<ffffffff827498f6>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:487
    [<ffffffff82745cdb>] device_add+0x5fb/0xdf0 drivers/base/core.c:3405
    [<ffffffff82d3d202>] usb_set_configuration+0x8f2/0xb80 drivers/usb/core/message.c:2170
    [<ffffffff82d4dbfc>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
    [<ffffffff82d3f49c>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
    [<ffffffff8274ab37>] call_driver_probe drivers/base/dd.c:542 [inline]
    [<ffffffff8274ab37>] really_probe.part.0+0xe7/0x310 drivers/base/dd.c:621
    [<ffffffff8274ae6c>] really_probe drivers/base/dd.c:583 [inline]
    [<ffffffff8274ae6c>] __driver_probe_device+0x10c/0x1e0 drivers/base/dd.c:752

Link: https://syzkaller.appspot.com/bug?id=4d54f8bf7b98eecf6cd76ed5aaea883c5d9e502a
Reported-by: syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
---

Changes in v2:
- Remove variable that is used to refcount and instead free current
  iteration private data.

 drivers/media/usb/dvb-usb/dvb-usb-init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 61439c8f33ca..69520d7ca25d 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -80,16 +80,22 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 		}
 
 		ret = dvb_usb_adapter_stream_init(adap);
-		if (ret)
+		if (ret) {
+			kfree(adap->priv);
 			return ret;
+		}
 
 		ret = dvb_usb_adapter_dvb_init(adap, adapter_nrs);
-		if (ret)
+		if (ret) {
+			kfree(adap->priv);
 			goto dvb_init_err;
+		}
 
 		ret = dvb_usb_adapter_frontend_init(adap);
-		if (ret)
+		if (ret) {
+			kfree(adap->priv);
 			goto frontend_init_err;
+		}
 
 		/* use exclusive FE lock if there is multiple shared FEs */
 		if (adap->fe_adap[1].fe)
@@ -112,6 +118,7 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 
 frontend_init_err:
 	dvb_usb_adapter_dvb_exit(adap);
+	return ret;
 dvb_init_err:
 	dvb_usb_adapter_stream_exit(adap);
 	return ret;
-- 
2.37.1

