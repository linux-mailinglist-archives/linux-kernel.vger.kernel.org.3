Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340054B8B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiBPOVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:21:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiBPOV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:21:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E690265514
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22408618CA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356F6C004E1;
        Wed, 16 Feb 2022 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645021274;
        bh=OIOfydG+W8At/Cke+P/C0ORx7P52hAsyWQXnEy6XZts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tslxXkakSAeDBz23ul7wQXfZZnmLcOVxx7DSUp0FKUH5dMPIFVdgT00DuHE7ZsIrw
         lgbmWzt9sYkF5XZCn//7c0D/cs9uPCjwxFryGUftlrmlY/8rvGAjQhFI1mJRu/BKBg
         aHuLWPg/r05ZMrZe5UjFs4M7lrRSvCSj3CEBqAuZ7NSl8xvzoEW0bEjPNKv+kPs0Q5
         2OwyOIaMQXr0cdqtHdW1lStlhKmc4i3V++mCNaZhONx6rrsf9veCcSpQo1hoNvqzsr
         iFdL44IOcy8iB63dk5wjghB+qa8RiXgkclRKB0K8eYE1bwBo70gXO+goUyTvBsFy66
         S/VHouiGiKWTA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C6D0400FE; Wed, 16 Feb 2022 11:21:12 -0300 (-03)
Date:   Wed, 16 Feb 2022 11:21:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com
Subject: Re: [PATCH v6 12/12] perf report: add addr_from/addr_to sort
 dimensions
Message-ID: <Yg0IWIjgpRcb8bZX@kernel.org>
References: <20220208211637.2221872-1-eranian@google.com>
 <20220208211637.2221872-13-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208211637.2221872-13-eranian@google.com>
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

Em Tue, Feb 08, 2022 at 01:16:37PM -0800, Stephane Eranian escreveu:
> With the existing symbol_from/symbol_to, branches captured in the same
> function would be collapsed into a single function if the latencies associated
> with the each branch (cycles) were all the same.  That is the case on Intel
> Broadwell, for instance. Since Intel Skylake, the latency is captured by
> hardware and therefore is used to disambiguate branches.
> 
> Add addr_from/addr_to sort dimensions to sort branches based on their
> addresses and not the function there are in. The output is still the function
> name but the offset within the function is provided to uniquely identify each
> branch.  These new sort dimensions also help with annotate because they create
> different entries in the histogram which, in turn, generates proper branch
> annotations.
> 
> Here is an example using AMD's branch sampling:

This can be cherry picked from this patchset, I'll try to do it now, and
also add the above explanation for the new sort dimensions to:

tools/perf/Documentation/perf-report.txt

Please update the documentation in the future when adding new sort
dimensions.

Thanks,

- Arnaldo
 
