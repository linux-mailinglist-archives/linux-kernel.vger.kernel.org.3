Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1944B7773
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbiBOUTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:19:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiBOUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:19:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF8EACBD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:19:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g205-20020a2552d6000000b0061e1843b8edso41991581ybb.18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3sykFJBU7TaEMZYTogVM89EYoDudBlD4QLkfsqx2ZFE=;
        b=QEf2mqWTjsa/E5krOX9OFf7ks4YOwL85No0GxFrV+2PebGS/cgnPqjSnvDvOSc3RvM
         Trxc/NaUhms8VlGKEMxWAPncnpKWXBwNLkT8jjzFbxCLXyy/RnVm2l4E4ZGu+ok0bYro
         KBvBrkBDZrFzWqXydq7l3gbslupJKMpdQtBTdrSzRNYfM5qOXDKhJOlSi6/37uaWqF8t
         TQg33AD3bLwrpN47rtY84vbuKcqHJuPVlxINx7v8M3wdXn7Vkd/yyAfLBAWG57zXkUJx
         z5OQ40GXQjt5ZS++yzyNLCiJFClwSux7MndH0Kvc1Ehwg7eEMR7dzBqbTgURQ84WsJwF
         0MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3sykFJBU7TaEMZYTogVM89EYoDudBlD4QLkfsqx2ZFE=;
        b=zPRpMuC8ubR4UViI7UQMaiWEUtMQPcJBrHncRfcPbgBYyspfynEGFCMsWF7vNM0nKY
         ORU2xACbGuIu043KJz2E3z+qQ9W8N1PpY6rJYFqkGJtE1N0klUNAaZwqyQqtHXBW7c7B
         C+0+0gf6PJMQpM7YJsBV4bg8vwsVtCE1hPdrpriAQ4eCNEEToID0SgQtjE2QEAt20YaO
         bZOJt3KzVpkNPuLIMQBA+TSahlkVFrsXHU66lQnrnTySe+N6R1Eqtjny580D5nP+7WZJ
         jNTwWIHQ0sPtBW2URGJOEkY6WAVcPWYFRkhIsnfjR6Vom80VXZYowHNbI9f0hVn+PkaS
         fBxQ==
X-Gm-Message-State: AOAM533drBSaqRdiChneJnj03HoyvsxO4nUlbbAmMTzJSwm9L/JLFDUF
        YUGYhr/EQmOtfkk2Ghyo+vYF390I964=
X-Google-Smtp-Source: ABdhPJw4G1dyLTGbU/4oGbsYbMXCg+jUT4P0G7PyusNh5KoZcthlKjSwWZ7ONGwtSRvNQbayc9fkxTBjGfQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:c779:6798:9711:86f4])
 (user=surenb job=sendgmr) by 2002:a25:dc02:: with SMTP id y2mr631611ybe.0.1644956366028;
 Tue, 15 Feb 2022 12:19:26 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:19:22 -0800
Message-Id: <20220215201922.1908156-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused after
 being freed
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@kernel.org, mhocko@suse.com, shy828301@gmail.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        luto@kernel.org, christian.brauner@ubuntu.com, fweimer@redhat.com,
        jengelh@inai.de, timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
otherwise it points to a vma that was freed and when reused leads to
a use-after-free bug.

Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..d445c1b9d606 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
 		vma = remove_vma(vma);
 		cond_resched();
 	}
+	mm->mmap = NULL;
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
-- 
2.35.1.265.g69c8d7142f-goog

