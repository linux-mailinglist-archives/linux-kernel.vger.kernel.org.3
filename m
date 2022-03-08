Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D04D229B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350243AbiCHUbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbiCHUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:31:15 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C09B50E1D;
        Tue,  8 Mar 2022 12:30:17 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CA940100D9423;
        Tue,  8 Mar 2022 21:30:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AA23147A006; Tue,  8 Mar 2022 21:30:14 +0100 (CET)
Date:   Tue, 8 Mar 2022 21:30:14 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
Message-ID: <20220308203014.GA11096@wunner.de>
References: <20220306184857.GA19394@wunner.de>
 <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
 <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
 <20220307191854.GA27748@wunner.de>
 <YiZfdlw0A75cojCx@smile.fi.intel.com>
 <6931d6ad-7520-b585-a8ba-35349e730bb@linux.intel.com>
 <20220308122220.GA24694@wunner.de>
 <d9aabfe-1179-67c2-98d1-f36e7e698f33@linux.intel.com>
 <20220308145042.GA20520@wunner.de>
 <CAHp75Vfd-bi3s=JnNTyov4C7prNhwuWHWsUC6n9pM_E+d4picg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfd-bi3s=JnNTyov4C7prNhwuWHWsUC6n9pM_E+d4picg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 04:53:56PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 8, 2022 at 4:50 PM Lukas Wunner <lukas@wunner.de> wrote:
> > Of course, if hardware-assisted DE assertion requires a particular pinmux
> > state, we could double-check whether that pinmux state is set.
> 
> I'm wondering how to achieve this.

On DT platforms, the devicetree specifies the pin controller settings
which need to be configured for a device to be usable, e.g.:

  pinctrl-names = "default";
  pinctrl-0 = <...>;

Before a driver is bound to the device, really_probe() in drivers/base/dd.c
calls pinctrl_bind_pins() which configures the pin controller accordingly.
In other words, the OS is fully in charge of configuring the pinmux.

I'm not sure how this is done on ACPI platforms.  If the pinmux is
exclusively under the control of the platform firmware and the OS has
no way of getting or setting the pinmux configuration, then that would
be a competitive disadvantage vis-à-vis DT platforms which should really
be addressed.  However I notice there are various drivers for Intel
chipsets in drivers/pinctrl/intel/, so surely there's a way to let the
OS handle pinmux settings?

Thanks,

Lukas
