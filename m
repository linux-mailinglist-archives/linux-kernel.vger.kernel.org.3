Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE834C78C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiB1TZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB1TZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:25:05 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0EFEB02;
        Mon, 28 Feb 2022 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646076259; x=1677612259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ioyGMTrNhrI2bIJcwf/tXVAAjhbSRoppoUAEm+1hobw=;
  b=SXaKL9oZ6aveOqnzV6wMsmh2bKLgIpTPszkNW1BhuQ4K/uXoDG6ya98/
   vchz6FNa1nLNNtxq4x/XFSy52dI7GWC/+7lsQgTHJdPdUiXYUT8JJ1shv
   +YOOJW9soN20NEwkSgbQyW57ijZggyCRzoEdr6IG9PVm1HW2LrcQUrusf
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Feb 2022 11:24:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:24:18 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 28 Feb 2022 11:24:18 -0800
Received: from [10.216.31.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 28 Feb
 2022 11:24:15 -0800
Message-ID: <0beb0083-d82b-dc24-6d07-565f9eaeebff@quicinc.com>
Date:   Tue, 1 Mar 2022 00:53:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/5] irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-msm@vger.kernel.org>
References: <20220224101226.88373-1-maz@kernel.org>
 <20220224101226.88373-2-maz@kernel.org>
From:   "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <20220224101226.88373-2-maz@kernel.org>
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

Hi,

On 2/24/2022 3:42 PM, Marc Zyngier wrote:
> PDC_NO_PARENT_IRQ is pretty pointless, as all it indicates is
> that the PDC terminates the interrupt hierarchy. Which is
> exactly the same as not having a mapping in the GIC space.
> This is also bad practice to treat the absence of a hwirq
> as a hwirq itself.
>
> Just explicitly use the region mapping pointer, and drop
> the definition.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>

Thanks,
Maulik
> ---
>   drivers/irqchip/qcom-pdc.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>
>
