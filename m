Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BAA5A2F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345393AbiHZS6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbiHZS6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:58:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58274B32
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA61CB83115
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B858C433D6;
        Fri, 26 Aug 2022 18:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661540244;
        bh=Et+UJP3nMFjSqnln2xBo9NvAK9eQG6VOhiPO8c+DwVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LVtNQfn43hg0qP57cDq5ZVdSuV6F6hQMIY1+AMC/AT3Ul1lVgo3d7yFo6RNUVk2i6
         5FSRXGpBJBqhoe+pGJ1ntBysI6RfXr0Yco3lgkrvokSb5lj4CM7c3fqnKeA1o8zNJj
         qpDkgsGcaUaYSe1FBbU3qZ/B6euL+WJCJ/dvysJfwUePOdcCUc/YRcmHNLDSpNYtQO
         +8zaYpy/gq7hM3eL4czpWP7kmgA1vsD7VpmWbjw3Ztf3dk9RcBgCnLQoPOXlexVvK4
         vXYjs1nXVyORwzEph65O51zTPbwHy0vijKZm1M+rB6bLL90jOH/jnp4lnX0bpIddQP
         b0X5KhiYBt9Rw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oReWA-0062Ce-OM;
        Fri, 26 Aug 2022 19:57:22 +0100
MIME-Version: 1.0
Date:   Fri, 26 Aug 2022 19:57:22 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     apatel@ventanamicro.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, tglx@linutronix.de,
        daniel.lezcano@linaro.org, atishp@atishpatra.org,
        Alistair.Francis@wdc.com, anup@brainfault.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/7] RISC-V: Treat IPIs as normal Linux IRQs
In-Reply-To: <8f4ae429-0f12-2096-c07b-fe43b3abb4fe@microchip.com>
References: <20220820065446.389788-1-apatel@ventanamicro.com>
 <20220820065446.389788-5-apatel@ventanamicro.com>
 <8f4ae429-0f12-2096-c07b-fe43b3abb4fe@microchip.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <69e58f4dc2b74415a32a97998e862479@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Conor.Dooley@microchip.com, apatel@ventanamicro.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, daniel.lezcano@linaro.org, atishp@atishpatra.org, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-26 19:48, Conor.Dooley@microchip.com wrote:
> On 20/08/2022 07:54, Anup Patel wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Currently, the RISC-V kernel provides arch specific hooks (i.e.
>> struct riscv_ipi_ops) to register IPI handling methods. The stats
>> gathering of IPIs is also arch specific in the RISC-V kernel.
>> 
>> Other architectures (such as ARM, ARM64, and MIPS) have moved away
>> from custom arch specific IPI handling methods. Currently, these
>> architectures have Linux irqchip drivers providing a range of Linux
>> IRQ numbers to be used as IPIs and IPI triggering is done using
>> generic IPI APIs. This approach allows architectures to treat IPIs
>> as normal Linux IRQs and IPI stats gathering is done by the generic
>> Linux IRQ subsystem.
>> 
>> We extend the RISC-V IPI handling as-per above approach so that arch
>> specific IPI handling methods (struct riscv_ipi_ops) can be removed
>> and the IPI handling is done through the Linux IRQ subsystem.
>> 
>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> 
>> +void riscv_ipi_set_virq_range(int virq, int nr)
>> +{
>> +       int i, err;
>> 
>> -               if (ops & (1 << IPI_IRQ_WORK)) {
>> -                       stats[IPI_IRQ_WORK]++;
>> -                       irq_work_run();
>> -               }
>> +       if (WARN_ON(ipi_virq_base))
>> +               return;
>> 
>> -#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>> -               if (ops & (1 << IPI_TIMER)) {
>> -                       stats[IPI_TIMER]++;
>> -                       tick_receive_broadcast();
>> -               }
>> -#endif
>> -               BUG_ON((ops >> IPI_MAX) != 0);
>> +       WARN_ON(nr < IPI_MAX);
>> +       nr_ipi = min(nr, IPI_MAX);
>> +       ipi_virq_base = virq;
>> +
>> +       /* Request IPIs */
>> +       for (i = 0; i < nr_ipi; i++) {
>> +               err = request_percpu_irq(ipi_virq_base + i, 
>> handle_IPI,
>> +                                        "IPI", &ipi_virq_base);
> 
> FWIW, ?sparse? does not like this:
> arch/riscv/kernel/smp.c:163:50: warning: incorrect type in argument 4
> (different address spaces)
> arch/riscv/kernel/smp.c:163:50:    expected void [noderef] __percpu
> *percpu_dev_id
> arch/riscv/kernel/smp.c:163:50:    got int *

Huh, well spotted. This will totally give the wrong sort of
result, as this is used as a percpu variable from the irq
core code.

The arm64 code passes instead a pointer to the CPU number, which
is not very useful, but at least not completely wrong.

I'm sure the RISC-V code has some sort of semi-useful data to
stuff in there instead of this.

         M.
-- 
Jazz is not dead. It just smells funny...
