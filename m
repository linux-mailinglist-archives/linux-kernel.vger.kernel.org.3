Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5E0573AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiGMQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiGMQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:11:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584CF29C8F;
        Wed, 13 Jul 2022 09:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657728696; x=1689264696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MYSKoO4+JA1HLIxr6+ZiGU46DVwUCWwtwniY7flkkp4=;
  b=aTzSBd44Q05EgMeRC11W9Xg2pTjAN5xZ6lvpvguTjW0/aP1cau3uXEkI
   3+XcnsQSgrYgsitqLCPMCuEWK6Em4DDjgg9KTeV0hlPZ1rIq74xGWJVHA
   eNluFRARFunYQ3fHqScjBOtYgeEpowrVBQMCqGOPTKX8vGOcW8dTTBtUA
   7I+DN5G6SWvF6CGeFMe+btKvt+kxe9hvrb6pUrBuy+FvoIKdU/T0gMREB
   pRNuzoLORybWebeqKpvZjXo9GmmZ5I14sGkYfmejj3RbmDL6f11HGYOQr
   vkQY/oRuLxn8wdFvtuF42cjCxh8yf6KtsC5JihYIZyUCjB3XMA+BuZPSn
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="268304430"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="268304430"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:11:35 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="545912368"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 09:11:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oBexW-001CSU-0Y;
        Wed, 13 Jul 2022 19:11:30 +0300
Date:   Wed, 13 Jul 2022 19:11:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vamshi Gajjela <vamshigajjela@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com
Subject: Re: [PATCH v3] serial: 8250_dw: Avoid pslverr on reading empty
 receiver fifo
Message-ID: <Ys7usW3W3kemtVc+@smile.fi.intel.com>
References: <20220713131722.2316829-1-vamshigajjela@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713131722.2316829-1-vamshigajjela@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 06:47:22PM +0530, Vamshi Gajjela wrote:
> From: VAMSHI GAJJELA <vamshigajjela@google.com>
> 
> With PSLVERR_RESP_EN parameter set to 1, the device generates an error
> response when an attempt to read an empty RBR with FIFO enabled.
> 
> This happens when LCR writes are ignored when UART is busy.
> dw8250_check_lcr() in retries to update LCR, invokes dw8250_force_idle()
> to clear and reset FIFO and eventually reads UART_RX causing the error.
> 
> Avoid this by not reading RBR/UART_RX when no data is available.

From code perspective looks good,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

but maybe Ilpo or others have something to add based on the practical use.

> Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
> ---
> v3:
> - check lsr based on FIFO enablement
> v2:
> - update as per review comments (re-format comments, xmas tree ordering)
>  drivers/tty/serial/8250/8250_dw.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f57bbd32ef11..7573904579f6 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -82,8 +82,21 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
>  static void dw8250_force_idle(struct uart_port *p)
>  {
>  	struct uart_8250_port *up = up_to_u8250p(p);
> +	unsigned int lsr;
>  
>  	serial8250_clear_and_reinit_fifos(up);
> +
> +	/*
> +	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
> +	 * error response when an attempt to read an empty RBR with FIFO
> +	 * enabled.
> +	 */
> +	if (up->fcr & UART_FCR_ENABLE_FIFO) {
> +		lsr = p->serial_in(p, UART_LSR);
> +		if (!(lsr & UART_LSR_DR))
> +			return;
> +	}
> +
>  	(void)p->serial_in(p, UART_RX);
>  }
>  
> -- 
> 2.37.0.144.g8ac04bfd2-goog
> 

-- 
With Best Regards,
Andy Shevchenko


