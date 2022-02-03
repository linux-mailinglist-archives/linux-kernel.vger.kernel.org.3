Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CDB4A8803
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351976AbiBCPtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:49:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:63034 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344816AbiBCPtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643903354; x=1675439354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0vgO5gWthy3+FtdvuKnnN01Iq2gWepBMDOv33Ni2GVk=;
  b=I/24nSw4VY0v5lHrIrYkK/46FrRmGrBD44GJrA0bT9KAEyoISVxGGCai
   beIdSMSRJDOkB38UhjRfs4dFmstf6V11IvjeAGhoetQWXy5DY4r5yXUzR
   +xk2VvUtEVMd22jU2fF1OP/lKmcDYeJFmrz8Z67aaZxVkfqMLkXR4FqVF
   uHac5amy/TLnG+X/nBzq6MVEzL+v3WsN1HUz5EOa+Q0jOS1wcZA8kMeT6
   bIhd++Ayw0Mq4EEMC1g+asG+hq/Toy8Y+4s0a1WxeWZh6Hg66CEPoUozY
   MqVC1Xkp/8STxhaU24PCNaJOc35seXhnek+POrwwMNhpLYfZWJnYfzzSi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334528030"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334528030"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:49:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="498171842"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:49:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFeLD-000SjZ-O0;
        Thu, 03 Feb 2022 17:48:11 +0200
Date:   Thu, 3 Feb 2022 17:48:11 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: Why not use kvcalloc in bitmap_zalloc/bitmap_alloc?
Message-ID: <Yfv5OxhDdfLHETkt@smile.fi.intel.com>
References: <BN7PR11MB26099D11661A8D4D968CC646FDA90@BN7PR11MB2609.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN7PR11MB26099D11661A8D4D968CC646FDA90@BN7PR11MB2609.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 01:02:30AM +0000, Ma, Jianpeng wrote:
> Hi Andy:
>      Currently, I want to use bitmap_zalloc. But because I need large space(pages > 1024). So met the following message.
>      From the code, I know bitmap_zalloc use kmalloc.  To fix this problem, I change the code use "kvcalloc(BITS_TO_LONGS(ns->pages_total), sizeof(unsigned long), GFP_KERNEL);"
>      Because you introduced bitmap_zalloc, so I wanted to know why use kvcalloc in bitmap_zalloc?  Are there other considerations？

+Cc: maintainer and mailing list

