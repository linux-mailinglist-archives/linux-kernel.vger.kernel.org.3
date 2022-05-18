Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F8452BB16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiERMZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiERMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:25:15 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC518FF24;
        Wed, 18 May 2022 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652876714; x=1684412714;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S/LRXJejZvAPg3mhWE1mMw8GrU9PbO2g/1at3Bi1V74=;
  b=SrbF8KMxZXJNqxQjPTWAL0MqiezjrSDO7w7xbVPnKc/T4ebzjvE3Gulu
   DFWDpnQfYQf0KTmPVAbmU4ROrgpD8yy2rmyVLow++k/iVv2DOy5Ii82/C
   ig/wJp8mXWUmDGpoluwwI6MG62iXdHe490SukGPG6Jes2xposc+9VpAaI
   zNiycU7v4ng1Dp+Q6KHJb1ykz2lqC0SzPtcMqkynYC1d2koTq/63HWoYw
   2WF1qOg8it+ukLxoCjaTmKkW5Dyi66DxVdpiIwGpwvIog45pVoOCPHQAb
   +Z5ZxgcVM7eKgBLXG4xIJ9eiIsWepiTjug6P572fw0ZbYCm5EQvnT5hNu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271775335"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271775335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 05:25:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="597763855"
Received: from lgomesba-mobl.ger.corp.intel.com ([10.252.38.97])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 05:25:09 -0700
Date:   Wed, 18 May 2022 15:25:07 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Sean Anderson <sean.anderson@seco.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] serial: uartline: Fix BRKINT clearing
In-Reply-To: <CAKfKVtFO5z68JwFtGDoHAVVfwXvNnT0B_dGZutCLyu6Vo8tXOQ@mail.gmail.com>
Message-ID: <3c5532e-c8f1-791d-6c58-ccd1c426432@linux.intel.com>
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com> <20220517110737.37148-2-ilpo.jarvinen@linux.intel.com> <CAKfKVtFO5z68JwFtGDoHAVVfwXvNnT0B_dGZutCLyu6Vo8tXOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-733060916-1652876712=:1539"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-733060916-1652876712=:1539
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 May 2022, Shubhrajyoti Datta wrote:

> On Tue, May 17, 2022 at 5:58 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > BRKINT is within c_iflag rather than c_cflag.
> Nit typo in the subject line.

Indeed, good catch. Even after you pointed it out, it was still hard to 
spot what was wrong with it.

Thanks.

-- 
 i.

> > Cc: Sean Anderson <sean.anderson@seco.com>
> > Fixes: ea017f5853e9 (tty: serial: uartlite: Prevent changing fixed parameters)
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/tty/serial/uartlite.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> > index 007db67292a2..880e2afbb97b 100644
> > --- a/drivers/tty/serial/uartlite.c
> > +++ b/drivers/tty/serial/uartlite.c
> > @@ -321,7 +321,8 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
> >         struct uartlite_data *pdata = port->private_data;
> >
> >         /* Set termios to what the hardware supports */
> > -       termios->c_cflag &= ~(BRKINT | CSTOPB | PARENB | PARODD | CSIZE);
> > +       termios->c_iflag &= ~BRKINT;
> > +       termios->c_cflag &= ~(CSTOPB | PARENB | PARODD | CSIZE);
> >         termios->c_cflag |= pdata->cflags & (PARENB | PARODD | CSIZE);
> >         tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
> >
> > --
> > 2.30.2
> >
> 

--8323329-733060916-1652876712=:1539--
