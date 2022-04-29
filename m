Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C2514ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbiD2NmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376362AbiD2NlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:41:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6DECB038
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:38:01 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so7325489pjf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eRy8MpvNC58F/UyXGBAubwgn5yhnXW5DArHTiriXqOA=;
        b=TkkXGSkcHeQ2HN+4kQyis5zmihRY3+P5XKbLE56DY4YYoqqTSnBAZQSkt8HShcDL1Y
         pna6lXKQks7nCKFwAb8lPv2ELLP1EHP7BC0L+tEblOUQ2tjXbPofhtBCEL4RHSKUiM+T
         SPXWW+3xIBJJPl60oVBE1kbw0YfRp5hBgkURC7WcxvTmgKuysqThrwaHfS2f/ZPJckX2
         iRS4JQjouD9CEKnyfCkh5QKVkKqvMDxXrYZFXA7bjAukG7CzEOo/V1CQpcoLZehvz0Ll
         t8R5QN2CL7ruHzsj5cLWt/UWgvclVrA8+xFk2tgGWIk8gd2+/YwSVDmRPNjq4+Ef8xwN
         DLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eRy8MpvNC58F/UyXGBAubwgn5yhnXW5DArHTiriXqOA=;
        b=xw462PZh7YgPUVV6u9a1qr1o5pS5ckhx8IWXBnKwI0KhUCfQ+PIIDxSum5CbAJ3WsQ
         M+zgM4REDlFRlBszJWuu4PIwx7+WtoRYe7YOewpfV4Sl8FGN3ybJZdCUnW5TN2Nj0Z0i
         LeEsVZ/qKQ31FVEwJ6r5UzxCh/8PHIgxPMK5K3xFH1xkHou/PyFmaL/JyWHptiw3JQhg
         vXUEKswYS/aqJ17kQ/erpXvPZJ3o7CZsCHS5MPeeP44K+n/H5AxZZ711gbj7p2yvG15V
         9vqldoJHrVMwjz2eKgBlAhHUhORsxLIsbhMbb9LJe62UNRWB5qDMTV/k2nPYQoTLq/Ex
         tJCw==
X-Gm-Message-State: AOAM531dRA8OoNrgSmevShtJFOb2JAboug5n6qAawTyfCILhLi0Y6f85
        +tPyEWW0/EvEgZzxbbcVN6kbYA==
X-Google-Smtp-Source: ABdhPJxSWULOjvO6LZb8fH5rIPVk36LG3U/StG5RIQqrXaps+4e7g0yd+bWTzUdJKU9VKCIdUNmIXg==
X-Received: by 2002:a17:902:cec3:b0:15d:242c:477d with SMTP id d3-20020a170902cec300b0015d242c477dmr22380034plg.54.1651239480766;
        Fri, 29 Apr 2022 06:38:00 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a414800b001d81a30c437sm10681977pjg.50.2022.04.29.06.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:38:00 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 18/18] Documentation: add document for pte_ref
Date:   Fri, 29 Apr 2022 21:35:52 +0800
Message-Id: <20220429133552.33768-19-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds document for pte_ref under `Documentation/vm/`.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/vm/index.rst   |   1 +
 Documentation/vm/pte_ref.rst | 210 +++++++++++++++++++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/vm/pte_ref.rst

diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
index 44365c4574a3..ee71baccc2e7 100644
--- a/Documentation/vm/index.rst
+++ b/Documentation/vm/index.rst
@@ -31,6 +31,7 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
    page_frags
    page_owner
    page_table_check
+   pte_ref
    remap_file_pages
    slub
    split_page_table_lock
diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
new file mode 100644
index 000000000000..0ac1e5a408d7
--- /dev/null
+++ b/Documentation/vm/pte_ref.rst
@@ -0,0 +1,210 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================================================
+pte_ref: Tracking about how many references to each user PTE page table page
+============================================================================
+
+Preface
+=======
+
+Now in order to pursue high performance, applications mostly use some
+high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
+These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
+physical memory for the following reasons::
+
+ First of all, we should hold as few write locks of mmap_lock as possible,
+ since the mmap_lock semaphore has long been a contention point in the
+ memory management subsystem. The mmap()/munmap() hold the write lock, and
+ the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
+ madvise() instead of munmap() to released physical memory can reduce the
+ competition of the mmap_lock.
+
+ Secondly, after using madvise() to release physical memory, there is no
+ need to build vma and allocate page tables again when accessing the same
+ virtual address again, which can also save some time.
+
+The following is the largest user PTE page table memory that can be
+allocated by a single user process in a 32-bit and a 64-bit system.
+
++---------------------------+--------+---------+
+|                           | 32-bit | 64-bit  |
++===========================+========+=========+
+| user PTE page table pages | 3 MiB  | 512 GiB |
++---------------------------+--------+---------+
+| user PMD page table pages | 3 KiB  | 1 GiB   |
++---------------------------+--------+---------+
+
+(for 32-bit, take 3G user address space, 4K page size as an example;
+ for 64-bit, take 48-bit address width, 4K page size as an example.)
+
+After using madvise(), everything looks good, but as can be seen from the
+above table, a single process can create a large number of PTE page tables
+on a 64-bit system, since both of the MADV_DONTNEED and MADV_FREE will not
+release page table memory. And before the process exits or calls munmap(),
+the kernel cannot reclaim these pages even if these PTE page tables do not
+map anything.
+
+To fix the situation, we introduces a reference count for each user PTE page
+table page. Then we can track whether users are using the user PTE page table
+page and reclaim the user PTE page table pages that does not map anything at
+the right time.
+
+Introduction
+============
+
+The ``pte_ref``, which is the reference count of user PTE page table page, is
+``percpu_ref`` type. It is used to track the usage of each user PTE page table
+page.
+
+Who will hold the pte_ref?
+--------------------------
+
+The following people will hold a pte_ref::
+
+ The !pte_none() entry, such as regular page table entry that map physical
+ pages, or swap entry, or migrate entry, etc.
+
+ Visitor to the PTE page table entries, such as page table walker.
+
+Any ``!pte_none()`` entry and visitor can be regarded as the user of the PTE
+page table page. When the pte_ref is reduced to 0, it means that no one is
+using the PTE page table page, then this free PTE page table page can be
+reclaimed at this time.
+
+About mode switching
+--------------------
+
+When user PTE page table page is allocated, its ``pte_ref`` will be initialized
+to percpu mode, which basically does not bring performance overhead. When we
+want to reclaim the PTE page, it will be switched to atomic mode. Then we can
+check if the ``pte_ref`` is zero::
+
+ - If it is zero, we can safely reclaim it immediately;
+ - If it is not zero but we expect that the PTE page can be reclaimed
+   automatically when no one is using it, we can keep its ``pte_ref`` in
+   atomic mode (e.g. MADV_FREE case);
+ - If it is not zero, and we will continue to try at the next opportunity,
+   then we can choose to switch back to percpu mode (e.g. MADV_DONTNEED case).
+
+Competitive relationship
+------------------------
+
+Now, the user page table will only be released by calling ``free_pgtables()``
+when the process exits or ``unmap_region()`` is called (e.g. ``munmap()`` path).
+So other threads only need to ensure mutual exclusion with these paths to ensure
+that the page table is not released. For example::
+
+	thread A			thread B
+	page table walker		munmap
+	=================		======
+
+	mmap_read_lock()
+	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
+		pte_offset_map_lock()
+		*walk page table*
+		pte_unmap_unlock()
+	}
+	mmap_read_unlock()
+
+					mmap_write_lock_killable()
+					detach_vmas_to_be_unmapped()
+					unmap_region()
+					--> free_pgtables()
+
+But after we introduce the ``pte_ref`` for the user PTE page table page, these
+existing balances will be broken. The page can be released at any time when its
+``pte_ref`` is reduced to 0. Therefore, the following case may happen::
+
+	thread A		thread B			thread C
+	page table walker	madvise(MADV_DONTNEED)		page fault
+	=================	======================		==========
+
+	mmap_read_lock()
+	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
+
+				mmap_read_lock()
+				unmap_page_range()
+				--> zap_pte_range()
+				    /* the pte_ref is reduced to 0 */
+				    --> free PTE page table page
+
+								mmap_read_lock()
+								/* may allocate
+								 * a new huge
+								 * pmd or a new
+								 * PTE page
+								 */
+
+		/* broken!! */
+		pte_offset_map_lock()
+
+As we can see, all of the thread A, B and C hold the read lock of mmap_lock, so
+they can execute concurrently. When thread B releases the PTE page table page,
+the value in the corresponding pmd entry will become unstable, which may be
+none or huge pmd, or map a new PTE page table page again. This will cause system
+chaos and even panic.
+
+So as described in the section "Who will hold the pte_ref?", the page table
+walker (visitor) also need to try to take a ``pte_ref`` to the user PTE page
+table page before walking page table (the helper ``pte_tryget_map{_lock}()``
+can help us to do this), then the system will become orderly again::
+
+	thread A		thread B
+	page table walker	madvise(MADV_DONTNEED)
+	=================	======================
+
+	mmap_read_lock()
+	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
+		pte_tryget()
+		--> percpu_ref_tryget
+		*if successfully, then:*
+
+				mmap_read_lock()
+				unmap_page_range()
+				--> zap_pte_range()
+				    /* the pte_refcount is reduced to 1 */
+
+		pte_offset_map_lock()
+		*walk page table*
+		pte_unmap_unlock()
+
+There is also a lock-less scenario(such as fast GUP). Fortunately, we don't need
+to do any additional operations to ensure that the system is in order. Take fast
+GUP as an example::
+
+	thread A		thread B
+	fast GUP		madvise(MADV_DONTNEED)
+	========		======================
+
+	get_user_pages_fast_only()
+	--> local_irq_save();
+				call_rcu(pte_free_rcu)
+	    gup_pgd_range();
+	    local_irq_restore();
+	    			/* do pte_free_rcu() */
+
+Helpers
+=======
+
++----------------------+------------------------------------------------+
+| pte_ref_init         | Initialize the pte_ref                         |
++----------------------+------------------------------------------------+
+| pte_ref_free         | Free the pte_ref                               |
++----------------------+------------------------------------------------+
+| pte_tryget           | Try to hold a pte_ref                          |
++----------------------+------------------------------------------------+
+| pte_put              | Decrement a pte_ref                            |
++----------------------+------------------------------------------------+
+| pte_tryget_map       | Do pte_tryget and pte_offset_map               |
++----------------------+------------------------------------------------+
+| pte_tryget_map_lock  | Do pte_tryget and pte_offset_map_lock          |
++----------------------+------------------------------------------------+
+| free_user_pte        | Free the user PTE page table page              |
++----------------------+------------------------------------------------+
+| try_to_free_user_pte | Try to free the user PTE page table page       |
++----------------------+------------------------------------------------+
+| track_pte_set        | Track the setting of user PTE page table page  |
++----------------------+------------------------------------------------+
+| track_pte_clear      | Track the clearing of user PTE page table page |
++----------------------+------------------------------------------------+
+
-- 
2.20.1

