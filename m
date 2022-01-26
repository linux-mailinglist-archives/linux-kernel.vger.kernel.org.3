Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D5A49D587
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiAZWhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiAZWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:37:21 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B68C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:37:21 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id u129so2463943oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PifLMi0zlGTgQS9puH7XvyhNJKKGKBmnkxGjrrgwy5Q=;
        b=GmUR4KytawYOJqKRpnN088ETGAv0pHwfsXThUth7+jNbCxxZ7WKC1pSlHNC372YjB7
         3moR9FBbLK7Hy5tlWLYW2rmXU1yacgo1jR2KEJoSMCFTG9XzYfw5Q5gEmjHFK1hKj+jh
         brZH8ZXPAHAd6XcjvmokbcJL22NduYNXI+9xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PifLMi0zlGTgQS9puH7XvyhNJKKGKBmnkxGjrrgwy5Q=;
        b=lVZ0xWO8qugn7Tr6dm16LiVBYTcVpWhlBxylK7fL6MHdjXQfvs90nrXFIO5gwQAYst
         U3OQpr7zjjF1edGpV0eoAIGpgo1qiG3qkJpxjlTSSIqtLE3SLLno8FZ3jSFGvrW89IAS
         axEY/WPaoC3nzuTUiN7v+ld+pifGg1RYH2qFK1TDMHL7jxpNdS3C9cmRxtRdGpQp2zcZ
         qtO6lcdBsZ7K+Hom3eURAVbpqNwIVbc5lIVpNfMMOv7nPY57lCzjlln9hlRd1Vz7Q8S2
         43woHuqDgfKnkc67fN4BWigdaQc9mGlRu01KMDhSdjdG3KXmOCaL4v+o+ZehLV3b4HoB
         MSpQ==
X-Gm-Message-State: AOAM533RvusYhs01qH6w6dSmJbNhCELAf57PaF4USHkqa4XesrvT0PxQ
        EmFo5glhj95yyK0Hkfb3b/npzKTYMFZ2IzAhWirJXw==
X-Google-Smtp-Source: ABdhPJynVYV2Qw40URajg8X99oS9Kekj6o6l97S3dWfHfSque0qeESj02QYmiIRzacI/nhXJ7inCFFpWeT+C9NYUHDo=
X-Received: by 2002:a05:6808:1406:: with SMTP id w6mr501539oiv.330.1643236640611;
 Wed, 26 Jan 2022 14:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de> <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de> <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <YfFMSkhbvHaR0YNE@smile.fi.intel.com> <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
 <YfFWmmJFtEB93jUi@smile.fi.intel.com> <3430838d-1c63-da49-b774-c5a883e7085f@redhat.com>
 <YfFZkgE3wfPXLpYA@kroah.com>
In-Reply-To: <YfFZkgE3wfPXLpYA@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jan 2022 23:37:09 +0100
Message-ID: <CAKMK7uF=75vCS1z4wfvEdGEaHu9-Uxpyu94Y4umbXO9ihBhbvQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 3:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 26, 2022 at 03:18:14PM +0100, Javier Martinez Canillas wrote:
> > On 1/26/22 15:11, Andy Shevchenko wrote:
> > > On Wed, Jan 26, 2022 at 02:47:33PM +0100, Javier Martinez Canillas wrote:
> > >> On 1/26/22 14:27, Andy Shevchenko wrote:
> > >>> On Wed, Jan 26, 2022 at 12:18:30PM +0100, Javier Martinez Canillas wrote:
> > >>>> On 1/26/22 11:59, Helge Deller wrote:
> > >>>>> On 1/26/22 11:02, Andy Shevchenko wrote:
> > >
> > > ...
> > >
> > >>>>>> P.S. For the record, I will personally NAK any attempts to remove that
> > >>>>>> driver from the kernel. And this is another point why it's better not
> > >>>>>> to be under the staging.
> > >>>>>
> > >>>>> I agree. Same as for me to NAK the disabling of fbcon's acceleration
> > >>>>> features or even attempting to remove fbdev altogether (unless all
> > >>>>> relevant drivers are ported to DRM).
> > >>>>
> > >>>> But that will never happen if we keep moving the goal post.
> > >>>>
> > >>>> At some point new fbdev drivers should not be added anymore, otherwise
> > >>>> the number of existing drivers that need conversion will keep growing.
> > >>>
> > >>> This thread is not about adding a new driver.
> > >>
> > >> It was about adding a new drivers to drivers/video/ (taken from staging).
> > >
> > > Does it mean gates are open to take any new fbdev drivers to the staging?
> > > If not, I do not see a point here.
> > >
> >
> > Good question. I don't know really.
> >
> > But staging has always been more flexible in what's accepted there and
> > that's why some distros avoid to enable CONFIG_STAGING=y in the kernel.
>
> And that's why if you load a staging driver, it enables TAINT_CRAP in
> your runtime flags :)

fwiw I'm fine with adding new fbdev drivers to staging, that really
doesn't hurt anyone. Adding drm drivers to staging tends to be pain,
least because if we need to do any changes to helpers there's a
cross-tree cordination problem usually, and the benefit of staging
hasn't in the past really outweighted that. Plus I try for us to land
new drivers when they're good enough directly into drivers/gpu, and
not aim for perfect.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
