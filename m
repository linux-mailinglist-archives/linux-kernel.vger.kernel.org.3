Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57A5557411
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiFWHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWHhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:37:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0414666B;
        Thu, 23 Jun 2022 00:37:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t21so12058817pfq.1;
        Thu, 23 Jun 2022 00:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpL/UAMrNCY+mpb7nIKgF/7LElte6o9clmtNEtgnD2o=;
        b=m/cOOaRhcIatl0ulDrUL73FQeXCsD9vjUh8YO/GmkOomCGyf4n2O+IKnyKZ2OahRYY
         DLz9c+ojYT9t5GCzYOghyVdJxgllpA2/nl/g+iWDWJvvAEUWr3pmVj+a5j3su2OTT8J8
         8uFs8SYF0Rn9uTM3zUKMabpSAZ59D6VVdzVssYsG4KttEMwgvefoLC2P3wx+/+20Li/6
         WmpBE9H8ZlcF2OeFNAFYDvYqpxk7R9qOejqJd7SjFgqarPGvvbRhdiWnpa2aecY8b9MF
         wOPqnPpWL7REP1xXTEPOn8eEqW0v3PO2htqhKyplIrpt/8vQmJPUl3IQsjx0MXYHGxN7
         2ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CpL/UAMrNCY+mpb7nIKgF/7LElte6o9clmtNEtgnD2o=;
        b=bCa+FCtSftmu7aHjGyTGoToX6f3tR7YqePo9RHdwUn4oVo2KszVTIdqX7JGdpxLjpE
         RzlGGUwdX5vGjm7eyx2tdTw7N0qiBN1TN4CoRTnXipKkpaSOLmwMno4Ic7nOirSh4o/v
         IcUxFlH9XmUxl+I6f2sFyWmnHae59o+5EQ5ByBpvgLLVH02d6ODdNRxNDK6R7iSfYo45
         6wQjZSWVgiBuyphvuVKLn9rjFRBOyBzBZhlXwr0s7W9OfQUCLQZ40CbkIIPMuyJ2TNjM
         8FYQ+BgzDlrHh8AuZv2vxJCMOpWklkeqY5pPVVZickeIquIkFgMn/hK7goEhslrE/M/k
         hbfw==
X-Gm-Message-State: AJIora+jOyzlxloLltLpyvW81pruQivB36cAj/OLS2qr6n+R1kceXgQ4
        yHNmZ6dMbs9ks36pE0BWCIY=
X-Google-Smtp-Source: AGRyM1tcPprn9LA/v1YcvMwmZJF8sbNQ3B2vhl9vTb92UdPuJDoze9T94OM9o8P3ocoGtcnvyaQsjA==
X-Received: by 2002:a63:6b08:0:b0:3fd:1b8e:3932 with SMTP id g8-20020a636b08000000b003fd1b8e3932mr6491663pgc.552.1655969852366;
        Thu, 23 Jun 2022 00:37:32 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id m18-20020a639412000000b0040c74f0cdb5sm10723134pge.6.2022.06.23.00.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 00:37:31 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        krzysztof.kozlowski@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] rpmsg: fix possible refcount leak in rpmsg_register_device_override()
Date:   Thu, 23 Jun 2022 15:36:05 +0800
Message-Id: <20220623073605.27386-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

[1] commit 1680939e9ecf ("rpmsg: virtio: Fix possible double free in
rpmsg_virtio_add_ctrl_dev()")
[2] commit c2eecefec5df ("rpmsg: virtio: Fix possible double free in
rpmsg_probe()")
[3] commit bb17d110cbf2 ("rpmsg: Fix calling device_lock() on
non-initialized device")

The above three patches merged at the same time introduced a new bug.
[1] and [2] make rpmsg_ns_register_device and rpmsg_ctrldev_register_device
need to call the callback function internally to free vch when it fails.
[3] has an error return path not handled vch.

Fix this by adding a put_device() to the error path.

Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 290c1f02da10..5a47cad89fdc 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -618,6 +618,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 					  strlen(driver_override));
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
+			put_device(dev);
 			return ret;
 		}
 	}
-- 
2.25.1

