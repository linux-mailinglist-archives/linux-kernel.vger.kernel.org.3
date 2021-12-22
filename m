Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C0747D740
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhLVS6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhLVS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:58:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00858C061574;
        Wed, 22 Dec 2021 10:58:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so12282475edt.9;
        Wed, 22 Dec 2021 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ppTWoNw/SvYfQ8yN9sAbiCb5gyXtWnMFHU4MmkszZk=;
        b=I3fvn32nODrKGIT7BE1xY0AvSp69lNgwMNmJlOjht6+LJDFHTnXoNAf2/22fTlb6z3
         aYFI6rFNxqc9L0uRWsyxRZKcI6JqwG7n46ws+s2EaPDC7+S1KYYWfl6l7deB/93hpDOi
         CaKLs4uWIHDMWF3l7wVhPKq8Ipa4yZpc1GigxOTHichXlFnRkP+STphTYr4qEmTkJnA7
         n2ipTQDhBvZbbPkpix6E2rCDI54PxS48jgES66drhNUYrE5CTtDtKkTU+hF8GmF5XeIa
         z9x0VbxOSUHP5W4ZZp44Zb9OZrQxWeq5fYUZJL6yeHLlzBL/8BiW7CGTijFRS7FxNnef
         NJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ppTWoNw/SvYfQ8yN9sAbiCb5gyXtWnMFHU4MmkszZk=;
        b=08YYAZ9pF7m0363R0UWRecDFksvYk78LfqSpUVazegTk6hWuJQQqtL1WK2aWualYrk
         hOyU/D83Oq3YTcL6+8lJ7ufbYAhwyx8KWiAbdtEFPZbUF+aYbWlCJRinJMeYqVkBvmp+
         xUEn+9mYovsJF/ezckcPeqFQz7uAbCjeFF7L0HqwHQKiJzULjYoCl4ZGspEBIDiBA0rT
         AjPSQHXkPI304/yyZfIzU8EsGM3SBOT8D7SqPfltNICKIPxbJ1RqHCXXmd0JUvu/r4sT
         w87FfORhQX0aiKUXQw8K3bXBRSzVBB3UUMY4RQjrXxhnjxMcepszt+noXbUfV+YoPg8n
         FUNA==
X-Gm-Message-State: AOAM531+7+iSjW6JY2JHkELK6pU8rfcyi2wnHE/Px+rk0TrzpHUUH4zn
        OffWoKEiuiAt1BrWYba+KN01WgKHhTsNMIlrvT43yOd5TJM=
X-Google-Smtp-Source: ABdhPJzETwlP1NAvbuZy6XjI89z/T19jmu3VOi2WR34ilGYFKNh6vSRJfKdGeejiEf1IaLiuFoIDPD/dwz4YR7ajVzU=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr3451905ejj.636.1640199490574;
 Wed, 22 Dec 2021 10:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-10-liambeguin@gmail.com>
 <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com> <YcNwt5RFMNFUimD/@shaak>
In-Reply-To: <YcNwt5RFMNFUimD/@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 22 Dec 2021 20:56:12 +0200
Message-ID: <CAHp75VdrLTNLWZRgWkLXD23RAF28zh29XybywAPyMtb=GNxXbw@mail.gmail.com>
Subject: Re: [PATCH v11 09/15] iio: afe: rescale: reduce risk of integer overflow
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

On Wed, Dec 22, 2021 at 8:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 02:29:04PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:

...

> > > -               tmp = 1 << *val2;
> >
> > At some point this should be BIT()

Forgot to add, If it's 64-bit, then BIT_ULL().

> I'm not against changing this, but (to me at least) 1 << *val2 seems
> more explicit as we're not working with bitfields. No?

You may add a comment. You may use int_pow(), but it will be suboptimal.

> > Rule of thumb (in accordance with C standard), always use unsigned
> > value as left operand of the _left_ shift.
>
> Right, that makes sense! In practice though, since we'll most likely
> never use higher bits of *val2 with IIO_VAL_FRACTIONAL_LOG2, would it be
> enough to simply typecast?
>
>         tmp = 1 << (unsigned int)*val2;

No, it's about the _left_ operand.
I haven't checked if tmp is 64-bit, then even that would be still wrong.

-- 
With Best Regards,
Andy Shevchenko
