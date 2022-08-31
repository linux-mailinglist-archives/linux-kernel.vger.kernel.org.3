Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F010D5A80FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiHaPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHaPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 11:13:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2972D5981;
        Wed, 31 Aug 2022 08:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661958802; x=1693494802;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Yf2gNNoFyU0e/oBX5JjGSbyHp3Rxy0ZZcWvgHdfDez4=;
  b=Ao1HR0iH1FUcghu+dUP31ArQ609HtLfZ3mIMRYWzw91nCkBMYb8xv7t0
   qcTFwdoV6ynnvQ6Mhyh42kn7XL1IczqOumCWB7NfuBm254GMHkvXkhLSa
   zOMLwNDSh8aexnEKb+SsF8577PfQLtInzysN94UUNxu4+xtZ3lGoQBZSD
   bS/E8zZ1m8kaPiC3+ores/p3sb3ktNC4gYp8XDnoSjYTe8gOcHQpyrwFB
   W5i77wIzi0+5m3w7qncZcrEgnA66MVKUz2dooC8fQYiezIwDwVmiI4o3I
   aQmvU9bqK8BGIkLSlul/7SNEsC7A+Hsq5EdGpCGePaxlimIigdzf1asky
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="381765761"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="381765761"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 08:13:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="738133205"
Received: from aametzl-mobl.amr.corp.intel.com (HELO [10.251.3.56]) ([10.251.3.56])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 08:13:20 -0700
Message-ID: <be281873-7c28-12b4-7eb5-50d08042549f@intel.com>
Date:   Wed, 31 Aug 2022 08:13:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: OpenWrt / MIPS benchmark with MGLRU
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        page-reclaim@google.com
References: <20220815071332.627393-1-yuzhao@google.com>
 <20220831041731.3836322-1-yuzhao@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220831041731.3836322-1-yuzhao@google.com>
Content-Type: text/plain; charset=UTF-8
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

On 8/30/22 21:17, Yu Zhao wrote:
> TLDR
> ====
> RAM utilization  Throughput (95% CI)  P99 Latency (95% CI)
> ----------------------------------------------------------
> ~90%             NS                   NS
> ~110%            +[12, 16]%           -[20, 22]%

I'll give you points for thinking out of the box on this one.  This is a
piece of hardware where both latency and bandwidth theoretically matter.
 I've got a slightly older but similar piece of Ubiquiti hardware with
512MB of RAM.  It doesn't run OpenWRT, fwiw.  Maybe my firmware is a bit
outdated.

*But*, most of the heavy lifting for packet flow on these systems is
done in hardware.  They have some hardware acceleration to be able to
_route_ at gigabit speeds, so they're probably not quite as sensitive to
software hiccups as lower-end routers.

That said, my system at least does not typically have *any* memory
pressure.  Right now, it hasn't even filled free memory with page cache
and it's been up for over a month:

# cat /proc/meminfo
MemTotal:         491552 kB
MemFree:          160188 kB
MemAvailable:     373088 kB
Cached:           151004 kB

I think a better tl;dr would be:

	MGLRU doesn't help much or cause any regressions on this
	hardware.  Under (atypical) synthetic memory pressure, MGLRU did
	show some modest but measurable throughput and latency benefits.

In other words, this provides more of a data point that MGLRU doesn't
hurt medium-ish sized embedded systems.  I think you could make an even
stronger case with even smaller hardware or something that actually sees
memory pressure on a regular basis in the wild.

