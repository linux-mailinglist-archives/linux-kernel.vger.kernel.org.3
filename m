Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2745A5EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiH3JEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiH3JD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:03:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318F9A345A;
        Tue, 30 Aug 2022 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661850235; x=1693386235;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7avfez+OE22HzdvQ5BgqZ4B5scJdV5v0spp+JaUmwEc=;
  b=chyN4dubi+G/+JTpHHYi68g5Wo/8oHPLfUXc8F00zwYGbEqlaCcrzhyD
   rlmjHFtoL47ge/PZvWVMpiD//ZsHPaNTU8snIFSFki9ShhcgtzadLZ71p
   b12RkFgJoEP+wpUuinRlAfoSXFJn7q7qJQoJekdQrjfuW4tltFbzoDGYg
   aEN0fX0zWUPJWkbKYBlflhdS7c7qG4jAuuY/gVY40XL3HunqVIie6vUz7
   oe2Bq3tzQ/WeUjfnJdJErYn3CFQ2ggPLo3qJbtHcKPma5ae16Ovn5JlpN
   Ic9j3TYMYJ91stn60fZZWfS7MX6wTWALaTGfGENdRbBRzlR73Yx3MgS6S
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381421627"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="381421627"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:03:55 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672769091"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:03:52 -0700
Date:   Tue, 30 Aug 2022 12:03:52 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/4] serial: Rename vars in uart_get_rs485_config()
In-Reply-To: <Yw3QMI0m2X/8aL7z@kroah.com>
Message-ID: <4cb3cc81-23b6-2df4-41b-853e34b78fb8@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com> <20220830072956.3630-2-ilpo.jarvinen@linux.intel.com> <Yw3QMI0m2X/8aL7z@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-111232978-1661850236=:1864"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-111232978-1661850236=:1864
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2022, Greg Kroah-Hartman wrote:

> On Tue, Aug 30, 2022 at 10:29:53AM +0300, Ilpo Järvinen wrote:
> > Make variable names to match uart_set_rs485_config() ones:
> > 	- rs485 -> rs485_user
> > 	- aux -> rs485
> > 
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/tty/serial/serial_core.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> > index 12c87cd201a7..8834414a0b2f 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -1408,16 +1408,16 @@ int uart_rs485_config(struct uart_port *port)
> >  EXPORT_SYMBOL_GPL(uart_rs485_config);
> >  
> >  static int uart_get_rs485_config(struct uart_port *port,
> > -			 struct serial_rs485 __user *rs485)
> > +			 struct serial_rs485 __user *rs485_user)
> >  {
> > +	struct serial_rs485 rs485;
> >  	unsigned long flags;
> > -	struct serial_rs485 aux;
> >  
> >  	spin_lock_irqsave(&port->lock, flags);
> > -	aux = port->rs485;
> > +	rs485 = port->rs485;
> >  	spin_unlock_irqrestore(&port->lock, flags);
> 
> I missed this originally, but why does the lock matter here at all?  You
> are just copying all data out of the structure into an on-stack one, why
> the extra step at all?
> 
> As the structure can change instantly after you release the lock, I
> don't see what the lock is protecting.

At least it cannot return inconsistent serial_rs485 because of the lock. 
Probably not an end of the world if the lock wouldn't be taken and a 
concurrent update of port->rs485 would be allowed to mess up a getted 
serial_rs485 as it seems kind of a high-level/userland concurrency issue 
on the tty. Anyway, that seems to be the only reason really.

It's orthogonal to the patch series though.

-- 
 i.

--8323329-111232978-1661850236=:1864--
