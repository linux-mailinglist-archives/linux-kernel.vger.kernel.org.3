Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7255F5AD8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiIER5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIER5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED63FA18;
        Mon,  5 Sep 2022 10:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E8561454;
        Mon,  5 Sep 2022 17:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA8CC433D7;
        Mon,  5 Sep 2022 17:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662400648;
        bh=jqNKDLC/PXJE+UoPBPoIoMdMLlWH+aYP+LxAm3vOm5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0CeVAtrx5xVylj0Q5omR37zCgiYccLxm3fUHuOt7j6AG2JFLoH3gl9lQnR/djDey
         rmc7lpNYRHqYM06v2MOk1iU7L8vYWkzPOpf8aqGJXf/mnmyYKjhBr5OBfqXcNnuMZQ
         9O4dPHeMltYjsYhJJLfs2ko6S1lwdDk+IIZgX150=
Date:   Mon, 5 Sep 2022 19:57:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>, stable-commits@vger.kernel.org,
        johan+linaro@kernel.org, Felipe Balbi <balbi@kernel.org>
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <YxY4hbjs0Y0877Ns@kroah.com>
References: <20220905125309.1037700-1-sashal@kernel.org>
 <YxXyd5H9TLWKUbWy@hovoldconsulting.com>
 <YxXz7LBh5Y4DSd4W@sashalap>
 <YxX15QkMDV+0amk8@hovoldconsulting.com>
 <YxX29eiH0qyyRk9x@sashalap>
 <YxX4QT6eeRiatmX+@hovoldconsulting.com>
 <YxX7R/EAynZC/iGr@sashalap>
 <YxYO+u0rAg029yNl@hovoldconsulting.com>
 <YxYrS3z/nYFYzoTh@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxYrS3z/nYFYzoTh@sashalap>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 01:00:59PM -0400, Sasha Levin wrote:
> On Mon, Sep 05, 2022 at 05:00:10PM +0200, Johan Hovold wrote:
> > On Mon, Sep 05, 2022 at 09:36:07AM -0400, Sasha Levin wrote:
> > > On Mon, Sep 05, 2022 at 03:23:13PM +0200, Johan Hovold wrote:
> > > >On Mon, Sep 05, 2022 at 09:17:41AM -0400, Sasha Levin wrote:
> > > >> On Mon, Sep 05, 2022 at 03:13:09PM +0200, Johan Hovold wrote:
> > > >> >On Mon, Sep 05, 2022 at 09:04:44AM -0400, Sasha Levin wrote:
> > > >> >> On Mon, Sep 05, 2022 at 02:58:31PM +0200, Johan Hovold wrote:
> > > >> >> >On Mon, Sep 05, 2022 at 08:53:09AM -0400, Sasha Levin wrote:
> > > >> >> >>     Fixes: 6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")
> > > >> >> >
> > > >> >> >This commit doesn't exist in 5.19 (and earlier trees), shouldn't your
> > > >> >> >scripts check for that?
> > > >> >>
> > > >> >> They do - it was backported to 5.19.
> > > >> >
> > > >> >What?! Why on earth would 6895ea55c385 ("usb: dwc3: qcom: Configure
> > > >> >wakeup interrupts during suspend") be backported to stable?
> > > >> >
> > > >> >Please drop that patch instead. It's essentially a new feature and is in
> > > >> >any case in no way stable material.
> > > >>
> > > >> Right, it was picked up as a dependency of a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> > > >
> > > >That's wrong too, it's not a dependency for that fix.
> > > 
> > > Right, it may not strictly be one, but we're trying to bring in
> > > dependencies as is without modifying the patch is it's far less error
> > > prone, and keeps future backports easy, as long as backporting those
> > > isn't riskier.
> > 
> > It should only be some context that have changed. Backporting a known
> > broken and non-trivial feature patch for that can't be right. It is
> > certainly riskier.
> > 
> > > In this case, if I were to drop a872ab303d5d I'd also need to drop:
> > > 
> > > a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> > > 6498a96c8c9c ("usb: dwc3: qcom: fix runtime PM wakeup")
> > > 
> > > >So does this mean you're dropping the patches that should not be
> > > >backported?
> > > 
> > > Having said the above, at the end it's your patches and your call, let
> > > me know if you're okay with dropping a872ab303d5d, a872ab303d5d, and
> > 
> > You mentioned a872ab303d5d twice here.
> > 
> > > 6498a96c8c9c from all trees and I'll do that.
> > 
> > This one didn't have a CC stable tag so not sure why you're backporting
> > that one either.
> > 
> > Just pick
> > 
> > 	a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> > 
> > which was the only patch I had marked for stable and fix up the trivial
> > context change (an unrelated function has been added after the new
> > helper in mainline).
> 
> Okay, this should be done. Please take a look at the queue to confirm.

At a quick glance, looks good to me.  I'll go through the other USB cc:
stable patches tomorrow and make sure.

thanks,

greg k-h
