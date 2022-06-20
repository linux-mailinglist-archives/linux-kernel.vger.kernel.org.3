Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82B5511CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbiFTHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbiFTHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:50:13 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BB4DEEF;
        Mon, 20 Jun 2022 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655711410; x=1687247410;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9bseAGLoquYm0UqZ1tHZ+c6M6vrz0icTqW/GIa5ID4I=;
  b=VR1i5KoJy/oxcaEO13idgrkrzFPXjpJ0DUWAFKDrJILWkJsJYGbDOLcO
   VJO6gLtYJ9XqM/3yhio19hhGtwq271o6kOqb3WiL7Ycycf1VpUhBo3U9C
   D6hYGPvP6KH+R+U07PAzkwCWQjjoVHSaCroHp6C6mAsyDyzpjOl+6Bani
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Jun 2022 00:50:10 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 00:50:09 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 00:50:04 -0700
Message-ID: <3cf9b2de-39f6-34f1-b9de-19e5da8ddf8d@quicinc.com>
Date:   Mon, 20 Jun 2022 13:20:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
Content-Language: en-US
To:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        <paulmck@kernel.org>, zhangfei <zhangfei.gao@linaro.org>
CC:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        Auger Eric <eric.auger@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
References: <tencent_E306F58EAEC1D188ED6D5F358A269F34C707@qq.com>
 <20220613035711.GY1790663@paulmck-ThinkPad-P17-Gen-1>
 <20220613041652.GA3976000@paulmck-ThinkPad-P17-Gen-1>
 <tencent_F82250B6E3D51A9AC0D2BE1AE43A4E060909@qq.com>
 <20220613121831.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_65C7D0A04984EDB6A79A5E5379DA7E835206@qq.com>
 <20220613145900.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <7b6c983b21d44119b61716a66de397ed@huawei.com>
 <f9684a69-5467-a440-abd1-7cf5ad3a81f7@quicinc.com>
 <tencent_8FD344DA7FC376C7D1204604DA7689DA4906@qq.com>
 <20220614141712.GR1790663@paulmck-ThinkPad-P17-Gen-1>
 <tencent_DFF5A6C9352C76C00C7E46E06F2BA945350A@qq.com>
 <042142db-aab2-fc4a-c1a5-371223c80440@quicinc.com>
 <tencent_B1290D581DF1837711F4DB176ACB4D4F6908@qq.com>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <tencent_B1290D581DF1837711F4DB176ACB4D4F6908@qq.com>
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

Hi,


