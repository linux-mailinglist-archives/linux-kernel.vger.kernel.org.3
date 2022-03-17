Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E10F4DC133
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiCQIbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiCQIbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:31:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2AB18F225;
        Thu, 17 Mar 2022 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647505793; x=1679041793;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YWwbBtyM55w2NVBtFgTtLmpvZGh5He1rqDimrPbgRxM=;
  b=O8/bivU0g3u5M9l4cZGsZSSlZW7CIlt72MmGU7xq4/IJAEkne59HBSFW
   aTe57A+kvR/IxypEaZYnFnMLUwm0tOF7GwvHD4WVDLAempY0pECbLF3PU
   75kfEZ7QKy6wsaCUyA4OFrFE/4JzvDkShMlAPfAJ/TQCSTohv+i9uAl0q
   QDubxHecmcnqzmdTZzJ29L+DRalh0BFfuRkM6yhaUxDiorod9tSO2z2zT
   Qs+XUlp1UOF4P2S1mU5wtWmnvfCqAEiUbFTrHXJmRskxZBjEUJYLlKFbM
   JUpJZjvHuU7ISUmXAB9wdaWJu/ITzhV9U9cjULXgYXNJwnpiXsKoGlp6V
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="281604689"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281604689"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:29:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557835326"
Received: from msivosuo-mobl1.ger.corp.intel.com ([10.252.54.208])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 01:29:46 -0700
Date:   Thu, 17 Mar 2022 10:29:40 +0200 (EET)
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
Subject: Re: [PATCH v4 2/5] serial/8250: Use the cache value of the FCR
 register
In-Reply-To: <20220316143646.13301-3-wander@redhat.com>
Message-ID: <ce8be768-6210-c3b-2131-de302a7757d@linux.intel.com>
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-3-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022, Wander Lairson Costa wrote:

> commit 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
> erroneous tries to read the FCR register content, but this register is
> write-only.
> 
> This patch fixes that by reading the content from the port struct fcr
> field.
> 
> Thanks to Jon Hunter and Jiri Slaby.
> 
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 2abb3de11a48..9f3fa9fe2a4e 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -3410,7 +3410,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
>  
>  	use_fifo = (up->capabilities & UART_CAP_FIFO) &&
>  		port->fifosize > 1 &&
> -		(serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &&
> +		(up->fcr & UART_FCR_ENABLE_FIFO) &&

Didn't you just add this line in 1/5? Please merge this kind of fixes that 
are due to development history of a change to the main patch itself.


-- 
 i.

