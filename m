Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719AB558BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiFWXxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiFWXw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1910F1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h192so878265pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LG1rSzGEsPK4iv+N/lwp5PXQGNIYUtfM/aAuTYkg0vc=;
        b=kp5Fq94l6Q8wgGQCHb0XGJwN4XF5JHuSExD/vq+W4HulxPu4y7NpXpzk0sC4IbGOF0
         M8KAGgZc5kObwch9yTED6BTWncP2yvMtbr+bH+KSPK3guq1ThRAzdHSa+W71rWfvYi5Y
         ysRgIgyiMWh4MKt7L42JrZc5NkKFssOV2e5P4ICRr7BACAKuoQ/eu+QswjxOjsF8Qh9L
         /9q19zgN4ONQWZgUIzp2zk9FPdJ7T/61qXbmDITGTyaGcabR3hZpeQjiZAfpcM4Id7Ms
         ZxiNLZtA8OmC0bfzSoEwTbnAiH5hXBWlOsZ/GgJaKy63TSCZUNEzfRNHl4QZ+uHeTTH/
         Cbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LG1rSzGEsPK4iv+N/lwp5PXQGNIYUtfM/aAuTYkg0vc=;
        b=Rf9POphUVuawOCUwtvG2fJ/qZr+RxT/6lKQlsnLl9gi1rP4qde5CE/l5dLzCo/+yWQ
         Ey63T8V1VTTFh+50hdFnxkSKWF3exqCF9OwuWSVTtYWuprBKTWplZZ44RJCOdoK5ruYg
         +I/cR6PBZgwBBJeFq4FArS9E5O7pF/bKrjr4eyLcJAOx7Zl4KRLPq0b/ueBvUYRBN7Kh
         JhPQM+pH0lD/MkhjaFV40Mb4O+uz/odJU05N26qdO8GHdFAc4IVBFks6p/XJ8ZxWur6b
         MstZ1g3qAx2/RfwjK8JCpX6I9u5+7oLAw8TI79POIYcV/JiZXihm5H/F0g47nzdrLBF1
         e1HQ==
X-Gm-Message-State: AJIora+uP2cs0XUNXKOiFrunz2B2UlX4gGeap2tQPK/huIIINbJo/KG+
        KcI/JydZjHAhuuTRmaoYZA==
X-Google-Smtp-Source: AGRyM1tcKr8yX9/tffiNeAaqH/kIj/EK53FgF4ggMpoeeio6m/TIPEIsDaxtlmNYN+u9v8W4FmnXEg==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr43077948pfb.59.1656028372725;
        Thu, 23 Jun 2022 16:52:52 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:52 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
Date:   Fri, 24 Jun 2022 08:51:52 +0900
Message-Id: <20220623235153.2623702-9-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

Currently if memory_failure() (modified to remove blocking code with
subsequent patch) is called on a page in some 1GB hugepage, memory error
handling fails and the raw error page gets into leaked state.  The impact
is small in production systems (just leaked single 4kB page), but this
limits the testability because unpoison doesn't work for it.
We can no longer create 1GB hugepage on the 1GB physical address range
with such leaked pages, that's not useful when testing on small systems.

When a hwpoison page in a 1GB hugepage is handled, it's caught by the
PageHWPoison check in free_pages_prepare() because the 1GB hugepage is
broken down into raw error pages before coming to this point:

        if (unlikely(PageHWPoison(page)) && !order) {
                ...
                return false;
        }

Then, the page is not sent to buddy and the page refcount is left 0.

Originally this check is supposed to work when the error page is freed from
page_handle_poison() (that is called from soft-offline), but now we are
opening another path to call it, so the callers of __page_handle_poison()
need to handle the case by considering the return value 0 as success. Then
page refcount for hwpoison is properly incremented so unpoison works.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index db85f644a1e3..fc7b83cb6468 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1046,7 +1046,6 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
 		unlock_page(hpage);
 	} else {
-		res = MF_FAILED;
 		unlock_page(hpage);
 		/*
 		 * migration entry prevents later access on error hugepage,
@@ -1054,9 +1053,11 @@ static int me_huge_page(struct page_state *ps, struct page *p)
 		 * subpages.
 		 */
 		put_page(hpage);
-		if (__page_handle_poison(p) > 0) {
+		if (__page_handle_poison(p) >= 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
+		} else {
+			res = MF_FAILED;
 		}
 	}
 
@@ -1704,9 +1705,11 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	 */
 	if (res == 0) {
 		unlock_page(head);
-		if (__page_handle_poison(p) > 0) {
+		if (__page_handle_poison(p) >= 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
+		} else {
+			res = MF_FAILED;
 		}
 		action_result(pfn, MF_MSG_FREE_HUGE, res);
 		return res == MF_RECOVERED ? 0 : -EBUSY;
-- 
2.25.1

