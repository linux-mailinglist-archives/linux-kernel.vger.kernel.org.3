Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAFB5AFCB6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIGGns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGGng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:43:36 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BC7114D22;
        Tue,  6 Sep 2022 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2rIc6
        tezrARE1+CFWv+5cFs1Lg6X5Lme/PX2cYrHUA8=; b=ALygE55e6myvo4zphyjfp
        Os1x6wwOfIX4pmddSjq3sI9ZzuxQG1OQP9BRCBHQGIZpPFZ++2zrwobeaR+R7DVO
        RrEsS5b/okcz3maBG/i4MdlEoNZUcAgGhEgTvkABcQQ//KuQydoTvV2OTPSD7MYr
        niLSiwFRM4AMLEB04IftDY=
Received: from localhost.localdomain (unknown [36.112.3.164])
        by smtp1 (Coremail) with SMTP id GdxpCgA3UqOEPRhjZ0q_ag--.42658S4;
        Wed, 07 Sep 2022 14:43:23 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] PM: hibernate: Fix potential memory leak in hibernate_preallocate_memory() and prepare_highmem_image()
Date:   Wed,  7 Sep 2022 14:43:11 +0800
Message-Id: <20220907064311.54475-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgA3UqOEPRhjZ0q_ag--.42658S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7XrW3Jw1rCr1kWrWkXF48Xrb_yoW8JF13pr
        Z5KF4DGr1vywnrJ397tFn5Ca47ZwsYg345W39Ivwn5uF13WrnYva1rJrWjgr4Iyry0g3Wj
        9FZ7Ww1UXanrKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieWldUUUUU=
X-Originating-IP: [36.112.3.164]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFQt1jF5mMevBQgAAsG
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
index 2a406753af90..e5ec204ebe22 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1752,6 +1752,7 @@ int hibernate_preallocate_memory(void)
 
 	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
 	if (error) {
+		memory_bm_free(&orig_bm, PG_UNSAFE_CLEAR);
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

