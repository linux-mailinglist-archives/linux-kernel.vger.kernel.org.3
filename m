Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720B547C190
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbhLUOeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:34:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:21968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhLUOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640097256; x=1671633256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OcNRIgcgXZ7GQYAfSBs5DkjQzI4mhLNysLq43pD7LA4=;
  b=SiENDTsparnfLWYlnVaSzSwnesgcrjtq2XB2I821nmpbt245oZrYcrku
   W3nwmMrDROq0BbI5XChEDvhqWLOiD8NsKaa9LJfxqUXA5E/MbT4J1T3GY
   6RzmznXgZXAD7dAr6c4EfuHAXKGnVgBpz6QsYxKARxdYrB5puXba98dT9
   AlDWJYtl/Hxgcrid3iENBiG5K3qjLjGOt8pOxVq8ZqGtpOMPn1EBNQs7a
   WeQir0Ae3nR7AH3J4m0/U4jib/aqOhb94dtNDDIo1a/ykWn0Szv/ggJkl
   kxxVT2XBIvLukqQwk4cBt4UTxHSNzIzwcPx+cH5nFQZiJDB/NFiyveEEJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="240357413"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="240357413"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 06:34:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="616779165"
Received: from carel.sh.intel.com (HELO linux.intel.com) ([10.239.158.92])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 06:34:13 -0800
Date:   Tue, 21 Dec 2021 22:31:54 +0800
From:   Carel Si <beibei.si@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [LKP] Re: [x86/mm/64] f154f29085:
 BUG:kernel_reboot-without-warning_in_boot_stage - clang KCOV?
Message-ID: <20211221143153.GA4676@linux.intel.com>
References: <20211209144141.GC25654@xsang-OptiPlex-9020>
 <YbjIoewxGaodXHKF@zn.tnic>
 <20211215070012.GA26582@linux.intel.com>
 <Ybm96seTxl+pWjTX@zn.tnic>
 <009391a5-468b-2a5d-1f12-44d2e3104bd6@intel.com>
 <YbsPwyLnejLQMbTb@zn.tnic>
 <20211216115838.GA23522@linux.intel.com>
 <e48b72d4-558a-ed7c-43cd-0cb70091be11@intel.com>
 <YbyIJYzqtHPKRMFt@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbyIJYzqtHPKRMFt@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, Dec 17, 2021 at 08:52:53PM +0800, Borislav Petkov wrote:
> ---
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 0083464de5e3..79b3d67addcc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -384,7 +384,7 @@ void native_write_cr0(unsigned long val)
>  }
>  EXPORT_SYMBOL(native_write_cr0);
>  
> -void native_write_cr4(unsigned long val)
> +void __no_profile native_write_cr4(unsigned long val)
>  {
>  	unsigned long bits_changed = 0;
>  
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 75acb6027a87..68d2b7f9a913 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -483,7 +483,7 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  	/* Kill off the identity-map trampoline */
>  	reset_early_page_tables();
>  
> -	__native_tlb_flush_global(native_read_cr4());
> +	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
>  
>  	clear_bss();
>  

We tested your patch, it can fix the issue, thanks.

=========================================================================================
compiler/kconfig/rootfs/sleep/tbox_group/testcase:
  clang-14/x86_64-randconfig-a013-20211207/debian-10.4-x86_64-20200603.cgz/1/vm-snb/boot

commit: 
  9de4999050 ("x86/realmode: Add comment for Global bit usage in trampoline_pgd")
  f154f29085 ("x86/mm/64: Flush global TLB on boot and AP bringup") 
  d12ddfe498 ("fixup-for-f154f29085")

9de4999050b5f2e8 f154f290855b070cc94dd44ad25 d12ddfe498329a0967c008d8183 
---------------- --------------------------- --------------------------- 
       fail:runs  %reproduction    fail:runs  %reproduction    fail:runs
           |             |             |             |             |    
           :27         100%          27:27           0%            :27    dmesg.BUG:kernel_reboot-without-warning_in_boot_stage
