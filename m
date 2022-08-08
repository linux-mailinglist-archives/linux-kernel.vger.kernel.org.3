Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFEF58C4CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 10:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiHHIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 04:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237712AbiHHIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 04:17:10 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8747A267F;
        Mon,  8 Aug 2022 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659946629; x=1691482629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XEwyJaMYWmG1kFpxR2EWSp3UqCWqh9T4pWQdKWnLsD4=;
  b=lL2RP7wm2s2EfGRA3AKdcMgasKjOzQkX5gRJVw25DhvkoUOx3vnMZukd
   UfSbB70Z98zo+oR5tR7APtVC5IkzDzt5KUC26x00C1z0CRo/oze0erQ+I
   5+Gxx6SUNPyIOWXhAiPTrNNUT3+Ci7U5fb+y/GBHp5gp92u6L5GH2y1x0
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Aug 2022 01:17:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 01:17:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 01:17:08 -0700
Received: from [10.79.136.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 8 Aug 2022
 01:17:05 -0700
Message-ID: <cb0c6fbd-bf5c-b5ce-b4c5-8a605836204d@quicinc.com>
Date:   Mon, 8 Aug 2022 13:47:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soc: qcom: rpmhpd: Use highest corner until sync_state
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
References: <20220806155035.968340-1-bjorn.andersson@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220806155035.968340-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/6/2022 9:20 PM, Bjorn Andersson wrote:
> In some cases the hardware that the bootloader has left configured
> depends on RPMH power domains for their operation up until the point
> where the related Linux device driver probes and can inherit that
> configuration, or power down the hardware gracefully.
> 
> Unfortunately as Linux probes the releavant drivers in sequence there
> are periods during the Linux boot flow where either the genpd refcount
> will reach 0, or worse where the active performance_state votes does not
> meet the requirements of the state that the hardware was left in.
> 
> One specific example of this is during boot of e.g. SM8150/SC8180X,
> where the display clock controller probes, without any particular
> performance state needs (to access its registers). This will drop the
> MMCX rail to MIN_SVS, which isn't sufficient to sustain the clock rates
> that the later probing MDP is configured to. This results in an
> unrecoverable system state.
> 
> Handle both these cases by keeping the RPMH power-domais that are
> referenced voted for highest state, until sync_state indicates that all
> devices referencing the RPMH power-domain driver has been probed.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   drivers/soc/qcom/rpmhpd.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
> index 092f6ab09acf..494bb6c75ed7 100644
> --- a/drivers/soc/qcom/rpmhpd.c
> +++ b/drivers/soc/qcom/rpmhpd.c
> @@ -39,6 +39,7 @@
>    * @res_name:		Resource name used for cmd-db lookup
>    * @addr:		Resource address as looped up using resource name from
>    *			cmd-db
> + * @state_synced:       Indicator that sync_state has been invoked for the rpmhpd resource
>    */
>   struct rpmhpd {
>   	struct device	*dev;
> @@ -54,6 +55,7 @@ struct rpmhpd {
>   	bool		enabled;
>   	const char	*res_name;
>   	u32		addr;
> +	bool		state_synced;
>   };
>   
>   struct rpmhpd_desc {
> @@ -493,7 +495,13 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>   	unsigned int this_active_corner = 0, this_sleep_corner = 0;
>   	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
>   
> -	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +	if (pd->state_synced) {
> +		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
> +	} else {
> +		/* Clamp to highest corner if sync_state hasn't happened */
> +		this_active_corner = pd->level_count - 1;
> +		this_sleep_corner = pd->level_count - 1;
> +	}
>   
>   	if (peer && peer->enabled)
>   		to_active_sleep(peer, peer->corner, &peer_active_corner,
> @@ -708,11 +716,36 @@ static int rpmhpd_probe(struct platform_device *pdev)
>   	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
>   }
>   
> +static void rpmhpd_sync_state(struct device *dev)
> +{
> +	const struct rpmhpd_desc *desc = of_device_get_match_data(dev);
> +	struct rpmhpd **rpmhpds = desc->rpmhpds;
> +	unsigned int corner;
> +	struct rpmhpd *pd;
> +	unsigned int i;
> +
> +	mutex_lock(&rpmhpd_lock);
> +	for (i = 0; i < desc->num_pds; i++) {
> +		pd = rpmhpds[i];
> +		if (!pd)
> +			continue;
> +
> +		pd->state_synced = true;
[]

> +		if (pd->enabled)
> +			corner = max(pd->corner, pd->enable_corner);
> +		else
> +			corner = 0;
> +		rpmhpd_aggregate_corner(pd, corner);

can't this be
		if (pd->enabled) {
			corner = max(pd->corner, pd->enable_corner);
			rpmhpd_aggregate_corner(pd, corner);
		}

also, we do check for return value of rpmhpd_aggregate_corner() but I guess
here there isn't much different we would do even if there is an error?
			
> +	}
> +	mutex_unlock(&rpmhpd_lock);
> +}
> +
>   static struct platform_driver rpmhpd_driver = {
>   	.driver = {
>   		.name = "qcom-rpmhpd",
>   		.of_match_table = rpmhpd_match_table,
>   		.suppress_bind_attrs = true,
> +		.sync_state = rpmhpd_sync_state,
>   	},
>   	.probe = rpmhpd_probe,
>   };
