Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8F34FFF16
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiDMTYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiDMTYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:24:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A42F4AE03
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:22:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g20so3634173edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MilXQC1tGawrIwnXnA0XmAAAlHvsFkKNc4Mvh7VSPxs=;
        b=09QiATtTDV+mr4QTOr2vwGHjd7VRC4YfgbltMGVapzsA8Amky0LqAA4RsmsinFLmPS
         swPbolc6MVlkhWVFdXhsbOxdk+sAGdQPnE3seed01gYAtK3clJPeh2zDiCOqkSPC29bY
         4RPvmXMe6umrwGwEV0B2vCH3kJZJBB5EYA4mUn0UXqIf0j/Naqy8YXh7QBDSivHofDGV
         rKr7xK0Ui/GkfcG4bdjrkIm9mCGaqI4Pi3kaDtx5woxHggOSRc7Sn45dIlGmTprVokTq
         cqGpnxwerhWNy5fYRv4cSwFmx92koc/ao8YBZlpdiP3y0bTtKiEGXK+cBUm1LepGazno
         9NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MilXQC1tGawrIwnXnA0XmAAAlHvsFkKNc4Mvh7VSPxs=;
        b=HjWEBGa+7N5L1oMTIWon9jKlEtRSFXTN1WMUeGLL1RzUAJL/3abVcbyGVoU/syOHev
         8+GW8vutFQ/0fEE6PHE+UXPN1T3Qu4EbkyQD0VnsUFEhIipPJ2tozx87k6qbMKRv1jFX
         c4LjCqjRnIGmtHvtorUwUg+Xq02yLvPwdIf5hRKYF6LH3OjU8Yakn0jXwkJoBhm3+uZw
         l9Wf95UpJHX8e4z6ZvLFwFcGh0ARcpFKq4DYIBV8aVaTplh01SfmVxEvvk8gnbf96gUw
         yv2uNuOFk5+lRdnb3cvIZ/kMUJxPhm23bmNpBLI6VIeUWQsMzgRvbni2R3AVSdHcw5fy
         FJ/w==
X-Gm-Message-State: AOAM5337ps/j+iDRj6VRGvKfBtvjI5T8QacI6fvzx8+oYRxhG6TX0KSp
        pAi9KJM3lMRQ2j4lReQdfx1A2FIxhaLpoVVD6ifOiQ==
X-Google-Smtp-Source: ABdhPJz2VpnF6zTkhx84UKodxUIcVJakqQ//DRrkWxRqYl0MzzRX8OVYvCgE7NDwXbJZGYG4FrIa0W6af6z45/zZZ3g=
X-Received: by 2002:a05:6402:22b5:b0:41d:7637:98b8 with SMTP id
 cx21-20020a05640222b500b0041d763798b8mr20229012edb.69.1649877747579; Wed, 13
 Apr 2022 12:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220413140132.286848-1-brgl@bgdev.pl> <YlcAEPYOBHk+NAD8@smile.fi.intel.com>
In-Reply-To: <YlcAEPYOBHk+NAD8@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Apr 2022 21:22:16 +0200
Message-ID: <CAMRc=MfNyzeZQ87n=Ley+7f9=4xxa_PTLcEbg7c3NXo7MLkGNw@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: fix setting and getting multiple lines
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 6:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 13, 2022 at 04:01:32PM +0200, Bartosz Golaszewski wrote:
> > We need to take mask into account in the set/get_multiple() callbacks.
> > Use bitmap_replace() instead of bitmap_copy().
>
> Good catch!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>

I've actually spent two days tracking this. I noticed that a single
test-case in libgpiod v2 fails sometimes (about 1 in 10 runs) and
suspected some race condition but couldn't find any. Turned out it was
triggered by not masking the bits but would only be triggered if the
memory which got passed to the callbacks got written over with some
other values than zeroes.

Bart
