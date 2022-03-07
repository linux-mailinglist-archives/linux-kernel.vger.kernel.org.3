Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6494CFCAE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiCGLZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiCGLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:24:47 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BBA6F48A;
        Mon,  7 Mar 2022 02:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646650464; x=1678186464;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Q1M9gmVJoXmXoHwfvCrAdLAyNtGaDDos2eLy10XrqkI=;
  b=eOJUu2ITLHVaoxeXR2MQmH7/082s4Dr980Tgy3jwj1J2QmOQg73kUDTP
   meHdtE85/DktlCz/VXFIDOIdu2QeKQ7nN3DHrpeFreV5GjiRjYkeLIEej
   KOQ97+tGnZ4O5ODw6Yi5nShvucuKlm1+lCLnYsmbJM1jCTaZuMNLoxPRK
   kldqBXpKLrqZ95nTKbuzNaHeMHpo0GL/EAbTNcMrQ0MsTGDw0V4gGiKTi
   a5qXsaTsGC7uvIeSGfde+K0/wfmTlgT9XBjVUkFlUBb9RynOb8vsqFA1D
   TBtgdH55RfCWOFNg6P5d6kjZAQMTn96BV2cPoWaAoVOrtmmE64xOC0eZL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="241795801"
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="241795801"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:54:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,161,1643702400"; 
   d="scan'208";a="553108858"
Received: from rabl-mobl2.ger.corp.intel.com ([10.252.54.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 02:54:21 -0800
Date:   Mon, 7 Mar 2022 12:54:19 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
In-Reply-To: <20220306184857.GA19394@wunner.de>
Message-ID: <c2607267-798b-d7a0-86f6-4a729c22911f@linux.intel.com>
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com> <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1938830918-1646647611=:1677"
Content-ID: <18e6a7b2-42ef-b14-4f23-6bc8af436835@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

--8323329-1938830918-1646647611=:1677
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <39b2a7d5-d439-f49a-82fd-e1c35ea87776@linux.intel.com>

On Sun, 6 Mar 2022, Lukas Wunner wrote:

> On Wed, Mar 02, 2022 at 11:56:00AM +0200, Ilpo Järvinen wrote:
>
> > +		rs485->flags &= SER_RS485_ENABLED;
> > +
> > +		tcr |= DW_UART_TCR_RS485_EN | DW_UART_TCR_XFER_MODE_DE_OR_RE;
> > +		dw8250_writel_ext(p, DW_UART_DE_EN, 1);
> > +		dw8250_writel_ext(p, DW_UART_RE_EN, 1);
> > +	} else {
> > +		rs485->flags = 0;
> > +
> > +		tcr &= ~DW_UART_TCR_RS485_EN;
> > +		dw8250_writel_ext(p, DW_UART_DE_EN, 0);
> > +		dw8250_writel_ext(p, DW_UART_RE_EN, 0);
> 
> Do the DW_UART_DE_EN and DW_UART_RE_EN registers have any effect at all
> if DW_UART_TCR_RS485_EN is disabled in the TCR register?
> 
> If they don't, there's no need to clear them here.  It would be sufficient
> to set them once (e.g. on probe).

They have no impact when in non-RS485 mode. I just removed them.

> > +	if (device_property_read_bool(p->dev, "snps,de-active-high"))
> > +		tcr |= DW_UART_TCR_DE_POL;
> 
> That device property is a duplication of the existing "rs485-rts-active-low"
> property.  Please use the existing one unless there are devices already
> in the field which use the new property (in which case that should be
> provided as justification in the commit message).
>
> Does the DesignWare UART use dedicated DE and RE pins instead of
> the RTS pin?  That would be quite unusual.
>
> > +	if (device_property_read_bool(p->dev, "snps,re-active-high"))
> > +		tcr |= DW_UART_TCR_RE_POL;
> 
> Heiko Stübner (+cc) posted patches in 2020 to support a separate RE pin
> in addition to a DE pin (which is usually simply the RTS pin):
> 
> https://lore.kernel.org/linux-serial/20200517215610.2131618-4-heiko@sntech.de/
> 
> He called the devicetree property for the pin "rs485-rx-enable",
> so perhaps "rs485-rx-active-low" would be a better name here.

While I believe there exist devices on the field with 
snps,re-active-high set to true, if the default matches to that, the 
impact of the naming mismatch will be near zero (likely zero).

Based on the Rob's earlier comment on the dt patch itself. I had already 
plans on changing these. My thought was to make it like this:
- rs485-de-active-low
- rs485-re-active-high

I don't have strong opinion on the actual names myself (every RS-485 
transceivers I've come across name their pins to DE and RE).

Given that you seemed to consider DE "unusual" despite being reality
with this hw, I don't know whether you still think the meaning of 
rs485-rts-active-low should be overloaded to also mean rs485-de-active-low?
(I think such overloading would be harmless so I'm not exactly opposing
other than noting FW/HW folks might find it odd to misname it to rts.)

What I think is more important though, is that RE would be by default
active low which matches to about every RS485 transceiver expectations.
Given what device_property_read_bool does when the property is missing,
it would make sense to have the property named as -active-high but I
don't know if that breaks some dt naming rule to have them opposites
of each other like that?

> > +	/*
> > +	 * XXX: Though we could interpret the "RTS" timings as Driver Enable
> > +	 * (DE) assertion/de-assertion timings, initially not supporting that.
> > +	 * Ideally we should have timing values for the Driver instead of the
> > +	 * RTS signal.
> > +	 */
> > +	rs485->delay_rts_before_send = 0;
> > +	rs485->delay_rts_after_send = 0;
> 
> I don't quite understand this code comment.

It seemed to be missing one "Enable" word.

Here's my interpretation of it (this comment was written by somebody 
else, perhaps either Heikki or Andy):

Since this HW has dedicated DE/RE in contrast to RTS, it is not specified 
anywhere that delay_rts_* should apply to them as well and that the 
writer of that comment was hoping to have something dedicated to them
rather than repurposing RTS-related fields.

I could of course change this if everything called RTS should be applied 
to DE as well?


-- 
 i.
--8323329-1938830918-1646647611=:1677--
