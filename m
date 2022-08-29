Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096365A4C73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiH2MwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiH2Mv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:51:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B612A9C;
        Mon, 29 Aug 2022 05:40:13 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m2so7858886pls.4;
        Mon, 29 Aug 2022 05:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=U4wTB7v20lr8R8vN/DK0R+bOA2Ehyif+zGIk0zOHfx0=;
        b=mUW9a9WuxFwjzWd9ArvC0UAnAXe8WIK4jnMELe11pyHPPKuXyL1J0BD4HdYYhFfiiv
         60ocE3VLbMEQ5FINK30pxWHac4NP/zeNzrHDJw+mfOPH+YXlD66fleA56iFTNEOZqATS
         qQ78Ft48VWLOxBlkd3f+mwir9VNJ6cT1JDDYS6xu54ixjpHprwimnF52vKMrliY0tc/j
         1bQQmr8oVWVhPff4l9wbmNsyeDZnbQzygjFW0rY10pZ4eZrJyVSa+ws/WgqbijQWe4jp
         qZiz7NpZu1b9oB8OAmV7amCMReVX+DXuGTbNZUNMTs3RCEHsC9dxgv+t96hrec1V9+WB
         jgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=U4wTB7v20lr8R8vN/DK0R+bOA2Ehyif+zGIk0zOHfx0=;
        b=npYgZs/HA2DP/djaXdcrhJ0XeapLW+NdeOew5cX4NQIjscgUeqJoDBytCk6t5KdPJQ
         hTvwkhahm0mvCsJtzRW6WTQRqtUdk40FNMvDHSJgRVv4DiVDhOgU4+KegK/fw/tOK9F0
         rzaJRDtjGyoAmJI5Lrd1ky/QM4gK5bkHtJwqNJexd+Wm/vGvE6LUqjFucsH/UYBtZK4i
         355cuVr6CKGr5QOV/YiMfbZXpMgPZ0TtOYCGfhi/zhsCpAO6TqCvPmkU4qhRcKMS/75w
         TLqILNiVbVT8eEEeb8Hr6xhnY5HiOC1Fz/V39MLT7WGvHPOFbugY/88V5kbXLdbuWflS
         WjRQ==
X-Gm-Message-State: ACgBeo2o6ngQHIgLmOgcKNPIttGZWahYD9LCIeIEUkhHY+bgjUPGhtwf
        zE6La8wISJ0ZyCy2D4A1M1+ClW+jvey68Q==
X-Google-Smtp-Source: AA6agR62s5v7zx7N35JeijeC8JxoIsW/kNiBDiOhLdy9ERmBr/+5HYU7BCqEN6UQidMuu50r9Uu9mA==
X-Received: by 2002:a17:902:9a41:b0:171:389a:554f with SMTP id x1-20020a1709029a4100b00171389a554fmr16202440plv.122.1661776812126;
        Mon, 29 Aug 2022 05:40:12 -0700 (PDT)
Received: from Negi ([207.151.52.7])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b0016d1bee1519sm7491501plf.102.2022.08.29.05.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:40:11 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: Check sanity of endpoint in pegasus_open()
Date:   Mon, 29 Aug 2022 05:39:59 -0700
Message-Id: <20220829123959.21298-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix WARNING in pegasus_open/usb_submit_urb
Syzbot bug: https://syzkaller.appspot.com/bug?id=bbc107584dcf3262253ce93183e51f3612aaeb13

Add sanity check of endpoint for Pegasus URB in pegasus_open() so that
transfer requests for bogus URBs are not submitted. If the URB is bogus
pegasus_open() will fail.

Reported-by: syzbot+04ee0cb4caccaed12d78@syzkaller.appspotmail.com
Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/input/tablet/pegasus_notetaker.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index c608ac505d1b..5e47882ee4c0 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -225,6 +225,15 @@ static int pegasus_open(struct input_dev *dev)
 
 	mutex_lock(&pegasus->pm_mutex);
 	pegasus->irq->dev = pegasus->usbdev;
+
+	/* Sanity check of endpoint in Pegasus URB */
+	error = usb_urb_ep_type_check(pegasus->irq);
+	if (error) {
+		dev_err(&pegasus->usbdev->dev,
+			"URB failed endpoint sanity check: %d\n", error);
+		goto err_autopm_put;
+	}
+
 	if (usb_submit_urb(pegasus->irq, GFP_KERNEL)) {
 		error = -EIO;
 		goto err_autopm_put;
-- 
2.17.1

