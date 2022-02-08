Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605E54AD187
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347318AbiBHG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiBHG2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:28:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D0C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 22:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644301732; x=1675837732;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yNaPz/gyRdt0tGsQijXVGSZ9IZW4oWjqhsRDzA7wKSs=;
  b=V87kfiD4BXhBfV4kTi/bJ+9sUywpP3IB78O0BzZvrEY0vcHiiX6dwwHc
   hI7ZrTc1ZCDSnkpNeHRMH4bqVwERdy3yADjx8NPGCMbjcNwXpaY8Xj8ky
   +ef3pNyzkPy8wy7FhWpQYn9/8eteGe6f+v0vMEi1vGPynyCfxZ4Wnvi44
   MiR7wqGVfHsFSzXHyKpfCdtZgrRLZzngovzONrQj3fMMlvISSyOpPVibY
   3z/L00biRNrLnmJy9Zbqkgjg8MJyUPU6rCfYcjOQHTqsyGXx+Rj4m42GG
   UIN3rvJTsXS+VicMNpcL88UL8M+VXF8QcITLkWRBqgH3xA4jKAExlABph
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248831772"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248831772"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 22:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="632742045"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2022 22:28:48 -0800
Subject: Re: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing
 and TNT disabling
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
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <dc5342b7-97d4-23c0-a093-1ba2dfec5ee7@intel.com>
Date:   Tue, 8 Feb 2022 08:28:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126104815.2807416-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 12:48, Adrian Hunter wrote:
> Hi
> 
> As of Intel SDM (https://www.intel.com/sdm) version 076, there are 2 new
> Intel PT features called Event Trace and TNT-Disable.
> 
> Event Trace exposes details about asynchronous events such as interrupts
> and VM-Entry/Exit.
> 
> TNT-Disable disables TNT packets to reduce the tracing overhead, but with
> the result that exact control flow information is lost.
> 
> Tools patches are being sent in a separate patch set, but can be found
> here:
> 
> 	https://github.com/ahunter6/linux/tree/event-trace
> 
> 
> Changes in V2:
> 
> 	Add my SOB

Ping


> 
> 
> Alexander Shishkin (2):
>       perf/x86/intel/pt: Add a capability and config bit for event tracing
>       perf/x86/intel/pt: Add a capability and config bit for disabling TNTs
> 
>  arch/x86/events/intel/pt.c       | 16 ++++++++++++++++
>  arch/x86/include/asm/intel_pt.h  |  2 ++
>  arch/x86/include/asm/msr-index.h |  2 ++
>  3 files changed, 20 insertions(+)
> 
> 
> Regards
> Adrian 
> 

