Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44B47F2C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhLYJlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 04:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLYJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 04:41:12 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A1C061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 01:41:12 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so9367200qtj.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 01:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSLg1sVivxppYxme4VG7yM6rxhjRKrfG8yCADiK/1dg=;
        b=hxgIRgzXLL7bFpBWkYSP215G59jJQqx9ex0RJfVPDZ4GtPVr5AyOqhM9rZSJJfOF2O
         DQytruJgV2p7s1255rhu5ne0sE5MOop0z4Q9yvc0KlCPWCZ04srahO0z5mxDVycvGNqz
         /JM3Rm5nMALB7Hbb8Fs0ZBIfwYRhPyxqp5PuZRJ3YnsSGXgyq897d1UmrMyTouI8Y1ad
         nEzoEe5Ir/LSKbtrulnbSaVskHPse9/xsQREnovDGdCg9kj6irs6faN1t2DVz/g+V8d2
         1xhcnaQoZsnyRxzRRxZRLrQCVki9GPlMnkjaOHmhbH0IgKds8StLfy1CiDb7u7ddfW9Y
         fkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSLg1sVivxppYxme4VG7yM6rxhjRKrfG8yCADiK/1dg=;
        b=M35zqJWvJe/f3MqYG89Du+0oLuO1HzRLwjZ2Uwut+vKolBOVh0NfUihagDr1s6d7DN
         i/u61BDKB82xMYqbVNWKkq/8UpLTXycjKAoRzo9EZKxfp+f8xEFEIGdGmCBqpEtd5F4N
         AGAZM/euAY/eU5CDC8ZAzJA18bSwLtU8qbT+VhNUVyped9qhNhKcfULQ2hXpv9h2dQqQ
         2vSQsh9wnbioXFe9sP9NKD9AmCK0I6pwB1UABf98miN9UF9eVbPThGTBXzdP7ixqOuXa
         xjFIL8g8/cn+1BheLwsT1gCSmdZjI/7TovBMh3O9ZJRaxf0xKIP0p39F37QZ7NpzYqDU
         KEEA==
X-Gm-Message-State: AOAM532L0ovLFZyDbDeq/QtcTwBVI6sZYzF9VMrdqvyAykR7H0/Q703+
        ELycuExNA8daXFQHE20Ovmyqa/pVhCs=
X-Google-Smtp-Source: ABdhPJy3ceojF3/mbxHNzx6mC2dPUJ+jC2Ui5omROTlEQCDzlH+K1nwcq76StAFpe0KD1SPk8kBSgA==
X-Received: by 2002:a05:622a:1713:: with SMTP id h19mr8269225qtk.464.1640425271268;
        Sat, 25 Dec 2021 01:41:11 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j14sm8942483qkp.28.2021.12.25.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 01:41:10 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        ying.huang@intel.com
Cc:     dave.hansen@linux.intel.com, yang.yang29@zte.com.cn,
        minchan@kernel.org, saravanand@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/vmstat: add events for THP max_ptes_* exceeds
Date:   Sat, 25 Dec 2021 09:40:37 +0000
Message-Id: <20211225094036.574157-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

There are interfaces to adjust max_ptes_none, max_ptes_swap,
max_ptes_shared values, see
/sys/kernel/mm/transparent_hugepage/khugepaged/.

But system administrator maynot know which value is the best. So
Add those events to support adjusting max_ptes_* to suitable values.

For example, if default max_ptes_swap value causes too much failures,
and system uses zram whose IO is fast, administrator could increase
max_ptes_swap until THP_SCAN_EXCEED_SWAP_PTE not increase anymore.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 include/linux/vm_event_item.h | 3 +++
 mm/khugepaged.c               | 7 +++++++
 mm/vmstat.c                   | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index a185cc75ff52..7b2363388bfa 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -98,6 +98,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SPLIT_PAGE_FAILED,
 		THP_DEFERRED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
+		THP_SCAN_EXCEED_NONE_PTE,
+		THP_SCAN_EXCEED_SWAP_PTE,
+		THP_SCAN_EXCEED_SHARED_PTE,
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 		THP_SPLIT_PUD,
 #endif
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7720189a2da7..abcd6bd8b97a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -618,6 +618,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 				goto out;
 			}
 		}
@@ -636,6 +637,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		if (page_mapcount(page) > 1 &&
 				++shared > khugepaged_max_ptes_shared) {
 			result = SCAN_EXCEED_SHARED_PTE;
+			count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 			goto out;
 		}
 
@@ -1253,6 +1255,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 				continue;
 			} else {
 				result = SCAN_EXCEED_SWAP_PTE;
+				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
 				goto out_unmap;
 			}
 		}
@@ -1262,6 +1265,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 				continue;
 			} else {
 				result = SCAN_EXCEED_NONE_PTE;
+				count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 				goto out_unmap;
 			}
 		}
@@ -1290,6 +1294,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		if (page_mapcount(page) > 1 &&
 				++shared > khugepaged_max_ptes_shared) {
 			result = SCAN_EXCEED_SHARED_PTE;
+			count_vm_event(THP_SCAN_EXCEED_SHARED_PTE);
 			goto out_unmap;
 		}
 
@@ -2006,6 +2011,7 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 		if (xa_is_value(page)) {
 			if (++swap > khugepaged_max_ptes_swap) {
 				result = SCAN_EXCEED_SWAP_PTE;
+				count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
 				break;
 			}
 			continue;
@@ -2056,6 +2062,7 @@ static void khugepaged_scan_file(struct mm_struct *mm,
 	if (result == SCAN_SUCCEED) {
 		if (present < HPAGE_PMD_NR - khugepaged_max_ptes_none) {
 			result = SCAN_EXCEED_NONE_PTE;
+			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
 		} else {
 			node = khugepaged_find_target_node();
 			collapse_file(mm, file, start, hpage, node);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d701c335628c..4057372745d0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1353,6 +1353,9 @@ const char * const vmstat_text[] = {
 	"thp_split_page_failed",
 	"thp_deferred_split_page",
 	"thp_split_pmd",
+	"thp_scan_exceed_none_pte",
+	"thp_scan_exceed_swap_pte",
+	"thp_scan_exceed_share_pte",
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	"thp_split_pud",
 #endif
-- 
2.25.1

