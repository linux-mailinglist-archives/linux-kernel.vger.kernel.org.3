Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D7558BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiFWXw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiFWXwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:53 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA560C53
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n10so665774plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KvUi4xXUaw0Gsdez/sII2VYp9q4T8l1odrgep5/r9aE=;
        b=b71HZZHM2aY5ylc8U6Uu7sxHM5Q4Dz7cL/mOReiZJuAaeu2rHNu+hnQmQAv38dDmwP
         pOKIk5yY/X85zQfa1Ys2n7GhIPD0SVPxsFL/z9/OGvRegbXwb/U4EHvDpjg7cQ1S0pyP
         KWtLwypFgkCY/db06rZ/D2urozJab3xD2VJxRbQ0no53NC4CzSsNbu/G6NHqRh9A8X+F
         8OTJbDheCebOpKua3A0uEj2qHKjRhFb2+wCy2g910KB5HQ2VrIMCFd/2r8H0V9axz7PU
         b2cZtNIaDaxWhsGU+tHFIrLWR/bKzQEwuNlwc7ldCcwha2zy4xep6e7bfU6vHKhpsNqV
         7Cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KvUi4xXUaw0Gsdez/sII2VYp9q4T8l1odrgep5/r9aE=;
        b=TerCug24D2xvDqJwPbU2RgOjVJB7OTQYBeUTA+4BlBNUU+GOrf+/xfH8lsV1Df7I7r
         nEKSnyCPsvX3RMCCGVvM8xiy2c/Fj0ijvTtQg5hErVM2SqX3bqvwPxwSI1ZXhcxQIS9P
         xAlHnogjX6rXeHp288kcFZxResHFqutCGUchhBMtWIRfMH4lZdRgNayi7lO8Uvv24s3D
         8TBCebLz4zXw6zPRGKF1OGTVQr15qOoFgy+2M9G2rGUnO2dCyNZ+RmhIIhZXIKbShbr6
         BvllU+u6AzZqS0lxhb9GQ+PlP013VL7w+EDNHfNhM/jQz0vwYBXtr0zpjW5ce7mgkt9y
         FZEw==
X-Gm-Message-State: AJIora/C+3qi/AYzmlb5C7iBhmclkx4Qpl++t60WgqlkBowCEFd7TEFB
        msJ5XyUqGXlxB2OVMl0SwA==
X-Google-Smtp-Source: AGRyM1u3RWXKYbvMbZlXJV9HgWdbCWIpY9vHZiP0MBdnlmG8yhoNWv12HEJym6YydHWar1VwhEIpYw==
X-Received: by 2002:a17:902:ebc1:b0:168:fd13:8adc with SMTP id p1-20020a170902ebc100b00168fd138adcmr41512651plg.161.1656028366487;
        Thu, 23 Jun 2022 16:52:46 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:46 -0700 (PDT)
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
Subject: [PATCH v2 6/9] mm, hwpoison: set PG_hwpoison for busy hugetlb pages
Date:   Fri, 24 Jun 2022 08:51:50 +0900
Message-Id: <20220623235153.2623702-7-naoya.horiguchi@linux.dev>
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

If memory_failure() fails to grab page refcount on a hugetlb page
because it's busy, it returns without setting PG_hwpoison on it.
This not only loses a chance of error containment, but breaks the rule
that action_result() should be called only when memory_failure() do
any of handling work (even if that's just setting PG_hwpoison).
This inconsistency could harm code maintainability.

So set PG_hwpoison and call hugetlb_set_page_hwpoison() for such a case.

Fixes: 405ce051236c ("mm/hwpoison: fix race between hugetlb free/demotion and memory_failure_hugetlb()")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 include/linux/mm.h  | 1 +
 mm/memory-failure.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4346e51484ba..044dc5a2e361 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3233,6 +3233,7 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
+	MF_NO_RETRY = 1 << 6,
 };
 extern int memory_failure(unsigned long pfn, int flags);
 extern void memory_failure_queue(unsigned long pfn, int flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6005e953d011..ce045d0d6115 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1632,7 +1632,8 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 			count_increased = true;
 	} else {
 		ret = -EBUSY;
-		goto out;
+		if (!(flags & MF_NO_RETRY))
+			goto out;
 	}
 
 	if (hugetlb_set_page_hwpoison(head, page)) {
@@ -1659,7 +1660,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	struct page *p = pfn_to_page(pfn);
 	struct page *head;
 	unsigned long page_flags;
-	bool retry = true;
 
 	*hugetlb = 1;
 retry:
@@ -1675,8 +1675,8 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		}
 		return res;
 	} else if (res == -EBUSY) {
-		if (retry) {
-			retry = false;
+		if (!(flags & MF_NO_RETRY)) {
+			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		action_result(pfn, MF_MSG_UNKNOWN, MF_IGNORED);
-- 
2.25.1

