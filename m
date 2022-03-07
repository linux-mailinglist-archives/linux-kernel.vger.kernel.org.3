Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46084D0449
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiCGQky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244253AbiCGQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:40:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89D52B08;
        Mon,  7 Mar 2022 08:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29630610A3;
        Mon,  7 Mar 2022 16:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521C3C340EB;
        Mon,  7 Mar 2022 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646671194;
        bh=CR3H+PJ5LIHoZfHg5BxqH2Z0JF+bZ+Y8Zs1kn0/J9aE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcHkb6q0B5fScFbjad4R1HhhdrOUswR1p4UPLjOVRwyGrUYm5HQEkgagTPrYWiUJ2
         gMoLHedwj1S/SADqicNmtAMS5t59ap/fOSDd71auy288Ju+16EyMOqUUGSoy0IDvpQ
         ++OoE4oNrhuEZamrT+s3RiJIMekFXbQRdPZYDW0X3VyirmvVsLIq3Ul4qJFZ4citzU
         yXSX4outrAL24CIG5thqyS6Fdz111qy63793pHyNTJYsst1PXjTuLxSeZPc5pDqJpe
         ly5bh4YolEqsnzTHmoHUQMhfJwM81XwyL3X6ZHI83IU97/LK+e2c1B5SG/RD+PJB/9
         MJq+Y0NmEW5MQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E619B403C8; Mon,  7 Mar 2022 13:39:50 -0300 (-03)
Date:   Mon, 7 Mar 2022 13:39:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, zhengjun.xing@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Subject: Re: [PATCH] perf parse: Fix event parser error for hybrid systems
Message-ID: <YiY1VnHi4VnLMaCi@kernel.org>
References: <20220307151627.30049-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307151627.30049-1-zhengjun.xing@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 07, 2022 at 11:16:27PM +0800, zhengjun.xing@linux.intel.com escreveu:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> This bug happened on hybrid systems when both cpu_core and cpu_atom
> have the same event name such as "UOPS_RETIRED.MS" while their event
> terms are different, then during perf stat, the event for cpu_atom
> will parse fail and then no output for cpu_atom.

Ian,

	since this patch fixes a patch from you, can you take a look?

- Arnaldo
 
> UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
> UOPS_RETIRED.MS -> cpu_atom/period=0x1e8483,umask=0x1,event=0xc2/
> 
> It is because event terms in the "head" of parse_events_multi_pmu_add
> will be changed to event terms for cpu_core after parsing UOPS_RETIRED.MS
> for cpu_core, then when parsing the same event for cpu_atom, it still
> uses the event terms for cpu_core, but event terms for cpu_atom are
> different with cpu_core, the event parses for cpu_atom will fail. This
> patch fixes it, the event terms should be parsed from the original
> event.
> 
> This patch can work for the hybrid systems that have the same event
> in more than 2 PMUs. It also can work in non-hybrid systems.
> 
> Before:
> 
>  #perf stat -v  -e  UOPS_RETIRED.MS  -a sleep 1
> 
> Using CPUID GenuineIntel-6-97-1
> UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
> Control descriptor is not initialized
> UOPS_RETIRED.MS: 2737845 16068518485 16068518485
> 
>  Performance counter stats for 'system wide':
> 
>          2,737,845      cpu_core/UOPS_RETIRED.MS/
> 
>        1.002553850 seconds time elapsed
> 
> After:
> 
>  #perf stat -v  -e  UOPS_RETIRED.MS  -a sleep 1
> 
> Using CPUID GenuineIntel-6-97-1
> UOPS_RETIRED.MS -> cpu_core/period=0x1e8483,umask=0x4,event=0xc2,frontend=0x8/
> UOPS_RETIRED.MS -> cpu_atom/period=0x1e8483,umask=0x1,event=0xc2/
> Control descriptor is not initialized
> UOPS_RETIRED.MS: 1977555 16076950711 16076950711
> UOPS_RETIRED.MS: 568684 8038694234 8038694234
> 
>  Performance counter stats for 'system wide':
> 
>          1,977,555      cpu_core/UOPS_RETIRED.MS/
>            568,684      cpu_atom/UOPS_RETIRED.MS/
> 
>        1.004758259 seconds time elapsed
> 
> Fixes: fb0811535e92c6c1 ("perf parse-events: Allow config on kernel PMU events")
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  tools/perf/util/parse-events.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9739b05b999e..8bf7f914ea0e 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1648,6 +1648,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  {
>  	struct parse_events_term *term;
>  	struct list_head *list = NULL;
> +	struct list_head *orig_head = NULL;
>  	struct perf_pmu *pmu = NULL;
>  	int ok = 0;
>  	char *config;
> @@ -1674,7 +1675,6 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  	}
>  	list_add_tail(&term->list, head);
>  
> -
>  	/* Add it for all PMUs that support the alias */
>  	list = malloc(sizeof(struct list_head));
>  	if (!list)
> @@ -1687,13 +1687,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  
>  		list_for_each_entry(alias, &pmu->aliases, list) {
>  			if (!strcasecmp(alias->name, str)) {
> +				parse_events_copy_term_list(head, &orig_head);
>  				if (!parse_events_add_pmu(parse_state, list,
> -							  pmu->name, head,
> +							  pmu->name, orig_head,
>  							  true, true)) {
>  					pr_debug("%s -> %s/%s/\n", str,
>  						 pmu->name, alias->str);
>  					ok++;
>  				}
> +				parse_events_terms__delete(orig_head);
>  			}
>  		}
>  	}
> -- 
> 2.25.1

-- 

- Arnaldo
