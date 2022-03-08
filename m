Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509AC4D0EFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242359AbiCHFXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiCHFXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:23:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE1653983C;
        Mon,  7 Mar 2022 21:22:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C6A9D6E;
        Mon,  7 Mar 2022 21:22:17 -0800 (PST)
Received: from [10.162.17.54] (a077893.blr.arm.com [10.162.17.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1123FA5D;
        Mon,  7 Mar 2022 21:22:14 -0800 (PST)
Message-ID: <3b6007ef-1ad8-c495-26aa-7974af8faefa@arm.com>
Date:   Tue, 8 Mar 2022 10:52:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] perf script: Output branch sample type
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
 <20220307171917.2555829-5-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220307171917.2555829-5-james.clark@arm.com>
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
> The type info is saved when using '-j save_type'. Output this in perf

Mentioning PERF_SAMPLE_BRANCH_CALL_STACK here as well might be better.

> script so it can be accessed by other tools or for debugging.
> 
> It's appended to the end of the list of fields so any existing tools
> that split on / and access fields via an index are not affected. Also
> output '-' instead of 'N/A' when the branch type isn't saved because /
> is used as a field separator.

Did not get it. Why 'N/A' should have been used anyway ?

> 
> Entries before this change look like this:
> 
>   0xaaaadb350838/0xaaaadb3507a4/P/-/-/0
> 
> And afterwards like this:
> 
>   0xaaaadb350838/0xaaaadb3507a4/P/-/-/0/CALL
> 
> or this if no type info is saved:
> 
>   0x7fb57586df6b/0x7fb5758731f0/P/-/-/143/-

143 ?

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/builtin-script.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index fac2e9470926..5e4a262a6825 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -859,11 +859,12 @@ mispred_str(struct branch_entry *br)
>  
>  static int print_bstack_flags(FILE *fp, struct branch_entry *br)
>  {
> -	return fprintf(fp, "/%c/%c/%c/%d ",
> +	return fprintf(fp, "/%c/%c/%c/%d/%s ",
>  		       mispred_str(br),
>  		       br->flags.in_tx ? 'X' : '-',
>  		       br->flags.abort ? 'A' : '-',
> -		       br->flags.cycles);
> +		       br->flags.cycles,
> +		       br->flags.type ? branch_type_name(br->flags.type) : "-");
>  }
>  
>  static int perf_sample__fprintf_brstack(struct perf_sample *sample,


LGTM but as mentioned before, I hope this does not affect any existing
parsing tools.
