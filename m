Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCB4CF4C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 10:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiCGJWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 04:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiCGJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 04:21:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4992E541AA;
        Mon,  7 Mar 2022 01:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646644808; x=1678180808;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wGeDKaASQDCyWy0awRd7jeAVQdDX7gR/VgWstKH88gA=;
  b=bRdsM6TncrMoQcN60/Ak8xegmd7mcKX+Pqa8Kyc82ckHH9l7VZxyrdXi
   Qy+zUsRJuFFR+cK9tox0P3uCJsH7FSOyacQUOynSSMYX8jASZqHYYEgCZ
   9PhlRRdkCXmJ8VTHsPYhUnaDmdcaTDEwgx0BAaXraBCGOnDcrhcSpvt9c
   8FzO/VaNY6odrH64Hv4W0Z+BJXFD381Aa044QfYUSVRYkivDfYpyLTDv6
   vMK3OYXohgaLAONqF7burNZKksnfgphTb4PUVb/m7BONykTYRvRzDI5l4
   GOGN528riicFYlgTCZezfw1SQu07sr2hTZcp1Qn/lza2jNgBSw3yfsYE/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="254536717"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="254536717"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:20:07 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="537042104"
Received: from rabl-mobl2.ger.corp.intel.com ([10.252.54.114])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 01:20:04 -0800
Date:   Mon, 7 Mar 2022 11:19:59 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Lukas Wunner <lukas@wunner.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
In-Reply-To: <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
Message-ID: <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de> <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1881166460-1646644807=:1677"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1881166460-1646644807=:1677
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Mar 2022, Andy Shevchenko wrote:

> On Mon, Mar 7, 2022 at 12:00 AM Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Mar 02, 2022 at 11:56:00AM +0200, Ilpo Järvinen wrote:
> 
> ...
> 
> > Does the DesignWare UART use dedicated DE and RE pins instead of
> > the RTS pin?  That would be quite unusual.
> 
> They are muxed with other UART pins on SoC level, but I don't remember
> by heart which ones. According to the Synopsys datasheet they are
> separate signals. It might be that I'm missing something, since the
> last time I looked was last year.

Unusual or not, there is a pin for both DE and RE. DE is muxed with RTS.

> > > +     d->hw_rs485_support = device_property_read_bool(p->dev, "snps,rs485-interface-en");
> > > +     if (d->hw_rs485_support)
> > > +             p->rs485_config = dw8250_rs485_config;
> > > +
> >
> > You wrote in the commit message that rs485 support is present from
> > version 4.0 onward.  Can't we just check the IP version and enable
> > rs485 support for >= 4.0?  That would seem more appropriate instead
> > of introducing yet another new property.
> 
> AFAIU this is dependent on the IP syntheses. I.o.w. version 4.0+ is a
> prerequisite, but doesn't automatically mean that there is a support.
> Unfortunately there is no way to tell this clearly in the IP
> configuration register.

And the IP synthesis only part of the picture, in general case, it'd
also matter that there's something connected to that RE (i.e.,
an RS485 transceiver).

On the board I'm testing with, I can also turn RS485 on/off from BIOS
which makes the pins (mainly RE) behave differently.

I initially had additional version check here while developing this
patch series but it seemed to not provide any added value due those
other factors that need to be considered.


-- 
 i.

--8323329-1881166460-1646644807=:1677--
