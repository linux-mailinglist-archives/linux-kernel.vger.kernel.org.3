Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8656561795
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiF3KU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiF3KUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:20:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA21545064;
        Thu, 30 Jun 2022 03:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656584454; x=1688120454;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4FGMng3U7GLnTku7mVOT+9WivvYzRVqmckgQnASfO9g=;
  b=Ql7uZZoKVL79/biniHg1ixcW1/+HejRnB0gKU2OHD3IKpn/VQZdHNUR3
   MIhLK/xan1qP6/Oj+gyjDTOnEgGrlKJgjCpnLQWzH+6LPgqZnHH9S3P/p
   ADHcaq4N48AhXIVombcCkpdTa1bObojX4AKuCViGUYMhrmc1Pr5q22tAP
   MLtEYflBv26zufbro0h0pSmGilkKqJ0+vEvNTRvzYCRV+bBWThM9djew2
   KMWcmKzErZ4ySMT/5PJ6mbqKMWmRuWydXRZXm/4Uqwd3deXwi4xaSSnjR
   91LYYxVZb590MplsyFOQB9owAJkDvnfEQjL5nxffp6ftVu1d7bxecLrKt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346300209"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="346300209"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:20:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647832875"
Received: from emontau-mobl2.ger.corp.intel.com ([10.249.42.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 03:20:50 -0700
Date:   Thu, 30 Jun 2022 13:20:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] 8250_dwlib: Convert bitops to newer form
In-Reply-To: <CAHp75VcH9O6=Lk06w3Set==zBEFyseCSDN6OUE3n7g4ZnBM4Bg@mail.gmail.com>
Message-ID: <eeba3ce9-c0a1-2363-154a-82b0b4468e3@linux.intel.com>
References: <20220630100536.41329-1-ilpo.jarvinen@linux.intel.com> <CAHp75VcH9O6=Lk06w3Set==zBEFyseCSDN6OUE3n7g4ZnBM4Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-29156649-1656584452=:1605"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-29156649-1656584452=:1605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 30 Jun 2022, Andy Shevchenko wrote:

> On Thu, Jun 30, 2022 at 12:08 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > Instead of open-coding, use BIT(), GENMASK(), and FIELD_GET() helpers.
> 
> FIELD_GET() requires bitfield.h to be included. Is this the case already?

It's there already.

-- 
 i.

> If so,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/tty/serial/8250/8250_dwlib.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> > index da330ef46446..a8bbed74ea70 100644
> > --- a/drivers/tty/serial/8250/8250_dwlib.c
> > +++ b/drivers/tty/serial/8250/8250_dwlib.c
> > @@ -46,21 +46,21 @@
> >  #define DW_UART_LCR_EXT_TRANSMIT_MODE  BIT(3)
> >
> >  /* Component Parameter Register bits */
> > -#define DW_UART_CPR_ABP_DATA_WIDTH     (3 << 0)
> > -#define DW_UART_CPR_AFCE_MODE          (1 << 4)
> > -#define DW_UART_CPR_THRE_MODE          (1 << 5)
> > -#define DW_UART_CPR_SIR_MODE           (1 << 6)
> > -#define DW_UART_CPR_SIR_LP_MODE                (1 << 7)
> > -#define DW_UART_CPR_ADDITIONAL_FEATURES        (1 << 8)
> > -#define DW_UART_CPR_FIFO_ACCESS                (1 << 9)
> > -#define DW_UART_CPR_FIFO_STAT          (1 << 10)
> > -#define DW_UART_CPR_SHADOW             (1 << 11)
> > -#define DW_UART_CPR_ENCODED_PARMS      (1 << 12)
> > -#define DW_UART_CPR_DMA_EXTRA          (1 << 13)
> > -#define DW_UART_CPR_FIFO_MODE          (0xff << 16)
> > +#define DW_UART_CPR_ABP_DATA_WIDTH     GENMASK(1, 0)
> > +#define DW_UART_CPR_AFCE_MODE          BIT(4)
> > +#define DW_UART_CPR_THRE_MODE          BIT(5)
> > +#define DW_UART_CPR_SIR_MODE           BIT(6)
> > +#define DW_UART_CPR_SIR_LP_MODE                BIT(7)
> > +#define DW_UART_CPR_ADDITIONAL_FEATURES        BIT(8)
> > +#define DW_UART_CPR_FIFO_ACCESS                BIT(9)
> > +#define DW_UART_CPR_FIFO_STAT          BIT(10)
> > +#define DW_UART_CPR_SHADOW             BIT(11)
> > +#define DW_UART_CPR_ENCODED_PARMS      BIT(12)
> > +#define DW_UART_CPR_DMA_EXTRA          BIT(13)
> > +#define DW_UART_CPR_FIFO_MODE          GENMASK(23, 16)
> >
> >  /* Helper for FIFO size calculation */
> > -#define DW_UART_CPR_FIFO_SIZE(a)       (((a >> 16) & 0xff) * 16)
> > +#define DW_UART_CPR_FIFO_SIZE(a)       (FIELD_GET(DW_UART_CPR_FIFO_MODE, (a)) * 16)
> >
> >  /*
> >   * divisor = div(I) + div(F)
> > --
> > 2.30.2
> >
> 
> 
> 

--8323329-29156649-1656584452=:1605--
