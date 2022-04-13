Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5C4FF121
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiDMIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiDMIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:00:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662DD4E39E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:58:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l7so2290786ejn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBruQmr4XB2N3FiWi5orHbgqzrYhRN078PvjlV3/G00=;
        b=Kd5ZK/WY7yr62gHt3kL6X4lGCWF27s2oIs6H206iPkS1fR0nFW2IdW4zJ6TFNxmAKK
         5Z6bKf8hr17Hc7G34kYFBsPvbsLtK4H51Z6l6Tx1ZiOh9NaFCoBHuPEXZ+kClfSXV7jc
         BvkWVBssOek7/E//kyrWnI3SZTIZm3cYC5QIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=oBruQmr4XB2N3FiWi5orHbgqzrYhRN078PvjlV3/G00=;
        b=nHPW7nYUu5wneVeJDo++r8aziC6BBvBQ0zbsHTpwqwx4wRUNVCVQfdbQJz52WZR/m/
         wKZiuIj5r84ikGmMRPktNsxwMEEPCcHsayLs2rdKIAeGwkNP6bLVHON/vxXyRB7CUUgg
         U6epZOZR7UkNE2QhNH5dKGyBgjB9OufL3ATxz5GrV/JdPzxizG/ssp3gdtw/cMBFvaHD
         T/j78PAMSokRal+V4oYfWN4r6P1QtpLizo239UNOKx8l1pTE8RK7/yRKfmR6MTrDID9O
         67fTcHxFbiB0U28oR0mUWbJpIT+o79f+5n/WaLNYk82Mo8HvenOaCL+Y8+j2prNSeHDB
         3vmg==
X-Gm-Message-State: AOAM532IiGemZqPakPN9Ouj+/8CtfRiR+lET37hEG9GEhL5eE2RlVcKP
        p/2hyNcHdDrwh+tChWkvOEszO9ilFA/vo0F3
X-Google-Smtp-Source: ABdhPJxfCXq5SUOUEARKiNbrHpD9ygaSNc0m4X9dNdhHp3sUrOgU4gZSMZLQ6/qjFA9BHmgEvdDeag==
X-Received: by 2002:a17:907:7f87:b0:6e8:354c:d440 with SMTP id qk7-20020a1709077f8700b006e8354cd440mr26948261ejc.761.1649836679957;
        Wed, 13 Apr 2022 00:57:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id lo15-20020a170906fa0f00b006e8a81cb623sm2118263ejb.224.2022.04.13.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 00:57:59 -0700 (PDT)
Date:   Wed, 13 Apr 2022 09:57:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH -next] drm/solomon: Make DRM_SSD130X depends on MMU
Message-ID: <YlaChZAd66pNPMEF@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>, David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
References: <20220312063437.19160-1-yuehaibing@huawei.com>
 <08e81f07-99d2-62a3-8eea-b2c0432b4d18@redhat.com>
 <CAMuHMdVYtV9KHYqjcXS05XM+QqbCgPKB_uZCCAN0eAqHUmoeTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVYtV9KHYqjcXS05XM+QqbCgPKB_uZCCAN0eAqHUmoeTg@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 03:49:38PM +0200, Geert Uytterhoeven wrote:
> Hi Javier,
> 
> On Tue, Mar 15, 2022 at 12:28 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> > On 3/12/22 07:34, YueHaibing wrote:
> > > WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
> > >   Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && MMU [=n]
> > >   Selected by [m]:
> > >   - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m]
> > >
> > > DRM_GEM_SHMEM_HELPER depends on MMU, DRM_SSD130X should also depends on MMU.
> > >
> > > Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> >
> > Indeed. All the DRM drivers that select DRM_GEM_SHMEM_HELPER depend on MMU.
> 
> That's very unfortunate. Is there no way around this?
> 
> Else fbdev can never be deprecated in favor of DRM.

I guess we could transparently replace shmem helpers by cma helpers on
!MMU platforms - like if you have CONFIG_MMU you get the current shmem
helpers, but if you don't have that, we do a dummy shmem helper
implementation which uses cma helpers internally. The problem is that the
interfaces have co-evolved and aren't a perfect match, so some surgery is
probably required. Also we embed the structs into driver buffer object
sturcts generally, and I'm not sure how to best solve that.

Maybe the simplest approach would be to add a pointer to cma_gem_object to
shmem_gem_object for the !MMU case and do a bit of forwarding as
necessary.

It might also be possible to wire through !MMU mmap support for shmem, but
I'm not sure how well that will work in practice since that path would go
to page_alloc and not through CMA (or maybe I'm just wrong about how mmap
works on !MMU, definitely not my area of expertise).

Anyway should be fixable.
-Daniel

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
