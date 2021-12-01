Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC18464A2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhLAIwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:52:51 -0500
Received: from smtp2.axis.com ([195.60.68.18]:61352 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231397AbhLAIwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638348570;
  x=1669884570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0gShEKXjzX9AdLiLP+/IR19sas2R14bBFUPZdaEFTw=;
  b=K5dXPbbNsE+zJS4yzEVNThT5Si1JyphTahSc1x5IDydgEqW/HdFrINV3
   o/gs7GPpu9lkB61pqmlSEhg7EG1/ztT85t6ezAKU1/MTW5ZjMHCZOns62
   4WKDrNc+lTKw3VkzeNmn+UqWzdn9mJ8NAK/tjWoW8DItya6OQXRoqfFxX
   fwdsVBwN+zcAHZdw575jfafPnRku5bGKBYmeXsdE0WLJJaBg1H4MEtbgN
   kTFqIpX8WqAFvzri6Kql4gmnL44TyOu1dYsGJnF+A4xhB/bV6PHKvWUhg
   agywyNq59DAVU1ABeG5erL0vB90nTG5NtErepKhxpqyUB3mdk/z13Mldf
   Q==;
Date:   Wed, 1 Dec 2021 09:49:27 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Alessandro Zummo <a.zummo@towertech.it>, kernel <kernel@axis.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf8523: fix alarm interrupt disabling
Message-ID: <20211201084927.GB26222@axis.com>
References: <20211103152253.22844-1-vincent.whitchurch@axis.com>
 <YaaxcFn/di3wCnO1@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YaaxcFn/di3wCnO1@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:19:12AM +0100, Alexandre Belloni wrote:
> On 03/11/2021 16:22:52+0100, Vincent Whitchurch wrote:
> > Fix the driver to actually disable the IRQ and not overwrite other bits
> > in the CONTROL_1 register when it is asked to disable the alarm
> > interrupt.
> > 
> > Compile-tested only.
> > 
> > Fixes: 13e37b7fb75dfaeb4 ("rtc: pcf8523: add alarm support")
> > Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > ---
> >  drivers/rtc/rtc-pcf8523.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rtc/rtc-pcf8523.c b/drivers/rtc/rtc-pcf8523.c
> > index 8b6fb20774bf..e26477267451 100644
> > --- a/drivers/rtc/rtc-pcf8523.c
> > +++ b/drivers/rtc/rtc-pcf8523.c
> > @@ -347,7 +347,7 @@ static int pcf8523_irq_enable(struct device *dev, unsigned int enabled)
> >  	if (err < 0)
> >  		return err;
> >  
> > -	value &= PCF8523_CONTROL1_AIE;
> > +	value &= ~PCF8523_CONTROL1_AIE;
> >  
> 
> I was going to apply that but it seems this was fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=91f3849d956d58073ef55e01f2e8871dc30847a5

Yes, you're right, sorry.  I had only checked mainline at the time I
wrote the patch and not what was queued up in linux-next.
