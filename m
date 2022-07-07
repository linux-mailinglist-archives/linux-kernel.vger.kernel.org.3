Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C65C56A0A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiGGK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGGK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:59:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7987D5721C;
        Thu,  7 Jul 2022 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657191573; x=1688727573;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=OfSc07yQ3ge94ZYeQXBPSqIG1ZrgFidplmZMaEP/6us=;
  b=gydAR5ApPju8f/+Q3tKFH4XjJbaNMNJwaGk/vdDR7fPLM3fN3Z5HkVi7
   JAka9dX1RgyqhptL7HmwwVJ6imCPKvamiZjaJkLS69M8Jt6+He751s1RG
   jjGFY7GyzGK740h4WWqhjwpYmNOuV3eTSK3qJp9Tc6BZqglK1yKCjF8NN
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jul 2022 03:59:33 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 03:59:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 03:59:32 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 03:59:29 -0700
Subject: Re: [V3 1/7] remoteproc: qcom: pas: Add decrypt shutdown support for
 modem
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
 <1657022900-2049-2-git-send-email-quic_sibis@quicinc.com>
 <b75e45fc-eede-d44d-9c0d-535923de2f9d@somainline.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <e51d0dc3-344a-f82f-aaf2-d07d76bed98e@quicinc.com>
Date:   Thu, 7 Jul 2022 16:29:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b75e45fc-eede-d44d-9c0d-535923de2f9d@somainline.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
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

Hey Konrad,
Thanks for taking time to review the series.


On 7/6/22 6:08 PM, Konrad Dybcio wrote:
> 
> 
> On 5.07.2022 14:08, Sibi Sankar wrote:
>> The initial shutdown request to modem on SM8450 SoCs would start the
>> decryption process and will keep returning errors until the modem shutdown
>> is complete. Fix this by retrying shutdowns in fixed intervals.
>>
> I'm sorry, but this message seems a bit cryptic to me.. What
> is being decrypted? How is it related to the shutdown sequence?
> Why does it need to finish first?

I was told some portions of the modem logs in secured modem regions
needs decryption and this needs to be completed before minidump/coredump
are collected.

-Sibi

> 
> Konrad
> 
> [snipped the rest]
> 
