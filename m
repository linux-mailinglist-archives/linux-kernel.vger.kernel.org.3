Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7816F4ED76A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiCaKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiCaKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:01:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC194991C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:59:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 582E968AA6; Thu, 31 Mar 2022 11:59:37 +0200 (CEST)
Date:   Thu, 31 Mar 2022 11:59:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v8 09/14] riscv: Fix accessing pfn bits in PTEs for
 non-32bit variants
Message-ID: <20220331095937.GF23422@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-10-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220324000710.575331-10-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 01:07:05AM +0100, Heiko Stuebner wrote:
> On rv32 the PFN part of PTEs is defined to use bits [xlen-1:10]
> while on rv64 it is defined to use bits [53:10], leaving [63:54]
> as reserved.
> 
> With upcoming optional extensions like svpbmt these previously
> reserved bits will get used so simply right-shifting the PTE
> to get the PFN won't be enough.
> 
> So introduce a _PAGE_PFN_MASK constant to mask the correct bits
> for both rv32 and rv64 before shifting.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/include/asm/pgtable-32.h   |  8 ++++++++
>  arch/riscv/include/asm/pgtable-64.h   | 14 +++++++++++---
>  arch/riscv/include/asm/pgtable-bits.h |  6 ------
>  arch/riscv/include/asm/pgtable.h      |  6 +++---
>  4 files changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable-32.h b/arch/riscv/include/asm/pgtable-32.h
> index 5b2e79e5bfa5..e266a4fe7f43 100644
> --- a/arch/riscv/include/asm/pgtable-32.h
> +++ b/arch/riscv/include/asm/pgtable-32.h
> @@ -7,6 +7,7 @@
>  #define _ASM_RISCV_PGTABLE_32_H
>  
>  #include <asm-generic/pgtable-nopmd.h>
> +#include <linux/bits.h>
>  #include <linux/const.h>
>  
>  /* Size of region mapped by a page global directory */
> @@ -16,4 +17,11 @@
>  
>  #define MAX_POSSIBLE_PHYSMEM_BITS 34
>  
> +/*
> + * rv32 PTE format:
> + * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *       PFN      reserved for SW   D   A   G   U   X   W   R   V
> + */
> +#define _PAGE_PFN_MASK  GENMASK(31, 10)

I have to say I really hate this obsfucating GENMASK macro, but it
does have a few other uses in the riscv code.

> +/*
> + * rv64 PTE format:
> + * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
> + *   N      MT     RSV    PFN      reserved for SW   D   A   G   U   X   W   R   V
> + */
>
> +#define _PAGE_PFN_MASK  GENMASK(53, 10)
> +
>  static inline int pud_present(pud_t pud)
>  {
>  	return (pud_val(pud) & _PAGE_PRESENT);
> @@ -91,12 +99,12 @@ static inline unsigned long _pud_pfn(pud_t pud)
>  
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> -	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> +	return (pmd_t *)pfn_to_virt((pud_val(pud) & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT);

Lots of overly long lins making this pretty unreadable.

But in general the (pfn & _PAGE_PFN_MASK) >> _PAGE_PFN_SHIFT logic
really should have a helper anyway.
