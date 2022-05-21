Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCA052F7D3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354407AbiEUDB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347782AbiEUDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:01:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D8E3054B;
        Fri, 20 May 2022 20:01:49 -0700 (PDT)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L4pCP4mH5zCsW8;
        Sat, 21 May 2022 10:56:49 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:01:47 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 21 May 2022 11:01:46 +0800
Subject: Re: [PATCH -next v3 2/2] blk-throttle: fix io hung due to
 configuration updates
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
CC:     <tj@kernel.org>, <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <geert@linux-m68k.org>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220519085811.879097-1-yukuai3@huawei.com>
 <20220519085811.879097-3-yukuai3@huawei.com>
 <20220519095857.GE16096@blackbody.suse.cz>
 <a8953189-af42-0225-3031-daf61347524a@huawei.com>
 <20220519161026.GG16096@blackbody.suse.cz>
 <73464ca6-9412-cc55-d9c0-f2e8a10f0607@huawei.com>
 <fe3c03f7-9b52-7948-075d-cbdf431363e1@huawei.com>
 <20220520160305.GA17335@blackbody.suse.cz>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <a2faaf5a-8e45-ec38-b2f3-7fa0368a393b@huawei.com>
Date:   Sat, 21 May 2022 11:01:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220520160305.GA17335@blackbody.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/05/21 0:03, Michal Koutný 写道:
> On Fri, May 20, 2022 at 09:36:11AM +0800, "yukuai (C)" <yukuai3@huawei.com> wrote:
>> Just to simplify explanation (assum that throtl_slice is greater than
>> 0.5s):
>> Without this patch:
>> wait time is caculated based on issuing 9k from now(3s) without any
>> bytes aready dispatched.
> 
> I acknowledge that pre-patch state is incorrect because it erases
> already passed wait-time from the previous slice.
> 
>> With this patch:
>> wait time is caculated based on issuing 9k from 0s with 0.5 bytes
>> aready dispatched.
> 
> Thanks for your further hint. Hopefully, I'm getting closer to real
> understanding. Now, I calculate the wait times as durations between
> current moment and timepoint when a bio can be dispatched.
> 
> IIUC, after config change the ideal wait time of a bio is
> 
>      wait_ideal := (disp + bio - Δt*l_old) / l_new
> 
> where Δt is the elapsed time of the current slice.
> You maintain the slice but scale disp, so you get
> 
>      wait_kuai := ((l_new/l_old)*disp + bio - Δt*l_lew) / l_new
>                 = disp / l_old + bio / l_new - Δt
> 
> Please confirm we're on the same page here.
Hi, Michal

Yes we're on the same page here.
> 
> Then I look at
> 
>      error := wait_kuai - wait_ideal
>            ...
> 	  = (Δt * l_old - disp) * (1/l_new - 1/l_old)
> 	  = (Δt * l_old - disp) * (1 - α) / (α * l_old)
> where
>      α = l_new / l_old
> 
> The leftmost term is a unconsumed IO of the slice. Say it's positive,
> while the bigger bio is throttled at the moment of a config change.
> If the config change increases throttling (α < 1), the error grows very
> high (i.e. over-throttling similar to the existing behavior).
> If the config change relieves throttling (α > 1), the wait time's
> slightly shorter (under-throttling) wrt the ideal.
Yew, you are right.
> 
> If I was to propose a correction, it'd be like the patch at the bottom
> derived from your but not finished (the XXX part). It's for potential
> further discussion.
I thought about it, however, I was thing that for such corner case,
fixing io hung if probably enough. Now with the formula that you sorted
out, it's right this is better.

