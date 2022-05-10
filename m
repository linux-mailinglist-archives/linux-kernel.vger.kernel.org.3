Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94695221F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiEJRMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbiEJRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:12:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4228ED29
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:08:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D2761898
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 17:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE55C385C2;
        Tue, 10 May 2022 17:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652202521;
        bh=JW5+/lrjtsbvazZDjt9voA+Y/DEDFq/SqAnWIuUwXys=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EeDrrq0xv6A4Pu3pY9lxl38sgB9IqaIEh335jodk/67xwkvtUxluLDq+JesiU/S+K
         2HhDhlYX5fEII/ZIIFceCnUor6YQsUokCMG1EXYY1IcJpW3g7PfZ55/hC/RCh/QGOR
         jaAw0G+c4pdLmTOaijisvxJDe6+pKUcfFyGFFmGM=
Date:   Tue, 10 May 2022 10:08:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [akpm-mm:mm-unstable 338/431] mm/nommu.c:579:2: error: call to
 undeclared function 'vma_mas_store'; ISO C99 and later do not support
 implicit function declarations
Message-Id: <20220510100840.2914b21473ac5fe774a5d44a@linux-foundation.org>
In-Reply-To: <202205102024.jnJMagOr-lkp@intel.com>
References: <202205102024.jnJMagOr-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 20:52:04 +0800 kernel test robot <lkp@intel.com> wrote:

> >> mm/nommu.c:579:2: error: call to undeclared function 'vma_mas_store'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            vma_mas_store(vma, &mas);

Thanks.

I queued the below temp fix for now.   Hopefully it makes sense for nommu.



From: Andrew Morton <akpm@linux-foundation.org>
Subject: mapletree: build fix

Fix the vma_mas_store/vma_mas_remove issues.  Missing prototypes, missing
implementation on nommu.

Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/mm.h |    3 +++
 mm/mmap.c          |    4 ++--
 mm/nommu.c         |   13 +++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

--- a/mm/nommu.c~mapletree-build-fix
+++ a/mm/nommu.c
@@ -544,6 +544,19 @@ static void put_nommu_region(struct vm_r
 	__put_nommu_region(region);
 }
 
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(mas, vma);
+}
+
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas->index = vma->vm_start;
+	mas->last = vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
 /*
  * add a VMA into a process's mm_struct in the appropriate place in the list
  * and tree and add to the address space's page tree also if not an anonymous
--- a/mm/mmap.c~mapletree-build-fix
+++ a/mm/mmap.c
@@ -475,7 +475,7 @@ static void __vma_link_file(struct vm_ar
  *
  * Note: the end address is inclusive in the maple tree.
  */
-inline void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
 {
 	trace_vma_store(mas->tree, vma);
 	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
@@ -491,7 +491,7 @@ inline void vma_mas_store(struct vm_area
  * been established and points to the correct location.
  * Note: the end address is inclusive in the maple tree.
  */
-static inline void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
 {
 	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
 	mas->index = vma->vm_start;
--- a/include/linux/mm.h~mapletree-build-fix
+++ a/include/linux/mm.h
@@ -2669,6 +2669,9 @@ extern struct vm_area_struct *copy_vma(s
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
 
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
+
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
_

