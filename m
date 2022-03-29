Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7460D4EB101
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiC2Pvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiC2Pvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:51:40 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2877C85640;
        Tue, 29 Mar 2022 08:49:57 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h4so13425128edr.3;
        Tue, 29 Mar 2022 08:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtysjXm9RkwZpLhMftUmhj8qUdHYgmqOkGeujUmUcCQ=;
        b=c65yvGVAqe02PNddxlppLIXo90yHqcUOThMOCPShodfhCEdKPp1ASyA2zFPQxCo7Gc
         xYS3PpmdKEVSGGkEV0acnesxhwOGPHKwA9K9fS7IB/VuIY3IkCpBdfto04SIb4MACjjL
         Ej/5fBSTtXvZW3VMRzJKTWuTGoqNSYygQ82htTlC515s6r/Gf5OWaWHikCp1TKfBsgq8
         wsRsqioLiE70+Zhw5yu8qyCSyxn3uKPNC3/pnM6ReVzggOoLI7sm9WxzmV9m+vCA/0eQ
         P+ItTJNpKnn0OBTOKdn+v9BLA0Noogv75YOZoGWNSzEf71WYpgRgTgkwLFqxZgvgpC94
         u51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GtysjXm9RkwZpLhMftUmhj8qUdHYgmqOkGeujUmUcCQ=;
        b=eQjjmzl6u35wsDZFyqBXWuIcjFgBujs8vJQxtfARUF+ooYyCUFd4a5aMipq9m74yZl
         Cdsi7kKeMica1m6olKyJ23pXSyjwHf2BEHtiEfHT4uzli+6SW4ewiWBJQ2qTJnn1kOy2
         yZ/ssXDToIFmFcQP7LlLwSO1LSfyxdyz/UWZEH0QeWfjXfoOpxhIMd1OXLdi2hUT2SAW
         xqCTZ9vfoOtOU6+Ymh0HxOOAayBvYS0asJjna3d6qunRWbArQMLh+oszR6WF96Bilet4
         LYBtcBSwFmN+v0/hmAUrtMlmn1ckVyRUbNDVMn96+PVFkfzA4FxAOanO8JWLWPKHT0Nd
         RaEg==
X-Gm-Message-State: AOAM531yYIqQqa04vnJYMsP05TVzyDy7uVC5/i2CogMTnSqyVRPvUJOV
        0ReYFFyMh84Ai3QO0hWh5LKwETF5EA0=
X-Google-Smtp-Source: ABdhPJxa13HMXynnJyWQcFsBo5jIU+7rqPf2/FHz4p0LAgh5wOJRY8OMUGjOlyngtZcOTc1iWN+Rxw==
X-Received: by 2002:a50:bf0f:0:b0:410:c512:cb6f with SMTP id f15-20020a50bf0f000000b00410c512cb6fmr5415364edk.262.1648568992434;
        Tue, 29 Mar 2022 08:49:52 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm8696843edu.73.2022.03.29.08.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:49:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Date:   Tue, 29 Mar 2022 17:49:48 +0200
Message-Id: <20220329154948.10350-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sd_probe(), if device_add_disk() fails it simply calls put_device()
and jumps to the "out" label but the device is never deleted from system.
This leads to a memory leak as reported by Syzbot.[1]

Fix this bug by calling device_del() soon before put_device() when 
device_add_disk() fails.

[1] [syzbot] memory leak in blk_mq_init_tags
https://lore.kernel.org/lkml/000000000000c341cc05db38c1b0@google.com/

Reported-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

This patch replace the previous attempt to fix the bug reported by
Syzbot. Therefore, the previous wrong patch at 
https://lore.kernel.org/lkml/20220328084452.11479-1-fmdefrancesco@gmail.com/
must be discarded.

Many thanks to Dan Carpenter.

 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..13d96d0f9dde 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3474,6 +3474,7 @@ static int sd_probe(struct device *dev)
 
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
+		device_del(&sdkp->disk_dev);
 		put_device(&sdkp->disk_dev);
 		goto out;
 	}
-- 
2.34.1

