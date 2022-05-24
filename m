Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEC153274F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiEXKPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiEXKPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:15:10 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EF18723D;
        Tue, 24 May 2022 03:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653387308; x=1684923308;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YogcLhioZD8mO8o2z+SR0UJW63uOHaQtqSiO2gDX0Wk=;
  b=uyqbWXSita2DFnjfBxfuJxEkDu2Rs0NaR8Lq4Ej48jqSxW6tL3TDFqnh
   Mm2JZi1o96wcnAPNGm0ADUjS1xzaxze4GnGae4bzwxFZutuPxiEbbJQg3
   PpjaCaIpSdGAAYoDU7cUfOqoQ+hv+Jo/Cnpr56uzAjiLNw1kS/5Qv/pdp
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 May 2022 03:15:08 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:15:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 03:15:07 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 03:15:02 -0700
Subject: Re: [PATCH] mailbox: qcom-ipcc: Fix -Wunused-function with
 CONFIG_PM_SLEEP=n
To:     Nathan Chancellor <nathan@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     Prasad Sodagudi <quic_psodagud@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20220523224702.2002652-1-nathan@kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <6d97075e-d62c-6f85-3cba-c3f7c71fdbbf@quicinc.com>
Date:   Tue, 24 May 2022 15:44:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220523224702.2002652-1-nathan@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nathan,
Thanks for the fix!

On 5/24/22 4:17 AM, Nathan Chancellor wrote:
> When CONFIG_PM_SLEEP is not set, there is a warning that
> qcom_ipcc_pm_resume() is unused:
> 
>    drivers/mailbox/qcom-ipcc.c:258:12: error: 'qcom_ipcc_pm_resume' defined but not used [-Werror=unused-function]
>      258 | static int qcom_ipcc_pm_resume(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> Commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old
> ones") reworked the PM_OPS macros to avoid this problem. Use
> NOIRQ_SYSTEM_SLEEP_PM_OPS directly so that qcom_ipcc_pm_resume() always
> appears to be used to the compiler, even though it will be dead code
> eliminated in the !CONFIG_PM_SLEEP case.
> 
> Fixes: c25f77899753 ("mailbox: qcom-ipcc: Log the pending interrupt during resume")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/mailbox/qcom-ipcc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
> index 2583b20cdeb7..31d58b7d55fe 100644
> --- a/drivers/mailbox/qcom-ipcc.c
> +++ b/drivers/mailbox/qcom-ipcc.c
> @@ -344,7 +344,7 @@ static const struct of_device_id qcom_ipcc_of_match[] = {
>   MODULE_DEVICE_TABLE(of, qcom_ipcc_of_match);
>   
>   static const struct dev_pm_ops qcom_ipcc_dev_pm_ops = {
> -	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, qcom_ipcc_pm_resume)
>   };
>   
>   static struct platform_driver qcom_ipcc_driver = {
> 
> base-commit: bca1a1004615efe141fd78f360ecc48c60bc4ad5
> 
