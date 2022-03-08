Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCCF4D21CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349273AbiCHTob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbiCHTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:44:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950D44B877;
        Tue,  8 Mar 2022 11:43:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id v28so57505ljv.9;
        Tue, 08 Mar 2022 11:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBq+74jsGS12/t26peyLXSXJ4MX0rUkn2P9HFFxGwBo=;
        b=lUkOC6OSjq2Z/dESjP3coU6U8iWOUb7DpIsCv0FDldqQGDpS2OWkQ86gVwB4kL1XPx
         zkDD2DuI2jVxYRiOPRltbMWExBuRg4NkveTQJ0nz8vksP1CUq3+j/qBYiWHbwQurW0LX
         X1mbXDB0bWTs82wE/+Xh6TpLFhGbWKtCEP8K/ZQV52d0AZmffYIAwc9m+FUtK3qi1sRA
         3Oq6BUSifJgMZlg5yWwzK77R4jXtpLIHOZPC+prbP9Eh9/3bWeYQF6NmYG9To82Jd0nQ
         PExcosJOxgQI5LAMTFfaFHgz0fcKy1xGoVxC9v80C1HWouADymfljb4RWxh/Dao37Lza
         jK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBq+74jsGS12/t26peyLXSXJ4MX0rUkn2P9HFFxGwBo=;
        b=bqyiw7N/7llnY8loMEmkLDPny57e++fM6CEPqet/mcoICRVRsf7pqcdJk/cmkxdq8X
         EFWgxPwcAP0XG2PvFngCm/KNft7jmQygaYl/414S4fu/MxpKi8DAafJ8LbyKOlXb3zcu
         7eOj5C8lO6l4C1BAAdVGBh00y3HKdiA8om5e7wQYwFrJ5iFLV9oMbHnVdqKQ9UAjoKX7
         G2BpBONrW/z7GUlv9pPoy1nmPa8pTf+n3N34/6JbPd/oFoAkVukgkVCfjzLfImN6t0hG
         ErPVp3GKbGAMJbCCoso6oYfyzdC8Iu7tOZdkrZdpfbUBTiJ8wGybEeGQhQNRUlZjBM+G
         kbxA==
X-Gm-Message-State: AOAM530RwSMd+11gcbnbU8mOnCoTpaJGzCbcvGaEwKYf5qdrdvRkkLfL
        48h8TiOzHxLHzcuLIGw780s=
X-Google-Smtp-Source: ABdhPJyUFZohD7qdVQ/51M1mbPKE7gr7WnFVzzBnWt5z1sjviZUXLn/OxTXWMyl7oGVm75ec48KRQg==
X-Received: by 2002:a05:651c:1209:b0:22e:353c:76c0 with SMTP id i9-20020a05651c120900b0022e353c76c0mr11728859lja.139.1646768610857;
        Tue, 08 Mar 2022 11:43:30 -0800 (PST)
Received: from localhost.localdomain ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512388500b004439696b40csm3641856lft.47.2022.03.08.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:43:30 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     dmitry.torokhov@gmail.com, vdronov@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+75cccf2b7da87fb6f84b@syzkaller.appspotmail.com
Subject: [PATCH] Input: aiptek - properly check endpoint type
Date:   Tue,  8 Mar 2022 22:43:28 +0300
Message-Id: <20220308194328.26220-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Syzbot reported warning in usb_submit_urb() which is caused by wrong
endpoint type. There was a check for the number of endpoints, but not
for the type of endpoint.

Fix it by replacing old desc.bNumEndpoints check with
usb_find_common_endpoints() helper for finding endpoints

Fail log:

usb 5-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 2 PID: 48 at drivers/usb/core/urb.c:502 usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
Modules linked in:
CPU: 2 PID: 48 Comm: kworker/2:2 Not tainted 5.17.0-rc6-syzkaller-00226-g07ebd38a0da2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: usb_hub_wq hub_event
...
Call Trace:
 <TASK>
 aiptek_open+0xd5/0x130 drivers/input/tablet/aiptek.c:830
 input_open_device+0x1bb/0x320 drivers/input/input.c:629
 kbd_connect+0xfe/0x160 drivers/tty/vt/keyboard.c:1593

Fixes: 8e20cf2bce12 ("Input: aiptek - fix crash on detecting device without endpoints")
Reported-and-tested-by: syzbot+75cccf2b7da87fb6f84b@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/input/tablet/aiptek.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index fcb1b646436a..5d0dc277bf86 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1787,15 +1787,12 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	input_set_abs_params(inputdev, ABS_TILT_Y, AIPTEK_TILT_MIN, AIPTEK_TILT_MAX, 0, 0);
 	input_set_abs_params(inputdev, ABS_WHEEL, AIPTEK_WHEEL_MIN, AIPTEK_WHEEL_MAX - 1, 0, 0);
 
-	/* Verify that a device really has an endpoint */
-	if (intf->cur_altsetting->desc.bNumEndpoints < 1) {
+	err = usb_find_common_endpoints(intf->cur_altsetting, NULL, NULL, &endpoint, NULL);
+	if (err) {
 		dev_err(&intf->dev,
-			"interface has %d endpoints, but must have minimum 1\n",
-			intf->cur_altsetting->desc.bNumEndpoints);
-		err = -EINVAL;
+			"interface has no int in endpoints, but must have minimum 1\n");
 		goto fail3;
 	}
-	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
 	/* Go set up our URB, which is called when the tablet receives
 	 * input.
-- 
2.35.1

