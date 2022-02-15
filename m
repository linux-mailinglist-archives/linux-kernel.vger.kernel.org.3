Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A034B6BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiBOMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:22:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiBOMW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:22:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3D8652D8;
        Tue, 15 Feb 2022 04:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644927738; x=1676463738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Z5qiYvDYgVNlV1KxkkI+JpsTNmfMXnWh+xwt4Boy3U=;
  b=K18fhYO+cO1+R1f4gdB/AxhnKjtkK43b06/+vItf5eOs7JpPkTXVcJ2e
   iHM1kJFYe+/quot+2cHbQ+ww463J0TnEMipp7YOM5Nz6nsHJIZ+s81AXJ
   HHLRg/v8RS/CMlteHDZ8pNaGUc8g2nIuni9NpXuc1tcEY31AMISFlg/cP
   vFklBoGU6+B4tjJEuNMgs+PsFuoZpi9LE5fr5wIgWePozIE1Ew/rhYv0H
   3dGqsaGvHbmAbdijmnC568gjGQqrcaQAR6Auvi7L5SV4izrEkDKw9mm9L
   vJRTMoAreyMML98quevfyB1Q8DVngqidABpRzZXlRUf4xHTwz3/dJR5cM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250081081"
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="250081081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:22:17 -0800
X-IronPort-AV: E=Sophos;i="5.88,370,1635231600"; 
   d="scan'208";a="544277902"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.249.196]) ([10.99.249.196])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 04:22:14 -0800
Message-ID: <f6e5f716-f191-c126-cc81-cf872ad4e750@linux.intel.com>
Date:   Tue, 15 Feb 2022 13:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] x86: Preserve ACPI memory area during hibernation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20220121103938.2602637-1-amadeuszx.slawinski@linux.intel.com>
 <59ef4cd5-5703-2356-c893-9858985f91e0@intel.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <59ef4cd5-5703-2356-c893-9858985f91e0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/2022 8:34 PM, Rafael J. Wysocki wrote:
> On 1/21/2022 11:39 AM, Amadeusz Sławiński wrote:
>> When overriding NHLT ACPI-table tests show that on some platforms
>> there is problem that NHLT contains garbage after hibernation/resume
>> cycle.
>>
>> Problem stems from the fact that ACPI override performs early memory
>> allocation using memblock_phys_alloc_range() in
>> memblock_phys_alloc_range(). This memory block is later being marked as
>> ACPI memory block in arch_reserve_mem_area(). Later when memory areas
>> are considered for hibernation it is being marked as nosave in
>> e820__register_nosave_regions().
>>
>> Fix this by skipping ACPI memory area altogether when considering areas
>> to mark as nosave.
> 
> This patch looks correct to me and I'm going to apply it as 5.18 
> material unless there are any objections or concerns (in which case 
> please let me know).
> 
> 

Well, what do you know? I've checked with validation team to make sure 
that it works as expected and while it causes no problem on almost all 
platforms and fixes problem with NHLT ACPI-table override, there is this 
one platform where it causes oops on hibernation which of course is gone 
after reverting the patch.

  ? set_direct_map_default_noflush+0x130/0x130
  ? memory_bm_test_bit+0x29/0x60
  saveable_page+0xce/0xf2
  count_data_pages+0x50/0x76
  hibernate_preallocate_memory+0x9c/0x377
  ? __mutex_lock_slowpath+0x20/0x20
  hibernation_snapshot+0x1cf/0x610
  snapshot_ioctl+0x3d2/0x690
  ? snapshot_release+0xd0/0xd0
  ? new_sync_write+0x36b/0x390
  __x64_sys_ioctl+0x6dc/0xe20
  ? vfs_fileattr_set+0x520/0x520
  ? _raw_read_unlock+0x2a/0x50
  ? __kasan_check_read+0x11/0x20
  ? vfs_write+0x131/0x3d0
  ? ksys_write+0x13b/0x170
  ? debug_smp_processor_id+0x17/0x20
  ? fpregs_assert_state_consistent+0x5f/0x70
  ? exit_to_user_mode_prepare+0x3e/0x170
  do_syscall_64+0x43/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae

Above trace points at functions using pfn, so I suspect there may be 
need for some additional checks, but I will need to investigate.
I guess you can skip this patch for now, until I figure what exactly is 
going on.
