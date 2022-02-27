Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808744C5B58
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiB0NdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiB0NdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:33:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD412BF;
        Sun, 27 Feb 2022 05:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19812CE0EA9;
        Sun, 27 Feb 2022 13:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC263C340E9;
        Sun, 27 Feb 2022 13:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645968742;
        bh=MDxfpEkZxbZP0NEaZp1YTMdHCQwoV1UW5mdbq06+8B0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dGpEzc5KVGdhcIL2OrlJkfkoxuOaBSeFYSYde3h/d5gmepWc4YfR4mfP44UVxZq8Z
         87KAZXiFO1HFIujBWh0V/BHTlotNYl/YrKUmpByZUVjXahoZruVuqpzNwn78B+Vijj
         8k3EqWCwToXIbAQpJ+sCGQuJXcUaBDyM/twX9e0yFsZ/muY0D8bmjBhFe3Kz8VTCaA
         OpHhF4OYsskcV0WLpOlxJRa41FWLAtv3Vn6SautX66TY060M9fmaAETP6EhCutZwIr
         3/atiDWUo8WicY0AhL9hreHj+9wbebuGhA2aT8FBgIL45OiwdAds/L6HlyUqMCHpoH
         BQNbbI9FMRgUw==
Date:   Sun, 27 Feb 2022 13:39:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Beguin <liambeguin@gmail.com>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v15 00/10] iio: afe: add temperature rescaling support
Message-ID: <20220227133925.19707a87@jic23-huawei>
In-Reply-To: <CAHp75VdNg--SAZ=8XqfZuhQ4iX3b9_O3psWHZZL8kO5hf7n14g@mail.gmail.com>
References: <20220213025739.2561834-1-liambeguin@gmail.com>
        <20220227125559.72d5d79a@jic23-huawei>
        <20220227130546.5ed0bae1@jic23-huawei>
        <CAHp75VdNg--SAZ=8XqfZuhQ4iX3b9_O3psWHZZL8kO5hf7n14g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Feb 2022 15:25:50 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Feb 27, 2022 at 2:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun, 27 Feb 2022 12:55:59 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Sat, 12 Feb 2022 21:57:29 -0500
> > > Liam Beguin <liambeguin@gmail.com> wrote:
> > >  
> > > > Jonathan, Peter, Andy,
> > > >
> > > > This series focuses on adding temperature rescaling support to the IIO
> > > > Analog Front End (AFE) driver.
> > > >
> > > > The main changes to the AFE driver include an initial Kunit test suite,
> > > > support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> > > > and temperature transducer sensors.  
> 
> ...
> 
> > > I was waiting for Andy to reply to this. Took a quick look back at
> > > what was outstanding and realised he had given a
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > for v13.  
> >
> > Actually given the units.h change is a perhaps non trivial perhaps that's
> > why you dropped Andy's RB.  I'll still apply the series, but it Andy
> > confirms his view on that tag before I push this out as something I can't
> > rebase I'll add it if appropriate.  
> 
> Since it was a separate patch, I'm fine with not including it due to
> strong argument from Peter.
Thanks. I've added your Rb and pushed out a fresh testing branch.

Jonathan

> 
> > > I'm assuming there wasn't a strong reason to drop that in the meantime
> > > and it's a simple omission / crossed emails issue.
> > >
> > > As such,
> > >
> > > Series applied to the togreg branch of iio.git and pushed out
> > > as testing to get some build coverage from 0-day.  
> 
> 