> 2114 Jan 12 08:44:46 ceph kernel: [19770.801510] Modules linked in: test_nvm(E+) bcache(E) crc64 btrfs blake2b_generic xor zstd_compress raid6_pq ufs qnx4 hfsplus hfs minix ntfs msdos jfs intel_rapl_msr intel_rapl_common dax_pmem_compat  device_dax nd_pmem dax_pmem_core nd_btt skx_edac ipmi_ssif x86_pkg_temp_thermal binfmt_misc intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper nls_iso8859_1 raplxfs intel_cstate libcrc32c input_leds efi_pstore ast drm_vram_helper drm_ttm_helper ttm drm_kms_helper cec drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect sysimgblt switchtec lpc_ich mei_me mei ioatdma acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler nfit acpi_pad acpi_power_meter mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid ixgbe megaraid_sas xfrm_algo i40e dca mdio nvme nvme_core ahci libahci wmi [last unloaded: bcache]
>  2115 Jan 12 08:44:46 ceph kernel: [19770.801568] CPU: 72 PID: 74351 Comm: insmod Tainted: G            E     5.10.0-rc5+ #1
>  2116 Jan 12 08:44:46 ceph kernel: [19770.801569] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>  2117 Jan 12 08:44:46 ceph kernel: [19770.801572] RIP: 0010:__alloc_pages_nodemask+0x297/0x330
>  2118 Jan 12 08:44:46 ceph kernel: [19770.801574] Code: 08 44 89 f9 44 89 ea 4c 89 f6 e8 54 96 fc ff e9 4c ff ff ff e8 fa 17 fc ff 48 89 c7 e9 b8 fe ff ff 41 81 e4 00 20 00 00 75 a7 <0f> 0b eb a3 31 c0 e9 1b fe ff ff 65 48 8b 04 25 c0 7b       01 00 8b 40
>  2119 Jan 12 08:44:46 ceph kernel: [19770.801575] RSP: 0018:ffffb2afcd4e39d8 EFLAGS: 00010246
>  2120 Jan 12 08:44:46 ceph kernel: [19770.801577] RAX: 0000000000000000 RBX: 0000000000000dc0 RCX: 0000000000000000
>  2121 Jan 12 08:44:46 ceph kernel: [19770.801578] RDX: 0000000000000001 RSI: 000000000000000b RDI: 0000000000040dc0
>  2122 Jan 12 08:44:46 ceph kernel: [19770.801579] RBP: ffffb2afcd4e3a30 R08: ffffffffb29c83c8 R09: 0000000000000000
>  2123 Jan 12 08:44:46 ceph kernel: [19770.801580] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000000000000
>  2124 Jan 12 08:44:46 ceph kernel: [19770.801581] R13: ffffffffb29c83c8 R14: 000000000000000b R15: 0000000000000000
>  2125 Jan 12 08:44:46 ceph kernel: [19770.801583] FS:  00007f24f731b540(0000) GS:ffff89abc1800000(0000) knlGS:0000000000000000
>  2126 Jan 12 08:44:46 ceph kernel: [19770.801584] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  2127 Jan 12 08:44:46 ceph kernel: [19770.801585] CR2: 00007f24f6e9f450 CR3: 00000040fc79e004 CR4: 00000000007706e0
>  2128 Jan 12 08:44:46 ceph kernel: [19770.801586] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  2129 Jan 12 08:44:46 ceph kernel: [19770.801587] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  2130 Jan 12 08:44:46 ceph kernel: [19770.801588] PKRU: 55555554
>  2131 Jan 12 08:44:46 ceph kernel: [19770.801589] Call Trace:
>  2132 Jan 12 08:44:46 ceph kernel: [19770.801598]  alloc_pages_current+0x87/0xe0
>  2133 Jan 12 08:44:46 ceph kernel: [19770.801602]  kmalloc_order+0x2c/0x90
>  2134 Jan 12 08:44:46 ceph kernel: [19770.801604]  kmalloc_order_trace+0x1d/0x80
>  2135 Jan 12 08:44:46 ceph kernel: [19770.801608]  __kmalloc+0x271/0x300
>  2136 Jan 12 08:44:46 ceph kernel: [19770.801612]  bitmap_zalloc+0x1d/0x20
>  2137 Jan 12 08:44:46 ceph kernel: [19770.801630]  bch_register_namespace+0x387/0x4e0 [bcache]
>  2138 Jan 12 08:44:46 ceph kernel: [19770.801636]  ? __wake_up_common_lock+0x8a/0xc0
>  2139 Jan 12 08:44:46 ceph kernel: [19770.801639]  ? 0xffffffffc04e3000
>  2140 Jan 12 08:44:46 ceph kernel: [19770.801641]  test_nvm_init+0x2f/0x1000 [test_nvm]
>  2141 Jan 12 08:44:46 ceph kernel: [19770.801646]  ? netlink_broadcast_filtered+0x13e/0x480
>  2142 Jan 12 08:44:46 ceph kernel: [19770.801649]  ? _cond_resched+0x19/0x30
>  2143 Jan 12 08:44:46 ceph kernel: [19770.801651]  ? unmap_kernel_range_noflush+0x2e7/0x360
>  2144 Jan 12 08:44:46 ceph kernel: [19770.801653]  ? free_pcp_prepare+0x80/0x160
>  2145 Jan 12 08:44:46 ceph kernel: [19770.801654]  ? 0xffffffffc04e3000
>  2146 Jan 12 08:44:46 ceph kernel: [19770.801658]  do_one_initcall+0x48/0x1d0
>  2147 Jan 12 08:44:46 ceph kernel: [19770.801659]  ? _cond_resched+0x19/0x30
>  2148 Jan 12 08:44:46 ceph kernel: [19770.801661]  ? kmem_cache_alloc_trace+0x153/0x2b0
>  2149 Jan 12 08:44:46 ceph kernel: [19770.801664]  do_init_module+0x62/0x240
>  2150 Jan 12 08:44:46 ceph kernel: [19770.801666]  load_module+0x28a0/0x2c50
>  2151 Jan 12 08:44:46 ceph kernel: [19770.801672]  ? security_kernel_post_read_file+0x5c/0x70
>  2152 Jan 12 08:44:46 ceph kernel: [19770.801674]  __do_sys_finit_module+0xc2/0x120
>  2153 Jan 12 08:44:46 ceph kernel: [19770.801676]  ? __do_sys_finit_module+0xc2/0x120

-- 
With Best Regards,
Andy Shevchenko


