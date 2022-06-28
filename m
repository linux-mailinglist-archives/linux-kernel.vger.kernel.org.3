Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1C55DF0C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbiF1JRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbiF1JRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:17:34 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B752186C2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656407853; x=1687943853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wrax32PwvedZxjaRNxkBwT6yVi7BY94I002uISo0sL8=;
  b=VpOKYmK40xOI1LclSSYYR+xkfHqz0P19p40VW3I6j4AHI2qy07orrLJX
   MwpPqF7q7YIGwgZOnHEPMWLNu8Knyrq062NetjA67omOup0rJ6r7TW7l6
   rvVrqu1o29N2UwkTTG/CbxEIfmT0wuG8hLMckMH1c3V6U0Vf/1snKFbBP
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jun 2022 02:17:32 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 02:17:32 -0700
Received: from [10.50.26.93] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 28 Jun
 2022 02:17:27 -0700
Message-ID: <dc24db89-05ae-c113-6728-de797e041123@quicinc.com>
Date:   Tue, 28 Jun 2022 14:47:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] srcu: Reduce blocking agressiveness of expedited grace
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
References: <20220627123706.20187-1-quic_neeraju@quicinc.com>
 <875ykl2mb2.wl-maz@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <875ykl2mb2.wl-maz@kernel.org>
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



On 6/28/2022 2:32 PM, Marc Zyngier wrote:
> On Mon, 27 Jun 2022 13:37:06 +0100,
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
>> Below table captures the experiments done by Zhangfei Gao, Shameer,
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
>> polls, soiuch that, non-sleeping polls are done for one jiffy. In addition
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
> 
> I've given this a go on one of my test platforms (the one I noticed
> the issue on the first place), and found that the initial part of the
> EFI boot under KVM (pointlessly wiping the emulated flash) went down
> to 1m7s from 3m50s (HZ=250).
> 
> Clearly a massive improvement, but still a far cry from the original
> ~40s (yes, this box is utter crap -- which is why I use it).

Do you see any improvement by using "srcutree.srcu_max_nodelay=1000" 
bootarg, on top of this patch?

> 
> Anyway:
> 
> Tested-by: Marc Zyngier <maz@kernel.org>

Thanks!


Thanks
Neeraj

> 
> 	M.
> 
