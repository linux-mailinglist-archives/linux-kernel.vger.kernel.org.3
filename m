Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5FD55E00C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiF1K5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiF1K5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:57:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF67331DC0;
        Tue, 28 Jun 2022 03:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656413824; x=1687949824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WKpsfZrkq24GzM+XFoOF1PmMcAsmja+uPPVG+NvAxaw=;
  b=Imkz2nsV9eKCI7BX1unDdSq/k13hlBrHNaxOpbgUp1fCjbvMPkpm0fW0
   erXzMZ3NggB79LHC/+5O33QNGxEGUDxiB6W6uotCmoiD51tuWxViX3E4l
   Ew72HIF599e2nmf+vYFU+YyPeXg4YOyeoIAzu91echoQjlJQEYjUbG+Ah
   Jb4Svfiu8NLy50l6l8q4vjgCFa79WsrHzMnlg2FL42IHBuI7c1Jh/Pt8m
   OFZJuArSN0gA5RuuoDPP757YCc2e54WvJ3LTg4HPv+EOs5zQkePvJVtzJ
   95dm/gDVLwQVGFSbfANmV1ztGzMuRfdz+GUCFM6JQDBF8DvMVbxfIhEtv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261511873"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="261511873"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:57:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="587829952"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:57:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o68tv-000wkA-R2;
        Tue, 28 Jun 2022 13:56:59 +0300
Date:   Tue, 28 Jun 2022 13:56:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND tty-next] serial: 8250_dw: Take port lock while
 accessing LSR
Message-ID: <Yrree8HOrk3D2TzX@smile.fi.intel.com>
References: <c5879db7-bee9-93f-526e-872a292442@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5879db7-bee9-93f-526e-872a292442@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:01:28PM +0300, Ilpo Järvinen wrote:
> Accessing LSR requires port lock because it mutates lsr_saved_flags
> in serial_lsr_in().

Don't remember if I given or not (and why if not) the tag, so here it is:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 197eb5c416ff ("serial: 8250_dw: Use serial_lsr_in() in dw8250_handle_irq()")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ---
> I'll resend the third patch later.
> 
>  drivers/tty/serial/8250/8250_dw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 167a691c7b19..f78b13db1b1e 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -266,7 +266,10 @@ static int dw8250_handle_irq(struct uart_port *p)
>  
>  	/* Manually stop the Rx DMA transfer when acting as flow controller */
>  	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
> +		spin_lock_irqsave(&p->lock, flags);
>  		status = serial_lsr_in(up);
> +		spin_unlock_irqrestore(&p->lock, flags);
> +
>  		if (status & (UART_LSR_DR | UART_LSR_BI)) {
>  			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
>  			dw8250_writel_ext(p, DW_UART_DMASA, 1);
> 
> -- 
> tg: (f55d2e4b0a47..) dw/use-spinlock (depends on: 8250/fix-stop_tx-race)


-- 
With Best Regards,
Andy Shevchenko


