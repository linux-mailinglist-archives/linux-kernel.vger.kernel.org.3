Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E43D4B027A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiBJB5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:57:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiBJB4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:56:08 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F96C2BB32
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:54:10 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id p17-20020a0568301d5100b005a3cd7c1e0bso2523097oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w6tX9+LQQBgQkkL2Bmc0Ipn0ZYxEiQaM6qO9zXS/sD4=;
        b=LyjUs12jFchRbYf+ASxBxNEsiClOdfJyVsWMQuJzQI0s4J1EDfEochhm9jtdOxvzSG
         swfXSCSS0eDITV/XVz2A7h3CdX6ZbRxSVNgEmyCBbGkuQ2vxRFseuHb8Ym9aOaID3Mq7
         DCtuv5TJLO4how//y3nZ6OHBTV0CAVTNUpPpfv9okzd/ucPaM2YF3IjIq8z11SpkrhQS
         Oj/4q7ldfEpSIM/hKhG2eKnLRpaJT+KJk5ESLvNRoBLU+simsYvCINODJkCAfMbawKlY
         F1AFB6IWWoBOHHCcxoXxHayWcKC7nYbnauL6bqLdpZhJZojGa10aAsdRirLHqVKjV3sP
         GrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w6tX9+LQQBgQkkL2Bmc0Ipn0ZYxEiQaM6qO9zXS/sD4=;
        b=6oGFvk+e/MzJkTUzmvk49MNgQCS1az2XzGLqVQ/xpiVmz5KALtuDpvCqC16v16M/63
         5KKD9N2etoMrnmhk819RkrKo4HDY38EuqHQRR00QJg6Z+0FTmOfCoo4QlHj/fLY1TeAV
         19Lr6wNgothERUACq+naJQMn8gKjtsnfxSu1stVOIuq3Mk1X3cnifzcAKbpNZpVze/zQ
         9+7UrooTITSqhQAUoBzwSzMNAy0LZLyXc6TDQUv96FexkeyZHRZG/XcEKwWs2jLCZlgV
         qT1WG6AvNWgCZ7SW9GX2cegttGfW0rqON4aPaosFua8yEOt8HsOh6uqu62IJEmNVDymR
         Gzog==
X-Gm-Message-State: AOAM531GREUdb+C2YMBHokprQw1MCZaoat1YXDTa5gqzpJc7iLI9OLqU
        6JaOyfrXEhtcDYITTaO8Hsgf3+RNAhM=
X-Google-Smtp-Source: ABdhPJxjQE6hDRgB3Yfh1egBA9CHmneYX+GIeGCDPvULa2hWWGNpM3Vp4gBNGaRiiDyaUPor7WTgh6F8ApM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:17d2:7c05:7f59:da03])
 (user=surenb job=sendgmr) by 2002:a81:4a07:: with SMTP id x7mr4764404ywa.245.1644452286222;
 Wed, 09 Feb 2022 16:18:06 -0800 (PST)
Date:   Wed,  9 Feb 2022 16:18:01 -0800
Message-Id: <20220210001801.15413-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 1/1] mm: Fix UAF when anon vma name is used after vma is freed
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
originally passed to madvise_update_vma being destroyed. In the current
implementation, the name parameter passed to madvise_update_vma points
directly to vma->anon_name->name and it is used after the call to
vma_merge. In the cases when vma_merge merges the original vma and
destroys it, this will result in use-after-free bug as shown below:

madvise_vma_behavior << passes vma->anon_name->name as name param
  madvise_update_vma(name)
    vma_merge
      __vma_adjust
        vm_area_free <-- frees the vma
    replace_vma_anon_name(name) <-- UAF

Fix this by passing madvise_update_vma a copy of the name.

Fixes: 9a10064f5625 ("mm: add a field to store names for private anonymous memory")
Reported-by: syzbot+aa7b3d4b35f9dc46a366@syzkaller.appspotmail.com
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h |  2 ++
 kernel/sys.c       |  1 -
 mm/madvise.c       | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 213cc569b192..e3490be76f35 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3370,6 +3370,8 @@ static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
 	return 0;
 }
 
+#define ANON_VMA_NAME_MAX_LEN	80
+
 #ifdef CONFIG_ANON_VMA_NAME
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in, const char *name);
diff --git a/kernel/sys.c b/kernel/sys.c
index ecc4cf019242..4cb6dc4bc09c 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2263,7 +2263,6 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 
 #ifdef CONFIG_ANON_VMA_NAME
 
-#define ANON_VMA_NAME_MAX_LEN		80
 #define ANON_VMA_NAME_INVALID_CHARS	"\\`$[]"
 
 static inline bool is_valid_name_char(char ch)
diff --git a/mm/madvise.c b/mm/madvise.c
index 5604064df464..f36a5a9942d8 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -976,6 +976,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 {
 	int error;
 	unsigned long new_flags = vma->vm_flags;
+	char name_buf[ANON_VMA_NAME_MAX_LEN];
+	const char *anon_name;
 
 	switch (behavior) {
 	case MADV_REMOVE:
@@ -1040,8 +1042,18 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		break;
 	}
 
+	anon_name = vma_anon_name(vma);
+	if (anon_name) {
+		/*
+		 * Make a copy of the name because vma might be destroyed when
+		 * merged with another one and the name parameter might be used
+		 * after that.
+		 */
+		strcpy(name_buf, anon_name);
+		anon_name = name_buf;
+	}
 	error = madvise_update_vma(vma, prev, start, end, new_flags,
-				   vma_anon_name(vma));
+				   anon_name);
 
 out:
 	/*
-- 
2.35.0.263.gb82422642f-goog

