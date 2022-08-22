Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9FC59C1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiHVObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiHVObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:31:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A1D1A803
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661178705; x=1692714705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w0/iww/X3RfFgBUxi2eU4bHj8vbCORI/e11jWSzv6TM=;
  b=if+jZ/60tlARzgJv4L1sXAMXwSTpvaBeN3jZU6VrolI3oTJifzIwpYF4
   VtR8mKPmAjwJ/PSvkB8drJItERbIpJUeQXHf2r/fFVIigaTUyWJXEffqu
   TNLyMnHbZRCBykDTEnOP7tu48M2uyaADZuEG6/aRt1ilwnJI37LU1k6Ti
   SmvZPItrixJDXosa0MLydR8Vh5F1ZtapfuXMtmwnOaQlT3My4+AIoTVxJ
   co/+yZuLcEkbUJzREdLCkvKh8diHQdxGkBamDX9Gp1uelKi8SH0VR9Ajo
   gYoOSjA9Yfy7Dx2L9Ub0Iu0C5etz6l8a6wD3mvO/kC+kU3I/dfRwMLbLC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273814933"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="273814933"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 07:31:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="585542289"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.228.10]) ([10.255.228.10])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 07:31:44 -0700
Message-ID: <14f7f3d2-e85b-f77a-bbac-abe3afd74321@linux.intel.com>
Date:   Mon, 22 Aug 2022 16:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error for
 Alder Lake N
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOJHLuX57Q4e/wH@worktop.programming.kicks-ass.net>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <YwOJHLuX57Q4e/wH@worktop.programming.kicks-ass.net>
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


On 8/22/2022 3:48 PM, Peter Zijlstra wrote:
> On Mon, Aug 22, 2022 at 09:28:31AM -0400, Liang, Kan wrote:
>>
>> On 2022-08-19 10:38 a.m., Peter Zijlstra wrote:
>>> On Thu, Aug 18, 2022 at 11:15:30AM -0700, kan.liang@linux.intel.com wrote:
>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> For some Alder Lake N machine, the below unchecked MSR access error may be
>>>> triggered.
>>>>
>>>> [ 0.088017] rcu: Hierarchical SRCU implementation.
>>>> [ 0.088017] unchecked MSR access error: WRMSR to 0x38f (tried to write
>>>> 0x0001000f0000003f) at rIP: 0xffffffffb5684de8 (native_write_msr+0x8/0x30)
>>>> [ 0.088017] Call Trace:
>>>> [ 0.088017] <TASK>
>>>> [ 0.088017] __intel_pmu_enable_all.constprop.46+0x4a/0xa0
>>> FWIW, I seem to get the same error when booting KVM on my ADL. I'm
>>> fairly sure the whole CPUID vs vCPU thing is a trainwreck.
>> We will enhance the CPUID to address the issues. Hopefully, we can have
>> them supported in the next generation.
> How!? A vCPU can readily migrate between a big and small CPU. There is
> no way the guest can sanely program the (v)MSRs and expect it to work.

In principle this can be fixed by affinitizing the vcpus to their 
respective type and reporting the right type, and I thought qemu was 
supported to support this. But it would be certainly a much more complex 
command line.

If you don't do this, architectural events should work, but yes any non 
architectural will not count correctly.

I guess one way to detect this situation would be if the CPUID is 
Alderlake, but there is no hybrid support reported in CPUID. Then it's 
likely a situation like this and it could be special cased in the perf 
tools and only show a limited event list.

-Andi


