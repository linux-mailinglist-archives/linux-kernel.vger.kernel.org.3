Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3265704BD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiGKNyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiGKNx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC0F3C8F6;
        Mon, 11 Jul 2022 06:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29707614E4;
        Mon, 11 Jul 2022 13:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A85C34115;
        Mon, 11 Jul 2022 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657547635;
        bh=caL07f0ZrqZjLNrdweHxAxsixM8nX4rbPbMW6ZYxsV0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=mjcLQAZ2hiumn0Rhx5n0oqEfEPs3iWu4Ef3cICqJ/e0aEdPsHK+6uTVnVmyI/PgOX
         5/Q4FgJ8udz3ZHaCcNlWI3urxE+qi3N5a2Swl7WeGW3RTrBWmasCNF0rwMCQaG8fsI
         MBT9yNmNhEbEviQ9WMswhT4q50Q8rOKFnUpCS/rSAH7Q6FxRRv8DUoYFPNkOV62rXT
         6sR2OQp8GnuWL3INmgM2nagbgmYuhO74Y9r4t2sLAd9Gb0xo53JdQrsIlVn3SHiXpP
         B9O8HDwxv1ejO3Koq5QhYyInUOXHK26f7kxqfPuB3UQovAzRfljun6+3GrOAF+qv0L
         nh1CjE/CuubYg==
Message-ID: <480d38db-3114-29d1-8b81-b35a07623060@kernel.org>
Date:   Mon, 11 Jul 2022 16:53:47 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v5 5/5] interconnect: qcom: icc-rpm: Set bandwidth and
 clock for bucket values
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220711115240.806236-1-leo.yan@linaro.org>
 <20220711115240.806236-6-leo.yan@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220711115240.806236-6-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Leo,

On 11.07.22 14:52, Leo Yan wrote:
> This commit uses buckets for support bandwidth and clock rates.  It
> introduces a new function qcom_icc_bus_aggregate() to calculate the
> aggregate average and peak bandwidths for every bucket, and also it
> calculates the maximum value of aggregated average bandwidth across all
> buckets.
> 
> The maximum aggregated average is used to calculate the final bandwidth
> requests.  And we can set the clock rate per bucket, we use SLEEP bucket
> as default bucket if a platform doesn't enable the interconnect path
> tags in DT binding; otherwise, we use WAKE bucket to set active clock
> and use SLEEP bucket for other clocks.  So far we don't use AMC bucket.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 75 +++++++++++++++++++++++------
>   1 file changed, 61 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index d27b1582521f..f15f5deee6ef 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -302,18 +302,57 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   	return 0;
>   }
>   
> +/**
> + * qcom_icc_bus_aggregate - aggregate bandwidth by traversing all nodes
> + * @provider: generic interconnect provider
> + * @agg_avg: an array for aggregated average bandwidth of buckets
> + * @agg_peak: an array for aggregated peak bandwidth of buckets
> + * @max_agg_avg: pointer to max value of aggregated average bandwidth
> + */
> +static void qcom_icc_bus_aggregate(struct icc_provider *provider,
> +				   u64 *agg_avg, u64 *agg_peak,
> +				   u64 *max_agg_avg)
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
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
> +		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
> +}
> +
>   static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>   {
>   	struct qcom_icc_provider *qp;
>   	struct qcom_icc_node *src_qn = NULL, *dst_qn = NULL;
>   	struct icc_provider *provider;
> -	struct icc_node *n;
>   	u64 sum_bw;
> -	u64 max_peak_bw;
>   	u64 rate;
> -	u32 agg_avg = 0;
> -	u32 agg_peak = 0;
> +	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
> +	u64 max_agg_avg, max_agg_peak;

Now max_agg_peak is unused?

Thanks,
Georgi
