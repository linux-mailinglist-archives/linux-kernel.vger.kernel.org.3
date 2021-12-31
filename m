Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C214048255F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbhLaRV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhLaRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:21:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBF0C061574;
        Fri, 31 Dec 2021 09:21:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l15so5762411pls.7;
        Fri, 31 Dec 2021 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH7/znJuAvjmoXOH9/iovhb28LF4t90T+OYzsHpGtU4=;
        b=DnVfW6uPRgmRdenERNyB3F0cNpUyGTDiRVvBLwiXrfSpX2z6u7jUQ4S4Z0HzYws0DU
         egLD+QqPL9IWj/VYzLFIK41Pmf+IThvwd08maiNVVTfp2YGxLfsexcquXq7Ud9jbPDPK
         a3dLBDDWhmgFmDtd4CL5VvbG6HnsjOsAT0yxlg2g1ZPCr4A7PGy/Ogop5RZFyLAVo3wV
         qE3A5rB1qzAoIty+wMz7OcJH3PjRnk3OvBTThYQ+25QugRl/TUuArBxwoMLlvWBRlVh1
         qFjvDE+eI4pfBThOlDj5ytVlylSH0E5i8vHIp43SXTxTlfsbc0G1zK02asRnsdP+aBtB
         CXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH7/znJuAvjmoXOH9/iovhb28LF4t90T+OYzsHpGtU4=;
        b=68vbHbTt1qPzx9/VGck9XOdcZi/BtxD4vdi94iAnkG6FvcJfogywSStDL+t/i4Tz1V
         Uhh2DbnXJrM1I13IX2ZsvRIkt3h1SWMKn6/ZGTQbiGZvR1BxHJAN+/E+Oy2wFJTt7vvb
         UXmLuN5oGhoWwA7GCCWlh3a3Ij20r6jBwnq3bi0v3gNfM6BcFY+Mrb/3mAKYp930JYbY
         ubSqVQM5U+bc0w460asBtd6d6jGeNq3B5s1Y2CRBgusbHTrrIxaRXWtO1x2vAERqANYC
         lGv+MGEcqr1TCzMCPXYXcLn0fMEE0p+7gaEqzKgvV+gg3h6x/T4UvaKtmIpN4yrG0WM7
         GBhw==
X-Gm-Message-State: AOAM530mqWZYDcEfYrjmDX6EpHu/PeY+OBl8bMWphS1JlqZUjDptFYRR
        quFbJdMIlfvhiN0Nq9nsHV4=
X-Google-Smtp-Source: ABdhPJxKkbyv6Csv866QV9VEWk/J3CAKTgpYROwjPalxfzklw2+uDbhYSxZW2WZVdGkwYzJ9BcWz3A==
X-Received: by 2002:a17:902:ea02:b0:149:473f:ca35 with SMTP id s2-20020a170902ea0200b00149473fca35mr36318549plg.99.1640971317086;
        Fri, 31 Dec 2021 09:21:57 -0800 (PST)
Received: from localhost.localdomain ([125.118.132.4])
        by smtp.gmail.com with ESMTPSA id k141sm30145834pfd.144.2021.12.31.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 09:21:56 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v4 1/2] usb: gadget: don't release an existing dev->buf
Date:   Sat,  1 Jan 2022 01:21:37 +0800
Message-Id: <20211231172138.7993-2-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211231172138.7993-1-hbh25y@gmail.com>
References: <20211231172138.7993-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->buf does not need to be released if it already exists before
executing dev_config.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 3b58f4fc0a80..eaad03c0252f 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1826,8 +1826,9 @@ dev_config (struct file *fd, const char __user *buf, size_t len, loff_t *ptr)
 	spin_lock_irq (&dev->lock);
 	value = -EINVAL;
 	if (dev->buf) {
+		spin_unlock_irq(&dev->lock);
 		kfree(kbuf);
-		goto fail;
+		return value;
 	}
 	dev->buf = kbuf;
 
-- 
2.25.1

