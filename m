Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A314ACAB5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 21:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiBGUsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 15:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbiBGUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:37:50 -0500
X-Greylist: delayed 201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 12:37:50 PST
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC46C0401DA;
        Mon,  7 Feb 2022 12:37:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 69338CE10EF;
        Mon,  7 Feb 2022 20:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6687EC004E1;
        Mon,  7 Feb 2022 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644266266;
        bh=IgAuBdjgFLxpzyuTFtxQnKiQ28etrzscehcAocUU+Tg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VqlmucnKui7TMn1XduYKgDyTgILjXVAJy1KHKfLJ3+Isf3ztsu8BxIsj8spr9joY5
         0S6wIuiB3dVtnWWkcLRgDugXPq894VXMvElJNoUEGidLjkcMYPk+wjOmxqoLmsSTpP
         cvKdmGieZhs5hgOUF+jEd0PMbx6PnV05KXmZXVHgvD+pP9eDcM/pRdQWlRtj9NyLGi
         gS0L8IoD0n1sapSUvOQQ0PUpSmg/joajcuyYNuSruCbaV0PEaWANBu65hYOtBqBEgx
         BYsISPk9Z9VK/+AqpI8Rzj58SKIycjO136cX526qV/TX6sKbYxXDNKaxNmvZB2fn5N
         /x7kAF2g8GK+A==
Date:   Mon, 7 Feb 2022 20:44:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joe Perches <joe@perches.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/3] iio: temperature: ltc2983: Don't hard code
 defined constants in messages
Message-ID: <20220207204421.7f905aa5@jic23-huawei>
In-Reply-To: <YgFVFceYQtWq4Hww@smile.fi.intel.com>
References: <20220207104830.83882-1-andriy.shevchenko@linux.intel.com>
        <fdb3056dcaf9dd113049adebbc3fcd74de2b3028.camel@perches.com>
        <YgFVFceYQtWq4Hww@smile.fi.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Mon, 7 Feb 2022 19:21:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Feb 07, 2022 at 08:37:55AM -0800, Joe Perches wrote:
> > On Mon, 2022-02-07 at 12:48 +0200, Andy Shevchenko wrote:  
> > > In a couple of messages the constants, which have their definitions,
> > > are hard coded into the message text. Unhardcode them.  
> > 
> > Found by inspection or tool?  
> 
> Does it matter? No, a side effect of the following patch.
> 
> ...
> 
> > > +		dev_err(dev, "Steinhart sensors size(%zu) must be %d", new_custom->size,
> > > +			LTC2983_CUSTOM_STEINHART_SIZE);  
> > 
> > probably better using "%u" and not "%d"
> > 
> > and better with a \n termination too.  
> 
> I think it would be a separate change if we wish so. Let Jonathan to tell what
> to do here.
> 
Either way is fine by me.  I tend to be a little flexible of trivial fixes
in patches that are as simple as this one.

Thanks,

Jonathan


