Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD54C3997
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiBXXTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiBXXTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:19:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6386D23892C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:18:44 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d5258e8a4bso13463317b3.22
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IALWH9LaKSweUR5bZa1FpDcJHobIK4+OdaXeGu0F6JQ=;
        b=MKEmgeV8keFzqWZcHOcTiLZlqPGywLiEIsJ+DgmNvryiXNxyu0iL7DTY+w67cd7N7k
         3SrxnI0w3asp3PQPS8RyPFn1S2QzEbAZzICzfGiUBdQ0zOd3QM2m7anzgZkE/OFUNnm2
         Trbc5I7BZ4JFq/zvqlsAvlUaGqtmbcl4I7dcF55Yz65c2ncpU98D6jPjRtkrbUvaiom8
         JuGXg5p2w1QeO+72Z+SdmmfhveJg62J4j+7SLMbU3UbDjpPQ0Nwaeijm+obBAATLI3L2
         DoDXNVK0HR3xnlI5Z5rO3zzynt191z2ym/fOmCgg9aiIOJQTJDWI/3TXCBPSAmlUDgBo
         FZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IALWH9LaKSweUR5bZa1FpDcJHobIK4+OdaXeGu0F6JQ=;
        b=3JUVW8MsBrkZfXF0XlgPFRc20YEjioea61UsCf/yO0wDPiHrYVlX9CmIofosttSDLE
         wmObBptYr8rN6QfPJXzcRlGf6QNoAywgLN3ECSeenMHD6qFp36dO2KO8r4H/TNIL06FQ
         R1Oq7w+ByGaXkwK+7b95UfeZLGi/AA7mufZPyRSyoRKlJpLO511to3HBKvDULn2lz/DY
         ZhK2o1B4XwaUr14+y+9i4C+KcW9uVPNYFGL2+ur8akAMRmblI2KFZK/wGMFLECjT2ZQj
         7lRU2cAR8wiFPumQEmfoV9/WfL5R56mSCjDzJBP1+7epbC4v/WwD0YAxpqqxVO11KTT5
         hJpQ==
X-Gm-Message-State: AOAM531Sr8R+tgvTPgsOn3reXsKd0wCRM1y81HIOVjPRBEWnzWxytzA/
        2VwRgw38RcPgH3AsgmM4L/6Em7RqaYE=
X-Google-Smtp-Source: ABdhPJylfTOhMDpaEnhM3agqq1RqsTGVtn1V6AZ3i7i5WpAOEcsxHrT1VmuNtYbRHQllOOnIxVs6NSfcC+k=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1c5c:1806:c1bc:a422])
 (user=surenb job=sendgmr) by 2002:a25:5f41:0:b0:624:754d:4c04 with SMTP id
 h1-20020a255f41000000b00624754d4c04mr4603744ybm.121.1645744723614; Thu, 24
 Feb 2022 15:18:43 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:18:34 -0800
In-Reply-To: <20220224231834.1481408-1-surenb@google.com>
Message-Id: <20220224231834.1481408-3-surenb@google.com>
Mime-Version: 1.0
References: <20220224231834.1481408-1-surenb@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v6 3/3] mm: fix use-after-free when anon vma name is used
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
directly to vma->anon_name and it is used after the call to vma_merge.
In the cases when vma_merge merges the original vma and destroys it,
this might result in UAF. For that the original vma would have to hold
the anon_vma_name with the last reference. The following vma would need
to contain a different anon_vma_name object with the same string. Such
scenario is shown below:

madvise_vma_behavior(vma)
  madvise_update_vma(vma, ..., anon_name == vma->anon_name)
    vma_merge(vma)
      __vma_adjust(vma) <-- merges vma with adjacent one
        vm_area_free(vma) <-- frees the original vma
    replace_vma_anon_name(anon_name) <-- UAF of vma->anon_name

Fix this by raising the name refcount and stabilizing it.

Link: https://lkml.kernel.org/r/20220223153613.835563-3-surenb@google.com
Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Acked-by: Michal Hocko <mhocko@suse.com>
---
changes in v6:
- Updated description clarifying the last reference requirement,
per Michal Hocko
- Added Ack, per Michal Hocko

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
2.35.1.574.g5d30c73bfb-goog

