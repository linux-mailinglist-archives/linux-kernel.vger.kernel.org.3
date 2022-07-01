Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8187F562923
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiGACdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGACdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:01 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F97F599FE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:33:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id h5so597504ili.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8nL+5PyNvVLU/q8vWhWVQWdYG+EWKXWaXejHBXOYMw=;
        b=BJJXm6Qmi0WzvybE9icbWzowY0jGoTjqUdbbA6Cx88x87VdIaLMXtZqi+QrFq7XK/5
         MyNr3CjZWJzK14DhuHjD24UX3pTBb1qy0XylRetjZzAx6GHBeCjXTzHzMa8kCAObgpnz
         3VxWAgvFRtO/VxmHxhFJCv74Qsz3YKri1YH1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8nL+5PyNvVLU/q8vWhWVQWdYG+EWKXWaXejHBXOYMw=;
        b=UREB5WlDunjttH7MhG4AUIRr7yC7YMKTAQEC40TAaatYubUFu68PA9fMeOCRTRInNZ
         5bLDOc2X8vpStsCGW0nvcPRYwpxUgPbK7j0miBXuUHMtuAz4yMFZMIsOxM6RIJoD027O
         EdPYhzY1koz4MoTzV6R1SqtoFHbf4gaD3zeFO7HfUmxoLZGS9+S28XkJvLhnyz8EJXcc
         8+3tvsxfTbvb6orXFIf9kbj2O5NA0RsFDRwRsMDAWliabRt/sce7XuT1d2VkVAFQ6WD2
         Xkb/790j8KkrLxH6uu+7OvQSa1ooMn3vs+9l8LBRN2+LL2u5ojvS7MsPi0dXwx/sHVGo
         ZgSA==
X-Gm-Message-State: AJIora938Ids4HOvFKmotX1AVNZ3pRSwCaD7xw1PMuDB0HA6dD07h0na
        LJ68yhUq6Hd9esyhkpl/kC/0aYPlgln36A==
X-Google-Smtp-Source: AGRyM1v4k3j+4tBfy70LkrBZQtW2Ydsf6vbHrZdh9inMgRaj6VqDDyiAx1DK3kLr65pyqx0tMYix1g==
X-Received: by 2002:a05:6e02:154a:b0:2da:8a02:bcba with SMTP id j10-20020a056e02154a00b002da8a02bcbamr7136186ilu.167.1656642780667;
        Thu, 30 Jun 2022 19:33:00 -0700 (PDT)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a22-20020a027356000000b00331cfbce17csm9367869jae.100.2022.06.30.19.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:33:00 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] misc: rtsx_usb: fix use of dma mapped buffer for usb bulk transfer
Date:   Thu, 30 Jun 2022 20:32:55 -0600
Message-Id: <667d627d502e1ba9ff4f9b94966df3299d2d3c0d.1656642167.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1656642167.git.skhan@linuxfoundation.org>
References: <cover.1656642167.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtsx_usb driver allocates coherent dma buffer for urb transfers.
This buffer is passed to usb_bulk_msg() and usb core tries to
map already mapped buffer running into a dma mapping error.

xhci_hcd 0000:01:00.0: rejecting DMA map of vmalloc memory
WARNING: CPU: 1 PID: 279 at include/linux/dma-mapping.h:326 usb_ hcd_map_urb_for_dma+0x7d6/0x820

...

xhci_map_urb_for_dma+0x291/0x4e0
usb_hcd_submit_urb+0x199/0x12b0
...
usb_submit_urb+0x3b8/0x9e0
usb_start_wait_urb+0xe3/0x2d0
usb_bulk_msg+0x115/0x240
rtsx_usb_transfer_data+0x185/0x1a8 [rtsx_usb]
rtsx_usb_send_cmd+0xbb/0x123 [rtsx_usb]
rtsx_usb_write_register+0x12c/0x143 [rtsx_usb]
rtsx_usb_probe+0x226/0x4b2 [rtsx_usb]

Fix it to use kmalloc() to get DMA-able memory region instead.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 drivers/misc/cardreader/rtsx_usb.c | 13 +++++++------
 include/linux/rtsx_usb.h           |  1 -
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index 1ef9b61077c4..e147cc8ab0fd 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -631,8 +631,7 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 
 	ucr->pusb_dev = usb_dev;
 
-	ucr->iobuf = usb_alloc_coherent(ucr->pusb_dev, IOBUF_SIZE,
-			GFP_KERNEL, &ucr->iobuf_dma);
+	ucr->iobuf = kmalloc(IOBUF_SIZE, GFP_KERNEL);
 	if (!ucr->iobuf)
 		return -ENOMEM;
 
@@ -668,8 +667,9 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 
 out_init_fail:
 	usb_set_intfdata(ucr->pusb_intf, NULL);
-	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
-			ucr->iobuf_dma);
+	kfree(ucr->iobuf);
+	ucr->iobuf = NULL;
+	ucr->cmd_buf = ucr->rsp_buf = NULL;
 	return ret;
 }
 
@@ -682,8 +682,9 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
 	mfd_remove_devices(&intf->dev);
 
 	usb_set_intfdata(ucr->pusb_intf, NULL);
-	usb_free_coherent(ucr->pusb_dev, IOBUF_SIZE, ucr->iobuf,
-			ucr->iobuf_dma);
+	kfree(ucr->iobuf);
+	ucr->iobuf = NULL;
+	ucr->cmd_buf = ucr->rsp_buf = NULL;
 }
 
 #ifdef CONFIG_PM
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index 159729cffd8e..a07f7341ebc2 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -55,7 +55,6 @@ struct rtsx_ucr {
 	struct usb_interface	*pusb_intf;
 	struct usb_sg_request	current_sg;
 	unsigned char		*iobuf;
-	dma_addr_t		iobuf_dma;
 
 	struct timer_list	sg_timer;
 	struct mutex		dev_mutex;
-- 
2.34.1

