Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3555A95D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 13:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIALiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 07:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiIALh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:37:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F1139F7C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662032278; x=1693568278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9ol9KceXIsX2CqIU3qCXqseU84Oohu14rAOJ5CsNSNw=;
  b=UzoZemdwNK0c5YBNn4yO7ORNo6RfS8BF9TF7fhxMZU1FM+bxjbeNRVZX
   10wIK+k6wDFTuGC6OVLvl1E+KiWGi/sN11Xfq3PHjZx5vNvCUHIAokzJO
   /RIGWOvOcbyjACQQt8EJONaZyPEDYrFVpjXw1UtG84Lxhmsb3ecAuZ/A0
   Nx24EnHySu7B1QqVU2IkEdMgXUYF6+/6CcqsUhfIhec12LjFgMegTiGhN
   rTXuulq5Wza9ixh97VmQVaMcjG4VpZaEEFZsJUmy78qXnlXaJRBHVweDH
   V6dVrchabycQJLXJW6l3XpFDhU5N6VEzI57gGc3dHzP6WPcmMNImSM6SA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="321838471"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321838471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 04:37:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="716079918"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2022 04:37:58 -0700
Received: from [10.252.213.4] (kamenshx-mobl.amr.corp.intel.com [10.252.213.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 950D4580AA7;
        Thu,  1 Sep 2022 04:37:56 -0700 (PDT)
Message-ID: <883ef80c-4adb-c77b-7cc6-dab50bef490e@linux.intel.com>
Date:   Thu, 1 Sep 2022 07:37:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 8/9] perf/x86/intel: Shadow
 MSR_ARCH_PERFMON_FIXED_CTR_CTRL
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, eranian@google.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org
References: <20220829100959.917169441@infradead.org>
 <20220829101321.905673933@infradead.org>
 <0b8477e2-6e85-b349-0e92-e6a298531c18@linux.intel.com>
 <YxB3GWVCNHg5RutQ@hirez.programming.kicks-ass.net>
 <YxCDr2uugoBQ5z27@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <YxCDr2uugoBQ5z27@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-01 6:04 a.m., Peter Zijlstra wrote:
> On Thu, Sep 01, 2022 at 11:10:49AM +0200, Peter Zijlstra wrote:
>> On Wed, Aug 31, 2022 at 09:52:19AM -0400, Liang, Kan wrote:
>>>
>>>
>>> On 2022-08-29 6:10 a.m., Peter Zijlstra wrote:
>>>> Less RDMSR is more better.
>>>
>>> I had an RFC patch which does a further step to move the fixed
>>> control register write to right before the entire PMU re-enabling, which
>>> could also save some writes if there are several fixed counters enabled.
>>> https://lore.kernel.org/lkml/20220804140729.2951259-1-kan.liang@linux.intel.com/
>>>
>>> Do you have any comments for the RFC patch?
>>>
>>
>> Oh, I like that better, let me just replace my patch with that.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/wip.cleanup
> 
> Should have your patch instead of mine for the FIXED_CTR_CTRL and have
> the pmu methods in the right place.

Thanks. I will do more test today with the updated branch.

Thanks,
Kan

