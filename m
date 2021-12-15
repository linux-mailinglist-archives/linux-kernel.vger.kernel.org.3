Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D4475DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbhLOQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244974AbhLOQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:42:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3224C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:42:04 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id f74so3820351pfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=twHkGtbZ/4TAT9UJF4rb85KYB1yDtANe5IeqA4O27RQ=;
        b=VSSHlZ4Cm1kE0LlkjpF79TezRsOcCbqa+waw7+xIKfNskBGTGbJVEhBUwBu/Dd0qWq
         8pB5hOOdqLI/tP88lfQgzSBh4HKxKvfotIwI0ZUOxIqQDibLPdmzpDYW3U5XTj4WDeWg
         CvLSNkKXSCurFF01LAsFvUW8O4okUR3uNuf0VF52uELM/6qE7AIoMJzl/yWjWz+SsLKX
         QcqwSs3dAL5pw1PFR5BH3mUyqgG04DzxEcXkMlGSIOj8YEDvUzl5LCpkmDuTh3B6zlxj
         2QoF7MHznUPUE99iKI1d1xhWKz8TNNHQYYSk9AuWD4BcDtQusj/1x+9lUt/qD2C4BS7w
         CfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=twHkGtbZ/4TAT9UJF4rb85KYB1yDtANe5IeqA4O27RQ=;
        b=qLJqyTp6yoxF9lQUYuXjNnVweZYyvIPWUX6MRSIfF+G6M63/476eg2SNOOXocbT962
         BGwWgegjgEC2qUegNGGz2qUmAwZRpk0lgrTyfkJctyNbMvqX6c7eAnKSgGf3X5lWTxG6
         UdRaRrw6uwY+cTCXUy6lNz3iOoJOilmaOKABHLSqE24Snz8DpbKQlHJ9ADDfvCDsvjF0
         uAg50ZBmH2GlbwQ+w4rllLhKePwDLApiTCIGu1UpuVKtrJp2rA6zINQZ+Y7hLWHUaO53
         2g3vuW/0GQAw8GtE/JlTpoCpyhc/23X7nFVXMIcD+770zoyj1CcK1VPKWew+odWJNBzN
         MqzA==
X-Gm-Message-State: AOAM532uzkSCdGpOCrpZ522cMMjOPbC9XApTzEo5rONY7cjSxGz0fthL
        0yHjYosYbj7Cg/VMp1J6xa6gRpGqLis=
X-Google-Smtp-Source: ABdhPJxZ3UqgJ8pfN51sBTuQJFzDf4hI4q1vnyZa3JBsW10ZCEg1+z1CMzXhc2M9Sv6XARCwVPlW5g==
X-Received: by 2002:a63:e43:: with SMTP id 3mr8611068pgo.73.1639586524479;
        Wed, 15 Dec 2021 08:42:04 -0800 (PST)
Received: from pc ([223.197.3.99])
        by smtp.gmail.com with ESMTPSA id ot7sm6797174pjb.21.2021.12.15.08.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Dec 2021 08:42:03 -0800 (PST)
Date:   Thu, 16 Dec 2021 00:41:57 +0800
From:   Zhaoyu Liu <zackary.liu.pro@gmail.com>
To:     ddstreet@ieee.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] zpool: remove the list of pools_head
Message-ID: <20211215163727.GA17196@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list of pools_head is no longer needed because the caller has been
deleted in commit 479305fd7172 ("zpool: remove zpool_evict()").

Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
---
 mm/zpool.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/mm/zpool.c b/mm/zpool.c
index 6d9ed48141e5..68facc193496 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -24,16 +24,11 @@ struct zpool {
 	const struct zpool_ops *ops;
 	bool evictable;
 	bool can_sleep_mapped;
-
-	struct list_head list;
 };
 
 static LIST_HEAD(drivers_head);
 static DEFINE_SPINLOCK(drivers_lock);
 
-static LIST_HEAD(pools_head);
-static DEFINE_SPINLOCK(pools_lock);
-
 /**
  * zpool_register_driver() - register a zpool implementation.
  * @driver:	driver to register
@@ -195,10 +190,6 @@ struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp,
 
 	pr_debug("created pool type %s\n", type);
 
-	spin_lock(&pools_lock);
-	list_add(&zpool->list, &pools_head);
-	spin_unlock(&pools_lock);
-
 	return zpool;
 }
 
@@ -217,9 +208,6 @@ void zpool_destroy_pool(struct zpool *zpool)
 {
 	pr_debug("destroying pool type %s\n", zpool->driver->type);
 
-	spin_lock(&pools_lock);
-	list_del(&zpool->list);
-	spin_unlock(&pools_lock);
 	zpool->driver->destroy(zpool->pool);
 	zpool_put_driver(zpool->driver);
 	kfree(zpool);
-- 
2.17.1

