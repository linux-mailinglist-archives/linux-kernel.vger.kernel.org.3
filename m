Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3D758F56E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 02:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiHKA6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 20:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHKA6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 20:58:21 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC02611B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 17:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1660179496; bh=OyTS99sFdIE7MIH3baHBlBv1aJd28i4z8hmNZy/UQKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eVO31LntCu1yWUk7nIK3DpJeeP9+itbBsMwL21XzJbJmCe9j9B8Nmo26VaOLy/Faz
         mGl7u5CbdBVPfSMLoC/iHefZMZp9UEtmxJT/hi2vJXhDoqj3gQLI3EF9+khVIzq3Kf
         e/nthtHo0pinGt7U9AExQ/a+3VJqywBcVmLPcJ04=
Received: from [192.168.9.172] (unknown [101.88.24.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E71CC60074;
        Thu, 11 Aug 2022 08:58:15 +0800 (CST)
Message-ID: <1359c52d-5194-7306-0e76-cde97b5aa31c@xen0n.name>
Date:   Thu, 11 Aug 2022 08:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:105.0) Gecko/20100101
 Thunderbird/105.0a1
Subject: Re: [PATCH] LoongArch: Fix the !CONFIG_SMP build for irqchip drivers
To:     Huacai Chen <chenhuacai@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220810103156.1214996-1-chenhuacai@loongson.cn>
 <f92fc4f34784217206b53a3709538d5c@kernel.org>
 <CAAhV-H7DbvjEcms9Y81t_=WyDnKu5vuB4x7g7vU3f9CUhZykHQ@mail.gmail.com>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H7DbvjEcms9Y81t_=WyDnKu5vuB4x7g7vU3f9CUhZykHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 23:38, Huacai Chen wrote:

> Hi, Marc,
>
> On Wed, Aug 10, 2022 at 7:01 PM Marc Zyngier <maz@kernel.org> wrote:
>> On 2022-08-10 11:31, Huacai Chen wrote:
>>> 1, Guard get_ipi_irq() in CONFIG_SMP;
>>> 2, Define cpu_logical_map() for the EIOINTC driver;
>>> 3, Make eiointc_set_irq_affinity() return early for !CONFIG_SMP.
>>>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Frankly, the real question is why do you even bother? As far as
>> I can tell, LoongArch has no UP system.
>>
>> arm64 crossed that bridge a long time ago, and we never looked
>> back, because these systems hardly exist.
>>
>> I'd rather you simply have a CONFIG_SMP always set to 'y', and
>> be done with it forever.
> LoongArch also has low-end processors (even LoongArch64). Though we
> haven't translate all documents at
> https://loongson.github.io/LoongArch-Documentation/ in time, there are
> currently 4 LoongArch64 processors: Loongson-2K500 (single-core),
> Loongon-2K1000 (dual-core), Loongson-3A5000 (quad-core) and
> Loongson-3C5000 (16-core). So we indeed need a UP configuration.
> Thanks.

I remember seeing an alternatives mechanism in the works for LoongArch. 
If such alternatives mechanism is to be upstreamed in short order, why 
make SMP one more build-time time option that developers have to decide 
upon? It's not like SMP code would break, or run with unacceptable 
overhead, on UP systems AFAIK, so it's probably better to not 
preemptively support so many *possibilities* that haven't been realized 
so the *current* maintainability suffers. Practically one can't buy the 
LoongArch 2K line of products anywhere right now, and the few companies 
developing for it are likely not using upstream kernels anyway, so it's 
not like we can't wait either.


-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

