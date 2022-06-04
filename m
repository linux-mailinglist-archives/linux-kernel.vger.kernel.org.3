Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC753D771
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 17:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiFDPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiFDPQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 11:16:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A52BC5;
        Sat,  4 Jun 2022 08:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9F2360DF2;
        Sat,  4 Jun 2022 15:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8045FC385B8;
        Sat,  4 Jun 2022 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654355791;
        bh=sMVrMeuN+iV/XtWw2AufvrZZOEq7TIiPqjXY1rL4f9g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dpi95ZpkKxrLsmYgT2URHRj5uELvFeqz8H2wlFStZFuYv6dGW1G5k10G29ejzXlpX
         LOqJgMy1s/AMzWICKHl/Wc0Mm0aShXLuQ9IZPS+8gZT/Z5WiQo5gLN9phpqZqq4IWu
         rnoA4StXDeC5K6lurx01fPg8zXC9hl8Deca/WHXS/+N9naaZRys/QHyE3hgf2rjjSo
         7PXMOtWELwJwLfWCM+7fhn6tQqzXw1EXriD6L8gx3/sQ9rDQeiZ9T8D3LtZw078B3c
         qw3xwZy820FNE+hEbN+QWezuVb3JJ7yCOUwsmndzXSeZjYdJ9te2ORgdqCiEIUggJH
         dRUS1Xa9Ml8LQ==
Date:   Sat, 4 Jun 2022 16:25:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iio: addac: ad74413r: for_each_set_bit_from ->
 for_each_set_bit
Message-ID: <20220604162532.65e4ea0e@jic23-huawei>
In-Reply-To: <20220130142558.7601722c@jic23-huawei>
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com>
        <20220111074703.3677392-3-cosmin.tanislav@analog.com>
        <CAHp75VeVRwbMhQp-oBYM7yVzL_ma0jRu3ESEjz19zLQDFWyzkA@mail.gmail.com>
        <20220115185948.56f227df@jic23-huawei>
        <20220130142558.7601722c@jic23-huawei>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 14:25:58 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 15 Jan 2022 18:59:48 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 11 Jan 2022 11:22:23 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >   
> > > On Tue, Jan 11, 2022 at 9:47 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:    
> > > >
> > > > The starting bit is always zero, it doesn't make much sense to
> > > > use for_each_set_bit_from. Replace it with for_each_set_bit
> > > > which doesn't start from a particular bit.      
> > > 
> > > We refer to the function() like this.
> > > But no need to resend, I hope Jonathan may amend this when applying.
> > >     
> > 
> > I'll need to wait for rc1 to have the relevant code in my fixes-togreg
> > branch to pick these up.
> > 
> > They look fine to me and hopefully I'll remember to cleanup the above ;)
> >   
> First 2 applied to the fixes-togreg branch of iio.git.
> 
> This 3rd one isn't a fix so will have to wait for those to end up in
> my togreg branch.  Give me a shout if I seem to have lost this once that
> is true.

Oops.  Even with patchwork I occasionally lose patches as too many things
stick there for a long time for complex reasons.

Anyhow, now applied to the togreg branch of iio.git

Sorry for the delay

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > Thanks,
> > 
> > Jonathan  
> 

