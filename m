Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1E44669C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376598AbhLBSX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:23:26 -0500
Received: from foss.arm.com ([217.140.110.172]:39040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344073AbhLBSXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:23:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0AF31435;
        Thu,  2 Dec 2021 10:20:01 -0800 (PST)
Received: from arm.com (arrakis.cambridge.arm.com [10.1.196.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353A23F766;
        Thu,  2 Dec 2021 10:20:00 -0800 (PST)
Date:   Thu, 2 Dec 2021 18:19:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, nicholas.tang@mediatek.com,
        james.hsu@mediatek.com, yee.lee@mediatek.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] kmemleak: fix kmemleak false positive report with HW
 tag-based kasan enable
Message-ID: <YakOGLo0GwSdd7aZ@arm.com>
References: <20211118054426.4123-1-Kuan-Ying.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118054426.4123-1-Kuan-Ying.Lee@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:44:19PM +0800, Kuan-Ying Lee wrote:
> With HW tag-based kasan enable, We will get the warning
> when we free object whose address starts with 0xFF.
> 
> It is because kmemleak rbtree stores tagged object and
> this freeing object's tag does not match with rbtree object.
> 
> In the example below, kmemleak rbtree stores the tagged object in
> the kmalloc(), and kfree() gets the pointer with 0xFF tag.
> 
> Call sequence:
> ptr = kmalloc(size, GFP_KERNEL);
> page = virt_to_page(ptr);
> kfree(page_address(page));
> ptr = kmalloc(size, GFP_KERNEL);
> 
> Call sequence like that may cause the warning as following:
> 1) Freeing unknown object:
> In kfree(), we will get free unknown object warning in kmemleak_free().
> Because object(0xFx) in kmemleak rbtree and pointer(0xFF) in kfree() have
> different tag.
> 
> 2) Overlap existing:
> When we allocate that object with the same hw-tag again, we will
> find the overlap in the kmemleak rbtree and kmemleak thread will
> be killed.
> 
> [  116.685312] kmemleak: Freeing unknown object at 0xffff000003f88000
> [  116.686422] CPU: 5 PID: 177 Comm: cat Not tainted 5.16.0-rc1-dirty #21
> [  116.687067] Hardware name: linux,dummy-virt (DT)
> [  116.687496] Call trace:
> [  116.687792]  dump_backtrace+0x0/0x1ac
> [  116.688255]  show_stack+0x1c/0x30
> [  116.688663]  dump_stack_lvl+0x68/0x84
> [  116.689096]  dump_stack+0x1c/0x38
> [  116.689499]  kmemleak_free+0x6c/0x70
> [  116.689919]  slab_free_freelist_hook+0x104/0x200
> [  116.690420]  kmem_cache_free+0xa8/0x3d4
> [  116.690845]  test_version_show+0x270/0x3a0
> [  116.691344]  module_attr_show+0x28/0x40
> [  116.691789]  sysfs_kf_seq_show+0xb0/0x130
> [  116.692245]  kernfs_seq_show+0x30/0x40
> [  116.692678]  seq_read_iter+0x1bc/0x4b0
> [  116.692678]  seq_read_iter+0x1bc/0x4b0
> [  116.693114]  kernfs_fop_read_iter+0x144/0x1c0
> [  116.693586]  generic_file_splice_read+0xd0/0x184
> [  116.694078]  do_splice_to+0x90/0xe0
> [  116.694498]  splice_direct_to_actor+0xb8/0x250
> [  116.694975]  do_splice_direct+0x88/0xd4
> [  116.695409]  do_sendfile+0x2b0/0x344
> [  116.695829]  __arm64_sys_sendfile64+0x164/0x16c
> [  116.696306]  invoke_syscall+0x48/0x114
> [  116.696735]  el0_svc_common.constprop.0+0x44/0xec
> [  116.697263]  do_el0_svc+0x74/0x90
> [  116.697665]  el0_svc+0x20/0x80
> [  116.698261]  el0t_64_sync_handler+0x1a8/0x1b0
> [  116.698695]  el0t_64_sync+0x1ac/0x1b0
> ...
> [  117.520301] kmemleak: Cannot insert 0xf2ff000003f88000 into the object search tree (overlaps existing)
> [  117.521118] CPU: 5 PID: 178 Comm: cat Not tainted 5.16.0-rc1-dirty #21
> [  117.521827] Hardware name: linux,dummy-virt (DT)
> [  117.522287] Call trace:
> [  117.522586]  dump_backtrace+0x0/0x1ac
> [  117.523053]  show_stack+0x1c/0x30
> [  117.523578]  dump_stack_lvl+0x68/0x84
> [  117.524039]  dump_stack+0x1c/0x38
> [  117.524472]  create_object.isra.0+0x2d8/0x2fc
> [  117.524975]  kmemleak_alloc+0x34/0x40
> [  117.525416]  kmem_cache_alloc+0x23c/0x2f0
> [  117.525914]  test_version_show+0x1fc/0x3a0
> [  117.526379]  module_attr_show+0x28/0x40
> [  117.526827]  sysfs_kf_seq_show+0xb0/0x130
> [  117.527363]  kernfs_seq_show+0x30/0x40
> [  117.527848]  seq_read_iter+0x1bc/0x4b0
> [  117.528320]  kernfs_fop_read_iter+0x144/0x1c0
> [  117.528809]  generic_file_splice_read+0xd0/0x184
> [  117.529316]  do_splice_to+0x90/0xe0
> [  117.529734]  splice_direct_to_actor+0xb8/0x250
> [  117.530227]  do_splice_direct+0x88/0xd4
> [  117.530686]  do_sendfile+0x2b0/0x344
> [  117.531154]  __arm64_sys_sendfile64+0x164/0x16c
> [  117.531673]  invoke_syscall+0x48/0x114
> [  117.532111]  el0_svc_common.constprop.0+0x44/0xec
> [  117.532621]  do_el0_svc+0x74/0x90
> [  117.533048]  el0_svc+0x20/0x80
> [  117.533461]  el0t_64_sync_handler+0x1a8/0x1b0
> [  117.533950]  el0t_64_sync+0x1ac/0x1b0
> [  117.534625] kmemleak: Kernel memory leak detector disabled
> [  117.535201] kmemleak: Object 0xf2ff000003f88000 (size 128):
> [  117.535761] kmemleak:   comm "cat", pid 177, jiffies 4294921177
> [  117.536339] kmemleak:   min_count = 1
> [  117.536718] kmemleak:   count = 0
> [  117.537068] kmemleak:   flags = 0x1
> [  117.537429] kmemleak:   checksum = 0
> [  117.537806] kmemleak:   backtrace:
> [  117.538211]      kmem_cache_alloc+0x23c/0x2f0
> [  117.538924]      test_version_show+0x1fc/0x3a0
> [  117.539393]      module_attr_show+0x28/0x40
> [  117.539844]      sysfs_kf_seq_show+0xb0/0x130
> [  117.540304]      kernfs_seq_show+0x30/0x40
> [  117.540750]      seq_read_iter+0x1bc/0x4b0
> [  117.541206]      kernfs_fop_read_iter+0x144/0x1c0
> [  117.541687]      generic_file_splice_read+0xd0/0x184
> [  117.542182]      do_splice_to+0x90/0xe0
> [  117.542611]      splice_direct_to_actor+0xb8/0x250
> [  117.543097]      do_splice_direct+0x88/0xd4
> [  117.543544]      do_sendfile+0x2b0/0x344
> [  117.543983]      __arm64_sys_sendfile64+0x164/0x16c
> [  117.544471]      invoke_syscall+0x48/0x114
> [  117.544917]      el0_svc_common.constprop.0+0x44/0xec
> [  117.545416]      do_el0_svc+0x74/0x90
> [  117.554100] kmemleak: Automatic memory scanning thread ended
> 
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

I was wondering whether we should just give up the tag when storing the
object->pointer and avoid any later untagging when searching the rb
tree. But, if we want to keep that for debugging, fine by me as well.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
