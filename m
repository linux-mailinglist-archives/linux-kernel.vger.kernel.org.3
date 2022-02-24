Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D04C3995
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiBXXTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiBXXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:19:12 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BB235339
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:18:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d726bd83a2so13602317b3.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WcRk+VkLxrTwbDR3tjLPtnh/8wAdzloMGXwNgmUa7nc=;
        b=Xwxd9XwNKK0NF4cvAU2R8vhvu0md7aSBa2B55PIhY89XephZkblHj+PSAVvnEPIM4j
         TJIvC7duVYI+j1l6KOTqznhCYAbQUDtp8EpNbXjUqsUR5K9jmjjJEz1SkUFUjRw8YwCK
         bnYV2bSlT8fQ+WgyynH1cHM7qxDGM1Sm39XZoK8HQyPnb1f0yMWhTvxbrVXSuh3F2Xwv
         3M3L85H9AkkLnx4241smzJynhC1b5AwbqMkVvRB3UeCPVW7FDOP0wdB4SAYnkqg0UKiQ
         UOhtxnzRUP3nOBNtj+VucN6ANz2W8hgC/+uweejp8adTZwWCRHPbq8zaE+zE6kR4B1GZ
         sxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WcRk+VkLxrTwbDR3tjLPtnh/8wAdzloMGXwNgmUa7nc=;
        b=uiStmpK7aqYj/b04ktZ5l395VBRezBxqD3Hc7LfV4yzl1Ql5tCyzTwYiwC8ZIjk+Rg
         LYjyxI9A1mR9aKsvP7WyivCuyXmMxQwAqYZpp5rfMOimCzAcSVkAfUlP7N7NE90lKmmO
         NHDr3LHHVICnLLrXAMehBrojJR6bIxu4ee/x/bjQpDCNM6/I2hR9fg2ExV20taFHvU6J
         QKO7iOG3TA+BE2EdqNdljcYDIvVOkmbQl01ptnsQNVnKB+H5/NeXkDqwIMQ1dK2rtCWm
         nNtbxCZwpcOzb6QQsGZ066izG9cnIFuxujf7jHcxMFf1L4rDcT8FTBwuzoukWtymlGdn
         FE2g==
X-Gm-Message-State: AOAM5322SM/PDLGNCCmvIIOGZ2DyTKM1WpMKj8F+OAtCeEEd6aHTm+dU
        34kvpoBhUS3JsQz/WNdmSB1iK1IJSlY=
X-Google-Smtp-Source: ABdhPJyJCBq67He+0PoQK/vX8Mc19UBZmel2zFsmVtxgnReH+P7sQUqvJV9mTsvwW3i/cmtEnDhi4N6BT1Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1c5c:1806:c1bc:a422])
 (user=surenb job=sendgmr) by 2002:a81:8d1:0:b0:2d0:ebfe:210d with SMTP id
 200-20020a8108d1000000b002d0ebfe210dmr4834089ywi.486.1645744721199; Thu, 24
 Feb 2022 15:18:41 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:18:33 -0800
In-Reply-To: <20220224231834.1481408-1-surenb@google.com>
Message-Id: <20220224231834.1481408-2-surenb@google.com>
Mime-Version: 1.0
References: <20220224231834.1481408-1-surenb@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 2/3] mm: prevent vm_area_struct::anon_name refcount saturation
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
        kernel-team@android.com, surenb@google.com
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

A deep process chain with many vmas could grow really high.  With default
sysctl_max_map_count (64k) and default pid_max (32k) the max number of
vmas in the system is 2147450880 and the refcounter has headroom of
1073774592 before it reaches REFCOUNT_SATURATED (3221225472).

Therefore it's unlikely that an anonymous name refcounter will overflow
with these defaults.  Currently the max for pid_max is PID_MAX_LIMIT
(4194304) and for sysctl_max_map_count it's INT_MAX (2147483647).  In this
configuration anon_vma_name refcount overflow becomes theoretically
possible (that still require heavy sharing of that anon_vma_name between
processes).

kref refcounting interface used in anon_vma_name structure will detect a
counter overflow when it reaches REFCOUNT_SATURATED value but will only
generate a warning and freeze the ref counter. This would lead to the
refcounted object never being freed. A determined attacker could leak
memory like that but it would be rather expensive and inefficient way
to do so.

To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
sharing when the refcount reaches REFCOUNT_MAX (2147483647), which still
leaves INT_MAX/2 (1073741823) values before the counter reaches
REFCOUNT_SATURATED.  This should provide enough headroom for raising the
refcounts temporarily.

Link: https://lkml.kernel.org/r/20220223153613.835563-2-surenb@google.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
changes in v3:
- Amended description with what happens when refcount saturates,
per Michal Hocko
- Added Ack, per Michal Hocko

 include/linux/mm_inline.h | 18 ++++++++++++++----
 mm/madvise.c              |  3 +--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index dd3accaa4e6d..cf90b1fa2c60 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -161,15 +161,25 @@ static inline void anon_vma_name_put(struct anon_vma_name *anon_name)
 		kref_put(&anon_name->kref, anon_vma_name_free);
 }
 
+static inline
+struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
+{
+	/* Prevent anon_name refcount saturation early on */
+	if (kref_read(&anon_name->kref) < REFCOUNT_MAX) {
+		anon_vma_name_get(anon_name);
+		return anon_name;
+
+	}
+	return anon_vma_name_alloc(anon_name->name);
+}
+
 static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
 				     struct vm_area_struct *new_vma)
 {
 	struct anon_vma_name *anon_name = anon_vma_name(orig_vma);
 
-	if (anon_name) {
-		anon_vma_name_get(anon_name);
-		new_vma->anon_name = anon_name;
-	}
+	if (anon_name)
+		new_vma->anon_name = anon_vma_name_reuse(anon_name);
 }
 
 static inline void free_anon_vma_name(struct vm_area_struct *vma)
diff --git a/mm/madvise.c b/mm/madvise.c
index 081b1cded21e..1f2693dccf7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -113,8 +113,7 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
 	if (anon_vma_name_eq(orig_name, anon_name))
 		return 0;
 
-	anon_vma_name_get(anon_name);
-	vma->anon_name = anon_name;
+	vma->anon_name = anon_vma_name_reuse(anon_name);
 	anon_vma_name_put(orig_name);
 
 	return 0;
-- 
2.35.1.574.g5d30c73bfb-goog

