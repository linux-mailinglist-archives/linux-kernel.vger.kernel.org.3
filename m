Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4158554CABC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355650AbiFOOB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355476AbiFOOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:01:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBBB49F09;
        Wed, 15 Jun 2022 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655301658; x=1686837658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XQOkLiIW9Oms1pLS/Wzf09bv+SL7eq+F6lD6mW0FjJ4=;
  b=myxY9wYxmw3TjdDCuQc56gZNjN5vD3MsShIrMBGyCznJfVXLxD8BRnKs
   kWJDqt8KCnD4RnGetTE5MlLt33W+H/QNGs6RaOE8ZVNHU5PUo92cgzfJk
   HiEgggVdhkyfVfj9bBLenbz50ZbbfV2evUXGFuIUMz4uSzgwZiQoam55o
   2CdlJ/6xU/6zOxvd4oOlDW+UVzNVZsWKER/taq66skY1tvCHzs2hWrnTZ
   anITFF+LTMYc5J3+vTiu/4+MtoDjevOn9p9LBUwewJHQA72s5J4manEZ3
   ZOpbHYwrNq5Wrs4mwiFnkC6FhW8ztk301N9XgW7g4YPMpyT4nCHnpdzIw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340627229"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="340627229"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:00:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="612751019"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 07:00:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o1TZg-000dU2-DP;
        Wed, 15 Jun 2022 17:00:48 +0300
Date:   Wed, 15 Jun 2022 17:00:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v7 1/6] serial: 8250: make saved LSR larger
Message-ID: <YqnmEGLLKrlR37HE@smile.fi.intel.com>
References: <20220615124829.34516-1-ilpo.jarvinen@linux.intel.com>
 <20220615124829.34516-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615124829.34516-2-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:48:24PM +0300, Ilpo Järvinen wrote:
> DW flags address received as BIT(8) in LSR. In order to not lose that
> on read, enlarge lsr_saved_flags to u16.
> 
> Adjust lsr/status variables and related call chains to use u16.
> Technically, some of these type conversion would not be needed but it
> doesn't hurt to be consistent.

...

>  static void exar_shutdown(struct uart_port *port)
>  {
> -	unsigned char lsr;
> +	u16 lsr;

I would take a chance and move it under the longer line(s), like after xmit
(taking into account given context).

>  	bool tx_complete = false;
>  	struct uart_8250_port *up = up_to_u8250p(port);
>  	struct circ_buf *xmit = &port->state->xmit;

...

>  int fsl8250_handle_irq(struct uart_port *port)
>  {
> -	unsigned char lsr, orig_lsr;
> +	u16 lsr, orig_lsr;

Ditto. And so on.

>  	unsigned long flags;
>  	unsigned int iir;
>  	struct uart_8250_port *up = up_to_u8250p(port);

-- 
With Best Regards,
Andy Shevchenko


