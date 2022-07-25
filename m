Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00021580101
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiGYOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiGYOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:51:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB47CD4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658760713; x=1690296713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+WbVs5sMQYAkSQVOMdmWh5G9RqLT20FLVz4KXcq4JoU=;
  b=b9D8Xcki+kFQw4Ct0WNyJMOmUypXLaMGHl+hBvz9gf7U6uR44N8W4Acb
   dnIXgybYpNQ4xD9u9hYzx1GPXzWTcCvQ1TByzUnFcWnAWRcvkJB5z+REv
   LeMtbU03YcwiKomDb7kX7yS1ZQeVlUsZV7WKd3pisHasm5cWiWf33AUl6
   LKbtSgyucvaIE/VeT3mdTZNg5+DG6g5S63J8ojR8Y3j0GbGqRr1La1M0B
   Xi6uLkiDrrQg6FtpEHxzOLfU5OwkkotT7M4eqOwlMOstKRfEUHgevrbH6
   1AdEguFd6pT1+eZXMvs1v7cWnJ8ZWQFo6D6UfKzDLCF4fvc3ShLRlKpiJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="349414908"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="349414908"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 07:51:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="775983385"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2022 07:51:48 -0700
Received: from [10.252.209.128] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EA14A58095D;
        Mon, 25 Jul 2022 07:51:46 -0700 (PDT)
Message-ID: <bec1bc73-b3bc-50da-8aa7-0aab2328d62f@linux.intel.com>
Date:   Mon, 25 Jul 2022 10:51:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
Content-Language: en-US
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220723185617.vz3swht66lbtuwzl@ldmartin-desk2>
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



On 2022-07-23 2:56 p.m., Lucas De Marchi wrote:
> On Fri, Jul 22, 2022 at 09:04:43AM -0400, Liang, Kan wrote:
>>
>>
>> On 2022-07-22 8:55 a.m., Lucas De Marchi wrote:
>>> Hi Kan,
>>>
>>> On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com
>>> wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> A self-describing mechanism for the uncore PerfMon hardware has been
>>>> introduced with the latest Intel platforms. By reading through an MMIO
>>>> page worth of information, perf can 'discover' all the standard uncore
>>>> PerfMon registers in a machine.
>>>>
>>>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>>>> a PCI device with the unique capability ID 0x23 can be found on each
>>>> die. Perf can retrieve the information of all available uncore PerfMons
>>>> from the device via MMIO. The information is composed of one global
>>>> discovery table and several unit discovery tables.
>>>> - The global discovery table includes global uncore information of the
>>>>  die, e.g., the address of the global control register, the offset of
>>>>  the global status register, the number of uncore units, the offset of
>>>>  unit discovery tables, etc.
>>>> - The unit discovery table includes generic uncore unit information,
>>>>  e.g., the access type, the counter width, the address of counters,
>>>>  the address of the counter control, the unit ID, the unit type, etc.
>>>>  The unit is also called "box" in the code.
>>>> Perf can provide basic uncore support based on this information
>>>> with the following patches.
>>>>
>>>> To locate the PCI device with the discovery tables, check the generic
>>>> PCI ID first. If it doesn't match, go through the entire PCI device
>>>> tree
>>>> and locate the device with the unique capability ID.
>>>>
>>>> The uncore information is similar among dies. To save parsing time and
>>>> space, only completely parse and store the discovery tables on the
>>>> first
>>>> die and the first box of each die. The parsed information is stored in
>>>> an
>>>> RB tree structure, intel_uncore_discovery_type. The size of the stored
>>>> discovery tables varies among platforms. It's around 4KB for a Sapphire
>>>> Rapids server.
>>>>
>>>> If a BIOS doesn't support the 'discovery' mechanism, the uncore driver
>>>> will exit with -ENODEV. There is nothing changed.
>>>>
>>>> Add a module parameter to disable the discovery feature. If a BIOS gets
>>>> the discovery tables wrong, users can have an option to disable the
>>>> feature. For the current patchset, the uncore driver will exit with
>>>> -ENODEV. In the future, it may fall back to the hardcode uncore driver
>>>> on a known platform.
>>>>
>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> I observed one issue when upgrading a kernel from 5.10 to 5.15 and after
>>> bisecting it arrived to this commit. I also verified the same issue is
>>> present in 5.19-rc7 and that the issue is gone when booting with
>>> intel_uncore.uncore_no_discover.
>>>
>>> Test system is a SPR host with a PVC gpu. Issue is that PVC is not
>>> reaching pkg c6 state, even if we put it in rc6 state. It seems the pcie
>>> link is not idling, preventing it to go to pkg c6.
>>>
>>> PMON discovery in bios is set to "auto".
>>>
>>> We do see the following on dmesg while going through this code path:
>>>
>>>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
>>> 0xffffffffffffffff 0xffffffffffffffff
>>
>> On SPR, the uncore driver relies on the discovery table provided by the
>> BIOS/firmware. It looks like your BIOS/firmware is out of date. Could
>> you please update to the latest BIOS/firmware and have a try?
> 
> hum, the BIOS is up to date. It seems PVC itself has a 0x09a7 device
> and it remains in D3, so the 0xffffffffffffffff we se below is
> just the auto completion. No wonder the values don't match what we are
> expecting here.
> 
> Is it expected the device to be in D0? Or should we do anything here to
> move it to D0 before doing these reads?
> 

It's OK to have a 0x09a7 device. But the device should not claim to
support the PMON Discovery if it doesn't comply the PMON discovery
mechanism.

See 1.10.1 Guidance on Finding PMON Discovery and Reading it in SPR
uncore document. https://cdrdv2.intel.com/v1/dl/getContent/642245
It demonstrates how the uncore driver find the device with the PMON
discovery mechanism.

Simply speaking, the uncore driver looks for a DVSEC
structure with an unique capability ID 0x23. Then it checks whether the
PMON discovery entry (0x1) is supported. If both are detected, it means
that the device comply the PMON discovery mechanism. The uncore driver
will be enabled to parse the discovery table.

AFAIK, the PVC gpu doesn't support the PMON discovery mechanism. I guess
the firmwire of the PVC gpu mistakenly set the PMON discovery entry
(0x1). You may want to check the extended capabilities (DVSEC) in the
PCIe configuration space of the PVC gpu device.

Thanks,
Kan
