Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B375AFC68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiIGG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIGG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:29:25 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FE9E8A1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:29:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VOwWscf_1662532140;
Received: from 30.240.98.182(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VOwWscf_1662532140)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 14:29:02 +0800
Message-ID: <33bedd74-a19e-8919-64c3-432c2eaba11d@linux.alibaba.com>
Date:   Wed, 7 Sep 2022 14:28:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v6 04/21] x86/resctrl: Group struct rdt_hw_domain cleanup
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
 <20220902154829.30399-5-james.morse@arm.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220902154829.30399-5-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/2 下午11:48, James Morse 写道:
> domain_add_cpu() and domain_remove_cpu() need to kfree() the child
> arrays that were allocated by domain_setup_ctrlval().
>
> As this memory is moved around, and new arrays are created, adjusting
> the error handling cleanup code becomes noisier.
>
> To simplify this, move all the kfree() calls into a domain_free() helper.
> This depends on struct rdt_hw_domain being kzalloc()d, allowing it to
> unconditionally kfree() all the child arrays.
>
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>   * Made domain_free() static.
>
> Changes since v1:
>   * This patch is new
> ---
>   arch/x86/kernel/cpu/resctrl/core.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 25f30148478b..e37889f7a1a5 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -414,6 +414,13 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
>   	}
>   }
>   
> +static void domain_free(struct rdt_hw_domain *hw_dom)
add inline ?
> +{
> +	kfree(hw_dom->ctrl_val);
> +	kfree(hw_dom->mbps_val);
> +	kfree(hw_dom);
> +}
> +
>   static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>   {
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> @@ -488,7 +495,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   	rdt_domain_reconfigure_cdp(r);
>   
>   	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> -		kfree(hw_dom);
> +		domain_free(hw_dom);
>   		return;
>   	}
>   
> @@ -497,9 +504,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>   	err = resctrl_online_domain(r, d);
>   	if (err) {
>   		list_del(&d->list);
> -		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
> -		kfree(hw_dom);
> +		domain_free(hw_dom);
>   	}
>   }
>   
> @@ -547,12 +552,10 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   		if (d->plr)
>   			d->plr->d = NULL;
>   
> -		kfree(hw_dom->ctrl_val);
> -		kfree(hw_dom->mbps_val);
>   		bitmap_free(d->rmid_busy_llc);
>   		kfree(d->mbm_total);
>   		kfree(d->mbm_local);
> -		kfree(hw_dom);
> +		domain_free(hw_dom);
>   		return;
>   	}
>   
