Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0224F3FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388784AbiDEOlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiDEJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7A3B91A6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:25:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37BD76164E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDBAC385A4;
        Tue,  5 Apr 2022 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150702;
        bh=kogP6nO7wU0ilpGa8JtIr5fN9KE3TnBqzaKz14TEHYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijeYoLORnSLf/AoiqG4azMEprQrMRfuFMpyxCeV8qw1UTVmW8dOxNKVseYbED+vAe
         231KKUQL50gbav6+5GJbGHqonejP5dzlB6OZkwJV2KTcH9z9OQUX8HkylsCFhrb6pP
         nn4c81PFSrWCxQpyGOu4i3SolWFCSmu3aL9SF7rVQInCux5C3pvUgmyS4upGC3vc60
         EEWxKVFp3wo+T3WYgIHw+Mrpoz8EF209VEKQaowwNeLawEXOJ/wDHI52uUkASeHP4N
         vPrXct/qNzUUqv5GpDnlZIdqn7o8IGOr6y5NcRR5CPn/5fBMFZwDp2DQt35NPLaMeb
         AEL2hHqkxmE+g==
Date:   Tue, 5 Apr 2022 10:24:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 11/70] arch/arm64: Remove the merge workaround for
 VMA_ITERATOR
Message-ID: <20220405092456.GA24387@willie-the-truck>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
 <20220404143501.2016403-12-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404143501.2016403-12-Liam.Howlett@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liam,

On Mon, Apr 04, 2022 at 02:35:36PM +0000, Liam Howlett wrote:
> Now that the vma iterator is in the kernel, remove the workaround.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  arch/arm64/kernel/elfcore.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
> index 3ed39c61a510..930a0bc4cac4 100644
> --- a/arch/arm64/kernel/elfcore.c
> +++ b/arch/arm64/kernel/elfcore.c
> @@ -8,13 +8,6 @@
>  #include <asm/cpufeature.h>
>  #include <asm/mte.h>
>  
> -#ifndef VMA_ITERATOR
> -#define VMA_ITERATOR(name, mm, addr)	\
> -	struct mm_struct *name = mm
> -#define for_each_vma(vmi, vma)		\
> -	for (vma = vmi->mmap; vma; vma = vma->vm_next)
> -#endif

I already have this revert queued up as an arm64 fix:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/fixes&id=a0ab7e5bc9651d65637f50ee9c09e083919677ed

Should land for -rc2.

Will
