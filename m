Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41054C663
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiFOKlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351123AbiFOKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:41:06 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C17F50E21;
        Wed, 15 Jun 2022 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655289661; x=1686825661;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w8/bDFESw1idEzx4HeTn+ye9EHUiCCtSlzeqYlYWtGk=;
  b=k+vShKq5VOvfpOvvwcThhULpbNe4YaXHMhb2Wsn3I+jR7j78cgPoWL2h
   buiu8oTCPtrWOf4QHFbtPS/16QWIfWUELVesoj1+v3+mK4C/SWxJ0ZZYw
   byv0q+ApE/dcZh4EOY+O2bneC6xdeKu1u5cidGe04x0J7qONaVy56yIwD
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Jun 2022 03:41:00 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 03:40:59 -0700
Received: from [10.50.37.107] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 15 Jun
 2022 03:40:22 -0700
Message-ID: <042142db-aab2-fc4a-c1a5-371223c80440@quicinc.com>
Date:   Wed, 15 Jun 2022 16:10:18 +0530
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
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <tencent_DFF5A6C9352C76C00C7E46E06F2BA945350A@qq.com>
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

Hi,

On 6/15/2022 2:33 PM, zhangfei.gao@foxmail.com wrote:
> 
> 
> On 2022/6/14 下午10:17, Paul E. McKenney wrote:
>> On Tue, Jun 14, 2022 at 10:03:35PM +0800, zhangfei.gao@foxmail.com wrote:
>>>
>>> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>>>>> 5.18-rc4 based               ~8sec
>>>>>
>>>>> 5.19-rc1                     ~2m43sec
>>>>>
>>>>> 5.19-rc1+fix1                 ~19sec
>>>>>
>>>>> 5.19-rc1-fix2                 ~19sec
>>>>>
>>>> If you try below diff on top of either 5.19-rc1+fix1 or 5.19-rc1-fix2 ;
>>>> does it show any difference in boot time?
>>>>
>>>> --- a/kernel/rcu/srcutree.c
>>>> +++ b/kernel/rcu/srcutree.c
>>>> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct 
>>>> srcu_struct
>>>> *ssp, struct srcu_node *snp
>>>>    */
>>>>   static void srcu_gp_end(struct srcu_struct *ssp)
>>>>   {
>>>> -       unsigned long cbdelay;
>>>> +       unsigned long cbdelay = 1;
>>>>          bool cbs;
>>>>          bool last_lvl;
>>>>          int cpu;
>>>> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>>>          spin_lock_irq_rcu_node(ssp);
>>>>          idx = rcu_seq_state(ssp->srcu_gp_seq);
>>>>          WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>>>> -       cbdelay = !!srcu_get_delay(ssp);
>>>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>>>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>>> +               cbdelay = 0;
>>>> +
>>>>          WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
>> Thank you both for the testing and the proposed fix!
>>
>>> Test here:
>>> qemu: https://github.com/qemu/qemu/tree/stable-6.1
>>> kernel:
>>> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test 
>>>
>>> (in case test patch not clear, push in git tree)
>>>
>>> Hardware: aarch64
>>>
>>> 1. 5.18-rc6
>>> real    0m8.402s
>>> user    0m3.015s
>>> sys     0m1.102s
>>>
>>> 2. 5.19-rc1
>>> real    2m41.433s
>>> user    0m3.097s
>>> sys     0m1.177s
>>>
>>> 3. 5.19-rc1 + fix1 from Paul
>>> real    2m43.404s
>>> user    0m2.880s
>>> sys     0m1.214s
>>>
>>> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
>>> real    0m15.262s
>>> user    0m3.003s
>>> sys     0m1.033s
>>>
>>> When build kernel in the meantime, load time become longer.
>>>
>>> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
>>> real    0m15.215s
>>> user    0m2.942s
>>> sys    0m1.172s
>>>
>>> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
>>> real    1m23.936s
>>> user    0m2.969s
>>> sys    0m1.181s
>> And thank you for the testing!
>>
>> Could you please try fix3 + Neeraj's change of srcu_gp_end?
>>
>> That is, fix1 + SRCU_MAX_NODELAY_PHASE 1000000 + Neeraj's change of
>> srcu_gp_end.
>>
>> Also, at what value of SRCU_MAX_NODELAY_PHASE do the boot
>> times start rising?  This is probably best done by starting with
>> SRCU_MAX_NODELAY_PHASE=100000 and dividing by (say) ten on each run
>> until boot time becomes slow, followed by a binary search between the
>> last two values.  (The idea is to bias the search so that fast boot
>> times are the common case.)
> 
> SRCU_MAX_NODELAY_PHASE 100 becomes slower.
> 
> 
> 8. 5.19-rc1 + fix6: fix4 + SRCU_MAX_NODELAY_PHASE 1000000
> 
> real 0m11.154s ~12s
> 
> user 0m2.919s
> 
> sys 0m1.064s
> 
> 
> 
> 9. 5.19-rc1 + fix7: fix4 + SRCU_MAX_NODELAY_PHASE 10000
> 
> real 0m11.258s
> 
> user 0m3.113s
> 
> sys 0m1.073s
> 
> 
> 
> 10. 5.19-rc1 + fix8: fix4 + SRCU_MAX_NODELAY_PHASE 100
> 
> real 0m30.053s ~ 32s
> 
> user 0m2.827s
> 
> sys 0m1.161s
> 
> 
> 
> By the way, if build kernel on the board in the meantime (using memory), 
> time become much longer.
> 
> real 1m2.763s
> 
> 
> 
> 11. 5.19-rc1 + fix9: fix4 + SRCU_MAX_NODELAY_PHASE 1000
> 
> real 0m11.443s
> 
> user 0m3.022s
> 
> sys 0m1.052s
> 
> 

This is useful data, thanks! Did you get chance to check between 100 and 
1000, to narrow down further, from which point (does need to be exact 
value) between 100 and 1000,  you start seeing degradation at, for ex. 
250, 500 , ...?

Is it also possible to try experiment 10 and 11 with below diff.
What I have done in below diff is, call srcu_get_delay() only once
in try_check_zero() (and not for every loop iteration); also
retry with a different delay for the extra iteration which is done
when srcu_get_delay(ssp) returns 0.

Once we have this data, can you also try by changing 
SRCU_RETRY_CHECK_LONG_DELAY   to 100, on top of below diff.

#define SRCU_RETRY_CHECK_LONG_DELAY  100

-------------------------------------------------------------------------
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6a354368ac1d..3aff2f3e99ab 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -620,6 +620,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
   * we repeatedly block for 1-millisecond time periods.
   */
  #define SRCU_RETRY_CHECK_DELAY         5
+#define SRCU_RETRY_CHECK_LONG_DELAY            5

  /*
   * Start an SRCU grace period.
@@ -927,12 +928,17 @@ static void srcu_funnel_gp_start(struct 
srcu_struct *ssp, struct srcu_data *sdp,
   */
  static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
  {
+       unsigned long curdelay;
+       curdelay = !srcu_get_delay(ssp);
         for (;;) {
                 if (srcu_readers_active_idx_check(ssp, idx))
                         return true;
-               if (--trycount + !srcu_get_delay(ssp) <= 0)
+               if (--trycount + curdelay <= 0)
                         return false;
-               udelay(SRCU_RETRY_CHECK_DELAY);
+               if (trycount)
+                       udelay(SRCU_RETRY_CHECK_DELAY);
+               else
+                       udelay(SRCU_RETRY_CHECK_LONG_DELAY);
         }
  }


Thanks
Neeraj

> Thanks
> 
>>
>>> More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5
>> And thank you for these details.
>>
>>                             Thanx, Paul
> 
