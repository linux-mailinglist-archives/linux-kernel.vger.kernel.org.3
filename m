Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9C583AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiG1Iw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiG1Iw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:52:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F36554C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 01:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CB0AB8236F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F9FC433D6;
        Thu, 28 Jul 2022 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658998341;
        bh=eT29zq1Ur4doyC+Ml51KFZUgnDShn/P0L50vYqHqY/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VWD2xwtSpC+nH6QRPqit5BsBGZZcEi1zkgVGT/p4PbiI7fegUvnKp00oXhvnB876y
         GaSfr1KsHnVw8XdPqlmQMAgX+rRK+PTTd1U3E+HCIGGu4srKniGa0HVEiBWf4x2mkq
         siv06fCYdYSLM+vppjULnQWHuCCvaIgxQiUnVOL0aOJPH89PCM/ZcVuu3Op78daffK
         2feKKB5L/9VYkracCP9cKlQf+lZKzRR1B3WdgDh4B+S6M+LhprueX3Wvw8CddhZuQZ
         iDL0vdaiLW3RfhPfeHNkk0hhVwYz3RnAomxXBkb+zZOPYwKCJuvvkmgjwHatWDaFpR
         0/PGmfzHxmerA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oGzFi-00AcQT-Qf;
        Thu, 28 Jul 2022 09:52:19 +0100
MIME-Version: 1.0
Date:   Thu, 28 Jul 2022 09:52:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        George Cherian <george.cherian@marvell.com>,
        sgoutham@marvell.com, "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>,
        xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: allow selection of number of sparse irqs
In-Reply-To: <20220728030420.2279713-1-danielwa@cisco.com>
References: <20220728030420.2279713-1-danielwa@cisco.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <980a561ed87c5530aab2e2b067074862@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: danielwa@cisco.com, tglx@linutronix.de, george.cherian@marvell.com, sgoutham@marvell.com, bobbliu@cisco.com, xe-linux-external@cisco.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-28 04:04, Daniel Walker wrote:
> Currently the maximum number of interrupters is capped at 8260 (64 +
> 8196) in most of the architectures were CONFIG_SPARSE_IRQ is selected.
> This upper limit is not sufficient for couple of existing SoC's from
> Marvell.
> For eg: Octeon TX2 series of processors support a maximum of 32K
> interrupters.
> 
> Allow configuration of the upper limit of the number of interrupts.
> 
> Cc: George Cherian <george.cherian@marvell.com>
> Cc: sgoutham@marvell.com
> Cc: "BOBBY Liu (bobbliu)" <bobbliu@cisco.com>
> Cc: xe-linux-external@cisco.com
> Signed-off-by: Daniel Walker <danielwa@cisco.com>
> ---
>  kernel/irq/Kconfig     | 23 +++++++++++++++++++++++
>  kernel/irq/internals.h | 10 +++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index db3d174c53d4..b356217abcfe 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -125,6 +125,29 @@ config SPARSE_IRQ
> 
>  	  If you don't know what to do here, say N.
> 
> +choice
> +	prompt "Select number of sparse irqs"
> +	depends on SPARSE_IRQ
> +	default SPARSE_IRQ_EXTEND_8K
> +	help
> +          Allows choosing the number of sparse irq's available on the
> +          system. For each 8k of additional irqs added there is 
> approximatly
> +          1kb of kernel size increase.
> +
> +config SPARSE_IRQ_EXTEND_8K
> +	bool "8k"
> +
> +config SPARSE_IRQ_EXTEND_16K
> +	bool "16K"
> +
> +config SPARSE_IRQ_EXTEND_32K
> +	bool "32K"
> +
> +config SPARSE_IRQ_EXTEND_64K
> +	bool "64K"
> +
> +endchoice
> +
>  config GENERIC_IRQ_DEBUGFS
>  	bool "Expose irq internals in debugfs"
>  	depends on DEBUG_FS
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index f09c60393e55..25fe5abf6c16 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -12,7 +12,15 @@
>  #include <linux/sched/clock.h>
> 
>  #ifdef CONFIG_SPARSE_IRQ
> -# define IRQ_BITMAP_BITS	(NR_IRQS + 8196)
> +# if defined(CONFIG_SPARSE_IRQ_EXTEND_8K)
> +# define IRQ_BITMAP_BITS	(NR_IRQS + 8192 + 4)
> +# elif defined(CONFIG_SPARSE_IRQ_EXTEND_16K)
> +# define IRQ_BITMAP_BITS	(NR_IRQS + 16384 + 4)
> +# elif defined(CONFIG_SPARSE_IRQ_EXTEND_32K)
> +# define IRQ_BITMAP_BITS	(NR_IRQS + 32768 + 4)
> +# elif defined(CONFIG_SPARSE_IRQ_EXTEND_64K)
> +# define IRQ_BITMAP_BITS	(NR_IRQS + 65536 + 4)
> +# endif
>  #else
>  # define IRQ_BITMAP_BITS	NR_IRQS
>  #endif

It really feels like the wrong approach. If your system
supports a large number of interrupt (I guess it has
a GICv3 ITS), this shouldn't impact the lesser machines
(most people are using a distro kernel).

It also doesn't really scale: the GICv3 architecture gives
you up to 24 bits of interrupts. Are we going to allocate
2MB worth of bitmap? Future interrupt architectures may have
even larger interrupt spaces.

As it turns out, we already store the irqdesc in an rb-tree.
It doesn't take too much imagination to turn this into a
xarray and use it for both allocation and tracking.

It would also conveniently replace the irqs_resend bitmap
if using marks to flag the IRQs to be resent.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
