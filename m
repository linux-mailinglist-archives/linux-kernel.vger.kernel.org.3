Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70E14C7D64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiB1Wbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiB1Wbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:31:32 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF9CEDF1A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:30:53 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so20496476ooi.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oWJNEF23gYsaQqgLAEVbye1HfW5HTbmGgJBkQBp8gGE=;
        b=ElcKOruAXbvxWDYvNPelX7nfkbvr5prW+ZUpyWp0zCYNtIH5cQ8kTumGYq2SGYmvfj
         AJKxZoUqAvpDu/F+a9neQDo4u2Q3DRo/prSmpCma1dNvWzvYefscyrCfuWMkfy7OUIod
         6l3ayoWRsPfzOkVxlv+RLKinqiuEm6QmxtzNQ5J7DlQGNIuh+AQVJJbxiElRc3xJ3cPD
         j+qXxPn66/JY8QsJLkAjIA8jT5SAlJ4dMp395XvWBql5ysTpokA6aEtrtVHSbRF6PInM
         QN0TE5o1GNg6ITeSPFcewR5FtJDrum+tKnxlobePfkRCga9ukeWGCFOly485J1vwOq2m
         /Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oWJNEF23gYsaQqgLAEVbye1HfW5HTbmGgJBkQBp8gGE=;
        b=hDkoxa0KpWePXis38gmRWIqHgbgRebkJUxEG/BB1N6Gw5XAf6t47GMJLrNp5ZGX4PS
         S5dgEPrUGrTPmpOYJXkZNNRfhkpht4kqIhZLz0iHVyCd/BeCKNsiOuYlrX+/LLt+VX4+
         zOwYsoB3A0ve4Rh4jPpxJJUjgVqsQO9/BQFiRf6co9AoV3wj1uvSoXY6Qf9Fzn/SZ8wx
         8VIZjjpcmY+HUC1bBZJH6NZBxXB498w3JCupyph4RE9XNvEj0c0S63hhUKjLdS/WoGFr
         MScHwVDANRN+wfm16sm/lzYKa+woq4nqwwF26LbgLxVSj3pv08MnSTfUVpmNyUEJ3c8L
         Cc7Q==
X-Gm-Message-State: AOAM532yNyItxdCVr+VjH8sORg/GR0sN1T/Xw0azMVed7wXN3zcqdg+B
        A3qlF/SJpeHytccRRse0WOIS/W6eZ7NhUctmSU8=
X-Google-Smtp-Source: ABdhPJxJw4j6RbUKEuCCao9TFapxCXxTwduA5GmufbYLkRtVhOI3ahGDwGCTJQXixtkIAkJPLilFPdDIBO2YtqM9oeE=
X-Received: by 2002:a05:6870:1b85:b0:d6:feda:913f with SMTP id
 hm5-20020a0568701b8500b000d6feda913fmr2039667oab.123.1646087452697; Mon, 28
 Feb 2022 14:30:52 -0800 (PST)
MIME-Version: 1.0
References: <20220227153342.79546-1-trix@redhat.com> <58ae0ccc-e964-69a3-b40b-3262fd24af9b@amd.com>
In-Reply-To: <58ae0ccc-e964-69a3-b40b-3262fd24af9b@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 28 Feb 2022 17:30:41 -0500
Message-ID: <CADnq5_Oc2mUfv41gOxrdeHjKDQ4W+S1+wiX6v_7SE6bEH-9xSA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix realloc of ptr
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Tom Rix <trix@redhat.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Lazar, Lijo" <lijo.lazar@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        llvm@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Feb 28, 2022 at 5:55 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.02.22 um 16:33 schrieb trix@redhat.com:
> > From: Tom Rix <trix@redhat.com>
> >
> > Clang static analysis reports this error
> > amdgpu_debugfs.c:1690:9: warning: 1st function call
> >    argument is an uninitialized value
> >    tmp =3D krealloc_array(tmp, i + 1,
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > realloc uses tmp, so tmp can not be garbage.
> > And the return needs to be checked.
> >
> > Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list"=
)
> > Signed-off-by: Tom Rix <trix@redhat.com>
>
> Yeah, stuff I missed because of the long review. I was already wondering
> what semantics krealloc_array is following for freeing up the pointer on
> error.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks,
> Christian.
>
> > ---
> > v2:
> >    use 'new' to hold/check the ralloc return
> >    fix commit log mistake on ralloc freeing to using input ptr
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index 9eb9b440bd438..2f4f8c5618d81 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_wr=
ite(struct file *f,
> >   {
> >       struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode=
(f)->i_private;
> >       char reg_offset[11];
> > -     uint32_t *tmp;
> > +     uint32_t *new, *tmp =3D NULL;
> >       int ret, i =3D 0, len =3D 0;
> >
> >       do {
> > @@ -1687,7 +1687,12 @@ static ssize_t amdgpu_reset_dump_register_list_w=
rite(struct file *f,
> >                       goto error_free;
> >               }
> >
> > -             tmp =3D krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_=
KERNEL);
> > +             new =3D krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_=
KERNEL);
> > +             if (!new) {
> > +                     ret =3D -ENOMEM;
> > +                     goto error_free;
> > +             }
> > +             tmp =3D new;
> >               if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) !=3D 1) {
> >                       ret =3D -EINVAL;
> >                       goto error_free;
>
