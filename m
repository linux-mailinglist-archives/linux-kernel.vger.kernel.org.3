Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00C84FE9F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiDLVaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 17:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiDLVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 17:30:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C1B4DF4F;
        Tue, 12 Apr 2022 14:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2E8B0CE20DC;
        Tue, 12 Apr 2022 21:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402FDC385A5;
        Tue, 12 Apr 2022 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649797437;
        bh=RFYjpKU37uB6UyPKVFSgk9DDLgvf6NL/iC5f833Q9jo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0mZDA2fwf8SsuU+dgEC41/ZqbU0uopfv3UmlUacSZJ/QIO04FrKFGpaBHTON8ogwT
         yAr+JsMnA584S0g8DLG4X6XNsivwjKnAZBNsPlA8izON4EhoMARt1TemjBNjGEQtE1
         Jqy7p+AyNzvxgboTQw1HbRDtUm2FmJlMGuQ070lg=
Date:   Tue, 12 Apr 2022 14:03:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mm <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>
Subject: Re: [next] next-20220412: BUG: Bad page map in process oom_reaper
 pte
Message-Id: <20220412140356.c0b382fe097cbf4fd040afcc@linux-foundation.org>
In-Reply-To: <CA+G9fYusMPEsFXhDd4BEMa0jy-qZxgRTCpxZ8E4gjdrpHdQGOQ@mail.gmail.com>
References: <CA+G9fYusMPEsFXhDd4BEMa0jy-qZxgRTCpxZ8E4gjdrpHdQGOQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Apr 2022 17:56:42 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Linux next-20220412 i386 LTP mm test case caused following kernel crash
> however, test runs to complete successfully.
> 
> ...
>
> [  951.985382] __swap_info_get: Bad swap file entry 6c0373b6
> [  951.986163] BUG: Bad page map in process oom_reaper  pte:06e76c3e
> pmd:0583f067
> [  951.987098] addr:77da7000 vm_flags:00100073 anon_vma:c4e22c40
> mapping:00000000 index:77da7
> [  951.988163] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> [  951.988850] CPU: 2 PID: 36 Comm: oom_reaper Tainted: G        W
>     5.18.0-rc2-next-20220412 #1
> [  951.990034] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  951.991101] Call Trace:
> [  951.991457]  dump_stack_lvl+0x44/0x57
> [  951.991942]  dump_stack+0xd/0x10
> [  951.992371]  print_bad_pte.cold+0x82/0xd9
> [  951.992901]  ? free_swap_and_cache+0x2e/0xe0
> [  951.993475]  unmap_page_range+0x6b5/0x790
> [  951.994005]  __oom_reap_task_mm+0xc0/0x140
> [  951.994539]  ? _raw_spin_lock_irqsave+0x28/0x70
> [  951.995128]  ? trace_preempt_on+0x8/0xe0
> [  951.995645]  oom_reaper+0x28c/0x3d0
> [  951.996103]  ? __kthread_parkme+0x37/0x80
> [  951.996626]  ? trace_preempt_on+0x29/0xe0
> [  951.997205]  ? __kthread_parkme+0x37/0x80
> [  951.997723]  ? nsec_high+0xa0/0xa0
> [  951.998174]  kthread+0xe0/0x110
> [  951.998588]  ? __oom_reap_task_mm+0x140/0x140
> [  951.999154]  ? kthread_complete_and_exit+0x20/0x20
> [  951.999771]  ret_from_fork+0x1c/0x28
> [  952.000258] Disabling lock debugging due to kernel taint
> [  952.000951] __swap_info_get: Bad swap file entry 6c0373b7
> [  952.001779] BUG: Bad page map in process oom_reaper  pte:06e76e3e
> pmd:0583f067
> [  952.002827] addr:77da8000 vm_flags:00100073 anon_vma:c4e22c40
> mapping:00000000 index:77da8
> [  952.004010] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> [  952.004764] CPU: 2 PID: 36 Comm: oom_reaper Tainted: G    B   W
>     5.18.0-rc2-next-20220412 #1
> [  952.006060] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [  952.007248] Call Trace:
> [  952.007611]  dump_stack_lvl+0x44/0x57
> [  952.008142]  dump_stack+0xd/0x10
> [  952.008614]  print_bad_pte.cold+0x82/0xd9
> [  952.009225]  ? free_swap_and_cache+0x2e/0xe0
> [  952.009848]  unmap_page_range+0x6b5/0x790
> [  952.010432]  __oom_reap_task_mm+0xc0/0x140
> [  952.011219]  ? _raw_spin_lock_irqsave+0x28/0x70
> [  952.011863]  ? trace_preempt_on+0x8/0xe0
> [  952.012470]  oom_reaper+0x28c/0x3d0
> [  952.013048]  ? __kthread_parkme+0x37/0x80
> [  952.013628]  ? trace_preempt_on+0x29/0xe0
> [  952.014202]  ? __kthread_parkme+0x37/0x80
> [  952.014774]  ? nsec_high+0xa0/0xa0
> [  952.015265]  kthread+0xe0/0x110
> [  952.015716]  ? __oom_reap_task_mm+0x140/0x140
> [  952.016336]  ? kthread_complete_and_exit+0x20/0x20
> [  952.017035]  ret_from_fork+0x1c/0x28
> [  952.017547] __swap_info_get: Bad swap file entry 6c0373b8
> [  952.018368] BUG: Bad page map in process oom_reaper  pte:06e7703e
> pmd:0583f067
> 
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

I wonder if this could be 859a85ddf90e714092de again.  But the timing
seems wrong.

It seems repeatable.  Is it possible to run a bisection search please?

