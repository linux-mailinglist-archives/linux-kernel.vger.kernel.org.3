Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD7554DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357493AbiFVOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355951AbiFVOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:52:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455853E0C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655909551; x=1687445551;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GdP+v9rWFJruBYGDlVuNU2He/W1X7NsvVGksa2exDM0=;
  b=fZKnIQzEFOk+A7bJY67jUsZ1H36oD+IUP+LnW/BcI9BvyD3lO6zsMVye
   4LxgzeBpHN2p0X+9fthida6lz3M2PdDzFq+BzICcqBvso4GoJ01VASLW6
   x49wtoIeWG9wh2LrmOvhbfT0V+z7XrAVk/Z52WBeMXd90ek+Q6Bjj6SDk
   2W4+ARmZjZPVjHtU3NK2or+ssqWhxOFjFCN805cyGQf4YbFl9l/L1kzQJ
   n/S2ZBx4aSl11hWFX24x9Cj2kZXwPI7DNAsAJSmENN4/jH6ipxBx4yUgx
   iG6kvXLlDsB/EQnIIOuyi6f9/7lgkdFUumJZmgJaCmm2r/n5ll04aT8Om
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305890592"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305890592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:52:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834148065"
Received: from xzhan99-mobl1.ccr.corp.intel.com (HELO [10.249.172.26]) ([10.249.172.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 07:52:27 -0700
Message-ID: <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
Date:   Wed, 22 Jun 2022 22:52:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Steve Wahl <steve.wahl@hpe.com>, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Kevin Tian <kevin.tian@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220615183650.32075-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/16 02:36, Steve Wahl wrote:
> To support up to 64 sockets with 10 DMAR units each (640), make the
> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
> set.
> 
> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> remapping doesn't support X2APIC mode x2apic disabled"; and the system
> fails to boot properly.
> 
> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> ---
> 
> Note that we could not find a reason for connecting
> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
> it seemed like the two would continue to match on earlier processors.
> There doesn't appear to be kernel code that assumes that the value of
> one is related to the other.
> 
> v2: Make this value a config option, rather than a fixed constant.  The default
> values should match previous configuration except in the MAXSMP case.  Keeping the
> value at a power of two was requested by Kevin Tian.
> 
> v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
> 
>   drivers/iommu/intel/Kconfig | 7 +++++++
>   include/linux/dmar.h        | 6 +-----
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 39a06d245f12..07aaebcb581d 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -9,6 +9,13 @@ config DMAR_PERF
>   config DMAR_DEBUG
>   	bool
>   
> +config DMAR_UNITS_SUPPORTED
> +	int "Number of DMA Remapping Units supported"
> +	depends on DMAR_TABLE
> +	default 1024 if MAXSMP
> +	default 128  if X86_64
> +	default 64

With this patch applied, the IOMMU configuration looks like:

[*]   AMD IOMMU support
<M>     AMD IOMMU Version 2 driver
[*]     Enable AMD IOMMU internals in DebugFS
(1024) Number of DMA Remapping Units supported   <<<< NEW
[*]   Support for Intel IOMMU using DMA Remapping Devices
[*]     Export Intel IOMMU internals in Debugfs
[*]     Support for Shared Virtual Memory with Intel IOMMU
[*]     Enable Intel DMA Remapping Devices by default
[*]     Enable Intel IOMMU scalable mode by default
[*]   Support for Interrupt Remapping
[*]   OMAP IOMMU Support
[*]     Export OMAP IOMMU internals in DebugFS
[*]   Rockchip IOMMU Support

The NEW item looks confusing. It looks to be a generic configurable
value though it's actually Intel DMAR specific. Any thoughts?

Best regards,
baolu
