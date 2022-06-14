Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94054A6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354859AbiFNCoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354811AbiFNCoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:44:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B955C532F3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655173309; x=1686709309;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IztUUoy8U8XG/s2pBKQMDOQCni2K/ES1DelQBEeR07o=;
  b=gJHqJ29GTve0Y43Nwk+ZTkMn/1Fh0GXV4UKrGQ9QwevJ7VMD7SZPd3hQ
   AyGt+A8WDBPVHIRDazzRNJqswigLC3WPqQ8wImiCyhXTn+7Elp1KdxRO3
   obsUt3MYVb8phfuplS1GK+KQTokNuySZ41DvJk+keypSBen/ZHCfLnRxM
   +yq7OAVeXvF2HRqVlSOD/EtDrCip6AqF4YAsjwNq+Cu9ePJurAefOFAWi
   iHBn33aReg7VFhoX7ys5qaF2CLvqSgfLUols8W09FW1eBuoruTrpQOX0/
   yyRmikHQHP/8OgXz4O+9Zr5jU1sksHAV1xGjGbG/JJm53ZDtaIZZB7tSA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="276008911"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="276008911"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:21:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="910710180"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:21:31 -0700
Message-ID: <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
Date:   Tue, 14 Jun 2022 10:21:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Steve Wahl <steve.wahl@hpe.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
 <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 09:54, Jerry Snitselaar wrote:
> On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>>
>> On 2022/6/14 09:44, Jerry Snitselaar wrote:
>>> On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>>>> On 2022/6/14 04:57, Jerry Snitselaar wrote:
>>>>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>>>>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>>>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>>>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>>>>> set.
>>>>>>
>>>>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>>>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>>>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>>>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>>>>> fails to boot properly.
>>>>>>
>>>>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>>>>> ---
>>>>>>
>>>>>> Note that we could not find a reason for connecting
>>>>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>>>>> it seemed like the two would continue to match on earlier processors.
>>>>>> There doesn't appear to be kernel code that assumes that the value of
>>>>>> one is related to the other.
>>>>>>
>>>>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>>>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>>>>> value at a power of two was requested by Kevin Tian.
>>>>>>
>>>>>>     drivers/iommu/intel/Kconfig | 6 ++++++
>>>>>>     include/linux/dmar.h        | 6 +-----
>>>>>>     2 files changed, 7 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>>>>> index 247d0f2d5fdf..fdbda77ac21e 100644
>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>>>>>     config DMAR_DEBUG
>>>>>>        bool
>>>>>>
>>>>>> +config DMAR_UNITS_SUPPORTED
>>>>>> +    int "Number of DMA Remapping Units supported"
>>>>> Also, should there be a "depends on (X86 || IA64)" here?
>>>> Do you have any compilation errors or warnings?
>>>>
>>>> Best regards,
>>>> baolu
>>>>
>>> I think it is probably harmless since it doesn't get used elsewhere,
>>> but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
>>> being autogenerated into the configs for the non-x86 architectures we
>>> build (aarch64, s390x, ppcle64).
>>> We have files corresponding to the config options that it looks at,
>>> and I had one for x86 and not the others so it noticed the
>>> discrepancy.
>>
>> So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
>> right?
>>
>> Best regards,
>> baolu
>>
> 
> Yes, with the depends it no longer happens.

The dmar code only exists on X86 and IA64 arch's. Adding this depending
makes sense to me. I will add it if no objections.

Best regards,
baolu
