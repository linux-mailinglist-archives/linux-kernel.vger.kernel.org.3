Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE9450F33D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbiDZICR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242414AbiDZICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:02:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8222A25F;
        Tue, 26 Apr 2022 00:59:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272F0616AD;
        Tue, 26 Apr 2022 07:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A5AC385A4;
        Tue, 26 Apr 2022 07:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650959944;
        bh=gShRDvOyHLQpm/q9JNzUtdsJw3R/dEssZdnu2xtO/YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NV95iVZtGxAlmRSiwgmfRKM9qMsLfIHKYAJdn4uuQStFSF9Jn6EUb+DAMricj3Fqg
         93abCtEzWI1fUnL9OhdZQ9K7CV53w6/8mXM714U5BmGUkeg2Gd8E00uFiNFOhXP5dB
         YdHg21LCYoTLMWDVp9boR0Ea+gudWSJidBwMZmGY=
Date:   Tue, 26 Apr 2022 09:59:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 3/5] tty: Add lookahead param to receive_buf
Message-ID: <YmemRRJugxbsEhWU@kroah.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
 <20220411094859.10894-4-ilpo.jarvinen@linux.intel.com>
 <YmK83NfVqEvGg8DW@kroah.com>
 <d496d544-fe59-5fa7-5d21-ab6ad025fa75@linux.intel.com>
 <769b1be-87c3-e1c1-b1f9-d56a74ff549@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <769b1be-87c3-e1c1-b1f9-d56a74ff549@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:48:40AM +0300, Ilpo Järvinen wrote:
> On Fri, 22 Apr 2022, Ilpo Järvinen wrote:
> 
> > On Fri, 22 Apr 2022, Greg KH wrote:
> > 
> > > >  /* Returns true if c is consumed as flow-control character */
> > > > -static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> > > > +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c,
> > > > +					 bool lookahead_done)
> > > >  {
> > > >  	if (!n_tty_is_char_flow_ctrl(tty, c))
> > > >  		return false;
> > > >  
> > > > +	if (lookahead_done)
> > > > +		return true;
> > > 
> > > Why would this function be called if this option was true?
> > 
> > Agreed, it makes sense to move the check before call (and then I also 
> > don't need to reorganize this function anymore).
> 
> I think I want to renege on this. The reason is that on flow control char, 
> two things must occur:
>   a) it must not be treated as normal char
>   b) if not yet processed, flow control actions need to be taken
> 
> When the check is inside, return value of n_tty_receive_char_flow_ctrl 
> decides a), and b) is kept internal to n_tty_receive_char_flow_ctrl().
> 
> If I more that lookahead_done check into the caller domain, things get 
> IMHO a lot more messy. Effectively, I have three options for the calling 
> domain to chose from:
> 
> 	if (I_IXON(tty)) {
> 		if (!lookahead_done) {
> 			if (n_tty_receive_char_flow_ctrl(tty, c))
> 				return;
> 		} else if (n_tty_is_char_flow_ctrl(tty, c)) {
> 			return;
> 		}
> 	}
> 
> or
> 
> 	if (I_IXON(tty)) {
> 		if ((!lookahead_done && n_tty_receive_char_flow_ctrl(tty, c)) ||
> 		    (lookahead_done && n_tty_is_char_flow_ctrl(tty, c))) {
> 			return;
> 	}
> 
> vs
> 
>         if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c, lookahead_done))
>                 return;
> 
> I heavily prefer that last option.

Ok, then document the heck out of it please.

greg k-h
