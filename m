Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C074B123C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiBJP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243942AbiBJP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:59:38 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B01CE9C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:59:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so5471750wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EDKE0XUF34XjrkFY4l0pOlQwE89KPDkqeFJG5WC7NDI=;
        b=h65YM/61sSvHy5I60WleieWpN4nnYo28ZtlvvRk5H56eZNMmXWqg0JO4SQLSn8qZFp
         0i+QcZo3XebXWIDA6cbnztXPjV1eqHw/LAPKxegfKp3BjTqGEMEtdReB+vCxzRtSL4tw
         2krSOMQSQJKIrGSMXEUKVGLk3TVT4oXsSHQ+i7DNQ3XRJkfKzNDWt/DZZEhmyC9zHXQn
         gu6DpfZEPv0sRrlM3AWue/d2bnLfPoxSdYqGXiYf4Hpm7iVpqjOitvAlDWbHIcD6zB6S
         ZcadMmvbRJD0op/Gd1n8RvN71pnuw0zjrQd6LQMXiA8FDxuL/SQi7UWXAYBnj+S6YMDT
         7NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EDKE0XUF34XjrkFY4l0pOlQwE89KPDkqeFJG5WC7NDI=;
        b=b6J1l+aLFvds8LmO7Mdj5EJ15ABfq6a2K/pmPpyxrffPoKSf87tE5TA+BEEmAWy/+/
         1V4SN6FMFncO5Gt4jiTpB6Za9dXEcwWCUty3L2wPFAwFLaFwFsISwST++y8OiehYyda1
         G6+TGE+u3mAVC0FT+x/qBGbwOYNTmwfAoppgSVGXAP/VMGJAHdxsw/Cd1Jg7j1u8+KnV
         f1DLYx0/Th+Dw/gDYKuvyrSgXwIjsQj5q1EWiLqrJCcRXa0rRf27zg5VLgrPPrh/hEHZ
         PdmBaosovKXtVvVZlQr4Ag99yitRav2ACRD/PWY3jEadkJ2bh3hFRlwn0FHdoCJRyCjm
         sTFA==
X-Gm-Message-State: AOAM530Ai9CbO0m3gPWQKBaRZelut9wHihvE3UCYrunSJCxSMMg+l5ub
        pOxu09oc/Ue7vd0yUhOO31JIjfrilLFI8g==
X-Google-Smtp-Source: ABdhPJz1JSHSDCF+ylWcFsJvXFRHabDouoJyMu2fpSIH6XdoPZV4NeON70cwyMobD0KgmTTayQoenA==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr2764427wmj.8.1644508776921;
        Thu, 10 Feb 2022 07:59:36 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id e15sm4636433wrg.6.2022.02.10.07.59.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Feb 2022 07:59:36 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2] riscv: fix oops caused by irq on/off tracer
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <YgUuzZp/eiNoXejK@xhacker>
Date:   Thu, 10 Feb 2022 15:59:35 +0000
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D51738E-C4C0-4D30-BCDF-55786E0CC201@jrtc27.com>
References: <20220129004226.32868-1-changbin.du@gmail.com>
 <YgAEb425uqy5/dw1@xhacker> <20220207123850.l4r5qjswaegwisbx@mail.google.com>
 <YgE7XRE/Uc6gTCWd@xhacker> <20220208003502.62gi5xhyg6bk2t2h@mail.google.com>
 <YgP6y99LWFSoxjHg@xhacker> <20220210133758.yzebffln6j76zme6@mail.google.com>
 <YgUuzZp/eiNoXejK@xhacker>
To:     Jisheng Zhang <jszhang@kernel.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Feb 2022, at 15:27, Jisheng Zhang <jszhang@kernel.org> wrote:
> On Thu, Feb 10, 2022 at 09:37:58PM +0800, Changbin Du wrote:
>> On Thu, Feb 10, 2022 at 01:32:59AM +0800, Jisheng Zhang wrote:
>> [snip]
>>> Hi Changbin,
>>>=20
>>> I read the code and find that current riscv frame records during
>>> exception isn't as completed as other architectures. riscv only
>>> records frames from the ret_from_exception(). If we add completed
>> What do you mean for 'record'?
>>=20
>=20
> stack frame record.
>=20
>>> frame records as other arch do, then the issue you saw can also
>>> be fixed at the same time.
>>>=20
>> I don't think so. The problem is __builtin_return_address(1) trigger =
page fault
>> here.
>=20
> There's misunderstanding here. I interpret this bug as incomplete
> stackframes.
>=20
> This is current riscv stackframe during exception:
>=20
> high
> 	----------------
> top	|		|  <- ret_from_exception
> 	----------------
> 	|		|  <- trace_hardirqs_on
> 	-----------------
> low
>=20
> As you said, the CALLER_ADDR1 a.k.a __builtin_return_address(1) needs
> at least two parent call frames.=20

No it doesn=E2=80=99t, you=E2=80=99re off by one, it only needs a valid =
current frame.

Jess

