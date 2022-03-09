Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA974D2C88
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiCIJwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiCIJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:52:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0E116EA9E;
        Wed,  9 Mar 2022 01:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646819475; x=1678355475;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Zych22kl5xpT4JSarhqPONWWkJ6kwcSGyYiRLML481U=;
  b=F2rh5V5SF9gF+BZ4vT5+aLefi0e3jJE6QSn7JO2/UeTvkEEhi4xVMAZK
   MT4TsgcJ5HJZ/VIoo5vO/wcwwT4DxD5Y+iMJHO5JQ+dtTfJiebeU/x/6l
   RlMbBSc9lHtFvByLPvKk/pU0+DoPdco1posVDGrK+N1YP8/R1gD7SAXHw
   GZQmHlfeZn2LBDLG2Zf4NcJcM9T5sZwYBQWDr5x4KA8VHSBsDbW6KPGxo
   qYbysFR67cakEWYTbpRjbpTk82uN4liwD9tfHFbMD0HARmkvY44S33x0T
   CbYyyhhRBiQ7ENSeCsJp/1hKl+Yo465eAxt4kz8OUCFzQQvZgelCVWKsa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254876017"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254876017"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:51:14 -0800
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="537943718"
Received: from vladi-laptop.ger.corp.intel.com ([10.252.32.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 01:51:09 -0800
Date:   Wed, 9 Mar 2022 11:51:07 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
In-Reply-To: <20220308203014.GA11096@wunner.de>
Message-ID: <db7b4efb-c4b-4ee5-72fd-d324173977@linux.intel.com>
References: <20220306184857.GA19394@wunner.de> <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com> <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com> <20220307191854.GA27748@wunner.de> <YiZfdlw0A75cojCx@smile.fi.intel.com>
 <6931d6ad-7520-b585-a8ba-35349e730bb@linux.intel.com> <20220308122220.GA24694@wunner.de> <d9aabfe-1179-67c2-98d1-f36e7e698f33@linux.intel.com> <20220308145042.GA20520@wunner.de> <CAHp75Vfd-bi3s=JnNTyov4C7prNhwuWHWsUC6n9pM_E+d4picg@mail.gmail.com>
 <20220308203014.GA11096@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1890276712-1646819472=:1769"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1890276712-1646819472=:1769
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 8 Mar 2022, Lukas Wunner wrote:

> On Tue, Mar 08, 2022 at 04:53:56PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 8, 2022 at 4:50 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > Of course, if hardware-assisted DE assertion requires a particular pinmux
> > > state, we could double-check whether that pinmux state is set.
> > 
> > I'm wondering how to achieve this.
> 
> On DT platforms, the devicetree specifies the pin controller settings
> which need to be configured for a device to be usable, e.g.:
> 
>   pinctrl-names = "default";
>   pinctrl-0 = <...>;
> 
> Before a driver is bound to the device, really_probe() in drivers/base/dd.c
> calls pinctrl_bind_pins() which configures the pin controller accordingly.
> In other words, the OS is fully in charge of configuring the pinmux.
> 
> I'm not sure how this is done on ACPI platforms.  If the pinmux is
> exclusively under the control of the platform firmware and the OS has
> no way of getting or setting the pinmux configuration, then that would
> be a competitive disadvantage vis-à-vis DT platforms which should really
> be addressed.  However I notice there are various drivers for Intel
> chipsets in drivers/pinctrl/intel/, so surely there's a way to let the
> OS handle pinmux settings?

The problem here is that the driver ("we could double-check" in your 
initial suggestion above) doesn't know which pins it should check the 
states for. I don't think any general mapping exists between drivers and 
pins.

Based on what I read, the mapping is a feature not wanted into pinmuxing.
Assuming I understood them correctly, they don't want to do such thing
on kernel side (based on experience with earlier approaches with 
mapping. It probably got too messy/unmaintainable in the end :-)).
So at best, one can only read and control pin mux states but that's about 
as far as pinmuxing in kernel goes (and control could be locked by FW).

Anyway, I've implemented the detection now based on RE_EN non-zero write + 
read + check based on your suggestion (despite still thinking myself it 
has these obvious problems with pinmux & other hw config unrelated dw uart 
itself).


-- 
 i.

--8323329-1890276712-1646819472=:1769--
