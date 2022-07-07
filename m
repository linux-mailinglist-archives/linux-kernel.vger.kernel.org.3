Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147F756A568
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiGGO3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbiGGO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176192F3BF;
        Thu,  7 Jul 2022 07:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7559062257;
        Thu,  7 Jul 2022 14:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D7AC3411E;
        Thu,  7 Jul 2022 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657204161;
        bh=zLD3ibeCNmnWU+a69Z0emMZcp26tTKwlO4zz96FbD0g=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=maRDDBMgpVM7fxUdnMeRfdk3VmVe4hlaYoXjem1uVpqSzXY0m9K4pU+JTM43k+UPb
         NlM3+TPLZhsf0AnRYmlKBis7SKeZcMcDTq92FHLkXq5Nw6gTo4e5c/VRxRNwNtz983
         pNReb28HmulV/A8oPyF16vyCvv8WohY+HWc3e4ZAmwT5U8CgV1HjuAcIk59UMcfO8K
         axsTbDiiyrcDVjpkJ3Tgx0FJgADtX5Meq2nNcqcB6efkIxxfPBAlGupKm0973r77Pg
         olkbKa7YqQ+6Y/o2snnuHIDBjkuSitUc/4RX/5hwNii58Pq96537koR72FGru57zm/
         GHViebz5g5BpQ==
Message-ID: <1d0fec7d-ed83-e1ff-92a1-e721bcc50298@kernel.org>
Date:   Thu, 7 Jul 2022 17:29:16 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/5] interconnect: qcom: icc-rpm: Support multiple
 buckets
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705072336.742703-1-leo.yan@linaro.org>
 <20220705072336.742703-5-leo.yan@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20220705072336.742703-5-leo.yan@linaro.org>
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
> The current interconnect rpm driver uses a single aggregate bandwidth to
> calculate the clock rates for both active and sleep clocks; therefore,
> it has no chance to separate bandwidth requests for these two kinds of
> clocks.
> 
> This patch studies the implementation from interconnect rpmh driver to
> support multiple buckets.  The rpmh driver provides three buckets for
> AMC, WAKE, and SLEEP; this driver only needs to use WAKE and SLEEP
> buckets, but we keep the same way with rpmh driver, this can allow us to
> reuse the DT binding and avoid to define duplicated data structures.
> 
> This patch introduces two callbacks: qcom_icc_pre_bw_aggregate() is used
> to clean up bucket values before aggregate bandwidth requests, and
> qcom_icc_bw_aggregate() is to aggregate bandwidth for buckets.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 51 ++++++++++++++++++++++++++++-
>   drivers/interconnect/qcom/icc-rpm.h |  6 ++++
>   2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 8c9d5cc7276c..b025fc6b97c9 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -254,6 +254,54 @@ static int __qcom_icc_set(struct icc_node *n, struct qcom_icc_node *qn,
>   	return 0;
>   }
>   
> +/**
> + * qcom_icc_rpm_pre_bw_aggregate - cleans up values before re-aggregate requests

This does not match with the name of the function below.

> + * @node: icc node to operate on
> + */
> +static void qcom_icc_pre_bw_aggregate(struct icc_node *node)
> +{
> +	struct qcom_icc_node *qn;
> +	size_t i;
> +
> +	qn = node->data;
> +	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		qn->sum_avg[i] = 0;
> +		qn->max_peak[i] = 0;
> +	}
> +}
> +
[..]
Thanks,
Georgi
