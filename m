Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2781C4EE3E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbiCaWTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiCaWTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:19:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5B2467D4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:18:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bi12so2176371ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGGgLAEg4vKemtCj1ntyLaCyd5rpT3euBf5HMUBa/kQ=;
        b=E4NYH+s4Okdqjh+xibJ5yjwAj29PreK5heggPOvUbxc/0XOdOKvGymtbtO1kdi0uqA
         UTEECTNqzjgKeolfmzwke5mOwqIs4wWuLfKL5uODd4rbA40wuiQ7ID2VG13DkbzrAgpm
         TibtqBacUFO/gCVs4fOChK+vTvTI0CMQ2RJNYJBtVfbP1mKzM2Nymvi9uxeV4JX/Y66J
         ttgp9L0VTaNGCIuMHFRPcefjynbEaH9zslYB+PWJU00tFU1NLZtNFjxPG4mLEpAoYTvF
         AzKoZFjMWec/izbllW5SeSyHP8sfsHDxbbixsGlw7ym9IhCFjvSBhGQaDwVJ/I72FwfP
         M5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGGgLAEg4vKemtCj1ntyLaCyd5rpT3euBf5HMUBa/kQ=;
        b=1ZzhmvJ0dNG+9TmW2wLbWaZpP3FCNWd+DqZjx5SZdMhOl9uKIC2JybuSYMGAgusSv4
         ZtA1N+5nsZZnAdQMFEQz+CvIoc6GcTquqTY4A/D5yP/XqPzAx82TtQLLPd9B2+1u489h
         muR6/q8l1tdNaveIDjQ+7Z8rVzMhcy2fyds7EJmi1uS8baQgVJRzb4DfpXWbANvtyH/f
         3eW2nuTiQRdWgE4NbaLNLZeS+DIEmzpa4pIGKKQAjIyep93lVqehlTRGE6E8VI1N7Hks
         MOL+0U/J30ZWwCQ4kaCOrvHQrjdTM2lxy7VI9xZjF1tRgjNNSGdha1GJ+D4UdejzhRFe
         0yIg==
X-Gm-Message-State: AOAM533sQU60heIYAUcPqt37J1PFvE5RfB1LmvbI5bshhCI+c0oomLoh
        y7bkw6j8Dvq0YzqmYEq2FNQ=
X-Google-Smtp-Source: ABdhPJwsPBXkMH3zqricdh6VqGP9lTF4os4T+dHyBkSiFt6jonLB2mmicd0A0DqTtqhS+Op9ohNBFw==
X-Received: by 2002:a17:907:a414:b0:6e0:68f3:d7a with SMTP id sg20-20020a170907a41400b006e068f30d7amr798723ejc.75.1648765082139;
        Thu, 31 Mar 2022 15:18:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id c4-20020a170906340400b006d077e850b5sm267295ejb.23.2022.03.31.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:18:01 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] f2fs: use separate list iterator variable to call list_move_tail()
Date:   Fri,  1 Apr 2022 00:16:49 +0200
Message-Id: <20220331221650.891790-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element
[1].

If no break is hit or the list is empty, 'next' will be NULL and
list_move_tail() should be called explicitly on the head directly.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/f2fs/segment.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22dfeb991529..81ef2c3d08e5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4175,16 +4175,20 @@ static void release_sit_entry_set(struct sit_entry_set *ses)
 static void adjust_sit_entry_set(struct sit_entry_set *ses,
 						struct list_head *head)
 {
-	struct sit_entry_set *next = ses;
+	struct sit_entry_set *next = NULL, *iter = ses;
 
 	if (list_is_last(&ses->set_list, head))
 		return;
 
-	list_for_each_entry_continue(next, head, set_list)
-		if (ses->entry_cnt <= next->entry_cnt)
+	list_for_each_entry_continue(iter, head, set_list)
+		if (ses->entry_cnt <= iter->entry_cnt) {
+			next = iter;
+			list_move_tail(&ses->set_list, &iter->set_list);
 			break;
+		}
 
-	list_move_tail(&ses->set_list, &next->set_list);
+	if (!next)
+		list_move_tail(&ses->set_list, head);
 }
 
 static void add_sit_entry(unsigned int segno, struct list_head *head)

base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550
-- 
2.25.1

