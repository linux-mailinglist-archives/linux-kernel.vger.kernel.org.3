Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4734859F0C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiHXBWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiHXBWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:22:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA04558DA;
        Tue, 23 Aug 2022 18:22:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k9so18969259wri.0;
        Tue, 23 Aug 2022 18:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=OhLPqZHai+lEZNO/aWIoJdIaImKIb4W7ZXPCAX37T0U=;
        b=KF010LcSPIWCIFpfDR0DvZsdsFdeGEGkqDXLaLXAt0Unnok8jGtw0Q4tk9n+XysoMX
         r03afeZ23ebiVSNkurNuFADPlOxXQhFzjduZWLX3Bl/CJxm6zQwiVgaUK9h7Ty/+T0nh
         vInb3mYztoTvUrmaK8Wq/OIyMxPTmX/RIXZWtcNm31qQ1h/nmUur+eMPnZFqLYD77Pmn
         8o0AcfuHWr2x6HLbprJOz8iJfmq5e6+iFuWLOtYwL0hJ2St+L09a05yDZv3TUBwBry0b
         crAoz6xjAaqRs8kpL4U9N+RP0auXPA1k51Qi5V5+cU+paTUZmszTiB3hsNgpuXEO67Mr
         YFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=OhLPqZHai+lEZNO/aWIoJdIaImKIb4W7ZXPCAX37T0U=;
        b=1WHmlTl9VPj4RsA8Qtw+/uTEQjttIdeljFzRu2HXDoKypP7p+AZt+HzVYxgTOp6N46
         T9jOJGNGKd21pjT1HOqCoEMZ9Qfq3ZqvVHgOlYvuOcmqAA3tdKBML3Bx5fFBMdtTSGiM
         wfB/dp1VRiWoXXLNP5FRxqUuddB6shcZFmms9smKQZUjbBBpTbrWAL+oYA7oAKbA4G7v
         KC4lPWhWfO6uJu7cv0Il4yxiWkhYA05DoWy3UdF25bDcd45IbUY6Cp2IwsE4XMoY+jOv
         h43kEvOwb4g+Z0wQNxUxsaO4f6hakOPy+fP6hkyLMTHu8Bacqi+mWvsbaMYWPa5H+5Y2
         xCcw==
X-Gm-Message-State: ACgBeo269iKTpwzZVk6dEROZ60FagOXl+LCmdQ+zCc+3+92eqPDZDTJ1
        T1r7Qu7MHnAdcxzzaXkiFUlzmaVcMOGTTRlR/4k=
X-Google-Smtp-Source: AA6agR55uyl5UODy8v/O3d3ed7BqsoPln2Xnk12sc+Vvjm8qw4FB4W647Ss7e/TKFClpln4GHkpL4w==
X-Received: by 2002:a5d:5487:0:b0:225:3fa7:41c2 with SMTP id h7-20020a5d5487000000b002253fa741c2mr11004598wrv.195.1661304129469;
        Tue, 23 Aug 2022 18:22:09 -0700 (PDT)
Received: from localhost.localdomain ([84.255.184.228])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d48c7000000b00223a50b1be8sm15364601wrs.50.2022.08.23.18.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 18:22:08 -0700 (PDT)
From:   Mazin Al Haddad <mazinalhaddad05@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Mazin Al Haddad <mazinalhaddad05@gmail.com>,
        syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com
Subject: [PATCH v3] media: dvb-usb: fix memory leak in dvb_usb_adapter_init()
Date:   Wed, 24 Aug 2022 04:21:52 +0300
Message-Id: <20220824012152.539788-1-mazinalhaddad05@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Syzbot reports a memory leak in "dvb_usb_adapter_init()".
The leak is due to not accounting for and freeing current iteration's
adapter->priv in case of an error. Currently if an error occurs, 
it will exit before incrementing "num_adapters_initalized", 
which is used as a reference counter to free all adap->priv 
in "dvb_usb_adapter_exit()". There are multiple error paths that
can exit from before incrementing the counter. Including the
error handling paths for "dvb_usb_adapter_stream_init()", 
"dvb_usb_adapter_dvb_init()" and "dvb_usb_adapter_frontend_init()"
within "dvb_usb_adapter_init()".

This means that in case of an error in any of these functions the 
current iteration is not accounted for and the current iteration's 
adap->priv is not freed.

Fix this by freeing the current iteration's adap->priv in the 
"stream_init_err:" label in the error path. The rest of the 
(accounted for) adap->priv objects are freed in dvb_usb_adapter_exit()
as expected using the num_adapters_initalized variable. 

Syzbot report:

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


Link: https://syzkaller.appspot.com/bug?extid=f66dd31987e6740657be
Reported-and-tested-by: syzbot+f66dd31987e6740657be@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
---
v2->v3:
	- Follow standard kernel pattern by moving error handling 
	to label instead as suggested by Lukas Bulwhan.
	- Adjust commit description to include syzbot report, 
	The "Reported-and-tested-by" tag and clarify the commit message. 

 drivers/media/usb/dvb-usb/dvb-usb-init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index 61439c8f33ca..58eea8ab5477 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -81,7 +81,7 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 
 		ret = dvb_usb_adapter_stream_init(adap);
 		if (ret)
-			return ret;
+			goto stream_init_err;
 
 		ret = dvb_usb_adapter_dvb_init(adap, adapter_nrs);
 		if (ret)
@@ -114,6 +114,8 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	dvb_usb_adapter_dvb_exit(adap);
 dvb_init_err:
 	dvb_usb_adapter_stream_exit(adap);
+stream_init_err:
+	kfree(adap->priv);
 	return ret;
 }
 
-- 
2.37.2

