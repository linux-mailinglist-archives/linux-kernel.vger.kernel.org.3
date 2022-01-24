Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D16498901
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbiAXSwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245572AbiAXSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:51:10 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A523C0617A8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:50:50 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x52-20020a05683040b400b0059ea92202daso7616562ott.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0csA6moKKYq3fSs9USPuSGlU/kYiU1Lp2B669qtC3bY=;
        b=UYTza7tSTELle6ZPRVA1VKcMdcn84stFawhGizZU7n+y0rXvx9W2wb6J2B4SG+jOkm
         HEXpxM0Jevqy6RKBvqcFHojq7RYiqe/b7mwqlXtDa4xRoJ2jaXH04rtKlwpaCahS/RLr
         YlIvXMiX2HOHKsmsnuOlPn5Uw8lj69D/E4iL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0csA6moKKYq3fSs9USPuSGlU/kYiU1Lp2B669qtC3bY=;
        b=W0ac2/agPl+jgAPeJl6dIUf6/L1+tZEyKfIVyxbFii2di4VxXlYuSLokMA1+bFlC5L
         eZ+gU3qVVDf0YZM7p5luQMxahbqxF435Lqx2vAf504LK+zXyEBw1g7NAbtFZjA3aDhZX
         HHqW0PiMpp7NSL4Wm9tsdN8crCgUyhehcU8O1hygjXix7bHYp4Hd4mHBSHbaXuinyqaS
         Fu/6rd8wFeD6rfWsuq4TDRSvVFrjJq9oOPV2Xizge/b51T+6kYNf9dg1+U9Kp8Udb/C9
         E+llrBqrSVKOaD7PsRvOs+NV02/rylaZw0j7bfOqBXEClYupzi3ZlpF/6+91DWjC7Ipx
         9bog==
X-Gm-Message-State: AOAM5331b5LQNx4wfMoRq31/8QKzirWV1ZAOE2LDhRQDEB+qVByYLEUx
        JG5RngWbSN4mVdUIKGKjxoRPcD9aYfsAH/moQ2TEYQ==
X-Google-Smtp-Source: ABdhPJw9kf0DB3au21XZBm8wAwVW+KBJNbxB/qjlpc+1/4Zpj18s6ohExWsveetehPvUTUdQCrdqVXsrDoX0olfQvpI=
X-Received: by 2002:a05:6830:1e76:: with SMTP id m22mr7594921otr.75.1643050249475;
 Mon, 24 Jan 2022 10:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20220117125716.yjwxsze35j2ndn2i@sirius.home.kraxel.org>
 <CAMuHMdW=Zpp2mHbrBx7i0WN8PqY3XpK5qpyAyYxgf9n88edpug@mail.gmail.com>
 <70530b62-7b3f-db88-7f1a-f89b824e5825@suse.de> <CAMuHMdW5M=zEuGEnQQc3JytDhoxCKRiq0QFw+HOPp0YMORzidw@mail.gmail.com>
 <57d276d3-aa12-fa40-6f90-dc19ef393679@gmx.de> <CAKMK7uE7jnTtetB5ovGeyPxHq4ymhbWmQXWmSVw-V1vP3iNAKQ@mail.gmail.com>
 <b32ffceb-ea90-3d26-f20e-29ae21c68fcf@gmx.de> <20220118062947.6kfuam6ah63z5mmn@sirius.home.kraxel.org>
 <CAMuHMdWXWA2h7zrZa_nnqR_qNdsOdHJS=Vf1YExhvs08KukoNg@mail.gmail.com>
 <3f96f393-e59d-34ac-c98b-46180e2225cd@suse.de> <20220120125015.sx5n7ziq3765rwyo@sirius.home.kraxel.org>
 <CAKMK7uF-V20qWTxQLvTC6GjC8Sg+Pst+UJ3pWCLQ4Q7Khgy62g@mail.gmail.com> <CAMuHMdWS3rYUUB8HQcpjq0pY28cLiPMGrYEXeSPVtr-a_rrQvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWS3rYUUB8HQcpjq0pY28cLiPMGrYEXeSPVtr-a_rrQvQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 24 Jan 2022 19:50:37 +0100
Message-ID: <CAKMK7uGdS7hSK2DWGrQZ3DT69Qp_m6h1UFnbT_A7T+Tptq6vYg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sven Schnelle <svens@stackframe.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 7:39 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Daniel,
>
> On Fri, Jan 21, 2022 at 9:55 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > Just to clarify, since we had lots of smaller and bigger
> > misunderstandings in the thread thus far: DRM_FORMAT_RGB332 exists, so
> > drm support that already. The fbdev emulation doesn't yet, but all
> > that's needed for that is filling out the code to remap the drm
> > description to the fbdev format description for this case. Plus
> > testing it all works ofc with fbcon and whatelse. Note that RGB332  is
> > a bit more work than e.g. C4, since atm fbdev still uses only bpp to
> > identify formats, so would need to be switch over to drm_fourcc first
> > before adding anything which aliases with something existing (we have
> > C8 already wired up).
>
> I doubt that RGB332 would be a bit more work than C4, as RGB332 is still
> 8 bpp, while C4 is less.  To support C4, all DRM code that cannot
> handle format->cpp[0] < 1 or drm_format_info_block_width() > 1 has to be
> fixed first.

Hm what's broken with it? Current code means it cannot support odd
width for C4 (because to make C4 fit into bytes you need 2 pixels),
but otherwise this should all work. Iirc we have formats with "5
pixels in 4 bytes" and fun stuff like that. Note that stride and also
the actual window you scan out are all separate, so even if your hw
needs an odd stride or you have an odd resolution it should still all
work out for C4 with the existing infra.

RGB322 is more work because in the fbdev code this aliases with bpp=8
which is C8, because no one has yet moved the fbdev emulation code
forward into the drm_fourcc world.

> On the plus side, I finally got my proof-of-concept Atari DRM driver
> working with fbcon on ARAnyM.  Mapping /dev/fb0 from userspace doesn't
> work (fbtest SEGVs while reading from the mapped frame buffer).  I don't
> know yet if this is a general issue without deferred I/O in v5.17-rc1,
> or a bug in the m68k MM code...
>
> So far it supports C8 only, but I hope to tackle C4 and monochrome soon.
> Whether the end result will be usable on real hardware is still to be
> seen, but at least I hope to get some DRM code written...

Yay, this sounds interesting!
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
