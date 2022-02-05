Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22214AA561
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378921AbiBEBs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:48:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:35553 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378908AbiBEBs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644025706; x=1675561706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bMWYoHZpNgt/lj0gljpMlLFpM3tBiMSU1GkncoSRyo4=;
  b=jmoycHIQ0jscCWxR+oQNK4PgNbQARqFm9lrxzt8SJxXmpMSoXs/EFoVB
   +1kAMHwJPMIiz/wDKETIjFdj3Q6IwRSPO3qXqatGxVZcjpNinJaHjiEAE
   UyaTgkENox4VJvLzzgE43XFMMrT0esysivwQgcsbh0qmWpszKjRrFsA9C
   Q44sJYN0klrmeIPLNHDGb6cu7HzpDI5cWdo53ibt/ERZ50jaBUkWMLmZk
   dNHho5rWgWE7ydTkqy9zuX2oanG2spx+pexd8U3U0epHrtCyv/ISaf6UR
   6AQ/XgWBb0zk7EIbXincfQ5bd0NxKC7NtdaB3L/4Og4AHjzBJyPKsAML6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246062863"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="246062863"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:48:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="539380710"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.19.144]) ([10.209.19.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:48:25 -0800
Message-ID: <e3bf95b1-bb9a-91be-1816-59c96c4e2024@linux.intel.com>
Date:   Fri, 4 Feb 2022 17:48:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] perf stat: Fix display of grouped aliased events.
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
References: <20220205010941.1065469-1-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220205010941.1065469-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/4/2022 5:09 PM, Ian Rogers wrote:
> An event may have a number of uncore aliases that when added to
> the evlist are consecutive. If there are multiple uncore events
> in a group then parse_events__set_leader_for_uncore_aliase will
> reorder the evlist so that events on the same PMU are
> adjacent. collect_all_aliases assumes that aliases are in blocks
> so that only the first counter is printed and all others are
> marked merged. The reordering for groups breaks the assumption
> and so all counts are printed. This change removes the assumption
> from collect_all_aliases that the events are in blocks and
> instead processes the entire evlist.

Looks good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi


