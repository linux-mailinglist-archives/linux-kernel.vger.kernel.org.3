Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A0C567E98
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 08:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiGFGbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 02:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiGFGak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 02:30:40 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C747C1D302;
        Tue,  5 Jul 2022 23:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657089014; x=1688625014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HKgGNtH5+ZCmlx68r1yZkOpQeKz/TE7pn1yL+4sruqo=;
  b=v6hTFnjtFFVpnBWK+rFPSYNAF0EAcxCanXPIhI4ncLYhImJ1QQ83JUnz
   DRTGr5ZgoBC1SFmEPTG7CFOcGB9GIXjfBoSJBnTDQZb5Mdee4iIJhP4mZ
   FXoPfBXt1EmCvZIz0AwSu8Ws/RmU3Jv1hm92tJPxzjfToa4mZr+/1if8d
   U=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 23:30:13 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 23:30:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 23:30:12 -0700
Received: from [10.216.8.139] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 23:30:10 -0700
Message-ID: <91421440-578a-ccd1-21b3-7b8e2e8e2e8d@quicinc.com>
Date:   Wed, 6 Jul 2022 12:00:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] PM: QoS: Add check to make sure CPU freq is non-negative
Content-Language: en-US
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
From:   Shivnandan Kumar <quic_kshivnan@quicinc.com>
In-Reply-To: <20220623064605.2538969-1-quic_kshivnan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Gentle reminder,

Thanks,

Shivnandan

On 6/23/2022 12:16 PM, Shivnandan Kumar wrote:
> 	CPU frequency should never be non-negative.
> 	If some client driver calls freq_qos_update_request with some
> 	value greater than INT_MAX, then it will set max CPU freq at
> 	fmax but it will add plist node with some negative priority.
> 	plist node has priority from INT_MIN (highest) to INT_MAX
> 	(lowest). Once priority is set as negative, another client
> 	will not be able to reduce max CPU frequency. Adding check
> 	to make sure CPU freq is non-negative will fix this problem.
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>
> ---
>   kernel/power/qos.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index ec7e1e85923e..41e96fe34bfd 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -531,7 +531,8 @@ int freq_qos_add_request(struct freq_constraints *qos,
>   {
>   	int ret;
>   
> -	if (IS_ERR_OR_NULL(qos) || !req)
> +	if (IS_ERR_OR_NULL(qos) || !req || value < FREQ_QOS_MIN_DEFAULT_VALUE
> +		|| value > FREQ_QOS_MAX_DEFAULT_VALUE)
>   		return -EINVAL;
>   
>   	if (WARN(freq_qos_request_active(req),
> @@ -563,7 +564,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
>    */
>   int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
>   {
> -	if (!req)
> +	if (!req || new_value < FREQ_QOS_MIN_DEFAULT_VALUE ||
> +		new_value > FREQ_QOS_MAX_DEFAULT_VALUE)
>   		return -EINVAL;
>   
>   	if (WARN(!freq_qos_request_active(req),
