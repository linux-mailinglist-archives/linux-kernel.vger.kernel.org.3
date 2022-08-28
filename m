Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A05A3EEC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiH1Rks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiH1Rkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:40:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFD8DF58;
        Sun, 28 Aug 2022 10:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06DD600BE;
        Sun, 28 Aug 2022 17:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFD8C433C1;
        Sun, 28 Aug 2022 17:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661708444;
        bh=M6V49NugIE7cNc4R62990NdetudL6kmloeJE8uOD5E8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c6aDkTUZ9DD4nkoBFIRYme/HO8S9c1GhteVBULvXGeKP7mSWoFlJDzWR2rVOj5Wq/
         kKV4UPECmB9Ai+CPG8xg9mTFNkAn4TmYG5bJN+6I/J2W6QWOhxWTZX27h27b58bZ93
         ECCzXdFHAJ4vUIgt4zhk0ynLnYUlrSvANYrrzRrvLsnay2mNnk6Z7tIWwmZ8D9uM+4
         50G6ckzh+drL7udCYLlip+SmY11OpipJ0v5eFbNIQc8WlpvXC3PTS/TRkI2y+q5OA6
         +Puml7OcQAOYlkxUXgxB/Ux/3VgIePPOQz0cfo8i5P5sU2Tiv4Ow0nksJZy9h+RiRX
         jMh5jJrWHRWSg==
Date:   Sun, 28 Aug 2022 18:06:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Axel Jonsson <Axel.Jonsson@axis.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: mcp320x: use device managed functions
Message-ID: <20220828180623.54939dd7@jic23-huawei>
In-Reply-To: <CAHp75VffYzNTfrki4+o8JJayUGo1n91bP0hSzB-fR=RfcFq-fw@mail.gmail.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
        <20220824104002.2749075-2-vincent.whitchurch@axis.com>
        <CAHp75Vf4C0hauoT7F26zS7815Cps=W3o1_HHmWKVbrUi90FcrQ@mail.gmail.com>
        <Ywiwv8TZ5oomTuHK@axis.com>
        <CAHp75VffYzNTfrki4+o8JJayUGo1n91bP0hSzB-fR=RfcFq-fw@mail.gmail.com>
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

On Fri, 26 Aug 2022 14:57:44 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Friday, August 26, 2022, Vincent Whitchurch <vincent.whitchurch@axis.com>
> wrote:
> 
> > On Thu, Aug 25, 2022 at 10:01:58PM +0200, Andy Shevchenko wrote:  
> > > On Wed, Aug 24, 2022 at 1:46 PM Vincent Whitchurch
> > > <vincent.whitchurch@axis.com> wrote:  
> > > >
> > > > Use devm_* functions in probe to remove some code and to make it easier
> > > > to add further calls to the probe function.  
> > >
> > > ...
> > >  
> > > > +       mutex_init(&adc->lock);  
> > >  
> > > > +       return devm_iio_device_register(&spi->dev, indio_dev);  
> > >
> > > Do you still need to destroy the mutex? If so, you may not call devm_
> > > variant of iio_device_register() or you have to wrap mutex_destroy()
> > > accordingly.  
> >
> > mutex_destroy() is only used to ensure that mutex debugging catches
> > further use of the mutex.  Isn't it rather overkill to add specific
> > cleanup to do only that, especially in this case when it's anyway going
> > to get freed immediately afterwards?  The vast majority of IIO drivers
> > don't call mutex_destroy() (256 calls to mutex_init() in HEAD vs 12 to
> > mutex_destroy()).
> >  
> 
> 
>  So 256 - 12 = 244 drivers are not pedantic.

I long ago decided mutex_destroy() in remove() paths just isn't worth the
effort. It makes absolute sense in more complex flows, but in cases
like this it's just annoying and makes the cleanup harder.

Hence I'd prefer we just ignore it's existence in cases like this.

If someone finds me a bug that it would have caught then I might
change my mind ;)

If anyone wants a giggle via adding a devm_mutex_init() call it
might be interesting to see the responses.  Would be unusual in
that it would just be mutex_init() in unless the mutex debugging
is turned on...

Jonathan


