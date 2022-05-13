Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A035526370
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiEMOIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiEMOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:08:11 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE462CEB;
        Fri, 13 May 2022 07:08:10 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e24so8191723pjt.2;
        Fri, 13 May 2022 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TWXXrbAm4PpaLqldYWgYCPhU0WPhNfiQs7deWJmTcog=;
        b=AFqSFrObrsA8pWWGIrBdouSjPKruwQEb+IPH6K4vtZV37Er00YDCWOAeTiZlUkRCmn
         DRRBUx5Ad83gRyF8U/pFy1OnLyXPSASRlgf4b1n3cv3T+FbZ4r9X4bHXS53k4ahkvr6v
         E6+LP/EjxS9mNAoLLmtpaFI5FMiN/RS73/LnGMa3Ic3ZSQOVmLLKcfEDMonogRh2WhGT
         jTJFHninjF5gTkX0YrZYJh4cwZ2PEtP6QoS3WXlhcBZF6X11RCqBcQkFxSRM7A1eZP46
         GY6bfwewM7IwnQJCV+PNqFLQSRjMMFQyBV0Ul7lhrpspP0y4mnHr8vxpd4te8evzw1DP
         ywvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TWXXrbAm4PpaLqldYWgYCPhU0WPhNfiQs7deWJmTcog=;
        b=n8EeNo5fCz3n2TQM8UyEP3t996U1xIH1cokwsuGgrZGpKeqhvgyGAHbGVKMZSTh1ad
         dej1oXttGaCF3sj+8YbB6zQDyDgKfu9TCfFqd21gjRaTR04Blh+k2feqhjDEtbY88JQd
         szjxySipTgH/iaFwFWWBqDtLM9UKkhK+KJbSpIT/+wLbg1UPTg+YMnxrUu2ZnUcwpFH2
         dIC12f00C0Zhu/l5LGcGKuoD1GQAnRDbghhJoEq1nOPEfLOJZb/njwjJjfeqJjKb7tGJ
         +noB1cuYtj/i3dN3r4/uA6wg6RhwPgGoQJJ/kuE/jB0DdY/m6Y69dZVNXRAZH6dKeCCo
         IhcQ==
X-Gm-Message-State: AOAM530x2ILiX45WGxDZ7HbtqyBz/7rtBZ1CmOc/DvMqC+6FZp3/bbcu
        Ka7XH/zxktwQnffn18P3boPQvpk0wVrTjHk=
X-Google-Smtp-Source: ABdhPJyzWYb/pCkLBPu5qAWPUietF1DSuOxx/ffN0+H7t5MC1tJkCsrSkUv7+jXZE1CzwwRnkMqYjA==
X-Received: by 2002:a17:902:7144:b0:15f:3d88:d79 with SMTP id u4-20020a170902714400b0015f3d880d79mr4793763plm.86.1652450889516;
        Fri, 13 May 2022 07:08:09 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id q24-20020a17090a2e1800b001dc7623950csm3657458pjd.11.2022.05.13.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:08:09 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] Bluetooth: bfusb: Check the endpoint type at probe
Date:   Fri, 13 May 2022 22:07:59 +0800
Message-Id: <20220513140759.2196755-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513124303.2192981-1-zheyuma97@gmail.com>
References: <20220513124303.2192981-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver reported an warning in usb_submit_urb() which is caused by
wrong endpoint type.

usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0
RIP: 0010:usb_submit_urb+0xcd9/0x18b0
Call Trace:
 <TASK>
 bfusb_rx_submit+0x24e/0x390 [bfusb]
 bfusb_open+0x50/0x90 [bfusb]

Fix this by checking the endpoint type at first.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Format the commit message
---
 drivers/bluetooth/bfusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index cab93935cc7f..447b6876c552 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -613,7 +613,9 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	bulk_out_ep = &intf->cur_altsetting->endpoint[0];
 	bulk_in_ep  = &intf->cur_altsetting->endpoint[1];
 
-	if (!bulk_out_ep || !bulk_in_ep) {
+	if (!bulk_out_ep || !bulk_in_ep ||
+		!usb_endpoint_is_bulk_out(&bulk_out_ep->desc) ||
+		!usb_endpoint_is_bulk_in(&bulk_in_ep->desc)) {
 		BT_ERR("Bulk endpoints not found");
 		goto done;
 	}
-- 
2.25.1

