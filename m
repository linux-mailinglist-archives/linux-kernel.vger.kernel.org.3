Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957624C16EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiBWPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242122AbiBWPgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:36:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40012BB57B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:36:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so3786930ybp.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VTm7fP795OcGxTyvbahW12BdyN0osMpgZF+oc5TFR48=;
        b=IRWJmzYqcQ3FOFrXy/WU1zsLFBzMCkcEVBFDmvJo0x44BOSca5zhysVzPxz+4FPm1/
         OiSFXHCdeqG/LaaoyQ0VTPkUwgIhTrm77sOWyc3sWxmZcwNbUk2nwCuNdbxiCy428MHz
         MG609HxJ9QLQ3zBWtV9vLCvyi2jU5vcOCTLb5FHepKP/L3xcYhgTM2XLFabE9iT6Utuq
         iaaa0dXYRB9deRLvG64p5RHZg7AQtf1+JvSwPIfQ1Sz7tSf865E6QU2vZoDEgkEa4bYD
         1O0GrjoEmBa1lc7H1NU7LF/HODYw4KmV9KnSGp90MJUpcWrmazrmoV/4sWKVoAa0Edlb
         lckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VTm7fP795OcGxTyvbahW12BdyN0osMpgZF+oc5TFR48=;
        b=UL2TcQDl2XSeMy3KUeSqFRq6fJ/IVJfSjiLVbcejYZahQgvF636cZTEf6lz6B75DYv
         GZZKKLC/SPiD6otwNXDB9vZeqDXSXr0XEv03WiurP1oEb8Kk0FO2c2+5vNbpS/inHNCl
         FNG5s6kSawjxw0OzkFpyKpRUhd5Yb2k6HGvNAvwvbpYSUqLxyvU5ZuYVjOx7tFehIhyr
         KpeEM/UVaIS4aUa235cmjwgxMym9EwdoZwKi3zQoZId3HNFCvwgaCWPxooAN+y3ojahb
         es50tciEMdxLZnLWJqfwtHf1uzPK98ecgkdts0nVBusyqkkMAjb9MHm5uyxLfiy/tTFy
         w8Jw==
X-Gm-Message-State: AOAM53395Mm1NCLW4IENAX/uXKaRiPW1olXaTe1tLB7dWUp/wjyNedk+
        /wroXeKbUMB6uETXZm7t4lTjH34iyHw=
X-Google-Smtp-Source: ABdhPJw+ehLGYr/coulof1rBJJzPvQAJiBIsiXatKMdNfWrhBrL6oVKrpydjbcVTigvdAofGAgHfZlN35m0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:5093:9fb5:d0ba:a5f])
 (user=surenb job=sendgmr) by 2002:a25:180b:0:b0:61a:a60:e7b0 with SMTP id
 11-20020a25180b000000b0061a0a60e7b0mr274980yby.454.1645630580430; Wed, 23 Feb
 2022 07:36:20 -0800 (PST)
Date:   Wed, 23 Feb 2022 07:36:12 -0800
In-Reply-To: <20220223153613.835563-1-surenb@google.com>
Message-Id: <20220223153613.835563-2-surenb@google.com>
Mime-Version: 1.0
References: <20220223153613.835563-1-surenb@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 2/3] mm: prevent vm_area_struct::anon_name refcount saturation
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

A deep process chain with many vmas could grow really high.
With default sysctl_max_map_count (64k) and default pid_max (32k)
the max number of vmas in the system is 2147450880 and the
refcounter has headroom of 1073774592 before it reaches
REFCOUNT_SATURATED (3221225472). Therefore it's unlikely that
an anonymous name refcounter will overflow with these defaults.
Currently the max for pid_max is PID_MAX_LIMIT (4194304) and
for sysctl_max_map_count it's INT_MAX (2147483647). In this
configuration anon_vma_name refcount overflow becomes
theoretically possible (that still require heavy sharing of
that anon_vma_name between processes).
kref refcounting interface used in anon_vma_name structure will
detect a counter overflow when it reaches REFCOUNT_SATURATED value
but will only generate a warning about broken refcounter.
To ensure anon_vma_name refcount does not overflow, stop anon_vma_name
sharing when the refcount reaches REFCOUNT_MAX (2147483647), which
still leaves INT_MAX/2 (1073741823) values before the counter reaches
REFCOUNT_SATURATED. This should provide enough headroom for raising
the refcounts temporarily.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v2:
- Updated description to include calculation details, per Michal Hocko

 include/linux/mm_inline.h | 18 ++++++++++++++----
 mm/madvise.c              |  3 +--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 4bad32507570..f82085ff8a6b 100644
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
2.35.1.473.g83b2b277ed-goog

