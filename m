Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1200451D875
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392236AbiEFNH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiEFNH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:07:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295285DA4F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:04:09 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220506130404euoutp017827ed52350e32b357087e7ee76dd1e8~shcTrIwLR1521615216euoutp01d
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:04:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220506130404euoutp017827ed52350e32b357087e7ee76dd1e8~shcTrIwLR1521615216euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651842244;
        bh=CF0/iGMhW3MHLfkpGcPNGe0RJKoR1yUkXgStXkfcxPE=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=LFzHQyNjjgGGuLRUHsgucEnOPRldKeA0wcOTvMaogUtFRuzJ1w3ZVkL6h7GcXQDay
         LoiEEiv2G6Sreyu6dcRDG0NdVInRrkNFgnw4zesA8T0vlaWipdkYRr4qwKN94mZkwP
         Ip5L3sUNyIhlVmHWxYSUBVWoNJS+kF58yfPIIoI0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506130403eucas1p22be4521a75f59ace6007907b3a069004~shcTYm3Q-0273902739eucas1p23;
        Fri,  6 May 2022 13:04:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 24.58.09887.3CC15726; Fri,  6
        May 2022 14:04:03 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506130403eucas1p2037cb394857dc6c0c30e051d710d894e~shcS8U-Jt0952109521eucas1p2P;
        Fri,  6 May 2022 13:04:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506130403eusmtrp29121e541313d3de588aafe31e7f329b1~shcS7hiEv0674106741eusmtrp2n;
        Fri,  6 May 2022 13:04:03 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-59-62751cc3d367
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AA.5E.09522.3CC15726; Fri,  6
        May 2022 14:04:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506130402eusmtip2a2d2fcca24d7cdc8980cea269ea40d97~shcSUNEKB3005830058eusmtip20;
        Fri,  6 May 2022 13:04:02 +0000 (GMT)
