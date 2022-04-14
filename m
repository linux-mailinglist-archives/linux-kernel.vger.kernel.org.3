Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DB1500961
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbiDNJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbiDNJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:12:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21475237F8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:09:37 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220414090933euoutp0132e7ae59bd0c9317e0f0f4c9fdc31bce~luDRmPOSE1475214752euoutp01B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:09:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220414090933euoutp0132e7ae59bd0c9317e0f0f4c9fdc31bce~luDRmPOSE1475214752euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1649927373;
        bh=SJhafutulbBWjzAisdgiv8bTYPPaJSbWbzRNCT2AawM=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=ps39xRjtCmm1KZJnAFkkQ/UDXx5Z/mFp/kRPdLHNj/LAelYNbtdBqeIXrkWF+UiUL
         1Krm3RzcwvySqz3WtyNFscVqRv5MEPCJ7eTGweGMwe2EiB3ArxTRjC40Pib6TLfKUX
         KzWl2F4yvwdOH0AFvSvL/z+Zf7uXFHqBdcsmNIZk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220414090933eucas1p16092ef022fca5dbe50d7aba922ef7d99~luDRN5iOp2338823388eucas1p1K;
        Thu, 14 Apr 2022 09:09:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 85.8B.10260.DC4E7526; Thu, 14
        Apr 2022 10:09:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220414090932eucas1p1afda292fc36692803a47a7e79b0fc6a7~luDQ737Xx0214502145eucas1p1z;
        Thu, 14 Apr 2022 09:09:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220414090932eusmtrp1222f7dab9584c1a79770ce400728ef6d~luDQ7HOo51392013920eusmtrp1Y;
        Thu, 14 Apr 2022 09:09:32 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-00-6257e4cd5483
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.88.09522.CC4E7526; Thu, 14
        Apr 2022 10:09:32 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220414090932eusmtip1b5ff89fc6eddcecd7e22a89529125b2f~luDQd7RaV1863918639eusmtip18;
        Thu, 14 Apr 2022 09:09:32 +0000 (GMT)
