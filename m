Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B691D55E8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346791AbiF1NoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346734AbiF1Nnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:43:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C91E3DF;
        Tue, 28 Jun 2022 06:43:47 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXQjj5pRbzdZt9;
        Tue, 28 Jun 2022 21:41:29 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 21:43:45 +0800
Received: from huawei.com (10.175.112.208) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:43:44 +0800
From:   Guo Mengqi <guomengqi3@huawei.com>
To:     <alexs@kernel.org>, <siyanteng@loongson.cn>, <corbet@lwn.net>,
        <bobwxc@email.cn>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuqiang36@huawei.com>, <guomengqi3@huawei.com>
Subject: [PATCH -next] docs/zh_CN: add vm transhuge translation
Date:   Tue, 28 Jun 2022 21:37:42 +0800
Message-ID: <20220628133742.91966-1-guomengqi3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_20,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate .../vm/transhuge.rst into Chinese.

Signed-off-by: Guo Mengqi <guomengqi3@huawei.com>
---
 Documentation/translations/zh_CN/vm/index.rst |   2 +-
 .../translations/zh_CN/vm/transhuge.rst       | 151 ++++++++++++++++++
 2 files changed, 152 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/vm/transhuge.rst

diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentation/translations/zh_CN/vm/index.rst
index c77a56553845..2d82b15b272b 100644
--- a/Documentation/translations/zh_CN/vm/index.rst
+++ b/Documentation/translations/zh_CN/vm/index.rst
@@ -59,11 +59,11 @@ Linux内存管理文档
    vmalloced-kernel-stacks
    z3fold
    zsmalloc
+   transhuge
 
 TODOLIST:
 * arch_pgtable_helpers
 * free_page_reporting
 * hugetlbfs_reserv
 * slub
-* transhuge
 * unevictable-lru
