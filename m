Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7315A5F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiH3Jgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiH3JgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:36:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6216BE9905;
        Tue, 30 Aug 2022 02:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CA07B818C4;
        Tue, 30 Aug 2022 09:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2FC433D7;
        Tue, 30 Aug 2022 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661852034;
        bh=RtTBoBmIFnTDD6x72hBHnoVvBe1GpBrLQzVhYk4MgBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rCWxQH8FcNcRmBJklBuDvw/CdqD37yq141CRU2jMGMPcbFVnqwXbg6PHxDMp2T0dq
         mKGSYSwq/CtUnQeBi0xTaTxIu4lvHNvglmfL0MzJUnJa8yep5+8StTjKTxYdLVp/42
         z01SenxMYwyJSwzbD9ylNbvgOVTM5g4d8DrsUnNM=
Date:   Tue, 30 Aug 2022 11:33:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
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
Message-ID: <Yw3Zf5cwJIlBAV2z@kroah.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com>
 <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com>
 <Yw3Pw9kwDDKXuqC+@kroah.com>
 <58d6748-ebd-e637-c1b2-b8e469e6d86d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58d6748-ebd-e637-c1b2-b8e469e6d86d@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:26:29PM +0300, Ilpo Järvinen wrote:
> On Tue, 30 Aug 2022, Greg Kroah-Hartman wrote:
> 
> > On Tue, Aug 30, 2022 at 10:29:56AM +0300, Ilpo Järvinen wrote:
> > > -static int serial_rs485_from_user(struct serial_rs485 *rs485,
> > > +static int serial_rs485_from_user(struct kserial_rs485 *rs485,
> > >  				  const struct serial_rs485 __user *rs485_user)
> > >  {
> > > -	if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
> > > +	struct serial_rs485 rs485_uapi;
> > > +
> > > +	if (copy_from_user(&rs485_uapi, rs485_user, sizeof(*rs485)))
> > >  		return -EFAULT;
> > >  
> > > +	*rs485 = *((struct kserial_rs485 *)&rs485_uapi);
> > 
> > Ah, you are mapping this on top of the existing structure, so there was
> > no padding in the original one, why say that?
> 
> While I'm not exactly sure what you tried to say with this, I'll try to 
> answer regardless.
> 
> It's the opposite, there's padding in rs485_user, and therefore also in 
> rs485_uapi. Struct serial_rs485 has padding and is part of uapi so it 
> cannot be changed to remove the extra padding.
> 
> I cannot directly copy_from_user into *rs485 because it lacks the padding. 
> Thus, the immediate rs485_uapi and then assign to rs485.

Padding could be in the middle of the structure, it's not obvious that
it is not there.  You are just trying to drop the trailing "unused
space", while all of the fields are identical otherwise.

So be specific about that, as padding is often in the middle of a
structure.

> > > +/*
> > > + * Compile-time asserts for struct kserial_rs485 and struct serial_rs485 equality
> > > + * (except padding).
> > 
> > This does not take into account any padding, in fact it's the opposite
> > as all of this:
> 
> ?? I said: "(except padding)" which I thought implies that padding is 
> intentionally excluded (it doesn't exist in kserial_rs485).
> 
> > > + */
> > > +static_assert(offsetof(struct kserial_rs485, flags) ==
> > > +	      offsetof(struct serial_rs485, flags));
> > > +static_assert(offsetof(struct kserial_rs485, delay_rts_before_send) ==
> > > +	      offsetof(struct serial_rs485, delay_rts_before_send));
> > > +static_assert(offsetof(struct kserial_rs485, delay_rts_after_send) ==
> > > +	      offsetof(struct serial_rs485, delay_rts_after_send));
> > > +static_assert(offsetof(struct kserial_rs485, addr_recv) ==
> > > +	      offsetof(struct serial_rs485, addr_recv));
> > > +static_assert(offsetof(struct kserial_rs485, addr_dest) ==
> > > +	      offsetof(struct serial_rs485, addr_dest));
> > > +static_assert(sizeof(struct kserial_rs485) <= sizeof(struct serial_rs485));
> > 
> > Is there to ensure that the offsets are exactly the same, no padding
> > involved anywhere.
> 
> That's because for kernel padding "doesn't matter", it doesn't want it,
> it would be just wasted space. After this series, padding is used only for 
> uapi, no longer for the in-kernel structs.

Again, you are talking about padding at the end, not in the middle,
hence my confusion.

> > So I don't understand the problem you are trying to solve here,
> 
> struct serial_rs485 has padding that is ~16B long currently. serial_rs485 
> is currently used for a few things:
> - Keep track of rs485 state (per port)
> - Record what rs485 options the port supports (per port)
> - Record rs485 options a driver supports (per driver with rs485 support)
> - Exchange rs485 config/state information with userspace
> 
> Only the last of those requires the padding (because it has been part of 
> uapi since day 1). With kserial_rs485, the padding can eliminated for the 
> first 3 cases.
> 
> If you feel ~32B per uart_port too little to be useful (and a little 
> more per driver), I can just drop this patch.

I think 32 bytes per serial port is totally lost in the noise and would
not even be able to be measured at all due to how slabs are aligned
(meaning you are not actually saving any memory at all.)

Can you notice any measurable savings on your systems?

And what is the code increase overall with this patch series?  :)

I'm all for making things const, to prevent errors, but that could
probably be done without this type of change, right?

thanks,

greg k-h