Message-ID: <2ff26497-a9c6-799f-13ae-1bd8cbd81574@samsung.com>
Date:   Fri, 6 May 2022 15:04:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <87h762lto8.fsf@jogness.linutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7qHZUqTDB7t17I49/g3i8Xp/e9Y
        LJoXr2ez2HZlPqPFxP1n2S0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcuj9kNF1k8Wvbd
        YvfYtKqTzePOtT1sHu/OnWP32D93DbvH+i1XWTw+b5IL4IjisklJzcksSy3St0vgytjStICx
        4L1SxdFjPYwNjNNluxg5OSQETCSu/dzA1sXIxSEksIJRYtHTx4wQzhdGifdPz7JCOJ8ZJXbt
        XcQM0/LuxzyoquWMEr/WT2SHcD4ySvT0TWIBqeIVsJOYO/k5G4jNIqAi8WDOSai4oMTJmU/A
        bFGBJIk3b64CTeXgEBaIkGjbGwoSZhYQl7j1ZD4TiC0i4C2x6vVesPnMAk+ZJDbuOA7WyyZg
        KNH1tgtsPqeAscSEJRB7mQXkJZq3zmYGaZAQaOaUON30lhXibBeJtfu+MEHYwhKvjm9hh7Bl
        JP7vBNnGAWTnS/ydYQwRrpC49noN1MfWEnfO/WIDKWEW0JRYv0sfIuwocW7LLmaITj6JG28F
        IS7gk5i0bTpUmFeio00IolpNYtbxdXA7D164xDyBUWkWUpjMQvL8LCS/zELYu4CRZRWjeGpp
        cW56arFRXmq5XnFibnFpXrpecn7uJkZg8jr97/iXHYzLX33UO8TIxMF4iFGCg1lJhFd4VkmS
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqZtujPfTBJN
        rcsT+XZlVq/ySf1zSyXOzw1e8PPiO6ff9qwzhWLCSo1/af6zd5sRp7j5OsPHls+zJho1n9/3
        RUXo5Gl/n1crFsQvu2Vf9m/tsfDPd5vvTrsa7lFcuXvJH3aPJjdJ1Xif5ytvOTR8eqTbdUNq
        udMuyca7U9U98i/f+PLGI3yToKF1X9OJUtbb63Lv9S9XkFn75v+T5a++GgeGcm2YfqhD503c
        qVWBW2V+cJXb/Qn91vx/Q/d/5enXD9tuSl37Ql75iOifkr8TZgq87VfJ3yuezMfrtv94nUSV
        798bC9o/i+p/fJO4quOyHH/m5eC24ycvvW3Ydl9A82t954lHvEdDp1Rv2eftG9Pfq8RSnJFo
        qMVcVJwIAM6Eb1fNAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7qHZUqTDHbuErA49/g3i8Xp/e9Y
        LJoXr2ez2HZlPqPFxP1n2S0u75rDZvH/8VdWi30dD5gsdm9cxGaxedNUZgcuj9kNF1k8Wvbd
        YvfYtKqTzePOtT1sHu/OnWP32D93DbvH+i1XWTw+b5IL4IjSsynKLy1JVcjILy6xVYo2tDDS
        M7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy9jStICx4L1SxdFjPYwNjNNluxg5OSQE
        TCTe/ZjH2MXIxSEksJRRYv2zr2wQCRmJk9MaWCFsYYk/17rYIIreM0p0vVrFApLgFbCTmDv5
        OVgDi4CKxIM5J6HighInZz4Bsjk4RAWSJI4c5gcxhQUiJN73glUwC4hL3HoynwnEFhHwllj1
        ei87RPwpk8SWq0IQq3YwSyw8cxqsgU3AUKLrbRfYKk4BY4kJSyZBDTKT6NraxQhhy0s0b53N
        PIFRaBaSK2Yh2TcLScssJC0LGFlWMYqklhbnpucWG+oVJ+YWl+al6yXn525iBMbrtmM/N+9g
        nPfqo94hRiYOxkOMEhzMSiK8wrNKkoR4UxIrq1KL8uOLSnNSiw8xmgKDYiKzlGhyPjBh5JXE
        G5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1ME3bfPpPCXvg5aIzq5mz
        7kryNX/v7Ni7aZFAYVzYq61O78IDqn5EcfnpZbqzLl2qqxwltNhxss6qYouvV7+IRxTc8VK2
        dDe+uOH72RDe3pYy+7O3/x26WXJVbA7nixqJ/bO6DFamxUx+kPn1vID+uxSWi2u+P1Pb7LDf
        b7OhYYBHDafHn/PXL2RX/7Z56GnhpVx+oJ4rsM/G1uvFI7GM/Hmbe58HropYe6OEZcPFZ9MC
        tpzaZyPl33G/583fR3JbThjuTmXgmGx+sl9M/nLNTUNnr/nzVHP1+ye9ZWOx91n0XuPkn/6Q
        kFLfXYvn+ocd9vfYq7NxSbzH3/0CGkKTTh7JuNzC3/Yk7UqlQ778diWW4oxEQy3mouJEAEzb
        CwtgAwAA
X-CMS-MailID: 20220506130403eucas1p2037cb394857dc6c0c30e051d710d894e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6
References: <20220421212250.565456-1-john.ogness@linutronix.de>
        <20220421212250.565456-15-john.ogness@linutronix.de>
        <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
        <Ymfwk+X0CHq6ex3s@alley> <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
        <CGME20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6@eucas1p2.samsung.com>
        <bb5cadc3-0940-7f5c-7a1b-8120ddac9039@samsung.com>
        <87h762lto8.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 06.05.2022 14:41, John Ogness wrote:
