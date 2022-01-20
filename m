Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A71E494D32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiATLlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiATLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:41:01 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0736FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:41:01 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id s13-20020a4aa38d000000b002e28c5100cbso2077196ool.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/S8k15AcpnXJR5sZmK0Rcxc+q7sXlvNu6yj6zSEHGrM=;
        b=AhbLp7Lrf/Hbom1/nqt1i9iL8YdYmD1NGte7834RS0WBZ0e4HZSvvgEnRviDNt+ijl
         +ExPcaeqep414/+Np4/OrvaZ1+CMi4uzmk42JdqTz0HgQELcdKTw5LfsCxPET5H2iwUZ
         XNMbk0TsUZ/N7jN6oUb1Kh0EfZWT6TrI9Ndwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/S8k15AcpnXJR5sZmK0Rcxc+q7sXlvNu6yj6zSEHGrM=;
        b=63jEG3P/oY/e6EG12oYR4c/YwES/P6uuo0VzcJXHoHXWx5pD7/3EyD/udNkE9/AcTH
         +zIa6KggxwWOn13rGRZldcmzK+ShanOrzDZllDsrWem6xb9+XyHRovs701MSYL6vt0Bo
         KNcLTCb84FGQCXoPonpqn/ZMrnZgaNgwnv9k5tNfamO8xsku68MSJ/pW48PNIrJHty3F
         7dMSpIzvisNkU0akYwnVC7mDGrFBn66TrBxLDsf5nxmb9ZsWMET01peT62d7cE3Sv1s8
         RNLQF8IXNnLe5A349TWQArzkRJNJeAtq4Pr/vQ+FGOelxKbahglpgLkSCf3JshgNrlDi
         5Mkg==
X-Gm-Message-State: AOAM53026sdry91PCvSEkEjzUsrRqoA8d5HJcHwEI1441YcTvJ2atpFX
        v2UmEKKoROnmJtYUdk45WQuWgR45EVG79zmoqk7Vpw==
X-Google-Smtp-Source: ABdhPJwa7VL7d5xj1gVrA32gnMHYFGhcySOnufhi//Z+qMUimvyBQyMQD3mUQexgWnazoLdFsFC06rjJ6XZ4Dnorwvg=
X-Received: by 2002:a4a:db96:: with SMTP id s22mr23232794oou.66.1642678860411;
 Thu, 20 Jan 2022 03:41:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PXnig9YfnwSzMg5UPm3UtAsEAQT_xVheBbLppiU45mc_QQ@mail.gmail.com>
 <Yeg8mi0S2ACy9q8O@phenom.ffwll.local> <CAFr9PXkUwfyZ9yJgNYHX5_jo_SFfDU9wKA3Ldf+hbVL23faqKQ@mail.gmail.com>
In-Reply-To: <CAFr9PXkUwfyZ9yJgNYHX5_jo_SFfDU9wKA3Ldf+hbVL23faqKQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 20 Jan 2022 12:40:49 +0100
Message-ID: <CAKMK7uHxjmZShgzVdt6yPRN6qN4QVMvwCfNYxTp8yWdfs4x_ng@mail.gmail.com>
Subject: Re: [RFC] How to add hardware rotation, scaling etc to a DRM/KMS driver
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Hans de Goede <j.w.r.degoede@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 12:12 PM Daniel Palmer <daniel@0x0f.com> wrote:
>
> Hi Daniel,
>
> On Thu, 20 Jan 2022 at 01:30, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > I got the feeling that maybe I should just provide an interface to the
> > > blitter from userspace and userspace should be doing the rotation. I'd
> > > like to do it in the kernel so stuff like SDL1 apps just work but
> > > maybe that isn't possible?
> >
> > panel orientation property is for that stuff:
> > fbcon will head this and rotate in sw,
>
> This is working. On boot I get Tux rotated correctly etc.
>
> > as should any competent compositor
> > in userspace (but some might not, it depends).
>
> That's the problem I guess. I don't have one. SDL1 apps like prboom
> use the fbdev emulation as-is so they render upside down[0].
> I have 16MB of local storage and 128MB of RAM so I don't think I'll
> manage to get the standard userland bits onto it.
>
> I wanted to do the rotation in the kernel so I didn't have to hack up SDL1.

Move to drm kms, fix userspace. fbdev never supported this, and I
really don't think it's a good idea to add in-kernel rotation to
fbdev.
-Daniel

>
> Cheers,
>
> Daniel
>
> 0 - https://twitter.com/linux_chenxing/status/1479801511274491909



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