Message-ID: <5dcf8d22-e9b3-f306-4c5f-256707e08fbf@samsung.com>
Date:   Thu, 14 Apr 2022 11:09:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <878rs8c2t2.wl-maz@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7pnn4QnGXQ84rW41LqJ3WLT/iZW
        i/PnN7BbXN41h81ixvl9TBY755xktdi8aSqzxdTXWxgdODwWbCr1aDnyltVj06pONo93586x
        e3zeJBfAGsVlk5Kak1mWWqRvl8CVseTrXpaCZqeK11NkGxhPmXcxcnJICJhIfD29g6WLkYtD
        SGAFo8T2I5eZIJwvjBKPHx6FynxmlPj26RMTTMuzRRMYIRLLGSXOT5vBDOF8ZJR42LuSGaSK
        V8BOYvbi+WwgNouAqsTarpmsEHFBiZMzn7CA2KICSRJz990DqxcW8JGYcvEEI4jNLCAucevJ
        fLBtIgKKEp8unISKb2GS2LwhC8RmEzCU6HrbBTafU0BbYsnhS2wQNfISzVtngx0kIfCEQ+LB
        qhXsEGe7SFzZ1coKYQtLvDq+BSouI3F6cg/QQRxAdr7E3xnGEOEKiWuv1zBD2NYSd879YgMp
        YRbQlFi/Sx8i7CjRfvQ5M0Qnn8SNt4IQF/BJTNo2HSrMK9HRJgRRrSYx6/g6uJ0HL1xinsCo
        NAspTGYh+X0Wkl9mIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzANnf53/OsO
        xhWvPuodYmTiYDzEKMHBrCTCe7M/PEmINyWxsiq1KD++qDQntfgQozQHi5I4b3LmhkQhgfTE
        ktTs1NSC1CKYLBMHp1QD08J9yWvfChotl91+5Yab2Frzu4bLzOI9xddcsJow32Wi/WHT9pj7
        C9Tl/VgP25ix/n6/uStpk/qTT33azz4pMzsIb+4MXBh21PFyQ9M83/rsmu6T+maXwr/EfjnS
        9nnz+vu7fvn17tP5dH/hh5Dk1pxzSz96c0xt/JHszHPZ89Xb1Mm/r6drJfcedGEsrIw5d1pr
        YwHXxxsrWZc+6jsrwqCdNeHXQv8K78qT0170JfS0PlLPSnu1+fyzqgviZUJXfzyY4xpRLp3i
        9+z17NqfT5axOTIbsM3ar91vEMlbG3DutN2GnD0rNMvW3nWy6I/Zq7v6jvVzt02FYlMayjdc
        2rfMXqtGXTZPt+agpMJsWyWW4oxEQy3mouJEAH4rk+KyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7pnnoQnGZzaa25xqXUTu8Wm/U2s
        FufPb2C3uLxrDpvFjPP7mCx2zjnJarF501Rmi6mvtzA6cHgs2FTq0XLkLavHplWdbB7vzp1j
        9/i8SS6ANUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjf
        LkEvY8nXvSwFzU4Vr6fINjCeMu9i5OSQEDCReLZoAmMXIxeHkMBSRokrK78wQiRkJE5Oa2CF
        sIUl/lzrYoMoes8o8ffwZhaQBK+AncTsxfPZQGwWAVWJtV0zWSHighInZz4BqxEVSJJ4se05
        2FBhAR+JKRdPgNnMAuISt57MZwKxRQQUJT5dOAl2BbPAFiaJg7t2QZ3UySRxZnE32FQ2AUOJ
        rrddYNs4BbQllhy+xAYxyUyia2sX1FR5ieats5knMArNQnLILCQLZyFpmYWkZQEjyypGkdTS
        4tz03GJDveLE3OLSvHS95PzcTYzA+Nt27OfmHYzzXn3UO8TIxMF4iFGCg1lJhPdmf3iSEG9K
        YmVValF+fFFpTmrxIUZTYGhMZJYSTc4HJoC8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS
        1OzU1ILUIpg+Jg5OqQamlo1aTceWvzYI7Lpha2iYOL/Tj+nBNT3/bTcMPsZMLD7Gxreg51Po
        HqH1pW3zF51/sE5q5p7w7hq+PSWyTM6XrxbvkBQo+WFpOGdq5jyNCIajOUGC/gmNmTUeeXnP
        bp778E8j9/kK7Y+3zyX9XKNcePfflTpj1xa1Y89L6xb/ezQn+7si++rGu9dOm5xcK/v97ewj
        6hzSm/6HOIY0/llcOOnN2S/LNL5OCJv/vfFeyiHOiw1Sp6d/W1NQtHH13lPP+NhNYl/bPr9/
        Y9akg1MULV780FLRknjztWrGFv+Fi00tWMU38wgem+TFP/fmdw7ei/WCJV1/BHnsu+wvORbv
        CT5ks9bV+8f787eXdr98eFuJpTgj0VCLuag4EQCHZp5+SAMAAA==
X-CMS-MailID: 20220414090932eucas1p1afda292fc36692803a47a7e79b0fc6a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220413145922eucas1p2dc46908354f4d2b48db79978d086a838
References: <20220405185040.206297-1-maz@kernel.org>
        <20220405185040.206297-3-maz@kernel.org>
        <CGME20220413145922eucas1p2dc46908354f4d2b48db79978d086a838@eucas1p2.samsung.com>
        <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
        <878rs8c2t2.wl-maz@kernel.org>
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 13.04.2022 19:26, Marc Zyngier wrote:
> Hi Marek,
>
> On Wed, 13 Apr 2022 15:59:21 +0100,
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> Hi Marc,
>>
>> On 05.04.2022 20:50, Marc Zyngier wrote:
>>> When booting with maxcpus=<small number> (or even loading a driver
>>> while most CPUs are offline), it is pretty easy to observe managed
>>> affinities containing a mix of online and offline CPUs being passed
>>> to the irqchip driver.
>>>
>>> This means that the irqchip cannot trust the affinity passed down
>>> from the core code, which is a bit annoying and requires (at least
>>> in theory) all drivers to implement some sort of affinity narrowing.
>>>
>>> In order to address this, always limit the cpumask to the set of
>>> online CPUs.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> This patch landed in linux next-20220413 as commit 33de0aa4bae9
>> ("genirq: Always limit the affinity to online CPUs"). Unfortunately it
>> breaks booting of most ARM 32bit Samsung Exynos based boards.
>>
>> I don't see anything specific in the log, though. Booting just hangs at
>> some point. The only Samsung Exynos boards that boot properly are those
>> Exynos4412 based.
>>
>> I assume that this is related to the Multi Core Timer IRQ configuration
>> specific for that SoCs. Exynos4412 uses PPI interrupts, while all other
>> Exynos SoCs have separate IRQ lines for each CPU.
>>
>> Let me know how I can help debugging this issue.
> Thanks for the heads up. Can you pick the last working kernel, enable
> CONFIG_GENERIC_IRQ_DEBUGFS, and dump the /sys/kernel/debug/irq/irqs/
> entries for the timer IRQs?

