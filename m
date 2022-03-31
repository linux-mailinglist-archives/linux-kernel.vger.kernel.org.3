Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB54EE3E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbiCaWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbiCaWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:19:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2A2467D6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:18:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dr20so2133776ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jJFh1buoTrN7HCc8BP6Skb98M8mOsri89QUbsb7tYY=;
        b=Ixa7hGhXAGxFtykB67HssQqapnD1Yx3POmhLjco4cuYfv4vHLHz4EF5zJEwqDbx0yO
         O6mRvWv+KlW8w04BK3AoeT1Qu3x96ptadpmzu4vMkKRQjLKBT19oSYISeYxroZ1JLYuy
         5qX3ZuEJ95RlXGSiYkca3n1K1L3sB9DvpmAHk98tlTSH5c0Xdk3nGDNYkffG12STt7JS
         wIM3e9jDLwxk0OaL94fgcDaFKRV5RqbIdj+uu48EqGU1IjGVK+qZKeIHYfjzZeIvo70j
         KCIi+nxUDZM8BUXLvxog5KbWIEuMKf6Qx2jABu/0s9nT7554KiXw6pXjEUsrbl93fM/b
         +6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jJFh1buoTrN7HCc8BP6Skb98M8mOsri89QUbsb7tYY=;
        b=eONUjHQoEUnOkAALIPlCTDuRuQiNqsQwALUzL7Yj2WYeA9Tf7Kcb1E9Epfsrz9tHsv
         Hq3IG94DtWQQdF5WFNyGXeK2dywHGoU51Wyk3pGCxQPXwf4LYO/SaPJC7McZKm/sj8IS
         z09ywT7JcWEizQ98XegF2hwyJQXtZwWdJYQq6GL8p99udOlG42+aMR0HlH7b0J41wty0
         Zno4jIlPn2WbBURGQ9AxrUkfpYpIOSBqLxHRvNjYsz9wM0Un0NQTNgCmcnHYQV/lwx4B
         MGXSoig16tufg2ya4+Fxt5Yuhnf7z4issE0km2RDvhDaJ50EjFlW+LEYifcTZuyUWSKc
         gskQ==
X-Gm-Message-State: AOAM531V0K5gwlANy7Ne8YPqmKRM6ocZyLE/Zv6PzFhhuMK0ABXiBPCm
        khFo782h6bbHIkhj9XGlmFg=
X-Google-Smtp-Source: ABdhPJzLAwy79KbD01epwHmvEIt2rFEG3KCTwcXepBTllkd7x5vQlWrXKKh2i8tAhccl+KTU/UkV3Q==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr6663371ejm.70.1648765082818;
        Thu, 31 Mar 2022 15:18:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id c4-20020a170906340400b006d077e850b5sm267295ejb.23.2022.03.31.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:18:02 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 2/2] f2fs: replace usage of found with dedicated list iterator variable
Date:   Fri,  1 Apr 2022 00:16:50 +0200
Message-Id: <20220331221650.891790-2-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331221650.891790-1-jakobkoschel@gmail.com>
References: <20220331221650.891790-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/f2fs/segment.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 81ef2c3d08e5..037164bf40a6 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1666,33 +1666,32 @@ static unsigned int __wait_discard_cmd_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct list_head *wait_list = (dpolicy->type == DPOLICY_FSTRIM) ?
 					&(dcc->fstrim_list) : &(dcc->wait_list);
-	struct discard_cmd *dc, *tmp;
-	bool need_wait;
+	struct discard_cmd *dc = NULL, *iter, *tmp;
 	unsigned int trimmed = 0;
 
 next:
-	need_wait = false;
+	dc = NULL;
 
 	mutex_lock(&dcc->cmd_lock);
-	list_for_each_entry_safe(dc, tmp, wait_list, list) {
-		if (dc->lstart + dc->len <= start || end <= dc->lstart)
+	list_for_each_entry_safe(iter, tmp, wait_list, list) {
+		if (iter->lstart + iter->len <= start || end <= iter->lstart)
 			continue;
-		if (dc->len < dpolicy->granularity)
+		if (iter->len < dpolicy->granularity)
 			continue;
-		if (dc->state == D_DONE && !dc->ref) {
-			wait_for_completion_io(&dc->wait);
-			if (!dc->error)
-				trimmed += dc->len;
-			__remove_discard_cmd(sbi, dc);
+		if (iter->state == D_DONE && !iter->ref) {
+			wait_for_completion_io(&iter->wait);
+			if (!iter->error)
+				trimmed += iter->len;
+			__remove_discard_cmd(sbi, iter);
 		} else {
-			dc->ref++;
-			need_wait = true;
+			iter->ref++;
+			dc = iter;
 			break;
 		}
 	}
 	mutex_unlock(&dcc->cmd_lock);
 
-	if (need_wait) {
+	if (dc) {
 		trimmed += __wait_one_discard_bio(sbi, dc);
 		goto next;
 	}
-- 
2.25.1

