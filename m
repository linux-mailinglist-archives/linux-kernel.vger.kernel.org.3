Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81951533B97
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 13:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiEYLSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 07:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiEYLSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 07:18:00 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8A66FA1D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1653477478;
  x=1685013478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/o4LP8ko0WJUyW9IItPnIXW6I9eQMh03kw30Jeb8Yro=;
  b=eGl2KcbhRUuslIob5EHiTg8e0X34FU4gw5m43gcr4FjtcNgASWuwbgOQ
   bJMfF6Z3ijPNp2bBlr9ghJgbdKTGRjs6XC7GeYiOZpbqCGDX4nrzWGlwK
   mMXgeYAJKgXCGVp1rKSeHvL8sZXtBxGoQGqsEd7l7BWj6/T8DlTcki7K4
   2YGFhDa+5SG9JmVkm3JeJM5tFHqRjIJO4YHORdt0xNVuLc9pl/aY3PEDa
   yYWFts9EUpF9+rJxQ7FekiNlZgOWEnGXKiVpzTPpCoCGtFQUeNSsLO4op
   LeUjuKRpXVCFlccJn6NPneMH/6MgmnoVmsj9MSmNv+54RBSOZYXPENSO6
   g==;
Date:   Wed, 25 May 2022 13:17:56 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     David Gow <davidgow@google.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
Message-ID: <20220525111756.GA15955@axis.com>
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <CAKFsvULGSQRx3hL8HgbYbEt_8GOorZj96CoMVhx6sw=xWEwSwA@mail.gmail.com>
 <1fb57ec2a830deba664379f3e0f480e08e6dec2f.camel@sipsolutions.net>
 <20220524103423.GA13239@axis.com>
 <CABVgOSnTX_e+tzR6c3KnGhDidVtEoUdtt_CJ62g2+MQDMp657g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABVgOSnTX_e+tzR6c3KnGhDidVtEoUdtt_CJ62g2+MQDMp657g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 09:35:33PM +0200, David Gow wrote:
> On Tue, May 24, 2022 at 3:34 AM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> > It works both with and without KASAN_VMALLOC.  KASAN_STACK works too
> > after I disabled sanitization of the stacktrace code.  All kasan kunit
> > tests pass and the test_kasan.ko module works too.
> 
> I've got this running myself, and can confirm the kasan tests work
> under kunit_tool in most cases, though there are a couple of failures
> when built with clang/llvm:
> [11:56:30] # kasan_global_oob_right: EXPECTATION FAILED at lib/test_kasan.c:732
> [11:56:30] KASAN failure expected in "*(volatile char *)p", but none occurred
> [11:56:30] not ok 32 - kasan_global_oob_right
> [11:56:30] [FAILED] kasan_global_oob_right
> [11:56:30] # kasan_global_oob_left: EXPECTATION FAILED at lib/test_kasan.c:746
> [11:56:30] KASAN failure expected in "*(volatile char *)p", but none occurred
> [11:56:30] not ok 33 - kasan_global_oob_left
> [11:56:30] [FAILED] kasan_global_oob_left
> 
> The global_oob_left test doesn't work on gcc either (but fails on all
> architectures, so is disabled), but kasan_global_oob_right should work
> in theory.

kasan_global_oob_right works for me with GCC, but it looks like
__asan_register_globals() never gets called when built with clang.  This
fixes it:

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index 731f8c8422a2..fd481ac371de 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -84,6 +84,7 @@
   .init_array : {
 	__init_array_start = .;
 	*(.kasan_init)
+	*(.init_array.*)
 	*(.init_array)
 	__init_array_end = .;
   }

With that:

