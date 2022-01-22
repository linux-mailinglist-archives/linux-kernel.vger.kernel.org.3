Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6217496930
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiAVB1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiAVB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:27:30 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D722C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:27:30 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id h14so32359828ybe.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGeiYCzIjx2lhzwSMzR28GbXOwWiDHcobMRIQO65p78=;
        b=h+v0rj/pl4yxAXK5lL/gGQPb1SuX/Av7Jc4okkfdozMmxRxVmXvA8Fet20H8yGFWgX
         ba9Glx9lrjtU1UZNu9yYwyRCDfVRyaVoPeh5VIGTbSuJlnmQygcxhw6SLI9B2ET3S4CG
         F8flyThHOIi/lJ5CJzzrK/GOgOg+6LX0EMHDaPuRddCT9dJPI0CrE6g45eOuyqd30Ieo
         wPLF2aauGYDd9beKo1gk3492zXxeMN2WH+66Gjvj5B2JA3VeD1lJzYR+J/UzYjUP+RA9
         Q3F/4eeeVsfs+dKj2bvh/ptaR1ttvZNsejPZ+IgKb93MOdJ8nYk7FU4e8STI5vxlBS6v
         mAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGeiYCzIjx2lhzwSMzR28GbXOwWiDHcobMRIQO65p78=;
        b=cLjGE+xTRSplkagwtOW4DI1K6ATamGc8B4TG7a3FwxwGnAAbhIUym/r3i/248n89MS
         7qtuTu3iM2QWXjaja9HJXOVSHFP4lcuyivaMLFg0moUmv/cFgoI88C5fjEc+17aikIm9
         wI930e4/A+1iiSQG4zfCVg0viVt66WBZrPNvh/+2dr3sqwEswqFB4u452y2xkSFluzvr
         VBqOt+Nhrk/q27PHSm2jWe8WK6AVdcfX0l2qdu6JGDJdPWZ6lAup2cz/E+dry2cv+b9d
         fE096B2edZUwMvW2jZUqcA9osMVjD79pGp0EJ3ofSiwqAIdfYMvdq8cSsZ2B8lCSYD4g
         nGKA==
X-Gm-Message-State: AOAM531Y2APInlpwl3Kx4/jiY7zE911vOnK+v8Qqd+RNykkvYq/OLnic
        CSPvKzoQOREofAMMmz2Sr9kgZtGr1pB5NJ5tv/Vevq/9Cu4=
X-Google-Smtp-Source: ABdhPJyA7vomQVVrseYa/cL3cGwarZ7G7OGRfty6vQ64nnf04aRYjNBpffV+7peVFtjjC34iLWpFEsQzgOqonGWqn/o=
X-Received: by 2002:a05:6902:124c:: with SMTP id t12mr11062816ybu.680.1642814849460;
 Fri, 21 Jan 2022 17:27:29 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYquceSBrOsvO8rW9wmJA_RO=HSwv_waVoS=0hsP414T-A@mail.gmail.com>
 <YesxfEDbK/qFizFG@robh.at.kernel.org>
In-Reply-To: <YesxfEDbK/qFizFG@robh.at.kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 21 Jan 2022 20:27:17 -0500
Message-ID: <CAMdYzYrnahMuZTBjwNRrHnnNhn4wB7Ze=UA_HhzurqHC9U6oJg@mail.gmail.com>
Subject: Re: [BUG] device_property_read_u16 reads out only zero
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 5:19 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 14, 2022 at 05:48:52PM -0500, Peter Geis wrote:
> > Good Evening,
> >
> > I seem to have come across a strange bug with drivers/base/property.c
> > while expanding the new cyttsp5 driver to handle device-tree
> > overrides.
> >
> > With the property:
> > touchscreen-size-x = <1863>;
> > The following code:
> > u32 test_u32 = 32; /* canary to catch writing a zero */
> > u16 test_u16 = 16; /* canary to catch writing a zero */
> > int ret;
> >
> > ret = device_property_read_u32(ts->dev, "touchscreen-size-x", &test_u32);
> > if(ret)
> > dev_err(ts->dev, "read_u32 failed ret: %d\n", ret);
> >
> > ret = device_property_read_u16(ts->dev, "touchscreen-size-x", &test_u16);
> > if(ret)
> > dev_err(ts->dev, "read_u16 failed ret: %d\n", ret);
> >
> > dev_err(ts->dev, "read_u32: %d, read_u16: %d\n", test_u32, test_u16);
> >
> > returns the following:
> > [    1.010876] cyttsp5 5-0024: read_u32: 1863, read_u16: 0
> >
> > This was as of 5.16-rc8, using the
> > gcc-arm-10.2-2020.11-x86_64-aarch64-none-linux-gnu compiler.
> > I honestly am at a loss here, any insight you can provide here would
> > be appreciated.
>
> The property "touchscreen-size-x" is a u32. Calling
> device_property_read_u16 is an error though one is not returned here.
> You get 0 because that is what the first 2 bytes of the property
> contain. DT data is big-endian.

I figured this was the case, but I was hopeful the operators would be
smart enough to handle endian translations.
Wouldn't all DT numeric properties be u32, meaning
device_property_read_u16 and device_property_read_u8 are meaningless
on little endian devices?
Or is there a way to force smaller values in the DT?

>
> I suspect making this a hard error would break some users, but we could
> try a WARN.

I don't suspect it would be trivial to implement endian translation
for these functions?

>
> Rob

Always,
Peter
