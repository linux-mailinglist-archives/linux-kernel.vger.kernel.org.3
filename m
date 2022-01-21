Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C58496696
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiAUUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAUUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:48:29 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBC6C06173B;
        Fri, 21 Jan 2022 12:48:26 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r138so15316454oie.3;
        Fri, 21 Jan 2022 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WGjUTrV5mgHMzDhyvLsZZ8pd7X6AuuH7QuhfJeG9EgY=;
        b=kvmf2OSxp7vQKMwYR1dLgO6WSiX2+4nzHhjmW/Oz5Vx0F/DK5D1vuYufA1qJh9Hx8a
         LfHmpvcS+ayKbXU3K1KqQvhGyBD1/9voVd8xBJhLWdUkaeOtZNW8nOlj2NT51r791/iw
         C1yXy+49U6UWHQxbmVxO2gR3A0Ot1byMBQMNkzoEOFKlPDfLSYdkPZ3ueek84qDVORVm
         ItiKUCPqLuAw3+Ac8+8viaNyNaokKwZyq7tsXOPOs0ZJV8ts+QZSdT+X526m/fv2gVZA
         dvucmMp0dZvzSnL7KV3yLFjafRYSt+ieGp4YyxXF6N3JQnT2EjKZqCvaQdHGuocKInoQ
         /1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WGjUTrV5mgHMzDhyvLsZZ8pd7X6AuuH7QuhfJeG9EgY=;
        b=lYvtHHbULd7RD6RvRqfCpysWW1AeiRxGscxOcDRbrYP3+iv/UH9Rd6sggBq5/psrYf
         nueK09T+he6JiYKP2Wff1jxuurLfBClIfmwTnAir5ZFmg4kn2LhJJlmRBIGAymG3jT/r
         EEalMbPUQxPBjcIg+5py+SCfjjIvdB0a8CsF+WSmgUvDJHVR27biEN/E+yQeCJ7zUcv9
         oaS6xeD/fQqbSJKfk7WL8zKLRplaP8vVI6jlaXmJljkUXDuptIbIBhl4yosOvU46+pBq
         EQn1q2meXnnS9Hef9dRzoRYKc+iAj8g3bYy6eO6095QeFeQzMgLzsDL+xcRuyy4ZjQnp
         0Z1w==
X-Gm-Message-State: AOAM5333zuXXUt4vV/90K6K7xnEoDXdHczlwWic001E85NfdZMx3gCza
        6wx3Gt9HS21EJsq4rlEcs6afT/qCW//Wlt3W/Zs=
X-Google-Smtp-Source: ABdhPJyFepdztr15jwXrbjkaZsAmzuoos6TQ9cMezqozHSl5K0Wmi1lv0sbBN6F1FVhtc6sl7qvKX2ON/nhJOnVhzbU=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr2012664oib.120.1642798104543;
 Fri, 21 Jan 2022 12:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20220121052827.4384-1-xiongx18@fudan.edu.cn> <23d5251f-c910-aed3-5d9e-07d6e5e5add2@amd.com>
In-Reply-To: <23d5251f-c910-aed3-5d9e-07d6e5e5add2@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 21 Jan 2022 15:48:13 -0500
Message-ID: <CADnq5_N5Di8mxWDoVe5hdqPfrBnCw=gnDMzMyHeenk2gb=aSZw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu/amdgpu_cs: fix refcount leak of a
 dma_fence obj
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Xin Xiong <xiongx18@fudan.edu.cn>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Xin Tan <tanxin.ctf@gmail.com>,
        yuanxzhang@fudan.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 2:45 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 21.01.22 um 06:28 schrieb Xin Xiong:
> > This issue takes place in an error path in
> > amdgpu_cs_fence_to_handle_ioctl(). When `info->in.what` falls into
> > default case, the function simply returns -EINVAL, forgetting to
> > decrement the reference count of a dma_fence obj, which is bumped
> > earlier by amdgpu_cs_get_fence(). This may result in reference count
> > leaks.
> >
> > Fix it by decreasing the refcount of specific object before returning
> > the error code.
> >
> > Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> > Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
>
> Good catch. Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Applied manually.  Strangely I never got this on any of my emails, and
I don't see it in the archives.

Alex

>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 0311d799a..894869789 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1510,6 +1510,7 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_de=
vice *dev, void *data,
> >               return 0;
> >
> >       default:
> > +             dma_fence_put(fence);
> >               return -EINVAL;
> >       }
> >   }
>
