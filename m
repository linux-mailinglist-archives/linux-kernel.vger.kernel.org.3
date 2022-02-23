Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366944C16F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiBWPhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242133AbiBWPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:36:51 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A8BBE04
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:36:23 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j17-20020a25ec11000000b0061dabf74012so27870881ybh.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KVI9h34IVpEZB73JFOBMLmYxwNU0WUD9iiOxc47ibAs=;
        b=cEOaTS6V3ulJlRkWpGLZufC1eh2PraLWoGncZISKjYg572ZFmQbI5VgWAZ6KyfvVgB
         +piaGLu69caHkbCzLMLInrkAWMBlCc3sY2U385t5PYrlH7CrDziPpdt4xbhanGJ1zc/a
         64pBgl9gpq3C6uLvx+Fwi0cbxm9kCb4cUqQF5+DsBoDFU+mj/McXhoongC8mkEYf33z1
         kw6l9/F9DIW2LMZsrgZ9qaXvuWQxDxKuyOKvNTO25CCAdaQ7jfRi8oi6pjMg93VLCzOv
         oPHphG2/cnq/AMLn51ciMFK6Ctr1gR5AUA4tTkrBxg1XmcPLXf4DrWJVpXv7fDNfmdYN
         UnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KVI9h34IVpEZB73JFOBMLmYxwNU0WUD9iiOxc47ibAs=;
        b=MBczS/ZuVlPxbft49f2xBTWFTItWeUvXpwSrfkjCA6PHqSWuifnR2kagW8Nf9yQpxl
         0AbRAB6LTYAcBGXfXD8EJCHBZdhUTIGk+/Z2PKt1IHFRfWFfFQ51eai59zW99gXmBm/R
         Sbt7IqJv6RT8M7K45GGDsX80JX9Nxu5rqrHneRKzRkbQ00a/M9jFLdiLTczEIYakhOlS
         qZSOxVXqgRzabSPUSKomiFD9eYsTP7RxkR5yGOl8tTyGb7FSmX5Zgy6lo+TNJG3Ci3Sg
         zVnt0utrpO+2QjQzQlXsEreJUa10/AvxNLRgsbQ23Swu9Krf6fixRzHdxpz5IKZqqH31
         UbXw==
X-Gm-Message-State: AOAM532r7PtL//ongVE4bwH9+QSXFC/G2HhePOWTQlxGga+NLJfWU1yj
        H3NWf570foNDOPHVRT8P9P2yBxnRTqY=
X-Google-Smtp-Source: ABdhPJz+dH+QYp21E0/NCb1xG1S5CJgsvwNt+rRWPe/zdfkulvwJe0FdspODecQRD2+y/VFn8M2ELMl3+IY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5093:9fb5:d0ba:a5f])
 (user=surenb job=sendgmr) by 2002:a25:2e10:0:b0:624:72a4:d938 with SMTP id
 u16-20020a252e10000000b0062472a4d938mr250689ybu.559.1645630582756; Wed, 23
 Feb 2022 07:36:22 -0800 (PST)
Date:   Wed, 23 Feb 2022 07:36:13 -0800
In-Reply-To: <20220223153613.835563-1-surenb@google.com>
Message-Id: <20220223153613.835563-3-surenb@google.com>
Mime-Version: 1.0
References: <20220223153613.835563-1-surenb@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v5 3/3] mm: fix use-after-free when anon vma name is used
 after vma is freed
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     ccross@google.com, sumit.semwal@linaro.org, mhocko@suse.com,
        dave.hansen@intel.com, keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, surenb@google.com,
        syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
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

When adjacent vmas are being merged it can result in the vma that was
originally passed to madvise_update_vma being destroyed.  In the current
implementation, the name parameter passed to madvise_update_vma points
directly to vma->anon_name and it is used after the call to
vma_merge.  In the cases when vma_merge merges the original vma and
destroys it, this will result in use-after-free bug as shown below:

madvise_vma_behavior(vma)
  madvise_update_vma(vma, ..., anon_name == vma->anon_name)
    vma_merge(vma)
      __vma_adjust(vma) <-- merges vma with adjacent one
        vm_area_free(vma) <-- frees the original vma
    replace_vma_anon_name(anon_name) <-- UAF of vma->anon_name

Fix this by raising the name refcount and stabilizing it.

Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
---
changes in v5:
- Updated description, per Michal Hocko

 mm/madvise.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 1f2693dccf7b..38d0f515d548 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -131,6 +131,8 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 /*
  * Update the vm_flags on region of a vma, splitting it or merging it as
  * necessary.  Must be called with mmap_sem held for writing;
+ * Caller should ensure anon_name stability by raising its refcount even when
+ * anon_name belongs to a valid vma because this function might free that vma.
  */
 static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct vm_area_struct **prev, unsigned long start,
@@ -945,6 +947,7 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 				unsigned long behavior)
 {
 	int error;
+	struct anon_vma_name *anon_name;
 	unsigned long new_flags = vma->vm_flags;
 
 	switch (behavior) {
@@ -1010,8 +1013,11 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	}
 
+	anon_name = anon_vma_name(vma);
+	anon_vma_name_get(anon_name);
 	error = madvise_update_vma(vma, prev, start, end, new_flags,
-				   anon_vma_name(vma));
+				   anon_name);
+	anon_vma_name_put(anon_name);
 
 out:
 	/*
-- 
2.35.1.473.g83b2b277ed-goog

