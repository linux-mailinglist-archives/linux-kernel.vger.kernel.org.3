Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31405AC5FC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 21:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbiIDTIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiIDTIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 15:08:52 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3652BB2B;
        Sun,  4 Sep 2022 12:08:52 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id j1so5177924qvv.8;
        Sun, 04 Sep 2022 12:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=juGsLKnqTXsnwZqRs+MmcAEQwaIZtbGH5Zi0HPPGJzk=;
        b=mZi3BejmzkopJJwZy4mQLPZIKs10+v92BcLT/ZV+n/ZEI86GF/1zaJvhBrO5dchPOp
         K519FXbBIvbMjclN3fBufHSIIqRWjLlqEGZL4LdXR+bodb+6V9Ko6hpPeYMWK0T5MLC5
         V0WCY/En33bYc0bh4BzwDpnM5sJbTzJnbqPQeypnaS+IrzVidbZeCCPl8KnL+T4zSHrO
         PotUylI8PJQ2xb4atCYUUMefHJusVZkw8sTAX9Xl/8NmrpGg8U2rYtAM3ALvi64PgPiX
         fxiEPm9eYvNK1LK5Z5MBNDN7tVmPVv6o9xpKbnp5LMVSpDPTQoI0sqmE5RQ7oqYzhEkE
         JA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=juGsLKnqTXsnwZqRs+MmcAEQwaIZtbGH5Zi0HPPGJzk=;
        b=nknfKi8VWb6EV4vwUhideKk1lJUrv1Sdq6tTRug5zxZkFZ2cOXPdyy6cxTwI2Pr374
         /26JnCRE9LR2xt3r/yGduvul+rpI8S2iWmDMrmyzXLCwJnLB4iW72hy5FC9lOfF1Hewx
         Z2APZZ+3YkA3o1untfcm8lwKuRp42HGzIZbUj75Xej5YWlk1aNtTOWPz9UxQ7CXSalE5
         CDgefJd3yPyk3fEtqqmNyr1iCj0ty9j7ff8DixMBIgp0kM3wp1RQBPIh4ZAIJnM/Yz87
         ibLDs0ACPIHRqMXYJzlcnzbyuZxuv24HdTMT1JYLi0L++ZXRw2T4jFbRAu2VgrZk/XUo
         6FfQ==
X-Gm-Message-State: ACgBeo26m+bflJBk3CV+QlV56QVtuPtRzXjf6+D3o1wATkr5IfBGw86i
        bfQO7mcLMtGFi6iOBhRQ5s2CnzWiWOH+s4bg2GN781BCY5g=
X-Google-Smtp-Source: AA6agR6hWx2DZCWskDIHl/i4XU4bpGVxGVqmo4490iUi1W8K8zuZGqNfWzfJwl/Kzp5EEXnep6Y8SyDDhiDUVoLc3+A=
X-Received: by 2002:a0c:e24b:0:b0:4a1:d41b:e280 with SMTP id
 x11-20020a0ce24b000000b004a1d41be280mr3423294qvl.11.1662318531239; Sun, 04
 Sep 2022 12:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131258.3316367-1-cmo@melexis.com> <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
 <CAKv63ut0rtTFh3XdF3oR6fxQSLzNkFRS+HPPOY8Xp4LX0OY4Tg@mail.gmail.com>
 <CAHp75VfJMpf3GeOryt9cH6-tK48BB8ZcfuGxhXovObBanDcc7w@mail.gmail.com>
 <CAKv63us6OLg8ahdbKvd8c4x9-Ri4aDwNvgc_oov7wZnSBmJGVA@mail.gmail.com> <20220904150346.0c56de9d@jic23-huawei>
In-Reply-To: <20220904150346.0c56de9d@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Sep 2022 22:08:15 +0300
Message-ID: <CAHp75VdMZYD4AwXjoy6dbopUyv4=qwzfgnVpSu_-_ZWtYMG92Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 4, 2022 at 5:37 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 3 Sep 2022 14:05:38 +0200
> Crt Mori <cmo@melexis.com> wrote:
> > On Fri, 2 Sept 2022 at 20:39, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Sep 2, 2022 at 8:59 PM Crt Mori <cmo@melexis.com> wrote:
> > > > On Fri, 2 Sept 2022 at 17:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:

...

> > > > > > +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)
> > > > >
> > > > > No __maybe_unused, use pm_ptr() / pm_sleep_ptr() below.
> > > > >
> > > > Care to explain a bit more about this? I just followed what other
> > > > drivers have...
> > >
> > > And other drivers have what I said, but it's a new feature.
> > > If you run `git log --no-merges --grep 'pm_ptr' -- drivers/iio
> > > include/linux/` and read the history it will explain the case.
> > >
> > Thanks for the hint.
>
> The relevant EXPORT_ for this particular case isn't upstream yet
> We had a proposal on IIO list, but there was a better one as part of
> cleaning this up for MFD.  I haven't checked if there is a suitable
> immutable branch for that patch yet...

Oh, well to know. But in any case pm_ptr() / DEFINE_*PM_OPS can still be used.

-- 
With Best Regards,
Andy Shevchenko
