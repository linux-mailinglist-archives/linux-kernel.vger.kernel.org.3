Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497454A5922
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiBAJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235902AbiBAJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:22:13 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A74EC061714;
        Tue,  1 Feb 2022 01:22:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jx6so52502706ejb.0;
        Tue, 01 Feb 2022 01:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zc0YUBbP4nO5xY/HXkwm2TEbGRUwzysYtK0Wp/4IoWE=;
        b=e7qSjd/0adrVrIIWN9p3EskCqHxGkJbwEIdTPOfRwrTlIc7VjHD1tc9nhYQNhbjaDL
         734EopB6UFXritQodtoOvtiP6KNtM0qHwnYOzQuFnhJlYtpmRXBzPMXC2mKN3wA5luj2
         VEPM1v47mucgLRp258bkjvaWtGo7eji9twznQncL5at5xnEUJ981gPsI0IZkVXHTaFxx
         LmAcAYA08Srh4owUN1WUl6LkVUNliUHlPzaZlmZFUGOUqpdmM5JsHCcCo1j/LsJIW7cO
         27syUfF3hjPpaIfvdWsScGdJ6Albm57lUtRA9DZhjjI4KbWdeWfVCFMCpsb9YQg69wbP
         fdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zc0YUBbP4nO5xY/HXkwm2TEbGRUwzysYtK0Wp/4IoWE=;
        b=6XbEyRJAGB1xhFbCoHdj2Vzv7OAc71vPN9jbmZwXpQNc0Ktcv4fxDlrxRjgTErXVJs
         zE1scN/3dAWwogcyoP9CKQsWPzm1NUUCFaYAIdYLqfPD4ODe+TfUCfuPri2BNACFFGCY
         zznY+V5sF0/B3vWNhcEKZHMsOWUsxzhOaT0ZgwvSNmG5Lb6A0QEbBNmkoI0lFEWUm7H3
         GU7U40Ym06JkmTexvBoVIJeSA00YjP/aFj4wEdwnmse88OcSjxlK7TdueV27TCrJ0sfy
         Bvwaj06dj7zdFBUnrxMywntDw4s0OsFYlGzIzmXdcbigNMey7KWFzpNAI5GmgRRSq3Sr
         99YQ==
X-Gm-Message-State: AOAM530+SVO3PfaiQympfDoZQokB40vG2ctNMidKJYtkzFPK5n2TGMnk
        RW3EyUnE+4Ky5YdTB+ToK91yp0QpQeIhsP1BK1i7QyhhKbY=
X-Google-Smtp-Source: ABdhPJyu5EUjHz+2RHbDEm3rZ1PYg19nT0J6+DbOVH4w0wgXGtwZxUwVQJH7+9NtCPS6zvJw6g3D4b2CRlVLsDwPwqc=
X-Received: by 2002:a17:907:a40a:: with SMTP id sg10mr20861269ejc.44.1643707331063;
 Tue, 01 Feb 2022 01:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-7-liambeguin@gmail.com> <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
 <CAHp75VcDMfnkRvh5Rmxqc_R0ML5Eq4GCFL_QAkess7OLAQkg7w@mail.gmail.com> <d9f3032c-539e-800f-289c-14971b7e3b15@axentia.se>
In-Reply-To: <d9f3032c-539e-800f-289c-14971b7e3b15@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Feb 2022 11:20:35 +0200
Message-ID: <CAHp75VdQyRrzYdTe5ak0Fyj2xDT2UVTwDMf+u9Y_6Hv-qMaPJw@mail.gmail.com>
Subject: Re: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 3:59 AM Peter Rosin <peda@axentia.se> wrote:
> On 2022-01-31 16:23, Andy Shevchenko wrote:
> > On Mon, Jan 31, 2022 at 4:50 PM Peter Rosin <peda@axentia.se> wrote:
> >> On 2022-01-30 17:10, Liam Beguin wrote:
> >
> > ...
> >
> >>> -             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> >>> +             tmp = div_s64_rem(tmp, GIGA, &rem);
> >>
> >> It is NOT easy for me to say which of GIGA/NANO is most fitting.
> >
> > What do you mean? The idea behind is the use of the macro depending on
> > the actual power of 10 in use (taking into account the sign of the
> > exponent part).
> >
> >> There are a couple of considerations:
> >>
> >> A) 1000000000 is just a big value (GIGA fits). Something big is
> >>    needed to not lose too much precision.
> >
> > Does it have a physical meaning?
>
> No, this is just a scaling factor which is moments later
> eliminted by a matching inverse operation. It's math purely
> about attempting to preserve precision and has nothing to do
> with the units of the values that are involved.

I see your point now, shame on me.


-- 
With Best Regards,
Andy Shevchenko
