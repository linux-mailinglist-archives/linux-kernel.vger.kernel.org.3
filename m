Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BA65AFCCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIGGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIGGsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:48:15 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AABB9E89C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:47:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VOwnYjr_1662533270;
Received: from 30.240.98.182(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VOwnYjr_1662533270)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 14:47:52 +0800
Message-ID: <87aa9fd2-cae8-972d-81d4-8855cbd81569@linux.alibaba.com>
Date:   Wed, 7 Sep 2022 14:47:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v6 12/21] x86/resctrl: Calculate bandwidth from the
 previous __mon_event_count() chunks
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        xhao@linux.alibaba.com
References: <20220902154829.30399-1-james.morse@arm.com>
 <20220902154829.30399-13-james.morse@arm.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220902154829.30399-13-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/2 下午11:48, James Morse 写道:
> mbm_bw_count() is only called by the mbm_handle_overflow() worker once a
> second. It reads the hardware register, calculates the bandwidth and
> updates m->prev_bw_msr which is used to hold the previous hardware register
> value.
>
> Operating directly on hardware register values makes it difficult to make
> this code architecture independent, so that it can be moved to /fs/,
> making the mba_sc feature something resctrl supports with no additional
> support from the architecture.
> Prior to calling mbm_bw_count(), mbm_update() reads from the same hardware
> register using __mon_event_count().
>
> Change mbm_bw_count() to use the current chunks value most recently saved
> by __mon_event_count(). This removes an extra call to __rmid_read().
> Instead of using m->prev_msr to calculate the number of chunks seen,
> use the rr->val that was updated by __mon_event_count(). This removes an
> extra call to mbm_overflow_count() and get_corrected_mbm_count().
> Calculating bandwidth like this means mbm_bw_count() no longer operates
> on hardware register values directly.
>
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v3:
>   * Reset rr.val before each use to avoid over counting.
>   * Fixed typos in kerneldoc.
>
> Changes since v2:
>   * Expanded commit message
>
> Changes since v1:
>   * This patch was rewritten
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 25 ++++++++++++++++---------
>   2 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 3b9e43ba7590..46062099d69e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -289,7 +289,7 @@ struct rftype {
>    * struct mbm_state - status for each MBM counter in each domain
>    * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
>    * @prev_msr:	Value of IA32_QM_CTR for this RMID last time we read it
> - * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
> + * @prev_bw_chunks: Previous chunks value read for bandwidth calculation
>    * @prev_bw:	The most recent bandwidth in MBps
>    * @delta_bw:	Difference between the current and previous bandwidth
>    * @delta_comp:	Indicates whether to compute the delta_bw
> @@ -297,7 +297,7 @@ struct rftype {
>   struct mbm_state {
>   	u64	chunks;
>   	u64	prev_msr;
> -	u64	prev_bw_msr;
> +	u64	prev_bw_chunks;
>   	u32	prev_bw;
>   	u32	delta_bw;
>   	bool	delta_comp;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 3e69386cfe00..2d81b6cd9632 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -315,7 +315,7 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   
>   	if (rr->first) {
>   		memset(m, 0, sizeof(struct mbm_state));
> -		m->prev_bw_msr = m->prev_msr = tval;
> +		m->prev_msr = tval;
>   		return 0;
>   	}
>   
> @@ -329,27 +329,32 @@ static u64 __mon_event_count(u32 rmid, struct rmid_read *rr)
>   }
>   
>   /*
> + * mbm_bw_count() - Update bw count from values previously read by
> + *		    __mon_event_count().
> + * @rmid:	The rmid used to identify the cached mbm_state.
> + * @rr:		The struct rmid_read populated by __mon_event_count().
> + *
>    * Supporting function to calculate the memory bandwidth
> - * and delta bandwidth in MBps.
> + * and delta bandwidth in MBps. The chunks value previously read by
> + * __mon_event_count() is compared with the chunks value from the previous
> + * invocation. This must be called once per second to maintain values in MBps.
>    */
>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(rr->r);
>   	struct mbm_state *m = &rr->d->mbm_local[rmid];
> -	u64 tval, cur_bw, chunks;
> +	u64 cur_bw, chunks, cur_chunks;
>   
> -	tval = __rmid_read(rmid, rr->evtid);
> -	if (tval & (RMID_VAL_ERROR | RMID_VAL_UNAVAIL))
> -		return;
> +	cur_chunks = rr->val;
> +	chunks = cur_chunks - m->prev_bw_chunks;
> +	m->prev_bw_chunks = cur_chunks;
>   
> -	chunks = mbm_overflow_count(m->prev_bw_msr, tval, hw_res->mbm_width);
> -	cur_bw = (get_corrected_mbm_count(rmid, chunks) * hw_res->mon_scale) >> 20;
> +	cur_bw = (chunks * hw_res->mon_scale) >> 20;
>   
>   	if (m->delta_comp)
>   		m->delta_bw = abs(cur_bw - m->prev_bw);
>   	m->delta_comp = false;
>   	m->prev_bw = cur_bw;
> -	m->prev_bw_msr = tval;
>   }
>   
>   /*
> @@ -516,10 +521,12 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   	 */
>   	if (is_mbm_total_enabled()) {
>   		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
> +		rr.val = 0;
In mbm_update,  there no use the rr.val, so there no need to initialize ？
>   		__mon_event_count(rmid, &rr);
>   	}
>   	if (is_mbm_local_enabled()) {
>   		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
> +		rr.val = 0;
ditto.
>   		__mon_event_count(rmid, &rr);
>   
>   		/*
