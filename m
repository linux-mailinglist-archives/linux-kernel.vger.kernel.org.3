Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1CE5065D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349341AbiDSH3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347430AbiDSH3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:29:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD02E6AE;
        Tue, 19 Apr 2022 00:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2AB9DCE12D4;
        Tue, 19 Apr 2022 07:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CEEC385AA;
        Tue, 19 Apr 2022 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650353208;
        bh=hRA97lDn/TuztS0QWmFlWK3AkqN/hp+z501lhGXN5Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhWSPXcbATyY17FmrIe2/UkdrOCSIbRMdfhyOhHsbGJqWBLZ42U9zk8bRA0DU97qY
         hibXOLimtXlAqsdWbHD+20bHCk5QQn0gbcAFMe/oMQal2P1OG2C0XwhnAh8zIn18La
         43jbMtpOKm++SEYp6qma01dPi/mK6SZb1qENNUTM=
Date:   Tue, 19 Apr 2022 09:26:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/20] tty: n_gsm: fix invalid command/response bit check
 for UI/UIH frames
Message-ID: <Yl5kNLyJTPGdO/tY@kroah.com>
References: <AM4PR1001MB1378879B82FF126255EFB099E0F29@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR1001MB1378879B82FF126255EFB099E0F29@AM4PR1001MB1378.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 07:10:43AM +0000, Starke, Daniel wrote:
> > 42:21AM -0700, D. Starke wrote:
> > > From: Daniel Starke <daniel.starke@siemens.com>
> > > 
> > > n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> > > See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> > > The changes from 07.010 to 27.010 are non-functional. Therefore, I 
> > > refer to the newer 27.010 here. Chapter 5.4.3.1 states the CR bit in 
> > > UI and UIH frames shall always be set 1 by the initiator and 0 by the responder.
> > 
> > This has nothing to do with the change you made here.
> > 
> > 
> > > Currently, gsm_queue() has a pre-processor gated (excluded) check 
> > > which treats all frames that conform to the standard as malformed frames.
> > > Remove this optional code to avoid confusion and possible breaking 
> > > changes in case that someone includes it.
> > 
> > Again, nothing to do with the code change.
> 
> Including this code (i.e. with #if 1) will treat every correct UI/UIH frame
> as invalid, because the cr flag is always set to 1 for those frames
> (as mentioned in chapter 5.4.3.1 of the standard). This is obviously wrong.
> 
> > > 
> > > Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> > 
> > This "fixes" nothing :(
> 
> What is the correct way to handle the removal of such dead and obviously
> wrong code?
> 
> > > Cc: stable@vger.kernel.org
> > 
> > How is commenting out unused code a stable backport requirement?
> 
> True, it does not change the behavior but it fixes a commit which is also
> present in the current stable release. I was unsure how to handle this
> case. I will remove the backport remark.
> 
> > > Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> > > ---
> > >  drivers/tty/n_gsm.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> > > 
> > > diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c index 
> > > e9a7d9483c1f..f4ec48c0d6d7 100644
> > > --- a/drivers/tty/n_gsm.c
> > > +++ b/drivers/tty/n_gsm.c
> > > @@ -1896,10 +1896,6 @@ static void gsm_queue(struct gsm_mux *gsm)
> > >  	case UI|PF:
> > >  	case UIH:
> > >  	case UIH|PF:
> > > -#if 0
> > > -		if (cr)
> > > -			goto invalid;
> > > -#endif
> > 
> > All you are doing is cleaning up dead code.  Not a big deal, and not
> > worth all the text above to confuse people :(
> 
> As mentioned above, this is not only dead but also wrong code. I tried to
> elaborate the reason for it being wrong code in the text above.

That's fine, then just submit a patch that says:
	Remove commented out code as it is never used and if anyone
	accidentally turned it on, it would be broken.

We remove dead code like this all the time, it's not a "fix" as nothing
is broken as-is.

thanks,

greg k-h
