Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAD556F30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376529AbiFVXfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377263AbiFVXf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:35:27 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1441999
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:35:24 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i15so28041523ybp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 16:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o7RsO830fD0jUOzHDwoBp7BpixyxsVDMcbzJc/dPZr8=;
        b=t72DVOYNRLlNIK0QWaS0yiZCgLQzJ+mww8RuMAa6SEu21pN2KF8In8tDLoWRqBsrNr
         KNnBknGFobmW8lD5cwyGXZhMOKni4k712dl8T6Nb1Y74xZMaHi0Kq2qd81vV4LMVdjCT
         9lXscB4gWNNBeBTqN53A7/SqtDjl+hdd0crwWDarrUqcrVVL1BKgKrobVA6tolIbU7CW
         7qtcKBAh+hyL8KFEk0j6kpHlcnQQCy4LuyU4suQyqWqX68juFOOsbqaTH6uXvAorFBYR
         T5EyqV/l5CVH064TgCz+CYYxgBqY/E+gzS5VZQ1S06ALNzSu8KP9nwKNPVFQO6FD4QXB
         X3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o7RsO830fD0jUOzHDwoBp7BpixyxsVDMcbzJc/dPZr8=;
        b=u3qV2EXUFmbf6pysdoajq1tX6jcNGI1wVkOhLKcGHum4zy4JH5Qw1210uRlOTrQAMN
         dGMPOXkYq9xP50ZNKiHZa/X8nK5eafPzVcZ/6Mp3zXC9vShzOI+HuHg2E/P+cEvs3eUl
         13zmC1gagnk7+0LCZye3cUNmMILKo5ai6V7qkCnHbUJfocqx/pvnmpja7DZsSQfcenqM
         WUtoC4cadBN8hPigd1TYvF0UlwygFkscguIvVqWXgtmcNpldwxOxcrtuLgL7ZKOp1s50
         vDMr7gl6FqnIDUYPr3z8A7d6xW8M2OpbYpQNsk7P+yqCpZLETHQfaX7+x4rmZF/onDsC
         47hA==
X-Gm-Message-State: AJIora9pYcxsPvuXf6+57IFno9xRZTraWlCGd+AhBzv0Jdn2CC4oKunz
        iprJgVL4B3C2K1eC8qDRJi7qZI3NUBd9KSRrAUQO6g==
X-Google-Smtp-Source: AGRyM1thlCmdsv9jRIXB0vx8z3s/GQ8/szb8lQCu3tvGCC9TxyNx0da3lTQTVZ/C/rnveNMpCk5dzQW1Wpv0FI0fIaQ=
X-Received: by 2002:a25:b29e:0:b0:669:160e:7f38 with SMTP id
 k30-20020a25b29e000000b00669160e7f38mr6608657ybj.280.1655940923198; Wed, 22
 Jun 2022 16:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <91ff0bbb-ea3a-2663-3453-dea96ccd6dd8@amd.com> <YCuPhOT4GhY3RR/6@phenom.ffwll.local>
 <9178e19f5c0e141772b61b759abaa0d176f902b6.camel@ndufresne.ca>
In-Reply-To: <9178e19f5c0e141772b61b759abaa0d176f902b6.camel@ndufresne.ca>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Thu, 23 Jun 2022 00:34:58 +0100
Message-ID: <CAPj87rPYQNkgVEdHECQcHcYe2nCpgF3RYQKk_=wwhvJSxwHXCg@mail.gmail.com>
Subject: Re: DMA-buf and uncached system memory
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Sharma, Shashank" <Shashank.Sharma@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, 22 Jun 2022 at 20:39, Nicolas Dufresne <nicolas@ndufresne.ca> wrote=
:
> Le mardi 16 f=C3=A9vrier 2021 =C3=A0 10:25 +0100, Daniel Vetter a =C3=A9c=
rit :
> > So I think if AMD also guarantees to drop clean cachelines just do the
> > same thing we do right now for intel integrated + discrete amd, but in
> > reserve. It's fragile, but it does work.
>
> Sorry to disrupt, but if you pass V4L2 vmalloc data to Intel display driv=
er, you
> also get nice dirt on the screen. If you have a UVC webcam that produces =
a pixel
> format compatible with your display, you can reproduce the issue quite ea=
sily
> with:
>
>   gst-launch-1.0 v4l2src device=3D/dev/video0 ! kmssink
>
> p.s. some frame-rate are less likely to exhibit the issue, make sure you =
create
> movement to see it.

Right, this is because the UVC data in a vmalloc() area is not
necessarily flushed from the CPU cache, and the importer expects it
will be.

> The only solution I could think of (not implemented) was to detect in the
> attach() call what the importers can do (with dev->coherent_dma_mask if I
> recall), and otherwise flush the cache immediately and start flushing the=
 cache
> from now on signalling it for DQBUF (in vb2 workqueue or dqbuf ioctl, I d=
on't
> have an idea yet). I bet this idea is inapplicable to were you have fence=
s, we
> don't have that in v4l2.
>
> This idea was hinted by Robert Becket (now in CC), but perhaps I picked i=
t up
> wrong, explaining it wrong, etc. I'm no expert, just noticed there wasn't=
 really
> a good plan for that, so one needs to make one up. I'm not aware oh an im=
porter
> could know how the memory was allocated by the exporter, and worst, how a=
n
> importer could figure-out that the export is going to produce buffer with=
 hot
> CPU cache (UVC driver does memcpy from USB chunks of variable size to pro=
duce a
> fixed size image).

This is exactly what Christian was saying above.

Cheers,
Daniel
