Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D5557FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbiFWQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiFWQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:32:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D49473AC;
        Thu, 23 Jun 2022 09:32:43 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="261202126"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="261202126"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:32:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="834712996"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 09:32:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1o4Pky-000tDG-6n;
        Thu, 23 Jun 2022 19:32:36 +0300
Date:   Thu, 23 Jun 2022 19:32:35 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if
 supported
Message-ID: <YrSVozxvPZtJdQL5@smile.fi.intel.com>
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de>
 <20220622154659.8710-2-LinoSanfilippo@gmx.de>
 <YrNLtg+BZlwKsBbF@smile.fi.intel.com>
 <2dda5707-6f13-6d33-863d-a88b89e88a88@gmx.de>
 <CAHp75Vd_ix=bJs9k6bYM8S+3f_Pw7Tvs9DhPcZxu1=33T=mQ7A@mail.gmail.com>
 <52ea773c-b5b0-fc4d-9b85-022676778af7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ea773c-b5b0-fc4d-9b85-022676778af7@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 06:08:56PM +0200, Lino Sanfilippo wrote:
> On 23.06.22 at 11:45, Andy Shevchenko wrote:
> > On Thu, Jun 23, 2022 at 4:00 AM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
> >> On 22.06.22 at 19:04, Andy Shevchenko wrote:
> >>> On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
> >>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>>>
> >>>> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> >>>> termination is supported by the driver.
> >>>
> >>> I'm not sure I got the usefulness of this change.
> >>> We request GPIO line as optional, so if one is defined it in the DT/ACPI, then
> >>> they probably want to (opportunistically) have it>
> >>>
> >>> With your change it's possible to have a DTS where GPIO line defined in a
> >>> broken way and user won't ever know about it, if they are using platforms
> >>> without termination support.
> >>
> >> This behavior is not introduced with this patch, also in the current code the driver
> >> wont inform the user if it does not make use erroneous defined termination GPIO.
> >
> > It does. If a previously stale GPIO resource may have deferred a probe
> > and hence one may debug why the driver is not working, after this
> > change one may put a stale GPIO resource into DT/ACPI and have nothing
> > in the result. Meaning the change relaxes validation which I consider
> > is not good.
> >
> 
> Ok I see the point. So what about changing it to:

You mean adding below after the existing code in the module?

> 	if (port->rs485_term_gpio &&
> 	    !(port->rs485_supported->flags & SER_RS485_TERMINATE_BUS)) {
> 		dev_warn(port->dev,
> 			"%s (%d): RS485 termination gpio not supported by driver\n",
> 			port->name, port->line);
> 		devm_gpiod_put(dev, port->rs485_term_gpio);
> 		port->rs485_term_gpio = NULL;
> 	}
> 
> This would also be consistent to the warnings we print in uart_sanitize_serial_rs485() for invalid
> RS485 settings.

Probably it's okay, but I dunno we have much on this to gain. Users may start
complaining of this (harmless) warning. I leave it to others to comment.

-- 
With Best Regards,
Andy Shevchenko


