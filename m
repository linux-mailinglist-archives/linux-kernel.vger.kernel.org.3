Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C8B4B8B36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiBPOSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:18:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbiBPOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:18:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFDE1B4453
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:17:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55DBBB81EDA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D259DC004E1;
        Wed, 16 Feb 2022 14:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645021076;
        bh=25WzSdKtFWUOysZRmxAVLJb+CZcoj//JQjD1ChtvlNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyFpMMkNVLu4oQG+tcrjlS2O0c2RGmmc4jAVRHRX5cJ49S+5KlwgUSg/lLw9i9VBR
         HUZ19T20xf6Gz9tIkghUYrISocVbfAc6avwO0iW0IIn4woxVv4fpB7TgnBqQpg9Ql/
         rN6ipK0H5Ho69WPqVD5vCUqiimT4J0ro7y2Q1TsXIeU41wgXMMuuBoS4bpc07BxAWU
         s5YS8X4pctUsVoUtjTSNf1zk4HsIKuKq9AzpvPzsuyX4LJ/qmJqLZfVNpZO1iYhjUU
         M8GhgX/WjCrk8RGG85ZrpIoEx5yTfznHJYwK0ImDp4VfYbmmPCFx8SFAnOZgj2YWZv
         +FRa8oCRY6MZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B4732400FE; Wed, 16 Feb 2022 11:17:53 -0300 (-03)
Date:   Wed, 16 Feb 2022 11:17:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com
Subject: Re: [PATCH v6 11/12] perf tools: Improve error handling of AMD
 Branch Sampling
Message-ID: <Yg0HkUzDlkD4nqNs@kernel.org>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-12-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220208211637.2221872-12-eranian@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 08, 2022 at 01:16:36PM -0800, Stephane Eranian escreveu:
> Improve the error message printed by perf when perf_event_open() fails on
> AMD Zen3 when using the branch sampling feature. In the case of EINVAL, there
> are two main reasons: frequency mode or period is smaller than the depth of
> the branch sampling buffer (16). The patch checks the parameters of the call
> and tries to print a relevant message to explain the error:
> 
> $ perf record -b -e cpu/branch-brs/ -c 10 ls
> Error:
> AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.
> 
> $ perf record -b -e cpu/branch-brs/ ls
> Error:
> AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> [Rebased on commit 9fe8895a27a84 ("perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings")]
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  tools/perf/util/evsel.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d42f63a484df..7311e7b4d34d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2857,6 +2857,12 @@ static bool is_amd_ibs(struct evsel *evsel)
>  	return evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3);
>  }
>  
> +static bool is_amd_brs(struct evsel *evsel)
> +{
> +	return ((evsel->core.attr.config & 0xff) == 0xc4) &&
> +	       (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_STACK);
> +}
> +

Well, this assumes we're on x86_64, right? Shouldn't we have some extra
condition using perf_env routines to check we're on x86_64.

Did a quick check and powerpc also supports PERF_SAMPLE_BRANCH_STACK

⬢[acme@toolbox perf]$ find arch/ -name "*.c" | xargs grep PERF_SAMPLE_BRANCH_STACK
arch/powerpc/perf/core-book3s.c:		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
arch/x86/events/intel/ds.c:	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
arch/x86/events/intel/ds.c:					PERF_SAMPLE_BRANCH_STACK |
arch/x86/events/intel/lbr.c: * in PERF_SAMPLE_BRANCH_STACK sample may vary.
arch/x86/kvm/vmx/pmu_intel.c:	 * - set 'sample_type = PERF_SAMPLE_BRANCH_STACK' and
arch/x86/kvm/vmx/pmu_intel.c:		.sample_type = PERF_SAMPLE_BRANCH_STACK,
⬢[acme@toolbox perf]$

arch/powerpc/perf/core-book3s.c:

                if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
                        struct cpu_hw_events *cpuhw;
                        cpuhw = this_cpu_ptr(&cpu_hw_events);
                        power_pmu_bhrb_read(event, cpuhw);
                        data.br_stack = &cpuhw->bhrb_stack;
                }

>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			 int err, char *msg, size_t size)
>  {
> @@ -2971,6 +2977,14 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  					return scnprintf(msg, size,
>  	"AMD IBS may only be available in system-wide/per-cpu mode.  Try using -a, or -C and workload affinity");
>  			}
> +			if (is_amd_brs(evsel)) {
> +				if (evsel->core.attr.freq)
> +					return scnprintf(msg, size,
> +	"AMD Branch Sampling does not support frequency mode sampling, must pass a fixed sampling period via -c option or cpu/branch-brs,period=xxxx/.");
> +				/* another reason is that the period is too small */
> +				return scnprintf(msg, size,
> +	"AMD Branch Sampling does not support sampling period smaller than what is reported in /sys/devices/cpu/caps/branches.");
> +			}
>  		}
>  
>  		break;
> -- 
> 2.35.0.263.gb82422642f-goog

-- 

- Arnaldo