Exynos4210, Trats board, next-20220411:

root@target:~# cat /proc/interrupts | grep mct
  40:          0          0 GIC-0  89 Level     mct_comp_irq
  41:       4337          0 GIC-0  74 Level     mct_tick0
  42:          0      11061 GIC-0  80 Level     mct_tick1
root@target:~# cat /sys/kernel/debug/irq/irqs/41
handler:  handle_fasteoi_irq
device:   (null)
status:   0x00003504
             _IRQ_NOPROBE
             _IRQ_NOAUTOEN
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x13403604
             IRQ_TYPE_LEVEL_HIGH
             IRQD_LEVEL
             IRQD_ACTIVATED
             IRQD_IRQ_STARTED
             IRQD_NO_BALANCING
             IRQD_SINGLE_TARGET
             IRQD_AFFINITY_SET
             IRQD_DEFAULT_TRIGGER_SET
             IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0
effectiv: 0
domain:  :soc:interrupt-controller@10490000
  hwirq:   0x4a
  chip:    GIC-0
   flags:   0x15
              IRQCHIP_SET_TYPE_MASKED
              IRQCHIP_MASK_ON_SUSPEND
              IRQCHIP_SKIP_SET_WAKE
root@target:~# cat /sys/kernel/debug/irq/irqs/42
handler:  handle_fasteoi_irq
device:   (null)
status:   0x00003504
             _IRQ_NOPROBE
             _IRQ_NOAUTOEN
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x13403604
             IRQ_TYPE_LEVEL_HIGH
             IRQD_LEVEL
             IRQD_ACTIVATED
             IRQD_IRQ_STARTED
             IRQD_NO_BALANCING
             IRQD_SINGLE_TARGET
             IRQD_AFFINITY_SET
             IRQD_DEFAULT_TRIGGER_SET
             IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 1
effectiv: 1
domain:  :soc:interrupt-controller@10490000
  hwirq:   0x50
  chip:    GIC-0
   flags:   0x15
              IRQCHIP_SET_TYPE_MASKED
              IRQCHIP_MASK_ON_SUSPEND
              IRQCHIP_SKIP_SET_WAKE
root@target:~#

