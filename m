Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709124BCF5B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiBTPVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:21:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbiBTPVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:21:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E114AE3A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:21:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B811B80DA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 15:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2340FC340E8;
        Sun, 20 Feb 2022 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645370478;
        bh=eJnycS5qt53VsIB/N/fp6arZcftkp16IIbquI152IwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aTd1ygMJBMoiyl0mBId332V1eIyqxzN1V3Ffb9ZNwAfsCvK3p37KxRw+xnwCR+r8j
         tUDxMHfajrvDHKDmJD20Oc8dncfwtwUZVgL7Hl7XlrHpw48simvkCzbOoX/T/HZpKN
         ABPbNbsw1U9tUO/epGzTj6+DpZ3K5SkxWa3lpVhGwNgsn3GEAT8KlThAXvCCjwFGhR
         gMw68pV0Etf0MgbAwAcLt9OdQX8kxdkfUQ5WCaIs9cdT6T21jMGpHYz+DUmXgRgvO4
         MXAR4WQyiBZbkGPgV8Y+XqREPRugx7IT6J3F5JMsTJddkAPoSB1LyZ2nGqvH50LWee
         0iQDzLtr6hmqQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nLo1U-00958w-2E; Sun, 20 Feb 2022 15:21:16 +0000
MIME-Version: 1.0
Date:   Sun, 20 Feb 2022 15:21:15 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Barry Song <21cnbao@gmail.com>, tglx@linutronix.de,
        will@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp
 before issuing ipi
In-Reply-To: <YhJYct7aW0kGXNXp@shell.armlinux.org.uk>
References: <20220218215549.4274-1-song.bao.hua@hisilicon.com>
 <YhJYct7aW0kGXNXp@shell.armlinux.org.uk>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <c10d6044786fdf78ef4bc7fac2544096@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@armlinux.org.uk, 21cnbao@gmail.com, tglx@linutronix.de, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, song.bao.hua@hisilicon.com
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

On 2022-02-20 15:04, Russell King (Oracle) wrote:
> On Sat, Feb 19, 2022 at 05:55:49AM +0800, Barry Song wrote:
>> dsb(ishst) should be enough here as we only need to guarantee the
>> visibility of data to other CPUs in smp inner domain before we
>> send the ipi.
>> 
>> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
>> ---
>>  drivers/irqchip/irq-gic-v3.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3.c 
>> b/drivers/irqchip/irq-gic-v3.c
>> index 5e935d97207d..0efe1a9a9f3b 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data 
>> *d, const struct cpumask *mask)
>>  	 * Ensure that stores to Normal memory are visible to the
>>  	 * other CPUs before issuing the IPI.
>>  	 */
>> -	wmb();
>> +	dsb(ishst);
> 
> On ARM, wmb() is a dsb(st) followed by other operations which may
> include a sync operation at the L2 cache, and SoC specific barriers
> for the bus. Hopefully, nothing will break if the sledge hammer is
> replaced by the tack hammer.

The saving grace is that ARMv8 forbids (as per D4.4.11) these 
SW-visible,
non architected caches (something like PL310 simply isn't allowed). 
Given
that GICv3 requires ARMv8 the first place, we should be OK.

As for SoC-specific bus barriers, I don't know of any that would affect
an ARMv8 based SoC. But I'm always prepared to be badly surprised...

         M.
-- 
Jazz is not dead. It just smells funny...
