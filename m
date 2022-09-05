Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF95ACE32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238008AbiIEIiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiIEIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:37:46 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 155EA19C20;
        Mon,  5 Sep 2022 01:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aoFbe
        myDU+f+b3BvxYQMAAfqeFTJORyFpOVWGzC12nw=; b=YPnxvO1Bh6Fm3CpwKWzZ1
        1AeAXCmPKbRHp/cKDik/DNzoJWNaZm7xzf8Qz6udj0x8ETQlp/cs54lbxzEG0fd1
        gelmaG8pykOzv8dMreaw4K07pPbAZ0MKWwsfbuqe8dBt5qVGmAidpa1AbzxR+ZM1
        L8gI5qw5XVQYbMArxAYm7Y=
Received: from localhost.localdomain (unknown [36.112.3.113])
        by smtp4 (Coremail) with SMTP id HNxpCgDnKLLwtBVjHqmWaQ--.30535S4;
        Mon, 05 Sep 2022 16:36:08 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] PM: hibernate: Fix potential memory leak in hibernate_preallocate_memory() and prepare_highmem_image()
Date:   Mon,  5 Sep 2022 16:35:59 +0800
Message-Id: <20220905083559.49438-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDnKLLwtBVjHqmWaQ--.30535S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7XrW3Jw1rCr1kWrWkXF48Xrb_yoW8JF1xpr
        Z5KF4DGr1vywnrJ397tFn5Ca47ZwsYg345W39Ivw1kuF13WrnYva1rJrWjgr4xAry0g3W0
        9FZ7Ww17XanFkw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziqXdrUUUUU=
X-Originating-IP: [36.112.3.113]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFRhzjF5mMdNJBQAAsk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hibernate_preallocate_memory() and prepare_highmem_image() allocates
memory chunk with memory_bm_create(). When the function gets some error
after memory_bm_create(), relavent memory should be released with
memory_bm_free().

Fix it by calling memory_bm_free() at the right time.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 kernel/power/snapshot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 2a406753af90..15345ad0b319 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1752,6 +1752,7 @@ int hibernate_preallocate_memory(void)
 
 	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
 	if (error) {
+		memory_bm_free(orig_bm, PG_UNSAFE_CLEAR);
 		pr_err("Cannot allocate copy bitmap\n");
 		goto err_out;
 	}
@@ -2335,8 +2336,10 @@ static int prepare_highmem_image(struct memory_bitmap *bm,
 	if (memory_bm_create(bm, GFP_ATOMIC, PG_SAFE))
 		return -ENOMEM;
 
-	if (get_highmem_buffer(PG_SAFE))
+	if (get_highmem_buffer(PG_SAFE)) {
+		memory_bm_free(bm, PG_UNSAFE_CLEAR);
 		return -ENOMEM;
+	}
 
 	to_alloc = count_free_highmem_pages();
 	if (to_alloc > *nr_highmem_p)
-- 
2.25.1

