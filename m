Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F056E500B88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiDNKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240117AbiDNKwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:52:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644313DD8;
        Thu, 14 Apr 2022 03:49:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649933379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1o/zjx+057+hoiih2AMIdIhF88TWdmeDt5GifKxymQs=;
        b=cTeAjqdLnWwHNTyfr4/d83MqQ6W57ons8iU9Bp7UrHcaQPp/ohZb5RZC2hFWDvc5fNg5Of
        /2CN0VNDD1R3MphxDI06GACtascykTAIprRi36zzE4w01DZbZYyIFQhv69lDRpxmFnRbWX
        OSVFsxaiJ3rtJhzY0c7+4W6q7rl2aUHxmMiJfkTYSk2KEk7Sh4IB++ljdZUEljVENVSena
        W4uMEahLBIDECVOM2AvZCYGWhP2MLDz9mICWRXIbKRBHrPNWHrIqetPW3BR9hOtjF0CNzJ
        ZU9+HIVAK9FySzbl8Uq0AokLFpW4PLcR3OGMaXmJWmgOBkGXmBLHnAnRSgs+/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649933379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1o/zjx+057+hoiih2AMIdIhF88TWdmeDt5GifKxymQs=;
        b=1OXLP/Z8sfaB5Vjrvv0WdsD9V+wV2tiJ+dDWmUmr+ZI893KaTK6uIXu+3tjJhz+JG9vtbK
        Kp5OL13cmTbcBeCA==
To:     Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/3] genirq: Always limit the affinity to online CPUs
In-Reply-To: <878rs8c2t2.wl-maz@kernel.org>
References: <20220405185040.206297-1-maz@kernel.org>
 <20220405185040.206297-3-maz@kernel.org>
 <CGME20220413145922eucas1p2dc46908354f4d2b48db79978d086a838@eucas1p2.samsung.com>
 <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
 <878rs8c2t2.wl-maz@kernel.org>
Date:   Thu, 14 Apr 2022 12:49:38 +0200
Message-ID: <87mtgodjnh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13 2022 at 18:26, Marc Zyngier wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> wrote:
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
>
> Can you also check that with the patch applied, it is this path that
> is taken and that it is the timer interrupts that get rejected? If
> that's the case, can you put a dump_stack() here and give me that
> stack trace? The use of irq_force_affinity() in the driver looks
> suspicious...

It's pretty clear what happens.

secondary_start_kernel()
  notify_cpu_starting(cpu);
    exynos4_mct_starting_cpu()
     irq_force_affinity() -> fail

  set_cpu_online(cpu, true);

Thanks,

        tglx
