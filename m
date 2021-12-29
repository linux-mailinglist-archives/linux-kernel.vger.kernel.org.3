Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC10481309
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhL2NKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:10:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46734 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238590AbhL2NKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:10:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC42614AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D96C36AEC;
        Wed, 29 Dec 2021 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640783431;
        bh=kpBr7XACXxAFZN5kDwVDdUSWedkX+AtEw87rcFRtVeg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tj7VsdtUIaRI0eXkrtNV5KFNQ7u0xol3+a8R1Ye3HbVHY2b07SCnHHQLotoY9ys93
         9o3ovQr5KiP4Ckzo+Fe3Jin3EPc3qmGb8rg2FmyaU5sK8dqf6IbTeFB0MrVKnArAMz
         NOP6RjuLpyp1La+aaLkhDYoygde708hsCMMx1f9Bw+8sMMPd1DKoRo9FEq6dGSxhWQ
         WxEaCcV3LbrCYTmbcoGU7DIOIpjUuIgIM9xngCC1UXCq6HKM6Q1zWOKYVS7JeUIjID
         rgfysXxhRgzfYHTaJOiFPmOX/FyMHRD8nyks8+UCKeTwaPC4IiuCWjXJUTloG4ltxm
         YuXqBFAS/5QXA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/4] mm/damon/dbgfs: Remove a unnecessary variable
Date:   Wed, 29 Dec 2021 13:10:13 +0000
Message-Id: <20211229131016.23641-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229131016.23641-1-sj@kernel.org>
References: <20211229131016.23641-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes a unnecessarily used variable in
dbgfs_target_ids_write().

Fixes: 4bc05954d007 ("mm/damon: implement a debugfs-based user space interface")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 751c7b835684..5b899601e56c 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -364,7 +364,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	struct damon_ctx *ctx = file->private_data;
 	struct damon_target *t, *next_t;
 	bool id_is_pid = true;
-	char *kbuf, *nrs;
+	char *kbuf;
 	unsigned long *targets;
 	ssize_t nr_targets;
 	ssize_t ret;
@@ -374,14 +374,13 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	if (IS_ERR(kbuf))
 		return PTR_ERR(kbuf);
 
-	nrs = kbuf;
 	if (!strncmp(kbuf, "paddr\n", count)) {
 		id_is_pid = false;
 		/* target id is meaningless here, but we set it just for fun */
 		scnprintf(kbuf, count, "42    ");
 	}
 
-	targets = str_to_target_ids(nrs, count, &nr_targets);
+	targets = str_to_target_ids(kbuf, count, &nr_targets);
 	if (!targets) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.17.1

