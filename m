Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD074BF1A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiBVFlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:41:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBVFlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:41:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CD19D0C8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso23117275ybs.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qqyEPHhtNcMIuHzofZyfR4VdGZXTrt+4dSmkIwliqsc=;
        b=IKHOwo4Dx8CMc91mjHwFli7xuzNosMgEP9RN+83t9bNE3LFI3FV050mQYjbw9eTMc9
         vXXISkC1t3BaOVQ36wn7IqyzuQ9cz0Gix56/PeGDmfqkvtHyoagz+h+Qm7+dp3yVYKAp
         xnF1aa6r4TyBKfghqeg7vnbiab282PzTmsxYsz6XYZOowHJv7OAB0jiSOVCW1G30uaz2
         u4NR+JKLWg3CF4wM19oBuxjOFD5MCp+bpPFNuUngMqx5y9hes4Qfr+jIY3iEYUAFr0jN
         x4PWlDvGSKHUYvgx261OxZwcG8tEoZcR1/0O4xpds4xRwtpnVe19ma+udm+p6B+O3FpA
         tT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qqyEPHhtNcMIuHzofZyfR4VdGZXTrt+4dSmkIwliqsc=;
        b=BMpiD8eNV1neXBjpOLMjpLEWE8en6idNVdEHOyd4iPj6o8osSOgjb0noQl/NkrR/fv
         I9m7TZ9g0YTCPbTBGpHSHybF/9OtDDJjRq/4O2XHCj51IkFujukQI2wy9xNy9/0jiz0f
         S8UcXKFoAxCMskyobM5yQF81MJBFgCW7CNRfZhTOJ/JeeNNs2Mkl8jDUbUQuc5gSG8/q
         S3AyhKG8TnIOmzq4yET+4MoUgrRuovk/JGzX2hehIjvUeOuVYFORme+GjKdtud/tAQQe
         6mitBagzNrAT0Ed4VKkQ+Es0rkpC8fpguLaAQUplsif3MG2QwRC0PdxVxfLm5IzmrzRt
         b8qg==
X-Gm-Message-State: AOAM532seseUnEcbSYbbcHDUwIVbNNSLmx4/v+0j3KHiLAUEY3HJiK7v
        O1AImDwZVxuuYnYP2JWlqAM7LXRlXdY=
X-Google-Smtp-Source: ABdhPJyV36iaywxWIV/mu3YvgglKzrKpoYNKBcoCDN/RAIPDuOGaBX4rgSXqnIM75wkiVz9su31jZU9lMZQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:79c1:8a4c:5d17:670f])
 (user=surenb job=sendgmr) by 2002:a81:1093:0:b0:2d7:2439:6279 with SMTP id
 141-20020a811093000000b002d724396279mr10598421ywq.520.1645508435012; Mon, 21
 Feb 2022 21:40:35 -0800 (PST)
Date:   Mon, 21 Feb 2022 21:40:25 -0800
In-Reply-To: <20220222054025.3412898-1-surenb@google.com>
Message-Id: <20220222054025.3412898-3-surenb@google.com>
Mime-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v4 3/3] mm: fix use-after-free when anon vma name is used
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
directly to vma->anon_name->name and it is used after the call to
vma_merge.  In the cases when vma_merge merges the original vma and
destroys it, this will result in use-after-free bug as shown below:

madvise_vma_behavior << passes vma->anon_name->name as name param
  madvise_update_vma(name)
    vma_merge
      __vma_adjust
        vm_area_free <-- frees the vma
    replace_vma_anon_name(name) <-- UAF

Fix this by raising the name refcount and stabilizing it.

Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
---
changes in v3:
- Reapplied the fix after code refactoring, per Michal Hocko

 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index a395884aeecb..00e8105430e9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -140,6 +140,8 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
 /*
  * Update the vm_flags on region of a vma, splitting it or merging it as
  * necessary.  Must be called with mmap_sem held for writing;
+ * Caller should ensure anon_name stability by raising its refcount even when
+ * anon_name belongs to a valid vma because this function might free that vma.
  */
 static int madvise_update_vma(struct vm_area_struct *vma,
 			      struct vm_area_struct **prev, unsigned long start,
@@ -1021,8 +1023,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 	}
 
 	anon_name = vma_anon_name(vma);
+	anon_vma_name_get(anon_name);
 	error = madvise_update_vma(vma, prev, start, end, new_flags,
 				   anon_name);
+	anon_vma_name_put(anon_name);
 
 out:
 	/*
-- 
2.35.1.473.g83b2b277ed-goog

