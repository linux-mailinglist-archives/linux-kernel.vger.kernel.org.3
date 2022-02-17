Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4368D4BA9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbiBQTY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:24:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245120AbiBQTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:24:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2223F94D9;
        Thu, 17 Feb 2022 11:24:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D9C161CC7;
        Thu, 17 Feb 2022 19:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D5AC340E8;
        Thu, 17 Feb 2022 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645125879;
        bh=r0FFFkQf0v+Vq0994D2RUjxFXog+gDvbX6KefPHK3dM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ny4nH9oRvZxO4sdirwRFEzdQyb+FedPG/TtZtia5tof0ulcZG7V7kVFVztg3KsQhn
         q6nHNP8tHb3ERbAlhvHyR6BmIiOOUqU/RG1+TmbfXFnUyyDwpXnL5HrLjtUQtj+fbM
         DPF5vGQUJsUFOvURAG2AgHzFd/yU8JGjnyQcD/qDxo3aw4aS0CPSmg8+KpgO4VeRwT
         j81K1m0ilN1jHDGdUxp2ldSzyXp4BNJvOx4gLD8b0HETBykTK0b7FknOxuMiWocTIH
         V/PsUIFUOMcKy7/YItFJ79f2PsGduZJk12mFQcKJmlYFSVk5p/ZnH0RYb8QjCLhcG+
         uIdAs2bRZYfzA==
Date:   Thu, 17 Feb 2022 19:24:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the maple tree
Message-ID: <20220217192434.GA11800@willie-the-truck>
References: <20220217191857.6d9917c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217191857.6d9917c2@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 07:18:57PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the maple tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_phdrs':
> arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member named 'mmap'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                   ^~
> arch/arm64/kernel/elfcore.c:69:9: note: in expansion of macro 'for_each_mte_vma'
>    69 |         for_each_mte_vma(current, vma)
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no member named 'vm_next'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                                         ^~
> arch/arm64/kernel/elfcore.c:69:9: note: in expansion of macro 'for_each_mte_vma'
>    69 |         for_each_mte_vma(current, vma)
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_phdrs':
> arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member named 'mmap'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                   ^~
> arch/arm64/kernel/elfcore.c:79:9: note: in expansion of macro 'for_each_mte_vma'
>    79 |         for_each_mte_vma(current, vma) {
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no member named 'vm_next'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                                         ^~
> arch/arm64/kernel/elfcore.c:79:9: note: in expansion of macro 'for_each_mte_vma'
>    79 |         for_each_mte_vma(current, vma) {
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_data_size':
> arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member named 'mmap'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                   ^~
> arch/arm64/kernel/elfcore.c:104:9: note: in expansion of macro 'for_each_mte_vma'
>   104 |         for_each_mte_vma(current, vma)
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no member named 'vm_next'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                                         ^~
> arch/arm64/kernel/elfcore.c:104:9: note: in expansion of macro 'for_each_mte_vma'
>   104 |         for_each_mte_vma(current, vma)
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_data':
> arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member named 'mmap'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                   ^~
> arch/arm64/kernel/elfcore.c:114:9: note: in expansion of macro 'for_each_mte_vma'
>   114 |         for_each_mte_vma(current, vma) {
>       |         ^~~~~~~~~~~~~~~~
> arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no member named 'vm_next'
>    13 |                 for (vma = tsk->mm->mmap; vma; vma = vma->vm_next)      \
>       |                                                         ^~
> arch/arm64/kernel/elfcore.c:114:9: note: in expansion of macro 'for_each_mte_vma'
>   114 |         for_each_mte_vma(current, vma) {
>       |         ^~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   b09e8361a4c3 ("mm: Remove the vma linked list")
> 
> interacting with commit
> 
>   6dd8b1a0b6cb ("arm64: mte: Dump the MTE tags in the core file")
> 
> from the arm64 tree.

Yikes, this is quite a mess. Liam -- how would you like to resolve this?

Will
