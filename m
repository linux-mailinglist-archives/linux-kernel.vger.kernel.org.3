Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C754BF54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiFOBiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiFOBin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:38:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40352ED77
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655257122; x=1686793122;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F5FruFQBqBnDQJ0qsMlb0vjNU8I29/Dq4OsbDKGrAdw=;
  b=dGHNPl5PzHB1s21qj18anNtAcCaF7LmyTbjuqn3mUFh06u2VlDLfb4fe
   ZzPwz6RM7CW59LheuTKcjwxoiDr4RSZ8YRQVEd7Mc786siwnqzfgBJR5v
   OQpHb/lvMeHUxAjmGYJe3I0MlhhGllP7LlQIJVpcR9dEGz0qluK+iIE7p
   9huS05xkQB6B9tTL3rm2hrQ/fSYfCdysBTzPESVQPY2g7YlWXMCqNRQir
   WvGTZoGLHb7SbLhth06enoaGwYzQPVCDfKcmmxOWfewj/Pkyk9O5yP6ed
   xpjEtHpWfTqCtywF2x+T08M7uVpBstFRfa+VW8d2/g1fh7Wn7m70X99xT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="277586380"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277586380"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 18:38:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588809497"
Received: from leitan-mobl.ccr.corp.intel.com (HELO [10.255.31.142]) ([10.255.31.142])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 18:38:37 -0700
Message-ID: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
Date:   Wed, 15 Jun 2022 09:38:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
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
To:     Steve Wahl <steve.wahl@hpe.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <20220613205734.3x7i46bnsofzerr4@cantor>
 <673eb011-94f4-46b0-f1b4-24a02a269f4e@linux.intel.com>
 <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
 <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
 <CALzcdduU-baVF9VV-NnYD2rKn0YC5hzS_F9udExRE7guvMqXWg@mail.gmail.com>
 <616dc81c-dfc6-d6c6-1eab-de0e9ba4411f@linux.intel.com>
 <Yqi7L9A/ADXpIvN6@swahl-home.5wahls.com>
 <20220614190145.dkdwjnqnd7lv6y4n@cantor>
 <Yqj5q1Yps9JVlyyH@swahl-home.5wahls.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yqj5q1Yps9JVlyyH@swahl-home.5wahls.com>
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

On 2022/6/15 05:12, Steve Wahl wrote:
> On Tue, Jun 14, 2022 at 12:01:45PM -0700, Jerry Snitselaar wrote:
>> On Tue, Jun 14, 2022 at 11:45:35AM -0500, Steve Wahl wrote:
>>> On Tue, Jun 14, 2022 at 10:21:29AM +0800, Baolu Lu wrote:
>>>> On 2022/6/14 09:54, Jerry Snitselaar wrote:
>>>>> On Mon, Jun 13, 2022 at 6:51 PM Baolu Lu <baolu.lu@linux.intel.com> wrote:
>>>>>>
>>>>>> On 2022/6/14 09:44, Jerry Snitselaar wrote:
>>>>>>> On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>>>>>>>> On 2022/6/14 04:57, Jerry Snitselaar wrote:
>>>>>>>>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>>>>>>>>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>>>>>>>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>>>>>>>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>>>>>>>>> set.
>>>>>>>>>>
>>>>>>>>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>>>>>>>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>>>>>>>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>>>>>>>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>>>>>>>>> fails to boot properly.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Note that we could not find a reason for connecting
>>>>>>>>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>>>>>>>>> it seemed like the two would continue to match on earlier processors.
>>>>>>>>>> There doesn't appear to be kernel code that assumes that the value of
>>>>>>>>>> one is related to the other.
>>>>>>>>>>
>>>>>>>>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>>>>>>>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>>>>>>>>> value at a power of two was requested by Kevin Tian.
>>>>>>>>>>
>>>>>>>>>>      drivers/iommu/intel/Kconfig | 6 ++++++
>>>>>>>>>>      include/linux/dmar.h        | 6 +-----
>>>>>>>>>>      2 files changed, 7 insertions(+), 5 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>>>>>>>>> index 247d0f2d5fdf..fdbda77ac21e 100644
>>>>>>>>>> --- a/drivers/iommu/intel/Kconfig
>>>>>>>>>> +++ b/drivers/iommu/intel/Kconfig
>>>>>>>>>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>>>>>>>>>      config DMAR_DEBUG
>>>>>>>>>>         bool
>>>>>>>>>>
>>>>>>>>>> +config DMAR_UNITS_SUPPORTED
>>>>>>>>>> +    int "Number of DMA Remapping Units supported"
>>>>>>>>> Also, should there be a "depends on (X86 || IA64)" here?
>>>>>>>> Do you have any compilation errors or warnings?
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> baolu
>>>>>>>>
>>>>>>> I think it is probably harmless since it doesn't get used elsewhere,
>>>>>>> but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
>>>>>>> being autogenerated into the configs for the non-x86 architectures we
>>>>>>> build (aarch64, s390x, ppcle64).
>>>>>>> We have files corresponding to the config options that it looks at,
>>>>>>> and I had one for x86 and not the others so it noticed the
>>>>>>> discrepancy.
>>>>>>
>>>>>> So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
>>>>>> right?
>>>>>>
>>>>>> Best regards,
>>>>>> baolu
>>>>>>
>>>>>
>>>>> Yes, with the depends it no longer happens.
>>>>
>>>> The dmar code only exists on X86 and IA64 arch's. Adding this depending
>>>> makes sense to me. I will add it if no objections.
>>>
>>> I think that works after Baolu's patchset that makes intel-iommu.h
>>> private.  I'm pretty sure it wouldn't have worked before that.
>>>
>>> No objections.
>>>
>>
>> Yes, I think applying it with the depends prior to Baolu's change would
>> still run into the issue from the KTR report if someone compiled without
>> INTEL_IOMMU enabled.
>>
>> This was dealing with being able to do something like:
>>
>> make allmodconfig ARCH=arm64 ; grep DMAR_UNITS .config
>>
>> and finding CONFIG_DMAR_UNITS_SUPPORTED=64.
>>
>> Thinking some more though, instead of the depends being on the arch
>> would depending on DMAR_TABLE or INTEL_IOMMU be more appropriate?
> 
> At least in my limited exploration, depending on INTEL_IOMMU yields
> compile errors, but depending upon DMAR_TABLE appears to work fine.

DMAR_TABLE is used beyond INTEL_IOMMU, so depending on DMAR_TABLE seems
better.

Steve, do you mind posting a v3 with this fixed?

Best regards,
baolu

