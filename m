Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F514D0EED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240424AbiCHFHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiCHFHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:07:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F78D33EA9;
        Mon,  7 Mar 2022 21:06:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A294D6E;
        Mon,  7 Mar 2022 21:06:09 -0800 (PST)
Received: from [10.162.17.54] (a077893.blr.arm.com [10.162.17.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F43B3FA5D;
        Mon,  7 Mar 2022 21:06:06 -0800 (PST)
Message-ID: <98472993-853a-7279-6594-fd173059a4d9@arm.com>
Date:   Tue, 8 Mar 2022 10:36:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] perf: Refactor perf script branch stack printing
Content-Language: en-US
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220307171917.2555829-1-james.clark@arm.com>
 <20220307171917.2555829-4-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220307171917.2555829-4-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/22 22:49, James Clark wrote:
> Remove duplicate code so that future changes to flags are always made to
> all 3 printing variations.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-script.c | 27 ++++++++++++---------------
>  1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9e032343f1c6..fac2e9470926 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -857,6 +857,15 @@ mispred_str(struct branch_entry *br)
>  	return br->flags.predicted ? 'P' : 'M';
>  }
>  
> +static int print_bstack_flags(FILE *fp, struct branch_entry *br)
> +{
> +	return fprintf(fp, "/%c/%c/%c/%d ",
> +		       mispred_str(br),
> +		       br->flags.in_tx ? 'X' : '-',
> +		       br->flags.abort ? 'A' : '-',
> +		       br->flags.cycles);
> +}
> +
>  static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>  					struct thread *thread,
>  					struct perf_event_attr *attr, FILE *fp)
> @@ -895,11 +904,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
>  			printed += fprintf(fp, ")");
>  		}
>  
> -		printed += fprintf(fp, "/%c/%c/%c/%d ",
> -			mispred_str(entries + i),
> -			entries[i].flags.in_tx ? 'X' : '-',
> -			entries[i].flags.abort ? 'A' : '-',
> -			entries[i].flags.cycles);
> +		printed += print_bstack_flags(fp, entries + i);
>  	}
>  
>  	return printed;
> @@ -941,11 +946,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
>  			printed += map__fprintf_dsoname(alt.map, fp);
>  			printed += fprintf(fp, ")");
>  		}
> -		printed += fprintf(fp, "/%c/%c/%c/%d ",
> -			mispred_str(entries + i),
> -			entries[i].flags.in_tx ? 'X' : '-',
> -			entries[i].flags.abort ? 'A' : '-',
> -			entries[i].flags.cycles);
> +		printed += print_bstack_flags(fp, entries + i);
>  	}
>  
>  	return printed;
> @@ -991,11 +992,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
>  			printed += map__fprintf_dsoname(alt.map, fp);
>  			printed += fprintf(fp, ")");
>  		}
> -		printed += fprintf(fp, "/%c/%c/%c/%d ",
> -			mispred_str(entries + i),
> -			entries[i].flags.in_tx ? 'X' : '-',
> -			entries[i].flags.abort ? 'A' : '-',
> -			entries[i].flags.cycles);
> +		printed += print_bstack_flags(fp, entries + i);
>  	}
>  
>  	return printed;


LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
