Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CB47F40B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhLYRTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:19:20 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55343C061401;
        Sat, 25 Dec 2021 09:19:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j6so44523606edw.12;
        Sat, 25 Dec 2021 09:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJA3WfysotzaqCeVLZSb+ucAA1krJKLmLx5aGtN5mww=;
        b=e0c193T5X85Fn9j06uF4QUJ7QpH7IB7SvGmkjwV/fSpoW+aD0rkvwm7lpdZ0bXMQbR
         HyQJyNAEGgLPZArJouxNhx2TAr2rvOTer/yzfr/tlx6BZbpnjQIQNi6QAb70+xvtQCoO
         N12XSKpdmWIpOgLQ1HaR4s4Mdwv3KSbDtV/wupoScGpCq5+ixALgH2y00MGs3o3lXT77
         2B1KG6JMM4tfBcome89WWGwIdopjHvt967ZFwei246Z2pHpymedIYY3yyJcf7EE0Vq8O
         MBttxCUtFbdDXZbCE+mnH2+CY/iVr8wJgQ2pwOdXLEQx0poiGVWkXcGLQtwiMtG7gNj9
         dSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJA3WfysotzaqCeVLZSb+ucAA1krJKLmLx5aGtN5mww=;
        b=11KMw1deetBSG26I32yDxuNoVrKF7d9haaG6MlDVzsbnkByTle4Z/lXYzhQ3B9JAjl
         MfmU19swNnXy5Jg3p8Bokh6r5w8buiFsRhk29ZwF3/MKaGt3tOingLGb8d03+MASPfF/
         F7tGcfk3nZR/HZY+ayQFU7qrzAL8viQHYpXsWSg/2Rq3/8NmTGJ4kxJSlXwsvDvo0Swh
         9r8Yo4bPb9Rn/bBGsi4+P/S45MXlfn0ZT6gn4Cb57ViZD2UbAP7Uad/okSCFiSRELBn/
         Ze2RWvSDt5FpVL9IlW/tU/upB2/W7WH8cznB9F3jFHXaX9Kp0rn3GRRDGrxy4DQZCNSl
         iN6Q==
X-Gm-Message-State: AOAM533FlGQarsn3APkEjVzqissEwwxgQPnB0C3Bq+0jIsJANX9vX1Ja
        rHPvp9zqYa8i6kHXeLMZb3osA4coInXtyl/4JH0=
X-Google-Smtp-Source: ABdhPJwWjhiZvdUS+Clb7u1rhW8c59lTWF0nlQc6NYJcqrlQX0RUV3YaIEvlgrlF66xEwFMv6pSybTEs+n8rDPxzqsc=
X-Received: by 2002:a17:907:97cd:: with SMTP id js13mr8687077ejc.497.1640452758830;
 Sat, 25 Dec 2021 09:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20211224202231.31130-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAHp75Vda7LTR=8eUki3yXEk5ia8va2Ma6Pqgj-4v6nSphNZjow@mail.gmail.com> <CA+V-a8vj30jPdXQ8PhFuawiNab0UJdiN8D6mh=c4mNGchTFfhw@mail.gmail.com>
In-Reply-To: <CA+V-a8vj30jPdXQ8PhFuawiNab0UJdiN8D6mh=c4mNGchTFfhw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:18:41 +0200
Message-ID: <CAHp75VedY-xwosQJ_KttdsTFnyTYwCTtavBOh7QU_99_3949vA@mail.gmail.com>
Subject: Re: [PATCH v3] soc: ti: smartreflex: Use platform_get_irq_optional()
 to get the interrupt
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 7:10 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sat, Dec 25, 2021 at 4:56 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Dec 25, 2021 at 4:08 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:

...

> > > +       ret = 0;
> >
> > I do not see the context, is it really necessary?
> >
> Yes the change is necessary as the probe callback returns ret on
> success, and in the below code flow there might be a case where ret
> inst set. So setting the ret here.

I can't believe this, so I have checked the code and it seems it uses
return ret at the end where it should be simply return 0. So, please,
fix it there.

-- 
With Best Regards,
Andy Shevchenko
