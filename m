Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADAE54D4D7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbiFOWwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350793AbiFOWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:52:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925BC56B19
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655333520; x=1686869520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxcCAp3JWEzEYsY7aLkNJu47mZ/7c9K+V/Ag23PGSY0=;
  b=FSf3hfNTJ5SnKEmj/3M4Ipjs2GWojOdBl1iudX0f6M9Gr3Y2cM9sDJ38
   +YuRnlB/mlhNCcF79xbHWR3BxZ3Yia7aQ181fLHOHFNmhLjBFTQdNZbJe
   P+0xLIyPsJQ6nC4amCyLxozGvcrDKKpZunIUQcR/peD1jndB44RNIYEPY
   V25jYg9gzRkDm2mDSNfwUDAsy+/Cao2b9755ke3fKKhzpCMRTmQjdknBf
   b1MA3qbgiYPCREmqlg4Bm0MiUgHEP4hpgGhEA1ig4IYejHpdSl2BM59b0
   pJRQRF5Oy2dbq9DavUrX+3/1fks2j/cACsRxasxhq32ECqmCXHyo5XIwf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="365470955"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="365470955"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583409887"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2022 15:51:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7AE03109; Thu, 16 Jun 2022 01:52:00 +0300 (EEST)
Date:   Thu, 16 Jun 2022 01:52:00 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220615225200.lflv4tbqus6lnj5u@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 03:01:35PM +0300, Kirill A. Shutemov wrote:
> load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> The unwanted loads are typically harmless. But, they might be made to
> totally unrelated or even unmapped memory. load_unaligned_zeropad()
> relies on exception fixup (#PF, #GP and now #VE) to recover from these
> unwanted loads.
> 
> In TDX guests, the second page can be shared page and VMM may configure
> it to trigger #VE.
> 
> Kernel assumes that #VE on a shared page is MMIO access and tries to
> decode instruction to handle it. In case of load_unaligned_zeropad() it
> may result in confusion as it is not MMIO access.
> 
> Fix it by detecting split page MMIO accesses and fail them.
> load_unaligned_zeropad() will recover using exception fixups.
> 
> The issue was discovered by analysis. It was not triggered during the
> testing.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 7d6d484a6d28..3bcaf2170ede 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -333,8 +333,8 @@ static bool mmio_write(int size, unsigned long addr, unsigned long val)
>  
>  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  {
> +	unsigned long *reg, val, vaddr;
>  	char buffer[MAX_INSN_SIZE];
> -	unsigned long *reg, val;
>  	struct insn insn = {};
>  	enum mmio_type mmio;
>  	int size, extend_size;
> @@ -360,6 +360,19 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  			return -EINVAL;
>  	}
>  
> +	/*
> +	 * Reject EPT violation #VEs that split pages.
> +	 *
> +	 * MMIO accesses suppose to be naturally aligned and therefore never
> +	 * cross a page boundary. Seeing split page accesses indicates a bug
> +	 * or load_unaligned_zeropad() that steps into unmapped shared page.
> +	 *
> +	 * load_unaligned_zeropad() will recover using exception fixups.
> +	 */
> +	vaddr = (unsigned long)insn_get_addr_ref(&insn, regs);
> +	if (vaddr / PAGE_SIZE != (vaddr + size) / PAGE_SIZE)

Oops. I just realized it has off-by-one. It supposed to be:

	if (vaddr / PAGE_SIZE != (vaddr + size - 1) / PAGE_SIZE)

> +		return -EFAULT;
> +
>  	/* Handle writes first */
>  	switch (mmio) {
>  	case MMIO_WRITE:
> -- 
> 2.35.1
> 

-- 
 Kirill A. Shutemov
