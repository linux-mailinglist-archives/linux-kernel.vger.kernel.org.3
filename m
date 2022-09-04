Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAE5AC4D1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbiIDOiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIDOh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:37:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A383341B;
        Sun,  4 Sep 2022 07:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72AB6B80D78;
        Sun,  4 Sep 2022 14:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42711C433D6;
        Sun,  4 Sep 2022 14:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662302274;
        bh=7zTaLKk/YvXMljqVKzIItnnizZmpS7vkmEXB4DMC+Hs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o+940ZsrS37x4e4mDMiB7rDt+uuYjA21QQk/PX0LqJFdqKDgIn3TO/cNl2SArmG8a
         Hq/W/LOcdBG/KiyIWALo53KjGchc+2oaDftg1dF1yszDXq+rZSZI3CUB4qShy12F67
         sJHejE9w0aXwziIrf9JDgNuxpi6Ld8Pbu6S0dlANrpMznRwTqI8Ho2g7LPKe0w0rYC
         feChJE8C/re8eZqhSBCUr2sw1rH540P8Okomb8zjbpAwuFj9uKFr/yjdp/oJHlxjfw
         wZfUUXlLFL3tom7GAjL3w/alJ/sSkSWeoPL+CmxZsQ35s/EFyFkCPmlUI7IabeTXMo
         Zh+RvgkiLkAYg==
Date:   Sun, 4 Sep 2022 15:03:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Crt Mori <cmo@melexis.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
Message-ID: <20220904150346.0c56de9d@jic23-huawei>
In-Reply-To: <CAKv63us6OLg8ahdbKvd8c4x9-Ri4aDwNvgc_oov7wZnSBmJGVA@mail.gmail.com>
References: <20220902131258.3316367-1-cmo@melexis.com>
        <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
        <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com>
        <CAHp75VfJMpf3GeOryt9cH6-tK48BB8ZcfuGxhXovObBanDcc7w@mail.gmail.com>
        <CAKv63us6OLg8ahdbKvd8c4x9-Ri4aDwNvgc_oov7wZnSBmJGVA@mail.gmail.com>
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

On Sat, 3 Sep 2022 14:05:38 +0200
Crt Mori <cmo@melexis.com> wrote:

> On Fri, 2 Sept 2022 at 20:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Sep 2, 2022 at 8:59 PM Crt Mori <cmo@melexis.com> wrote:  
> > > On Fri, 2 Sept 2022 at 17:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > > On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:  
> > > > > +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> > > > > +               return mlx90632_pwr_set_sleep_step(data->regmap);  
> > > >  
> > > > > +       else  
> > > >
> > > > Redundant.
> > > >  
> > > No, the powermode changes among the type.  
> >
> > Yes. 'else' keyword is always redundant in the
> >
> >   if (...)
> >     return / break / continue / goto
> >   else
> >
> > cases.
> >  
> In this case current power mode of the sensor is halt, so the else is
> needed to set it to continuous mode, which means I can't just remove
> the else here because this statement restores the power mode before
> this function was entered (and changed powermode for the setup).
> 
> > > > > +               return mlx90632_pwr_continuous(data->regmap);  
> >
> > ...
> >  
> > > > > +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)  
> > > >
> > > > No __maybe_unused, use pm_ptr() / pm_sleep_ptr() below.
> > > >  
> > > Care to explain a bit more about this? I just followed what other
> > > drivers have...  
> >
> > And other drivers have what I said, but it's a new feature.
> > If you run `git log --no-merges --grep 'pm_ptr' -- drivers/iio
> > include/linux/` and read the history it will explain the case.
> >  
> Thanks for the hint.

The relevant EXPORT_ for this particular case isn't upstream yet
We had a proposal on IIO list, but there was a better one as part of
cleaning this up for MFD.  I haven't checked if there is a suitable
immutable branch for that patch yet...

Jonathan


