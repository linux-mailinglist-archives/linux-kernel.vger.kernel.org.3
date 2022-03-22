Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1550D4E4805
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiCVVDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbiCVVCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:02:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472B52E0F;
        Tue, 22 Mar 2022 14:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C86DDB81DAB;
        Tue, 22 Mar 2022 21:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404D9C340EE;
        Tue, 22 Mar 2022 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647982875;
        bh=mXcy1351Q+KX/ctUS80CaNY82irKPeqQR5GkcO7LZc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rqryPQpq3tMfs6fciTQ6wuFbdyUwHo7e533740fhC+9QYD5iYeZzJVTdjxnZSZPPE
         SDGiRA42cebAjEEtH9Z52TZjrFpEpZsvuOvsmut3LDPbMOcem8E+hWA69ZN/NbTPAJ
         uLeet+4pdhrukGD8lhS2hO0iA8a+6W8NKYb4BEAbMMbYJkLicn3LBXV40BWwfQNmH3
         xUBGifQhLXxxkZSvxwOPnvUsg3AKFeYQ7rKjVYnumRhtYAjnmQKBQUpVl8HgXFe4lQ
         DVUlOTijR8RW2NuKvOlR4ei8Pu9syb5/LqEdSe85RnvVJVxmp84A4I0oa81PBN5DTU
         cVWBAFrz/+z/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5659940407; Tue, 22 Mar 2022 18:01:12 -0300 (-03)
Date:   Tue, 22 Mar 2022 18:01:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, peterz@infradead.org, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        ahmad.yasin@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [PATCH] perf script: Add 'brstackinsnlen' for branch stacks
Message-ID: <Yjo5GGbRUcnzRoGI@kernel.org>
References: <1647871212-184070-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1647871212-184070-1-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 21, 2022 at 07:00:12AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> When analyzing with the perf script, it's useful to understand the
> captured instruction and the next sequential instruction. To calculate
> the address of the next sequential instruction, the length of the
> captured instruction is required. For example, you can’t know the next
> sequential instruction after an unconditional branch unless you
> calculate that based on its length.
> 
> For branch stacks, the current perf script only prints the instruction
> bytes with 'brstackinsn', but lack of instruction length.
> 
> Add 'brstackinsnlen' to print the instruction length.
> 
> $perf script -F ip,brstackinsn,brstackinsnlen --xed
>      7fa555be8f75
>         _start:
>         00007fa555be8090        mov %rsp, %rdi          ilen: 3
>         00007fa555be8093        callq  0x7fa555be8ea0   ilen: 5 # PRED
> 102 cycles [102] 0.02 IPC
>         _dl_start+38:
>         00007fa555be8ec6        movq  %rdx,0x227853(%rip)       ilen: 7
>         00007fa555be8ecd        leaq  0x227f94(%rip),%rdx       ilen: 7
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

You forgot to update tools/perf/Documentation/perf-script.txt, I added
it this time.

Thanks, applied.

- Arnaldo

