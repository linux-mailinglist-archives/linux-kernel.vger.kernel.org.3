Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370135A5F94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiH3JhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH3JgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:36:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293AEA334;
        Tue, 30 Aug 2022 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661852049; x=1693388049;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BZlFP+2gMdlipVyXYzNcamg3THGOdoHRiZzKamrAIYY=;
  b=jv4SkrtHGqLF3daSd5ScPRGXlLOmFID8C67JL5Dq6R2917xRNKoX/73/
   Zg9aUSPe0w5uaBjttG7HD2aceWPWvOIquszKvLqSIjt/eg2H1NLh9EhRU
   hXhQIf3GjFI0rhDaUe0pF3sYoQMB8h6b0gPOMI8ppLWlaD594+u3vzI+E
   ndXCKKg1sgOzb/CJo2aXAtDsKxXHDjQsLrVwuvbcvGpOlfOny+oqD0VOK
   HLONp+Pyo6gglZl+mNdRZbaS7gMNhcVQGhc/FsxR1kMa92V8xCwY1gDYR
   HTSr5T6xIOzpgWNtTXDEZ/ErOcpqiaV9P8qnujoA/4h2ESNYrNCQbKGVc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282102074"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="282102074"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:34:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="588532455"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:34:01 -0700
Date:   Tue, 30 Aug 2022 12:34:00 +0300 (EEST)
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
In-Reply-To: <Yw3PHg0imhJyb9sf@kroah.com>
Message-ID: <31865b7-22f3-c07b-c934-83b44269eb3@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com> <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com> <Yw3PHg0imhJyb9sf@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-437881220-1661852048=:1864"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-437881220-1661852048=:1864
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2022, Greg Kroah-Hartman wrote:

> On Tue, Aug 30, 2022 at 10:29:56AM +0300, Ilpo Järvinen wrote:
> > The struct serial_rs485 has a .padding field to make uapi updates
> > easier. It wastes space, however. Create struct kserial_rs485 which is
> > a kerner counterpart w/o padding.
> 
> "kernel"?
> 
> And what is the size difference now?

Roughly 16B of padding is eliminated. That saving is then multiplied by 
the times it appears in in-kernel structs (2x per uart_port, 1x per rs485 
supporting driver). As said in my other reply, if you feel it's too 
little gained by eliminating the padding, I can drop this patch, just let 
me know.

> > +/**
> > + * struct kserial_rs485 - kernel-side struct for controlling RS485 settings.
> > + * @flags:			RS485 feature flags
> > + * @delay_rts_before_send:	Delay before send (milliseconds)
> > + * @delay_rts_after_send:	Delay after send (milliseconds)
> > + * @addr_recv:			Receive filter for RS485 addressing mode
> > + *				(used only when %SER_RS485_ADDR_RECV is set).
> > + * @addr_dest:			Destination address for RS485 addressing mode
> > + *				(used only when %SER_RS485_ADDR_DEST is set).
> > + *
> > + * Must match with struct serial_rs485 in include/uapi/linux/serial.h excluding
> > + * the padding.
> 
> Why must this match?

Because serial_rs485_from_user() and serial_rs485_to_user() just copy 
things over from one struct type to another w/o considering the fields 
individually. If that's not acceptable, I could make it copy field by 
field but it didn't feel necessary to allow "real" fields to differ to 
achieve padding elimination...

> And how is that going to be enforced?

With static_assert()s in serial_core.c. I'll add a note about that into 
the comment.

> > + */
> > +struct kserial_rs485 {
> > +	__u32	flags;
> > +	__u32	delay_rts_before_send;
> > +	__u32	delay_rts_after_send;
> > +	struct {
> > +		__u8    addr_recv;
> > +		__u8    addr_dest;
> > +	};
> 
> As this is an in-kernel structure, this should be "u32" and "u8" now.

Right, I'll change those.

-- 
 i.

--8323329-437881220-1661852048=:1864--
