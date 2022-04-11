Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5691B4FBB23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbiDKLoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237230AbiDKLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73EE345786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649677322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7DSSalCMKrMQL2sXsyII9bpO/a5YUZjo+XSNzqSdDyY=;
        b=jCZX2NZRsmAXeubbYkq5jDn5jL3bY/0N/j1xI/ASz3h//lW8+0dA5R3Kfgl6Ht7dppM41q
        yX9KyOX+xMsLlrU//JTyyt8l3zYszJWBj2KwimlXxmcLYqrveTCYfIwXgLskJhuXWJVH4m
        xJTFZpnvU6PSfDp83u7rI1UQM2aChWI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-3s2iJBHaPSGB0kTYufBa5g-1; Mon, 11 Apr 2022 07:42:01 -0400
X-MC-Unique: 3s2iJBHaPSGB0kTYufBa5g-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso143391wma.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=7DSSalCMKrMQL2sXsyII9bpO/a5YUZjo+XSNzqSdDyY=;
        b=su+YAJ78RiUogwOawgUlhY0PkJGyFK/gVa1x4OwLiEUvUdOc4n3J6k0Eu9uwkP32Zs
         vOwpy6CCrksNULXLRhXVghpH54rSr0nKknAHP3H4LVym3O6bqM3zkH2R+dqMidepi27V
         8pj7wSPf3kgl3Q1hGtE+i2PbW6Zsbl4Oz8biMvTtsuexQU4dna2NFSH2Bm9zji8cxwMO
         TSFrrhTzJBoNL7o8sCnCkvwIMaP5VBS4xVbkJ4DZSLStN8y/+do1rCfS9XMXjZq5Hr66
         UR9TFALL6Kp6A02SqMDtgo9NK3sTiI2o9NyZAcOqXCvwkZheykkdNGGCjGJyFjFsoaMg
         0eXA==
X-Gm-Message-State: AOAM5304L9N3xtZVuV4UAa20OMY1UHIqKiJKlEdMujT7tc86iKq2DK5K
        kRTwxKjdhYIIOo3j0/89GEyWH9Lxjwe/V2Oa2E0sWpUCFQ1nz7nND/NdZ8+FxVIyYyveHZ0Le+u
        7yc6VNLf4bPz5cMOm7Gwag4sS
X-Received: by 2002:a05:600c:21d1:b0:381:4fed:159a with SMTP id x17-20020a05600c21d100b003814fed159amr29032270wmj.143.1649677320230;
        Mon, 11 Apr 2022 04:42:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFyEjzxc0zgKdZrTtMLN/bRitSPe9MQ9NWFxCCokqVwO5R2gJOb3FmGMihPyQbA4IMTuZ1Xg==
X-Received: by 2002:a05:600c:21d1:b0:381:4fed:159a with SMTP id x17-20020a05600c21d100b003814fed159amr29032250wmj.143.1649677320010;
        Mon, 11 Apr 2022 04:42:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:aa00:2064:15bd:222d:3a02? (p200300cbc703aa00206415bd222d3a02.dip0.t-ipconnect.de. [2003:cb:c703:aa00:2064:15bd:222d:3a02])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b0038e71072376sm17268187wms.19.2022.04.11.04.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 04:41:59 -0700 (PDT)
Message-ID: <a190e78f-d833-780b-6fbe-b129c2505deb@redhat.com>
Date:   Mon, 11 Apr 2022 13:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ying.huang@intel.com, ziy@nvidia.com, minchan@kernel.org,
        apopple@nvidia.com, dave.hansen@linux.intel.com,
        o451686892@gmail.com, jhubbard@nvidia.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, mhocko@suse.com, riel@redhat.com,
        osalvador@suse.de, sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220409073846.22286-1-linmiaohe@huawei.com>
 <20220409073846.22286-5-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 4/4] mm/migration: fix potential pte_unmap on an not
 mapped pte
In-Reply-To: <20220409073846.22286-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.22 09:38, Miaohe Lin wrote:
> __migration_entry_wait and migration_entry_wait_on_locked assume pte is
> always mapped from caller. But this is not the case when it's called from
> migration_entry_wait_huge and follow_huge_pmd. And a parameter unmap to
> indicate whether pte needs to be unmapped to fix this issue.

Hm.


migration_entry_wait_on_locked documents

"@ptep: mapped pte pointer. Will return with the ptep unmapped. Only
required for pte entries, pass NULL for pmd entries."

Setting ptep implies that we have a *mapped pte* pointer that requires unmap.
If some code sets that although that's not guaranteed, that calling code
is wrong and needs to be fixed to not pass a ptep.


hugetlbfs never requires a map/unmap. I really don't see we there is need to
adjust migration_entry_wait_on_locked(): just don't pass a ptep as documented.

What's really nasty here is that hugetlbfs actually mostly works on PMD/PUD,
but we call it PTEs. One corner case might be CONT PTEs, but they are also
accessed without a map+unmap.

Regarding __migration_entry_wait(), I think we should just stop using it for
hugetlbfs and have a proper hugetlbfs variant that calls
hugetlb_migration_entry_wait(ptep == NULL), and knows that although we're
handling ptes, we're usually not actually holding ptes in our hands
that need a map+unmap.


Something like (including some cleanups mm parameter):


diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 32d517a28969..898c407ad8f7 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -234,8 +234,8 @@ extern void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl);
 extern void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address);
-extern void migration_entry_wait_huge(struct vm_area_struct *vma,
-		struct mm_struct *mm, pte_t *pte);
+extern void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl);
+extern void migration_entry_wait_huge(struct vm_area_struct *vma, pte_t *pte);
 #else
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -261,8 +261,9 @@ static inline void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 					spinlock_t *ptl) { }
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					 unsigned long address) { }
+static inline void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
-		struct mm_struct *mm, pte_t *pte) { }
+					     pte_t *pte) { }
 static inline int is_writable_migration_entry(swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 48740e6c3476..2b38eaaa2e60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5622,7 +5622,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
-			migration_entry_wait_huge(vma, mm, ptep);
+			migration_entry_wait_huge(vma, ptep);
 			return 0;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
 			return VM_FAULT_HWPOISON_LARGE |
@@ -6770,7 +6770,7 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
 	} else {
 		if (is_hugetlb_entry_migration(pte)) {
 			spin_unlock(ptl);
-			__migration_entry_wait(mm, (pte_t *)pmd, ptl);
+			__migration_entry_wait_huge((pte_t *)pmd, ptl);
 			goto retry;
 		}
 		/*
diff --git a/mm/migrate.c b/mm/migrate.c
index 231907e89b93..84b685a235fe 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -315,11 +315,26 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	__migration_entry_wait(mm, ptep, ptl);
 }
 
+void __migration_entry_wait_huge(pte_t *ptep, spinlock_t *ptl)
+{
+	swp_entry_t entry;
+	pte_t pte;
+
+	spin_lock(ptl);
+	pte = huge_ptep_get(ptep);
+
+	if (unlikely(!is_hugetlb_entry_migration(pte)))
+		spin_unlock(ptl);
+	else
+		migration_entry_wait_on_locked(pte_to_swp_entry(pte), NULL, ptl);
+}
+
 void migration_entry_wait_huge(struct vm_area_struct *vma,
 		struct mm_struct *mm, pte_t *pte)
 {
-	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), mm, pte);
-	__migration_entry_wait(mm, pte, ptl);
+	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->mm, pte);
+
+	__migration_entry_wait_huge(pte, ptl);
 }
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION

-- 
Thanks,

David / dhildenb