diff --git a/Documentation/translations/zh_CN/vm/transhuge.rst b/Documentation/translations/zh_CN/vm/transhuge.rst
new file mode 100644
index 000000000000..a7bed8b13a47
--- /dev/null
+++ b/Documentation/translations/zh_CN/vm/transhuge.rst
@@ -0,0 +1,151 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/vm/transhuge.rst
+
+:翻译:
+
+ 郭梦琪 Guo Mengqi <guomengqi3@huawei.com>
+
+:校译:
+
+==============
+透明大页机制
+==============
+
+本文档描述透明大页（THP）的设计理念，以及它是如何与内存管理系统其他部分交互的。
+
+设计原则
+========
+
+- “优雅fallback”：有些mm组件不了解透明大页的存在，它们的回退方法是将PMD页表项
+  拆分成PTE页表项。必要时还需要拆分透明大页。这样就可以在常规大小的页或页表项上
+  继续工作。
+
+- 如果内存碎片化导致大页分配失败，则分配常规页作为替代放入原vma中，此期间不应
+  产生任何失败或明显延迟，不要引起用户态的注意。
+
+- 如果一些进程退出后释放了空余的大页（不论在伙伴系统还是在VM），由常规页支持的
+  guest物理内存应该自动重新申请为大页。(通过khugepaged进程)
+
+- 透明大页不需要预留内存，而是尽可能使用已经存在的大页。（唯为避免不可移动的页
+  将整个内存碎片化，唯一可能的预留是在kernelcore=的设置中。不过这个调整并不仅
+  针对透明大页，而对内核中所有动态的多级页面申请都通用。）
+
+get_user_pages和follow_page
+===========================
+
+不论对单个大页还是hugetlbfs，使用get_user_pages和follow_page时，返回的会是首页或
+尾页。大多数情况下调用get_user_page功能的人不关心页的大小，只关心页的真实物理
+地址以及暂时的pin页，好在I/O结束后将页释放。但在驱动中，在某些情况下有可能访问
+尾页的page_struct（如检查page->mapping字段），这时应该转而检查首页。一旦首页或者
+尾页被引用，大页就不能再被拆分了。
+
+.. note::
+   以上限制不是针对GUP API新增，而是为了与在hugetlbfs中保持一致。这样如果驱动
+   能在hugetlbfs中使用GUP，就能够切换到透明大页机制支持的GUP。
+
+优雅fallback
+============
+
+为查页表流程增加大页支持只需添加split_huge_pmd(vma, pmd,
+addr)即可。其中pmd为pmd_offset返回值。要为代码添加透明大页支持很简单，搜索
+"pmd_offset"并将split_huge_pmd添加到所有返回的pmd后面。这短短一行的fallback函数
+很巧妙，为我们省去了额外的适配代码（通常会很长或者很复杂）。
+
+如果你需要在没有页表的情况下处理一个大页，可以使用split_huge_page(page)把它拆分
+成小页。linux VM就是通过这种方式将大页换出。如果页面被pin住了，split_huge_page
+就会失败。
+
+例子：添加一行代码使mremap.c支持透明大页::
+
+        diff --git a/mm/mremap.c b/mm/mremap.c
+        --- a/mm/mremap.c
+        +++ b/mm/mremap.c
+        @@ -41,6 +41,7 @@ static pmd_t *get_old_pmd(struct mm_stru
+                return NULL;
+
+                pmd = pmd_offset(pud, addr);
+        +       split_huge_pmd(vma, pmd, addr);
+                if (pmd_none_or_clear_bad(pmd))
+                    return NULL;
+
+大页支持中的锁使用
+==================
+
+我们希望尽可能多的代码能原生支持透明大页，因为调用split_huge_page()和
+split_huge_pmd()还是有开销的。
+
+要让查页表操作变得能处理huge pmd，只需对pmd_offset返回的pmd调用
+pmd_trans_huge()。一定要持有mmap_lock读锁，以避免khugepaged在此期间申请新的
+大页pmd（khugepaged collapse_huge_page会持有mmap_lock写锁而非anon_vma lock）。
+如果pmd_trans_huge返回false，那就回到原来的流程。如果pmd_trans_huge返回true，
+就需要先持有页表锁(pmd_lock())，然后再调一次pmd_trans_huge. 持页表锁是为了防止
+大页pmd被转换成小页（split_huge_pmd可以跟查页表操作同时进行）。如果第二次
+pmd_trans_huge返回false,那就释放页表锁，依然回到原有流程。如果返回true，就可以
+继续处理huge pmd和hugepage了。处理完毕，再释放页表锁。
+
+引用计数和透明大页
+==================
+
+THP的计数跟其他复合页的计数大致相同：
+
+ - get_page()/put_page()和GUP都在首页上进行计数（修改head page->_refcount）
+
+ - 尾页的_refcount永远是0. get_page_unless_zero()永远无法get到尾页。
+
+ - map/unmap特定PTE entry时，增减的是复合页中相应子页的_mapcount.
+
+ - map/unmap整个复合页时，增减的是compound_mapcount属性。该属性保存在第一个
+   尾页中。对于文件中的大页，还要增加所有子页中的_mapcount，这样是为了在检测
+   子页的解映射时不需考虑竞争问题。
+
+PageDoubleMap() 表明大页 *可能* 被映射为了PTE.
+
+对匿名页，PageDoubleMap()也表示所有子页的_mapcount都偏移了1.
+在页被同时映射为了PMD和PTE的情况下，这个额外的引用可以避免子页解映射时的竞争。
+
+这个优化也可以追踪每个子页mapcount所带来的性能开销。另一种解决方法是在每次
+map/unmap整个复合页时更改所有子页的_mapcount.
+
+对于匿名页，如果页面的PMD在首次被拆分时同时还具有PMD映射，则设置PG_double_map;
+当compound_mapcount值降为0时，取消设置。
+
+对于映射到文件的页，在其首次映射PTE时，设置PG_double_map; 在页面从页缓存
+page cache中移除时，取消设置。
+
+split_huge_page中，在清除page struct中所有PG_head/tail位之前，需要先将首页中的
+引用计数refcount分发到所有其他尾页中。页表项PTE占用的引用计数很好处理，但剩下的
+引用计数来源难以确定（如通过get_user_pages的pin页）。如果大页被pin住，
+split_huge_page()会失败。页的引用计数必须等于所有子页mapcount之和再加一（因为
+split_huge_page的调用者也必须对首页持有一个引用）。
+
+对匿名页，split_huge_page用页表项迁移（migration
+entries）保持来page->_refcount和page->_mapcount稳定。对文件页，直接解映射就好。
+
+这套机制对物理内存扫描（physical memory scanners）也安全，scanner唯一合法引用页
+的途径就是get_page_unless_zero().
+
+没调atomic_add()时，所有尾页的_refcount都为0. 这时scanner无法获取尾页的引用。
+调了atomic_add()后，我们也不在乎页的_refcount是多少了。只要知道应该从首页的引用
+计数减去多少即可。
+
+对首页进行get_page_unless_zero()是可以成功的。此时引用计数的再分配非常明了：
+引用计数将会留在首页中。
+
+split_huge_pmd()对引用计数没有任何限制，在任何时候都可以拆分PMD，而且永远不会
+失败。
+
+局部unmap和deferred_split_huge_page()函数
+==========================================
+
+透明大页通过munmap()或其他方式解映射时，并不会立即释放内存。在page_remove_rmap()
+中检查透明大页的某个子页是否已经还在使用，并将透明大页加入一个预备队列，当内存
+使用需求变大时，把透明大页拆分，释放已经不用的子页。
+
+如果检测到局部unmap，由于处在锁中，无法拆页。而且在很多情况下，透明大页会跨VMA,
+这时会在exit(2)中进行局部unmap，这时拆页效果适得其反。
+
+deferred_split_huge_page函数就是用来进行上文所说的将页排队以预备后续的拆分。真正
+的拆页操作是通过内存压力导致的shrinker函数来触发。
+
-- 
2.17.1