> Also, see below.
>
>>> ---
>>>    kernel/irq/manage.c | 25 +++++++++++++++++--------
>>>    1 file changed, 17 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>>> index c03f71d5ec10..f71ecc100545 100644
>>> --- a/kernel/irq/manage.c
>>> +++ b/kernel/irq/manage.c
>>> @@ -222,11 +222,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>>>    {
>>>    	struct irq_desc *desc = irq_data_to_desc(data);
>>>    	struct irq_chip *chip = irq_data_get_irq_chip(data);
>>> +	const struct cpumask  *prog_mask;
>>>    	int ret;
>>>    
>>> +	static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
>>> +	static struct cpumask tmp_mask;
>>> +
>>>    	if (!chip || !chip->irq_set_affinity)
>>>    		return -EINVAL;
>>>    
>>> +	raw_spin_lock(&tmp_mask_lock);
>>>    	/*
>>>    	 * If this is a managed interrupt and housekeeping is enabled on
>>>    	 * it check whether the requested affinity mask intersects with
>>> @@ -248,24 +253,28 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
>>>    	 */
>>>    	if (irqd_affinity_is_managed(data) &&
>>>    	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
>>> -		const struct cpumask *hk_mask, *prog_mask;
>>> -
>>> -		static DEFINE_RAW_SPINLOCK(tmp_mask_lock);
>>> -		static struct cpumask tmp_mask;
>>> +		const struct cpumask *hk_mask;
>>>    
>>>    		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>>>    
>>> -		raw_spin_lock(&tmp_mask_lock);
>>>    		cpumask_and(&tmp_mask, mask, hk_mask);
>>>    		if (!cpumask_intersects(&tmp_mask, cpu_online_mask))
>>>    			prog_mask = mask;
>>>    		else
>>>    			prog_mask = &tmp_mask;
>>> -		ret = chip->irq_set_affinity(data, prog_mask, force);
>>> -		raw_spin_unlock(&tmp_mask_lock);
>>>    	} else {
>>> -		ret = chip->irq_set_affinity(data, mask, force);
>>> +		prog_mask = mask;
>>>    	}
>>> +
>>> +	/* Make sure we only provide online CPUs to the irqchip */
>>> +	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
>>> +	if (!cpumask_empty(&tmp_mask))
>>> +		ret = chip->irq_set_affinity(data, &tmp_mask, force);
>>> +	else
>>> +		ret = -EINVAL;
> Can you also check that with the patch applied, it is this path that
> is taken and that it is the timer interrupts that get rejected? If
> that's the case, can you put a dump_stack() here and give me that
> stack trace? The use of irq_force_affinity() in the driver looks
> suspicious...

[    0.158241] smp: Bringing up secondary CPUs ...
[    0.166118] irq_do_set_affinity irq 42
[    0.166160] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
5.18.0-rc1-00002-g33de0aa4bae9-dirty #11708
[    0.166176] Hardware name: Samsung Exynos (Flattened Device Tree)
[    0.166188]  unwind_backtrace from show_stack+0x10/0x14
[    0.166220]  show_stack from dump_stack_lvl+0x58/0x70
[    0.166239]  dump_stack_lvl from irq_do_set_affinity+0x188/0x1c8
[    0.166258]  irq_do_set_affinity from irq_set_affinity_locked+0xf8/0x17c
[    0.166274]  irq_set_affinity_locked from irq_force_affinity+0x34/0x54
[    0.166290]  irq_force_affinity from exynos4_mct_starting_cpu+0xdc/0x11c
[    0.166308]  exynos4_mct_starting_cpu from 
cpuhp_invoke_callback+0x190/0x38c
[    0.166328]  cpuhp_invoke_callback from 
cpuhp_invoke_callback_range+0x98/0xb4
[    0.166345]  cpuhp_invoke_callback_range from 
notify_cpu_starting+0x54/0x94
[    0.166364]  notify_cpu_starting from secondary_start_kernel+0x160/0x26c
[    0.166383]  secondary_start_kernel from 0x40101a00
[    0.166498] CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
[    0.166515] CPU1: Spectre v2: using BPIALL workaround
[    0.265631] smp: Brought up 1 node, 2 CPUs
[    0.268660] SMP: Total of 2 processors activated (96.00 BogoMIPS).
[    0.274583] CPU: All CPU(s) started in SVC mode.

> Finally, is there a QEMU emulation of one of these failing boards?

yes, smdkc210, I've reproduced it with the following command:

qemu-system-arm -serial null -serial stdio -kernel /tftpboot/qemu/zImage 
-dtb /tftpboot/qemu/exynos4210-smdkv310.dtb -append 
"console=ttySAC1,115200n8 earlycon root=/dev/mmcblk0p2 rootwait 
init=/bin/bash ip=::::target::off cpuidle.off=1" -M smdkc210 -drive 
file=qemu-smdkv310-mmcblk0.raw,if=sd,bus=0,index=2,format=raw


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

