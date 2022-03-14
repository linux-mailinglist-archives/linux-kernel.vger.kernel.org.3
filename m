Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D994D8809
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbiCNP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiCNP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:28:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830A13F36
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:27:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647271631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZIfmwWb2WbJZ9l5iSAxqdfWYYMc+kkAzn78elxgggk=;
        b=2QnjM1SeFWxXmJrw27fv2lIzu0ACfZAFozfFjteT+xHMtXsfF821fzXo+5gKYuh3xAPdyD
        czbvQ/DTUU921vAI3StVMgkWQRUVomVzBpQlZ0o1sBX59pKhfEoIlmg/mT0C/jbF0ENGF/
        hiCXx49XArdd0701qfLuyJzY4u5qqCl4Dv/tNhK1OiJ2K1BYdKjIAhTE+VcTJa6brT7CpX
        qSeaq/BRvxwb/9WO7OwFG8JnSRsJ8wEMnj4xDPV7FhBtuhwchpwmBx1z6VNhErSOVaIxwn
        q0O22qmftUMD6dCPFgPsHJ4bS7FuGlrAJBCPD6PoZGudqOt5TI3Mvqq6bG3GRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647271631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ZIfmwWb2WbJZ9l5iSAxqdfWYYMc+kkAzn78elxgggk=;
        b=tpO0fU//UaLJH0a/mguVPCt3eT9qjNJU9AVu0j4bJIuf5oev7+wLDGQIpB+pxwT5U9bVpn
        5yr4AxND2pjfLMBA==
To:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: Re: [PATCH] genirq/msi: Shutdown managed interrupts with
 unsatifiable affinities
In-Reply-To: <20220307190625.254426-1-maz@kernel.org>
References: <20220307190625.254426-1-maz@kernel.org>
Date:   Mon, 14 Mar 2022 16:27:10 +0100
Message-ID: <87sfrkftbl.ffs@tglx>
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

On Mon, Mar 07 2022 at 19:06, Marc Zyngier wrote:
> When booting with maxcpus=<small number>, interrupt controllers
> such as the GICv3 ITS may not be able to satisfy the affinity of
> some managed interrupts, as some of the HW resources are simply
> not available.

This is also true if you have offlined lots of CPUs, right?

> In order to deal with this, do not try to activate such interrupt
> if there is no online CPU capable of handling it. Instead, place
> it in shutdown state. Once a capable CPU shows up, it will be
> activated.
>
> Reported-by: John Garry <john.garry@huawei.com>
> Reported-by: David Decotigny <ddecotig@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  kernel/irq/msi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 2bdfce5edafd..aa84ce84c2ec 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -818,6 +818,18 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
>  		irqd_clr_can_reserve(irqd);
>  		if (vflags & VIRQ_NOMASK_QUIRK)
>  			irqd_set_msi_nomask_quirk(irqd);
> +
> +		/*
> +		 * If the interrupt is managed but no CPU is available
> +		 * to service it, shut it down until better times.
> +		 */
> +		if ((vflags & VIRQ_ACTIVATE) &&
> +		    irqd_affinity_is_managed(irqd) &&
> +		    !cpumask_intersects(irq_data_get_affinity_mask(irqd),
> +					cpu_online_mask)) {
> +			    irqd_set_managed_shutdown(irqd);

Hrm. Why is this in the !CAN_RESERVE path and not before the actual
activation call?

Thanks,

        tglx
