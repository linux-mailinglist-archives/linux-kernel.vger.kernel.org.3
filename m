Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D372481CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 15:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbhL3OMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 09:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhL3OMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 09:12:07 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244FEC061574;
        Thu, 30 Dec 2021 06:12:07 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id k21so54797110lfu.0;
        Thu, 30 Dec 2021 06:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GymDJbaBvoM8d/YBigegwCaA/JsyEYJgdnS30akxPc=;
        b=oPAtwjzmPyQQbE5awj35uyRutGn0nCMRmY2eVYVapRO4KKzf5QhZgdI3Y+CX3VqzT7
         khMjkdJY9hZfrLXFyO5qM+TAoTGSA0C8TXFYCxwmqhgj73XabeNJXCgo8C640wDgON4i
         fKwdxuLoRB7q3n2rV2zv7WFocf/ZUMZbV7jwmZ3s9gd2awnjgcXfr/VP5Of0fMQxqQ/n
         jz4Q3+90obYri0+Gw6r7nW95miMfc8LnprvET0xlJ5tDqpWecbDU9J0b6w6k4pmYNtnr
         NdVDDrFDvDId+7hFsSwgg0VMhixFJoL3ZIDWpQwRx1w2eLZBMlcmumQ0lUI1K+mgYzaP
         RERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6GymDJbaBvoM8d/YBigegwCaA/JsyEYJgdnS30akxPc=;
        b=BkbnZxfD8d8bE8bz98nvi8VarfWhDp1AwkNWK9+YTReoofI5ixMTCmDQEnMHmEG7Nt
         s/57EudCoGaLvDZI9S2UxHw2x6qMyOTmJ8Pso12IgSXNw2/qnmQz6yeTlqQzqlO4V1x/
         lDO1o8kMiP2AYcBi6ByKrFYEI9XxUHImyFwRwVPxWFfPTk4BAXe/Tu5ePiFFGmqs4j4n
         8Xje36zoQbxGAAFIG83//fv8/8keNmRhxGk6aYEvMALK01PP1289Nf0x/fVL7mr/19Yp
         AKYNOGkh+5VKpzdw16eoDjae5udAE1Wvz747iueWf0CAlQvcLBnYscS0ID4zCMGoIBjK
         BxbQ==
X-Gm-Message-State: AOAM5314DmSvCzaCw7rgfcoIHnhG7mIDwT6hqmNCqukim3EJDBDOduCN
        Sc0JYpk3X5H/mAe5lvNo01s=
X-Google-Smtp-Source: ABdhPJwtn6nKnwHcZEzbJB8VhHKom8j1PjTW4wnzo5b0c0cyZDPzrXQn9SLL3g5u5XqS1JPkH9c6HQ==
X-Received: by 2002:a05:6512:3324:: with SMTP id l4mr28153232lfe.30.1640873525265;
        Thu, 30 Dec 2021 06:12:05 -0800 (PST)
Received: from localhost.localdomain ([94.103.235.97])
        by smtp.gmail.com with ESMTPSA id bq36sm2500147lfb.42.2021.12.30.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 06:12:04 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     dmitry.torokhov@gmail.com, kernel@nn7.de, mjg59@srcf.ucam.org
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com
Subject: [PATCH] input: appletouch: initialize work before device registration
Date:   Thu, 30 Dec 2021 17:11:51 +0300
Message-Id: <20211230141151.17300-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot has reported warning in __flush_work(). This warning is caused by
work->func == NULL, which means missing work initialization.

This may happen, since input_dev->close() calls cancel_work_sync(&dev->work),
but dev->work initalization happens _after_ input_register_device()
call.

So this patch moves dev->work initialization before registering input
device

Fixes: 5a6eb676d3bc ("Input: appletouch - improve powersaving for Geyser3 devices")
Reported-and-tested-by: syzbot+b88c5eae27386b252bbd@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Happy New Year and Merry Christmas! :)


With regards,
Pavel Skripkin

---
 drivers/input/mouse/appletouch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index bfa26651c0be..627048bc6a12 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -916,6 +916,8 @@ static int atp_probe(struct usb_interface *iface,
 	set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
 	set_bit(BTN_LEFT, input_dev->keybit);
 
+	INIT_WORK(&dev->work, atp_reinit);
+
 	error = input_register_device(dev->input);
 	if (error)
 		goto err_free_buffer;
@@ -923,8 +925,6 @@ static int atp_probe(struct usb_interface *iface,
 	/* save our data pointer in this interface device */
 	usb_set_intfdata(iface, dev);
 
-	INIT_WORK(&dev->work, atp_reinit);
-
 	return 0;
 
  err_free_buffer:
-- 
2.34.1

