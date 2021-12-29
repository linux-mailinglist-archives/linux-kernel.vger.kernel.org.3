Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC04811A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbhL2KWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:22:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:48779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhL2KWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:22:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="228804415"
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="228804415"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 02:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,245,1635231600"; 
   d="scan'208";a="486575593"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 29 Dec 2021 02:22:31 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.32])
        by linux.intel.com (Postfix) with ESMTP id DCF5C5802B1;
        Wed, 29 Dec 2021 02:22:29 -0800 (PST)
Message-ID: <2e5cd069996b1abb477eb4e817391db6f9bfa097.camel@gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Update EPP for AlderLake mobile
From:   Artem Bityutskiy <dedekind1@gmail.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        lenb@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 29 Dec 2021 12:22:28 +0200
In-Reply-To: <20211216183305.3152807-1-srinivas.pandruvada@linux.intel.com>
References: <20211216183305.3152807-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-16 at 10:33 -0800, Srinivas Pandruvada wrote:
> There is an expectation from users that they can get frequency specified
> by cpufreq/cpuinfo_max_freq when conditions permit. But with AlderLake
> mobile it may not be possible. This is possible that frequency is clipped
> based on the system power-up EPP value. In this case users can update
> cpufreq/energy_performance_preference to some performance oriented EPP to
> limit clipping of frequencies.
> 
> To get out of box behavior as the prior generations of CPUs, update EPP
> for AlderLake mobile CPUs on boot. On prior generations of CPUs EPP = 128
> was enough to get maximum frequency, but with AlderLake mobile the
> equivalent EPP is 102. Since EPP is model specific, this is possible that
> they have different meaning on each generation of CPU.
> 
> The current EPP string "balance_performance" corresponds to EPP = 128.
> Change the EPP corresponding to "balance_performance" to 102 for only
> AlderLake mobile CPUs and update this on each CPU during boot.
> 
> To implement reuse epp_values[] array and update the modified EPP at the
> index for BALANCE_PERFORMANCE. Add a dummy EPP_INDEX_DEFAULT to
> epp_values[] to match indexes in the energy_perf_strings[].
> 
> After HWP PM is enabled also update EPP when "balance_performance" is
> redefined for the very first time after the boot on each CPU. On
> subsequent suspend/resume or offline/online the old EPP is restored,
> so no specific action is needed.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


I think this patch alone makes things a bit inconsistent, because the
'x86_energy_perf_policy' does not get adjusted.

Ideally, constants like HWP_EPP_BALANCE_PERFORMANCE should go away from
arch/x86/include/asm/msr-index.h, along with all users.

Artem.

