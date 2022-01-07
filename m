Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5FC48759F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbiAGKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiAGKgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90773C061245;
        Fri,  7 Jan 2022 02:36:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id w16so20348573edc.11;
        Fri, 07 Jan 2022 02:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bY4JV8PvHANaCuy0WETi+VNSc7nLUtCARUT2kHvG5ag=;
        b=bl7zbdfbmadOtJ+Kp7IjDn3CTba7ItJMMRsnIfAePiKE+rqwUlWmP6Zck7KAWZD/2h
         +CiG+Yzr4Uqh403Wn8bQXpp/Av4XoisCd9bGuNg/pAIhpeNcQPyUcxYk0cgDHGGDU70j
         RGQdF7rwpwVIFwbbOYlgEzVgNRTavY5jh44Iqff/JfIlJavmXn5asWezjwXihjni/AbD
         sKDWQxyUUIauYiqLBRE3M9lGwtSLMnK85VkYn50Z2PNLfFv0PD6eromj0abSVQzNIUsO
         an/OtnJcKQpFPjik03MWaeXZ/HrheXejNwjwQG/yUy52Ch2YZCypZwWCO6wuLPLGHxw7
         15Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bY4JV8PvHANaCuy0WETi+VNSc7nLUtCARUT2kHvG5ag=;
        b=vA9ar+DmVTGoad6HC/IxeBcElMjSbfporgzK5JzSo9NvjhVM/Im46OeKMRI/bS+jGU
         4ikcoik+RBkO8i1UvNnqXmuqP8cnsqrbNpdLplS1kYKDbfJWkWFqEvIygqsGk/tYTLOr
         l35bCWL177/7sxVjgAv86p9PvmP8Ra5V4F8H+ejIPZgYQWuOdUNCFzBp3CLxFGdUgnQi
         BvLP+j31s6oyt/KMl9/jUGx4+Cryw7hgO+fHiXqNuP2Cjd7GGlXvsikF1kWJ2d5diCOM
         eVzk2DP70909fpTQYHSz2UJI5Ua5Hoe1ZN9mwA+rGqF9joAhYJN2V8o8XbZGwepnwuiz
         WvCw==
X-Gm-Message-State: AOAM532WLSI55nYUGV4EX/BVzsocqVho2sssEdqMTzN527s2JQEI6D8J
        O/+Kw8YLgdURtQ17qcUTATovOeTEAUhUIOwMhP8=
X-Google-Smtp-Source: ABdhPJwOxFpt5QqjsgvDKHf9uAjVZglIOQSSGBAYKxFBQEhaHuBPoCqrlXRvr4tEGaOXx/Rs2Aq1z7ryjFymAst10OQ=
X-Received: by 2002:a05:6402:4301:: with SMTP id m1mr60216587edc.125.1641551763189;
 Fri, 07 Jan 2022 02:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20220106041257.927664-1-kai.heng.feng@canonical.com>
 <CAHp75VdxV+4_yxJv1H1MZPpu02e2gHUkP55dduUqN7QJ2j6aGg@mail.gmail.com> <CAAd53p4nUDtuVmkFCqv2R1KEvGYQyLu+ibxJOsoUZs-SM6LuHw@mail.gmail.com>
In-Reply-To: <CAAd53p4nUDtuVmkFCqv2R1KEvGYQyLu+ibxJOsoUZs-SM6LuHw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Jan 2022 12:35:26 +0200
Message-ID: <CAHp75VdXw-G_zSkC7Vzyjeo-aV7Bum=birMMmR8UGsx+e43-bg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: humidity: hdc100x: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Chris Lesiak <chris.lesiak@licor.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 6:14 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Thu, Jan 6, 2022 at 10:33 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Jan 6, 2022 at 6:13 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:

...

> > >  - Change the ID to follow ACPI Spec
> >
> > Is there any evidence Texas Instrument allocated this ID, or you just
> > created it yourself?
> > Please, add an excerpt from email from them to confirm this.
>
> Sure, let me ask our customer to provide the excerpt.

Thanks! This is basically the most important point of review.

...

> > > +               .acpi_match_table = ACPI_PTR(hdc100x_acpi_match),
> >
> > It's the wrong usage of ACPI_PTR().
>
> Can you please explain a bit more?
>
> ACPI_PTR() turns the value to NULL when ACPI is not enabled, seems to
> be correct?
> Not to mention most other drivers also use ACPI_PTR() for acpi_match_table.

ACPI_PTR() needs to be used along with the ugly ifdeffery (#ifdef
CONFIG_ACPI). Rather not doing both simplifies the code and avoids
unneeded macros or attributes (as you suggested below).

> > >         },
> >
> > All the comments are applicable to all your patches. Some of them I
> > already commented on and even kbuild bot has sent you a complaint.
>
> That one should be solved by adding __maybe_unused to acpi_device_id array.

This is illogical to add an ID table that we will know may be unused,
don't you think? Better to always provide it. Yes, the downside is few
dozens of bytes in the module even if it doesn't support, but OTOH
this information still may be useful for users to know what devices
the certain module might support.

-- 
With Best Regards,
Andy Shevchenko
