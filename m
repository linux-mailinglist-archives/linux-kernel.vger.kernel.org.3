Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF659D463
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 10:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiHWIW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiHWIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:16:25 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD36455;
        Tue, 23 Aug 2022 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661242248;
  x=1692778248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=90lMTt/ZXObsrajbLvhxlhFniuNo3NYsG99rwzGubV4=;
  b=QtHPZwfZYRIrxwYMvcrxSu9EztzKiz0nXdQYG4DB28m2xocRELb0vAac
   OhEdvcjR859428A2NfsfbZwSyO+4PfruV4Xrt5pp7S1X/hc3vodDXj3cG
   2RI/K3hPyQ2rOWbWuzXu5Fpu/UVYSNiNUnefOE7+O4BWwnFFzBd5/it3C
   mbiNhFaZj7kJkkLjpl4qklEWfDw/3AAveXd0mEMY/HXgXzb5I3AmEnU/i
   Ek3Ib0SDq2CuNV9451Mo6cNvm0XOp5IiDhQHiSKAYiz0O+mHhfYSauya1
   bFBvqKWv+6iknPPLzCgJJnAZtJuLlIHLZDs0cwqsn7wYluqxOaxzFrHsA
   A==;
Date:   Tue, 23 Aug 2022 10:10:45 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Message-ID: <YwSLhWFbGb26B3mx@axis.com>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
 <CAHp75VebQfdHrfYTmF0w9M556ZV8fG5jJ2rAN5a3mrB1mbvOQw@mail.gmail.com>
 <20220820120800.519b5eb5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220820120800.519b5eb5@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 01:08:00PM +0200, Jonathan Cameron wrote:
> On Fri, 19 Aug 2022 11:03:55 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On top of that, Fixes tag?
> It's going to be tricky to identify - the interface predates usecases that were IIO
> drivers by a long way.  I guess introduction of first IIO driver that used
> a callback buffer? No idea which one that was :(

AFAICS there's only one IIO driver upstream using a callback buffer, and
it's lmp91000, so I can point the fixes tag to the patch which added
that.

By the way, note that lmp91000 actually fails to probe in mainline
without extra patches, and it seems to have been that way for a while
now.  I noticed this lockdep splat when working on a new driver which
also uses a callback buffer.  I can post the fixes I used to get
lmp91000 to probe successfully (in roadtest) separately.
