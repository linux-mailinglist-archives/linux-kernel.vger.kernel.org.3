Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033294FE11B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354116AbiDLMyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356430AbiDLMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:49:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C63522D6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:21:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t25so9451732edt.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzJCMQcfk2LS05QX3t+F4QP/1tjShGb6Ooy0sIJVLiY=;
        b=E4xO9sPBDCWCWLk9kftCh0w0N3Cuz39OrLZhKqBsBTqzL1fZN8rDVp+5JpQSpFwT3A
         dY4LV3DjIoqH7I7B6FNo2nZBH5/Y4byJUGhwd7HbYgk7AFqjTsBaGXsX61aeJXEEchEB
         szuQFcdogT7CPTeurL+Q2HEjAzXH7wPdV+7B0qijGfzGwQ9js5RqJjnq032dacfCKVhM
         g0az0tt8dq430Q1JoeknsQzRlIMjfwmzCXIIuAFso0fFgxsR7f5c0t0ZD67aaFkVLzTE
         XE04sKGlJwllwsbraBoSp/+HmBtjWzvVC4JwnvvmtiVMx+SQ2Z+W/jVmqt0vysudQshJ
         loXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IzJCMQcfk2LS05QX3t+F4QP/1tjShGb6Ooy0sIJVLiY=;
        b=C9O1NUE0A7G8bsc54ii3twU1/fOWLhQcD8qU0tA/Jejjz7BZwCcDKPtYa7imfe81P4
         7egVVpiQS96iNAxjA/ELKCCvMjtkgEVA+5KetOOXIliM+nYKZrIqcgyebHY8k+0qlUKz
         94tJUMKfLZNerFJexPIUKnauWQNsnCCs3jmnJ6u457yzk9ojGzqO7zUnbwvku5zpVWHW
         ++Jwzk2XDbZ0eOE2/fHO89+/4/gRyzIG8AWSc04i2VdCEjlxP6X/+H3qSnF1Iel3l7wa
         KRQpmYxFe6JbOMMoZ2EaxnMcVVJDFxSmKoBfphy9Xo2rd+V2PsqlwjkvV9gBfSQedc+d
         q6JA==
X-Gm-Message-State: AOAM533ZhHB12oa0DBNMCPStVznFrO9jkRGM0Tre5lrEVY7NQ+Fco4jz
        ZPpGmqm69On0V7qUPP1aOc8=
X-Google-Smtp-Source: ABdhPJyNKaWIEZRkY89LGHWnXV/bh5ppnLjvI645Mx1dycERHTuYg9+4sor4BlXGHalI/ohmU7UVqQ==
X-Received: by 2002:a05:6402:354d:b0:41d:dfe:6a8c with SMTP id f13-20020a056402354d00b0041d0dfe6a8cmr26438988edd.286.1649766067989;
        Tue, 12 Apr 2022 05:21:07 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id op12-20020a170906bcec00b006e89b09a238sm1954081ejb.4.2022.04.12.05.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 05:21:07 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2 1/2] f2fs: Remove usage of list iterator pas the loop for list_move_tail()
Date:   Tue, 12 Apr 2022 14:20:39 +0200
Message-Id: <20220412122040.3555423-1-jakobkoschel@gmail.com>
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
traversal loop, the usage of the list iterator variable 'next' should
be avoided past the loop body [1].

Instead of calling list_move_tail() on 'next' after the loop, it is
called within the loop if the correct location was found.
After the loop it covers the case if no location was found and it
should be inserted based on the 'head' of the list.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---

v1->v2:
- Add early return to avoid introducing additional 'iter' variable
  (Chao Yu)

 fs/f2fs/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 22dfeb991529..7ec1a2ef2167 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4181,10 +4181,12 @@ static void adjust_sit_entry_set(struct sit_entry_set *ses,
 		return;

 	list_for_each_entry_continue(next, head, set_list)
-		if (ses->entry_cnt <= next->entry_cnt)
-			break;
+		if (ses->entry_cnt <= next->entry_cnt) {
+			list_move_tail(&ses->set_list, &next->set_list);
+			return;
+		}

-	list_move_tail(&ses->set_list, &next->set_list);
+	list_move_tail(&ses->set_list, head);
 }

 static void add_sit_entry(unsigned int segno, struct list_head *head)

base-commit: 3e732ebf7316ac83e8562db7e64cc68aec390a18
--
2.25.1

