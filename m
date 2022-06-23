Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC40558BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiFWXwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiFWXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2960C40
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id x4so1070349pfq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l+d0OGtRtkY09M0VLBofFywNSItSfbSemC3EkYMtQyY=;
        b=ou1qFSPl8LCvTmp9oUsKtEu26AbVApYmilkjIi5Rqdhn7tRx0awXZilRcMS07UUquu
         QsIs67X8QqsYXNyNzHjQNz4bMesy8pxAo3Bce4yXtWS4IsYr//Q6obb1scOMH/WtDmL/
         SsxBh2QpvXr8qN7vUjWsuvyZg8bCvfUzCU06EOdhNks5pav3NCoN2wDpgXepSFDFWoJh
         8gCeRcS9v75oR4dEJJeo6B0GAHI6EUGSyxBzaS1PBsydIbR84FKq3cCjokSPygKkHr3b
         DoJiHIvWanhxYmJRFwaglGt55RhnE69wEJocNsqgwWlBFy7k6z/n2lV6xFjGI2JJQole
         GCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l+d0OGtRtkY09M0VLBofFywNSItSfbSemC3EkYMtQyY=;
        b=DJ61OosgAA9Xu1zg5jbPd/MgGoR9m0T3cFJQcWhCtDItMU7fkSv65wmaOYqyw9JiMU
         2KDCq+Gkpt9uyWaUrk4tjQMOyqIDW/NMG0v0nu5OhTV+cmnWjb5ThxVw1mLTYCYwxvBE
         4TNynxpaLtiqO0z6jSRxloqIirbRae2B7nnSL4UGtRNVp+Bjhsue/nREAFafTwPetzkJ
         k+3gwQ5SZZ6DKq1mBwijTXD28ku1wJpAngin7fbk02Lkzr93kEInjzwrp6f6AJESn3iV
         31rrfNZtVZiM9/TKwHXTqQhLJDCD6i/V0PMlIN3Y9b604ArSIUVMGRjM/7Dmb/q/ZSdX
         3b5Q==
X-Gm-Message-State: AJIora/mrT69uaPfDIYAzHm48jp/3NUEQFG2F9v7VfIVuZ3RFjfVgKom
        6/e8XvUTj6JftV0zUZzUXQ==
X-Google-Smtp-Source: AGRyM1sCQntLUzCfsXoFtqsZy7Xh7dUH0cStwNLtXgYEfOK9ftLkc8zvJEC5P2/PdCc5Fs8haLDBMg==
X-Received: by 2002:a05:6a00:134f:b0:51c:4c92:1dae with SMTP id k15-20020a056a00134f00b0051c4c921daemr43342643pfu.32.1656028354057;
        Thu, 23 Jun 2022 16:52:34 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:33 -0700 (PDT)
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
Subject: [PATCH v2 2/9] mm/hugetlb: separate path for hwpoison entry in copy_hugetlb_page_range()
Date:   Fri, 24 Jun 2022 08:51:46 +0900
Message-Id: <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
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

Originally copy_hugetlb_page_range() handles migration entries and hwpoisone
entries in similar manner.  But recently the related code path has more code
for migration entries, and when is_writable_migration_entry() was converted
to !is_readable_migration_entry(), hwpoison entries on source processes got
to be unexpectedly updated (which is legitimate for migration entries, but
not for hwpoison entries).  This results in unexpected serious issues like
kernel panic when foking processes with hwpoison entries in pmd.

Separate the if branch into one for hwpoison entries and one for migration
entries.

Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: <stable@vger.kernel.org> # 5.18
---
 mm/hugetlb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c538278170a2..f59f43c06601 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4784,8 +4784,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 * sharing with another vma.
 			 */
 			;
-		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
-				    is_hugetlb_entry_hwpoisoned(entry))) {
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+			bool uffd_wp = huge_pte_uffd_wp(entry);
+
+			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+				entry = huge_pte_clear_uffd_wp(entry);
+			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
+		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
 			bool uffd_wp = huge_pte_uffd_wp(entry);
 
-- 
2.25.1

