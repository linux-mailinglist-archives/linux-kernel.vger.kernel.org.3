Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C015A48897D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiAINIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiAINIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:08:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417BAC06173F;
        Sun,  9 Jan 2022 05:08:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 30so40946672edv.3;
        Sun, 09 Jan 2022 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWHbjPtcVR2yLhFXLToA2Y4vWx0ZPRaE9GL7xijArNU=;
        b=YLvZj1lGzDkVk7NA++e4C0k7gNYL3JHbkm4aMLEnE7pZG323V5dRn+Ilu3/LFWO2jI
         bBGmvygwElsUYg3j0ghKbtKN/ahoscH02zxRc791burgP4kArywUr1lu3iEAK0ValPV0
         OybGeDt3j3jjYPNt2FrPREoDlgGAMRnmqwn4oqx5Mt+viTFJ3IxnmmpebzNMiyVsbsym
         I3FRKT7JsexGzOhA81G5+METWIqhQBLpJAjUPhcpW3J79ZjQWS9F67+5S+jXf+2Mwro3
         ZhtJLXIiMBDOsLUnc2Ji8opXREkBxMJUWE2xkRpvrjOn6DanF0pNhwp+YUYcMsymafSX
         5IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWHbjPtcVR2yLhFXLToA2Y4vWx0ZPRaE9GL7xijArNU=;
        b=5p2oLHxYsVjXfK2mSnYCbJPT6sLw6XtXb8Krg16vzrwhjFEu3PriW7Q1f/rSubWk59
         5EWeYbbT2zmky2ouS9YuuoCwQe17bQHxQ/VnTjoVfdECgBFg9jXkImfRac0ZMHeAVzr/
         niQFXWxVpVwkW8LADZ/1/eWJyDK8vclcRwS8PUuoXpCYgWU/DjQZ+RxWmOG2t5EyOh8t
         z3HdlNvPrN9ldWxTVr6LOhJb7NR9mJZY59xUJClm7kqDVwAnheJWUKIs1MFN4T3ltiao
         jbRdtzg8E8qwgi+GGXgxSdVqUYnB3/XRCyPQI8G71A9zdfCj+j8bLyjZn+xUieartL7T
         RjaQ==
X-Gm-Message-State: AOAM531j12EzZHFwrEOcSfLFg85d/hpf+hjg0WHWsN01yzqLTnMR2vHM
        ZU/5vua6UYbB9ygo3HBVVqJyjQKgykR5rJKMDZc=
X-Google-Smtp-Source: ABdhPJy0uP18acDGeCB7QGpmvkx1E+SfpYGdZtXncQG/FkPZcziciKjJI0nUlX1gpN2icsnJnEms4UfGwuzCjWRBEFc=
X-Received: by 2002:a17:907:968c:: with SMTP id hd12mr8127490ejc.639.1641733714836;
 Sun, 09 Jan 2022 05:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20220108205319.2046348-1-liambeguin@gmail.com> <20220108205319.2046348-7-liambeguin@gmail.com>
In-Reply-To: <20220108205319.2046348-7-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 15:07:58 +0200
Message-ID: <CAHp75VdVBQPG0Qbo9H5Sro0-Uhr683WhWor9P2MXZ5a18HfRgA@mail.gmail.com>
Subject: Re: [PATCH v12 06/16] iio: afe: rescale: expose scale processing function
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>
> In preparation for the addition of kunit tests, expose the logic
> responsible for combining channel scales.

...

> +/*
> + * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
> + */

Despite the Rb tag by the author of the code the above is wrong.
Please do not steal others work :-) (The smiley due to my believe that
you have done this undeliberately)

 * IIO rescale driver
 *
 * Copyright (C) 2018 Axentia Technologies AB
 *
 * Author: Peter Rosin <peda@axentia.se>

-- 
With Best Regards,
Andy Shevchenko
