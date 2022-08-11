Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C958F5AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiHKCD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiHKCDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:03:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD205A3ED
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:03:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso3818342pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=GiE/+6siIUPepAkCpDVOEfnQBLpgG2re0zDFCb88zhQ=;
        b=joHERJT1xeR/3qOBhs17HUmqwFTPf4spDjKd+momOQl2shFfvUEH63FMW685UOvbWu
         eM5AEg7fFwRVwMlTt0oS2NLcuzhmywk2KcMVTcnqEqIKcESarRPJTnguW/wb4mLqRY6T
         yOuuemKnoeHzadu7wuYjS5deU8SKBJK3Zj/9vG4G3jXMOM2XQbXJ2xkgIX+hFTWTnLz6
         Qa59m7Cf2k3O8dQehmYOmNowELVWxQTNSo8u+/QaPEZH8/NMPhb8vDLIF8xJFOcn9r+7
         byRmrkg+v0mxgvxg1FuG/+Gu3TVZqA/TDX6PKk4BvodPi4v4unqI+fC70/6CwbTDFXO6
         cX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=GiE/+6siIUPepAkCpDVOEfnQBLpgG2re0zDFCb88zhQ=;
        b=vDW3puRyaA+LUd9fHbJ8+Q8gm9ih6HVV7BjWsdnNPXOjkv1P95+XS7rdymmK3+y2Qk
         RZJHRpd6JplssIvjFsBTbrFb58Ed1xlosxYAAraIcotV9YhoFEu6GGtwhPvlKsYCDJ51
         MJGDlCmZlksIyOB8Qsguolm17rPtSHeTR80TolpvSTHPMIE8UipRxVjtQ1YxWvBxVA0/
         UBsX3X+eeKOVhHD0EqPWO5PWwYGEgEzG9+4IwbfZlHNcxPPOSXj593FiKx9WSvIHCtSg
         A7azJnhPjoQXBtu50tw5+UlnG8d6oKgG/HTV/iPAJ2YoP7obu2tzXYPD6PdhoIbM53Tt
         CztQ==
X-Gm-Message-State: ACgBeo2SY+FwWDYgC54AvXOPhNm9yEGM7BUq+DJMugcczjxyeCGfpShE
        Rq8wZ/kugYKs68udH1bY7kM=
X-Google-Smtp-Source: AA6agR6eYLEdMc6mcH6h1NYJUYJ6BWR4sQTdRX7eCg9wtswlLhfNlrmHZNZ2r77tZd+xROogLEesKA==
X-Received: by 2002:a17:903:22d1:b0:16f:a93:918b with SMTP id y17-20020a17090322d100b0016f0a93918bmr31356017plg.123.1660183432128;
        Wed, 10 Aug 2022 19:03:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b0016e808dbe55sm13492190pll.96.2022.08.10.19.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 19:03:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
Date:   Wed, 10 Aug 2022 19:03:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Content-Language: en-US
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
References: <20220727181936.3250466-1-saravanak@google.com>
 <20220809103052.GA1778649@roeck-us.net>
 <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
 <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YvQnbq2RhMOElQE3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 14:47, Isaac Manjarres wrote:
