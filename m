Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1E58AC7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbiHEOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiHEOqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:46:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E8F5E315;
        Fri,  5 Aug 2022 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659710761; x=1691246761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cW8TOt2AOoJIUa4hQwkY7LnTl78Uw0yQOYwnQjGXAV8=;
  b=bWYsx1kiq0ec+oM1Vtbx9h3lvq6/dMzX37ZANzalKyn+YIm7NgVceFqP
   VPjhL8f6NIzR0amhdBWctDkI4haw2pmsdip4s3RZx6le8krXvmUQkEACO
   cgHHgk3a6NVvaXcS/k9HZeQdSw/VLuy1OGEQ9BUbu+7T8o89lE4MAtSAN
   FLEa6vlCUDYKSOuF40b0MuhfUvqr+PCaxGy03qFXbsaCzTzUpAmC411LS
   2SGG9ylHUDaLHd09NlmZPpFDk4k6G9wboSu3Dy8pVPuaYfPwpvxwLdbve
   8jcPBfiUVUwu2FBscfBAwGfBKSjeO8WAVN5zmXwGwTaL9RyN9k52Z3IVX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="290223341"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="290223341"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 07:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="579519718"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 05 Aug 2022 07:45:34 -0700
Received: from [10.252.214.183] (kliang2-mobl1.ccr.corp.intel.com [10.252.214.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 91701580B9F;
        Fri,  5 Aug 2022 07:45:32 -0700 (PDT)
Message-ID: <3f85d0f9-921f-4f5c-7b5c-8a8e1773512a@linux.intel.com>
Date:   Fri, 5 Aug 2022 10:45:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 0/3] Remove bad uncore filter/events
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, perry.taylor@intel.com,
        caleb.biggers@intel.com, kshipra.bopardikar@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220805013856.1842878-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220805013856.1842878-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-04 9:38 p.m., Ian Rogers wrote:
> The event converter scripts at:
> https://github.com/intel/event-converter-for-linux-perf
> passes Filter values from data on 01.org that is bogus in a perf command
> line and can cause perf to infinitely recurse in parse events. Remove
> such events or filter using the updated patch:
> https://github.com/intel/event-converter-for-linux-perf/pull/15/commits/afd779df99ee41aac646eae1ae5ae651cda3394d
> 
> v3. Removed filters rather than events in some cases as Suggested-by:
>     Liang, Kan <kan.liang@linux.intel.com>
> v2. Manually fixed a broken \\Inbound\\ ivytown event.
> 
> Ian Rogers (3):
>   perf vendor events: Remove bad broadwellde uncore events
>   perf vendor events: Remove bad ivytown uncore events
>   perf vendor events: Remove bad jaketown uncore events
> 

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

>  .../arch/x86/broadwellde/uncore-cache.json    | 97 -------------------
>  .../arch/x86/broadwellde/uncore-other.json    | 13 ---
>  .../arch/x86/ivytown/uncore-cache.json        | 90 -----------------
>  .../arch/x86/ivytown/uncore-interconnect.json |  1 -
>  .../arch/x86/ivytown/uncore-other.json        | 13 ---
>  .../arch/x86/ivytown/uncore-power.json        | 19 ----
>  .../arch/x86/jaketown/uncore-cache.json       | 30 ------
>  .../arch/x86/jaketown/uncore-other.json       | 13 ---
>  .../arch/x86/jaketown/uncore-power.json       | 11 ---
>  9 files changed, 287 deletions(-)
> 
