Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE0489F53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbiAJShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238734AbiAJShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:37:47 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14DFC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:37:46 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so15932683otu.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7RDlnoeMMtaCidCqn8V2aaFhuGEcHAhns4iW4e9qdnM=;
        b=VjFp/WLcs6GbIfJmypSr2K7VuO1ew6VCjVRgmHxGjIea/Cm3msMQzGm1VjEuN251zy
         faFdW6V3W2CNHCys3PjbHhczDEuuB8TeZCZWemA49uf4TAEk05szO2Cswf0nu/bZxsYA
         iKYF7hXT/N6tjdvrf6Jmu8Hp3zTmpWd1TdpjNyc+FBBGznkem8PTKpGS+DcaccOAN1IS
         AcXVq7Z0uMVC15Xm+eTgOTe0MaKag1D+wrRu4rnjpo00yqB+Mq2qVawOK13KA807RRH1
         +5DVHyLJ8K+QHMR6b7xJPuKIZRmpBzh6D/mRLwCoWpXNfsGDR5rjyYKW6tZ/X8pGY2Dm
         NFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7RDlnoeMMtaCidCqn8V2aaFhuGEcHAhns4iW4e9qdnM=;
        b=tHoh50+lvJFVOgaWZYbanN/8MXyHQ+YqU7P0PKdEhJ09EOFK3aChbdqItsrO7/Jmv/
         MSogN4nEjWzm7HQVlgXzBDEU7tphM6D4j/26Q83SYR7RgwQwfVcxau+/0TI8EkR31x+t
         mY8/DmoyipmE8CYfF2qbzmzrknKkwaXfWqj40+SJOlr5T2HPhv3vJvanWGt0f8vsCjuw
         ZrIlLOElfZUZRtWfBo33Eu0pZ1ylBqak7lqSWIQZq7IdTeClE5Yf48oWg3sXjTd2f02d
         1wCycMzu5MD91LdX/zUHwwctJTcyM5AHfiTBGlu8vqitZMFClwhqET4yJJqbWGLNkfJo
         sZAQ==
X-Gm-Message-State: AOAM531teRx/XR3zEY4Jw1YkhSVd45v2vp7CdIl+PVTCmhh0HYLg+Hvs
        1O2ilinBj2e2sKFSS4aGiveU8quJLqb8DDYm3qE=
X-Google-Smtp-Source: ABdhPJxg2UhJ+8PlYBDJNAgt4LXO7EPhRJbjnm22Ybn0KY7F3AAAM5Whi/nHt7mQ5Dz0kggNNlLjgFB1qLbBjrHVsHo=
X-Received: by 2002:a9d:f09:: with SMTP id 9mr833994ott.299.1641839866004;
 Mon, 10 Jan 2022 10:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20220109184245.124850-1-jose.exposito89@gmail.com> <139784cd-6cb7-18e0-bb09-b35113bd83ef@amd.com>
In-Reply-To: <139784cd-6cb7-18e0-bb09-b35113bd83ef@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jan 2022 13:37:34 -0500
Message-ID: <CADnq5_N1-kKfhZ9mttcRq7RON0DsEjs1cpvxo4M7jJN3M8Sx9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: invalid parameter check in dmub_hpd_callback
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jude Shih <shenshih@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 10, 2022 at 11:34 AM Harry Wentland <harry.wentland@amd.com> wr=
ote:
>
> On 2022-01-09 13:42, Jos=C3=A9 Exp=C3=B3sito wrote:
> > The function performs a check on the "adev" input parameter, however, i=
t
> > is used before the check.
> >
> > Initialize the "dev" variable after the sanity check to avoid a possibl=
e
> > NULL pointer dereference.
> >
> > Fixes: e27c41d5b0681 ("drm/amd/display: Support for DMUB HPD interrupt =
handling")
> > Addresses-Coverity-ID: 1493909 ("Null pointer dereference")
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index e727f1dd2a9a..7fbded7a6d9c 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -656,7 +656,7 @@ void dmub_hpd_callback(struct amdgpu_device *adev, =
struct dmub_notification *not
> >       struct drm_connector_list_iter iter;
> >       struct dc_link *link;
> >       uint8_t link_index =3D 0;
> > -     struct drm_device *dev =3D adev->dm.ddev;
> > +     struct drm_device *dev;
> >
> >       if (adev =3D=3D NULL)
> >               return;
> > @@ -673,6 +673,7 @@ void dmub_hpd_callback(struct amdgpu_device *adev, =
struct dmub_notification *not
> >
> >       link_index =3D notify->link_index;
> >       link =3D adev->dm.dc->links[link_index];
> > +     dev =3D adev->dm.ddev;
> >
> >       drm_connector_list_iter_begin(dev, &iter);
> >       drm_for_each_connector_iter(connector, &iter) {
>
