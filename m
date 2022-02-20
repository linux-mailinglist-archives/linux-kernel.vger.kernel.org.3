Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF3E4BCF40
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244111AbiBTPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:05:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbiBTPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:05:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA3631DCF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:04:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BED01611CE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:04:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30047C340E8;
        Sun, 20 Feb 2022 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645369496;
        bh=fZPTSvnh4YHQ8D1myNfcH54rXKHDXQJ0WyVEVbo+D4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JpAlhX433ZrMRryMljDJdvPbfIU6fHHqJCPrVFj/Eg6dRhXWNfDXIT3+j9SRfycrj
         hHNKdfLkZnJtOUFQC7uxAcAKlFZppp1aqt/1RJDEQtQM6fxuslQ9NERHGWT37cAUC9
         oAJojKSEBTNvnqM4A44eH1CA5j84amNmU8OmRsUSNma4/Db+wb3Fea+Xp9yJYuMQG6
         HfsBxXtPD5y231gpPJXGK8hfJIayhSEVIIMbMMEbjQ9vAAydsEr8HznUmkpOaPWIq9
         D5hMtrlFUkFMprsuko3GWRFYFOJS6r/Mm7y7ngBG348C4ipnkZExI7whhSGJUrG4j2
         1Bvfg+8EpxcOQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nLnle-0094yi-0f; Sun, 20 Feb 2022 15:04:54 +0000
MIME-Version: 1.0
Date:   Sun, 20 Feb 2022 15:04:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Barry Song <21cnbao@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp
 before issuing ipi
In-Reply-To: <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
 <6432e7e97b828d887da8794c150161c4@kernel.org>
 <CAMj1kXF14uEM=eTsqKR8MBWYS_yebMQF5kca86gGyuXkjs+GRg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <49ee858267c75144c601b1e42d4f4c28@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, 21cnbao@gmail.com, tglx@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, song.bao.hua@hisilicon.com
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

On 2022-02-20 13:30, Ard Biesheuvel wrote:
> On Sat, 19 Feb 2022 at 10:57, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2022-02-18 21:55, Barry Song wrote:
>> > dsb(ishst) should be enough here as we only need to guarantee the
>> > visibility of data to other CPUs in smp inner domain before we
>> > send the ipi.
>> >
>> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> > ---
>> >  drivers/irqchip/irq-gic-v3.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/irqchip/irq-gic-v3.c
>> > b/drivers/irqchip/irq-gic-v3.c
>> > index 5e935d97207d..0efe1a9a9f3b 100644
>> > --- a/drivers/irqchip/irq-gic-v3.c
>> > +++ b/drivers/irqchip/irq-gic-v3.c
>> > @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data
>> > *d, const struct cpumask *mask)
>> >        * Ensure that stores to Normal memory are visible to the
>> >        * other CPUs before issuing the IPI.
>> >        */
>> > -     wmb();
>> > +     dsb(ishst);
>> >
>> >       for_each_cpu(cpu, mask) {
>> >               u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
>> 
>> I'm not opposed to that change, but I'm pretty curious whether this
>> makes
>> any visible difference in practice. Could you measure the effect of 
>> this
>> change
>> for any sort of IPI heavy workload?
>> 
> 
> Does this have to be a DSB ?

We can use a DMB ISHST for the other interrupt controllers that use a
MMIO access to signal the IPI, as we need to order the previous writes 
with
the MMIO access (and DMB fits that bill).

For GICv3 when ICC_SRE_EL1.SRE==1, we need to order a set of writes with
a system register access with side effects, and the only barrier that
allows us to do that is DSB.

It is a bit unfortunate that the relative lightweight nature of the 
sysreg
CPU interface is encumbered by fairly heavy barriers (the most horrible 
one
being the DSB SY on each read of IAR to be able to synchronise the CPU 
interface
and the redistributor).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
