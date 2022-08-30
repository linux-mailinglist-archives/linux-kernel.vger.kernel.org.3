Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C75A6086
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiH3KSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiH3KRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:17:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BD96461;
        Tue, 30 Aug 2022 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661854493; x=1693390493;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=UgNERPcJtkcZ6uHTT9C3QVaF5md5rEDPHJWxiZf1opY=;
  b=kRCtMSmVqJjPds+kQCtNossT5Yhn3Q1yMP5K27Jtt6LeM438zT+efill
   +J+jml1Ytg67KjTC5fLT/IcTktPNu14G3RHFhjC1/DS9AgdlHqmaFdpE9
   3GemL/61l08np71Z/ZhZKRFJlP48mC0xOJf6Goi4ZmVbsweR6LH+wING1
   fAVDvFUnkC9imyE3yYQWdmtmRg01WHvzE3ITQOw/jLB9LVXCOlX9fXJuF
   +v0rhYUF5rJ9YDNuNsjuSzHMMSOlr9UE28qgxtzAzS38HVkBTMRy2yrLA
   2YeZsfYNVhdrZYoTChY6Jbx2GsOlVjO5o1BDBgnS3PSh7nvM//dLmIrYO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="359100278"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="359100278"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:14:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672797149"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 03:14:28 -0700
Date:   Tue, 30 Aug 2022 13:14:27 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v2 4/4] serial: Add kserial_rs485 to avoid wasted space
 due to .padding
In-Reply-To: <Yw3Zf5cwJIlBAV2z@kroah.com>
Message-ID: <55e7b5d8-9bf7-4186-fa5d-29e1e1b3a1d3@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com> <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com> <Yw3Pw9kwDDKXuqC+@kroah.com> <58d6748-ebd-e637-c1b2-b8e469e6d86d@linux.intel.com> <Yw3Zf5cwJIlBAV2z@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1914567423-1661852593=:1864"
Content-ID: <e212410-9396-e748-6f82-3fb0839d31@linux.intel.com>
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

--8323329-1914567423-1661852593=:1864
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <1aefe4bc-c222-7b33-216c-7cd023ce365@linux.intel.com>

On Tue, 30 Aug 2022, Greg Kroah-Hartman wrote:

> On Tue, Aug 30, 2022 at 12:26:29PM +0300, Ilpo Järvinen wrote:
> > On Tue, 30 Aug 2022, Greg Kroah-Hartman wrote:

> > > Ah, you are mapping this on top of the existing structure, so there was
> > > no padding in the original one, why say that?
> > 
> > While I'm not exactly sure what you tried to say with this, I'll try to 
> > answer regardless.
> > 
> > It's the opposite, there's padding in rs485_user, and therefore also in 
> > rs485_uapi. Struct serial_rs485 has padding and is part of uapi so it 
> > cannot be changed to remove the extra padding.
> > 
> > I cannot directly copy_from_user into *rs485 because it lacks the padding. 
> > Thus, the immediate rs485_uapi and then assign to rs485.
> 
> Padding could be in the middle of the structure, it's not obvious that
> it is not there.  You are just trying to drop the trailing "unused
> space", while all of the fields are identical otherwise.
> 
> So be specific about that, as padding is often in the middle of a
> structure.

Ah, sorry. I didn't realize there would be such a way to misunderstand
the message because I knew too well where the padding with this particular 
struct is.

> > If you feel ~32B per uart_port too little to be useful (and a little 
> > more per driver), I can just drop this patch.
> 
> I think 32 bytes per serial port is totally lost in the noise and would
> not even be able to be measured at all due to how slabs are aligned
> (meaning you are not actually saving any memory at all.)
>
> Can you notice any measurable savings on your systems?

It's not that straightforward. Many uart_ports are embedded into arrays
like this:

static struct ...[N];

...But then one could again say that, e.g., module alignment eats up all 
potential benefits, etc.

Obviously with big systems and small number of ports, this would never 
matter much so while I believe likely could get some small looking number 
for you I don't feel the effort needed to be anymore justified.

> And what is the code increase overall with this patch series?  :)

The series was mostly shuffling existing code around, the only thing added 
was that those struct copies so probably less than it looked.

> I'm all for making things const, to prevent errors, but that could
> probably be done without this type of change, right?

OK, I'll drop this last patch. For the first three though, there's useful 
stuff in them making some things more cleaner/consistent, I'll sort that 
out.

Thanks for your comments.


-- 
 i.
--8323329-1914567423-1661852593=:1864--
