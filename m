Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA18755710D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 04:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377823AbiFWC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiFWC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 22:29:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1318C403CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 19:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655951383; x=1687487383;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O8dTk/EyqAi+/URxBU6KCoV1F2X9CZR61Iaxw/z5tl0=;
  b=gI6vgjukuE7TVmBEdiwt18N/FEXalHFC7u74AYFTCI5ugXi7egoQVoub
   WqJOsw158XZjIPTlp7oh36dBbKLDdINGdhKa0YplV8E4/qVw+KIHMfuDA
   P3/JF3sNXpKrL0l4bgolyHVTfL/k6NEo/a0F0DIK1HsSm77iZLbYC+C24
   7aY/JVlC+ZrLKG88RNR8m07UAQ6HsWnHUB/k8OTYY4/Rk7APZDAKKEGUc
   U+QG8ANgF4+rXqrhHLJR9z3RcrbKtXg+yxx27G+nUEoNXq1XE7YU4UXSH
   H55OqB03cxZrSNRlcmKM5G5TAQgu42jQzcriBfY8e0gAHptH8gjLQJXD4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="279371133"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="279371133"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 19:29:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644501698"
Received: from yutaoxu-mobl.ccr.corp.intel.com (HELO [10.249.172.190]) ([10.249.172.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 19:29:38 -0700
Message-ID: <f0e4adc8-5d67-b76a-d0f1-2df83bd69a82@linux.intel.com>
Date:   Thu, 23 Jun 2022 10:29:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Steve Wahl <steve.wahl@hpe.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
 <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/22 23:05, Jerry Snitselaar wrote:
> On Wed, Jun 22, 2022 at 7:52 AM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 2022/6/16 02:36, Steve Wahl wrote:
>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>> set.
>>>
>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>> fails to boot properly.
>>>
>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
>>> ---
>>>
>>> Note that we could not find a reason for connecting
>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>> it seemed like the two would continue to match on earlier processors.
>>> There doesn't appear to be kernel code that assumes that the value of
>>> one is related to the other.
>>>
>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>> value at a power of two was requested by Kevin Tian.
>>>
>>> v3: Make the config option dependent upon DMAR_TABLE, as it is not used without this.
>>>
>>>    drivers/iommu/intel/Kconfig | 7 +++++++
>>>    include/linux/dmar.h        | 6 +-----
>>>    2 files changed, 8 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>> index 39a06d245f12..07aaebcb581d 100644
>>> --- a/drivers/iommu/intel/Kconfig
>>> +++ b/drivers/iommu/intel/Kconfig
>>> @@ -9,6 +9,13 @@ config DMAR_PERF
>>>    config DMAR_DEBUG
>>>        bool
>>>
>>> +config DMAR_UNITS_SUPPORTED
>>> +     int "Number of DMA Remapping Units supported"
>>> +     depends on DMAR_TABLE
>>> +     default 1024 if MAXSMP
>>> +     default 128  if X86_64
>>> +     default 64
>> With this patch applied, the IOMMU configuration looks like:
>>
>> [*]   AMD IOMMU support
>> <M>     AMD IOMMU Version 2 driver
>> [*]     Enable AMD IOMMU internals in DebugFS
>> (1024) Number of DMA Remapping Units supported   <<<< NEW
>> [*]   Support for Intel IOMMU using DMA Remapping Devices
>> [*]     Export Intel IOMMU internals in Debugfs
>> [*]     Support for Shared Virtual Memory with Intel IOMMU
>> [*]     Enable Intel DMA Remapping Devices by default
>> [*]     Enable Intel IOMMU scalable mode by default
>> [*]   Support for Interrupt Remapping
>> [*]   OMAP IOMMU Support
>> [*]     Export OMAP IOMMU internals in DebugFS
>> [*]   Rockchip IOMMU Support
>>
>> The NEW item looks confusing. It looks to be a generic configurable
>> value though it's actually Intel DMAR specific. Any thoughts?
>>
>> Best regards,
>> baolu
>>
> Would moving it under INTEL_IOMMU at least have it show up below
> "Support for Intel IOMMU using DMA Remapping Devices"? I'm not sure it
> can be better than that, because IRQ_REMAP selects DMAR_TABLE, so we
> can't stick it in the if INTEL_IOMMU section.

It's more reasonable to move it under INTEL_IOMMU, but the trouble is
that this also stands even if INTEL_IOMMU is not configured.

The real problem here is that the iommu sequence ID overflows if
DMAR_UNITS_SUPPORTED is not big enough. This is purely a software
implementation issue, I am not sure whether user opt-in when building a
kernel package could help a lot here.

If we can't find a better way, can we just step back?

Best regards,
baolu
