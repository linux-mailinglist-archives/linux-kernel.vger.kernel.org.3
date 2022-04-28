Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5703F513974
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349806AbiD1QQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349603AbiD1QQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:16:20 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71813D3E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651162381; x=1682698381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FrfyPGyrRql3+c1AJp/BIgQHA9i1fgkYU3oOQT+9KWw=;
  b=XQayxy73JjwEUoreQ9TJ2Fs6djX5nEbPSZf4LU0pZ/RERDMy6VUSAm6B
   kZq3jI1GPuCrK8DaY7vJd6WfrylnYs0WDydbgM7qsQhfpUr5aGDc+He/g
   qptMnA8Qdc0Q9enyUaqFcior31198nQfvMi0XcFv7363u/VJrXAoeinAc
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 09:13:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:13:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 09:13:00 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 09:12:57 -0700
Date:   Thu, 28 Apr 2022 12:12:54 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     <andrey.konovalov@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 00/39] kasan, vmalloc, arm64: add vmalloc tagging
 support for SW/HW_TAGS
Message-ID: <20220428161254.GA182@qian>
References: <cover.1643047180.git.andreyknvl@google.com>
 <20220428141356.GB71@qian>
 <CA+fCnZesRG_WLi2fEHtG=oNLt2oJ7RrZuwuCm_rQDPZLoZr-3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+fCnZesRG_WLi2fEHtG=oNLt2oJ7RrZuwuCm_rQDPZLoZr-3g@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:28:12PM +0200, Andrey Konovalov wrote:
> No ideas so far.
> 
> Looks like the page has reserved tag set when it's being freed.
> 
> Does this crash only happen with the SW_TAGS mode?

No, the system is running exclusively with CONFIG_KASAN_GENERIC=y

> Does this crash only happen when loading modules?

Yes. Here is another sligtly different path at the bottom.

> Does your system have any hot-plugged memory?

No.

 BUG: Bad page state in process systemd-udevd  pfn:403fc007c
 page:fffffd00fd001f00 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x403fc007c
 flags: 0x1bfffc0000001000(reserved|node=1|zone=2|lastcpupid=0xffff)
 raw: 1bfffc0000001000 fffffd00fd001f08 fffffd00fd001f08 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
 CPU: 101 PID: 2004 Comm: systemd-udevd Not tainted 5.17.0-rc8-next-20220317-dirty #39
 Call trace:
  dump_backtrace
  show_stack
  dump_stack_lvl
  dump_stack
  bad_page
  free_pcp_prepare
  free_pages_prepare at mm/page_alloc.c:1348
  (inlined by) free_pcp_prepare at mm/page_alloc.c:1403
  free_unref_page
  __free_pages
  free_pages.part.0
  free_pages
  kasan_depopulate_vmalloc_pte
  (inlined by) kasan_depopulate_vmalloc_pte at mm/kasan/shadow.c:359
  apply_to_pte_range
  apply_to_pte_range at mm/memory.c:2547
  apply_to_pmd_range
  apply_to_pud_range
  __apply_to_page_range
  apply_to_existing_page_range
  kasan_release_vmalloc
  (inlined by) kasan_release_vmalloc at mm/kasan/shadow.c:469
  __purge_vmap_area_lazy
  _vm_unmap_aliases.part.0
  __vunmap
  __vfree
  vfree
  module_memfree
  free_module
  do_init_module
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
 BUG: Bad page state in process systemd-udevd  pfn:403fc007b
 page:fffffd00fd001ec0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x403fc007b
 flags: 0x1bfffc0000001000(reserved|node=1|zone=2|lastcpupid=0xffff)
 raw: 1bfffc0000001000 fffffd00fd001ec8 fffffd00fd001ec8 0000000000000000
 raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
 CPU: 101 PID: 2004 Comm: systemd-udevd Tainted: G    B             5.17.0-rc8-next-20220317-dirty #39
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
  _vm_unmap_aliases.part.0
  __vunmap
  __vfree
  vfree
  module_memfree
  free_module
  do_init_module
  load_module
  __do_sys_finit_module
  __arm64_sys_finit_module
  invoke_syscall
  el0_svc_common.constprop.0
  do_el0_svc
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
