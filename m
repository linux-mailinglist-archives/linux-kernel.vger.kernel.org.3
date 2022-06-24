Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B0B55A01E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiFXRhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiFXRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:26 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A65DF3E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:24 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id j15-20020ab0644f000000b00368bac468ceso1007662uap.17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BHwQikGJ0T9dngSuqajvJzRNJRNB+p1hBOZL6v8gtdU=;
        b=SJaLm0XrTpsH4nsCpNczOnWA4pAKrfnpfCQD7J/A/w8ZLuyF3qMil1lg2kFawB2M4a
         itbVC6Cy96FvwmkCOrHBppgxya0l4XK+nbemqmVGl2TtO1nxOedDpeGypnCjJRZS7QQN
         NDC0hCezqTOYHNT6HpGvGH8b8GjOJaayBlAgzsQ6R71RrjTlRa2+jtXbsXNhdPHlJ6Xj
         Bf0Xtsg/vvdXkEZqCE7ZRTpn6YWG/VddVaye5OHuJMLgDbbZwZkgCRO6djsmySZP8iDS
         KKIDvmk/HJlHB4lLRHC4SCJoBQ4oZp4rMf+AAsSXjtVnRk/loJUaiEBO6jLZd1OibD+8
         oWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BHwQikGJ0T9dngSuqajvJzRNJRNB+p1hBOZL6v8gtdU=;
        b=y5m8IjKspkb9qekqrWFumUh7pDEku/dAz2XjEfai7lE2yCkD/Qeu6aLSI1WBfXi2gI
         9CmPDgBW7tmOVAGCndEM4Xeb5a2MUYQ/bHHL4JECvUkzLrZlIvQARly5yiFbfCYv/mKM
         NkjKq+oHnjOODUUMR5jPX46PgU6xZyHzMgXjaOS8zpcNF9fBJLn5kJEcIlOZ7GDeVIVg
         VZCv4JI30sUJx1UJ4CCZ4bIYgHUglB6+eKkPZoeujakvVS9bd8VefbmQudHhIt+4yvLY
         o3t/PIcf293uYYjXa+51TO4BS9Cki1gV44snPOmA30lOuN8NBaUie+nMiT31LrSzZcdo
         CpLA==
X-Gm-Message-State: AJIora8b2UiaDNUnofBqXF9dDNUynpJ3rmoOodEFxMkkkS62Gcul2+cT
        TzHCMJAlHbzf5QuN7CBHjCpmHKx0C1OTX3F0
X-Google-Smtp-Source: AGRyM1vwAeqnR6McfUFoedAHpp3M9GTRsmGOf0kSjUYrMb74mEmizd7GUpekp5x9kN5nii0pCQDDYM1i4RCw9Zq8
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a67:d785:0:b0:354:355b:60cd with SMTP
 id q5-20020a67d785000000b00354355b60cdmr14256935vsj.65.1656092243596; Fri, 24
 Jun 2022 10:37:23 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:40 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-11-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 10/26] hugetlb: add for_each_hgm_shift
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

This is a helper macro to loop through all the usable page sizes for a
high-granularity-enabled HugeTLB VMA. Given the VMA's hstate, it will
loop, in descending order, through the page sizes that HugeTLB supports
for this architecture; it always includes PAGE_SIZE.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8b10b941458d..557b0afdb503 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6989,6 +6989,16 @@ bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
 	/* All shared VMAs have HGM enabled. */
 	return vma->vm_flags & VM_SHARED;
 }
+static unsigned int __shift_for_hstate(struct hstate *h)
+{
+	if (h >= &hstates[hugetlb_max_hstate])
+		return PAGE_SHIFT;
+	return huge_page_shift(h);
+}
+#define for_each_hgm_shift(hstate, tmp_h, shift) \
+	for ((tmp_h) = hstate; (shift) = __shift_for_hstate(tmp_h), \
+			       (tmp_h) <= &hstates[hugetlb_max_hstate]; \
+			       (tmp_h)++)
 #endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 
 /*
-- 
2.37.0.rc0.161.g10f37bed90-goog

