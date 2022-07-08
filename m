Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95256BAE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiGHNbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiGHNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:31:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E972F019
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 531CEB824C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079C3C341C0;
        Fri,  8 Jul 2022 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657287089;
        bh=hGds4B+mCIAOpm1BnDxnLnmZBHrG70bhYx2KsmmxqIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CetDsqfpap9TpmGYmlt51q4RIDsIk3g8CKBuY71/K8OZVND1iyEzsg2nVcVbb/JFr
         +zJh65zexDNPxKxlEr4mlBWIObet9ygfMwwLxGuIXUKjb37tyM8IaHsOPG3xbLEcM6
         5ht0EdJqaTGydT5JTFa3JPYiAmFYAw+/ai5fSDVt0e9yPK0Cu3D5dCHyhi+B2rDkXL
         yBqJz3ElCgtLYCvigS6h5A16oPHBHWAfxctgTy4Ind+qLoNLkxRCjmRnAHBDfJsf7N
         Jl/rgCToCIZoDmK3TK+TpuxPUXmlYPyMHDMEx9ofe4EKS0vJ1tjDe8aY1qtJjVxR11
         QSHndpPPMTj+A==
Date:   Fri, 8 Jul 2022 14:31:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4] csky/tlb: Remove tlb_flush() define
Message-ID: <20220708133122.GC5989@willie-the-truck>
References: <20220708071802.751003711@infradead.org>
 <20220708071834.019084831@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708071834.019084831@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:18:04AM +0200, Peter Zijlstra wrote:
> The previous patch removed the tlb_flush_end() implementation which
> used tlb_flush_range(). This means:
> 
>  - csky did double invalidates, a range invalidate per vma and a full
>    invalidate at the end
> 
>  - csky actually has range invalidates and as such the generic
>    tlb_flush implementation is more efficient for it.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/csky/include/asm/tlb.h |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/arch/csky/include/asm/tlb.h
> +++ b/arch/csky/include/asm/tlb.h
> @@ -4,8 +4,6 @@
>  #define __ASM_CSKY_TLB_H
>  
>  #include <asm/cacheflush.h>
> -#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)

Looks right to me, and the generic code handles the fullmm case when
!CONFIG_MMU_GATHER_NO_RANGE so:

Acked-by: Will Deacon <will@kernel.org>

Will
