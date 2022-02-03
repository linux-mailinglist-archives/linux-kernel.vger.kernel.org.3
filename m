Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC04A7E86
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 05:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349269AbiBCEAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 23:00:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:10261 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbiBCD7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643860795; x=1675396795;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZYA57xTbdJSnrx2D/xliMGotRPM9NQFUEpYWCzlWsRA=;
  b=VscWcCuin4AzDLUTgMZkhemyCyvSVWO4zcGwG0qhXWvatBalwK14ArVa
   jpz7luKY0RIJW/mljaQms92LH+kMb8r16QLfr8k5jETKu+JqkWJW+cHtl
   Cq6X7SIn0N/FqfP8yA4/DgQcX11fJAgq1Gyz4aOrNmIoY8yJ0GWyjcWDW
   X7zkhZB5VjeMpPwvkkgUcL/J5hwFLXjy2b63jG3X0sOWX0eWvXCteBnpx
   +p2+P3Q3MQOeoHWN/61Fqrq7/XfomTZERVV5/ZubBIpK4ae2fpk86v/PO
   H+A1flYmNZ2MPYCa1EFkaejIhIK4dPYeGjWJqECAyUInUq25UR10efq3O
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235471461"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="235471461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:59:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="631213682"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.76.239]) ([10.209.76.239])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:59:52 -0800
Message-ID: <ac97246f-0dbe-6118-dab6-dbc562e3c82c@linux.intel.com>
Date:   Wed, 2 Feb 2022 19:59:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] perf metrics: Add literal for system TSC frequency
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>, vineet.singh@intel.com,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        asaf.yaffe@intel.com, kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20220203010746.610494-1-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220203010746.610494-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/2022 5:07 PM, Ian Rogers wrote:
> Such a literal is useful to calculate things like the average frequency
> [1]. The TSC frequency isn't exposed by sysfs although some experimental
> drivers look to add it [2]. This change computes the value using the
> frequency in /proc/cpuinfo which is accruate at least on Intel
> processors.

FWIW the information in /proc/cpuinfo is going away.

You should really use CPUID for this, which has a new leaf for this. 
Unfortunately there

were a few systems were it was inaccurate, but I suppose you could still 
prefer /proc/cpuinfo

Also your method will not work when the metrics are used through perf 
stat report or perf script

and run on another system. For the perf script case there is support for 
putting the TSC into

perf.data (that is needed for PT), but the header is not dumped by 
default unfortunately.

So likely you would need some new mechanism for that.

-Andi

