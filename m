Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF4589225
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbiHCSUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiHCSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:20:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E917B8D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:20:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so9780156edd.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JeHaDzN/T9zdt1E9cU7smMk5qHhPya55JjFdlrzIX3k=;
        b=INEoSC/YCw3s0xEFuAjl0FudzzmuGidy2wORHUKeRKbiAv+sdeLAK126e8JnZOEm8f
         lPaM8d4pq7XXTUiUXuehFxy4hrObhxiXPOj2Laebe2J3HPkm3NTK+HWGkTHvLPQM1FyY
         MOu6Bo536E1qirme7EQHr4yFhvgTa7Wc5tKGrjlaU4Fl0kFSeZSB0LGks2cHnbDK8DHX
         Nu3VrOJa7A6P68X8QYXjxutD61il8TJqTZJTHnnpGDrUfBv/hHRjbrtpVU9/9pNUL49d
         tZJfgnL4Wy0XmtyIlbNE18Uis7dUnCnpglAlnCvEKIW+xkCbZWYJ3oFh6kIYVbHQ4iXc
         S3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JeHaDzN/T9zdt1E9cU7smMk5qHhPya55JjFdlrzIX3k=;
        b=z+kqfpbfbukxp02r/9WWdhNTwKt6h0Io8hG/BqF7Or27ALpx3gp7W0FGxmAgYeOHX2
         aWulwIqy1V/i7wAT+77JQIIzf7hfV57pVfWAHp6de45DDZzm7dfugCkjk9h5tNASIZUH
         iWICA3LJ5l3IRJbfs3IGE4+bHWU61y18PYz1P8eLTPkXSKhd9AIVHiGTc63B57NqXKBM
         8W3QjNaPn3VjQtB2IqvzT/XUH9IVpo+qcj2S3vwBuzWrQICn2g/5P6XDX2YlxskCl5Wv
         xgKNP2yWB/J3Xr4tuRgvGwcv2dy5XMFQxxSS0RnL27YuKTNqGQrlceQV6zHkWKVrB4Ac
         pKLw==
X-Gm-Message-State: AJIora8T7qh0eErajrcTKuO9xDJvCToZKwRI/JD14gGzVZ5LD+smXIb8
        JV1oWRUjTmvev6sPQc0+AsgzhS2eaQ5NE59NQqIesQ==
X-Google-Smtp-Source: AGRyM1uw+GUcF1PBNGZ+q2q8x91Y3dvl1Az8jAlzFKrDCz9xMYEPtSoRsJ5BxJx8t7vjgHLnRd2FNNGAmALekLTWPhQ=
X-Received: by 2002:a05:6402:5384:b0:431:6d84:b451 with SMTP id
 ew4-20020a056402538400b004316d84b451mr26628094edb.46.1659550811827; Wed, 03
 Aug 2022 11:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com>
 <20220731170057.2b8ac00e@jic23-huawei> <6c839ba3-b671-76fb-95e1-94bf2f2da303@gmail.com>
 <20220731211743.6ab9264f@jic23-huawei>
In-Reply-To: <20220731211743.6ab9264f@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Aug 2022 20:20:00 +0200
Message-ID: <CACRpkdZF3AOurSnhEVSLrPmJOnU-+ZjtnA7G=QQ5sY-TUdKi0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: Retry ID verification on failure
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2022 at 10:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com> wrote:

> > Based on the specification for the sensor I have and also driver used i=
n
> > Android kernel for my device (it uses a 3 x 20 ms loop) I think 20 ms i=
s
> > a good value but to be sure a slightly longer might make sense. As
> > suggested in the other review comment by changing the regmap_read to
> > regmap_read_poll_timeout the function doesn't always need to wait at
> > least 20 ms in case first read doesn't provide the correct value, if a
> > suitable shorter poll interval is used (something like 1-10 ms).
> >
> > However testing on my device has shown that I still need to have a loop
> > or at least a retry possibility because I have noticed a rare random
> > read error (-6, happens after some time not at first read) when reading
> > the id from the hardware. This could be due to for example internal
> > init failure of the sensor chip causing an internal reset. Because of
> > this read error regmap_read_poll_timeout returns with an error and
> > without retrying to read the id the sensor probe fails.
>
> Nasty. If you can get a confirmation that it's a possible failure on star=
tup
> from the manufacturer then I'd be happier with that justification to retr=
y
> rather than just sleep for say 30msec after power on.

If the power comes from an external regulator (such as a fixed-regulator
on a GPIO) it could be that the startup time for that regulator is incorrec=
tly
specified or unspecified (startup-delay-us =3D ... for regulator-fixed)?

Else I think if the a vendor version of a driver for this HW does this quir=
k,
that's as good indication as you will ever get from a vendor. Do you
have the android driver source code? Or is it a userspace blob?

Yours,
Linus Walleij
