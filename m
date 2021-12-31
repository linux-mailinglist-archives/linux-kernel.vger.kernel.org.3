Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30516482561
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhLaRWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhLaRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:22:01 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3A2C06173F;
        Fri, 31 Dec 2021 09:22:01 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id h1so17336251pls.11;
        Fri, 31 Dec 2021 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nps+WNx8C15ufScj3uNO99ieEChaDSrcgseTuNPXLa4=;
        b=p9S7kg7ARWTJjp0Er+NBCT3ZYaopx6eiXNjLquQON2byOommzA+wBwlqBHWJf/lynL
         J+Xb3W+p6k6bYKtsosx6kOMVvFScFYHxpYk+PP49D1Dl0e6dfzHCsMJ8/IHzxnerBXGz
         4s4IWcRn38hVnSWcuSuXrW/3ZHPvNXT1QAqxGrbjWugEA4IsCva6rPKbFDxvx5j4L+sU
         PHAXCxPNKzPQ/n8dxEGBKXaF75Qmjfj7VgfjoFn3yfwLAtQjcO3CVGz2JJ4MW1gYPNST
         51y89CGT037H06052qkiSyhgLavhIDbcmLoVkXkWDNZe06JY1mdkYazXFlvl+ZxnrTOE
         oCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nps+WNx8C15ufScj3uNO99ieEChaDSrcgseTuNPXLa4=;
        b=bJJXnk54CEHRo8EZVidndy8nwivsi3I3KsM0a7VIRGh7IXTh4YgHhn5JuEDTqWek3I
         w371Ql7H3k50WgSE2QTmBOK5UrtukCrLevT9H5qhDefFnCGzllsYwzomJVEPeibqcb20
         /e6S/ve4Jk+RlnI6OzAtbIayxHSoZW07J6K3tqHHJAoE2xO+ApNtheoEBHOlG4196PyJ
         wepVFiSZ5Dn9iYnSlXA18u7HBj/+u6uuqbbgisJ5WDlaiwcptOnITMBgqKogPBR/ZOaD
         fzeDsBrPnpVGy2BzZ8ECp2UCAP4LUXiQQrzXYnsCIxpDZ4fMSROWWlr9QY4tlaVCFxid
         XyqA==
X-Gm-Message-State: AOAM5339t42O1n2XRSllQTG2RNBd2x4uc/PKDza3wP9p+cNNVklMMv7O
        QnVrXDYtkqb+2HQLICdyh5E=
X-Google-Smtp-Source: ABdhPJwYjfKFuXKbcjCgxOZAHWxSFaMYvex4xw0OBOAxFEBZoEdUb8SCRbKykB+Gyet7mRss8pKFBQ==
X-Received: by 2002:a17:902:6b03:b0:149:7dd8:e56d with SMTP id o3-20020a1709026b0300b001497dd8e56dmr24602229plk.29.1640971320799;
        Fri, 31 Dec 2021 09:22:00 -0800 (PST)
Received: from localhost.localdomain ([125.118.132.4])
        by smtp.gmail.com with ESMTPSA id k141sm30145834pfd.144.2021.12.31.09.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 09:22:00 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v4 2/2] usb: gadget: clear related members when goto fail
Date:   Sat,  1 Jan 2022 01:21:38 +0800
Message-Id: <20211231172138.7993-3-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211231172138.7993-1-hbh25y@gmail.com>
References: <20211231172138.7993-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->config and dev->hs_config and dev->dev need to be cleaned if
dev_config fails to avoid UAF.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index eaad03c0252f..25c8809e0a38 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1875,8 +1875,8 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 
 	value = usb_gadget_probe_driver(&gadgetfs_driver);
 	if (value != 0) {
-		kfree (dev->buf);
-		dev->buf = NULL;
+		spin_lock_irq(&dev->lock);
+		goto fail;
 	} else {
 		/* at this point "good" hardware has for the first time
 		 * let the USB the host see us.  alternatively, if users
@@ -1893,6 +1893,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	return value;
 
 fail:
+	dev->config = NULL;
+	dev->hs_config = NULL;
+	dev->dev = NULL;
 	spin_unlock_irq (&dev->lock);
 	pr_debug ("%s: %s fail %zd, %p\n", shortname, __func__, value, dev);
 	kfree (dev->buf);
-- 
2.25.1

