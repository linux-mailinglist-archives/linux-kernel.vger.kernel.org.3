Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9E1481956
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbhL3Eih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhL3Eif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:38:35 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DD0C061574;
        Wed, 29 Dec 2021 20:38:34 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r5so20440079pgi.6;
        Wed, 29 Dec 2021 20:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVwajQHhZd85KIJ2Q7ggiBUzMG1h9q9fZGknQXtFqUc=;
        b=TS+iO9SZIgGR4ABvM2YsSTMoO5vHWMQCyFtNPXXNK+thw0d0zhed4V9htc02CgQtRU
         +zBFOlMOjWH/bYxIQxQ8qKf9mut4hQgMov7EpIx7Bzv4c7uZINiMFQj5vC0AXjBHbCTI
         TZW8lRhHXU5dPPnSpjkcGNuFKCWzEdsHbZxHZqo8ulOJGaJd7HpEG8z6GBWpUnMP7SRL
         GH80kBDYN03PNICmYbJ6o2c/1uOrSq6XC4YGa4nzDzhIR4bJ7s5HdodKHusR6zI9XZFS
         bsnjdsbBJTz4glPN7mLHKdC23JBGefaiCRrJLONwGK/fdDRtSYz4SVNFO20CwC74Kt+n
         ce1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVwajQHhZd85KIJ2Q7ggiBUzMG1h9q9fZGknQXtFqUc=;
        b=51cQgF01a4onpOyVNJNHKRYBrISRoqtZaDlSyN+3VY+m9zLhUCt9YGN1fpXKd4PgdF
         qAAEpEfaimShnWrlWZg1SCOsvvzAuyHNRFPqpbN5KIoTjgC3Ia/DhYdys6SnXkHXNTpZ
         PgWYRsKO49IO4Pv6elRl0uRuzTjJZicJvr9lQeQbjumA/4GvAD3Qq2toLtO4HUXdWuLa
         SAwh1XQ04WlSELDcWAUroWa8ScunPf/MEnpqVavR9Qnq1PdVnD8ITQ3KRQiqT85+Luah
         4sv9fcmomQLryAIXCDCHytzsradkWihPqzrLbe+7qJ6QgiJozQBaaAIRUChkzBcsANKz
         kuyg==
X-Gm-Message-State: AOAM530YXrhwD9BHze5KsBHm8hAKMBs14PtlnKoaaeTt6wLOMBnV/yx1
        9jn7hXzdxNl9W/X0aEMduTc=
X-Google-Smtp-Source: ABdhPJyB5Qg3SQxEKWYuJ0vJhppHCXVdX3sqRKGoGAANxMAQ/rvd/StWMHPyt2/nDx2QKIxRznEXcw==
X-Received: by 2002:a63:3d84:: with SMTP id k126mr24954326pga.410.1640839114606;
        Wed, 29 Dec 2021 20:38:34 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id g16sm22828808pfv.159.2021.12.29.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 20:38:34 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 1/2] usb: gadget: don't release an existing dev->buf
Date:   Thu, 30 Dec 2021 12:38:14 +0800
Message-Id: <20211230043815.18899-2-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230043815.18899-1-hbh25y@gmail.com>
References: <20211230043815.18899-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev->buf does not need to be released if it already exists before
executing dev_config.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 3b58f4fc0a80..564352035ac1 100644
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

