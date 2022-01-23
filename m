Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9533E49709A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiAWImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 03:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiAWImP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 03:42:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CA6C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 00:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC654CE0AF5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 08:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D091C340E2;
        Sun, 23 Jan 2022 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642927330;
        bh=UUKmtuSMpupYk96XoQFSB2r4Gx4bW5PBbgIdLGWFxjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WSXFPTgNQ5Ur6bJqNztZGcCH7dbsSFMmfwoVrkKePMDbHa3KsDnkTzH+m7tQFZtNg
         /yr3ew3r3shqLdEK5q0/mdTJlLcb4OnlALUZr+Wcs9iOvbwH8WL9ssoLy59qHdUyG+
         1HEKVTpxf6/vLirRPRPzI7lhJzXFC26C9RYZhNuZfc2JJepODBaZGqef4g4Klpxq4X
         DzM3P+xz2qMYwlAGxYTRbuUUW4FYQS4mCLkk4BuR3D51KWGoRBQQF327SH9hncWmT7
         Qg/EdNUgd1ClLQq0Y3LsmqmonSrZ+OUHfq1OZegkqTr1+WMZjQvNwQx1l5sgW8XuwW
         0hIqpX1GJM0MA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nBYRr-002BGB-Ls; Sun, 23 Jan 2022 08:42:07 +0000
MIME-Version: 1.0
Date:   Sun, 23 Jan 2022 08:42:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH -next] irqchip/gic-v3-its: protect reference to
 cpus_booted_once_mask
In-Reply-To: <20220122234055.647-1-rdunlap@infradead.org>
References: <20220122234055.647-1-rdunlap@infradead.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <47b11387bfa17f7aafb9a2f39a72f956@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: rdunlap@infradead.org, linux-kernel@vger.kernel.org, lkp@intel.com, valentin.schneider@arm.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-22 23:40, Randy Dunlap wrote:
> When CONFIG_SMP is not set/enabled, the reference in irq-gic-v3-its.c
> to 'cpus_booted_once_mask' causes a build error. Fix this by
> first checking for !CONFIG_SMP in the 'if' test.
> 
> Fixes this build error:
> 
> arm-linux-gnueabi-ld: drivers/irqchip/irq-gic-v3-its.o: in function
> `its_cpu_memreserve_lpi':
> irq-gic-v3-its.c:(.text+0x45d0): undefined reference to 
> `cpus_booted_once_mask'
> 
> Fixes: 835f442fdbce3 ("irqchip/gic-v3-its: Limit memreserve cpuhp
> state lifetime")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-gic-v3-its.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20220121.orig/drivers/irqchip/irq-gic-v3-its.c
> +++ linux-next-20220121/drivers/irqchip/irq-gic-v3-its.c
> @@ -5241,7 +5241,8 @@ static int its_cpu_memreserve_lpi(unsign
> 
>  out:
>  	/* Last CPU being brought up gets to issue the cleanup */
> -	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
> +	if (!IS_ENABLED(CONFIG_SMP) ||
> +	    cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
>  		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
> 
>  	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;

This exact patch[1] has been queued yesterday.

Thanks,

         M.

[1] https://lore.kernel.org/r/20220122151614.133766-1-ardb@kernel.org
-- 
Jazz is not dead. It just smells funny...
