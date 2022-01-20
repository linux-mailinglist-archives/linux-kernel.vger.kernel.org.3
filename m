Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5D49518E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376700AbiATPgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:36:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34668 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346547AbiATPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:36:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B3861865;
        Thu, 20 Jan 2022 15:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786C0C340E0;
        Thu, 20 Jan 2022 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642693011;
        bh=kN6hBAfOXKsmu5b/F2NQ/rozz7SmeIlLkEnsjvw8p3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zc+adtQVmKpga2Ff99euSBMyTazpNZFYDNVP1WHuYnvgylPZH2b/bAzj94PQ5gumq
         /dVAGE9P5DrLogbiWELbMhnWIm7EnGc13zSDmtY1TVhotHdafSouBfCOmlml7rZryM
         JTv05HUv/wj4pCCq2Uhi9Eyi22Wd5bvjDxs7TA2s=
Date:   Thu, 20 Jan 2022 16:36:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v20 2/5] driver core: Export device_is_bound()
Message-ID: <YemBkNhvfPukCB6C@kroah.com>
References: <20220119204345.3769662-1-mka@chromium.org>
 <20220119124327.v20.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
 <YekPTh/G1IkvpSiI@infradead.org>
 <YekTFMnXK87MNMh3@kroah.com>
 <Yel+0DrtWm5I9JrL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yel+0DrtWm5I9JrL@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 07:25:04AM -0800, Matthias Kaehlcke wrote:
> On Thu, Jan 20, 2022 at 08:45:24AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 19, 2022 at 11:29:18PM -0800, Christoph Hellwig wrote:
> > > On Wed, Jan 19, 2022 at 12:43:42PM -0800, Matthias Kaehlcke wrote:
> > > > Export device_is_bound() to enable its use by drivers that are
> > > > built as modules.
> > > > 
> > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > 
> > > Didn't Greg clearly NAK this the last few times it came up?
> > 
> > Yes, which is why this series is _WAY_ on the bottom of my list for
> > reviews...
> 
> I wasn't aware of that prior discussion, it would have helped to know
> that this is a major concern for you ...

Sorry, that was on a different thread for a different feature, I thought
it was this one.  Too many reviews at times.

> 
> If using device_is_bound() is a no-go then _find_onboard_hub() of
> the onboard_hub driver could make it's decision based on the
> presence (or absence) of drvdata, which is what the function ultimately
> returns.

That suffers from the same problem.  I'll take a look at this later
after -rc1 is out and see what can be done here...

thanks,

greg k-h
