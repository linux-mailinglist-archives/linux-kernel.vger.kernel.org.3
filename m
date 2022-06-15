Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C169654C426
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbiFOJDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346973AbiFOJDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:03:45 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888EF377DD;
        Wed, 15 Jun 2022 02:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1655283819;
        bh=yGIqFbDVhQfi98uNwz2qN9S7Yz1LlnTD2FVmVtOJuoc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=xOxEubHg2PIyspkaCjgtnDtkQEp1jiPp+bjp+4cpdpkBjCMkLhAJjl/fyj/uKOtR4
         61nRMwNpwROhep+rbDT9X89rkt2eZTwAGqYhf88tZ3J3GIhmAe1qzzWFH82oXsAMCI
         FFGMqZ3VDyB6+sRdb1K1WDjLbANiOspSYkjbSDLk=
Received: from [IPv6:240e:45a:40b:32d5:40d9:41b7:4f55:3d8c] ([240e:45a:40b:32d5:40d9:41b7:4f55:3d8c])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id E23AAD9; Wed, 15 Jun 2022 17:03:34 +0800
X-QQ-mid: xmsmtpt1655283814t564lhbpz
Message-ID: <tencent_DFF5A6C9352C76C00C7E46E06F2BA945350A@qq.com>
X-QQ-XMAILINFO: NRN3UPsLzYKVaynmbzMu4xCIrguRMpEbttgHReiCH60WykTo9hEpBjRwxhmIbj
         T8pZ24gNhkEKV57Zuw8HWDrADwR8sZBaDfpcf8+jOe0P25Mapb2wSBPHBt9HzYUw+AA/+k0DHtFF
         xOFyHKPqwkve/1mAmYM3Uk25STpggNGuiBIhgtL2TzwFwwaxEAxw++OyH71DuWneAXkZ9P+OsgC1
         +QVKEWsC3heif3Oa4ZagQtsQVKvCxxqtdajg4uyNTSSpBAtb87qSC4grg2Gu72jVY68HXMuOwJbn
         e7Nqd98FRvrnTyvxqjGiRI0YMzF3FBrN2PiMGo/0lSIBxEMpVN47pSMYQfpJzD26wes3Ya+AEMoq
         SZR0Su4gMZf5L0ZXw1OtCRuA4XO5mJVJYY6husaGS1I2hLTEw1iV1UGs6u9YtRDvdEYmMPBR+zI+
         uimGIHlNecjHrnc9yoldrSj0iqSjKMWLswj/U+C4fpwEhzCqYbr590FHyqnj7OJp+ClVFWMMOXS9
         Ng9abCvxKkgZRw/+2I3AsJrdXcKUL6uoZXzeGULJLdT4/3eyDsatGStHH0VQkNxhWFJHjhJ+rWc8
         tL1K4J0krxxNgXKIHfFkLIdVIVZjT5CAvBkC0JTzTk5n58xXoTnhB4wNXzY5iHozUY4WXXcM3aEV
         0iqj3SF3l4JDAMkKv3oXfXpuudJNrc5m3PojbwjcBHHjVsUK3tVUJP+haqkIhAl0/5sga2Y3tX3T
         Zrrbt1P+W5BQZIgcFJYT2ZSDWibMyg2x8N+nBTfw65ns71AmehiNpSjEf7/+rJJBYGR3l7noSCkP
         7SHii7tg+Eyx38/m/+mcOfzVg/OhL+ceEw0Dzo6YV/Lzew9qR0EjvshuWlzfOBJZmlvameNRgVVp
         K3BKxwhfLmMoCmpXc9Psy2bTkdPzIsm+p5brTct57eg/qwLDT+U1FYxlCJR0eJ6k/MXqAGs4HvsO
         TvcPfIjXTXFp+cruBO62nr28RUXpVmpukTKQq3gcQ=
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
To:     paulmck@kernel.org, zhangfei <zhangfei.gao@linaro.org>
Cc:     Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
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
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
X-OQ-MSGID: <bc281849-bc1e-54f2-2526-1df294cde6e0@foxmail.com>
Date:   Wed, 15 Jun 2022 17:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220614141712.GR1790663@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/14 下午10:17, Paul E. McKenney wrote:
> On Tue, Jun 14, 2022 at 10:03:35PM +0800, zhangfei.gao@foxmail.com wrote:
>>
>> On 2022/6/14 下午8:19, Neeraj Upadhyay wrote:
>>>> 5.18-rc4 based               ~8sec
>>>>
>>>> 5.19-rc1                     ~2m43sec
>>>>
>>>> 5.19-rc1+fix1                 ~19sec
>>>>
>>>> 5.19-rc1-fix2                 ~19sec
>>>>
>>> If you try below diff on top of either 5.19-rc1+fix1 or 5.19-rc1-fix2 ;
>>> does it show any difference in boot time?
>>>
>>> --- a/kernel/rcu/srcutree.c
>>> +++ b/kernel/rcu/srcutree.c
>>> @@ -706,7 +706,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct
>>> *ssp, struct srcu_node *snp
>>>    */
>>>   static void srcu_gp_end(struct srcu_struct *ssp)
>>>   {
>>> -       unsigned long cbdelay;
>>> +       unsigned long cbdelay = 1;
>>>          bool cbs;
>>>          bool last_lvl;
>>>          int cpu;
>>> @@ -726,7 +726,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
>>>          spin_lock_irq_rcu_node(ssp);
>>>          idx = rcu_seq_state(ssp->srcu_gp_seq);
>>>          WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
>>> -       cbdelay = !!srcu_get_delay(ssp);
>>> +       if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq),
>>> READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
>>> +               cbdelay = 0;
>>> +
>>>          WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
> Thank you both for the testing and the proposed fix!
>
>> Test here:
>> qemu: https://github.com/qemu/qemu/tree/stable-6.1
>> kernel:
>> https://github.com/Linaro/linux-kernel-uadk/tree/uacce-devel-5.19-srcu-test
>> (in case test patch not clear, push in git tree)
>>
>> Hardware: aarch64
>>
>> 1. 5.18-rc6
>> real    0m8.402s
>> user    0m3.015s
>> sys     0m1.102s
>>
>> 2. 5.19-rc1
>> real    2m41.433s
>> user    0m3.097s
>> sys     0m1.177s
>>
>> 3. 5.19-rc1 + fix1 from Paul
>> real    2m43.404s
>> user    0m2.880s
>> sys     0m1.214s
>>
>> 4. 5.19-rc1 + fix2: fix1 + Remove "if (!jbase)" block
>> real    0m15.262s
>> user    0m3.003s
>> sys     0m1.033s
>>
>> When build kernel in the meantime, load time become longer.
>>
>> 5. 5.19-rc1 + fix3: fix1 + SRCU_MAX_NODELAY_PHASE 1000000
>> real    0m15.215s
>> user    0m2.942s
>> sys    0m1.172s
>>
>> 6. 5.19-rc1 + fix4: fix1 + Neeraj's change of srcu_gp_end　
>> real    1m23.936s
>> user    0m2.969s
>> sys    0m1.181s
> And thank you for the testing!
>
> Could you please try fix3 + Neeraj's change of srcu_gp_end?
>
> That is, fix1 + SRCU_MAX_NODELAY_PHASE 1000000 + Neeraj's change of
> srcu_gp_end.
>
> Also, at what value of SRCU_MAX_NODELAY_PHASE do the boot
> times start rising?  This is probably best done by starting with
> SRCU_MAX_NODELAY_PHASE=100000 and dividing by (say) ten on each run
> until boot time becomes slow, followed by a binary search between the
> last two values.  (The idea is to bias the search so that fast boot
> times are the common case.)

SRCU_MAX_NODELAY_PHASE 100 becomes slower.


8. 5.19-rc1 + fix6: fix4 + SRCU_MAX_NODELAY_PHASE 1000000

real 0m11.154s ~12s

user 0m2.919s

sys 0m1.064s



9. 5.19-rc1 + fix7: fix4 + SRCU_MAX_NODELAY_PHASE 10000

real 0m11.258s

user 0m3.113s

sys 0m1.073s



10. 5.19-rc1 + fix8: fix4 + SRCU_MAX_NODELAY_PHASE 100

real 0m30.053s ~ 32s

user 0m2.827s

sys 0m1.161s



By the way, if build kernel on the board in the meantime (using memory), 
time become much longer.

real 1m2.763s



11. 5.19-rc1 + fix9: fix4 + SRCU_MAX_NODELAY_PHASE 1000

real 0m11.443s

user 0m3.022s

sys 0m1.052s


Thanks

>
>> More test details: https://docs.qq.com/doc/DRXdKalFPTVlUbFN5
> And thank you for these details.
>
> 							Thanx, Paul