> $ perf record -a -b -c 1000037 -e cpu/branch-brs/ test_prg
> 
> $ perf report
> Samples: 6M of event 'cpu/branch-brs/', Event count (approx.): 6901276
> Overhead  Command          Source Shared Object  Source Symbol                                   Target Symbol                                   Basic Block Cycle
>   99.65%  test_prg	   test_prg              [.] test_thread                                 [.] test_thread                                 -
>    0.02%  test_prg         [kernel.vmlinux]      [k] asm_sysvec_apic_timer_interrupt             [k] error_entry                                 -
> 
> $ perf report -F overhead,comm,dso,addr_from,addr_to
> Samples: 6M of event 'cpu/branch-brs/', Event count (approx.): 6901276
> Overhead  Command          Shared Object     Source Address          Target Address
>    4.22%  test_prg         test_prg          [.] test_thread+0x3c    [.] test_thread+0x4
>    4.13%  test_prg         test_prg          [.] test_thread+0x4     [.] test_thread+0x3a
>    4.09%  test_prg         test_prg          [.] test_thread+0x3a    [.] test_thread+0x6
>    4.08%  test_prg         test_prg          [.] test_thread+0x2     [.] test_thread+0x3c
>    4.06%  test_prg         test_prg          [.] test_thread+0x3e    [.] test_thread+0x2
>    3.87%  test_prg         test_prg          [.] test_thread+0x6     [.] test_thread+0x38
>    3.84%  test_prg         test_prg          [.] test_thread         [.] test_thread+0x3e
>    3.76%  test_prg         test_prg          [.] test_thread+0x1e    [.] test_thread
>    3.76%  test_prg         test_prg          [.] test_thread+0x38    [.] test_thread+0x8
>    3.56%  test_prg         test_prg          [.] test_thread+0x22    [.] test_thread+0x1e
>    3.54%  test_prg         test_prg          [.] test_thread+0x8     [.] test_thread+0x36
>    3.47%  test_prg         test_prg          [.] test_thread+0x1c    [.] test_thread+0x22
>    3.45%  test_prg         test_prg          [.] test_thread+0x36    [.] test_thread+0xa
>    3.28%  test_prg         test_prg          [.] test_thread+0x24    [.] test_thread+0x1c
>    3.25%  test_prg         test_prg          [.] test_thread+0xa     [.] test_thread+0x34
>    3.24%  test_prg         test_prg          [.] test_thread+0x1a    [.] test_thread+0x24
>    3.20%  test_prg         test_prg          [.] test_thread+0x34    [.] test_thread+0xc
>    3.04%  test_prg         test_prg          [.] test_thread+0x26    [.] test_thread+0x1a
>    3.01%  test_prg         test_prg          [.] test_thread+0xc     [.] test_thread+0x32
>    2.98%  test_prg         test_prg          [.] test_thread+0x18    [.] test_thread+0x26
>    2.94%  test_prg         test_prg          [.] test_thread+0x32    [.] test_thread+0xe
>    2.76%  test_prg         test_prg          [.] test_thread+0x28    [.] test_thread+0x18
>    2.73%  test_prg         test_prg          [.] test_thread+0xe     [.] test_thread+0x30
>    2.67%  test_prg         test_prg          [.] test_thread+0x30    [.] test_thread+0x10
>    2.67%  test_prg         test_prg          [.] test_thread+0x16    [.] test_thread+0x28
>    2.46%  test_prg         test_prg          [.] test_thread+0x10    [.] test_thread+0x2e
>    2.44%  test_prg         test_prg          [.] test_thread+0x2a    [.] test_thread+0x16
>    2.38%  test_prg         test_prg          [.] test_thread+0x14    [.] test_thread+0x2a
>    2.32%  test_prg         test_prg          [.] test_thread+0x2e    [.] test_thread+0x12
>    2.28%  test_prg         test_prg          [.] test_thread+0x12    [.] test_thread+0x2c
>    2.16%  test_prg         test_prg          [.] test_thread+0x2c    [.] test_thread+0x14
>    0.02%  test_prg         [kernel.vmlinux]  [k] asm_sysvec_apic_ti+0x5  [k] error_entry
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/hist.c |   2 +
>  tools/perf/util/hist.h |   2 +
>  tools/perf/util/sort.c | 128 +++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/sort.h |   2 +
>  4 files changed, 134 insertions(+)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 0a8033b09e28..1c085ab56534 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -124,6 +124,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  		} else {
>  			symlen = unresolved_col_width + 4 + 2;
>  			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
> +			hists__new_col_len(hists, HISTC_ADDR_FROM, symlen);
>  			hists__set_unres_dso_col_len(hists, HISTC_DSO_FROM);
>  		}
>  
> @@ -138,6 +139,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  		} else {
>  			symlen = unresolved_col_width + 4 + 2;
>  			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
> +			hists__new_col_len(hists, HISTC_ADDR_TO, symlen);
>  			hists__set_unres_dso_col_len(hists, HISTC_DSO_TO);
>  		}
>  
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 2a15e22fb89c..7ed4648d2fc2 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -77,6 +77,8 @@ enum hist_column {
>  	HISTC_GLOBAL_INS_LAT,
>  	HISTC_LOCAL_P_STAGE_CYC,
>  	HISTC_GLOBAL_P_STAGE_CYC,
> +	HISTC_ADDR_FROM,
> +	HISTC_ADDR_TO,
>  	HISTC_NR_COLS, /* Last entry */
>  };
>  
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 2da081ef532b..6d5588e80935 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -990,6 +990,128 @@ struct sort_entry sort_sym_to = {
>  	.se_width_idx	= HISTC_SYMBOL_TO,
>  };
>  
> +static int _hist_entry__addr_snprintf(struct map_symbol *ms,
> +				     u64 ip, char level, char *bf, size_t size,
> +				     unsigned int width)
> +{
> +	struct symbol *sym = ms->sym;
> +	struct map *map = ms->map;
> +	size_t ret = 0, offs;
> +
> +	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
> +	if (sym && map) {
> +		if (sym->type == STT_OBJECT) {
> +			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
> +			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
> +					ip - map->unmap_ip(map, sym->start));
> +		} else {
> +			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
> +					       width - ret,
> +					       sym->name);
> +			offs = ip - sym->start;
> +			if (offs)
> +				ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx", offs);
> +		}
> +	} else {
> +		size_t len = BITS_PER_LONG / 4;
> +		ret += repsep_snprintf(bf + ret, size - ret, "%-#.*llx",
> +				       len, ip);
> +	}
> +
> +	return ret;
> +}
> +
> +static int hist_entry__addr_from_snprintf(struct hist_entry *he, char *bf,
> +					 size_t size, unsigned int width)
> +{
> +	if (he->branch_info) {
> +		struct addr_map_symbol *from = &he->branch_info->from;
> +
> +		return _hist_entry__addr_snprintf(&from->ms, from->al_addr,
> +						 he->level, bf, size, width);
> +	}
> +
> +	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
> +}
> +
> +static int hist_entry__addr_to_snprintf(struct hist_entry *he, char *bf,
> +				       size_t size, unsigned int width)
> +{
> +	if (he->branch_info) {
> +		struct addr_map_symbol *to = &he->branch_info->to;
> +
> +		return _hist_entry__addr_snprintf(&to->ms, to->al_addr,
> +						 he->level, bf, size, width);
> +	}
> +
> +	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
> +}
> +
> +static int64_t
> +sort__addr_from_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	struct addr_map_symbol *from_l;
> +	struct addr_map_symbol *from_r;
> +	int64_t ret;
> +
> +	if (!left->branch_info || !right->branch_info)
> +		return cmp_null(left->branch_info, right->branch_info);
> +
> +	from_l = &left->branch_info->from;
> +	from_r = &right->branch_info->from;
> +
> +	/*
> +	 * comparing symbol address alone is not enough since it's a
> +	 * relative address within a dso.
> +	 */
> +	ret = _sort__dso_cmp(from_l->ms.map, from_r->ms.map);
> +	if (ret != 0)
> +		return ret;
> +
> +	return _sort__addr_cmp(from_l->addr, from_r->addr);
> +}
> +
> +static int64_t
> +sort__addr_to_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	struct addr_map_symbol *to_l;
> +	struct addr_map_symbol *to_r;
> +	int64_t ret;
> +
> +	if (!left->branch_info || !right->branch_info)
> +		return cmp_null(left->branch_info, right->branch_info);
> +
> +	to_l = &left->branch_info->to;
> +	to_r = &right->branch_info->to;
> +
> +	/*
> +	 * comparing symbol address alone is not enough since it's a
> +	 * relative address within a dso.
> +	 */
> +	ret = _sort__dso_cmp(to_l->ms.map, to_r->ms.map);
> +	if (ret != 0)
> +		return ret;
> +
> +	return _sort__addr_cmp(to_l->addr, to_r->addr);
> +}
> +
> +struct sort_entry sort_addr_from = {
> +	.se_header	= "Source Address",
> +	.se_cmp		= sort__addr_from_cmp,
> +	.se_snprintf	= hist_entry__addr_from_snprintf,
> +	.se_filter	= hist_entry__sym_from_filter, /* shared with sym_from */
> +	.se_width_idx	= HISTC_ADDR_FROM,
> +};
> +
> +struct sort_entry sort_addr_to = {
> +	.se_header	= "Target Address",
> +	.se_cmp		= sort__addr_to_cmp,
> +	.se_snprintf	= hist_entry__addr_to_snprintf,
> +	.se_filter	= hist_entry__sym_to_filter, /* shared with sym_to */
> +	.se_width_idx	= HISTC_ADDR_TO,
> +};
> +
> +
>  static int64_t
>  sort__mispredict_cmp(struct hist_entry *left, struct hist_entry *right)
>  {
> @@ -1893,6 +2015,8 @@ static struct sort_dimension bstack_sort_dimensions[] = {
>  	DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
>  	DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
>  	DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
> +	DIM(SORT_ADDR_FROM, "addr_from", sort_addr_from),
> +	DIM(SORT_ADDR_TO, "addr_to", sort_addr_to),
>  };
>  
>  #undef DIM
> @@ -3126,6 +3250,10 @@ static bool get_elide(int idx, FILE *output)
>  		return __get_elide(symbol_conf.dso_from_list, "dso_from", output);
>  	case HISTC_DSO_TO:
>  		return __get_elide(symbol_conf.dso_to_list, "dso_to", output);
> +	case HISTC_ADDR_FROM:
> +		return __get_elide(symbol_conf.sym_from_list, "addr_from", output);
> +	case HISTC_ADDR_TO:
> +		return __get_elide(symbol_conf.sym_to_list, "addr_to", output);
>  	default:
>  		break;
>  	}
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index f994261888e1..2ddc00d1c464 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -251,6 +251,8 @@ enum sort_type {
>  	SORT_SRCLINE_FROM,
>  	SORT_SRCLINE_TO,
>  	SORT_SYM_IPC,
> +	SORT_ADDR_FROM,
> +	SORT_ADDR_TO,
>  
>  	/* memory mode specific sort keys */
>  	__SORT_MEMORY_MODE,
> -- 
> 2.35.0.263.gb82422642f-goog

-- 

- Arnaldo
