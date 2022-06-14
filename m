Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E154A3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbiFNBgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiFNBgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:36:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298033A06
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655170581; x=1686706581;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ewivjPZum4J8cY2UdxwQKYE+RjVPBMMFr8E5bpfsPXc=;
  b=UGc3du+UML2M5P7EUB703gu8lwBWOEz8sOahnKttvSdXgw/18DsMxr8+
   7mTuAHiOX3B+3lYJ/ob/+ookqR/tXMfGCwxflVlk+FVH1yO8u8PCbID1a
   /SIovODCI+NtaB69brlXlibidb7icUMVT5dnaLkXzzqwldziCO3sRCPF2
   TEz2IL6jzUU2DzHnq5RqFMZGrIqwQDgUBA7kBRuZvHuk/UsXsubP74dcc
   url2w9H5ejB8TPjoTDnZm+9v9V5T4uSlew6KpN/HgEZl/MQfpos4I2YeD
   28ZD9AmTiYC28On1m0JEpvJ56rQhdECr61uf7wd5fBaMWv9KpeOSioxfC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="342434172"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="342434172"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:36:20 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="910696441"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:36:17 -0700
Message-ID: <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
Date:   Tue, 14 Jun 2022 09:36:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220613205734.3x7i46bnsofzerr4@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 04:57, Jerry Snitselaar wrote:
> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>> To support up to 64 sockets with 10 DMAR units each (640), make the
>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>> set.
>>
>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>> fails to boot properly.
>>
>> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
>> ---
>>
>> Note that we could not find a reason for connecting
>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>> it seemed like the two would continue to match on earlier processors.
>> There doesn't appear to be kernel code that assumes that the value of
>> one is related to the other.
>>
>> v2: Make this value a config option, rather than a fixed constant.  The default
>> values should match previous configuration except in the MAXSMP case.  Keeping the
>> value at a power of two was requested by Kevin Tian.
>>
>>   drivers/iommu/intel/Kconfig | 6 ++++++
>>   include/linux/dmar.h        | 6 +-----
>>   2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index 247d0f2d5fdf..fdbda77ac21e 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>   config DMAR_DEBUG
>>   	bool
>>   
>> +config DMAR_UNITS_SUPPORTED
>> +	int "Number of DMA Remapping Units supported"
> 
> Also, should there be a "depends on (X86 || IA64)" here?

Do you have any compilation errors or warnings?

Best regards,
baolu

> 
>> +	default 1024 if MAXSMP
>> +	default 128  if X86_64
>> +	default 64
>> +
>>   config INTEL_IOMMU
>>   	bool "Support for Intel IOMMU using DMA Remapping Devices"
>>   	depends on PCI_MSI && ACPI && (X86 || IA64)
>> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
>> index 45e903d84733..0c03c1845c23 100644
>> --- a/include/linux/dmar.h
>> +++ b/include/linux/dmar.h
>> @@ -18,11 +18,7 @@
>>   
>>   struct acpi_dmar_header;
>>   
>> -#ifdef	CONFIG_X86
>> -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
>> -#else
>> -# define	DMAR_UNITS_SUPPORTED	64
>> -#endif
>> +#define	DMAR_UNITS_SUPPORTED	CONFIG_DMAR_UNITS_SUPPORTED
>>   
>>   /* DMAR Flags */
>>   #define DMAR_INTR_REMAP		0x1
>> -- 
>> 2.26.2
>>
> 

