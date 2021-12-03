Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE4A467E2C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382860AbhLCT0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382867AbhLCT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:26:49 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC86C061359
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 11:23:25 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id n15so4446967qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 11:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/NfeKYIAhkUIAZJtgd6awxwNqUewAop8qMlhPdQIiw=;
        b=F+bvJUItKNdS/eTxqRFsYTDexgXI/WlDljElOv5rZ1FqdzNd6az6Wp/czLZQdFLjOD
         lHvZsZgt6E9hU7LI+B65d2ZU+suiM3hcuriSpE6E0LWvX8I0KAqfUtq/36ZvRlMgeIdK
         3HfXFp5U+I6bslWX14LrDiOGVY7iEOjiF9LGHcOZib7XLql84nyPoykoceLbod734csg
         qd8vcajozXjJ+y83I7VW8TYvAzqBnrbf/+9VM93/n0R5Ds7xq1TTKlnKYm0bmwtUS7aj
         LOGUV6d0skEhoIPsXCilztMkKXECKdNDMqcLyrI/RJxormDDNBCcpxBVZXQqzCK3vEGH
         qUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/NfeKYIAhkUIAZJtgd6awxwNqUewAop8qMlhPdQIiw=;
        b=Mkw7YvzBt+XARv8ug8QmEHndsLne+kXTdh1LRrwvREJMakjXhasDvk/eRFxBQey2B1
         7Z6B7RWBL4l2xziMM8VxTmD1ofv5nccKoDoooGPzxuk5kRy1gw7UcoZltXp31GVuAuMS
         VVz05rV5lXNHs8PGxkorR+ZetQeVDHuxFSa7/LlxhQsQuUGwnAVO/rQYaKqqVMzgrBxk
         VWg+RZanLz+5udmteTu6vBBDoZpq5aKBuUjV9xpmhYKkYmGH3HccUg9W8PrC3q6F6kE9
         bzK3qyfXkbxCdLlZbz9HvobSzzZx471zvwEb8rKmLI0y9GZbRPwq3Q3FX4z0Ie1xlkz8
         ttBw==
X-Gm-Message-State: AOAM5327Zb+tHT4+76aMkCSVcWtt8YWf6a0c9MwMwQ3kgUsp7hL3ibyd
        kkfdgRLvFEzMSMnQwFcV5NWXzLwP/V6juNncJWHZJsS3kkyRhkxcj+6C0jVhG3i+WovTrybCsRH
        nBkQR35xHjeQYNk/j8wgD71XYu5pi/FHAPnu5bng2AlA57jN9J2MqDeHLdvW2ElCQP98Kx2Qc3Q
        Rs3JCOXvXENIHHt2yo
X-Google-Smtp-Source: ABdhPJwnDlYpqgkf/Sf5zgNg//Uz5Zqh1xUeIEbLhDHGR1sxM6ZGnX3ghbkytQe24N4WA113II3Buw==
X-Received: by 2002:a05:622a:1a04:: with SMTP id f4mr23050973qtb.476.1638559404100;
        Fri, 03 Dec 2021 11:23:24 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id w10sm3099663qtk.90.2021.12.03.11.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 11:23:23 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v3 5/5] drivers/node: Show in sysfs node's crypto capabilities
Date:   Fri,  3 Dec 2021 16:21:48 -0300
Message-Id: <20211203192148.585399-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
References: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show in each node in sysfs if its memory is able to do be encrypted by
the CPU, ie. if all its memory is marked with EFI_MEMORY_CPU_CRYPTO in
the EFI memory map.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 drivers/base/node.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index b5a4ba18f9f9..67b0e2fa93b1 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -560,11 +560,21 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+static ssize_t crypto_capable_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct pglist_data *pgdat = NODE_DATA(dev->id);
+
+	return sysfs_emit(buf, "%d\n", pgdat->crypto_capable);
+}
+static DEVICE_ATTR_RO(crypto_capable);
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+	&dev_attr_crypto_capable.attr,
 	NULL
 };
 
-- 
2.30.2