On 6/18/2022 8:37 AM, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/6/15 下午6:40, Neeraj Upadhyay wrote:
>> Hi,
>>
>> On 6/15/2022 2:33 PM, zhangfei.gao@foxmail.com wrote:
>>>
>>>
>>> On 2022/6/14 下午10:17, Paul E. McKenney wrote:
>>>> On Tue, Jun 14, 2022 at 10:03:35PM +0800, zhangfei.gao@foxmail.com 
>>>> wrote:
>>>>>
>>>>> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>>>>>>> 5.18-rc4 based               ~8sec
>>>>>>>
>>>>>>> 5.19-rc1                     ~2m43sec
>>>>>>>
>>>>>>> 5.19-rc1+fix1                 ~19sec
>>>>>>>
>>>>>>> 5.19-rc1-fix2                 ~19sec
>>>>>>>
>>>>>> If you try below diff on top of either 5.19-rc1+fix1 or 
>>>>>> 5.19-rc1-fix2 ;
>>>>>> does it show any difference in boot time?
>>>>>>
>>>>>> --- a/kernel/rcu/srcutree.c
>>>>>> +++ b/kernel/rcu/srcutree.c
>>>>>> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct 
>>>>>> srcu_struct
>>>>>> *ssp, struct srcu_node *snp
>>>>>>    */
>>>>>>   static void srcu_gp_end(struct srcu_struct *ssp)
>>>>>>   {
>>>>>> -       unsigned long cbdelay;
>>>>>> +       unsigned long cbdelay = 1;
>>>>>>          bool cbs;
>>>>>>          bool last_lvl;
>>>>>>          int cpu;
>>>>>> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>>>>>          spin_lock_irq_rcu_node(ssp);
>>>>>>          idx = rcu_seq_state(ssp->srcu_gp_seq);
>>>>>>          WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>>>>>> -       cbdelay = !!srcu_get_delay(ssp);
>>>>>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>>>>>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>>>>> +               cbdelay = 0;
>>>>>> +
>>>>>>          WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>>>> Thank you both for the testing and the proposed fix!
>>>>
>>>>> Test here:
>>>>> qemu: https://github.com/qemu/qemu/tree/stable-6.1
>>>>> kernel:
>>>>> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test 
>>>>>
>>>>> (in case test patch not clear, push in git tree)
>>>>>
>>>>> Hardware: aarch64
>>>>>
>>>>> 1. 5.18-rc6
>>>>> real    0m8.402s
>>>>> user    0m3.015s
>>>>> sys     0m1.102s
>>>>>
>>>>> 2. 5.19-rc1
>>>>> real    2m41.433s
>>>>> user    0m3.097s
>>>>> sys     0m1.177s
>>>>>
>>>>> 3. 5.19-rc1 + fix1 from Paul
>>>>> real    2m43.404s
>>>>> user    0m2.880s
>>>>> sys     0m1.214s
>>>>>
>>>>> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
>>>>> real    0m15.262s
>>>>> user    0m3.003s
>>>>> sys     0m1.033s
>>>>>
>>>>> When build kernel in the meantime, load time become longer.
>>>>>
>>>>> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
>>>>> real    0m15.215s
>>>>> user    0m2.942s
>>>>> sys    0m1.172s
>>>>>
>>>>> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
>>>>> real    1m23.936s
>>>>> user    0m2.969s
>>>>> sys    0m1.181s
>>>> And thank you for the testing!
>>>>
>>>> Could you please try fix3 + Neeraj's change of srcu_gp_end?
>>>>
>>>> That is, fix1 + SRCU_MAX_NODELAY_PHASE 1000000 + Neeraj's change of
>>>> srcu_gp_end.
>>>>
>>>> Also, at what value of SRCU_MAX_NODELAY_PHASE do the boot
>>>> times start rising?  This is probably best done by starting with
>>>> SRCU_MAX_NODELAY_PHASE=100000 and dividing by (say) ten on each run
>>>> until boot time becomes slow, followed by a binary search between the
>>>> last two values.  (The idea is to bias the search so that fast boot
>>>> times are the common case.)
>>>
>>> SRCU_MAX_NODELAY_PHASE 100 becomes slower.
>>>
>>>
>>> 8. 5.19-rc1 + fix6: fix4 + SRCU_MAX_NODELAY_PHASE 1000000
>>>
>>> real 0m11.154s ~12s
>>>
>>> user 0m2.919s
>>>
>>> sys 0m1.064s
>>>
>>>
>>>
>>> 9. 5.19-rc1 + fix7: fix4 + SRCU_MAX_NODELAY_PHASE 10000
>>>
>>> real 0m11.258s
>>>
>>> user 0m3.113s
>>>
>>> sys 0m1.073s
>>>
>>>
>>>
>>> 10. 5.19-rc1 + fix8: fix4 + SRCU_MAX_NODELAY_PHASE 100
>>>
>>> real 0m30.053s ~ 32s
>>>
>>> user 0m2.827s
>>>
>>> sys 0m1.161s
>>>
>>>
>>>
>>> By the way, if build kernel on the board in the meantime (using 
>>> memory), time become much longer.
>>>
>>> real 1m2.763s
>>>
>>>
>>>
>>> 11. 5.19-rc1 + fix9: fix4 + SRCU_MAX_NODELAY_PHASE 1000
>>>
>>> real 0m11.443s
>>>
>>> user 0m3.022s
>>>
>>> sys 0m1.052s
>>>
>>>
>>
>> This is useful data, thanks! Did you get chance to check between 100 
>> and 1000, to narrow down further, from which point (does need to be 
>> exact value) between 100 and 1000,  you start seeing degradation at, 
>> for ex. 250, 500 , ...?
>>
>> Is it also possible to try experiment 10 and 11 with below diff.
>> What I have done in below diff is, call srcu_get_delay() only once
>> in try_check_zero() (and not for every loop iteration); also
>> retry with a different delay for the extra iteration which is done
>> when srcu_get_delay(ssp) returns 0.
>>
>> Once we have this data, can you also try by changing 
>> SRCU_RETRY_CHECK_LONG_DELAY   to 100, on top of below diff.
>>
>> #define SRCU_RETRY_CHECK_LONG_DELAY  100
>>
>> -------------------------------------------------------------------------
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index 6a354368ac1d..3aff2f3e99ab 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -620,6 +620,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
>>   * we repeatedly block for 1-millisecond time periods.
>>   */
>>  #define SRCU_RETRY_CHECK_DELAY         5
>> +#define SRCU_RETRY_CHECK_LONG_DELAY            5
>>
>>  /*
>>   * Start an SRCU grace period.
>> @@ -927,12 +928,17 @@ static void srcu_funnel_gp_start(struct 
>> srcu_struct *ssp, struct srcu_data *sdp,
>>   */
>>  static bool try_check_zero(struct srcu_struct *ssp, int idx, int 
>> trycount)
>>  {
>> +       unsigned long curdelay;
>> +       curdelay = !srcu_get_delay(ssp);
>>         for (;;) {
>>                 if (srcu_readers_active_idx_check(ssp, idx))
>>                         return true;
>> -               if (--trycount + !srcu_get_delay(ssp) <= 0)
>> +               if (--trycount + curdelay <= 0)
>>                         return false;
>> -               udelay(SRCU_RETRY_CHECK_DELAY);
>> +               if (trycount)
>> +                       udelay(SRCU_RETRY_CHECK_DELAY);
>> +               else
>> +                       udelay(SRCU_RETRY_CHECK_LONG_DELAY);
>>         }
>>  }
>>
> 
> 11. 5.19-rc1 + fix9: fix4 + SRCU_MAX_NODELAY_PHASE 1000
>   real    0m11.443
> s user    0m3.022
> s sys    0m1.052s
> 
> fix10: fix4 + SRCU_MAX_NODELAY_PHASE 500
> 
> real    0m11.401s
> user    0m2.798s
> sys     0m1.328s
> 
> 
> fix11: fix4 + SRCU_MAX_NODELAY_PHASE 250
> 
>      real    0m15.748s
>      user    0m2.781s
>      sys     0m1.294s
> 
> 
> fix12: fix4 + SRCU_MAX_NODELAY_PHASE 200
> 
>      real    0m20.704s  21
>      user    0m2.954s
>      sys     0m1.226s
> 
> fix13: fix4 + SRCU_MAX_NODELAY_PHASE 150
> 
>      real    0m25.151s
>      user    0m2.980s
>      sys     0m1.256s
> 
> 
> fix8: fix4 + SRCU_MAX_NODELAY_PHASE 100
> real    0m30.053s ~ 32s
>   user    0m2.827s
>   sys    0m1.161s
> 
> 
> fix14: fix4 + SRCU_MAX_NODELAY_PHASE 100 + SRCU_RETRY_CHECK_LONG_DELAY 5
> 
>      real    0m19.263s
>      user    0m3.018s
>      sys     0m1.211s
> 
> 
> 
>      fix15: fix4 + SRCU_MAX_NODELAY_PHASE 100 + 
> SRCU_RETRY_CHECK_LONG_DELAY 100
> 
>      real    0m9.347s
>      user    0m3.132s
>      sys     0m1.041s
> 
> 

Thanks. From the data and experiments done, looks to me that we get
comparable (to 5.18-rc4 ) timings, when we retry without sleep for time 
duration close to 4-5 ms, which could be closer to the configured HZ (as 
it is 250)? Is it possible to try below configuration on top of  fix15?
If possible can you try with both HZ_1000 and HZ_250?
As multiple fixes are getting combined in experiments, for clarity, 
please also share the diff of srcutree.c (on top of baseline) for all 
experiments.

16. fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() calls) + 
(long delay scaled to 1 jiffy)


