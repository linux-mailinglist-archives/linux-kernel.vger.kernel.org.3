Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BF585EA4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiGaLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiGaLbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:31:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3D3E00D;
        Sun, 31 Jul 2022 04:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE7660C78;
        Sun, 31 Jul 2022 11:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419EFC433D6;
        Sun, 31 Jul 2022 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659267104;
        bh=38BTaASGYg5+Vs+XTa8bg9XAcJEvnldmFNzVWjYh5zg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lxRnv2Jw7emD1Dq4XiFS5ZFs7+8Ry7VRxlMXXYlT9lbEnlva+Za3gM29Xk+xq4PuX
         r/bY5LZQ9qQ4bYZiwijah8s26s285098TQKE/VhFxcrN6az3j+UkLlLLg/x4MhWD6E
         eeXRslRxl/3dw36mkbuu0UU6LhlsGfmkOc6KQ4tema3XLpBIvwDNgJVKf5CA8TNWzU
         QsZ31StzU9O76HsOoMtDkApRhUUchGdGHh4bWDAE/PP0IP4pCtcSUwuc4qVLVMe9IA
         mxkcQ109zlP0mGTFn3FljLP6qXj4vv7H6FgiaelMJIsI5gitrIpuBor0zXG0hycNJs
         cOcOMmMSIfiMA==
Date:   Sun, 31 Jul 2022 12:41:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jbhayana@google.com" <jbhayana@google.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] units: complement the set of Hz units
Message-ID: <20220731124140.777ddd05@jic23-huawei>
In-Reply-To: <CAHp75VfGEPVBWbZ16widVCjgCnYAoUurjDj+-2pgC2oBQR12ZQ@mail.gmail.com>
References: <20220729172332.19118-1-ddrokosov@sberdevices.ru>
        <20220729172332.19118-2-ddrokosov@sberdevices.ru>
        <CAHp75VfGEPVBWbZ16widVCjgCnYAoUurjDj+-2pgC2oBQR12ZQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2022 20:02:42 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jul 29, 2022 at 7:23 PM Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:
> >
> > Currently, Hz units do not have milli, micro and nano Hz coefficients.
> > Some drivers (IIO especially) use their analogues to calculate
> > appropriate Hz values. This patch includes them to units.h definitions,
> > so they can be used from different kernel places.  
> 
> ...
> 
> > +#define NHZ_PER_HZ             1000000000UL
> > +#define UHZ_PER_HZ             1000000UL
> > +#define MILLIHZ_PER_HZ         1000UL  
> 
> Oh, but then a bit of consistency?
> 
> MICRO
> NANO
Tricky given existing items, but I agree we shouldn't make
it worse.

However, I'm not 100% sold on why we need these conversions relative to HZ.
What's wrong with using MILLI / NANO etc as already defined?  I guess
there is a 'documentation' like effect of making it clear these are frequency
unit conversions, but I don't think it makes sense to add it for all the other
types of unit, so why is Hz special?

I'm not sure why we have the existing ones for HZ with the
exception of KHZ_PER_MEGAHZ.

Jonathan

> 

