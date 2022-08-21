Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B917159B58D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiHUREF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHURED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:04:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE013FA6;
        Sun, 21 Aug 2022 10:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4E8FB80A08;
        Sun, 21 Aug 2022 17:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E339C433D6;
        Sun, 21 Aug 2022 17:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661101439;
        bh=lmaONrarTYyoSnUieZtTg5QSSZi6JaipEBFE/NQounY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pGDQAKjwVlBFKJvENPzrYPhYN0hSeGlSggZ+IRf4mwFF3sI5/AQoAKnIi/dooYgD6
         2e0dJyQh0fSaM67YFXxxR5ZPBiwu9ISBMmW7rKbP4PLSdy5C33ZkqQc7RznzEpGRD/
         PNe8hvLJ+t9SJXPBbAvAC3GKvp3HEdCT2ZgOaza/FcDkGkAdBj3EPxz/fw25EdmvKo
         YKEPUNT10ipfNJT0CGtS/T8LugldK5MpoyQmtO8r1cEX3XG38atRajOeBQPIPgqLe5
         Bh/2MaUl1G5RZZDH92GfteF/Y4TUD+zrhBOk/x4IKUpLhTbEDC/OKu3E9x28neMZ9E
         sBuT8qcc3U5SQ==
Date:   Sun, 21 Aug 2022 17:29:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: frequency: admv1014: return -EINVAL directly
Message-ID: <20220821172930.29e7a2fa@jic23-huawei>
In-Reply-To: <CAHp75VfQY_7WQZTxGG17Ps=VHGrnGdUAdRpacPYeJEMK5PS6yA@mail.gmail.com>
References: <20220819104117.4600-1-antoniu.miclaus@analog.com>
        <20220819180856.5a1d4e5a@jic23-huawei>
        <CAHp75VfQY_7WQZTxGG17Ps=VHGrnGdUAdRpacPYeJEMK5PS6yA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sat, 20 Aug 2022 18:56:53 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 19, 2022 at 8:41 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 19 Aug 2022 13:41:17 +0300
> > Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
> >  
> > > Remove extra step where the error code is assigned to the `ret`
> > > variable.
> > >
> > > Return instead error code directly.  
> 
> ...
> 
> > Change is fine, but I've dropped the fixes tag. The code before this
> > wasn't broken, just longer than it needed to be. We don't want the noise
> > of this getting backported because someone sees the fixes tag and thinks
> > there is a reason it needs to be.
> >
> > Applied to the togreg branch of iio.git  
> 
> Haven't checked myself if it's possible, but shouldn;'t we go further
> and return dev_err_probe()?

Good idea, but only as part of a patch doing that throughout the driver.
So follow up patch perhaps..

> 
> > >       chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
> > >       if (chip_id != ADMV1014_CHIP_ID) {
> > >               dev_err(&spi->dev, "Invalid Chip ID.\n");
> > > -             ret = -EINVAL;
> > > -             return ret;
> > > +             return -EINVAL;
> > >       }  
> 
> 

