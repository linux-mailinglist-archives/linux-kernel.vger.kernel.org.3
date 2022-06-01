Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B553A7C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354290AbiFAOCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354394AbiFAOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:00:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D93A5006;
        Wed,  1 Jun 2022 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654091800; x=1685627800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jUqZ7w2WMAE0tbVZTXI0Gl8U5/1ENzxvvW17y8aE7po=;
  b=ethjiQYobhnk61a7Yk0v7zoeTr2OtGogxpgd91NLxNWZVfYdxjkERoDy
   QeiTFQgA8wpa/fsffOozwoEUKPisGhELr84uiIJLAA2c2ZcTzpKm8gjhh
   0h1Kg8Ve86oQTtYaZJumMezZ5dVQMAAX1exV7M6zurkR7yDNkcRirz5H9
   ytsmkrHjKmBvffWVtTu8n1hkbIQMkohXLP5lDeBx8U8CqCuT64g8QX5xg
   ed0mlnleB3VTBNfanIEe+NdGTCprvob3yrctDbQZW/0IAYEpDy8jaDdyB
   jQHBqG3E3P1RSyxYy15wRfNPlPE8ergTUaw7JUd/PkUD5fuBmHAAxMlnG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275604135"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="275604135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="530068655"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2022 06:55:36 -0700
Received: from [10.252.214.178] (kliang2-MOBL.ccr.corp.intel.com [10.252.214.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 66EBD580514;
        Wed,  1 Jun 2022 06:55:33 -0700 (PDT)
Message-ID: <9fa06966-ceec-e48b-677c-c8f2dc8ab20a@linux.intel.com>
Date:   Wed, 1 Jun 2022 09:55:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 2/8] perf tool: Parse pmu caps sysfs only once
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        peterz@infradead.org, rrichter@amd.com, mingo@redhat.com,
        mark.rutland@arm.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, james.clark@arm.com, leo.yan@linaro.org,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
References: <20220601032608.1034-1-ravi.bangoria@amd.com>
 <20220601032608.1034-3-ravi.bangoria@amd.com>
 <47584a6b-20b9-9a3d-3125-d9fe848cea54@linux.intel.com>
 <0c795f97-c582-8059-fcf8-82b43239f0d1@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <0c795f97-c582-8059-fcf8-82b43239f0d1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2022 9:51 AM, Ravi Bangoria wrote:
> Hi Kan,
> 
> [...]
> 
>>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>>> index 541889fa9f9c..4b45fd8da5a3 100644
>>> --- a/tools/perf/util/pmu.h
>>> +++ b/tools/perf/util/pmu.h
>>> @@ -46,6 +46,8 @@ struct perf_pmu {
>>>        struct perf_cpu_map *cpus;
>>>        struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>>>        struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
>>> +    bool caps_initialized;
>>> +    u32 nr_caps;
>>
>> If they are just used for the cache purpose, I don't think we need to add the variables in the struct perf_pmu.
>>
>> A static variable should be good enough. See sysctl__nmi_watchdog_enabled().
> 
> These fields are per pmu. Static variable won't help :) And they are
> used in subsequent patches as well.
> 

Ah, I see. Then the patch looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
