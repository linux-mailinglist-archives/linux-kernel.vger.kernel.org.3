Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20814993B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386380AbiAXUf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353760AbiAXUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:13:47 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB2BC0604D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:37:16 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id s9so27115347oib.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6T+a8Bx06xvDutb5+VHfkoYO4ESKNGds/DLEsaoyVx8=;
        b=FMSnFxr7XrvMSHM8YrAM6NA5d3ET8kIpzVnWIzWt1EKy7/wkEHXze29Yi49fGJq+Y5
         GnxGPakbkFU5mIiNUV80zkvcs5Lq3FDyau5p4lc5ZHUMincF4tlOGxC64RcVK/YGhUhh
         TA7kmVkXemc68K3B6H4WUIdjUnrcj0Z5AQRok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6T+a8Bx06xvDutb5+VHfkoYO4ESKNGds/DLEsaoyVx8=;
        b=USjnHWCAHxFR2z+6VYgIrxV1MD84Ilax/Vh67XgRu67jAj6Xy0gF93VfHqSz3ofEjU
         chbsVld2aR6OGnBK6h6ErRyDDn2l4SD0ZENuwq3FuWI/rGzERjTLpDKmB1VweQBAXb/V
         2KBA8Bowd2Lga5NU7UbGbR2J0emjKZ/YyTn5hMx8IOq73X76OGHjnDBDpbKXd0SxvoN5
         EWnSz34f+0+beOIqUw4pK1p0wBlGL9O0urFG5qY8+7Ub0JtC+WLPUDucSIuLialu2DQ/
         4wGUgSx+vidKwAQkkDtOa/ygmY5wPNDIPETSP536joPowBlgUi9CUy40xDTWi20xO4/r
         8YTQ==
X-Gm-Message-State: AOAM532z/O1bQyQtPqKHuvKwI1A//B3IYKZfyxr6YaGS+6b0xTtLK99/
        ufCpkHurba9PlMiXfR8ZhETZH0c7hHJbVoe5FgvMSQ==
X-Google-Smtp-Source: ABdhPJx2AuJy+QcrAabTMb6vCZNPkX02N/uNR4+C15e6Iu9I+hPt4usCsK7v1wJ/eTUYdqctv9P8j2XhiTCfUUNkhbA=
X-Received: by 2002:a05:6808:1188:: with SMTP id j8mr2716171oil.101.1643053036285;
 Mon, 24 Jan 2022 11:37:16 -0800 (PST)
MIME-Version: 1.0
References: <YeG8ydoJNWWkGrTb@ls3530> <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
 <87bl0amc6s.fsf@x1.stackframe.org> <20220118103323.4bae3a7d@eldfell>
 <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org> <CAMuHMdWV+-+Jr7HggbfH_GEDcdep4pJLiMG+15jxBvQ91BCS0w@mail.gmail.com>
 <CAKMK7uEOFg3z2btFERQ5XBQ7hqex6bXCb9X=SdwCjeLfX_SdFw@mail.gmail.com>
 <CAMuHMdVjv1+UNeXkCBE+80tdtLuNg=5d6N12hNLgJdaS-jxERg@mail.gmail.com>
 <CAKMK7uEwDdaR7kDVi9Oah0w8qFEoAywp_wj2eH7DtttVD2L00A@mail.gmail.com> <CAMuHMdUyHEExOCtH-hKh0HmZzadmfZaR=vAVYJkTvphfzs3Xiw@mail.gmail.com>
In-Reply-To: <CAMuHMdUyHEExOCtH-hKh0HmZzadmfZaR=vAVYJkTvphfzs3Xiw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 24 Jan 2022 20:37:04 +0100
Message-ID: <CAKMK7uGtjNgRo8t4ZY_ouve2GSbdkjBsw6Gso=riV2CbOJkpzA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sven Schnelle <svens@stackframe.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 7:51 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Daniel,
>
> On Thu, Jan 20, 2022 at 1:33 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > But reading code&docs is too hard I guess, safer to assume it's just
> > broken and not supported.
>
> I confirm there's lots of documentation (and even more code ;-),
> which is always great!
> But both are intimidating to me, and most of the documentation covers
> features I'm not interested in, as they're only applicable to fancy
> modern truecolor 3D-capable multi-buffer and multi-head hardware, while
> what I am looking for is usually not documented.  E.g. I had a hard
> time to discover how color look-up tables work (gamma_{store,size}!),
> as this is not covered in https://docs.kernel.org/gpu/index.html,
> and none of the tinydrm drivers support CLUT modes.

Hm yeah that part is a bit awkward since due to how Xorg works here
the gamma table is abused to be the lookup table for C8. If we're
adding piles of new Cx formats it might be worth it to structure this
a bit better, e.g. (really just thinking on the spot here):
- have a separate Cx lookup table blob in drm_plane_state (in theory
you could have a different one on each plane and still have an overall
gamma ramp on the crtc)
- change the compat functions which map the legacy gamma ramp to
redirect to the plane gamma ramp if the primary plane is set to Cx
- bonus points for then correctly sizing the lookup table to match the
number of bits in the Cx plane format

But unfiddling this confusion properly is going to be tricky. I think
just continuing the tradition we have for C8 and reusing the crtc
gamma ramp for that is probably fine for now.

And yes that's not documented, because when we fixed the docs for the
entire degamm/CGM/gamma color correction pipeline Cx wasn't the top
priority :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
