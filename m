Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1756A583
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiGGOeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiGGOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:34:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECADC2A732;
        Thu,  7 Jul 2022 07:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B8DFB82139;
        Thu,  7 Jul 2022 14:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43847C3411E;
        Thu,  7 Jul 2022 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657204443;
        bh=WcCj/mS9RTdQYqbcOaXGcW3pRviUrRb0UE/IJVCNlrM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZJiIMtYC6iHeh1na94SLj/3K4bAW+2UN9B/KupY2HkbzVEhgNzS/myZeuowFtDTYq
         jsIXZCvmDoz/f4jlcQMX3AFIugTgtdtDjw86wtrHbF4XnRgRvPurourTK+nlX1OBFI
         93iM828Us08nWTE3gjA8/VOMeB4n2J+lWGrj9ljrs5qOy2xJhkb8IL8YwQZWYR+gXr
         ifeJF4Rp46H7/yqH2EJ2bUz4kRXHNWd0nZlyJCR4Ea+woPSNOOVRqfBqws/LjK0SmY
         9K0+6pvDhOcRY5w637R/NR9oE1s6OYbTAJhLg8CGtqW02Vit3uBaX8d4K8oPAlZFyH
         sjCSJycqYNEDw==
Message-ID: <28bf991f-7b4c-0af1-2780-842500b01a0f@kernel.org>
Date:   Thu, 7 Jul 2022 17:33:58 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] interconnect: qcom: icc-rpm: Set bandwidth and
 clock for bucket values
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705072336.742703-1-leo.yan@linaro.org>
 <20220705072336.742703-6-leo.yan@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220705072336.742703-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5.07.22 10:23, Leo Yan wrote:
> This commit uses buckets for support bandwidth and clock rates.  It
> introduces a new function qcom_icc_bus_aggregate() to calculate the
> aggregate average and peak bandwidths for every bucket, and also it
> calculates the maximum aggregate values across all buckets.
> 
> The maximum aggregate values are used to calculate the final bandwidth
> requests.  And we can set the clock rate per bucket, we use SLEEP bucket
> as default bucket if a platform doesn't enable the interconnect path
> tags in DT binding; otherwise, we use WAKE bucket to set active clock
> and use SLEEP bucket for other clocks.  So far we don't use AMC bucket.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 80 ++++++++++++++++++++++++-----
>   1 file changed, 67 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index b025fc6b97c9..4b932eb807c7 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -302,18 +302,62 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   	return 0;
>   }
>   
> +/**
> + * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
> + * @provider: generic interconnect provider
> + * @agg_avg: an array for aggregated average bandwidth of buckets
> + * @agg_peak: an array for aggregated peak bandwidth of buckets
> + * @max_agg_avg: pointer to max value of aggregated average bandwidth
> + * @max_agg_peak: pointer to max value of aggregated peak bandwidth
> + */
> +static void qcom_icc_bus_aggregate(struct icc_provider *provider,
> +				   u64 *agg_avg, u64 *agg_peak,
> +				   u64 *max_agg_avg, u64 *max_agg_peak)
> +{
> +	struct icc_node *node;
> +	struct qcom_icc_node *qn;
> +	int i;
> +
> +	/* Initialise aggregate values */
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		agg_avg[i] = 0;
> +		agg_peak[i] = 0;
> +	}
> +
> +	*max_agg_avg = 0;
> +	*max_agg_peak = 0;
> +
> +	/*
> +	 * Iterate nodes on the interconnect and aggregate bandwidth
> +	 * requests for every bucket.
> +	 */
> +	list_for_each_entry(node, &provider->nodes, node_list) {
> +		qn = node->data;
> +		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +			agg_avg[i] += qn->sum_avg[i];
> +			agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
> +		}
> +	}
> +
> +	/* Find maximum values across all buckets */
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
> +		*max_agg_peak = max_t(u64, *max_agg_peak, agg_peak[i]);
> +	}
> +}
> +
>   static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   {
>   	struct qcom_icc_provider *qp;
>   	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>   	struct icc_provider *provider;
> -	struct icc_node *n;
>   	u64 sum_bw;
>   	u64 max_peak_bw;
>   	u64 rate;
> -	u32 agg_avg = 0;
> -	u32 agg_peak = 0;
> +	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
> +	u64 max_agg_avg, max_agg_peak;
>   	int ret, i;
> +	int bucket;
>   
>   	src_qn = src->data;
>   	if (dst)
> @@ -321,12 +365,11 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   	provider = src->provider;
>   	qp = to_qcom_provider(provider);
>   
> -	list_for_each_entry(n, &provider->nodes, node_list)
> -		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
> -				    &agg_avg, &agg_peak);
> +	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg,
> +			       &max_agg_peak);
>   
> -	sum_bw = icc_units_to_bps(agg_avg);
> -	max_peak_bw = icc_units_to_bps(agg_peak);
> +	sum_bw = icc_units_to_bps(max_agg_avg);
> +	max_peak_bw = icc_units_to_bps(max_agg_peak);
>   
>   	ret = __qcom_icc_set(src, src_qn, sum_bw);
>   	if (ret)
> @@ -337,12 +380,23 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   			return ret;
>   	}
>   
> -	rate = max(sum_bw, max_peak_bw);

Looks like max_peak_bw is unused now?

> -	do_div(rate, src_qn->buswidth);
> -	rate = min_t(u64, rate, LONG_MAX);
> -
>   	for (i = 0; i < qp->num_clks; i++) {
> +		/*
> +		 * Use WAKE bucket for active clock, otherwise, use SLEEP bucket
> +		 * for other clocks.  If a platform doesn't set interconnect
> +		 * path tags, by default use sleep bucket for all clocks.
> +		 *
> +		 * Note, AMC bucket is not supported yet.
> +		 */
> +		if (!strcmp(qp->bus_clks[i].id, "bus_a"))
> +			bucket = QCOM_ICC_BUCKET_WAKE;
> +		else
> +			bucket = QCOM_ICC_BUCKET_SLEEP;
> +
> +		rate = icc_units_to_bps(max(agg_avg[bucket], agg_peak[bucket]));
> +		do_div(rate, src_qn->buswidth);
> +		rate = min_t(u64, rate, LONG_MAX);
> +
>   		if (qp->bus_clk_rate[i] == rate)
>   			continue;

Thanks,
Georgi
