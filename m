Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CFF5A26F8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiHZLir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHZLio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:38:44 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320A5DB7E2;
        Fri, 26 Aug 2022 04:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661513922;
  x=1693049922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P9AsG7gThmUES9KSpQbh1/yQIt+a2Ly6k49idujfHCM=;
  b=Az3mPGnggbKs/VBeSChAq+3SFUCiIgtREdgp2tQ90hj65Tvi8+P9BLA1
   AlPUM44pHRBlXUa+d2UToIGlyi3BOTGQhm8WNj6ATwNd9PtiIF465xzPM
   XsCN3wOzsbeMQzw/NXCQRoMukNw1cq+4MwdrD/nMZMr/QVSwIwUfr65+T
   HH9hLJGj0zLgrAkZJFoKhJtljrgPiw3U3M77Ac3V3gRPs13nhZK7YGXLv
   l96evXNcYOkYSxQHuBeBCj72yNEysvbxE4EvZ4un6XzKrLYBKl0aVwaVq
   nUyhs4d0iT04lfBYzbjdKIH6QOUFupeKxZkvvXu1IH4roCePzcHujyNrx
   w==;
Date:   Fri, 26 Aug 2022 13:38:39 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Axel Jonsson <Axel.Jonsson@axis.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: mcp320x: use device managed functions
Message-ID: <Ywiwv8TZ5oomTuHK@axis.com>
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com>
 <20220824104002.2749075-2-vincent.whitchurch@axis.com>
 <CAHp75Vf4C0hauoT7F26zS7815Cps=W3o1_HHmWKVbrUi90FcrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf4C0hauoT7F26zS7815Cps=W3o1_HHmWKVbrUi90FcrQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:01:58PM +0200, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 1:46 PM Vincent Whitchurch
> <vincent.whitchurch@axis.com> wrote:
> >
> > Use devm_* functions in probe to remove some code and to make it easier
> > to add further calls to the probe function.
> 
> ...
> 
> > +       mutex_init(&adc->lock);
> 
> > +       return devm_iio_device_register(&spi->dev, indio_dev);
> 
> Do you still need to destroy the mutex? If so, you may not call devm_
> variant of iio_device_register() or you have to wrap mutex_destroy()
> accordingly.

mutex_destroy() is only used to ensure that mutex debugging catches
further use of the mutex.  Isn't it rather overkill to add specific
cleanup to do only that, especially in this case when it's anyway going
to get freed immediately afterwards?  The vast majority of IIO drivers
don't call mutex_destroy() (256 calls to mutex_init() in HEAD vs 12 to
mutex_destroy()).
