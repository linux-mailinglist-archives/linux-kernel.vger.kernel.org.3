Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DD051B672
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiEEDX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiEEDXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:23:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4964A914;
        Wed,  4 May 2022 20:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651720784; x=1683256784;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EjKATgGynEAXwguJ/QTN/z+daoE6vOAcRSvMpeZK+tM=;
  b=tY+ocKKdIsKuzpS5L/sNJAVTom2Cl2STml8zxzkqnMBTzdynjmE4+Oih
   JhaL9HTLe9MccgzW+VLmxfwXiVkgiIt3voJtDc4TwbHiSYP45tNe4b6Xc
   07crhdBlWRDqx/VlqCTz4b3Y37kVJC9vu29v+ShvIu4tC6RpVDoInxGbj
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 04 May 2022 20:19:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 20:19:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 20:19:42 -0700
Received: from [10.50.60.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 4 May 2022
 20:19:38 -0700
Message-ID: <3ea26a88-bdff-f7bc-0887-8678939912b1@quicinc.com>
Date:   Thu, 5 May 2022 08:49:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] Disable MMIO tracing from QUP wrapper and serial
 driver
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <jirislaby@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <1651488314-19382-1-git-send-email-quic_vnivarth@quicinc.com>
 <Ym/JYr3ltaKWqHQn@kroah.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <Ym/JYr3ltaKWqHQn@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/2022 5:36 PM, Greg KH wrote:
> On Mon, May 02, 2022 at 04:15:12PM +0530, Vijaya Krishna Nivarthi wrote:
>> Register read/write tracing is causing excessive
>> logging and filling the rtb buffer and effecting
>> performance.
>>
>> Disabled MMIO tracing from QUP wrapper and serial
>> driver to disable register read/write tracing.
>>
>> Vijaya Krishna Nivarthi (2):
>>    soc: qcom: geni: Disable MMIO tracing
>>    tty: serial: qcom_geni_serial: Disable MMIO tracing
>>
>>   drivers/soc/qcom/qcom-geni-se.c       | 8 +++++++-
>>   drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> -- 
>>
> Doesn't this series depend on the MMIO tracing series?  Why not just
> make it part of that one?
>
> confused,
>
> greg k-h
>
>

It is already a part of MMIO tracing series - https://lore.kernel.org/lkml/cover.1651663123.git.quic_saipraka@quicinc.com/
There was some disconnect before but they have been informed. Now this series will be dropped and
will be taken as part of MMIO tracing series.

Thanks,
Sai
