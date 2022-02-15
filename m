Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663954B6EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiBOOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:18:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiBOOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:18:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC9B10A4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644934705; x=1676470705;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=2TDzB3yc1DJv1eV3LSYJMenEIhdyiLvMYtVL3TmCuCI=;
  b=gWoChOgYNERfIGixpDU9gcB1BGiiIUW7Fqu6mJYqTcJw+DW75FDtbV/l
   1ToK4u+ppccvR/kLuJu0pryvmuuSyjNRauopPI/3M+CTwNnQnV21MvmEu
   zqZ7rwhDEvWwOaBr3qK1I0NDdhMwd/O0T2YVkUTMfTfQxGyCLALphhuqH
   NneWGdW/OsTFpqZvdmy2ik68vYIyHpKjknoPwlEuh1YxCMRtkulCJ7Gln
   2Mm7EIMADfDOpFuoLYPH/jmWHnf1t/VFr2+vuSU2cwdtd+zIXeBszlzuX
   PE6R5d7l6uAihgU8ojI3x/UbmBlJmRQQ1A85R1DZSMlZ1tp8CElzfSc3R
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="249193231"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="249193231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:18:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="539329743"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2022 06:18:13 -0800
Message-ID: <e31c10a2-0985-af6d-e4cd-0e7ad95fdb31@intel.com>
Date:   Tue, 15 Feb 2022 16:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing
 and TNT disabling
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
References: <20220126104815.2807416-1-adrian.hunter@intel.com>
 <dc5342b7-97d4-23c0-a093-1ba2dfec5ee7@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <dc5342b7-97d4-23c0-a093-1ba2dfec5ee7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2022 08:28, Adrian Hunter wrote:
> On 26/01/2022 12:48, Adrian Hunter wrote:
>> Hi
>>
>> As of Intel SDM (https://www.intel.com/sdm) version 076, there are 2 new
>> Intel PT features called Event Trace and TNT-Disable.
>>
>> Event Trace exposes details about asynchronous events such as interrupts
>> and VM-Entry/Exit.
>>
>> TNT-Disable disables TNT packets to reduce the tracing overhead, but with
>> the result that exact control flow information is lost.
>>
>> Tools patches are being sent in a separate patch set, but can be found
>> here:
>>
>> 	https://github.com/ahunter6/linux/tree/event-trace
>>
>>
>> Changes in V2:
>>
>> 	Add my SOB
> 
> Ping

Any comments on these patches?

> 
> 
>>
>>
>> Alexander Shishkin (2):
>>       perf/x86/intel/pt: Add a capability and config bit for event tracing
>>       perf/x86/intel/pt: Add a capability and config bit for disabling TNTs
>>
>>  arch/x86/events/intel/pt.c       | 16 ++++++++++++++++
>>  arch/x86/include/asm/intel_pt.h  |  2 ++
>>  arch/x86/include/asm/msr-index.h |  2 ++
>>  3 files changed, 20 insertions(+)
>>
>>
>> Regards
>> Adrian 
>>
> 