Thanks,
Kuai
> 
> 
> I had myself carried a way with the formulas. If I go back to the
> beginning:
> 
>> Then io hung can be triggered by always submmiting new configuration
>> before the throttled bio is dispatched.
> 
> How big is this a problem actually? Is it only shooting oneself in the leg
> or can there be a user who's privileged enough to modify throttling
> configuration yet not privileged enough to justify the hung's
> consequences (like some global FS locks).
> 
> 
> Thanks,
> Michal
> 
> --- 8< ---
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index 469c483719be..3fd458d16f31 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -1274,7 +1274,62 @@ static int tg_print_conf_uint(struct seq_file *sf, void *v)
>   	return 0;
>   }
>   
> -static void tg_conf_updated(struct throtl_grp *tg, bool global)
> +static u64 throtl_update_slice_scale(unsigned int slice_start, u64 new_limit,
> +				     u64 old_limit)
> +{
> +	if (new_limit == old_limit)
> +		return slice_start;
> +
> +	/* This shouldn't really matter but semantically we want to extend the
> +	 * slice from the earliest possible point of time. */
> +	if (WARN_ON(new_limit == 0))
> +		return 0;
> +
> +	return jiffies - div64_u64((jiffies - slice_start) * old_limit, new_limit);
> +}
> +
> +static void throtl_update_slice(struct throtl_grp *tg, u64 *old_limits)
> +{
> +	/*
> +	 * How does this work? We're going to calculate new wait time in
> +	 * tg_with_in_bps_limit(). Ideal wait time after config change is
> +	 *
> +	 *   wait_ideal := (disp + bio - Δt*l_old) / l_new
> +	 *
> +	 * where Δt = jiffies - tg->slice_start (elapsed time of slice).
> +	 * In reality, the function has no idea about l_old so it calculates
> +	 *
> +	 *   wait_skewed := (disp + bio - Δt*l_new) / l_new
> +	 *
> +	 * So we modify slice_start to get correct number
> +	 *
> +	 *   wait_fixed := (disp + bio - Δt'*l_new) / l_new == wait_ideal
> +	 *
> +	 * from that
> +	 *   Δt' = Δt * l_old / l_new
> +	 * or
> +	 *   jiffies - slice_start' = (jiffies - slice_start) * l_old / l_new
> +	 * .
> +	 */
> +	tg->slice_start[READ]  = throtl_update_slice_scale(tg->slice_start[READ],
> +							   tg_bps_limit(tg, READ),
> +							   old_limits[0]);
> +	tg->slice_start[WRITE] = throtl_update_slice_scale(tg->slice_start[WRITE],
> +							   tg_bps_limit(tg, WRITE),
> +							   old_limits[1]);
> +
> +	// XXX This looks like OK since we should not change BPS and IOPS limit
> +	// at the same time but it is not actually OK because scaling
> +	// slice_start for one limit breaks the other anyway.
> +	tg->slice_start[READ]  = throtl_update_slice_scale(tg->slice_start[READ],
> +							   tg_iops_limit(tg, READ),
> +							   old_limits[2]);
> +	tg->slice_start[WRITE] = throtl_update_slice_scale(tg->slice_start[WRITE],
> +							   tg_iops_limit(tg, WRITE),
> +							   old_limits[3]);
> +}
> +
> +static void tg_conf_updated(struct throtl_grp *tg, u64 *old_limits, bool global)
>   {
>   	struct throtl_service_queue *sq = &tg->service_queue;
>   	struct cgroup_subsys_state *pos_css;
> @@ -1313,16 +1368,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
>   				parent_tg->latency_target);
>   	}
>   
> -	/*
> -	 * We're already holding queue_lock and know @tg is valid.  Let's
> -	 * apply the new config directly.
> -	 *
> -	 * Restart the slices for both READ and WRITES. It might happen
> -	 * that a group's limit are dropped suddenly and we don't want to
> -	 * account recently dispatched IO with new low rate.
> -	 */
> -	throtl_start_new_slice(tg, READ);
> -	throtl_start_new_slice(tg, WRITE);
> +	throtl_update_slice(tg, old_limits);
>   
>   	if (tg->flags & THROTL_TG_PENDING) {
>   		tg_update_disptime(tg);
> @@ -1330,6 +1376,14 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
>   	}
>   }
>   
> +static void tg_get_limits(struct throtl_grp *tg, u64 *limits)
> +{
> +	limits[0] = tg_bps_limit(tg, READ);
> +	limits[1] = tg_bps_limit(tg, WRITE);
> +	limits[2] = tg_iops_limit(tg, READ);
> +	limits[3] = tg_iops_limit(tg, WRITE);
> +}
> +
>   static ssize_t tg_set_conf(struct kernfs_open_file *of,
>   			   char *buf, size_t nbytes, loff_t off, bool is_u64)
>   {
> @@ -1338,6 +1392,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>   	struct throtl_grp *tg;
>   	int ret;
>   	u64 v;
> +	u64 old_limits[4];
>   
>   	ret = blkg_conf_prep(blkcg, &blkcg_policy_throtl, buf, &ctx);
>   	if (ret)
> @@ -1350,13 +1405,14 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>   		v = U64_MAX;
>   
>   	tg = blkg_to_tg(ctx.blkg);
> +	tg_get_limits(tg, old_limits);
>   
>   	if (is_u64)
>   		*(u64 *)((void *)tg + of_cft(of)->private) = v;
>   	else
>   		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
>   
> -	tg_conf_updated(tg, false);
> +	tg_conf_updated(tg, old_limits, false);
>   	ret = 0;
>   out_finish:
>   	blkg_conf_finish(&ctx);
> @@ -1526,6 +1582,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>   	struct blkg_conf_ctx ctx;
>   	struct throtl_grp *tg;
>   	u64 v[4];
> +	u64 old_limits[4];
>   	unsigned long idle_time;
>   	unsigned long latency_time;
>   	int ret;
> @@ -1536,6 +1593,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>   		return ret;
>   
>   	tg = blkg_to_tg(ctx.blkg);
> +	tg_get_limits(tg, old_limits);
>   
>   	v[0] = tg->bps_conf[READ][index];
>   	v[1] = tg->bps_conf[WRITE][index];
> @@ -1627,7 +1685,7 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
>   			tg->td->limit_index = LIMIT_LOW;
>   	} else
>   		tg->td->limit_index = LIMIT_MAX;
> -	tg_conf_updated(tg, index == LIMIT_LOW &&
> +	tg_conf_updated(tg, old_limits, index == LIMIT_LOW &&
>   		tg->td->limit_valid[LIMIT_LOW]);
>   	ret = 0;
>   out_finish:
> .
> 
