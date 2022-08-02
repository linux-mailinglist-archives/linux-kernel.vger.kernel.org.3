Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61746587F32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiHBPno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:43:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F89281
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659455020; x=1690991020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ROz/vuJ5wRTvvajh9vpqwj37VO3GU6YnB/QR5pMS0xw=;
  b=A1qC9JOIkA5G5NnyREEg7qLSAm2uD10oBF+vcgEmms0a+nGaWGZMtjZD
   ZWE5wiIDfPA49dW144nNqkKuhHwR+q3x8S6dgKmWpcOnpdwhzAZFzRhC4
   Gl1t6n5fGyisz0j2e9GjBGi5PKByqEGTbJZaD8PX6N0vXikCIb4ZAUqMj
   SMhi/1EIkxDDGAyG9PCrDH2ZLbxqO98HvdV4YG2eAbx+545tOoqiPh5XX
   qHMRYvpFiFMAvk13jXTWmWGan9BGuW8wBAEQ8iUqEiyUdLKkTAvha6y/L
   ecFH33ROWaBN8UnTDcrygEt4HjtrBwdOFISw/Ht1yoFFCBlfcdumCMZuj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290658256"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="290658256"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 08:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="691892584"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2022 08:43:39 -0700
Received: from [10.252.214.98] (kliang2-mobl1.ccr.corp.intel.com [10.252.214.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 21565580AD7;
        Tue,  2 Aug 2022 08:43:38 -0700 (PDT)
Message-ID: <b0bd2b88-2ac8-42f2-22dd-587a21a7e9dd@linux.intel.com>
Date:   Tue, 2 Aug 2022 11:43:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, tilak.tangudu@intel.com
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
 <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
 <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
 <20220723185617.vz3swht66lbtuwzl@ldmartin-desk2>
 <bec1bc73-b3bc-50da-8aa7-0aab2328d62f@linux.intel.com>
 <20220802142213.d2f6qzwl2w3sfm5g@ldmartin-desk2.lan>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220802142213.d2f6qzwl2w3sfm5g@ldmartin-desk2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-02 10:22 a.m., Lucas De Marchi wrote:
> On Mon, Jul 25, 2022 at 10:51:44AM -0400, Liang, Kan wrote:
>>
>>
>> On 2022-07-23 2:56 p.m., Lucas De Marchi wrote:
>>> On Fri, Jul 22, 2022 at 09:04:43AM -0400, Liang, Kan wrote:
>>>>
>>>>
>>>> On 2022-07-22 8:55 a.m., Lucas De Marchi wrote:
>>>>> Hi Kan,
>>>>>
>>>>> On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com
>>>>> wrote:
>>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>>
>>>>>> A self-describing mechanism for the uncore PerfMon hardware has been
>>>>>> introduced with the latest Intel platforms. By reading through an
>>>>>> MMIO
>>>>>> page worth of information, perf can 'discover' all the standard
>>>>>> uncore
>>>>>> PerfMon registers in a machine.
>>>>>>
>>>>>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>>>>>> a PCI device with the unique capability ID 0x23 can be found on each
>>>>>> die. Perf can retrieve the information of all available uncore
>>>>>> PerfMons
>>>>>> from the device via MMIO. The information is composed of one global
>>>>>> discovery table and several unit discovery tables.
>>>>>> - The global discovery table includes global uncore information of
>>>>>> the
>>>>>>  die, e.g., the address of the global control register, the offset of
>>>>>>  the global status register, the number of uncore units, the
>>>>>> offset of
>>>>>>  unit discovery tables, etc.
>>>>>> - The unit discovery table includes generic uncore unit information,
>>>>>>  e.g., the access type, the counter width, the address of counters,
>>>>>>  the address of the counter control, the unit ID, the unit type, etc.
>>>>>>  The unit is also called "box" in the code.
>>>>>> Perf can provide basic uncore support based on this information
>>>>>> with the following patches.
>>>>>>
>>>>>> To locate the PCI device with the discovery tables, check the generic
>>>>>> PCI ID first. If it doesn't match, go through the entire PCI device
>>>>>> tree
>>>>>> and locate the device with the unique capability ID.
>>>>>>
>>>>>> The uncore information is similar among dies. To save parsing time
>>>>>> and
>>>>>> space, only completely parse and store the discovery tables on the
>>>>>> first
>>>>>> die and the first box of each die. The parsed information is
>>>>>> stored in
>>>>>> an
>>>>>> RB tree structure, intel_uncore_discovery_type. The size of the
>>>>>> stored
>>>>>> discovery tables varies among platforms. It's around 4KB for a
>>>>>> Sapphire
>>>>>> Rapids server.
>>>>>>
>>>>>> If a BIOS doesn't support the 'discovery' mechanism, the uncore
>>>>>> driver
>>>>>> will exit with -ENODEV. There is nothing changed.
>>>>>>
>>>>>> Add a module parameter to disable the discovery feature. If a BIOS
>>>>>> gets
>>>>>> the discovery tables wrong, users can have an option to disable the
>>>>>> feature. For the current patchset, the uncore driver will exit with
>>>>>> -ENODEV. In the future, it may fall back to the hardcode uncore
>>>>>> driver
>>>>>> on a known platform.
>>>>>>
>>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> I observed one issue when upgrading a kernel from 5.10 to 5.15 and
>>>>> after
>>>>> bisecting it arrived to this commit. I also verified the same issue is
>>>>> present in 5.19-rc7 and that the issue is gone when booting with
>>>>> intel_uncore.uncore_no_discover.
>>>>>
>>>>> Test system is a SPR host with a PVC gpu. Issue is that PVC is not
>>>>> reaching pkg c6 state, even if we put it in rc6 state. It seems the
>>>>> pcie
>>>>> link is not idling, preventing it to go to pkg c6.
>>>>>
>>>>> PMON discovery in bios is set to "auto".
>>>>>
>>>>> We do see the following on dmesg while going through this code path:
>>>>>
>>>>>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
>>>>> 0xffffffffffffffff 0xffffffffffffffff
>>>>
>>>> On SPR, the uncore driver relies on the discovery table provided by the
>>>> BIOS/firmware. It looks like your BIOS/firmware is out of date. Could
>>>> you please update to the latest BIOS/firmware and have a try?
>>>
>>> hum, the BIOS is up to date. It seems PVC itself has a 0x09a7 device
>>> and it remains in D3, so the 0xffffffffffffffff we se below is
>>> just the auto completion. No wonder the values don't match what we are
>>> expecting here.
>>>
>>> Is it expected the device to be in D0? Or should we do anything here to
>>> move it to D0 before doing these reads?
>>>
>>
>> It's OK to have a 0x09a7 device. But the device should not claim to
>> support the PMON Discovery if it doesn't comply the PMON discovery
>> mechanism.
>>
>> See 1.10.1 Guidance on Finding PMON Discovery and Reading it in SPR
>> uncore document. https://cdrdv2.intel.com/v1/dl/getContent/642245
>> It demonstrates how the uncore driver find the device with the PMON
>> discovery mechanism.
> 
> ok, this is exactly the code in the kernel.
> 
>>
>> Simply speaking, the uncore driver looks for a DVSEC
>> structure with an unique capability ID 0x23. Then it checks whether the
>> PMON discovery entry (0x1) is supported. If both are detected, it means
>> that the device comply the PMON discovery mechanism. The uncore driver
>> will be enabled to parse the discovery table.
>>
>> AFAIK, the PVC gpu doesn't support the PMON discovery mechanism. I guess
>> the firmwire of the PVC gpu mistakenly set the PMON discovery entry
>> (0x1). You may want to check the extended capabilities (DVSEC) in the
>> PCIe configuration space of the PVC gpu device.
> 
> However here it seems we have 2 issues being mixed:
> 
> 1) PVC with that capability when it shouldn't

This is a firmware/HW issue. If PVC doesn't support the PMON discovery
mechanism, the PVC and its attached OOBMSM device should not enumerate
the discovery mechanism. However, the PVC enumerates the discovery
mechanism here, which doesn't comply the spec.

The uncore driver prints errors when the in-compliance is detected.
That's expected. There is noting more SW can do here.

The firmware issue must be fixed.

> 2) Trying to read the MMIOs when device is possibly in D3 state:

