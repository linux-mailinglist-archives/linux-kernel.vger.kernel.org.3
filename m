Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6494A6247
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiBARXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiBARXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:23:09 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E90C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:23:09 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 9so22178193iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VueRVXUIZ4PLuv+jNKqynr+SXNuvNQ3b0auGVgVeb4=;
        b=m9EHAA2Qyy592ZIy/XyoM+shRkpriwg9tXfgTsIAFpgsIJZ6PEVHmKGEhQtH8CuFWi
         I5lzavI/NRKex8bSa4P9FxykKScpxo6lin4p2aginO7Mzy7ysR1E1N42NzOXHrt+Cw1z
         a0hGA7YIw7XXMX0D7gxuLwEQKPa9jDNy8sU3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VueRVXUIZ4PLuv+jNKqynr+SXNuvNQ3b0auGVgVeb4=;
        b=LA9QkvyDyMxkRmKyf63H8VPUH5Iro3MFfeieHtXMcDxA7tL4N/8wiVhQYMXw/AV8cd
         lSX4zgdiNd5KaC3fFpSWFlLMFQQoaTKHU/75SUgBOtnxReCjgCOgDQs7sibxpQIPeypq
         RH3ATo0BuIfgEczkoZsqDbwgqyH4j3nNkTDj+mTVeXl3IojxZC2ck9gKEpX6GWedhx0B
         1U7DoMkSXUt9SdyFM00nclFEgTK9k7m0ZUYlSPAvqMMLuGuxVWO6sVawkJtVdCm1baKu
         Ct4LEuTut0JJEjzs+n1yV6b0B9f3+iC5HfW7XUKZiby7vcgQzq5RXwTJAE1G3avLY9La
         jrgQ==
X-Gm-Message-State: AOAM531d4MGCkPQjSjkAdptmtOa6kkwGSuIK+xtGLuU4EXzq6ajg1StS
        42ekJZXsSyBuSgDYil3e/5ixYmFxIm6CkA==
X-Google-Smtp-Source: ABdhPJx774kS75ntlXG9WRSciV9pFd87cnCVmPaLzgz47H4n+CMkq8/KpWMr5p9R+1N8PWkLHgOiZA==
X-Received: by 2002:a05:6638:2642:: with SMTP id n2mr10819788jat.47.1643736188599;
        Tue, 01 Feb 2022 09:23:08 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id j14sm19545692ilc.62.2022.02.01.09.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 09:23:08 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id w5so14892378ilo.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:23:07 -0800 (PST)
X-Received: by 2002:a05:6e02:1809:: with SMTP id a9mr15721637ilv.27.1643736187426;
 Tue, 01 Feb 2022 09:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
 <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com> <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
 <6fdcfbcf-0546-6b4f-b50f-cf2382ad746f@redhat.com> <CAD=FV=U3YHt=+cr8c39zMxFWMeo4Pr=R3BBPMKanpySPhsYh9w@mail.gmail.com>
 <CAKMK7uEiUxPJ7F+F33YVdq6d9WxzxTKzoxTyiZnvceM2CHEkVw@mail.gmail.com>
In-Reply-To: <CAKMK7uEiUxPJ7F+F33YVdq6d9WxzxTKzoxTyiZnvceM2CHEkVw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 1 Feb 2022 09:22:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WqL9gP3Lmr5ORvNXeUis1b58cOvDXKGeq-j9Q6=EMXbQ@mail.gmail.com>
Message-ID: <CAD=FV=WqL9gP3Lmr5ORvNXeUis1b58cOvDXKGeq-j9Q6=EMXbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Allow querying the detected panel via sysfs
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>, jjsu@chromium.org,
        lschyi@chromium.org, Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 1, 2022 at 9:02 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Feb 1, 2022 at 5:42 PM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Jan 26, 2022 at 12:25 AM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
> > >
> > > On 1/26/22 00:25, Doug Anderson wrote:
> > > > On Tue, Jan 25, 2022 at 2:55 PM Javier Martinez Canillas
> > > > <javierm@redhat.com> wrote:
> > >
> > > [snip]
> > >
> > > >> Should this new sysfs entry be documented in Documentation/ABI/ ?
> > > >
> > > > I'm not sure what the policy is here. I actually don't know that I'm
> > > > too worried about this being an ABI. For the purposes of our tests
> > > > then if something about this file changed (path changed or something
> > > > like that) it wouldn't be a huge deal. Presumably the test itself
> > > > would just "fail" in this case and that would clue us in that the ABI
> > > > changed and we could adapt to whatever new way was needed to discover
> > > > this.
> > > >
> > > > That being said, if the policy is that everything in sysfs is supposed
> > > > to be ABI then I can add documentation for this...
> > > >
> > >
> > > I also don't know the policy, hence the question. But in any case, I
> > > think that it could even be done as a follow-up if is needed.
> >
> > Sounds good. Since it's been pretty silent and I had your review I
> > pushed this to drm-misc-next. If there are comments or someone has an
> > opinion documenting this as a stable ABI then please yell.
> >
> > 363c4c3811db drm/panel-edp: Allow querying the detected panel via sysfs
>
> Generally stuff for tests should be put into debugfs. We print
> everything there in various files.
>
> sysfs is uapi, and so come with the full baggage of you need open
> userspace (which for some sysfs stuff might just be a script), and
> explicitly not for tests (because that just opens the door to merge
> anything binary blobs might want and just slide it all in). So please
> retcon at least some plausible deniability here :-)

OK, fair enough. It really is just for a test. Let me post a revert
then while we discuss more. If someone can add a Reviewed-by to the
revert then I'll push that just so we're not in an awkward situation.

https://lore.kernel.org/r/20220201092152.1.Ibc65ec6fa05017e9856ba9ef557310268429c3ce@changeid


> But if it's really only for a test then maybe dumping this into a
> debugfs file (we do have connector directories already) would be much
> better. That doable?

I did spend a little time looking at how to do this in debugfs and it
wasn't at all obvious to me without plumbing in a lot of extra code,
but I can spend more time on it if it's a requirement. If you think
this is something that should just be easy, I certainly wouldn't say
no to a pointer to what I should look at! ;-)

-Doug
