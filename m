Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33F35AE075
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 09:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiIFHBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 03:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238733AbiIFHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:01:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5865663;
        Tue,  6 Sep 2022 00:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F5761241;
        Tue,  6 Sep 2022 07:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435BEC433D6;
        Tue,  6 Sep 2022 07:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662447662;
        bh=24c4PtJ96+bjkVl4KVBMDzMhG2i1uiFdnLzYkvahTlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdfKbO+mhmN5kLDmx8Dd6OnQgMaSw9MjdgdvM/nsTjzJklr1GHfcyLKHhlBk8pY+E
         N0KbbxzrCEjbgw7g0JWzu6UlhQjH0NRw/YW+NQ2KwcWjrjSq9BXNG3ikdPVJq0xB22
         RZ9qCXlva8Q/mQBuG09ltACtyxxWUWUrGrSgIerZLLlOiePLp7TR9wjOMgKL1cNBa/
         G8CkHNGoO1PVsk67XPTTs7bs0qkgxq2nWu08Rj9+fwUelLaQzHSVfE948QbulmAOai
         UXWqUVXvA+Vc/6xo6nmcx2jcpBLRWfE56KIPxAsDduKn/OzYu/ceEbQDmsuuX0cp9o
         0YzQIrDPxIlSQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oVSa0-0005QE-Tw; Tue, 06 Sep 2022 09:01:05 +0200
Date:   Tue, 6 Sep 2022 09:01:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        johan+linaro@kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <YxbwMJkMuz7PDX1l@hovoldconsulting.com>
References: <YxXyd5H9TLWKUbWy@hovoldconsulting.com>
 <YxXz7LBh5Y4DSd4W@sashalap>
 <YxX15QkMDV+0amk8@hovoldconsulting.com>
 <YxX29eiH0qyyRk9x@sashalap>
 <YxX4QT6eeRiatmX+@hovoldconsulting.com>
 <YxX7R/EAynZC/iGr@sashalap>
 <YxYO+u0rAg029yNl@hovoldconsulting.com>
 <YxYrS3z/nYFYzoTh@sashalap>
 <YxbfJqPb8x0WjmqR@hovoldconsulting.com>
 <YxbsvTeuodsiMiop@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxbsvTeuodsiMiop@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:46:21AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 06, 2022 at 07:48:22AM +0200, Johan Hovold wrote:
> > On Mon, Sep 05, 2022 at 01:00:59PM -0400, Sasha Levin wrote:
> > > On Mon, Sep 05, 2022 at 05:00:10PM +0200, Johan Hovold wrote:

> > > >Just pick
> > > >
> > > >	a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> > > >
> > > >which was the only patch I had marked for stable and fix up the trivial
> > > >context change (an unrelated function has been added after the new
> > > >helper in mainline).
> > > 
> > > Okay, this should be done. Please take a look at the queue to confirm.
> > 
> > I only checked the pending-5.19 branch, but that one still has 
> > 
> > 	360e8230516d ("usb: dwc3: qcom: Add helper functions to enable,disable wake irqs")
> > 
> > which should be dropped as well.
> 
> Now dropped.  It was needed for a different dwc3 patch, so I dropped
> that too and will figure them out later today...

I believe that wasn't a real dependency either and only changed the
context somewhat.

The only dwc3 fix that should be needed is the one mentioned above:

	a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")

which is self-contained, even if the context (as in unrelated functions
following the helper) may need to be adjusted.

Johan
