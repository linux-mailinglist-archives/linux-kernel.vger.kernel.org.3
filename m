Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A262747F3AE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhLYPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 10:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhLYPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 10:55:45 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94325C061401;
        Sat, 25 Dec 2021 07:55:44 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y22so44195727edq.2;
        Sat, 25 Dec 2021 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DLKSeIndgPjjCOxHQScvibLO8kHejdBM84u4yhRKdw=;
        b=efMBR7Wv4GAWbKS2UyH6Oe18HGl6TZsQkmr4gxKou4wN3lF0Jn/PgMluFfYBDkLAcd
         TjYCep5KnKP80rNKIpdZfwK1lto9zvuGYlqWrPbyBIz+9PfEkHG7jjGDF67WdSw6JZym
         6F6hK3H0bfto+6aSIMiTPXO7uxnGxfuXfB41qGkTEEftkYsLsDOn16zdBYPK9FbnBiVP
         AgbemA1Swu0KSSKD50Kpzjot6AaVySKMKKmDjSuVUF3lxkw2X8xBl6A6g0+QwlJ+o8J6
         LOnmFjn1OO97p3qJM8YP76QNso0zOPCYnnk3EAzwB68QmhnWZghDaRqeG/LL4QQ91dl8
         W1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DLKSeIndgPjjCOxHQScvibLO8kHejdBM84u4yhRKdw=;
        b=GalQvyTFJkMAG0Bi2M0EbY66KLWPaTg/6clsPn/NeD6Pxsm2kheB5JkozPUtrhvqqn
         FE+9LOMb/NadRAK25GvXw0TaQ2N1fOhgrXRJKyFhnSFrusEeXiX2Eyek5NdUvew6kQHL
         HPy1uxN48lDnB6KgDdKZd6QTvdf9T9voa/9/Hvye3RFjAU0H7psEVAMEonYHjAHCmm5y
         tXr5loRFzzYFtqN73apkb+nXNSciuhABOalW0QsVNUy8p41ZuGn4PMu9gh01+pqC0Ian
         U5dEV6DQRNJwBvJF7Jpw8sBPonxkkt4E/1l1XTnAJjOob5a36wUv/7IZ/31xM/xpMIQU
         287g==
X-Gm-Message-State: AOAM533rS+7f2Vgo3RnyIKg+a7PfoClFe4HIELG7Mjlhqt1k+sCmBiL0
        c0huBd4Yq0BVSwYgoedoE8GHhuB9LD6pyWUqQfE=
X-Google-Smtp-Source: ABdhPJwvpIDYA/WqYlyPJTUhlOBXSVWk8jyw6JrS/Xc9bguueysDQYyaQEjMk1rn+UMrYsIPvpeZdb/J/nzALyEFghA=
X-Received: by 2002:a05:6402:12c5:: with SMTP id k5mr10006635edx.296.1640447742716;
 Sat, 25 Dec 2021 07:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211224194649.22328-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAHp75Vd+84qyTzPc=Tkhz2cxkVv9Y+ME64XO6btXq=RmtWUxZw@mail.gmail.com>
In-Reply-To: <CAHp75Vd+84qyTzPc=Tkhz2cxkVv9Y+ME64XO6btXq=RmtWUxZw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 17:55:06 +0200
Message-ID: <CAHp75VcubOLjXGCyh95zcDGNryAorO_WcgqeK0Vq81DsXSHW7Q@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 1:41 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Friday, December 24, 2021, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

...

>> +               int irq;
>> +
>> +               irq = platform_get_irq_optional(pdev, i);
>> +               if (irq == -ENXIO)
>> +                       break;
>> +               if (irq < 0) {
>> +                       ret = irq;
>> +                       goto error_unregister;
>> +               }
>
>
> In all your patches which introduce optional IRQ please change the logic to the opposite:
>
>   if (irq > 0)
>     ...we got one...
>   if (irq == -EPROBE_DEFER)
>     ...return it, if it is ever possible...
>
> With this you adding me a work.

I noticed that in some patches you actually do the right things, so,
please do it in the same way where you use _optiomal() variant, i.e.

if (ret < 0 && ret != -ENXIO)
  return ret;
if (ret > 0)
  ...we got it...

-- 
With Best Regards,
Andy Shevchenko
