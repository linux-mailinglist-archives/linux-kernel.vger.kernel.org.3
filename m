Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996615AE67C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239712AbiIFLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbiIFLWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:22:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765D272FE0;
        Tue,  6 Sep 2022 04:22:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35A95B815F8;
        Tue,  6 Sep 2022 11:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AB8C433D6;
        Tue,  6 Sep 2022 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662463363;
        bh=LcA5wsbnQSAf4Q35s/BMNpU/e5dnpMXBEsorcDQH50Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asT2PZ9Sz8C18pY+JCsK8zkaNDM6v5Yr6yCEQhtkzzQhvdTJ2FnwRoU4QWqogxRF4
         JNXZ5P7+xcwmsTeelHAVZKYKxyRewATLvH45HnWPpJM6cUJCC781IEaAqVl2z5rBpj
         jKzJEoWjRhelCC2nn/wEXZOKmQciA7SsalUDq9ks=
Date:   Tue, 6 Sep 2022 13:22:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
        johan+linaro@kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Patch "usb: dwc3: qcom: fix peripheral and OTG suspend" has been
 added to the 5.19-stable tree
Message-ID: <YxctgOXYI3FcXv4H@kroah.com>
References: <YxXz7LBh5Y4DSd4W@sashalap>
 <YxX15QkMDV+0amk8@hovoldconsulting.com>
 <YxX29eiH0qyyRk9x@sashalap>
 <YxX4QT6eeRiatmX+@hovoldconsulting.com>
 <YxX7R/EAynZC/iGr@sashalap>
 <YxYO+u0rAg029yNl@hovoldconsulting.com>
 <YxYrS3z/nYFYzoTh@sashalap>
 <YxbfJqPb8x0WjmqR@hovoldconsulting.com>
 <YxbsvTeuodsiMiop@kroah.com>
 <YxbwMJkMuz7PDX1l@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxbwMJkMuz7PDX1l@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 09:01:04AM +0200, Johan Hovold wrote:
> On Tue, Sep 06, 2022 at 08:46:21AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Sep 06, 2022 at 07:48:22AM +0200, Johan Hovold wrote:
> > > On Mon, Sep 05, 2022 at 01:00:59PM -0400, Sasha Levin wrote:
> > > > On Mon, Sep 05, 2022 at 05:00:10PM +0200, Johan Hovold wrote:
> 
> > > > >Just pick
> > > > >
> > > > >	a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> > > > >
> > > > >which was the only patch I had marked for stable and fix up the trivial
> > > > >context change (an unrelated function has been added after the new
> > > > >helper in mainline).
> > > > 
> > > > Okay, this should be done. Please take a look at the queue to confirm.
> > > 
> > > I only checked the pending-5.19 branch, but that one still has 
> > > 
> > > 	360e8230516d ("usb: dwc3: qcom: Add helper functions to enable,disable wake irqs")
> > > 
> > > which should be dropped as well.
> > 
> > Now dropped.  It was needed for a different dwc3 patch, so I dropped
> > that too and will figure them out later today...
> 
> I believe that wasn't a real dependency either and only changed the
> context somewhat.
> 
> The only dwc3 fix that should be needed is the one mentioned above:
> 
> 	a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")
> 
> which is self-contained, even if the context (as in unrelated functions
> following the helper) may need to be adjusted.

Ok, I've tried to apply the dwc3 patches that were tagged for stable
now, and you should have some FAILED emails showing what did not apply.

thanks,

greg k-h
