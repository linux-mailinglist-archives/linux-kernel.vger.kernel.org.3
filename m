Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63632481986
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhL3FLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhL3FLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:11:51 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71AC061574;
        Wed, 29 Dec 2021 21:11:51 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v16so20384012pjn.1;
        Wed, 29 Dec 2021 21:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EmxtRCBMu2tl5deRcbELWxHEnqJDX4005AuwU/ExKFE=;
        b=cwFr7pePmZ1OSxQreJRsjeft07oYlRELfu6jlBs2W5N0BVQ2YHy814Omn7LgcFaNH1
         mueUvptlujnJExax2RwRnHRVD54OGtXju+ZeKRYrXFjsYsj7yxRxx35V/qdfAvskreN0
         QbfGfrhrLQ8gWtwl/mMX2J7n2RdcNde2XsrlBzBRf9dxpA5QadEcdkR3zZ8Ww96+81k1
         zhiw0Gh3RlGBLeN0VTPOWgN6e39ILM/8Fw6dzwLQI5dHdhbBznOFVAbSe2NSaNI39FdS
         m8qJBeTYfSWczA8itB/jxy10nMY7OtN/egyw4L6EoJygd0jGCC8RryAoeDAWjfIegvEz
         ENJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EmxtRCBMu2tl5deRcbELWxHEnqJDX4005AuwU/ExKFE=;
        b=Gielxm1BzZdo2occXl61DfxyvUOxb8Ofa1tahMRB4M1C3hdMcPkwDZ7G8WolpzINjS
         2zD82ZDMD4GcO4Zg/eA6vwY3dQYkWBOtXeMET9ZZ1LS62ILM6KdfXSGPD1Nwl99XiUx6
         El+yDvFCxPNEAE/2uKTLjdLNqmaMllcWHllWJHRnKEhRVIiUZWPi37Pkp5os6jkrYaUh
         +Tf7YWOiEk+GXT74dVlZS6LpwzWC1TaAeuzyou4RKPi3Aksj40wG8VBUxf7+kAgZlXTY
         iRdjniCcE00icsr7npPpQOuyrwsveLM8A4DlF0q6oTzoF5ftAJDF2rlTK9ZqcUJqdCOX
         aNsg==
X-Gm-Message-State: AOAM5313hcdmKA3+5NPMC/sibXivHLvAtkl0g5/34eoRKnZUSuZkibQU
        FHSya56u6R0LBHMIES696Nw=
X-Google-Smtp-Source: ABdhPJxRnUv3bGDRbyONTrwj2fITEPmpDqjrSYnNvc3moaFQuDdZ4V8Q1Bd+xZgmb1wiyga5kleDbg==
X-Received: by 2002:a17:902:8c83:b0:149:8ef6:b2ff with SMTP id t3-20020a1709028c8300b001498ef6b2ffmr12190337plo.32.1640841111214;
        Wed, 29 Dec 2021 21:11:51 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id e21sm10365925pjr.4.2021.12.29.21.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 21:11:51 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v3 1/2] usb: gadget: don't release an existing dev->buf
Date:   Thu, 30 Dec 2021 13:11:31 +0800
Message-Id: <20211230051132.21056-2-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230051132.21056-1-hbh25y@gmail.com>
References: <20211230051132.21056-1-hbh25y@gmail.com>
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

