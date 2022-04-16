Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2855035F6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiDPKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:36:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0412BC7;
        Sat, 16 Apr 2022 03:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6C2BB81D17;
        Sat, 16 Apr 2022 10:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694F8C385A1;
        Sat, 16 Apr 2022 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650105232;
        bh=RkfjwSY2V54oCcdnuPvXsSFQ3xDecQj7tVsVG5NkgEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SRJdPBWD89TaY39pJ9OUMKyuhqcSnECbekubt+rtqVIPbunHrtzC/IIr2DB66yxxh
         gpHXxPBcrUlwsiVmY9o7o82MW+XqvOFASV77gRIxwMDpFBrwUXocH9PaggplJ/w5ou
         KA7AhqxiEswEUKcL7IGMc4AS5YZAwRq6u5CItWYyyjbs9ZMzWF+y4xsA0IqGjfqrbj
         41Msmhm8SD/t9vKAC/2NmND0Mekk2AjwLvfYHk4stILmaWfkoRMUShgCpXn9C5zBQT
         Pn/PE6TBho6HUk2AbNktszZs7jFymUvU+sucX6xBYeFdGZEU+w67uw7oOr7OENR7XP
         LEs427tvpG/gA==
Date:   Sat, 16 Apr 2022 11:41:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: afe: rescale: Make use of device properties
Message-ID: <20220416114150.171813b6@jic23-huawei>
In-Reply-To: <YlmFezCYNeUxa8cL@shaak>
References: <20220413190117.29814-1-andriy.shevchenko@linux.intel.com>
        <Ylgwhu9zdmwwYnAq@shaak>
        <YlhT/yiJSD7pFsF8@smile.fi.intel.com>
        <YlmFezCYNeUxa8cL@shaak>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 10:47:23 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> On Thu, Apr 14, 2022 at 08:03:59PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 14, 2022 at 10:32:38AM -0400, Liam Beguin wrote:  
> > > Hi Andy,
> > > 
> > > On Wed, Apr 13, 2022 at 10:01:17PM +0300, Andy Shevchenko wrote:  
> > > > Convert the module to be property provider agnostic and allow
> > > > it to be used on non-OF platforms.  
> >   
> > > > +#include <linux/mod_devicetable.h>  
> > > 
> > > Is this really needed?  
> > 
> > Yes.
> > This header is missed. I can split its addition to a separate patch.  
> 
> Understood, maybe a separate patch would make it more explicit.

You could also argue that the main route people 'expect' that header via
is of.h and given that include is dropped in this patch, we have even more reason
mod_devicetable.h should be included.

So I'm fine with this in one patch on that basis.

Also I'm lazy and not having to go to v2 on this saves me a little bit of effort :)

Hence applied.


Jonathan

> 
> Cheers,
> Liam
> 
> > > device_get_match_data() is already defined in <linux/property.h>  
> > 
> > It's indirectly related (just like we do when we clean up of.h). Since
> > the original of.h is missed there is no header replacement, just adding.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   

