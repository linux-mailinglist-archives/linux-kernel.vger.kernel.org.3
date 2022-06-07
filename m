Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76CE53F552
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 06:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiFGE45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 00:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236621AbiFGE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 00:56:49 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95748D412B;
        Mon,  6 Jun 2022 21:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654577807; x=1686113807;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=qEYLlVyw0msAfVi+gJ8kYAT2VCGgymTRLm5YaRSAAWc=;
  b=erz3kNXgNjzjJK3dLPMT73NTWC83ZDwJBlEEwhet6EFZdy2oS1BcDxrO
   LvBKBIXUqDWhtdFUNrKYHPtgyp59+9dTWa+R2GLS1/ZPs8G6w5c35QmxA
   V6EP+KnVVDCP4nH41qJhEOtzV0GNpQQXbsC7HZeY7+yucCJxG/XfHRINX
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jun 2022 21:56:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 21:56:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 6 Jun 2022 21:56:46 -0700
Received: from [10.47.233.232] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 21:56:46 -0700
Subject: Re: [RESEND PATCH V6 00/10] A bunch of fix and optimization patches
 in spmi-pmic-arb.c
To:     <sboyd@kernel.org>
CC:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <tglx@linutronix.de>, <maz@kernel.org>
References: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Message-ID: <c89c775f-cae2-fd1e-a223-1e1e46f33d7f@quicinc.com>
Date:   Mon, 6 Jun 2022 21:55:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1651108369-11059-1-git-send-email-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 6:12 PM, Fenglin Wu wrote:
> Changes in v6:
>   Rebased [v5 08/10] on
>     https://lore.kernel.org/linux-arm-msm/20211227170151.73116-1-david@ixit.cz/#t
>
> Changes in v5:
>   Drop [v4 11/11] because of a similar change is under review:
>     https://lore.kernel.org/linux-arm-msm/YdRJcv2kpp1vgUTb@robh.at.kernel.org/T/#t
>
> Changes in v4:
>   In [v4 02/11], separated spurious interrupt handling.
>   In [v4 03/11], added Fixes tag for ("spmi: pmic-arb: do not ack and clear peripheral").
>   In [v4 11/11], updated the binding to address few warnings in "make dtbs_check"
>
> Changes in v3:
>   Drop [v2 07/10] as this is no longer needed after this change:
>                 50fc4c8cd240 ("spmi: spmi-pmic-arb: fix irq_set_type race condition")
>   In [v3 07/10], updated the author email to match with Signed-off-by.
>   In [v3 10/10], added the binding change in this series, and addressed issues in "make dt_binding_check"
>
> Changes in v2:
>   In [v2 01/10], added code to handle spurious interrupt.
>   In [v2 03/10], adressed minor comments to update the code logic.
>   In [v2 04/10], minor update to detect spurious interrupt.
>   In [v2 05/10], added Fixes tag.
>   In [v2 07/10], added Fixes tag and updated commit text to explain the problem.
>   In [v2 08/10], added binding change to make interrupt properties as optional.
>   In [v2 09/10], updated to check presence of "interrupt-controller" property.
>
>
> Abhijeet Dharmapurikar (1):
>   spmi: pmic-arb: add a print in cleanup_irq
>
> Ashay Jaiswal (1):
>   spmi: pmic-arb: add support to dispatch interrupt based on IRQ status
>
> David Collins (6):
>   spmi: pmic-arb: check apid against limits before calling irq handler
>   spmi: pmic-arb: correct duplicate APID to PPID mapping logic
>   spmi: pmic-arb: block access for invalid PMIC arbiter v5 SPMI writes
>   dt-bindings: spmi: spmi-pmic-arb: make interrupt properties as
>     optional
>   spmi: pmic-arb: make interrupt support optional
>   spmi: pmic-arb: increase SPMI transaction timeout delay
>
> Fenglin Wu (1):
>   spmi: pmic-arb: handle spurious interrupt
>
> Subbaraman Narayanamurthy (1):
>   spmi: pmic-arb: do not ack and clear peripheral interrupts in
>     cleanup_irq
>
>  .../bindings/spmi/qcom,spmi-pmic-arb.yaml          |   3 -
>  drivers/spmi/spmi-pmic-arb.c                       | 136 +++++++++++++++------
>  2 files changed, 96 insertions(+), 43 deletions(-)
>

Hi Stephen,
Is there any problem with the patch series format? If not, can you please review these changes as they've been pending for a while?

Thanks,
Subbaraman
