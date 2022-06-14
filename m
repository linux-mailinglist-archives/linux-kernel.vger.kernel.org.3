Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4581854A3D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349476AbiFNBvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348863AbiFNBvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:51:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA7C2C12E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655171473; x=1686707473;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xR9+0H/9OiLAA9Tu6kOW3uyO/wnTrUEpnpUyHCYRC8k=;
  b=AdX+HGn3VJM0qvZ8HS6/goUmQhJW+bIrMzfqhmizq4ySIxDb4fX8Jquj
   YTFvsi70Fm4gSlmrMiIvpfzPd1sM2TeRMHx7ItLlGRqBXW781cCVI6QAa
   9NMNsUnv3mf8KJna/6hJkRtB/zmvVuTJnVOSHsXm52sICdfbvfSFolifE
   jDa28IdNEUMNf9+tl2S5fHI3jwZT2e7ydkxt33wm/jDkkk4fn089NnkV2
   oui3Rj2szp4/YIfGmfz//WGwhYlhr+dRdz6V5uh8T5k58ODfvs+Hxrrv7
   CzeMveANdWNI3zmZTWJfuRpEdnQJ5HnKPjsemM17we0hq6xGtUtGUtQ5x
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277245874"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="277245874"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:51:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="910701088"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 18:51:10 -0700
Message-ID: <9c943703-0c2f-b654-a28b-f594bf90bec9@linux.intel.com>
Date:   Tue, 14 Jun 2022 09:51:08 +0800
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CALzcddsXciFgKOLSkXxx4Rv_rwh21qe8hkyiEET280D8orP6Vw@mail.gmail.com>
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

On 2022/6/14 09:44, Jerry Snitselaar wrote:
> On Mon, Jun 13, 2022 at 6:36 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 2022/6/14 04:57, Jerry Snitselaar wrote:
>>> On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
>>>> To support up to 64 sockets with 10 DMAR units each (640), make the
>>>> value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
>>>> CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when MAXSMP is
>>>> set.
>>>>
>>>> If the available hardware exceeds DMAR_UNITS_SUPPORTED (previously set
>>>> to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
>>>> allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
>>>> remapping doesn't support X2APIC mode x2apic disabled"; and the system
>>>> fails to boot properly.
>>>>
>>>> Signed-off-by: Steve Wahl<steve.wahl@hpe.com>
>>>> ---
>>>>
>>>> Note that we could not find a reason for connecting
>>>> DMAR_UNITS_SUPPORTED to MAX_IO_APICS as was done previously.  Perhaps
>>>> it seemed like the two would continue to match on earlier processors.
>>>> There doesn't appear to be kernel code that assumes that the value of
>>>> one is related to the other.
>>>>
>>>> v2: Make this value a config option, rather than a fixed constant.  The default
>>>> values should match previous configuration except in the MAXSMP case.  Keeping the
>>>> value at a power of two was requested by Kevin Tian.
>>>>
>>>>    drivers/iommu/intel/Kconfig | 6 ++++++
>>>>    include/linux/dmar.h        | 6 +-----
>>>>    2 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>>>> index 247d0f2d5fdf..fdbda77ac21e 100644
>>>> --- a/drivers/iommu/intel/Kconfig
>>>> +++ b/drivers/iommu/intel/Kconfig
>>>> @@ -9,6 +9,12 @@ config DMAR_PERF
>>>>    config DMAR_DEBUG
>>>>       bool
>>>>
>>>> +config DMAR_UNITS_SUPPORTED
>>>> +    int "Number of DMA Remapping Units supported"
>>> Also, should there be a "depends on (X86 || IA64)" here?
>> Do you have any compilation errors or warnings?
>>
>> Best regards,
>> baolu
>>
> I think it is probably harmless since it doesn't get used elsewhere,
> but our tooling was complaining to me because DMAR_UNITS_SUPPORTED was
> being autogenerated into the configs for the non-x86 architectures we
> build (aarch64, s390x, ppcle64).
> We have files corresponding to the config options that it looks at,
> and I had one for x86 and not the others so it noticed the
> discrepancy.

So with "depends on (X86 || IA64)", that tool doesn't complain anymore,
right?

Best regards,
baolu
