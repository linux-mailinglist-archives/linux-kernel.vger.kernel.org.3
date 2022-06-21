Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8990C5538BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353087AbiFURR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353066AbiFURQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:16:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19FF2B1BE
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:16:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t21so7418230pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fs5s4JcJ+7OVLy6dPnCaAHxh/LbeQw/mzmnVnCYs5jU=;
        b=dTV2dYwI90sJL6IoPQwX2ej+S7VZ0SyJsWgey+NbaI5ofhR3zEw2DefJAen04k9Bf/
         8Wbdf/wdCU6paRVelxfwltwLeinGaVF4WZ26I3QQNVNrFo1w0q4WocCbjHjuqoMyRYHL
         NFcwgy+gvux8h+Tz82Cs6CzPjxyU3h+7loAV2LE3bLF3YoiCcW/yR92Vtu1AaOg7MNBm
         RGin2ZSr4RMDAq/Cq7MWnYTOXskxlj1JjdcNWVy9zW0fEZ6gYQTnKcyl4Joir26m2v73
         T4CmIpL2CeipqaS/KcmSntty89ZdcT88PPS9+8lVnr+tp7AVUS2iZOjjjMHV3Oz4EmOl
         LFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fs5s4JcJ+7OVLy6dPnCaAHxh/LbeQw/mzmnVnCYs5jU=;
        b=DyIXwgVK0o1p76MPi20V2qVnVf8lvIklGA5DDh2sQlhHu4FFNFAYiMpg2zT83vXxol
         2MuRaMv+uelTUMsLuA2xYwAFyAcJwo7dXQDOVEBOI6C5niDRcHGVa6MbdoQm5JmbHTGj
         jl/6CXroV5ESwYtRfnQ3HhUfE43xdBO66sCxi3YHTQd0x1xLGhU7ZWLNQ4kC9eRLRmSm
         FfBv3VxPvfWyK8exJDLivCLfLHs01FaFAEY3jYI0rGF/oOCIdGYU3Frd+GHxk7TZ/6QP
         zBCwzTUyDZvD8S3CbI+Tq4Kh2lPd1B+XItBucWcZjFssrQovCZyjmaEYKoZw98PDJDbu
         82Nw==
X-Gm-Message-State: AJIora+fUhsq0Me2YHx9WPVO5j05Dj2l2812lnbVqnIMGHAu9iTz0HRc
        62qKl55Dzn1LvxZDHxr9oqzQ9kktzHjxiWR5
X-Google-Smtp-Source: AGRyM1savgryE5QvJxpt5RmEz7m9ePaP9HX/xUs1NQ3VOCvtR0kEFvkWxqI2Q0V2e2NKSPT7xG3kuw==
X-Received: by 2002:a63:7785:0:b0:40c:c07d:6c21 with SMTP id s127-20020a637785000000b0040cc07d6c21mr9867927pgc.7.1655831791084;
        Tue, 21 Jun 2022 10:16:31 -0700 (PDT)
Received: from n131-251-240.byted.org ([121.30.179.156])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b001664d88aab3sm10843899plb.240.2022.06.21.10.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:16:30 -0700 (PDT)
From:   Zhi Song <zhi.song@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Jonathan.Cameron@huawei.com, kbusch@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhi Song <zhi.song@bytedance.com>
Subject: [PATCH v4] node: fix error handling in node_init_node_access
Date:   Wed, 22 Jun 2022 01:16:23 +0800
Message-Id: <20220621171623.1959231-1-zhi.song@bytedance.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_set_name() allocates new space to dev->name if it allocates
successfully. But if we failed to allocate space, there won't be any
new space for dev->name. Therefore, there's no need for calling
kfree_const(dev->kobj.name) in dev_set_name()'s error handling.

If we failed to calling device_register(dev), we just need to call
put_device(dev) which will do access_node freeing, kobj.name freeing
and other cleanup.

Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
Signed-off-by: Zhi Song <zhi.song@bytedance.com>
---
V1 -> V2: Fix up the changelog text correct.
V2 -> V3: Add a fixes tag line specifying the commit where this bug was
introduced.
V3 -> V4: Fix the error handling for dev_set_name() and
device_register() to perform cleanup correctly.
---
 drivers/base/node.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..0946931f113d 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -144,20 +144,19 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
 	dev->parent = &node->dev;
 	dev->release = node_access_release;
 	dev->groups = node_access_node_groups;
-	if (dev_set_name(dev, "access%u", access))
-		goto free;
+	if (dev_set_name(dev, "access%u", access)) {
+		kfree(access_node);
+		return NULL;
+	}
 
-	if (device_register(dev))
-		goto free_name;
+	if (device_register(dev)) {
+		put_device(dev);
+		return NULL;
+	}
 
 	pm_runtime_no_callbacks(dev);
 	list_add_tail(&access_node->list_node, &node->access_list);
 	return access_node;
-free_name:
-	kfree_const(dev->kobj.name);
-free:
-	kfree(access_node);
-	return NULL;
 }
 
 #ifdef CONFIG_HMEM_REPORTING
-- 
2.30.2

