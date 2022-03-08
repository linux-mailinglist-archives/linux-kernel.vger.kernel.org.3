Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E003A4D1711
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbiCHMS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346785AbiCHMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:18:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D2E43EEC;
        Tue,  8 Mar 2022 04:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646741829; x=1678277829;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=b6XNSvqFP88JTyW8tQlLM0QNG9urVY1LhIdyUhoyfvI=;
  b=b/+eXqMwZYXh1eU7VmbEKEBEXxM6Ag7re75dqleF9JrfdugJnH3GLkuS
   OHJnBQQ8vz6Fo6lF1vnHc9thsRXle1VIAbxX+xqcscCfu7eQkP6v0ifpG
   5Q7m/0s4UN95IjhHqfHnF+mDG9y3olYCwb4S7WIrelcroGzQCTuACzUzd
   y99lJoUpE3ruMC9+6FAM0zYIQphcs7ArFP9WMWNmMuz5lpJL+0uYkRH47
   EVxyCrvzvS30DckL5kV+MwQXs9BbF8eBgPGzIqAZ8YjhnuKWfRmJ335vI
   rHO6Zzewunj0BjzF1Mjg8p2zQ77SmV6EH5WoaoNR1MtNE/qXaiAYiWfEw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254860049"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254860049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:17:08 -0800
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="553597256"
Received: from lpessina-mobl.ger.corp.intel.com ([10.249.37.31])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:17:05 -0800
Date:   Tue, 8 Mar 2022 14:16:56 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Lukas Wunner <lukas@wunner.de>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
In-Reply-To: <YiZfdlw0A75cojCx@smile.fi.intel.com>
Message-ID: <6931d6ad-7520-b585-a8ba-35349e730bb@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de> <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com> <ab82f6a-8d1b-8e89-4ea-77d1a55667d2@linux.intel.com>
 <20220307191854.GA27748@wunner.de> <YiZfdlw0A75cojCx@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-463480829-1646741577=:1613"
Content-ID: <57315a41-d689-1245-85b2-783950081b7@linux.intel.com>
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

--8323329-463480829-1646741577=:1613
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <43444a8-f88-5b0-5b8e-b22c72a4fc9@linux.intel.com>

On Mon, 7 Mar 2022, Andy Shevchenko wrote:

> On Mon, Mar 07, 2022 at 08:18:54PM +0100, Lukas Wunner wrote:
> > On Mon, Mar 07, 2022 at 11:19:59AM +0200, Ilpo Järvinen wrote:
> > > On Mon, 7 Mar 2022, Andy Shevchenko wrote:
> 
> ...
> 
> > That's for DT platforms, but I suppose you've got ACPI.  Not sure
> > how it's handled there, the ACPI 6.4 spec contains a "UART Serial Bus
> > Connection Resource Descriptor" but nothing on RS-485, so I guess
> > the only option is to use regular DT properties in a _DSD object?
> 
> Which make me think that this series needs an additional patch to
> describe RS485 enumeration for ACPI case (somewhere in
> Documentation/firmware-guide/acpi/enumeration.rst IIRC the filename).
> 
> ...
> 
> > > I initially had additional version check here while developing this
> > > patch series but it seemed to not provide any added value due those
> > > other factors that need to be considered.
> > 
> > Here's another idea:
> > 
> > Read TCR register on ->probe.  It's POR value is 0x6 if RS-485 is
> > supported by the chip, else 0x0.  (Page 220 of the 4.01a spec says
> > UCV register does not exist if additional features are not implemented
> > and reading from this register address returns 0, I suppose the same
> > applies to TCR if RS-485 is not implemented.)
> > 
> > Since the driver may change the polarity in the TCR register, be sure
> > to write 0x6 to it on ->remove so that you can still correctly detect
> > presence of the RS-485 feature after unbind/rebind of the driver.
> 
> What to do in the case when DE pin is muxed to RTS and locked in pin control
> IP by firmware (no possibility to change the muxing in the OS)?

The SoC also has a pin to select between RS485 and RS232. With a combo 
transceiver, TCR-based heuristic just runs into the same problems as the 
version-based one did.


-- 
 i.
--8323329-463480829-1646741577=:1613--