> On 2022-05-06, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> The Amlogic Meson related issue has been investigated and fixed:
>>
>> https://lore.kernel.org/all/b7c81f02-039e-e877-d7c3-6834728d2117@samsung.com/
>>
>> but I just found that there is one more issue.
>>
>> It appears on QCom-based DragonBoard 410c SBC
>> (arch/arm64/boot/dts/qcom/apq8016-sbc.dts). To see it on today's linux
>> next-20220506, one has to revert
>> 42cd402b8fd4672b692400fe5f9eecd55d2794ac, otherwise lockdep triggers
>> other warning and it is turned off too early:
>>
>> ================================
>> WARNING: inconsistent lock state
>> 5.18.0-rc5-next-20220506+ #11869 Not tainted
>> --------------------------------
>> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>> swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> ffff80000aaa8478 (&port_lock_key){?.+.}-{2:2}, at: msm_uart_irq+0x38/0x750
>> {HARDIRQ-ON-W} state was registered at:
>>     lock_acquire.part.0+0xe0/0x230
>>     lock_acquire+0x68/0x84
>>     _raw_spin_lock+0x5c/0x80
>>     __msm_console_write+0x1ac/0x220
>>     msm_console_write+0x48/0x60
>>     __console_emit_next_record+0x188/0x420
>>     printk_kthread_func+0x3a0/0x3bc
>>     kthread+0x118/0x11c
>>     ret_from_fork+0x10/0x20
>> irq event stamp: 12182
>> hardirqs last  enabled at (12181): [<ffff800008e3d2a8>]
>> cpuidle_enter_state+0xc4/0x30c
>>
>> stack backtrace:
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc5-next-20220506+ #11869
>> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
>> Call trace:
>>    dump_backtrace.part.0+0xd0/0xe0
>>    show_stack+0x18/0x6c
>>    dump_stack_lvl+0x8c/0xb8
>>    dump_stack+0x18/0x34
>>    print_usage_bug.part.0+0x208/0x22c
>>    mark_lock+0x710/0x954
>>    __lock_acquire+0x9fc/0x20cc
>>    lock_acquire.part.0+0xe0/0x230
>>    lock_acquire+0x68/0x84
>>    _raw_spin_lock_irqsave+0x80/0xcc
>>    msm_uart_irq+0x38/0x750
>>    __handle_irq_event_percpu+0xac/0x3d0
>>    handle_irq_event+0x4c/0x120
>>    handle_fasteoi_irq+0xa4/0x1a0
>>    generic_handle_domain_irq+0x3c/0x60
>>    gic_handle_irq+0x44/0xc4
>>    call_on_irq_stack+0x2c/0x54
>>    do_interrupt_handler+0x80/0x84
>>    el1_interrupt+0x34/0x64
>>    el1h_64_irq_handler+0x18/0x24
>>    el1h_64_irq+0x64/0x68
>>    cpuidle_enter_state+0xcc/0x30c
>>    cpuidle_enter+0x38/0x50
>>    do_idle+0x22c/0x2bc
>>    cpu_startup_entry+0x28/0x30
>>    rest_init+0x110/0x190
>>    arch_post_acpi_subsys_init+0x0/0x18
>>    start_kernel+0x6c4/0x704
>>    __primary_switched+0xc0/0xc8
>>    INIT: version 2.88 booting
>> [info] Using makefile-style concurrent boot in runlevel S.
> The console write() callback for the msm driver (__msm_console_write)
> assumes interrupts are off and is doing a spin_lock(&port->lock) rather
> than spin_lock_irqsave(&port->lock, flags).
>
> The following change should address the issue:

Right, this help. spin_trylock() should be also converted imho, see below.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> John
>
> diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> index 23c94b927776..ab3f360bd354 100644
> --- a/drivers/tty/serial/msm_serial.c
> +++ b/drivers/tty/serial/msm_serial.c
> @@ -1599,6 +1599,7 @@ static inline struct uart_port *msm_get_port_from_line(unsigned int line)
>   static void __msm_console_write(struct uart_port *port, const char *s,
>   				unsigned int count, bool is_uartdm)
>   {
> +	unsigned long flags;
>   	int i;
>   	int num_newlines = 0;
>   	bool replaced = false;
> @@ -1621,7 +1622,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>   	else if (oops_in_progress)
>   		locked = spin_trylock(&port->lock);

locked = spin_trylock_irqsave(&port->lock, flags);

>   	else
> -		spin_lock(&port->lock);
> +		spin_lock_irqsave(&port->lock, flags);
>   
>   	if (is_uartdm)
>   		msm_reset_dm_count(port, count);
> @@ -1660,7 +1661,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
>   	}
>   
>   	if (locked)
> -		spin_unlock(&port->lock);
> +		spin_unlock_irqrestore(&port->lock, flags);
>   }
>   
>   static void msm_console_write(struct console *co, const char *s,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

