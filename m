Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E2558556
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiFWR4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiFWRws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:52:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118956776
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 135C9B82489
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 17:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451B1C341C8;
        Thu, 23 Jun 2022 17:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656004413;
        bh=H9XDdoABPSpvLcbeZb6mrxq8vL7qtowAVPQVxrIBCh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LddGc6vdrk8EgF6Z4hnLIdZwz699aX1/xvWQ0jdTMOyMcerBIMcJRmXrjXOiQ+2M3
         i/6hCrDYIpxTCbiGyHA5kXvrVbJZBW+83+tTY+TLw3ruGq+d6xthR4k3mIsnCmdhuI
         rMwYwpUQw7S42bYg88j0+naQ8aKNnfVm51nd7yXwlwHq+01IgqtNeBL/VyEWOgIGKB
         6VXMahkdQdyTzFHYHXzV050pv6Evvsa/Xwv0KUgRN/f+qLB7QO6nGEB01sCW5Hi5Pw
         5OpRGqtrJ1P1p8PXOc0sk1w+AwEkimSl3mGL7g15Q5RMMPlDmQLl3BriNp9A1twMHM
         2pSiDazAborBg==
Date:   Thu, 23 Jun 2022 12:13:30 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64e: Rewrite p4d_populate() as a static inline
 function
Message-ID: <YrSfOp5B+LhFXgjt@kernel.org>
References: <1b416f8a8fe1bc3f4e01175680ce310b7eb3a1e4.1655974565.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b416f8a8fe1bc3f4e01175680ce310b7eb3a1e4.1655974565.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 10:56:57AM +0200, Christophe Leroy wrote:
> Rewrite p4d_populate() as a static inline function instead of
> a macro.
> 
> This change allows typechecking and would have helped detecting
> a recently found bug in map_kernel_page().
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/powerpc/include/asm/nohash/64/pgalloc.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> index 668aee6017e7..e50b211becb3 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
> @@ -15,7 +15,10 @@ struct vmemmap_backing {
>  };
>  extern struct vmemmap_backing *vmemmap_list;
>  
> -#define p4d_populate(MM, P4D, PUD)	p4d_set(P4D, (unsigned long)PUD)
> +static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, pud_t *pud)
> +{
> +	p4d_set(p4d, (unsigned long)pud);
> +}
>  
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -- 
> 2.36.1
> 

-- 
Sincerely yours,
Mike.
