Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F278B516F5A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384932AbiEBMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381903AbiEBMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:16:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7761388B;
        Mon,  2 May 2022 05:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651493591; x=1683029591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sJ60E5BWBY9FCFWfQXJljYPhZ2BPxZzhp2CW1/egp3c=;
  b=aQYP82nk/mXs4sgNiq4C2oDRVX3rkDbC8c7spCM/IzgR40N7dqxrWosk
   o3vTcpyS7pc4m2C0pHIor9BoH11mYSqPhd9aT+qpw4NuywADVd11jfbN/
   qWkfSQuBG37BPZ9LHYA2/UQMb7F9ceZU9i5r7CraG7oKDbv4J41fCsTdE
   PclsjVjiFvfPeDU7nXQ6kmeF8//uc0r7uEIFKs6cgT1oHffuHcXgXREtf
   fb0bao9O8b5L25dvcNB82kUn4dAQfNFe8HpfsHDHvFgPZs8bBSNRWWIrb
   ohkkQfeC5X3V2hE16vI8GFLP66T8BMjyMlWmausfB7nmfxmoxKUXC0iHZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="267348634"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="267348634"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:13:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="546252629"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 05:12:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nlUv8-00B2Vf-A3;
        Mon, 02 May 2022 15:12:54 +0300
Date:   Mon, 2 May 2022 15:12:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: dw: Fix NULL pointer dereference
Message-ID: <Ym/KxaRfOaAS8Tzq@smile.fi.intel.com>
References: <20220502115621.77985-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502115621.77985-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:56:21PM +0300, Heikki Krogerus wrote:
> dw8250_platform_data is only used on DT platforms for now.

Ah, good catch, Heikki!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks

> Fixes: 4a218b277fdb ("serial: 8250: dw: Create a generic platform data structure")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Hi,
> 
> I'm sorry, I have to resend this (to you guys).
> I left out the mailing lists.
> 
> Br,
> ---
>  drivers/tty/serial/8250/8250_dw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index 0cf1a99dc1244..31422e44c64ff 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -433,9 +433,9 @@ static void dw8250_prepare_rx_dma(struct uart_8250_port *p)
>  static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
>  {
>  	struct device_node *np = p->dev->of_node;
> -	unsigned int quirks = data->pdata->quirks;
>  
>  	if (np) {
> +		unsigned int quirks = data->pdata->quirks;
>  		int id;
>  
>  		/* get index of serial line, if found in DT aliases */
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


