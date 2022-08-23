Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2DD59D4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243000AbiHWI1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243800AbiHWIVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:21:43 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ADF71706;
        Tue, 23 Aug 2022 01:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661242378;
  x=1692778378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dsmv2HWtXdyoSrM7X25yViaz1yQI9MEMGWUi+MfjE0g=;
  b=BGbqcAusKcLIyRblNhfi4BhRxGfzA8XQ7BgxiegR9i/HxXXXVs5SgZO2
   9pbFZgmUHz/amsdF+K3uPLFq9IdlOxtQ96qTxc3WbP4VeNhIECo8k0hB6
   UcKz5OQfuCJa8083MXcuiGRZcE6HmM3//dlGI387AOlJTYOiaZSUXVq6T
   j3jz/5ZUXYHydJ2cxJLax6fA0YGwNiDuTwSFJSvmTNDogXDxSczc/K5u+
   7FT1OmJmRwO4Y7rLlEVKXwO838gAVmrkEvK3jaEAYJHUxeQ57UAK0XWLP
   USH6IA+KEvmkLEgVdTs8YkKtjF5F8ugx5FivBrfsu2IRJ/KLVbc/pZdRX
   w==;
Date:   Tue, 23 Aug 2022 10:12:33 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>, kernel <kernel@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Message-ID: <YwSL8VD78u0ea0Qb@axis.com>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
 <20220820120640.6d1b928d@jic23-huawei>
 <ff2bc13c-f66f-03f3-fc01-c4f962f7b694@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff2bc13c-f66f-03f3-fc01-c4f962f7b694@metafoo.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 01:08:28PM +0200, Lars-Peter Clausen wrote:
> There are two different approaches for this kind of nested locking. One 
> is to use mutex_lock_nested(). This works if there is a strict 
> hierarchy. The I2C framework for example has a function to determine the 
> position of a I2C mux in the hierarchy and uses that for locking. See 
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L1151.
> 
> I'm not sure this directly translates to IIO since the 
> consumers/producers don't have to be a in strict hierarchy.  And if it 
> is a complex graph it can be difficult to figure out the right level for 
> mutex_lock_nested().
> 
> The other method is to mark each mutex as its own class. lockdep does 
> the lock checking based on the lock class and by default the same mutex 
> of different instances is considered the same class to keep the resource 
> requirements for the checker lower.
> 
> Regmap for example does this. See 
> https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap.c#L795.
> 
> This could be a solution for IIO with the downside how the additional 
> work for the checker. But as long as there are only a few IIO devices 
> per system that should be OK. We could also only set the per device lock 
> class if in kernel consumers are enabled.

The second method certainly sounds like a better fix, since it also
still warns if one actually takes the same iio_dev mutex twice.  I'll
respin the patch.  Thanks.
