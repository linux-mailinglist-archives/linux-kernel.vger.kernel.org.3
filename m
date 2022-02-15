Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB54B71BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiBOPrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:47:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiBOPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:45:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE8123BD2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644939662; x=1676475662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QV2lpkZ1uoeX6MQ6u1abca3syu0nEO8PCNGkVo6xNn8=;
  b=IVxYpOEkOnnQv3WyV+EjQIZFCnmjOR9St01j6y03v3nAk9Je/lbTrQ5g
   bkPLMGt7XyKErTk4U+/DoVgfV8qpbZTB/Kc+Lm6Lx9BVbKOVghY3fpkbR
   7kg/78MbDJVLcevJNimKy+UVNcCIylbemckhh1gldsQX61rsy8xpdMJIe
   fMnS113aMZJlP+gJWwnNyuU6kcFH3lZP23P8dh/0HQmZxTpL0QAFPmMQf
   cF0/3R9W4Pt30R2y4zjhacFQBuW3JEgSO5WyBn/fnMoxp4GHJnerYhCch
   HYF3Nlj3GiQQnNZbFWzZz8zAbXHRc+/K/Z5LcYRfKq7wiT96zan77AnoG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250320820"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250320820"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 07:40:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="539378825"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2022 07:40:46 -0800
Message-ID: <f2c2389e-db62-c307-b5d7-6a8d9df70b7e@intel.com>
Date:   Tue, 15 Feb 2022 17:40:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing
 and TNT disabling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
References: <20220126104815.2807416-1-adrian.hunter@intel.com>
 <YgvIJop34KuyUIx6@hirez.programming.kicks-ass.net>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <YgvIJop34KuyUIx6@hirez.programming.kicks-ass.net>
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

On 15/02/2022 17:35, Peter Zijlstra wrote:
> On Wed, Jan 26, 2022 at 12:48:13PM +0200, Adrian Hunter wrote:
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
> 
> What's a TNT?

The TNT packet indicates whether conditional branches were taken
or not taken.
