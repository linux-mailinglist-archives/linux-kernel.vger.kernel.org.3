Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60894BF193
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiBVFlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:41:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiBVFk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:40:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372859D075
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s11-20020a255e0b000000b0062277953037so22966440ybb.21
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EUVVGZ+sfFkAlbWcLcOfWelo8aSG6wtK/MR4mUfnNyc=;
        b=fpKWCGjam3h+oTc0b3WTir63RzOkNxXZgU5vtYBVjVlxzP5vP/UzSd57jCvC6qB9QY
         wnW7RUHe1MmvyANTL3zgrIrab9nIWp9DhoBpbeeL8c1uF0/9Oh6Q2wRSBgXSpcue+JVq
         rUzEGcNR0RVhA+BN4ZOd2DlPj1XYJBw4WnotnP3QgboCwWf3osqEqMWixUmN//eQx9jr
         O2rDmJeaQcpGM0+aP2JGf5YVs1XKpozN2vXj1EKQ/icvgRL1sGoWkuX8qm/EsMHDe0pj
         U9PuDoDRtQLLQGx/aXAe/1kKHlALYnkO3Qt2O/eQnn0ydTcdIUKdkDsP39r5Qg7MuYY/
         CNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EUVVGZ+sfFkAlbWcLcOfWelo8aSG6wtK/MR4mUfnNyc=;
        b=UviYBqe2ua0dn8JQD+V2VcJBsvlD0AIg6IbAqyiYR8/q65GObkLkuvxybPYdGPBZh4
         O+z117g+iQRqIIEXVXroZ4YUI5UlaU3Csl60Uh3Wh4Wlxku5GabZPfSNJvlk73ikJUTw
         GHP1SE4Fl8v5382LVehcIw8h9IU+VrIfu70z8jXOR6Fa5k1ZcUyZ8I0oEQdnpqAFB7rN
         LKCIytXaQEZCDTEBu+ro+cZtpwSG+9BERHgzYniIWn8yJMxdDo0+PU5z5Tl5Kl0L88bf
         HP2JS/TVMTHQBjT6/aoAqO1kP3Rczasbdcs7ULyiM/TBNtY8n3hNw88nXWxsS0xQQZiX
         x7Fg==
X-Gm-Message-State: AOAM531Iwfc4i2Jtlb7tPfI/b2WUBMf7JemrW2E9TpPN/X7s54nDgMoX
        vwmLY1NZQV2AtrINeESxf0HdNZURnR8=
X-Google-Smtp-Source: ABdhPJwVOasBVfLeQeogd5ubt0z+Z2Jo+Med/RLmizMF6Vlq5T8zcqx5UBl7TcdJuZhVwz7vc9q5T1juSek=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:79c1:8a4c:5d17:670f])
 (user=surenb job=sendgmr) by 2002:a81:6184:0:b0:2d6:c22c:2a66 with SMTP id
 v126-20020a816184000000b002d6c22c2a66mr16578937ywb.311.1645508432422; Mon, 21
 Feb 2022 21:40:32 -0800 (PST)
Date:   Mon, 21 Feb 2022 21:40:24 -0800
In-Reply-To: <20220222054025.3412898-1-surenb@google.com>
Message-Id: <20220222054025.3412898-2-surenb@google.com>
Mime-Version: 1.0
References: <20220222054025.3412898-1-surenb@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH 2/3] mm: prevent vm_area_struct::anon_name refcount saturation
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

A deep process chain with many vmas could grow really high. kref
refcounting interface used in anon_vma_name structure will detect
a counter overflow when it reaches REFCOUNT_SATURATED value but will
only generate a warning about broken refcounting.
To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
sharing when the refcount reaches INT_MAX, which still leaves INT_MAX/2
values before the counter reaches REFCOUNT_SATURATED. This should provide
enough headroom for raising the refcounts temporarily.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm_inline.h | 18 ++++++++++++++----
 mm/madvise.c              |  3 +--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 70b619442d56..b189e2638843 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -156,15 +156,25 @@ static inline void anon_vma_name_get(struct anon_vma_name *anon_name)
 
 extern void anon_vma_name_put(struct anon_vma_name *anon_name);
 
+static inline
+struct anon_vma_name *anon_vma_name_reuse(struct anon_vma_name *anon_name)
+{
+	/* Prevent anon_name refcount saturation early on */
+	if (kref_read(&anon_name->kref) < INT_MAX) {
+		anon_vma_name_get(anon_name);
+		return anon_name;
+
+	}
+	return anon_vma_name_alloc(anon_name->name);
+}
+
 static inline void dup_vma_anon_name(struct vm_area_struct *orig_vma,
 				     struct vm_area_struct *new_vma)
 {
 	struct anon_vma_name *anon_name = vma_anon_name(orig_vma);
 
-	if (anon_name) {
-		anon_vma_name_get(anon_name);
-		new_vma->anon_name = anon_name;
-	}
+	if (anon_name)
+		new_vma->anon_name = anon_vma_name_reuse(anon_name);
 }
 
 static inline void free_vma_anon_name(struct vm_area_struct *vma)
diff --git a/mm/madvise.c b/mm/madvise.c
index f81d62d8ce9b..a395884aeecb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -122,8 +122,7 @@ static int replace_vma_anon_name(struct vm_area_struct *vma,
 	if (anon_vma_name_eq(orig_name, anon_name))
 		return 0;
 
-	anon_vma_name_get(anon_name);
-	vma->anon_name = anon_name;
+	vma->anon_name = anon_vma_name_reuse(anon_name);
 	anon_vma_name_put(orig_name);
 
 	return 0;
-- 
2.35.1.473.g83b2b277ed-goog

