Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A052CEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbiESI5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiESI5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:57:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCA956FA1;
        Thu, 19 May 2022 01:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652950619; x=1684486619;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wYyL5jNtJLvThuTJXbDz7/sXDwDLXfvwFOauQDsuJu8=;
  b=Q0H9nCSER7PJ6fj43FHJMW+Z/fBJIxAbHWtRcpYuALTmHc+OuhbUE9EG
   Ae+U+kOLnxZG5qK+NZCRodmMrY/opw9A0tSgogFazGfk+LheLzjEMh0JP
   oSJ+SaSgtUVKxXKESamSi1OnSdfjVI0iw15FIA2CItFF30rqk63+qAn7Q
   mvkyQON8b1lDuBnRd85Jgj+4vE8JJ/6EDeMaTC76TGHPVxjCKS+8+UxOi
   ZAyP0+n+eDgWwLYO+umaoDQRh8ypJClYtMNDKhVUdh67rAA/Y0I6GIO7g
   L5Zao1dyXNobj2c8kvmvrT/Pncc3ftEX2LsfONnu0/sPF1wVJ/GhcuCmj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="252621613"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="252621613"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:56:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598445313"
Received: from ivanovbx-mobl1.ger.corp.intel.com ([10.249.33.234])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 01:56:57 -0700
Date:   Thu, 19 May 2022 11:56:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jslaby@suse.cz>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] serial: pmac_zilog: remove unfinished DBDMA
 support
In-Reply-To: <20220519075653.31356-1-jslaby@suse.cz>
Message-ID: <2f7a739f-61b4-a1af-7c9b-70c5b93c6281@linux.intel.com>
References: <20220519075653.31356-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022, Jiri Slaby wrote:

> The support for DBDMA was never completed. Remove the the code that only
> maps spaces without real work.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/serial/pmac_zilog.c | 38 +--------------------------------
>  drivers/tty/serial/pmac_zilog.h |  9 --------
>  2 files changed, 1 insertion(+), 46 deletions(-)
> 
> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
> index c903085acb8d..2953ff64a892 100644
> --- a/drivers/tty/serial/pmac_zilog.c
> +++ b/drivers/tty/serial/pmac_zilog.c

How about dropping this too:
#include <asm/dbdma.h>

-- 
 i.


