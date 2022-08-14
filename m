Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0AE592025
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbiHNOZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiHNOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:25:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2410545;
        Sun, 14 Aug 2022 07:25:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id k14so4861300pfh.0;
        Sun, 14 Aug 2022 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cmiC4GyXrivAdN89C1L8XiqqWpho7GqZlZeaKyCMglU=;
        b=iW7PUTkWbQ4GdHHEteuCNQQ5Ss7ljIOtKksm4RzTJDCRMkFQ216uH9eyBZ2pMHgX9g
         PuNmNy51O5WWstLXa0FBpetTeHuSGSgl1VKN6FAvouYLBuiUerRTuHGUXVf2liVticay
         NmUUq3xL7EiuE6XJXJB5otVI+ST8+hjNF4J+gCF/8YjDvLGPcPLiZKC+7OfA19SLMBIv
         ddLNMlG1E3UDFQleHPX5KNluWSKFhQ7b7qCRVdJ8tHNHzlJGR090oBkuHIuUTD7E6i3z
         QWWa6wvoTrbbBFCWbxBVes1c7haTDs/qD2qZIlC2p5lTzK2RPl0HbtC2aCNZxUn0+yNP
         2uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cmiC4GyXrivAdN89C1L8XiqqWpho7GqZlZeaKyCMglU=;
        b=wXJqUw2KVXkvVf7dyNAP8qzjIDcP2Tv3jua2MoMYPmhl3DDSCymCkumWIQIHC+YIqI
         HMPNb1sHRtrfgIN0HUwvv+FTdiToXTaqMCaz+ACgxKpGr9Jhar18VNDKzaHKjbP88QUr
         zQQzXGMCM0yO44FHYlYsQZeSQwpDqSiHmp7yIhYkrPF0MQ7Jv2vxQrBJYBNxv9g3xe9r
         AdAwhKkkqEYSR8zWc+Uo4kekngSIr0zv6+dypiYauXk8+CFwRSA3E3DvgkR0l+KuCpK3
         TyQlJoK4QEDvlHl0sglk9L/9tJZzGouP+4o9jVzcaApKwtnRQCl8ikrajhSCy+WT3gwW
         22dg==
X-Gm-Message-State: ACgBeo16nMRgNE48FbrghtVpkTl6JYEQGPDYqx1rfSDe0KGHU95d2Sbv
        sTysqA6/yyLuKyGS/bnNnLw=
X-Google-Smtp-Source: AA6agR5oNGtoZK4xcKJgsKFitJ58zTxZ2oiNPpciipm5RltIv8qLg6CwX2m+LTMXM1+WO4RhZqI7NQ==
X-Received: by 2002:a63:1208:0:b0:423:c60e:ed09 with SMTP id h8-20020a631208000000b00423c60eed09mr6082759pgl.385.1660487150954;
        Sun, 14 Aug 2022 07:25:50 -0700 (PDT)
Received: from biggie.. ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902ea0600b0016dc6279ab7sm5491340plg.149.2022.08.14.07.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 07:25:50 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     sean@mess.org, mchehab@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com,
        hdanton@sina.com
Subject: [PATCH] drivers/media/rc: Ensure usb_submit_urb() is not called if write is in progress
Date:   Sun, 14 Aug 2022 19:55:42 +0530
Message-Id: <20220814142543.24910-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning "URB submitted while active" is reported if the function
send_packet() in imon.c is called if a write is already is in progress.
Add a check to return -EBUSY in case a write is already is in progress.
Also, mark tx.busy as false after transmission is completed.

Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")
Cc: hdanton@sina.com
Suggested-by: hdanton@sina.com
Link: https://syzkaller.appspot.com/bug?id=e378e6a51fbe6c5cc43e34f131cc9a315ef0337e
Reported-by: syzbot+0c3cb6dc05fbbdc3ad66@syzkaller.appspotmail.com
Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
 drivers/media/rc/imon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 735b925da998..a5b997c2c7e2 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -598,6 +598,8 @@ static int send_packet(struct imon_context *ictx)
 	int retval = 0;
 	struct usb_ctrlrequest *control_req = NULL;
 
+	if (ictx->tx.busy)
+		return -EBUSY;
 	/* Check if we need to use control or interrupt urb */
 	if (!ictx->tx_control) {
 		pipe = usb_sndintpipe(ictx->usbdev_intf0,
@@ -654,6 +656,7 @@ static int send_packet(struct imon_context *ictx)
 			pr_err_ratelimited("task interrupted\n");
 		}
 		mutex_lock(&ictx->lock);
+		ictx->tx.busy = false;
 
 		retval = ictx->tx.status;
 		if (retval)
-- 
2.34.1

