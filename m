Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4E4D0EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244260AbiCHEac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCHEa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:30:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5017E220EA;
        Mon,  7 Mar 2022 20:29:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B641DD6E;
        Mon,  7 Mar 2022 20:29:29 -0800 (PST)
Received: from [10.162.17.54] (a077893.blr.arm.com [10.162.17.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F04E73FA5D;
        Mon,  7 Mar 2022 20:29:26 -0800 (PST)
Message-ID: <fb9717bb-735a-88d9-254d-0e7b2f7209f2@arm.com>
Date:   Tue, 8 Mar 2022 09:59:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] perf: Print branch stack entry type in
 --dump-raw-trace
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
 <20220307171917.2555829-3-james.clark@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220307171917.2555829-3-james.clark@arm.com>
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
> This can help with debugging issues. It only prints when -j save_type
> is used otherwise an empty string is printed.

Specifying events with PERF_SAMPLE_BRANCH_CALL_STACK flag explicitly might
be better along with '-j save_type'.

> 
> Before the change:
> 
>   101603801707130 0xa70 [0x630]: PERF_RECORD_SAMPLE(IP, 0x2): 1108/1108: 0xffff9c1df24c period: 10694 addr: 0
>   ... branch stack: nr:64
>   .....  0: 0000ffff9c26029c -> 0000ffff9c26f340 0 cycles  P   0
>   .....  1: 0000ffff9c2601bc -> 0000ffff9c26f340 0 cycles  P   0
> 
> After the change:
> 
>   101603801707130 0xa70 [0x630]: PERF_RECORD_SAMPLE(IP, 0x2): 1108/1108: 0xffff9c1df24c period: 10694 addr: 0
>   ... branch stack: nr:64
>   .....  0: 0000ffff9c26029c -> 0000ffff9c26f340 0 cycles  P   0 CALL
>   .....  1: 0000ffff9c2601bc -> 0000ffff9c26f340 0 cycles  P   0 IND_CALL
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/session.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f54282d5c648..3b8dfe603e50 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1159,14 +1159,15 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>  		struct branch_entry *e = &entries[i];
>  
>  		if (!callstack) {
> -			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x\n",
> +			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s\n",
>  				i, e->from, e->to,
>  				(unsigned short)e->flags.cycles,
>  				e->flags.mispred ? "M" : " ",
>  				e->flags.predicted ? "P" : " ",
>  				e->flags.abort ? "A" : " ",
>  				e->flags.in_tx ? "T" : " ",
> -				(unsigned)e->flags.reserved);
> +				(unsigned)e->flags.reserved,
> +				e->flags.type ? branch_type_name(e->flags.type) : "");
>  		} else {
>  			printf("..... %2"PRIu64": %016" PRIx64 "\n",
>  				i, i > 0 ? e->from : e->to);

LGTM but I am wondering whether this might affect existing tools ?