#define SRCU_MAX_NODELAY_TRY_CHECK_PHASE       10
#define SRCU_MAX_NODELAY_PHASE (SRCU_MAX_NODELAY_TRY_CHECK_PHASE * 2)
#define SRCU_RETRY_CHECK_LONG_DELAY           \
   (USEC_PER_SEC / HZ / SRCU_MAX_NODELAY_TRY_CHECK_PHASE)


17. fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() calls) + 
(long delay scaled to 2 jiffy)

#define SRCU_RETRY_CHECK_LONG_DELAY        \
      (2 * USEC_PER_SEC / HZ / SRCU_MAX_NODELAY_TRY_CHECK_PHASE)

18. fix15 + SRCU_MAX_NODELAY_PHASE 20 (10 try_check_zero() calls) + 
(long delay scaled to 1/2 jiffy)

#define SRCU_RETRY_CHECK_LONG_DELAY      \
        (USEC_PER_SEC / HZ / SRCU_MAX_NODELAY_TRY_CHECK_PHASE / 2)



Thanks
Neeraj

> And  Shameer suggests this method, to decrease region_add/del time from 
> 6000+ to 200+, also works on 5.19-rc1
> 
> Make the EFI flash image file
> $ dd if=/dev/zero of=flash0.img bs=1M count=64
> $ dd if=./QEMU_EFI-2022.fd of=flash0.img conv=notrunc
> $ dd if=/dev/zero of=flash1.img bs=1M count=64
> Include the below line instead of "-bios QEMU_EFI.fd" in Qemu cmd line.
> -pflash flash0.img -pflash flash1.img \
> 

Thanks for sharing this wa info!
> 
> 
> Thanks
> 
>>
>> Thanks
>> Neeraj
>>
>>> Thanks
>>>
>>>>
>>>>> More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5
>>>> And thank you for these details.
>>>>
>>>>                             Thanx, Paul
>>>
> 
