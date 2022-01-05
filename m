Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33204850BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiAEKJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbiAEKJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:09:46 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F5C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:09:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id j6so159742769edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 02:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goUHNsibMsGCOASgzWIWYMSALsP5wysEG0QPSAMZCos=;
        b=KW7inX3L+wA77LAr0fKw1GCBvfmEfX1wh72E1svOkqoiVB4NS4PT+FhMiA3o1Id8Bc
         ThF0KfSRTqRmBJYbK3NNjpqaD3bVayQewaEUSotC5ahCGH2YbQFk6UT6pQKZclD3YxSt
         gxwxRrFYJpm5AKtGQxMP9TBXmpAe2F+EV2pEDsCRoK49tI9lNmU68Rc6wAIUEt1hK237
         DTeI0WMX/uELB1xEiEdsN63dZWQVX8uuLmal/DhCiDQ1kTWuilHE4qLdkERZVyGbm4dU
         OBaUtjrgf74vYfJoNpY0/W3JHb7daFb2xvnvqEIL+MijgeQyDt9gk1lN5UprfBSe1H7s
         qq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goUHNsibMsGCOASgzWIWYMSALsP5wysEG0QPSAMZCos=;
        b=z3c4DH54Xk6BgzT3m5kFVR2e99gNZU2xcS5iwvSymxdG846mxIRQD1UAwBbfgEHE0A
         nY1on4k+luu7hcr/ne3bgg6le2iNkAjeONxiIDbnStYcSxaCKhLR01rr7CvwT5HSjilR
         wxclUiGthwF+YWYhSG4YHsCMnTV7ab3IV7V6Kjeji2dcC9KNKkcKGuxMiXps+o60SkpJ
         bo2Jbp4X2Y31e35XR0y+kTvdvOsXkloXMeg+3bfsI5jLm3wyTLMTXw+asPuXn7xhQ1uR
         qSiBF+6AnbDwQVKojmDmGr7ijSoxaYO99UGfJut0gXeUID3370Jr8uPJz4h/HtOy7EmP
         xhKw==
X-Gm-Message-State: AOAM5336NbkesvaiWHUwDVuaFRPLY0P6Gd0A/ADa5fyDp3T0GNuhnjn5
        9kxwWNRqNzzmBbyTizJh4UguLyNf1e0WKoen7vy5llhOJ47i0A==
X-Google-Smtp-Source: ABdhPJx+p/D5VKfBeRo/iV8ePOGH1nb2taw2GjNrRB/qFmz14OJfyi+FZELPQ2aF4klKl4qEtp9vld399fgjQ6qXp1w=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr41387442ejj.636.1641377385174;
 Wed, 05 Jan 2022 02:09:45 -0800 (PST)
MIME-Version: 1.0
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru> <YbJhu53WEmotslox@smile.fi.intel.com>
 <59f08001-7e1e-7fe2-28ba-045972bbae90@omp.ru> <YbM3T29wPZFLMu1D@smile.fi.intel.com>
 <8a415980-990b-abae-6f60-dedd0c199583@omp.ru>
In-Reply-To: <8a415980-990b-abae-6f60-dedd0c199583@omp.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jan 2022 12:09:08 +0200
Message-ID: <CAHp75VddS225riMvTD36M4UNKC=zKYLCmUdJsACvWbf7=8CqRA@mail.gmail.com>
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 9:40 AM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
> On 12/10/21 2:17 PM, Andy Shevchenko wrote:

> >>> Wanna help?
> >>
> >>    No, I'm afraid you're on your own here...
>
>    Tell me please, how far you've got with this by now?
>    (I've already started to add the fixups to your patch -- unfortunately, this change has to be
> done atomically, not piecemeal.)

I just returned from vacation and will have another one soon, I don't
think I will be doing much for the next couple of weeks.


> >>>> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> >>>
> >>> Not sure.
> >>
> >>    Why? It fixes gthe IRQ0 problem, so that you don't have to check for IRQ0 in many callers
> >> (for the subsytems that treat 0 as s/th special, like polling mode)... If you have something
> >> to improve, you can do that atop of this patch...
> >
> > Because first we need to fix all users of platform_get_irq_optional().
>
>    I still don't understand why your issue should be fixed 1st -- but I don't really care about
> the order...

See my other comments on the discussion.
The rough roadmap is:
1) check which drivers are still subjects of vIRQ0 which is retrieved
via IRQ resource
2) fix them accordingly (for example, by transforming to IRQ domains)
3) convert platform_get_irq() and Co (including optional variants) to
follow the pattern
 a) non-optional APIs never return 0
 b) optional APIs return negative error, or positive vIRQ or 0 when
IRQ not found

Alternatively you may put a big comment in the drivers first and use
platform_get_resource() for retrieving IRQ0 without WARN(). Then they
will be subject to fix later on.

-- 
With Best Regards,
Andy Shevchenko