The uncore driver skips the device which doesn't support the discovery
mechanism.
If 1) is fixed, the uncore driver will not touch the MMIO space of a PVC
device. The power issue should be gone.

I've already sent you a patch to ignore the PVC added OOBMSM device, you
can double check with the patch.

Thanks,
Kan

> 
>     /* Map whole discovery table */
>     addr = pci_dword & ~(PAGE_SIZE - 1);
>     io_addr = ioremap(addr, UNCORE_DISCOVERY_MAP_SIZE);
> 
>     /* Read Global Discovery table */
>     memcpy_fromio(&global, io_addr, sizeof(struct
> uncore_global_discovery));
> 
> Unless it's guaranteed that at this point the device must be in D0
> state, this doesn't look right.  When we are binding a driver to a PCI
> device, pci core will move it to D0 for us:
> 
>     static long local_pci_probe(void *_ddi)
>     {
>         ...
>         /*
>          * Unbound PCI devices are always put in D0, regardless of
>          * runtime PM status.  During probe, the device is set to
>          * active and the usage count is incremented.  If the driver
>          * supports runtime PM, it should call pm_runtime_put_noidle(),
>          * or any other runtime PM helper function decrementing the usage
>          * count, in its probe routine and pm_runtime_get_noresume() in
>          * its remove routine.
>          */
>          pm_runtime_get_sync(dev);
>          ...
> 
> But here we are traversing the entire PCI device tree by ourselves.
> Considering intel_uncore is a module that can be loaded at any time
> (even after the driver supporting PVC, which already called
> pm_runtime_put_noidle(), it looks like we are missing the pm integration
> here.
> 
> On a quick hack, just forcing the device into D0 before doing the MMIO,
> the PM issue is gone (but we still hit the problem of PVC having the cap
> when it shouldn't)
> 
> thanks
> Lucas De Marchi
> 
>>
>> Thanks,
>> Kan
