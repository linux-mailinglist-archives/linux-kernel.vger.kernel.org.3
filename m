Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6997E4E9064
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbiC1Iql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbiC1Iqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:46:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D453B41;
        Mon, 28 Mar 2022 01:44:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so5149753wms.1;
        Mon, 28 Mar 2022 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pqdm+mBE6rvDwcUiUDsdVFIdx5r1E/ZYwzEqYDEj1e0=;
        b=NB+PmO5b3jTtCuBHri6okNxSStdSscYcd7scQMYe+jFgLN/IzFE+S/k+w+siMZXP8U
         0eJno86W9uXoIMvzol/M2MNDwdibNcN2b4FFn2m9YcSbLuppA5h7atjI47yhBw/DuZn5
         rDwCyiY1dEnrzdCJJdBCtEVfFIwKQRSyjLJ6nmENR5/abqGmZiemDaSBz5RAkPZDQbAC
         YDdkIlBUpLasyQpvi9gqdWoN7ozOg8JQzoxag7TtvScki1DQr45K6/SYQTTX9fere8Md
         r1IRNilqQifjqHfyJQi13KfuAqNodpxNLeN4wA+2chspQnDeMZsBvgj6BJ5o21Z7eAhK
         iARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pqdm+mBE6rvDwcUiUDsdVFIdx5r1E/ZYwzEqYDEj1e0=;
        b=0lYQvyWPisiq8pLQ91bgW4qBWOzAB+baoOY921rrwR3FQv7OopYdIbTzz1ka4HFyON
         U4r/rRXavbEVEeEgJ7pIqr1h6Ve8Gl1Xyv0BJ5RvbyIcEfBWUCwF/6wafR5LAktRmhJk
         VvIaAa8D9JNkEDnMNusHxt3p3EcZKChnInuHj9qaspVkcWRstjQeR57yH1WGtDXVCGuv
         1hq9urwb02AFoskHa3lZY1LcfdbZS8IqXKEdXyXb/cX4RSrTYUwyX0dTZ2VZTKlEfynP
         QIy8lnaMcPXTJwDoawCW74UNv77d5uniW0s+iqFiepe1nrJp7aKL+qM3lFGrx6ppHTRW
         ljUg==
X-Gm-Message-State: AOAM530RLzG+TiaZmRnhaLM9k2zy9oi6/a5rqLScwgx5nh7rUFOiwhxJ
        378GfHkowyVOIQvChKaQscU=
X-Google-Smtp-Source: ABdhPJxtdTBusI80FVUAuQFJXM8pHhDgNrv9BKoyKHkaGwamAo3bAaxMSp13WOHJlEJWWqn1wdZbjg==
X-Received: by 2002:a7b:c186:0:b0:38c:75ea:4903 with SMTP id y6-20020a7bc186000000b0038c75ea4903mr24461122wmi.176.1648457097197;
        Mon, 28 Mar 2022 01:44:57 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d4a85000000b00205a8bb9c0dsm10493303wrq.90.2022.03.28.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 01:44:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: [PATCH] scsi: sd: Jump to out_free_index if device_add{,_disk}() fail
Date:   Mon, 28 Mar 2022 10:44:52 +0200
Message-Id: <20220328084452.11479-1-fmdefrancesco@gmail.com>
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

Currently, if device_add() or device_add_disk() fail, the code jumps to
the "out" label. Doing so we get a memory leak as Syzbot reports.[1]

Fix this bug by jumping to the "out_free_index" label.

[1] https://groups.google.com/g/syzkaller-bugs/c/BvuqG6YGb6I

Reported-and-tested-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/scsi/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index a390679cf458..61fcf653ef5a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3434,7 +3434,7 @@ static int sd_probe(struct device *dev)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
-		goto out;
+		goto out_free_index;
 	}
 
 	dev_set_drvdata(dev, sdkp);
@@ -3475,7 +3475,7 @@ static int sd_probe(struct device *dev)
 	error = device_add_disk(dev, gd, NULL);
 	if (error) {
 		put_device(&sdkp->disk_dev);
-		goto out;
+		goto out_free_index;
 	}
 
 	if (sdkp->capacity)
-- 
2.34.1

