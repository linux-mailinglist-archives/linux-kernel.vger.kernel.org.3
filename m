Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6F7568882
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGFMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGFMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:41:04 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EF7255B6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:41:03 -0700 (PDT)
Received: from [192.168.1.101] (abxi46.neoplus.adsl.tpnet.pl [83.9.2.46])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id ED5563F727;
        Wed,  6 Jul 2022 14:41:01 +0200 (CEST)
Message-ID: <84083c41-be8e-15c0-7dc0-a5cd2895566c@somainline.org>
Date:   Wed, 6 Jul 2022 14:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [V3 4/7] remoteproc: qcom: pas: Check if coredump is enabled
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, bjorn.andersson@linaro.org
Cc:     agross@kernel.org, mathieu.poirier@linaro.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siddharth Gupta <sidgup@codeaurora.org>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
 <1657022900-2049-5-git-send-email-quic_sibis@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <1657022900-2049-5-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.07.2022 14:08, Sibi Sankar wrote:
> From: Siddharth Gupta <sidgup@codeaurora.org>
> 
> Client drivers need to check if coredump is enabled for the rproc before
> continuing with coredump generation. This change adds a check in the PAS
> driver.
> 
> Fixes: 8ed8485c4f05 ("remoteproc: qcom: Add capability to collect minidumps")
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/remoteproc/qcom_q6v5_pas.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 43dde151120f..d103101a5ea0 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -92,6 +92,9 @@ static void adsp_minidump(struct rproc *rproc)
>  {
>  	struct qcom_adsp *adsp = rproc->priv;
>  
> +	if (rproc->dump_conf == RPROC_COREDUMP_DISABLED)
> +		return;
> +
>  	qcom_minidump(rproc, adsp->minidump_id);
>  }
>  
