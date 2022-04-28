Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD99751369B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbiD1ORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiD1ORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:17:16 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E65EB53CB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651155242; x=1682691242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4OmeIZ6y+f2JRwt4I1DekUCqDfEai6t2MRiaiReNuU=;
  b=ToK9CeE7zntyztH+u2THAsAMEXEdiBuoeewP7yfyvEcTkYJ4UTpfiRUC
   jjhCQe/biTYz5AQQ+EqcnkAlheJ9BSoH9fkgN/2mrEBCt/7zxE/rMzT/T
   v1cXiZvwGgKIob0uYfKk7sYwAs38kfshK/vp1dz/cTkishJhTEQaDyuoJ
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Apr 2022 07:14:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:14:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 07:14:01 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 07:13:59 -0700
Date:   Thu, 28 Apr 2022 10:13:56 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     <andrey.konovalov@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Peter Collingbourne" <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
Message-ID: <20220428141356.GB71@qian>
References: <cover.1643047180.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1643047180.git.andreyknvl@google.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 07:02:08PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Hi,
> 
> This patchset adds vmalloc tagging support for SW_TAGS and HW_TAGS
> KASAN modes.
> 
> The tree with patches is available here:
> 
> https://github.com/xairy/linux/tree/up-kasan-vmalloc-tags-v6
> 
> About half of patches are cleanups I went for along the way. None of
> them seem to be important enough to go through stable, so I decided
> not to split them out into separate patches/series.
> 
> The patchset is partially based on an early version of the HW_TAGS
> patchset by Vincenzo that had vmalloc support. Thus, I added a
> Co-developed-by tag into a few patches.
> 
> SW_TAGS vmalloc tagging support is straightforward. It reuses all of
> the generic KASAN machinery, but uses shadow memory to store tags
> instead of magic values. Naturally, vmalloc tagging requires adding
> a few kasan_reset_tag() annotations to the vmalloc code.
> 
> HW_TAGS vmalloc tagging support stands out. HW_TAGS KASAN is based on
> Arm MTE, which can only assigns tags to physical memory. As a result,
> HW_TAGS KASAN only tags vmalloc() allocations, which are backed by
> page_alloc memory. It ignores vmap() and others.

I could use some help here. Ever since this series, our system starts to
trigger bad page state bugs from time to time. Any thoughts?

 BUG: Bad page state in process systemd-udevd  pfn:83ffffcd
 page:fffffc20fdfff340 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x83ffffcd
 flags: 0xbfffc0000001000(reserved|node=0|zone=2|lastcpupid=0xffff)
 raw: 0bfffc0000001000 fffffc20fdfff348 fffffc20fdfff348 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
 page_owner info is not present (never set?)
 CPU: 76 PID: 1873 Comm: systemd-udevd Not tainted 5.18.0-rc4-next-20220428-dirty #67
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  bad_page
  free_pcp_prepare
  free_unref_page
  __free_pages
  free_pages.part.0
  free_pages
  kasan_depopulate_vmalloc_pte
  (inlined by) kasan_depopulate_vmalloc_pte at mm/kasan/shadow.c:361
  apply_to_pte_range
  apply_to_pmd_range
  apply_to_pud_range
  __apply_to_page_range
  apply_to_existing_page_range
  kasan_release_vmalloc
  (inlined by) kasan_release_vmalloc at mm/kasan/shadow.c:469
  __purge_vmap_area_lazy
  purge_vmap_area_lazy
  alloc_vmap_area
  __get_vm_area_node.constprop.0
  __vmalloc_node_range
  module_alloc
  move_module
  layout_and_allocate
  load_module
  __do_sys_finit_module
  __arm64_sys_finit_module
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 Disabling lock debugging due to kernel taint
 BUG: Bad page state in process systemd-udevd  pfn:83ffffcc
 page:fffffc20fdfff300 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x83ffffcc
 flags: 0xbfffc0000001000(reserved|node=0|zone=2|lastcpupid=0xffff)
 raw: 0bfffc0000001000 fffffc20fdfff308 fffffc20fdfff308 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
 page_owner info is not present (never set?)
 CPU: 76 PID: 1873 Comm: systemd-udevd Tainted: G    B             5.18.0-rc4-next-20220428-dirty #67
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  bad_page
  free_pcp_prepare
  free_unref_page
  __free_pages
  free_pages.part.0
  free_pages
  kasan_depopulate_vmalloc_pte
  apply_to_pte_range
  apply_to_pmd_range
  apply_to_pud_range
  __apply_to_page_range
  apply_to_existing_page_range
  kasan_release_vmalloc
  __purge_vmap_area_lazy
  purge_vmap_area_lazy
  alloc_vmap_area
  __get_vm_area_node.constprop.0
  __vmalloc_node_range
  module_alloc
  move_module
  layout_and_allocate
  load_module
  __do_sys_finit_module
  __arm64_sys_finit_module
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
