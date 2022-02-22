Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA67C4BFE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiBVQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiBVQLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:11:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95FA165C1B;
        Tue, 22 Feb 2022 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645546285; x=1677082285;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xAztCkgXwGQAWMHLroJTEMZem0nISYqo7RPlzIO8arA=;
  b=JDQ8h5wrel3bviDk+pDa3f9QDFus6Mszbb1NQyZLLcneMSFhHtoUquAt
   meXarquXCkYQ+6zzwv7tJQy3BruyvSVSl2MroTtPYMvkaul95xjeFUh1c
   95IR6H6pxPKwdMKevRbNo4HRpFAmcBWP1aYTupa1655ZGCYXtoUpo+bOi
   mIe9KpmijYiQu4ddrZrvi9eJXfXLMczCsut1JXiVKxKPwvg7D9OFSFzEV
   m2GJLeDpC2k+gbdly5pAulA7CSbCpYimCsRN0B29Q8UWu1sNbbof4tBY1
   ch7YvT3n4/7tECAY/Tk4I4NP+sXnO16mUe8VGrc+fvkViOLvE6fZBc3f4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="250567132"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="250567132"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 08:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="776352766"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 22 Feb 2022 08:11:16 -0800
Received: from [10.209.63.44] (kliang2-MOBL.ccr.corp.intel.com [10.209.63.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B81F8580BDB;
        Tue, 22 Feb 2022 08:11:14 -0800 (PST)
Message-ID: <d38b0f9e-e9b9-e6d2-7da5-7169dedbc404@linux.intel.com>
Date:   Tue, 22 Feb 2022 11:11:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf/x86/intel/uncore: Make uncore_discovery clean for 64
 bit addresses
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Liang, Kan" <kan.liang@intel.com>
References: <20220218175418.421268-1-steve.wahl@hpe.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220218175418.421268-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/18/2022 12:54 PM, Steve Wahl wrote:
> Support 64-bit BAR size for discovery, and do not truncate return from
> generic_uncore_mmio_box_ctl() to 32 bits.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

Thanks for the patch.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>


Thanks,
Kan
> ---
>   arch/x86/events/intel/uncore_discovery.c | 16 +++++++++++-----
>   arch/x86/events/intel/uncore_discovery.h |  2 --
>   2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 3049c646fa20..141a540e7403 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -210,15 +210,21 @@ static int parse_discovery_table(struct pci_dev *dev, int die,
>   	void __iomem *io_addr;
>   	resource_size_t addr;
>   	unsigned long size;
> -	u32 val;
> +	u32 val, val2;
>   	int i;
>   
>   	pci_read_config_dword(dev, bar_offset, &val);
>   
> -	if (val & UNCORE_DISCOVERY_MASK)
> +	if (val & ~PCI_BASE_ADDRESS_MEM_MASK & ~PCI_BASE_ADDRESS_MEM_TYPE_64)
>   		return -EINVAL;
>   
> -	addr = (resource_size_t)(val & ~UNCORE_DISCOVERY_MASK);
> +	addr = (resource_size_t)(val & PCI_BASE_ADDRESS_MEM_MASK);
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +	if ((val & PCI_BASE_ADDRESS_MEM_TYPE_MASK) == PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		pci_read_config_dword(dev, bar_offset + 4, &val2);
> +		addr |= ((resource_size_t)val2) << 32;
> +	}
> +#endif
>   	size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
>   	io_addr = ioremap(addr, size);
>   	if (!io_addr)
> @@ -444,7 +450,7 @@ static struct intel_uncore_ops generic_uncore_pci_ops = {
>   
>   #define UNCORE_GENERIC_MMIO_SIZE		0x4000
>   
> -static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
> +static u64 generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
>   {
>   	struct intel_uncore_type *type = box->pmu->type;
>   
> @@ -456,7 +462,7 @@ static unsigned int generic_uncore_mmio_box_ctl(struct intel_uncore_box *box)
>   
>   void intel_generic_uncore_mmio_init_box(struct intel_uncore_box *box)
>   {
> -	unsigned int box_ctl = generic_uncore_mmio_box_ctl(box);
> +	u64 box_ctl = generic_uncore_mmio_box_ctl(box);
>   	struct intel_uncore_type *type = box->pmu->type;
>   	resource_size_t addr;
>   
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index 6d735611c281..22d40e7afbf1 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -18,8 +18,6 @@
>   #define UNCORE_DISCOVERY_BIR_BASE		0x10
>   /* Discovery table BAR step */
>   #define UNCORE_DISCOVERY_BIR_STEP		0x4
> -/* Mask of the discovery table offset */
> -#define UNCORE_DISCOVERY_MASK			0xf
>   /* Global discovery table size */
>   #define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE	0x20
>   
