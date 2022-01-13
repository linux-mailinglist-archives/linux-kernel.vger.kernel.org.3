Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12B648CF93
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbiAMAOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiAMAOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:14:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A308C06173F;
        Wed, 12 Jan 2022 16:14:34 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f141-20020a1c1f93000000b003497aec3f86so2625308wmf.3;
        Wed, 12 Jan 2022 16:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrycIVytOAWKwlTZ8w/ilWkQGwSx5+f1dHu/8y6N/pg=;
        b=a5njH7Cztbo3QbtdGcyKyoTMyUtlQJsxqlzKkWKEIfbWXIsN71da5Z/xrNnGXkCf02
         g1Em62HCYMugKat3UKDt/LZu3XMEaqlybt+gLzPfyFBHJhdrrnmgDrTRzlMSxekNtaZf
         YtFe+WRGbXF/EO7hGdJ1/gQuwtdMhG8Lj3sVOIomo8rQa+cLHlgPHQz5eVgLp70/jnoj
         6Hhy85tZnyfANAw1RyglEUob4q+sl79VTXnwMQ2KpYknTZv/Tgd4GsMPbJQqyQOA4WpV
         i5qcHpHpQVP+d0Xvmxtc/ORerQIP7N5lx6j7E0mFDwMK2FYoLTbGRXi8kFt+4KVm0T+4
         /Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nrycIVytOAWKwlTZ8w/ilWkQGwSx5+f1dHu/8y6N/pg=;
        b=j8ix3Ld2AhABhXUH0ZObs0w7pm5lg8tKRcHP8TjTFBOczpxTqN61FABaGweFErvz2c
         ur+qsRaZVRU3KI7djDbSCJLnNiC3CoYDFHHm7f/xBARU/2+c94uiM10J2ZTQGLxlcXzA
         CQfq6oMqWfGQRjSAU59Q7Y2ExqpRPgUyCKKOYygc3IE7o1QEN9+INrAdZqSZ1WtmmX7f
         CGfe0JgUWRu+H3bAKUbyDs0H+BXji1eul2spvuw23o11tWZZyEPMZCPq3EGjxs9NAsyh
         ImL2C/Q2yvqX8Wjfq1poLqMN7e9lQdO7Phr07TDUqXRTJypi9bA5oNXONXwuZr4PVUnl
         gplw==
X-Gm-Message-State: AOAM533IpkKNzBP2hgyeuJqbpRyf8ZG6uslACOKrIk/kCOSmrddzrysC
        6EXKJ+95pBgKd1yd2BBow8GHfdmDJND1vQqc
X-Google-Smtp-Source: ABdhPJzFRXF9OXm4/EgGBsukO61paY1VNAwGvoqc5gvww2Qjl1zPJXbwmOs2F+J66qK1yHYXQaSWcQ==
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr1573262wmq.64.1642032873277;
        Wed, 12 Jan 2022 16:14:33 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bh26sm6581197wmb.3.2022.01.12.16.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:14:32 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] loop: remove redundant initialization of pointer node
Date:   Thu, 13 Jan 2022 00:14:32 +0000
Message-Id: <20220113001432.1331871-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer node is being initialized with a value that is never
read, it is being re-assigned the same value a little futher on.
Remove the redundant initialization. Cleans up clang scan warning:

drivers/block/loop.c:823:19: warning: Value stored to 'node' during
its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..01cbbfc4e9e2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -820,7 +820,7 @@ static inline int queue_on_root_worker(struct cgroup_subsys_state *css)
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
-	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
+	struct rb_node **node, *parent = NULL;
 	struct loop_worker *cur_worker, *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
-- 
2.33.1

