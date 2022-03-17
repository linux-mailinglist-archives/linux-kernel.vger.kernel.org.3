Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE224DC194
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiCQIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiCQIom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:44:42 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBD96813;
        Thu, 17 Mar 2022 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647506601; x=1679042601;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fk6weti58MZKAxtUajcq3xIVBK6Sp4rBWIwlnsIXVuc=;
  b=dPyzvwcEjSWW3LaJ/HgybVPbph+eiGvqtNrJgdtQamnDA/pZz3YZK/81
   ZVwnKKEmK8M8eY3o7QpLva7aee3FeqrCjn92tuPHr6byDUSguO5vlCWqE
   I4ZwkK/PzGTc5lCTCPQpJ8mowtEeM8v5zpcfXDQrfAq9qKdf/CNca2QIt
   jZmN/afZGQ5D24oyjvIKoco90ns61/j1wNsXKzovN/nzj2x97ROyb9bwr
   W2HI6GsrPwd5jO+RBU+Ks3WHNF0UezxPL7Zj83jHvv8uo2g0ldKYdVFLv
   bf93L2+6VVKz/sZV4fq19lF80N1z6yibEM/IEOcfJBaUx0Mvx2Iy+GhQu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317535538"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="317535538"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:43:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557840005"
Received: from msivosuo-mobl1.ger.corp.intel.com ([10.252.54.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:43:14 -0700
Date:   Thu, 17 Mar 2022 10:43:11 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Wander Lairson Costa <wander@redhat.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, rostedt@goodmis.org,
        senozhatsky@chromium.org, andre.goddard@gmail.com,
        sudipm.mukherjee@gmail.com, andy.shevchenko@gmail.com,
        David.Laight@aculab.com, jonathanh@nvidia.com, phil@raspberrypi.com
Subject: Re: [PATCH v4 5/5] serial/8250: Only use fifo after the port is
 initialized in console_write
In-Reply-To: <20220316143646.13301-6-wander@redhat.com>
Message-ID: <2f3d386-b82a-9ae1-eaba-f2123b1346f8@linux.intel.com>
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-6-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022, Wander Lairson Costa wrote:

> The serial driver set the value of uart_8250_port.fcr in the function
> serial8250_config_port, but only writes the value to the controller
> register later in the initalization code.
> 
> That opens a small window in which is not safe to use the fifo for
> console write.
> 
> Make sure the port is initialized correctly before reading the FCR
> cached value.
> 
> Unfortunately, I lost track of who originally reported the issue. If
> s/he is reading this, please speak up so I can give you the due credit.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 4acf620be241..7e2227161555 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3416,6 +3416,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  		!(up->capabilities & UART_CAP_MINI) &&
>  		up->tx_loadsz > 1 &&
>  		(up->fcr & UART_FCR_ENABLE_FIFO) &&
> +		test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
>  		/*
>  		 * After we put a data in the fifo, the controller will send
>  		 * it regardless of the CTS state. Therefore, only use fifo

So it looks like 2-5 just contain your development history and should all 
be merged to 1/5 (perhaps with Co-developed-by: tags where appropriate).

And please don't just merge them "silently" there w/o describing in the 
message _why_ you ended up doing the things the way you did in the end.
The messages you've written for patches 2-5 will serve you as great source 
material (with small mods, obviously).


-- 
 i.

