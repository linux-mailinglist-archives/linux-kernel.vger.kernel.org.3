Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DB05905BB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiHKRWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiHKRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:22:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9910B7;
        Thu, 11 Aug 2022 10:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79CD3B82202;
        Thu, 11 Aug 2022 17:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE9CC433D6;
        Thu, 11 Aug 2022 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660238381;
        bh=4TnnSHe/Xp9maH0JKMds58skYOS7Cg1upinXS2ls2OM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RvpfFthYr58aCHVRgiI5w+v1WO2G2o/SCiIL4fy8KaZHl57NS4y8eCutaUGEPGj1i
         nfhG2CujkkaEzY0yxGWjkRwV34J5GGb98C0/x1BMn10QNRitkvJe2aaA98hcWp0mye
         QvSxERRPd8zyf6okW0JHHVmf43IVEwvxmxPWnHqjqXIXvpzLbjV0qXgztcWicLdInu
         GoLo5h8C2p8XZMARKypXyVbeH9D6E+tDNcQDsORdtQMm3OjbaAdsjQ3yNxuVN9L3Rs
         CmQKErC63+mMn9bB8sTv3urSZTiWrhgTn45aAkd6lOiTeM1rIpa9q15nZbqeMEvE8+
         k9lEH5sBDdO4w==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oMBqM-002Po5-PX;
        Thu, 11 Aug 2022 18:19:38 +0100
MIME-Version: 1.0
Date:   Thu, 11 Aug 2022 18:19:38 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, tglx@linutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, geert+renesas@glider.be,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        prabhakar.csengg@gmail.com, biju.das.jz@bp.renesas.com
Subject: Re: [PATCH] irqchip/sifive-plic: Make struct irq_chip const
In-Reply-To: <mhng-16e473fc-4513-4998-b732-9059d2c0b870@palmer-mbp2014>
References: <mhng-16e473fc-4513-4998-b732-9059d2c0b870@palmer-mbp2014>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <771e663cebf23735782a7ce41e51d33e@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: palmer@dabbelt.com, prabhakar.mahadev-lad.rj@bp.renesas.com, tglx@linutronix.de, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org, geert+renesas@glider.be, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, prabhakar.csengg@gmail.com, biju.das.jz@bp.renesas.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-11 17:53, Palmer Dabbelt wrote:
> On Fri, 24 Jun 2022 10:56:39 PDT (-0700),
> prabhakar.mahadev-lad.rj@bp.renesas.com wrote:
>> These should be const, so make it so.
>> 
>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>  drivers/irqchip/irq-sifive-plic.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/irqchip/irq-sifive-plic.c 
>> b/drivers/irqchip/irq-sifive-plic.c
>> index bb87e4c3b88e..173446cc9204 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -176,7 +176,7 @@ static void plic_irq_eoi(struct irq_data *d)
>>  	}
>>  }
>> 
>> -static struct irq_chip plic_chip = {
>> +static const struct irq_chip plic_chip = {
>>  	.name		= "SiFive PLIC",
>>  	.irq_mask	= plic_irq_mask,
>>  	.irq_unmask	= plic_irq_unmask,
> 
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Not sure if this got picked up somewhere, but it looks fine to me.

It probably needs respinning (the PLIC code has evolved a bit since).

         M.
-- 
Jazz is not dead. It just smells funny...
