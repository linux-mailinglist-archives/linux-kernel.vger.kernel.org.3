Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C3B5278C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 18:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiEOQcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 12:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiEOQcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 12:32:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381361C106;
        Sun, 15 May 2022 09:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33AEEB80D23;
        Sun, 15 May 2022 16:32:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CBFC385B8;
        Sun, 15 May 2022 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652632323;
        bh=4vBXeGOXH388BuK75d5Tbp+8kwGEur5G8fxJzz0bKYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LZSZIAHpVmgathYw/TYcyOBMQIG8PO1S0uy4FplHjtoYiEcAfiAybb/29DMLDxz9C
         wElDUYIbi72GszJ8cInKUChRyQgzb8x77SFu5QEFRxJBzqlHU1MCnmEwmRX5hpEuue
         VMTQ+DBTn4td8XmSIs7Ux8ZQbRAOdFC3oP88h2cV7CdJW2m5duoORNhpOzpiYJbCDh
         dIDjx7v3tZBFdA/bgsNna5pkq2OpCLU0a+d6EJ5PoCuomjUuxqx8/OaKrtRfAhJqwb
         zWrCQuvR9G10e/H+5DPZLucT6glBf4oakcupfKJR1usj2lwxI0qhm6hu0Vddj0UbjM
         jElHC+TaZVT5w==
Date:   Sun, 15 May 2022 17:40:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Matti Vaittinen <Matti.Vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 05/22] iio: replace bitmap_weight with
 bitmap_weitght_{eq,le} where appropriate
Message-ID: <20220515174037.614c6c6e@jic23-huawei>
In-Reply-To: <58a70b4a91a184eef26f9823636bf81c573b2c3b.camel@perches.com>
References: <20220510154750.212913-1-yury.norov@gmail.com>
        <20220510154750.212913-6-yury.norov@gmail.com>
        <20220514165309.7445c767@jic23-huawei>
        <58a70b4a91a184eef26f9823636bf81c573b2c3b.camel@perches.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 09:31:23 -0700
Joe Perches <joe@perches.com> wrote:

> On Sat, 2022-05-14 at 16:53 +0100, Jonathan Cameron wrote:
> > On Tue, 10 May 2022 08:47:33 -0700
> > Yury Norov <yury.norov@gmail.com> wrote:
> >   
> > > bitmap_weight_{eq,le} is better than bitmap_weight because it
> > > may return earlier.
> > > 
> > > CC: Jonathan Cameron <jic23@kernel.org>
> > > CC: Lars-Peter Clausen <lars@metafoo.de>
> > > CC: Michael Hennerich <Michael.Hennerich@analog.com>
> > > CC: linux-iio@vger.kernel.org
> > > CC: linux-kernel@vger.kernel.org
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>  
> > without being cc'd on the cover letter, there is no obvious way for
> > me to know this is reliant in some series to be found in next.
> > 
> > Please call out the exact dependency and whilst it's a long list,
> > it is good to cc all people cc'd on individual patches also
> > on the cover letter so they have that background information.  
> 
> When doing a treewide change like this, vger would commonly
> reject the message because of too many recipients.

Hmm. I took a look via lore before sending this moan and didn't think
this actually had that large a list of CCs but maybe my counting wasn't
great (lots of overlaps between different patches).

The series is also not a tree wide change.
It's a set of changes related only by the fact they are using
a call to the same set of functions and the series is based
on next (which is usually a bad idea as a tree to base anything on).
Arguably there are two different sets of functions at that (the bitmap
ones and the cpumask ones)

This is a good set of changes, but taking it slowly and sending these
out as a number of different series after rc1 would have made
much more sense to me.  That way visibility would have been good
and they could have been applied through the various individual trees.

If there is a reason to want to take this via a common tree then
that information needs to be conveyed to all the subsystem maintainers.

Jonathan


> 
> > 
> > Change seems fine, but I've no idea when/if to pick it up because of
> > that lack of information.  
> 
> You could try using lore with the in-reply-to message header id
> 
> https://lore.kernel.org/lkml/20220510154750.212913-6-yury.norov@gmail.com/
> 
> that gives you the entire thread.
> 

