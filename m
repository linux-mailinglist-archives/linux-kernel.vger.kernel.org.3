Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D992654B796
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbiFNRYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbiFNRYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:24:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E232DD61
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:24:21 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id a15-20020a65604f000000b00401a9baf7d5so5308738pgp.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2QM6sBlqZy4J9QcboN+ulRRaCl3S/0tpYWY2Xs9tMvs=;
        b=U3ZM4Mh9Vtb3LPkbV3lH1h/A9RAlFyhE451o+qAD47OjOML5XFM2+If65eVSNQRhyj
         +87U6Ec1g7g8wmBNWmufg13BJppjUEJR2VXS10tFCBDHd/Q8h06zQzcs92NQbe2bAHr2
         D9n1Onh1lzE/ZdUzhYmW650TlV3alGjKLxD5RFRERi73TXlBwRv8CQQdqI8iW30vwb4f
         0VbjO1m0maSoMmthZ7LMBiBeNazRoquWa/XXRfntWJYgkoqqOi3mCfeehShtHylGKDfS
         LkryUwyXuXpKGeOCdhTqlzMf4rcaCeBEzjF8ytO1Ar2uytiQmK0bx38b56NNBnFjyri7
         nP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2QM6sBlqZy4J9QcboN+ulRRaCl3S/0tpYWY2Xs9tMvs=;
        b=6vIen/ID5tHJh46wssyU/JsL2MShYeL6tkjtI3HLVUYpf7OxMlpKrFJGSu2Koq4pXk
         SvPg7D/4uEnp/f1FUyFBTbdC6n8LnkB/uhJppywJFMzTO4nkpar1fvdhuOLXlUo2/5H2
         8th4A2dMDsGTzIYyxf+9WEVf/agIoMktRvaABbhnq2xA+mYuz0msLjEa0pHo69bJ7PGd
         4/XMh3T3JFZ4jmDrLNqC6JcnYu5Ib0YRzDKBtbmEHpKSuDqMQsP6RMrYUdXGOCHyYCej
         BELZqpehiLIofaVw5zV1UpX0EnXnYxiHThEvFvMhCs6cty6Elx+cMjgdyblqv53EcnF5
         D5sQ==
X-Gm-Message-State: AJIora9iUYqNt5jpdd+Oc+sh00wHjUDCJaqJStR9vwIhf2nyb21wBkf6
        eEnUooqOG8s4Fj6vztLDzWDkXa9THNdXQh2/1Zc=
X-Google-Smtp-Source: AGRyM1uk0WIS9cY0lcWVVfHXobO/VvLecSw2GkwDRc4JamK5pXrrTRPclrJPSSalp3SFnMMcVMxBgq+coHse9/n7qhg=
X-Received: from willmcvicker.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:2dd0])
 (user=willmcvicker job=sendgmr) by 2002:a17:90a:6fc2:b0:1e3:2c21:c29f with
 SMTP id e60-20020a17090a6fc200b001e32c21c29fmr5784490pjk.191.1655227460606;
 Tue, 14 Jun 2022 10:24:20 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:24:01 +0000
Message-Id: <20220614172401.3010509-1-willmcvicker@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v1] sysfs: fix sysfs_kf_seq_show null pointer dereference
From:   Will McVicker <willmcvicker@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     kernel-team@android.com, Christoph Hellwig <hch@lst.de>,
        Will McVicker <willmcvicker@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kobj->ktype is null, sysfs_file_ops() returns a NULL pointer
for the sysfs_ops. When this happens, we hit a kernel panic in
sysfs_kf_seq_show() by dereferencing ops to check if ->show is NULL.
Based on commit 820879ee1865 ("sysfs: simplify sysfs_kf_seq_show"), it
sounds like we won't hit this often, but I have randomly hit this on my
Pixel 6 with 5.19-rc1. Refer to the crash stack below:

   Unable to handle kernel paging request at virtual address ...
   Internal error: Oops: 96000004 [#1] PREEMPT SMP
   Hardware name: Oriole EVT 1.0 (DT)
   pc : sysfs_kf_seq_show+0x3c/0x160
   lr : kernfs_seq_show+0x54/0xa0
   Call trace:
    sysfs_kf_seq_show+0x3c/0x160
    kernfs_seq_show+0x54/0xa0
    seq_read_iter+0x17c/0x638
    kernfs_fop_read_iter+0x70/0x1f4
    vfs_read+0x240/0x36c
    ksys_read+0x7c/0xf0
    __arm64_sys_read+0x20/0x30
    invoke_syscall+0x60/0x150
    el0_svc_common+0xb8/0x100
    do_el0_svc+0x30/0xd4
    el0_svc+0x30/0xc0
    el0t_64_sync_handler+0x88/0xf8
    el0t_64_sync+0x1a0/0x1a4

Fixes: 820879ee1865 ("sysfs: simplify sysfs_kf_seq_show")
Signed-off-by: Will McVicker <willmcvicker@google.com>
---
 fs/sysfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a12ac0356c69..f09f86f10410 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -45,7 +45,7 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	ssize_t count;
 	char *buf;
 
-	if (WARN_ON_ONCE(!ops->show))
+	if (WARN_ON_ONCE(!ops || !ops->show))
 		return -EINVAL;
 
 	/* acquire buffer and ensure that it's >= PAGE_SIZE and clear */
-- 
2.36.1.476.g0c4daa206d-goog

