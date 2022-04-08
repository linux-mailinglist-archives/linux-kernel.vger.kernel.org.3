Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35D84F97BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiDHOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiDHOOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:14:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9E034F4A1;
        Fri,  8 Apr 2022 07:12:21 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KZgBD6Jnvz67tCt;
        Fri,  8 Apr 2022 22:10:12 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Fri, 8 Apr 2022 16:12:18 +0200
Received: from [10.47.91.39] (10.47.91.39) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 15:12:17 +0100
Message-ID: <ab0293b6-9e71-a28a-e5c1-e4d9b22b0ae6@huawei.com>
Date:   Fri, 8 Apr 2022 15:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf: Don't show unwind error messages when augmenting
 frame pointer stack
To:     James Clark <james.clark@arm.com>, <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <alexandre.truong@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        German Gomez <german.gomez@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220406145651.1392529-1-james.clark@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20220406145651.1392529-1-james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.91.39]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 15:56, James Clark wrote:
> Commit b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf
> record --call-graph=fp'") intended to add a 'best effort' Dwarf unwind
> that improved the frame pointer stack in most scenarios. It's expected
> that the unwind will fail sometimes, but this shouldn't be reported as
> an error. It only works when the return address can be determined from
> the contents of the link register alone.
> 
> Fix the error shown when the unwinder requires extra registers by adding
> a new flag that suppresses error messages. This flag is not set in the
> normal --call-graph=dwarf unwind mode so that behavior is not changed.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Fixes: b9f6fbb3b2c2 ("perf arm64: Inject missing frames when using 'perf record --call-graph=fp'")
> Signed-off-by: James Clark <james.clark@arm.com>

Seems ok:
Tested-by: John Garry <john.garry@huawei.com>

Thanks!

> ---
>   tools/perf/tests/dwarf-unwind.c                     |  2 +-
>   .../perf/util/arm64-frame-pointer-unwind-support.c  |  2 +-
>   tools/perf/util/machine.c                           |  2 +-
>   tools/perf/util/unwind-libdw.c                      | 10 +++++++---
>   tools/perf/util/unwind-libdw.h                      |  1 +
>   tools/perf/util/unwind-libunwind-local.c            | 10 +++++++---
>   tools/perf/util/unwind-libunwind.c                  |  6 ++++--
>   tools/perf/util/unwind.h                            | 13 ++++++++++---
>   8 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index 2dab2d262060..afdca7f2959f 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -122,7 +122,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thr
>   	}
>   
>   	err = unwind__get_entries(unwind_entry, &cnt, thread,
> -				  &sample, MAX_STACK);
> +				  &sample, MAX_STACK, false);
>   	if (err)
>   		pr_debug("unwind failed\n");
>   	else if (cnt != MAX_STACK) {
> diff --git a/tools/perf/util/arm64-frame-pointer-unwind-support.c b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> index 2242a885fbd7..4940be4a0569 100644
> --- a/tools/perf/util/arm64-frame-pointer-unwind-support.c
> +++ b/tools/perf/util/arm64-frame-pointer-unwind-support.c
> @@ -53,7 +53,7 @@ u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thr
>   		sample->user_regs.cache_regs[PERF_REG_ARM64_SP] = 0;
>   	}
>   
> -	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2);
> +	ret = unwind__get_entries(add_entry, &entries, thread, sample, 2, true);
>   	sample->user_regs = old_regs;
>   
>   	if (ret || entries.length != 2)
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index b80048546451..95391236f5f6 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2987,7 +2987,7 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
>   		return 0;
>   
>   	return unwind__get_entries(unwind_entry, cursor,
> -				   thread, sample, max_stack);
> +				   thread, sample, max_stack, false);
>   }
>   
>   int thread__resolve_callchain(struct thread *thread,
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> index a74b517f7497..94aa40f6e348 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -200,7 +200,8 @@ frame_callback(Dwfl_Frame *state, void *arg)
>   	bool isactivation;
>   
>   	if (!dwfl_frame_pc(state, &pc, NULL)) {
> -		pr_err("%s", dwfl_errmsg(-1));
> +		if (!ui->best_effort)
> +			pr_err("%s", dwfl_errmsg(-1));
>   		return DWARF_CB_ABORT;
>   	}
>   
> @@ -208,7 +209,8 @@ frame_callback(Dwfl_Frame *state, void *arg)
>   	report_module(pc, ui);
>   
>   	if (!dwfl_frame_pc(state, &pc, &isactivation)) {
> -		pr_err("%s", dwfl_errmsg(-1));
> +		if (!ui->best_effort)
> +			pr_err("%s", dwfl_errmsg(-1));
>   		return DWARF_CB_ABORT;
>   	}
>   
> @@ -222,7 +224,8 @@ frame_callback(Dwfl_Frame *state, void *arg)
>   int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>   			struct thread *thread,
>   			struct perf_sample *data,
> -			int max_stack)
> +			int max_stack,
> +			bool best_effort)
>   {
>   	struct unwind_info *ui, ui_buf = {
>   		.sample		= data,
> @@ -231,6 +234,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
>   		.cb		= cb,
>   		.arg		= arg,
>   		.max_stack	= max_stack,
> +		.best_effort    = best_effort
>   	};
>   	Dwarf_Word ip;
>   	int err = -EINVAL, i;
> diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
> index 0cbd2650e280..8c88bc4f2304 100644
> --- a/tools/perf/util/unwind-libdw.h
> +++ b/tools/perf/util/unwind-libdw.h
> @@ -20,6 +20,7 @@ struct unwind_info {
>   	void			*arg;
>   	int			max_stack;
>   	int			idx;
> +	bool			best_effort;
>   	struct unwind_entry	entries[];
>   };
>   
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 71a353349181..41e29fc7648a 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -96,6 +96,7 @@ struct unwind_info {
>   	struct perf_sample	*sample;
>   	struct machine		*machine;
>   	struct thread		*thread;
> +	bool			 best_effort;
