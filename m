Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9454B2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbiFNOOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiFNOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:14:38 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CF28704;
        Tue, 14 Jun 2022 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655216076; x=1686752076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0uq+vPn9P86+eSA1af5GDSL4gdgJ3UTG153tOxE/IIg=;
  b=yh7alZGDRwLh+1n+KB2uLlOYjtsfBSD3tE5t5FxhC6NDkr0R65h2LT2S
   ImKBBlpwYpBi4jXCZhx09sLVzujwYOWpGcZPPn6J3UN22kha7HPmbqK/O
   kRdZhcetb5sqZIQLQgHGwTA5O9ZfIJqA7XeCqlmeTaaefiO1tfJDY/8TC
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 14 Jun 2022 07:14:36 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 07:14:34 -0700
Received: from [10.50.56.0] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 14 Jun
 2022 07:14:30 -0700
Message-ID: <88780123-32a3-ab34-cd3d-01e4a3421f03@quicinc.com>
Date:   Tue, 14 Jun 2022 19:44:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Content-Language: en-US
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <20220612162029.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220612164002.GA1242564@paulmck-ThinkPad-P17-Gen-1>
 <560f7d27-fe38-0db9-834a-50dda5fa6157@redhat.com>
 <20220612184944.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2022 7:33 PM, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>>
>>>
>>> 5.18-rc4 based               ~8sec
>>>
>>> 5.19-rc1                     ~2m43sec
>>>
>>> 5.19-rc1+fix1                 ~19sec
>>>
>>> 5.19-rc1-fix2                 ~19sec
>>>
>>
>> If you try below diff on top of either 5.19-rc1+fix1 or 5.19-rc1-fix2 
>> ; does it show any difference in boot time?
>>
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct 
>> srcu_struct *ssp, struct srcu_node *snp
>>   */
>>  static void srcu_gp_end(struct srcu_struct *ssp)
>>  {
>> -       unsigned long cbdelay;
>> +       unsigned long cbdelay = 1;
>>         bool cbs;
>>         bool last_lvl;
>>         int cpu;
>> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>         spin_lock_irq_rcu_node(ssp);
>>         idx = rcu_seq_state(ssp->srcu_gp_seq);
>>         WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>> -       cbdelay = !!srcu_get_delay(ssp);
>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), 
>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>> +               cbdelay = 0;
>> +
>>         WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>>
> Test here:
> qemu: https://github.com/qemu/qemu/tree/stable-6.1
> kernel: 
> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test
> (in case test patch not clear, push in git tree)
> 
> Hardware: aarch64
> 
> 1. 5.18-rc6
> real    0m8.402s
> user    0m3.015s
> sys     0m1.102s
> 
> 2. 5.19-rc1
> real    2m41.433s
> user    0m3.097s
> sys     0m1.177s
> 
> 3. 5.19-rc1 + fix1 from Paul
> real    2m43.404s
> user    0m2.880s
> sys     0m1.214s
> 
> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
> real    0m15.262s
> user    0m3.003s
> sys     0m1.033s
> 
> When build kernel in the meantime, load time become longer.
> 
> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
> real    0m15.215s
> user    0m2.942s
> sys    0m1.172s
> 
> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
> real    1m23.936s
> user    0m2.969s
> sys    0m1.181s
> 

Thanks for this data. Can you please share below test combo also?

7. 5.19-rc1 + fix5: fix2 + Neeraj's change of srcu_gp_end


8. 5.19-rc1 + fix6: fix3 + Neeraj's change of srcu_gp_end


Thanks
Neeraj

> More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5
> 
> Thanks
> 
