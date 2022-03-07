Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23AB4D07D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiCGTlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiCGTlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:41:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53A13DE2;
        Mon,  7 Mar 2022 11:40:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254217114"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="254217114"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 11:40:22 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="711233447"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 11:40:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nRJCg-00CxVa-V8;
        Mon, 07 Mar 2022 21:39:34 +0200
Date:   Mon, 7 Mar 2022 21:39:34 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
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
Message-ID: <YiZfdlw0A75cojCx@smile.fi.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com>
 <20220306184857.GA19394@wunner.de>
 <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
 <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
 <20220307191854.GA27748@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220307191854.GA27748@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:18:54PM +0100, Lukas Wunner wrote:
> On Mon, Mar 07, 2022 at 11:19:59AM +0200, Ilpo Järvinen wrote:
> > On Mon, 7 Mar 2022, Andy Shevchenko wrote:

...

> That's for DT platforms, but I suppose you've got ACPI.  Not sure
> how it's handled there, the ACPI 6.4 spec contains a "UART Serial Bus
> Connection Resource Descriptor" but nothing on RS-485, so I guess
> the only option is to use regular DT properties in a _DSD object?

Which make me think that this series needs an additional patch to
describe RS485 enumeration for ACPI case (somewhere in
Documentation/firmware-guide/acpi/enumeration.rst IIRC the filename).

...

> > I initially had additional version check here while developing this
> > patch series but it seemed to not provide any added value due those
> > other factors that need to be considered.
> 
> Here's another idea:
> 
> Read TCR register on ->probe.  It's POR value is 0x6 if RS-485 is
> supported by the chip, else 0x0.  (Page 220 of the 4.01a spec says
> UCV register does not exist if additional features are not implemented
> and reading from this register address returns 0, I suppose the same
> applies to TCR if RS-485 is not implemented.)
> 
> Since the driver may change the polarity in the TCR register, be sure
> to write 0x6 to it on ->remove so that you can still correctly detect
> presence of the RS-485 feature after unbind/rebind of the driver.

What to do in the case when DE pin is muxed to RTS and locked in pin control
IP by firmware (no possibility to change the muxing in the OS)?

-- 
With Best Regards,
Andy Shevchenko


