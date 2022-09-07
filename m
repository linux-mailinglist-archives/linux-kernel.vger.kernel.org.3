Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C595B01BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiIGKTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiIGKRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:17:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FEE558E1;
        Wed,  7 Sep 2022 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662545792; x=1694081792;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=oG/rTyJfL3+KZX6K/6NP9h6bWZE1yxt+UXbMI1HplF8=;
  b=jhtfS5j2BV0RGDmlGTOFlazhJTw/mFu4woiZKan2IdH4E4lbsacvf3kz
   lZqV5CG5k7w03eVxruRAdeJe2HnScOV3/yeacIKhqoLYgwA2dONJWorpR
   s1gDV9IDmITNbBK8kqhLbXv+xoxbUA6PRzELbX7Rq/0y7O03N3KQKm87k
   mE84zkhBIu3UopxTtIPW9hSI4m/RFXLKbFDEDDtCzFHcPGRRs9CZkZgbW
   vCT4J3Ia7vudDNf/hr+ePPBVJlJhNHnEIHRP5fCClRNRdQiexMGtsxtrL
   1d9ZSPnYUkg5JShYRxldA1cvQ+iuK3Nq4FD6tn59q3AKOqCJpalreO9XY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="358550225"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="358550225"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 03:16:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="676121421"
Received: from dmatouse-mobl.ger.corp.intel.com ([10.251.223.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 03:16:24 -0700
Date:   Wed, 7 Sep 2022 13:16:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?ISO-8859-15?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/4] tty: TX helpers
In-Reply-To: <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
Message-ID: <4e9b4471-a6f2-4b16-d830-67d253ae4e6a@linux.intel.com>
References: <20220906104805.23211-1-jslaby@suse.cz> <Yxcvbk281f/vy4vb@hovoldconsulting.com> <dec6d5c4-45b7-f087-95f4-bf1dae9e9d27@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1625185259-1662545792=:1717"
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

--8323329-1625185259-1662545792=:1717
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 7 Sep 2022, Jiri Slaby wrote:

> On 06. 09. 22, 13:30, Johan Hovold wrote:
> > On Tue, Sep 06, 2022 at 12:48:01PM +0200, Jiri Slaby wrote:
> > > This series introduces DEFINE_UART_PORT_TX_HELPER +
> > > DEFINE_UART_PORT_TX_HELPER_LIMITED TX helpers. See PATCH 2/4 for the
> > > details. Comments welcome.
> > > 
> > > Then it switches drivers to use them. First, to
> > > DEFINE_UART_PORT_TX_HELPER() in 3/4 and then
> > > DEFINE_UART_PORT_TX_HELPER_LIMITED() in 4/4.
> > > 
> > > The diffstat of patches 3+4 is as follows:
> > >   26 files changed, 191 insertions(+), 823 deletions(-)
> > > which appears to be nice.
> > 
> > Not really. This is horrid. Quality can't be measured in LoC (only).
> > 
> > The resulting code is unreadable. And for no good reason.
> 
> IMO, it's much more readable than the original ~ 30 various (and buggy -- see
> Ilpo's fixes) copies of this code. Apart from that, it makes further rework
> much easier (I have switch to kfifo in my mind for example).
> 
> > [ And note that you're "saving" something like 20 lines per driver:
> 
> It's not about saving, it's about deduplicating and unifying.
>
> > 	 12 files changed, 84 insertions(+), 349 deletions(-)
> > ]
> > 
> > NAK
> 
> I'd love to come up with something nicer. That would be a function in
> serial-core calling hooks like I had [1] for example. But provided all those
> CPU workarounds/thunks, it'd be quite expensive to call two functions per
> character.
> 
> Or creating a static inline (having ± the macro content) and the hooks as
> parameters and hope for optimizations to eliminate thunks (also suggested in
> the past [1]).
> 
> [1] https://lore.kernel.org/all/20220411105405.9519-1-jslaby@suse.cz/

I second Jiri here.

Saving lines in drivers is not that important compared with all removing 
all the variants of the same thing that have crept there over the years.

I suspect the main reason for the variants is that everybody just used 
other drivers as examples and therefore we've a few "main" variant 
branches depending on which of the drivers was used as an example for the 
other. That is hardly a good enough reason to keep them different and as 
long as each driver keeps its own function for this, it will eventually 
lead to similar differentiation so e.g. a one-time band-aid similarization 
would not help in the long run.

Also, I don't understand why you see it unreadable when the actual code is 
out in the open in that macro. It's formatted much better than e.g. 
read_poll_timeout() if you want an example of something that is hardly 
readable ;-). I agree though there's a learning-curve, albeit small, that 
it actually creates a function but that doesn't seem to me as big of an 
obstacle you seem to think.


-- 
 i.

--8323329-1625185259-1662545792=:1717--
