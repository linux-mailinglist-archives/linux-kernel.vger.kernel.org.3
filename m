Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629145129BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiD1DF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbiD1DFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:05:52 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8BE99695;
        Wed, 27 Apr 2022 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651114957; x=1682650957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SIYCB3bexhua9iFQzXZUTU9dplIjEghTancCIHJwJog=;
  b=Ewpu2M7NyoPLRzZJzISU0lTVPeoW41aAZpBs31QDgsCHfO2OGweOSzlI
   rAvyAETNMvQ83zjq5UDWFZKqLYcfnF1Z+zYHPPsIITaQpDTXj3PooiRQn
   oD5xgB8Yw2DtUSUfzLuFQCxwM2YhEGlAEH7peCYYvcJQB8XO8WKqPpwR2
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 20:02:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 20:02:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 20:02:35 -0700
Received: from [10.50.42.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 20:02:31 -0700
Message-ID: <6b8b7969-56f0-d8d5-91b3-7accf066ea14@quicinc.com>
Date:   Thu, 28 Apr 2022 08:32:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv10 0/6] lib/rwmmio/arm64: Add support to trace register
 reads/writes
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
 <20220408111707.2488-1-quic_saipraka@quicinc.com>
 <bb99b615-cc76-9591-a610-fb4841d41d62@quicinc.com>
 <CAK8P3a1b0K4hJC9esuznqDdcBoX6+QqD74nVh91-iYbkZxiqbQ@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a1b0K4hJC9esuznqDdcBoX6+QqD74nVh91-iYbkZxiqbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2022 9:20 PM, Arnd Bergmann wrote:
> On Thu, Apr 21, 2022 at 4:00 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> On 4/8/2022 4:47 PM, Sai Prakash Ranjan wrote:
>>> Gentle ping, could you please take a look at this, would appreciate your reviews.
>>>
>> Gentle Ping !!
>>
> Sorry for dropping the ball on this. I'll go through the patches again
> now. From a new
> look, this all seems fine, but I'll need to take a little extra time
> to understand why we
> are getting the warnings that you are fixing, and how one will use the
> tracepoints
> in the end.
>
>         Arnd

Thanks Arnd, I saw in other thread that you figured out the reasons for warnings.

Thanks,
Sai
