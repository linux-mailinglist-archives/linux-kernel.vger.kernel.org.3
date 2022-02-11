Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0494B22F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiBKKU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:20:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBKKUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:20:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F82A5;
        Fri, 11 Feb 2022 02:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644574823; x=1676110823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJ+0ZmlVTd1NI8J1ND1o+WTJfa5qruEZ7EtRTsDra1o=;
  b=nbCIxheDepA12YuGBuiLfifyx6PXQOa49hfOofMdqt6bI4D44jGHmDQI
   wlgpDGiXK13XFEw1qidcsCmSnbI63f/3iikT4b91xpgnY/G4039m0OlpQ
   hsKxRmNIm31f93u/xWrTg/Ccamg/2SO9awkF41q0lRRwzkGhRSx9TSost
   q69Pj/V4/HQwDOtigVUYAG2rvbYVHTkjTgg28r5LPsiiz5Xk9maZ+HjTZ
   cLBg9SSBCAg1xSFvdLfazTJdsEBHfYIsFKxDwv/jqwdJJZVHDt6MepHGJ
   QMattY31J7bAU27APUgpgKQwLleGdOhWj4u/oYE9A1VGMtQAvmvGLxHwc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="248538209"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="248538209"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:20:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="568999001"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:20:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIT1F-003PAX-4u;
        Fri, 11 Feb 2022 12:19:13 +0200
Date:   Fri, 11 Feb 2022 12:19:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konstantin Aladyshev <aladyshev22@gmail.com>,
        Oskar Senft <osk@google.com>, openbmc@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_aspeed_vuart: add PORT_ASPEED_VUART port
 type
Message-ID: <YgY4IODZlKTG7yzn@smile.fi.intel.com>
References: <20220211004203.14915-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211004203.14915-1-zev@bewilderbeest.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 04:42:03PM -0800, Zev Weiss wrote:
> Commit 54da3e381c2b ("serial: 8250_aspeed_vuart: use UPF_IOREMAP to
> set up register mapping") fixed a bug that had, as a side-effect,
> prevented the 8250_aspeed_vuart driver from enabling the VUART's
> FIFOs.  However, fixing that (and hence enabling the FIFOs) has in
> turn revealed what appears to be a hardware bug in the ASPEED VUART in
> which the host-side THRE bit doesn't get if the BMC-side receive FIFO
> trigger level is set to anything but one byte.  This causes problems
> for polled-mode writes from the host -- for example, Linux kernel
> console writes proceed at a glacial pace (less than 100 bytes per
> second) because the write path waits for a 10ms timeout to expire
> after every character instead of being able to continue on to the next
> character upon seeing THRE asserted.  (GRUB behaves similarly.)
> 
> As a workaround, introduce a new port type for the ASPEED VUART that's
> identical to PORT_16550A as it had previously been using, but with
> UART_FCR_R_TRIG_00 instead to set the receive FIFO trigger level to
> one byte, which (experimentally) seems to avoid the problematic THRE
> behavior.

...

> +	[PORT_ASPEED_VUART] = {
> +		.name		= "ASPEED VUART",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
> +		.rxtrig_bytes	= {1, 4, 8, 14},
> +		.flags		= UART_CAP_FIFO,
> +	},

This is quite similar to AR7 type. Can that be (re-)used?

-- 
With Best Regards,
Andy Shevchenko