[13:12:15] =================== kasan (55 subtests) ====================
[13:12:15] [PASSED] kmalloc_oob_right
[13:12:15] [PASSED] kmalloc_oob_left
[13:12:15] [PASSED] kmalloc_node_oob_right
[13:12:15] [PASSED] kmalloc_pagealloc_oob_right
[13:12:15] [PASSED] kmalloc_pagealloc_uaf
[13:12:15] [PASSED] kmalloc_pagealloc_invalid_free
[13:12:15] [SKIPPED] pagealloc_oob_right
[13:12:15] [PASSED] pagealloc_uaf
[13:12:15] [PASSED] kmalloc_large_oob_right
[13:12:15] [PASSED] krealloc_more_oob
[13:12:15] [PASSED] krealloc_less_oob
[13:12:15] [PASSED] krealloc_pagealloc_more_oob
[13:12:15] [PASSED] krealloc_pagealloc_less_oob
[13:12:15] [PASSED] krealloc_uaf
[13:12:15] [PASSED] kmalloc_oob_16
[13:12:15] [PASSED] kmalloc_uaf_16
[13:12:15] [PASSED] kmalloc_oob_in_memset
[13:12:15] [PASSED] kmalloc_oob_memset_2
[13:12:15] [PASSED] kmalloc_oob_memset_4
[13:12:15] [PASSED] kmalloc_oob_memset_8
[13:12:15] [PASSED] kmalloc_oob_memset_16
[13:12:15] [PASSED] kmalloc_memmove_negative_size
[13:12:15] [PASSED] kmalloc_memmove_invalid_size
[13:12:15] [PASSED] kmalloc_uaf
[13:12:15] [PASSED] kmalloc_uaf_memset
[13:12:15] [PASSED] kmalloc_uaf2
[13:12:15] [PASSED] kfree_via_page
[13:12:15] [PASSED] kfree_via_phys
[13:12:15] [PASSED] kmem_cache_oob
[13:12:15] [PASSED] kmem_cache_accounted
[13:12:15] [PASSED] kmem_cache_bulk
[13:12:15] [PASSED] kasan_global_oob_right
[13:12:15] [PASSED] kasan_global_oob_left
[13:12:15] [PASSED] kasan_stack_oob
[13:12:15] [PASSED] kasan_alloca_oob_left
[13:12:15] [PASSED] kasan_alloca_oob_right
[13:12:15] [PASSED] ksize_unpoisons_memory
[13:12:15] [PASSED] ksize_uaf
[13:12:15] [PASSED] kmem_cache_double_free
[13:12:15] [PASSED] kmem_cache_invalid_free
[13:12:15] [PASSED] kmem_cache_double_destroy
[13:12:15] [PASSED] kasan_memchr
[13:12:15] [PASSED] kasan_memcmp
[13:12:15] [PASSED] kasan_strings
[13:12:15] [PASSED] kasan_bitops_generic
[13:12:15] [SKIPPED] kasan_bitops_tags
[13:12:15] [PASSED] kmalloc_double_kzfree
[13:12:15] [SKIPPED] vmalloc_helpers_tags
[13:12:15] [PASSED] vmalloc_oob
[13:12:15] [SKIPPED] vmap_tags
[13:12:15] [SKIPPED] vm_map_ram_tags
[13:12:15] [SKIPPED] vmalloc_percpu
[13:12:15] [SKIPPED] match_all_not_assigned
[13:12:15] [SKIPPED] match_all_ptr_tag
[13:12:15] [SKIPPED] match_all_mem_tag
[13:12:15] ====================== [PASSED] kasan ======================
[13:12:15] ============================================================
[13:12:15] Testing complete. Passed: 46, Failed: 0, Crashed: 0, Skipped: 9, Errors: 0

> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index a4f07de21771..d8c518bd0e7d 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -295,8 +295,14 @@ int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
> >                 return 0;
> >
> >         shadow_start = (unsigned long)kasan_mem_to_shadow((void *)addr);
> > -       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> >         shadow_end = (unsigned long)kasan_mem_to_shadow((void *)addr + size);
> > +
> > +       if (IS_ENABLED(CONFIG_UML)) {
> > +               __memset(kasan_mem_to_shadow((void *)addr), KASAN_VMALLOC_INVALID, shadow_end - shadow_start);
> > +               return 0;
> > +       }
> > +
> > +       shadow_start = ALIGN_DOWN(shadow_start, PAGE_SIZE);
> >         shadow_end = ALIGN(shadow_end, PAGE_SIZE);
> 
> Is there a particular reason we're not doing the rounding under UML,
> particularly since I think it's happening anyway in
> kasan_release_vmalloc() below. (I get that it's not really necessary,
> but is there an actual bug you've noticed with it?)

No, I didn't notice any bug.

> >         ret = apply_to_page_range(&init_mm, shadow_start,
> > @@ -466,6 +472,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
> >
> >         if (shadow_end > shadow_start) {
> >                 size = shadow_end - shadow_start;
> > +               if (IS_ENABLED(CONFIG_UML)) {
> > +                       __memset(shadow_start, KASAN_SHADOW_INIT, shadow_end - shadow_start);
> > +                       return;
> > +               }
> >                 apply_to_existing_page_range(&init_mm,
> >                                              (unsigned long)shadow_start,
> >                                              size, kasan_depopulate_vmalloc_pte,
> > @@ -531,6 +541,11 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
> >         if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> >                 return -EINVAL;
> >
> > +       if (IS_ENABLED(CONFIG_UML)) {
> > +               __memset((void *)shadow_start, KASAN_SHADOW_INIT, shadow_size);
> > +               return 0;
> > +       }
> > +
> >         ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
> >                         shadow_start + shadow_size,
> >                         GFP_KERNEL,
> > @@ -554,6 +569,9 @@ int kasan_alloc_module_shadow(void *addr, size_t size, gfp_t gfp_mask)
> >
> >  void kasan_free_module_shadow(const struct vm_struct *vm)
> >  {
> > +       if (IS_ENABLED(CONFIG_UML))
> > +               return;
> > +
> >         if (vm->flags & VM_KASAN)
> >                 vfree(kasan_mem_to_shadow(vm->addr));
> >  }
> 
> In any case, this looks pretty great to me. I still definitely want to
> play with it a bit more, particularly with various module loads -- and
> it'd be great to track down why those global_oob tests are failing --
> but I'm definitely hopeful that we can finish this off and get it
> upstream.
> 
> It's probably worth sending a new rebased/combined patch out which has
> your fixes and applies more cleanly on recent kernels. (I've got a
> working tree here, so I can do that if you'd prefer.)

Please feel free to do so.  Thanks!