> @@ -65,9 +65,6 @@
>  
>  #include "pmac_zilog.h"
>  
> -/* Not yet implemented */
> -#undef HAS_DBDMA
> -
>  static char version[] __initdata = "pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)";
>  MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
>  MODULE_DESCRIPTION("Driver for the Mac and PowerMac serial ports.");
> @@ -1399,7 +1396,7 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
>  		char	name[1];
>  	} *slots;
>  	int len;
> -	struct resource r_ports, r_rxdma, r_txdma;
> +	struct resource r_ports;
>  
>  	/*
>  	 * Request & map chip registers
> @@ -1411,35 +1408,6 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
>  
>  	uap->control_reg = uap->port.membase;
>  	uap->data_reg = uap->control_reg + 0x10;
> -	
> -	/*
> -	 * Request & map DBDMA registers
> -	 */
> -#ifdef HAS_DBDMA
> -	if (of_address_to_resource(np, 1, &r_txdma) == 0 &&
> -	    of_address_to_resource(np, 2, &r_rxdma) == 0)
> -		uap->flags |= PMACZILOG_FLAG_HAS_DMA;
> -#else
> -	memset(&r_txdma, 0, sizeof(struct resource));
> -	memset(&r_rxdma, 0, sizeof(struct resource));
> -#endif	
> -	if (ZS_HAS_DMA(uap)) {
> -		uap->tx_dma_regs = ioremap(r_txdma.start, 0x100);
> -		if (uap->tx_dma_regs == NULL) {	
> -			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
> -			goto no_dma;
> -		}
> -		uap->rx_dma_regs = ioremap(r_rxdma.start, 0x100);
> -		if (uap->rx_dma_regs == NULL) {	
> -			iounmap(uap->tx_dma_regs);
> -			uap->tx_dma_regs = NULL;
> -			uap->flags &= ~PMACZILOG_FLAG_HAS_DMA;
> -			goto no_dma;
> -		}
> -		uap->tx_dma_irq = irq_of_parse_and_map(np, 1);
> -		uap->rx_dma_irq = irq_of_parse_and_map(np, 2);
> -	}
> -no_dma:
>  
>  	/*
>  	 * Detect port type
> @@ -1505,8 +1473,6 @@ static int __init pmz_init_port(struct uart_pmac_port *uap)
>  	    of_device_is_compatible(np->parent->parent, "gatwick")) {
>  		/* IRQs on gatwick are offset by 64 */
>  		uap->port.irq = irq_create_mapping(NULL, 64 + 15);
> -		uap->tx_dma_irq = irq_create_mapping(NULL, 64 + 4);
> -		uap->rx_dma_irq = irq_create_mapping(NULL, 64 + 5);
>  	}
>  
>  	/* Setup some valid baud rate information in the register
> @@ -1526,8 +1492,6 @@ static void pmz_dispose_port(struct uart_pmac_port *uap)
>  	struct device_node *np;
>  
>  	np = uap->node;
> -	iounmap(uap->rx_dma_regs);
> -	iounmap(uap->tx_dma_regs);
>  	iounmap(uap->control_reg);
>  	uap->node = NULL;
>  	of_node_put(np);
> diff --git a/drivers/tty/serial/pmac_zilog.h b/drivers/tty/serial/pmac_zilog.h
> index fa85b0de5c2f..87337b748d6d 100644
> --- a/drivers/tty/serial/pmac_zilog.h
> +++ b/drivers/tty/serial/pmac_zilog.h
> @@ -43,7 +43,6 @@ struct uart_pmac_port {
>  #define PMACZILOG_FLAG_TX_ACTIVE	0x00000040
>  #define PMACZILOG_FLAG_IS_IRDA		0x00000100
>  #define PMACZILOG_FLAG_IS_INTMODEM	0x00000200
> -#define PMACZILOG_FLAG_HAS_DMA		0x00000400
>  #define PMACZILOG_FLAG_RSRC_REQUESTED	0x00000800
>  #define PMACZILOG_FLAG_IS_OPEN		0x00002000
>  #define PMACZILOG_FLAG_IS_EXTCLK	0x00008000
> @@ -55,13 +54,6 @@ struct uart_pmac_port {
>  	volatile u8			__iomem *control_reg;
>  	volatile u8			__iomem *data_reg;
>  
> -#ifdef CONFIG_PPC_PMAC
> -	unsigned int			tx_dma_irq;
> -	unsigned int			rx_dma_irq;
> -	volatile struct dbdma_regs	__iomem *tx_dma_regs;
> -	volatile struct dbdma_regs	__iomem *rx_dma_regs;
> -#endif
> -
>  	unsigned char			irq_name[8];
>  
>  	struct ktermios			termios_cache;
> @@ -377,7 +369,6 @@ static inline void zssync(struct uart_pmac_port *port)
>  #define ZS_WANTS_MODEM_STATUS(UP)	((UP)->flags & PMACZILOG_FLAG_MODEM_STATUS)
>  #define ZS_IS_IRDA(UP)			((UP)->flags & PMACZILOG_FLAG_IS_IRDA)
>  #define ZS_IS_INTMODEM(UP)		((UP)->flags & PMACZILOG_FLAG_IS_INTMODEM)
> -#define ZS_HAS_DMA(UP)			((UP)->flags & PMACZILOG_FLAG_HAS_DMA)
>  #define ZS_IS_OPEN(UP)			((UP)->flags & PMACZILOG_FLAG_IS_OPEN)
>  #define ZS_IS_EXTCLK(UP)		((UP)->flags & PMACZILOG_FLAG_IS_EXTCLK)
>  
> 

