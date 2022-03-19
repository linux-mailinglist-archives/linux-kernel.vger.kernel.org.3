Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3722B4DEAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 21:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbiCSUdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiCSUdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 16:33:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06828A0BC4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:31:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o10so4244080ejd.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2nH/6HpwTaCP8txEBQYJMA9Qv7Ene1XvLcUIwNblbw=;
        b=kfuhmI16RfQ5XyFFwfPWGNgI9FebAcYFdOTi3tz2cN4I4aoMO4xPY9VHdrL9nZF/7K
         vdSTLgdaQsJoDVjANXS9JhkKNerMkb6jawwr1kJrdLQ0tyDzK2KbJVwypyLIP7nCgFgY
         DNfLVVptJow8+Bl77Zjd9BdzXpmDiiX3CNCwfXhKQAUZtaP9m0kxE/MS8XH0vlClPDUE
         5WNFQ2R+RXx8SnbnTROzpSXuH5ih2Pmpfi0vBOnRtsOcIE8FVjwoesE4B+YG0VHogs/J
         T4GDiQJm50R5E62bx3g24//zKomA9pTdJPU7nIfEfrmMsRvGIU1yBL1Vllrj2ngYr8ph
         5dnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N2nH/6HpwTaCP8txEBQYJMA9Qv7Ene1XvLcUIwNblbw=;
        b=t4Rrk4M9qn/gZnMXTyx9/kjudUmz3rdiq2ZD00CTPuXe9jLQ4e1tIB6Bvk4Rt8NOhB
         USk5hlIh6MRAMZ+3QCEzvA9bLK/p0AIYbyYb+hoT0RTa6Ct14Hi9AxfGJDULD/pB3suq
         jg5WRmnr6wkdOlE9SEYTVmgw6vbdcoSmzP1nOa4qjzyBYNsrFLTTPoG/jRrM+ylkzMPC
         xmALl9U/TDjjGU7Yt/2T+tQgmuB2PHIXa6G0RiJruSn7vtisQE9TksTZHks8nkPVsgA3
         PvoQ0rTMGEW42TfV/OGJnHON/RTiukUiQUt4bRzCOjMJoS7OwcmjkUGtBVy0VJyOhVip
         McEw==
X-Gm-Message-State: AOAM533PjRkGrIf6tuKdh1dhtnYbOh9PuY/dVbS2A3Uqubq98Hnuh2C0
        qmL2IOm5WIlzguUJZXtzyUs=
X-Google-Smtp-Source: ABdhPJy2jy/Jz2ohQfbL8TIY6ppZp7c+/CgYz508Ye0DFQEnqTl1Zam648bwg3+tsspZpsfx5Lt5Hg==
X-Received: by 2002:a17:906:5cb:b0:6cf:954:d84d with SMTP id t11-20020a17090605cb00b006cf0954d84dmr14694950ejt.560.1647721910365;
        Sat, 19 Mar 2022 13:31:50 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id g15-20020a170906520f00b006cd07ba40absm5131441ejm.160.2022.03.19.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:31:49 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mark Fasheh <mark@fasheh.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: [PATCH] ocfs2: fix check if list iterator did find an element
Date:   Sat, 19 Mar 2022 21:31:06 +0100
Message-Id: <20220319203106.2541700-1-jakobkoschel@gmail.com>
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

Instead of setting 'res' to NULL, it should only be set if
the suitable element was found.

In the original code 'res' would have been set to an incorrect pointer
if the list is empty.

In preparation to limit the scope of the list iterator to the list
traversal loop, use a dedicated pointer pointing to the found element [1].

Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/ocfs2/dlm/dlmdebug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index d442cf5dda8a..be5e9ed7da8d 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -541,7 +541,7 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
 	struct debug_lockres *dl = m->private;
 	struct dlm_ctxt *dlm = dl->dl_ctxt;
 	struct dlm_lock_resource *oldres = dl->dl_res;
-	struct dlm_lock_resource *res = NULL;
+	struct dlm_lock_resource *res = NULL, *iter;
 	struct list_head *track_list;

 	spin_lock(&dlm->track_lock);
@@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
 		}
 	}

-	list_for_each_entry(res, track_list, tracking) {
-		if (&res->tracking == &dlm->tracking_list)
-			res = NULL;
-		else
-			dlm_lockres_get(res);
+	list_for_each_entry(iter, track_list, tracking) {
+		if (&iter->tracking != &dlm->tracking_list) {
+			dlm_lockres_get(iter);
+			res = iter;
+		}
 		break;
 	}
 	spin_unlock(&dlm->track_lock);

base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
--
2.25.1

