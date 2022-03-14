Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F0B4D8C06
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 20:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiCNTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 15:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiCNTFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C243BB7EF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 12:03:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647284630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rr1I2k8yy6900xeEsxynWpaXe8KIZVUby5z1J+L4pXU=;
        b=bR6C4zGc0Iyp0yyhJvhYcxU0uFc7HWAXk8ICDrdjrk9YVSMsiOXbU/dc2QcafdZHvYQqgh
        iW6F5JTdIz+r7LW6qNUlAmPgmeprUfIbEAI2h3AYVKqg6LT/fFP+8q3BBcRsSJFVYUcj2l
        vX9nbOinYT1gcxHRRWeWF2A6JuUH9hcVZj/drmnrD4ul5G/SNFP6tXSeErHDG7xtkGpVUk
        JGTn4KVLj376BglcBXieUYLqWJMYs0DdgHkSz3s0GpKIYucQUzNlKRPcSwxoMVeMkm4tsH
        JdIZv0l2ucWZpM7YiRExqSLnQq1n6U4MsRowRWk0X+ePr2UZE29YXepEGcTo7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647284630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rr1I2k8yy6900xeEsxynWpaXe8KIZVUby5z1J+L4pXU=;
        b=NvjcSqaxJGaUAD1TnH/uLzx2EWLLmCut6PUiv3PrqT1Spzfc7r0Nnpl5V+mBOg/P5dQTnB
        K+El4/EwmpzlUYBQ==
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, John Garry <john.garry@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: Re: [PATCH] genirq/msi: Shutdown managed interrupts with
 unsatifiable affinities
In-Reply-To: <87ilsgzfpv.wl-maz@kernel.org>
References: <20220307190625.254426-1-maz@kernel.org> <87sfrkftbl.ffs@tglx>
 <87ilsgzfpv.wl-maz@kernel.org>
Date:   Mon, 14 Mar 2022 20:03:49 +0100
Message-ID: <87mthsfjai.ffs@tglx>
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

On Mon, Mar 14 2022 at 16:00, Marc Zyngier wrote:
> On Mon, 14 Mar 2022 15:27:10 +0000,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>> 
>> On Mon, Mar 07 2022 at 19:06, Marc Zyngier wrote:
>> > When booting with maxcpus=<small number>, interrupt controllers
>> > such as the GICv3 ITS may not be able to satisfy the affinity of
>> > some managed interrupts, as some of the HW resources are simply
>> > not available.
>> 
>> This is also true if you have offlined lots of CPUs, right?
>
> Not quite. If you offline the CPUs, the interrupts will be placed in
> the shutdown state as expected, having initially transitioned via an
> activation state with an online CPU. The issue here is with the
> initial activation of the interrupt, which currently happens even if
> no matching CPU is present.

Yes. But if you load the driver _after_ offlining lots of CPUs first
then the same thing should happen, right?

>> > +		/*
>> > +		 * If the interrupt is managed but no CPU is available
>> > +		 * to service it, shut it down until better times.
>> > +		 */
>> > +		if ((vflags & VIRQ_ACTIVATE) &&
>> > +		    irqd_affinity_is_managed(irqd) &&
>> > +		    !cpumask_intersects(irq_data_get_affinity_mask(irqd),
>> > +					cpu_online_mask)) {
>> > +			    irqd_set_managed_shutdown(irqd);
>> 
>> Hrm. Why is this in the !CAN_RESERVE path and not before the actual
>> activation call?
>
> VIRQ_CAN_RESERVE can only happen as a consequence of
> GENERIC_IRQ_RESERVATION_MODE, which only exists on x86. Given that x86
> is already super careful not to activate an interrupt that is not
> immediately required, I though we could avoid putting this check on
> that path.
>
> But if I got the above wrong (which is, let's face it, extremely
> likely), I'm happy to kick it down the road next to the activation
> call.

I just rechecked. Yes, we could push it there, but actually on x86 the
reservation mode activation sets the entry to a spurious catch all on an
online CPU, which is intentional.

So yes, we can keep it where it is now, but that needs a comment.

Thanks,

        tglx