> ---
>  tools/perf/builtin-script.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index fa478dd..5a7b2b0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -124,6 +124,7 @@ enum perf_output_field {
>  	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 33,
>  	PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 34,
>  	PERF_OUTPUT_INS_LAT         = 1ULL << 35,
> +	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
>  };
>  
>  struct perf_script {
> @@ -191,6 +192,7 @@ struct output_option {
>  	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
>  	{.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
>  	{.str = "ins_lat", .field = PERF_OUTPUT_INS_LAT},
> +	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
>  };
>  
>  enum {
> @@ -488,7 +490,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
>  		       "selected. Hence, no address to lookup the source line number.\n");
>  		return -EINVAL;
>  	}
> -	if (PRINT_FIELD(BRSTACKINSN) && !allow_user_set &&
> +	if ((PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN)) && !allow_user_set &&
>  	    !(evlist__combined_branch_type(session->evlist) & PERF_SAMPLE_BRANCH_ANY)) {
>  		pr_err("Display of branch stack assembler requested, but non all-branch filter set\n"
>  		       "Hint: run 'perf record -b ...'\n");
> @@ -1122,10 +1124,17 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
>  
>  static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
>  			    struct perf_insn *x, u8 *inbuf, int len,
> -			    int insn, FILE *fp, int *total_cycles)
> +			    int insn, FILE *fp, int *total_cycles,
> +			    struct perf_event_attr *attr)
>  {
> -	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s", ip,
> -			      dump_insn(x, ip, inbuf, len, NULL),
> +	int ilen = 0;
> +	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
> +			      dump_insn(x, ip, inbuf, len, &ilen));
> +
> +	if (PRINT_FIELD(BRSTACKINSNLEN))
> +		printed += fprintf(fp, "ilen: %d\t", ilen);
> +
> +	printed += fprintf(fp, "#%s%s%s%s",
>  			      en->flags.predicted ? " PRED" : "",
>  			      en->flags.mispred ? " MISPRED" : "",
>  			      en->flags.in_tx ? " INTX" : "",
> @@ -1211,7 +1220,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  		printed += ip__fprintf_sym(entries[nr - 1].from, thread,
>  					   x.cpumode, x.cpu, &lastsym, attr, fp);
>  		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
> -					    &x, buffer, len, 0, fp, &total_cycles);
> +					    &x, buffer, len, 0, fp, &total_cycles,
> +					    attr);
>  		if (PRINT_FIELD(SRCCODE))
>  			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
>  	}
> @@ -1242,14 +1252,17 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
>  			if (ip == end) {
>  				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
> -							    &total_cycles);
> +							    &total_cycles, attr);
>  				if (PRINT_FIELD(SRCCODE))
>  					printed += print_srccode(thread, x.cpumode, ip);
>  				break;
>  			} else {
>  				ilen = 0;
> -				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
> +				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
>  						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
> +				if (PRINT_FIELD(BRSTACKINSNLEN))
> +					printed += fprintf(fp, "\tilen: %d", ilen);
> +				printed += fprintf(fp, "\n");
>  				if (ilen == 0)
>  					break;
>  				if (PRINT_FIELD(SRCCODE))
> @@ -1292,16 +1305,23 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  			      machine, thread, &x.is64bit, &x.cpumode, false);
>  		if (len <= 0)
>  			goto out;
> -		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
> -			dump_insn(&x, sample->ip, buffer, len, NULL));
> +		ilen = 0;
> +		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
> +			dump_insn(&x, sample->ip, buffer, len, &ilen));
> +		if (PRINT_FIELD(BRSTACKINSNLEN))
> +			printed += fprintf(fp, "\tilen: %d", ilen);
> +		printed += fprintf(fp, "\n");
>  		if (PRINT_FIELD(SRCCODE))
>  			print_srccode(thread, x.cpumode, sample->ip);
>  		goto out;
>  	}
>  	for (off = 0; off <= end - start; off += ilen) {
>  		ilen = 0;
> -		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
> +		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
>  				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
> +		if (PRINT_FIELD(BRSTACKINSNLEN))
> +			printed += fprintf(fp, "\tilen: %d", ilen);
> +		printed += fprintf(fp, "\n");
>  		if (ilen == 0)
>  			break;
>  		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
> @@ -1459,7 +1479,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
>  		for (i = 0; i < sample->insn_len; i++)
>  			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
>  	}
> -	if (PRINT_FIELD(BRSTACKINSN))
> +	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
>  		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
>  
>  	return printed;
> @@ -3716,7 +3736,7 @@ int cmd_script(int argc, const char **argv)
>  		     "Valid types: hw,sw,trace,raw,synth. "
>  		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
>  		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
> -		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
> +		     "brstacksym,flags,bpf-output,brstackinsn,brstackinsnlen,brstackoff,"
>  		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
>  		     "data_page_size,code_page_size,ins_lat",
>  		     parse_output_fields),
> -- 
> 2.7.4

-- 

- Arnaldo
