Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2631A4F653B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbiDFQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbiDFQPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:15:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221902A26E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:41:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l26so4402167ejx.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0IeTkY1yhaJPK6VDqHKztL6/sdrLKeK5VaUPik01uco=;
        b=WbP9ySUZSPgHLrHFRxIUWqAkKlwtz3/lphdxBTdMOVQuUT5+HfJKYrAg4eUTEsXZkz
         8e8KhdnBO1xUEtEoMVUbtRmhxsR8BiyPPc5TfM+9lfBW5O/VYyOW+YLyas51CMQO09SJ
         sZRGZOroZ5LEsaydgXPFKgZgbG1xzpflqC0GHSWYpUCcjg8C4j+ZieSFKHPLTUOmbrOS
         FoxY0v0cP6iQBZ+ms6c4zzRlAar3PgroXfqXIn9AfuiaBKa3RqrlilCrfE7ZwizUQ6Gj
         m53Hcr11tJjGhloLapsO3Q2jt656PpXU7Rt7ClPkwJ/n3+3r+zLKxwgtFNDXTmcfVLZU
         ZYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0IeTkY1yhaJPK6VDqHKztL6/sdrLKeK5VaUPik01uco=;
        b=6Iw7zn8Y1Xtvd20tsENPlDb4tHQSagUGPRqJrltTo2QrwgzX42OaRnGC9RghfWwshd
         qRRVXr49J5rZS9WBhNDisxop1ZhOHVuljtmAwnh0kihFJ27WjGftNXoU9RRK3YL6Npcq
         MwCtSsAqiPrKOYrSDcxiiryBNrPS1eYzY1ohgLp6zRkYgyhS4wF0M62b0CoKOcHiQ/Qm
         PMfKCLJbD7RKuJi7s3Ao4MN5h5HpAU4kngFyMQ5SMwD5Vo5kr7MH0TZu8AO7pGqtNDcD
         fC99iu3/j4O5NjOyO+Ss5HdYOWd58CgdZ+vK5MbRegAN903zsQo6oyAH8tN9jAEw9bRN
         GgBw==
X-Gm-Message-State: AOAM533wYYMyiYInkFQ8tvnPIVSWb4Tf3tHzELpUZxSdmAFbPkFb8g+m
        gtjvnj2VPHbn/tq7iasnt3iYfbP189Se29E2Xos=
X-Google-Smtp-Source: ABdhPJxZ9dElneUwA1wzU6Q0bcRp/j+jGbBrxLosQpe0RT2zY1YIsaK+d6cZ5N6w4jJF97TCJJ6VotA+kDLMYk0zyDo=
X-Received: by 2002:a17:907:980b:b0:6e0:71d9:c87e with SMTP id
 ji11-20020a170907980b00b006e071d9c87emr8142309ejc.510.1649252495645; Wed, 06
 Apr 2022 06:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220404222132.12740-1-h0tc0d3@gmail.com> <c55e9866-83f6-a3a0-2ad3-40090e978b40@amd.com>
In-Reply-To: <c55e9866-83f6-a3a0-2ad3-40090e978b40@amd.com>
From:   =?UTF-8?B?0JPRgNC40LPQvtGA0LjQuQ==?= <h0tc0d3@gmail.com>
Date:   Wed, 6 Apr 2022 16:41:34 +0300
Message-ID: <CAD5ugGDL7U1TiOW3P=ecwVhF95XgdibtoYGV8GzbAskuB5UWCA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix potential NULL pointer dereference
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. You are right. I found a potential bug, and as I understand
it, the code only applies to the Aldebaran GPU and I can not check the
correctness of the code. I only test code on my navi 10 and run GPU
stress tests.
My knowledge of amdgpu is limited, and fixing potential bugs allows me
to learn more about amdgpu code. But there are many that I still don't
understand. In any case, we need to fix the code to eliminate
problems in the future.

Regards, Grigory.

=D0=B2=D1=82, 5 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 20:00, Felix Kuehli=
ng <felix.kuehling@amd.com>:
>
> Am 2022-04-04 um 18:21 schrieb Grigory Vasilyev:
> > In the amdgpu_amdkfd_get_xgmi_bandwidth_mbytes function,
> > the peer_adev pointer can be NULL and is passed to amdgpu_xgmi_get_num_=
links.
> >
> > In amdgpu_xgmi_get_num_links, peer_adev pointer is dereferenced
> > without any checks: peer_adev->gmc.xgmi.node_id .
>
> What's worse, peer_adev is uninitialized with an undefined value if src
> is NULL. So that code was definitely bogus.
>
> However, I think your patch will result in incorrect results. Currently
> amdgpu_amdkfd_get_xgmi_bandwidth is always called with is_min=3Dtrue if
> src=3D=3DNULL, and with is_min=3Dfalse if src!=3DNULL. The intention is, =
that we
> assume a single XGMI link in the case that src=3D=3DNULL. That means the
> is_min parameter is redundant. What we should do instead is, assume that
> num_links=3D=3D1 if src=3D=3DNULL, and drop the is_min parameter.
>
> That would keep things working the way they do now, and prevent
> potential problems in the future.
>
> Regards,
>    Felix
>
>
> >
> > Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_amdkfd.c
> > index be1a55f8b8c5..1a1006b18016 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -541,11 +541,10 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struc=
t amdgpu_device *dst,
> >       struct amdgpu_device *adev =3D dst, *peer_adev;
> >       int num_links;
> >
> > -     if (adev->asic_type !=3D CHIP_ALDEBARAN)
> > +     if (!src || adev->asic_type !=3D CHIP_ALDEBARAN)
> >               return 0;
> >
> > -     if (src)
> > -             peer_adev =3D src;
> > +     peer_adev =3D src;
> >
> >       /* num links returns 0 for indirect peers since indirect route is=
 unknown. */
> >       num_links =3D is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_a=
dev);
