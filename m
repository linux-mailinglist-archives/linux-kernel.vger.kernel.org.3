Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C004488982
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiAINLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiAINLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:11:14 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2349C06173F;
        Sun,  9 Jan 2022 05:11:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so42558434edd.8;
        Sun, 09 Jan 2022 05:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9sT+dpb/1t36dNBjxze9Hu6gYpZTJ3fNrdbt8q/W9pw=;
        b=YPsY3VAaAyHaFQX2GXJHn+wx5EfC4zEtwVTFgoyZcK7kGymn7ycxvKrhdeRrl01Lry
         Afn4Qv13X3K1wfJpbFLZtsO0kEF5sipnt28NhP70d9RJ1oAZTdf3D2IEIZH+nhVav0A6
         uLLZOzcQ/+qTjw37aCcW6Jrj5qPJBXMuDzOqtySc8q6mj2Kh1DPEnjV0x+bGwtAo4S6J
         xwqVpuisnruJamAAWdYGD5Fl+0uX/63zT7mjHPhn+jXz4r/86YGPTVMzg7vmiOl3Bqfk
         cELuMBrDRG9wOoflXuGuQwShvnkWnM3ru9/4opDMKbAvWjQKLDxr+PxCojaQkmaNCPRQ
         rfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9sT+dpb/1t36dNBjxze9Hu6gYpZTJ3fNrdbt8q/W9pw=;
        b=7xQ7bv7Jn3qx6zQXUUOM6cMdHzF3mokCyg/uOkNtkiqDeFPKiVcBnAPNVUm4Y+HKr8
         2sa0OR2NeqtSe/2g0H8tb/tWr//brudi9xUP1po2/jKsFk/kgi1WwOGZY8VCMGOEvJ9Y
         rtV5fvP7bdTTMDb0kzzLmbWuTqcnrQUe5bDHA0YMKFot19fmak6ZdKvIlQHTDPcUgoZG
         TzQKaxDEo0/stO+kuP3SNOvG32JbuKStoAegEZDVwvSbWZeaWPRGz0Ye2loL4OuPbPSu
         64MsHcfv+gaZJVi1+aVpjqGDvKIxYcl/IjNiuf5dhucSB7e/rloWej98uv+GEzBSw2QJ
         D8Vw==
X-Gm-Message-State: AOAM533pmeYBNq2WjkR60j2Mj7xHKDXzaR0BYGYfRb187VlApdkWwLEr
        9QtpRo5KWLkFI5eKMw62qKmky3e7p97DofHFiys=
X-Google-Smtp-Source: ABdhPJx7WMLDWrRi1aWvhnM+drgNhn21HtaSKKh+QEW/7A8V8Jgz89jDDOXzCSSRJQIn5oUdzxmk9VCN+7UhnM1IvrU=
X-Received: by 2002:aa7:d9c9:: with SMTP id v9mr12628372eds.270.1641733872420;
 Sun, 09 Jan 2022 05:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20220108205319.2046348-1-liambeguin@gmail.com>
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 15:10:36 +0200
Message-ID: <CAHp75VdyujSuTCr_+oFP9t=tardioG69k7uNkBSRAmPvqiyT7w@mail.gmail.com>
Subject: Re: [PATCH v12 00/16] iio: afe: add temperature rescaling support
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
> Jonathan, Peter, Andy,
>
> I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> the rest of these changes pulled in, but I don't mind adding a patch for
> that later on.
>
> This series focuses on adding temperature rescaling support to the IIO
> Analog Front End (AFE) driver.
>
> The first few patches address minor bugs in IIO inkernel functions, and
> prepare the AFE driver for the additional features.
>
> The main changes to the AFE driver include an initial Kunit test suite,
> support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> and temperature transducer sensors.
>
> My apologies Andy for misunderstanding your left-shift comments, I don't
> know where my head was at... Thanks for your patience!

For the patches 1-5
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Jonathan, perhaps you may apply them, so Liam will have less burden in
the near future.

-- 
With Best Regards,
Andy Shevchenko
