Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827D54A61CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiBARC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiBARCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:02:25 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA11AC061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 09:02:25 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so4239573oov.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmNulzN3mmZQBCDB7sQ8CSdfD8G2urW4bUypyx2Sf+U=;
        b=d+5cIITflXarmSYidQYqGy/SPlpwJFPzUwzgnzx7YR24olDgujJq7qHiWnlN+fcRjp
         RmfyDMRjnZa+nNfcr3P4npSe9RXP+06rXO/fW8PoG09XRA1YqP8nxpkt4MzDwjpsicV7
         ZyFcVV7wa1gfKWy64DDrp7h3j9EB30ErvuCRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmNulzN3mmZQBCDB7sQ8CSdfD8G2urW4bUypyx2Sf+U=;
        b=Ei0o0gbbUJNGEZ1fH3ZmVKrVJEZqHYsokxeBsuud9BcQutiQhY1yG6y15r7buAubAo
         0tKlvR0F0bHJ+NlPpihRp+6gTUEvFuBcRJL3O4xG06+xR0aQzxSiKTIqhVxr0FQdFzEh
         OSFFGkqdy9kDbSaXNxITYCT1xIa4Wvkw7yAp+bRuWXtz5eUfuM7UsCts+fi14N/g3mjX
         LW768r8bN6hxm+7Xp6YT+EHUd35dMP24TxJ7E/SVwYr33uaVAtg010ZpGddxg4T9hPKC
         RRyVxgeFlOorMviRojwXboZ3xVuPkgr2rimVk5gQ4K37t4F/icfPUtAZVPZRS4FZzgZx
         MQ8Q==
X-Gm-Message-State: AOAM532WxRpGwUr4fbYxXFNcQNPsQT9SysS+f7p0ehfgL7KVpuYqZLyA
        ktJaesMyJ6NdbyGI0drkSUmhpXo8MSRVZmb5cO/q1w==
X-Google-Smtp-Source: ABdhPJwWXljKvKuGvpSaNGrCDpGDZgSOOvLzRo52D5dqbZIgiKxNCAjoHk0BJnO9f2e73wAgllo3zYa4Ve3UnhJBSrA=
X-Received: by 2002:a4a:8891:: with SMTP id j17mr13060858ooa.12.1643734945153;
 Tue, 01 Feb 2022 09:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20220125135406.1.I62322abf81dbc1a1b72392a093be0c767da9bf51@changeid>
 <e89dbc7b-b3ae-c334-b704-f5633725c29f@redhat.com> <CAD=FV=U8VGnRXv8MgofKzZF22_x0_X3M+AMfyPQ1u=yTXnFBQA@mail.gmail.com>
 <6fdcfbcf-0546-6b4f-b50f-cf2382ad746f@redhat.com> <CAD=FV=U3YHt=+cr8c39zMxFWMeo4Pr=R3BBPMKanpySPhsYh9w@mail.gmail.com>
In-Reply-To: <CAD=FV=U3YHt=+cr8c39zMxFWMeo4Pr=R3BBPMKanpySPhsYh9w@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 1 Feb 2022 18:02:13 +0100
Message-ID: <CAKMK7uEiUxPJ7F+F33YVdq6d9WxzxTKzoxTyiZnvceM2CHEkVw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Allow querying the detected panel via sysfs
To:     Doug Anderson <dianders@chromium.org>
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

On Tue, Feb 1, 2022 at 5:42 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Jan 26, 2022 at 12:25 AM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> >
> > On 1/26/22 00:25, Doug Anderson wrote:
> > > On Tue, Jan 25, 2022 at 2:55 PM Javier Martinez Canillas
> > > <javierm@redhat.com> wrote:
> >
> > [snip]
> >
> > >> Should this new sysfs entry be documented in Documentation/ABI/ ?
> > >
> > > I'm not sure what the policy is here. I actually don't know that I'm
> > > too worried about this being an ABI. For the purposes of our tests
> > > then if something about this file changed (path changed or something
> > > like that) it wouldn't be a huge deal. Presumably the test itself
> > > would just "fail" in this case and that would clue us in that the ABI
> > > changed and we could adapt to whatever new way was needed to discover
> > > this.
> > >
> > > That being said, if the policy is that everything in sysfs is supposed
> > > to be ABI then I can add documentation for this...
> > >
> >
> > I also don't know the policy, hence the question. But in any case, I
> > think that it could even be done as a follow-up if is needed.
>
> Sounds good. Since it's been pretty silent and I had your review I
> pushed this to drm-misc-next. If there are comments or someone has an
> opinion documenting this as a stable ABI then please yell.
>
> 363c4c3811db drm/panel-edp: Allow querying the detected panel via sysfs

Generally stuff for tests should be put into debugfs. We print
everything there in various files.

sysfs is uapi, and so come with the full baggage of you need open
userspace (which for some sysfs stuff might just be a script), and
explicitly not for tests (because that just opens the door to merge
anything binary blobs might want and just slide it all in). So please
retcon at least some plausible deniability here :-)

But if it's really only for a test then maybe dumping this into a
debugfs file (we do have connector directories already) would be much
better. That doable?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
