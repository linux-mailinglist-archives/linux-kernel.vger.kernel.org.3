Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4D4F5E52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiDFMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiDFMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:46:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D375933E5;
        Wed,  6 Apr 2022 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649235053; x=1680771053;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4HsEIEA6lqkchGpdlbP1+HwGf7g8BXb8TpkxJaEOXhQ=;
  b=cP5C/OuWJNLrON7iVg9mpl7M0iI1V3uf8mvOV7vozQ9Z+6QkAOTNflH3
   YyVaHulMjEQqGxNWQ/NaOUpgwSMAmLTT3bm3BPAbOgiSfzY0rmsj3N1H/
   xbtloU+N0VAhFuIvrCiDnkKIm0rENV3CDd994L28N8j98hOq0sko6RsrQ
   egCo/ujOe667gMwBZfkpPNslYSvU61PmfJNBqqloR6KBFBh4L0xNfEAJC
   E408L4NX6u13iFlFsLytyj1s9+pkjHywYHJTknAL3IrXbN0TmGiEFxSaO
   AuBMFtRvy0fuV5l6EYT4Mq4oo4icfLgx6jLQ680SZH3yST0blpsy2xJpR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259823733"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="259823733"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:50:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570418389"
Received: from hott-mobl.ger.corp.intel.com ([10.249.44.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 01:50:50 -0700
Date:   Wed, 6 Apr 2022 11:50:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/2] tty: Implement lookahead to process XON/XOFF
 timely
In-Reply-To: <fce9c28e-a334-3c70-3a6a-8812f11d8fc7@kernel.org>
Message-ID: <cf8d1e81-1811-d66f-21fc-a733bfad198@linux.intel.com>
References: <20220405102437.4842-1-ilpo.jarvinen@linux.intel.com> <20220405102437.4842-3-ilpo.jarvinen@linux.intel.com> <YkxqGDsURPpkDM5W@smile.fi.intel.com> <fce9c28e-a334-3c70-3a6a-8812f11d8fc7@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2114925272-1649235052=:1612"
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

--8323329-2114925272-1649235052=:1612
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 6 Apr 2022, Jiri Slaby wrote:

> On 05. 04. 22, 18:11, Andy Shevchenko wrote:
> > On Tue, Apr 05, 2022 at 01:24:37PM +0300, Ilpo Järvinen wrote:
> > > When tty is not read from, XON/XOFF may get stuck into an
> > > intermediate buffer. As those characters are there to do software
> > > flow-control, it is not very useful. In the case where neither end
> > > reads from ttys, the receiving ends might not be able receive the
> > > XOFF characters and just keep sending more data to the opposite
> > > direction. This problem is almost guaranteed to occur with DMA
> > > which sends data in large chunks.
> > > 
> > > If TTY is slow to process characters, that is, eats less than given
> > > amount in receive_buf, invoke lookahead for the rest of the chars
> > > to process potential XON/XOFF characters.
> > > 
> > > The guards necessary for ensuring the XON/XOFF character are
> > > processed only once were added by the previous patch. All this patch
> > > needs to do on that front is to pass the lookahead count (that can
> > > now be non-zero) into port->client_ops->receive_buf().
> > 
> > ...
> > 
> > > +static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned
> > > char c,
> > > +					 bool lookahead_done)
> > > +{
> > > +	if (!I_IXON(tty))
> > > +		return false;
> > > +
> > > +	if (c == START_CHAR(tty)) {
> > > +		if (!lookahead_done) {
> > > +			start_tty(tty);
> > > +			process_echoes(tty);
> > > +		}
> > > +		return true;
> > > +	}
> > > +	if (c == STOP_CHAR(tty)) {
> > > +		if (!lookahead_done)
> > > +			stop_tty(tty);
> > > +		return true;
> > > +	}
> > > +	return false;
> > > +}
> > 
> > Looking into this I would first make a preparatory patch that splits out
> > current code into something like
> > 
> > static bool __n_tty_receive_char_special_no_lookahead(struct tty_struct
> > *tty, unsigned char c)
> > {
> > 	...current code...
> > }
> > 
> > Then in the patch 1 you add
> > 
> > static bool __n_tty_receive_char_special_lookahead(struct tty_struct *tty,
> > unsigned char c)
> > {
> > 	...
> > }
> > 
> > static bool __n_tty_receive_char_special(struct tty_struct *tty, unsigned
> > char c,
> > 					 bool lookahead_done)
> 
> This should be dubbed better. Maybe n_tty_receive_char_flow_control()?
> 
> And I would place the if (I_IXON(tty)) to the caller. I am a bit lost in this
> pseudo code, so maybe this doesn't make sense in your proposal. I have
> something like in my mind:
> 
> if (I_IXON(tty))
>   return n_tty_receive_char_flow_control();
>
> Historically, these n_tty_receive* function names were a big mess. Don't
> produce more of that by simply prepending only "__".

Ok, I'll see what I can do.

Thanks to both of you for the comments.


-- 
 i.

--8323329-2114925272-1649235052=:1612--