> If we complete the stackframes during exception as other arch does:
>=20
> high
> 	----------------
> top	|		|  <- the synthetic stackframe from the =
interrupted point
> 	----------------
> 	      .....	     =20
>        ----------------
> 	|		|  <- ret_from_exception
> 	----------------
> 	|		|  <- trace_hardirqs_on
> 	-----------------
> low
>=20
>=20
> Then we meet the "at least two parent call frames" requirement. IOW, =
my
> solution solve the problem from the entry.S side. One of the =
advantages
> would be we let interrupted point show up in dump_stack() as other =
arch
> do. What I'm not sure is whether it's safe to do so now since rc3 is
> released.
>=20
>>=20
>>> However, I'm not sure what's the best choice now.
>>>=20
>>> A simple demo to this incomplete frames:
>>> add dump_stack() in any ISR, then
>>>=20
>>> in riscv:
>>> [    2.961294] Call Trace:
>>> [    2.961460] [<ffffffff8000485e>] dump_backtrace+0x1c/0x24
>>> [    2.961823] [<ffffffff805ed980>] show_stack+0x2c/0x38
>>> [    2.962153] [<ffffffff805f292e>] dump_stack_lvl+0x40/0x58
>>> [    2.962483] [<ffffffff805f295a>] dump_stack+0x14/0x1c
>>> [    2.962792] [<ffffffff805f31a0>] serial8250_interrupt+0x20/0x82
>>> [    2.963139] [<ffffffff80053032>] =
__handle_irq_event_percpu+0x4c/0x106
>>> [    2.963526] [<ffffffff80053170>] handle_irq_event+0x38/0x80
>>> [    2.963856] [<ffffffff80056a32>] handle_fasteoi_irq+0x96/0x188
>>> [    2.964198] [<ffffffff800526ce>] =
generic_handle_domain_irq+0x28/0x3a
>>> [    2.964567] [<ffffffff802f0ae4>] plic_handle_irq+0x88/0xec
>>> [    2.964896] [<ffffffff800526ce>] =
generic_handle_domain_irq+0x28/0x3a
>>> [    2.965264] [<ffffffff802f08e4>] riscv_intc_irq+0x34/0x5c
>>> [    2.965584] [<ffffffff805f6dc8>] =
generic_handle_arch_irq+0x4a/0x74
>>> [    2.966068] [<ffffffff80002fe8>] ret_from_exception+0x0/0xc
>>>=20
>>> in x86:
>>> [    1.191274] Call Trace:
>>> [    1.192223]  <IRQ>
>>> [    1.192758]  dump_stack_lvl+0x45/0x59
>>> [    1.192982]  serial8250_interrupt+0x24/0x88
>>> [    1.193105]  __handle_irq_event_percpu+0x66/0x1b0
>>> [    1.193239]  handle_irq_event+0x34/0x70
>>> [    1.193345]  handle_edge_irq+0x85/0x1e0
>>> [    1.193455]  __common_interrupt+0x38/0x90
>>> [    1.193573]  common_interrupt+0x73/0x90
>>> [    1.193809]  </IRQ>
>>> [    1.193889]  <TASK>
>>> [    1.193956]  asm_common_interrupt+0x1b/0x40
>>> [    1.194318] RIP: 0010:_raw_spin_unlock_irqrestore+0x1b/0x40
>>> [    1.194566] Code: 24 be 01 02 00 00 e9 54 20 bf ff 0f 1f 40 00 0f =
1f
>>> 44 00 00 f7 c6 00f
>>> [    1.195137] RSP: 0000:ffff888000243b68 EFLAGS: 00000246
>>> [    1.195314] RAX: 0000000000000000 RBX: ffffffff82025840 RCX:
>>> 0000000000000000
>>> [    1.195482] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
>>> 0000000000000001
>>> [    1.195645] RBP: 0000000000000202 R08: ffffffffffffffff R09:
>>> 0000000000000000
>>> [    1.195808] R10: 00000000000000eb R11: 0000000000000000 R12:
>>> 0000000000000000
>>> [    1.195972] R13: 0000000000000040 R14: 0000000000000000 R15:
>>> ffff888000c39000
>>> [    1.196245]  ? _raw_spin_unlock_irqrestore+0x15/0x40
>>> [    1.196373]  serial8250_do_startup+0x42d/0x600
>>> [    1.196502]  uart_port_startup+0x11b/0x270
>>> [    1.196619]  uart_port_activate+0x3f/0x60
>>> [    1.196729]  tty_port_open+0x7e/0xd0
>>> [    1.196835]  ? _raw_spin_unlock+0x12/0x30
>>> [    1.196942]  uart_open+0x1a/0x30
>>> [    1.197036]  tty_open+0x153/0x7c0
>>> [    1.197144]  chrdev_open+0xbf/0x230
>>> [    1.197253]  ? cdev_device_add+0x90/0x90
>>> [    1.197359]  do_dentry_open+0x13c/0x360
>>> [    1.197470]  path_openat+0xb0c/0xe00
>>> [    1.197577]  ? update_load_avg+0x5f/0x640
>>> [    1.197691]  ? finish_task_switch.isra.0+0xac/0x240
>>> [    1.197821]  do_filp_open+0xb2/0x150
>>> [    1.197935]  ? preempt_schedule_thunk+0x16/0x18
>>> [    1.198049]  ? preempt_schedule_common+0x90/0xd0
>>> [    1.198167]  ? preempt_schedule_thunk+0x16/0x18
>>> [    1.198291]  file_open_name+0xf1/0x1b0
>>> [    1.198397]  filp_open+0x2c/0x50
>>> [    1.198495]  console_on_rootfs+0x19/0x52
>>> [    1.198648]  kernel_init_freeable+0x19a/0x1c7
>>> [    1.198765]  ? rest_init+0xc0/0xc0
>>> [    1.198867]  kernel_init+0x16/0x110
>>> [    1.198965]  ret_from_fork+0x1f/0x30
>>> [    1.199131]  </TASK>
>>>=20
>> As I said before, this issue is not related to stackdump.
>>=20
>> Besides, you can see more calltrace on x86 that because x86 iterate =
all stacks
>> (kernel, irq or exception) when dumping stacktrace. While RISCV only =
show
>> calltrace of current stack.
>>=20
>=20
> I'm not sure whether there's misunderstanding. See above.
>=20
> Thanks
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

