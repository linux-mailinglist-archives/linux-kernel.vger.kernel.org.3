Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1925A5F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 11:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiH3J1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiH3J0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:26:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE5CA99C4;
        Tue, 30 Aug 2022 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661851608; x=1693387608;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=unlic4/lYX6T/gxK2b8kUDtNMgSGMfP8eMU0jAigMdY=;
  b=GwSpLQjg+w7MFlxboVm2pzmtFL1/hTDlCVPsZKLvkL1kPyf1i8yA6prG
   MBW1mnJc4KdPO2rhoVM/j8zEltB1Qu8WBRiPFhPGq0Jih3GOQiPZiNXKn
   G5/Jzr2MZkdWvH4yjo69enjaqsh/fUoVLnLBHEmZassty42G6nQPgzH8q
   xJDFds81PMgkUuZjnTDXBpXZpMYsCUZtVHLbb8BK2JpGdgnHAqA6deYOO
   HBgfyRiHggi8CyESek+nQ7w6Uf5Mwr5dO8PVFd5l9Tu5ZX4Sb2+xLLFpc
   pIanWzjKDAQszDbPwLXqZdGPDXVVKD687Kei46iiDaf3Q5WS/q8cX6+bP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275530104"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="275530104"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:26:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672778415"
Received: from arnesgom-mobl.ger.corp.intel.com ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 02:26:30 -0700
Date:   Tue, 30 Aug 2022 12:26:29 +0300 (EEST)
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
In-Reply-To: <Yw3Pw9kwDDKXuqC+@kroah.com>
Message-ID: <58d6748-ebd-e637-c1b2-b8e469e6d86d@linux.intel.com>
References: <20220830072956.3630-1-ilpo.jarvinen@linux.intel.com> <20220830072956.3630-5-ilpo.jarvinen@linux.intel.com> <Yw3Pw9kwDDKXuqC+@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1331296277-1661851599=:1864"
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

--8323329-1331296277-1661851599=:1864
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Tue, 30 Aug 2022, Greg Kroah-Hartman wrote:

> On Tue, Aug 30, 2022 at 10:29:56AM +0300, Ilpo Järvinen wrote:
> > -static int serial_rs485_from_user(struct serial_rs485 *rs485,
> > +static int serial_rs485_from_user(struct kserial_rs485 *rs485,
> >  				  const struct serial_rs485 __user *rs485_user)
> >  {
> > -	if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
> > +	struct serial_rs485 rs485_uapi;
> > +
> > +	if (copy_from_user(&rs485_uapi, rs485_user, sizeof(*rs485)))
> >  		return -EFAULT;
> >  
> > +	*rs485 = *((struct kserial_rs485 *)&rs485_uapi);
> 
> Ah, you are mapping this on top of the existing structure, so there was
> no padding in the original one, why say that?

While I'm not exactly sure what you tried to say with this, I'll try to 
answer regardless.

It's the opposite, there's padding in rs485_user, and therefore also in 
rs485_uapi. Struct serial_rs485 has padding and is part of uapi so it 
cannot be changed to remove the extra padding.

I cannot directly copy_from_user into *rs485 because it lacks the padding. 
Thus, the immediate rs485_uapi and then assign to rs485.

> > +/*
> > + * Compile-time asserts for struct kserial_rs485 and struct serial_rs485 equality
> > + * (except padding).
> 
> This does not take into account any padding, in fact it's the opposite
> as all of this:

?? I said: "(except padding)" which I thought implies that padding is 
intentionally excluded (it doesn't exist in kserial_rs485).

> > + */
> > +static_assert(offsetof(struct kserial_rs485, flags) ==
> > +	      offsetof(struct serial_rs485, flags));
> > +static_assert(offsetof(struct kserial_rs485, delay_rts_before_send) ==
> > +	      offsetof(struct serial_rs485, delay_rts_before_send));
> > +static_assert(offsetof(struct kserial_rs485, delay_rts_after_send) ==
> > +	      offsetof(struct serial_rs485, delay_rts_after_send));
> > +static_assert(offsetof(struct kserial_rs485, addr_recv) ==
> > +	      offsetof(struct serial_rs485, addr_recv));
> > +static_assert(offsetof(struct kserial_rs485, addr_dest) ==
> > +	      offsetof(struct serial_rs485, addr_dest));
> > +static_assert(sizeof(struct kserial_rs485) <= sizeof(struct serial_rs485));
> 
> Is there to ensure that the offsets are exactly the same, no padding
> involved anywhere.

That's because for kernel padding "doesn't matter", it doesn't want it,
it would be just wasted space. After this series, padding is used only for 
uapi, no longer for the in-kernel structs.

> So I don't understand the problem you are trying to solve here,

struct serial_rs485 has padding that is ~16B long currently. serial_rs485 
is currently used for a few things:
- Keep track of rs485 state (per port)
- Record what rs485 options the port supports (per port)
- Record rs485 options a driver supports (per driver with rs485 support)
- Exchange rs485 config/state information with userspace

Only the last of those requires the padding (because it has been part of 
uapi since day 1). With kserial_rs485, the padding can eliminated for the 
first 3 cases.

If you feel ~32B per uart_port too little to be useful (and a little 
more per driver), I can just drop this patch.

-- 
 i.

--8323329-1331296277-1661851599=:1864--