> On Wed, Aug 10, 2022 at 05:58:58AM -0700, Guenter Roeck wrote:
>> On 8/9/22 20:33, Saravana Kannan wrote:
>> [ ... ]
>>
>>>
>>> Can you give me more details on the qemu configuration so I could try
>>> to reproduce it?
>>
>> qemu-system-arm -M vexpress-a9 -kernel arch/arm/boot/zImage -no-reboot \
>>      -initrd rootfs-armv5.cpio -m 128 \
>>      --append "rdinit=/sbin/init console=ttyAMA0,115200" \
>>      -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
>>      -nographic -monitor null -serial stdio
>>
>> using multi_v7_defconfig will hang nicely with your patch applied,
>> and boot as expected without. This was with qemu v7.0, but I am
>> sure older qemu versions will show the same behavior. The initrd
>> used should not matter, but you'll find it at
>> https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv5.cpio.gz
>>
>> Guenter
>>
> Hi Guenter,
> 
> Thanks for the information; I was able to reproduce this on my end as
> well. The following changes fixed the problem for me. Can you please try
> them out?
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 70f79fc71539..b377f18d8acc 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>                  dev_dbg(dev, "Device match requests probe deferral\n");
>                  dev->can_match = true;
>                  driver_deferred_probe_add(dev);
> +               /*
> +                * Device can't match with the bus right now, so don't attempt
> +                * to match or bind with other drivers on the bus.
> +                */
> +               return ret;
>          } else if (ret < 0) {
>                  dev_dbg(dev, "Bus failed to match device: %d\n", ret);
>                  return ret;
> @@ -1120,6 +1125,11 @@ static int __driver_attach(struct device *dev, void *data)
>                  dev_dbg(dev, "Device match requests probe deferral\n");
>                  dev->can_match = true;
>                  driver_deferred_probe_add(dev);
> +               /*
> +                * Driver could not match with device, but may match with
> +                * another device on the bus.
> +                */
> +               return 0;
>          } else if (ret < 0) {
>                  dev_dbg(dev, "Bus failed to match device: %d\n", ret);
>                  return ret;
> 

Most of the tests pass with the above applied, but there is still one crash.

8<--- cut here ---^M
Unhandled fault: page domain fault (0x81b) at 0x00000122^M
[00000122] *pgd=00000000^M
Internal error: : 81b [#1] ARM^M
Modules linked in:^M
CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 5.19.0+ #1^M
Hardware name: ARM-Versatile (Device Tree Support)^M
PC is at do_alignment_ldrstr+0x7c/0x164^M
LR is at ai_half+0x0/0x4^M
pc : [<c001fa00>]    lr : [<c0ca1278>]    psr: 60000113^M
sp : c8811d68  ip : 00000003  fp : 00000004^M
r10: c05433e4  r9 : c0ca1278  r8 : 00000801^M
r7 : 00000122  r6 : 00000000  r5 : e5823000  r4 : c8811df8^M
r3 : 00000100  r2 : c8811df8  r1 : 00000000  r0 : 00000122^M
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none^M
Control: 00093177  Table: 01698000  DAC: 00000051^M
Register r0 information: non-paged memory^M
Register r1 information: NULL pointer^M
Register r2 information: 2-page vmalloc region starting at 0xc8810000 allocated at kernel_clone+0x70/0x644^M
Register r3 information: non-paged memory^M
Register r4 information: 2-page vmalloc region starting at 0xc8810000 allocated at kernel_clone+0x70/0x644^M
Register r5 information: non-paged memory^M
Register r6 information: NULL pointer^M
Register r7 information: non-paged memory^M
Register r8 information: non-paged memory^M
Register r9 information: non-slab/vmalloc memory^M
Register r10 information: non-slab/vmalloc memory^M
Register r11 information: non-paged memory^M
Register r12 information: non-paged memory^M
Process swapper (pid: 1, stack limit = 0x(ptrval))^M
Stack: (0xc8811d68 to 0xc8812000)^M
1d60:                   c8811df8 e5823000 00000000 c00201dc 00000000 00000000^M
1d80: c0bf2fd4 60000013 00000000 c006c440 00000001 00000000 e5823000 c053cdc0^M
1da0: 00000000 c0be786c c1496d40 00000801 c0bec3f8 c001ffdc c8811df8 00000122^M
1dc0: c1496d40 c0bc4858 00000000 c001d66c c12ae950 00000001 c0c5f3b0 c1496d40^M
1de0: c05433e4 20000013 ffffffff c8811e2c c1496d40 c00095c4 00000001 00000001^M
1e00: 00000122 00000100 c24d8cc0 c1552c00 00000fff c0c5f230 c1496d40 c24d6e58^M
1e20: c0bc4858 00000000 c1497330 c8811e48 00000001 c05433e8 20000013 ffffffff^M
1e40: 00000053 c05433cc ffffffed c1552c00 00000fff c0c5f230 c1496d40 c24d6e58^M
1e60: c0bc4858 c053a784 c1552c00 c0c5f294 c0c5f294 c053a808 00000000 c1552c00^M
1e80: c0c5f294 c05d9f94 00000000 c0c5f294 c05d9f74 c0c5f230 c1496d40 c05d7984^M
1ea0: 00000000 c1540eac c7cd5fb4 c0be786c c0c5f294 c24d6e00 00000000 c05d8b7c^M
1ec0: c0acccd4 c0c92600 c1496d40 c0c5f294 c0c92600 c1496d40 00000000 c1496d40^M
1ee0: c0ca1000 c05dab3c c0bb0690 c0c92600 c1496d40 c000a8b0 00000000 00000000^M
1f00: c14d7e4b c0b5f800 000000bf c0047c5c c0b5e9b4 00000000 c0c92600 c088e078^M
1f20: c1496d40 00000007 c0c92600 c14d7e00 c0bc4874 c0b5e9b4 c0ca1000 c0bc4858^M
1f40: 00000000 c0be786c c0bdda90 00000008 c14d7e00 c0bc4878 c0b5e9b4 c0b93230^M
1f60: 00000007 00000007 00000000 c0b92400 00000000 000000bf 00000000 00000000^M
1f80: c088e340 00000000 00000000 00000000 00000000 00000000 00000000 c088e350^M
1fa0: 00000000 c088e340 00000000 c00084f8 00000000 00000000 00000000 00000000^M
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000^M
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000^M
  do_alignment_ldrstr from do_alignment+0x200/0x984^M
  do_alignment from do_DataAbort+0x38/0xb8^M
  do_DataAbort from __dabt_svc+0x64/0xa0^M
Exception stack(0xc8811df8 to 0xc8811e40)^M
1de0:                                                       00000001 00000001^M
1e00: 00000122 00000100 c24d8cc0 c1552c00 00000fff c0c5f230 c1496d40 c24d6e58^M
1e20: c0bc4858 00000000 c1497330 c8811e48 00000001 c05433e8 20000013 ffffffff^M
  __dabt_svc from __clk_put+0x34/0x174^M
  __clk_put from amba_read_periphid+0xd8/0x120^M
  amba_read_periphid from amba_match+0x3c/0x84^M
  amba_match from __driver_attach+0x20/0x114^M
  __driver_attach from bus_for_each_dev+0x74/0xc0^M
  bus_for_each_dev from bus_add_driver+0x154/0x1e8^M
  bus_add_driver from driver_register+0x74/0x10c^M
  driver_register from do_one_initcall+0x8c/0x2fc^M
  do_one_initcall from kernel_init_freeable+0x190/0x220^M
  kernel_init_freeable from kernel_init+0x10/0x108^M
  kernel_init from ret_from_fork+0x14/0x3c^M
Exception stack(0xc8811fb0 to 0xc8811ff8)^M
1fa0:                                     00000000 00000000 00000000 00000000^M
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000^M
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000^M
Code: e3a00002 e782310c e8bd8070 e792310c (e4c03001) ^M
---[ end trace 0000000000000000 ]---^M
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b^M

This is with versatile_defconfig and versatileab. Let me know if you need details.

Guenter
