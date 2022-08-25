Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7A85A1810
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbiHYRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiHYRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:40:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D915A2B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 10:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52FCFB82854
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 17:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA516C433D6;
        Thu, 25 Aug 2022 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661449201;
        bh=SDKoz9koOirHvmApzriJuYbcGoefIYVkRUX1jcIAjBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JyMmAyd8AuAnjX8D7YcczoKlEXp4thYLLjDKpoDSWWGtYedQ+d0CC/u7TYqSCBHiB
         RF2erq/R/7l5PLX5U5yYpfwZFuZu68MH0L/b/qIdqFKAXiJuiEzEooxKJzeo/pwvBl
         M91+zMmZCC68/RAAGDjc5RZoXBktyoBHqPhJyoHYG1lm0t8+gM4EHEG4K0igVZ1kcJ
         J5Ev852qPE6aU8eWzD7g2E2OhA6GPpwB1vrvyf6CgmVdhnw2GaO0qMaztvDBLMFa5x
         s/MMeMi4kmYowGOOF/tssXJDkuWi+lybRz6bcUI0sCjwDYB2MMvf9cvOSu4pRI+lwF
         4DA8PSJa4LeWg==
Date:   Thu, 25 Aug 2022 12:39:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] earlyprintk: Clean up pciserial
Message-ID: <20220825173959.GA2856913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 01:36:40PM +0200, Peter Zijlstra wrote:
> 
> While working on a GRUB patch to support PCI-serial, a number of
> cleanups were suggested that apply to the code I took inspiration from.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
>  arch/x86/kernel/early_printk.c | 14 +++++++-------
>  include/linux/pci_ids.h        |  3 +++
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
> index 68b38925a74f..44f937015e1e 100644
> --- a/arch/x86/kernel/early_printk.c
> +++ b/arch/x86/kernel/early_printk.c
> @@ -264,11 +264,11 @@ static __init void early_pci_serial_init(char *s)
>  	bar0 = read_pci_config(bus, slot, func, PCI_BASE_ADDRESS_0);
>  
>  	/*
> -	 * Verify it is a UART type device
> +	 * Verify it is a 16550-UART type device
>  	 */
>  	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
>  	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
> -	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
> +	    (((classcode >> 8) & 0xff) != PCI_SERIAL_16550_COMPATIBLE)) {
>  		if (!force)
>  			return;
>  	}
> @@ -276,22 +276,22 @@ static __init void early_pci_serial_init(char *s)
>  	/*
>  	 * Determine if it is IO or memory mapped
>  	 */
> -	if (bar0 & 0x01) {
> +	if ((bar0 & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
>  		/* it is IO mapped */
>  		serial_in = io_serial_in;
>  		serial_out = io_serial_out;
> -		early_serial_base = bar0&0xfffffffc;
> +		early_serial_base = bar0 & PCI_BASE_ADDRESS_IO_MASK;
>  		write_pci_config(bus, slot, func, PCI_COMMAND,
> -						cmdreg|PCI_COMMAND_IO);
> +				 cmdreg|PCI_COMMAND_IO);
>  	} else {
>  		/* It is memory mapped - assume 32-bit alignment */
>  		serial_in = mem32_serial_in;
>  		serial_out = mem32_serial_out;
>  		/* WARNING! assuming the address is always in the first 4G */
>  		early_serial_base =
> -			(unsigned long)early_ioremap(bar0 & 0xfffffff0, 0x10);
> +			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
>  		write_pci_config(bus, slot, func, PCI_COMMAND,
> -						cmdreg|PCI_COMMAND_MEMORY);
> +				 cmdreg|PCI_COMMAND_MEMORY);
>  	}
>  
>  	/*
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6feade66efdb..1d2c7df8cd41 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -75,6 +75,9 @@
>  #define PCI_CLASS_COMMUNICATION_MODEM	0x0703
>  #define PCI_CLASS_COMMUNICATION_OTHER	0x0780
>  
> +/* I/F for SERIAL/MODEM */

I/F?  Grep says it's fairly common, but doesn't seem completely
obvious.  I guess it means "interface"?

> +#define PCI_SERIAL_16550_COMPATIBLE	0x02
> +
>  #define PCI_BASE_CLASS_SYSTEM		0x08
>  #define PCI_CLASS_SYSTEM_PIC		0x0800
>  #define PCI_CLASS_SYSTEM_PIC_IOAPIC	0x080010
