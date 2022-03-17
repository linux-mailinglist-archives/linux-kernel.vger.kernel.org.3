Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789064DC9F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiCQP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiCQP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:29:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0324154497
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85F99B81E9E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4847CC340E9;
        Thu, 17 Mar 2022 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647530881;
        bh=hN8xQVVF/q7RWAXWD35WxGlCSnYQIq4OKytp1ktzTLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ptgbokUFdfVwmApcrCiYJJ8eaaUD9B2IXUnSJeEldTKiNy/7B4erY9BjQQOKlUDZm
         cs+IszBPzAj1T31lipeQshGD7ItljRdN+X7fNbAQ6zxluEf08kSNkElu5WHdyk/j0M
         x9VsfAOzAZA+jHbc1feSB7YHC/sypjbDwH0ZqyLWYocVup3D5B9VwFqRAd6EC0Q629
         X1If6cnkGDAVc0w5AhhRX+74NcU3q88U7E+4cg+GCHohCJ0WiScUfwNGtzn0KrlKqo
         nYKigeFn6zzVIfjKj7NXCHau1Dq0ZhnYAkTr2u8h+SzumWUtRh/pgvuewMhdZjEaJ9
         Ux6Bs5HJMw51w==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nUs2g-00FDm3-Vu; Thu, 17 Mar 2022 15:27:59 +0000
MIME-Version: 1.0
Date:   Thu, 17 Mar 2022 15:27:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] irq/qcom-mpm: Fix build error without MAILBOX
In-Reply-To: <20220317135917.GA360113@dragon>
References: <20220317131956.30004-1-yuehaibing@huawei.com>
 <20220317135917.GA360113@dragon>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e1a74161a77004a565906e65ff764f65@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shawn.guo@linaro.org, yuehaibing@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-17 13:59, Shawn Guo wrote:
> On Thu, Mar 17, 2022 at 09:19:56PM +0800, YueHaibing wrote:
>> If MAILBOX is n, building fails:
>> 
>> drivers/irqchip/irq-qcom-mpm.o: In function `mpm_pd_power_off':
>> irq-qcom-mpm.c:(.text+0x174): undefined reference to 
>> `mbox_send_message'
>> irq-qcom-mpm.c:(.text+0x174): relocation truncated to fit: 
>> R_AARCH64_CALL26 against undefined symbol `mbox_send_message'
>> 
>> Make QCOM_MPM depends on MAILBOX to fix this.
>> 
>> Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
>> ---
>>  drivers/irqchip/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 680d2fcf2686..15edb9a6fcae 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -433,6 +433,7 @@ config QCOM_PDC
>>  config QCOM_MPM
>>  	tristate "QCOM MPM"
>>  	depends on ARCH_QCOM
>> +	depends on MAILBOX
>>  	select IRQ_DOMAIN_HIERARCHY
>>  	help
>>  	  MSM Power Manager driver to manage and configure wakeup
>> --
>> 2.17.1
>> 

Hmmm... Even if that fix the build, this still isn't correct, is it?
You also need the mailbox *driver* to be selected. How is that
dependency enforced?

I'll queue this to fix -next, but this really is papering over
a bigger problem.

         M.
-- 
Jazz is not dead. It just smells funny...
