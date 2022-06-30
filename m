Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7E56164B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiF3J3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiF3J26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:28:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2723A112
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656581338; x=1688117338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0DTG2u6m3ZJQ1eowa1Tp9B3y0nN+bfBmbgViftnv1Aw=;
  b=wmLZTUIjbmIGUYpqZesy0HS3bxOKc2Z+g/hYAiD8tM1eMTXB+SRU+2kv
   ZAZSyXj5rIScRJuPCfQc2XwLBOQVUDuQweDPn20/KXqJRXfoVpD5fIpXT
   y07KNbMYWD8MP05OuWpI/d11pENCHx9MFiqvVA6STFspv1Gc4CVSEJzxr
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Jun 2022 02:28:57 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 02:28:57 -0700
Received: from [10.50.30.42] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 30 Jun
 2022 02:28:52 -0700
Message-ID: <95d8e5c0-e382-4e8a-c8c6-2acbc0d31ca8@quicinc.com>
Date:   Thu, 30 Jun 2022 14:58:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] srcu: Reduce blocking agressiveness of expedited grace
 periods further
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <paulmck@kernel.org>, <frederic@kernel.org>,
        <josh@joshtriplett.org>, <rostedt@goodmis.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>, <linux-kernel@vger.kernel.org>,
        <zhangfei.gao@foxmail.com>, <boqun.feng@gmail.com>,
        <urezki@gmail.com>, <shameerali.kolothum.thodi@huawei.com>,
        <pbonzini@redhat.com>, <mtosatti@redhat.com>,
        <eric.auger@redhat.com>, <chenxiang66@hisilicon.com>
References: <20220630041201.18301-1-quic_neeraju@quicinc.com>
 <87o7ya1ozz.wl-maz@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <87o7ya1ozz.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2022 2:56 PM, Marc Zyngier wrote:
> On Thu, 30 Jun 2022 05:12:01 +0100,
> Neeraj Upadhyay <quic_neeraju@quicinc.com> wrote:
>>
>> Commit 640a7d37c3f4 ("srcu: Block less aggressively for expedited
>> grace periods") highlights a problem where aggressively blocking
>> SRCU expedited grace periods, as was introduced in commit
>> 282d8998e997 ("srcu: Prevent expedited GPs and blocking readers
>> from consuming CPU"), introduces ~2 minutes delay to the overall
>> ~3.5 minutes boot time, when starting VMs with "-bios QEMU_EFI.fd"
>> cmdline on qemu, which results in very high rate of memslots
>> add/remove, which causes > ~6000 synchronize_srcu() calls for
>> kvm->srcu SRCU instance.
>>
>> Below table captures the experiments done by Zhangfei Gao and Shameer
>> to measure the boottime impact with various values of non-sleeping
>> per phase counts, with HZ_250 and preemption enabled:
>>
>> +──────────────────────────+────────────────+
>> | SRCU_MAX_NODELAY_PHASE   | Boot time (s)  |
>> +──────────────────────────+────────────────+
>> | 100                      | 30.053         |
>> | 150                      | 25.151         |
>> | 200                      | 20.704         |
>> | 250                      | 15.748         |
>> | 500                      | 11.401         |
>> | 1000                     | 11.443         |
>> | 10000                    | 11.258         |
>> | 1000000                  | 11.154         |
>> +──────────────────────────+────────────────+
>>
>> Analysis on the experiment results showed improved boot time
>> with non blocking delays close to one jiffy duration. This
>> was also seen when number of per-phase iterations were scaled
>> to one jiffy.
>>
>> So, this change scales per-grace-period phase number of non-sleeping
>> polls, such that, non-sleeping polls are done for one jiffy. In addition
>> to this, srcu_get_delay() call in srcu_gp_end(), which is used to calculate
>> the delay used for scheduling callbacks, is replaced with the check for
>> expedited grace period. This is done, to schedule cbs for completed expedited
>> grace periods immediately, which results in improved boot time seen in
>> experiments.
>>
>> In addition to the changes to default per phase delays, this change
>> adds 3 new kernel parameters - srcutree.srcu_max_nodelay,
>> srcutree.srcu_max_nodelay_phase, srcutree.srcu_retry_check_delay.
>> This allows users to configure the srcu grace period scanning delays,
>> depending on their system configuration requirements.
>>
>> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
>> Tested-by: Marc Zyngier <maz@kernel.org>
>> ---
>>
>> Change in v2:
>>
>>    - Change srcu_max_nodelay default value to consider phase delay
>>      iterations
>>    - Apply Pauls' feedback
>>    - Add Marc's Tested-by
> 
> I gave this a go on the same platform as v1, and the result is
> actually much better as I didn't have to add any extra command-line
> option to get to a reasonable result (41s). I think we have a winner.
> 

Thank you for testing it!


Thanks
Neeraj

> Thanks again,
> 
> 	M.
> 
