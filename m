Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0390E4BC73F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiBSJ4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:56:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiBSJ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:56:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7F38A2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:56:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34477B8013C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9AFC004E1;
        Sat, 19 Feb 2022 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645264589;
        bh=oE4n057itlw6z2EKGJmIYQhY6E/5y7x1AOT0/sQpMMI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g0lbhpjjGxWweCjUcNJUB522eW0PRgXADI9p1QWopi1qyAUDziM0YvIHnmtwv28hS
         VPlj16C6Iyo9Fke4PtPLvQxCH4cGKjM55z9p/EgEMldmovrjLO3/SlNM5rcinXAfHU
         M+M6m2OIP2Yya0bqO4D7jT110e523sZs4r351y1XZV+p/O0Nquwm4NGl13F+JWpMKX
         I97lemeyEmOPK60gXRdqK70FY8bBw6Ctk5G+5wnJ1i3qXpPjesC71ZI5h/S0WE0lHR
         /4ABvTPJHuFaVYM52dkGnaYBnmUjE2/Tyb0OZYQCl3Vh5SQMh1hTCBQU5oDRc3+rHT
         Sh+8ztvWZDWgg==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nLMTa-008xLf-WF; Sat, 19 Feb 2022 09:56:27 +0000
MIME-Version: 1.0
Date:   Sat, 19 Feb 2022 09:56:26 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     tglx@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp
 before issuing ipi
In-Reply-To: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6432e7e97b828d887da8794c150161c4@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: 21cnbao@gmail.com, tglx@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, song.bao.hua@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-18 21:55, Barry Song wrote:
> dsb(ishst) should be enough here as we only need to guarantee the
> visibility of data to other CPUs in smp inner domain before we
> send the ipi.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 5e935d97207d..0efe1a9a9f3b 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data
> *d, const struct cpumask *mask)
>  	 * Ensure that stores to Normal memory are visible to the
>  	 * other CPUs before issuing the IPI.
>  	 */
> -	wmb();
> +	dsb(ishst);
> 
>  	for_each_cpu(cpu, mask) {
>  		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));

I'm not opposed to that change, but I'm pretty curious whether this 
makes
any visible difference in practice. Could you measure the effect of this 
change
for any sort of IPI heavy workload?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
