Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305985A3E82
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiH1QHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiH1QHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 12:07:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DD32CE0C;
        Sun, 28 Aug 2022 09:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CA1DDCE0924;
        Sun, 28 Aug 2022 16:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C8C433D6;
        Sun, 28 Aug 2022 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661702828;
        bh=6QmM8/GiuDkSpxDLj8miyaVK8Mz2SqME5orytHsgun4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iwawSyZ1CVVtLjkqYGlZjo0WWhqb3Y47lhAJj4vXDcTZT48bYySdYaCtOlWLuv1Vo
         AqSCpcMf2SpgIOn7UtASmAoHLxWDiMRSt3joaW5icqYigDuLNx8f1Nb4rlp3WKUhbM
         QGKEhktAGGDaNoCMW/fpn7v5zVxsXehwbrfQo/W/V6bqibtVCZ6xL36e+b6VuOgXJi
         83GXgKnmfpI4maef9p9KchSEaACgPafiZIo/8k2ehniAW9x8onOTYpW6AMC5CX/KVj
         uTi7+x5rG6tY4BvFJPnYM+1cQ3KMYCT01lxxkH9y7sUbAyjQIMRy9SlO+0nFjUkH0P
         atwrlYISmNvrQ==
Date:   Sun, 28 Aug 2022 16:32:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Message-ID: <20220828163247.3d6417d9@jic23-huawei>
In-Reply-To: <YwSLhWFbGb26B3mx@axis.com>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
        <CAHp75VebQfdHrfYTmF0w9M556ZV8fG5jJ2rAN5a3mrB1mbvOQw@mail.gmail.com>
        <20220820120800.519b5eb5@jic23-huawei>
        <YwSLhWFbGb26B3mx@axis.com>
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

On Tue, 23 Aug 2022 10:10:45 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> On Sat, Aug 20, 2022 at 01:08:00PM +0200, Jonathan Cameron wrote:
> > On Fri, 19 Aug 2022 11:03:55 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On top of that, Fixes tag?  
> > It's going to be tricky to identify - the interface predates usecases that were IIO
> > drivers by a long way.  I guess introduction of first IIO driver that used
> > a callback buffer? No idea which one that was :(  
> 
> AFAICS there's only one IIO driver upstream using a callback buffer, and
> it's lmp91000, so I can point the fixes tag to the patch which added
> that.

Ah. That's handy.

> 
> By the way, note that lmp91000 actually fails to probe in mainline
> without extra patches, and it seems to have been that way for a while
> now.  I noticed this lockdep splat when working on a new driver which
> also uses a callback buffer.  I can post the fixes I used to get
> lmp91000 to probe successfully (in roadtest) separately.
That would be great.  Unfortunately drivers sometimes bit rot
without testing.

Any plans to post updated roadtest soon?  I'm keen to add more test cases
and use it to cleanup the remaining staging drivers.  Very helpful tool,
but I don't want to be developing test sets against an old version if
it's going to be costly to forward port it. No great rush though as
I've bitten off a bit more than I was aiming to in prep for plumbers so
not going to get anything significant done in IIO until mid September.

Thanks,

Jonathan

