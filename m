Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0042575368
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbiGNQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiGNQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:50:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3A6C10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:47:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id va17so4531261ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qWSHX3eXBHfFTsd7QfRtWGODgvWsqs9hDqIclZtgzZE=;
        b=kjEHD1wJu+C+dldPQZx7ojIPKTrL1FNbzLNfUuC50054eSlcyxxkG9FtYASBd1JhFZ
         zPTfx9Z6roTSmWlEEC1shAmP34PHEd8Np54N9LlbrRS5kx1RwrstchC9T6RHtueoT9Qg
         mQEenWDdd4hMWQrV+I0P1VxYakhlVC5nmSeblmcvp9u5qDQjVIxDfiZz8IfU+K/I28Pw
         oHUfpYiv+hExma5ou4B/RyJYycbufZV5ncTbrAA5E5Blxc6v5kgYJdD5EIFkzRjibz9o
         mpQHBChxTagUmB+uJjFTkeixM8RvNI8/L92O0jAouKwsOamLjoJI7DtourgxPdzuWDDE
         C7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qWSHX3eXBHfFTsd7QfRtWGODgvWsqs9hDqIclZtgzZE=;
        b=SFelDIgnd2eOJ7yP3Z7xLAKPWBr56jBHHVFLEngjMTyW73gjCbsC03bV8/59rmdXSb
         qPNgJZdTSpW9pDNkoWYiXNRdUf4W+f951Qz4ICPmMb+kjnW0xEhtj7Js5Kb41u2TXWQT
         F0rqyKnmjz+st1R4gKWjJN8nbHoDJCTCyTSa/q8JvaU96VO1u2iP8ME9tqggcE3/oLaY
         3tdXJ/2cSS4iV8Bd5EO/NdpFaaNEfUQcPrFvdOsBLCMy66LsVj30ApruXiU6n+k4RHDO
         n+wO1gAnaCgdrPNUWJu3FMVHYrVXxlsfmfoBNkr6NxHtZHWGlfWbv32U6xk6eO5lw472
         99KQ==
X-Gm-Message-State: AJIora+7hFkOwVLV1HKtfHWKVzlcAY1j4/FZbeifsi1mPplMeq+M5Jel
        NOnohPhPT266W/OhXcEVuNW3IuImv4qvxe8ha4c=
X-Google-Smtp-Source: AGRyM1urhg4LBIyWLSK1JsFexKVLuDaj0dQddpMeJxSn4QJM5YHaFyYHHkUUymXpIPLdQwAAdD1dPgMK7rKlzKj2n60=
X-Received: by 2002:a17:907:94cf:b0:726:c81a:f30e with SMTP id
 dn15-20020a17090794cf00b00726c81af30emr9572150ejc.451.1657817246137; Thu, 14
 Jul 2022 09:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220713151504.7521-1-andrealmeid@igalia.com> <CADnq5_NASpkVUpPa=CPad39AYvzueGx9vsNbUcSgqzQhh+0Lzg@mail.gmail.com>
 <a63e287b-39c0-1433-d62b-bcb9d45ad1df@igalia.com>
In-Reply-To: <a63e287b-39c0-1433-d62b-bcb9d45ad1df@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 12:47:14 -0400
Message-ID: <CADnq5_NPF6REg63Td0GWimgVAywjFQ1MWwEEKW99F10cC-VaDg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/debugfs: Expose GFXOFF state to userspace
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        kernel-dev@igalia.com
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

On Thu, Jul 14, 2022 at 12:45 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com=
> wrote:
>
>
>
> =C3=80s 13:42 de 14/07/22, Alex Deucher escreveu:
> > On Wed, Jul 13, 2022 at 11:15 AM Andr=C3=A9 Almeida <andrealmeid@igalia=
.com> wrote:
> >>
> >> GFXOFF has two different "state" values: one to define if the GPU is
> >> allowed/disallowed to enter GFXOFF, usually called state; and another
> >> one to define if currently GFXOFF is being used, usually called status=
.
> >> Even when GFXOFF is allowed, GPU firmware can decide to not used it
> >> accordingly to the GPU load.
> >>
> >> Userspace can allow/disallow GPUs to enter into GFXOFF via debugfs. Th=
e
> >> kernel maintains a counter of requests for GFXOFF (gfx_off_req_count)
> >> that should be decreased to allow GFXOFF and increased to disallow.
> >>
> >> The issue with this interface is that userspace can't be sure if GFXOF=
F
> >> is currently allowed. Even by checking amdgpu_gfxoff file, one might g=
et
> >> an ambiguous 2, that means that GPU is currently out of GFXOFF, but th=
at
> >> can be either because it's currently disallowed or because it's allowe=
d
> >> but given the current GPU load it's enabled. Then, userspace needs to
> >> rely on the fact that GFXOFF is enabled by default on boot and to trac=
k
> >> this information.
> >>
> >> To make userspace life easier and GFXOFF more reliable, return the
> >> current state of GFXOFF to userspace when reading amdgpu_gfxoff with t=
he
> >> same semantics of writing: 0 means not allowed, not 0 means allowed.
> >>
> >
> > This looks good. Can you document this in the amdgpu kerneldoc?
> >
>
> Sure, let me send a v2 with that

While you are at it, if we are missing docs for the other gfxoff file
can you add that as well?

Thanks!

Alex

>
> > Alex
> >
> >> Expose the current status of GFXOFF through a new file,
> >> amdgpu_gfxoff_status.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 49 ++++++++++++++++++++=
-
> >>  1 file changed, 47 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_debugfs.c
> >> index f3b3c688e4e7..e2eec985adb3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> >> @@ -1117,13 +1117,50 @@ static ssize_t amdgpu_debugfs_gfxoff_read(stru=
ct file *f, char __user *buf,
> >>         }
> >>
> >>         while (size) {
> >> -               uint32_t value;
> >> +               u32 value =3D adev->gfx.gfx_off_state;
> >> +
> >> +               r =3D put_user(value, (u32 *)buf);
> >> +               if (r)
> >> +                       goto out;
> >> +
> >> +               result +=3D 4;
> >> +               buf +=3D 4;
> >> +               *pos +=3D 4;
> >> +               size -=3D 4;
> >> +       }
> >> +
> >> +       r =3D result;
> >> +out:
> >> +       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >> +       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >> +
> >> +       return r;
> >> +}
> >> +
> >> +static ssize_t amdgpu_debugfs_gfxoff_status_read(struct file *f, char=
 __user *buf,
> >> +                                                size_t size, loff_t *=
pos)
> >> +{
> >> +       struct amdgpu_device *adev =3D file_inode(f)->i_private;
> >> +       ssize_t result =3D 0;
> >> +       int r;
> >> +
> >> +       if (size & 0x3 || *pos & 0x3)
> >> +               return -EINVAL;
> >> +
> >> +       r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> +       if (r < 0) {
> >> +               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >> +               return r;
> >> +       }
> >> +
> >> +       while (size) {
> >> +               u32 value;
> >>
> >>                 r =3D amdgpu_get_gfx_off_status(adev, &value);
> >>                 if (r)
> >>                         goto out;
> >>
> >> -               r =3D put_user(value, (uint32_t *)buf);
> >> +               r =3D put_user(value, (u32 *)buf);
> >>                 if (r)
> >>                         goto out;
> >>
> >> @@ -1206,6 +1243,12 @@ static const struct file_operations amdgpu_debu=
gfs_gfxoff_fops =3D {
> >>         .llseek =3D default_llseek
> >>  };
> >>
> >> +static const struct file_operations amdgpu_debugfs_gfxoff_status_fops=
 =3D {
> >> +       .owner =3D THIS_MODULE,
> >> +       .read =3D amdgpu_debugfs_gfxoff_status_read,
> >> +       .llseek =3D default_llseek
> >> +};
> >> +
> >>  static const struct file_operations *debugfs_regs[] =3D {
> >>         &amdgpu_debugfs_regs_fops,
> >>         &amdgpu_debugfs_regs2_fops,
> >> @@ -1217,6 +1260,7 @@ static const struct file_operations *debugfs_reg=
s[] =3D {
> >>         &amdgpu_debugfs_wave_fops,
> >>         &amdgpu_debugfs_gpr_fops,
> >>         &amdgpu_debugfs_gfxoff_fops,
> >> +       &amdgpu_debugfs_gfxoff_status_fops,
> >>  };
> >>
> >>  static const char *debugfs_regs_names[] =3D {
> >> @@ -1230,6 +1274,7 @@ static const char *debugfs_regs_names[] =3D {
> >>         "amdgpu_wave",
> >>         "amdgpu_gpr",
> >>         "amdgpu_gfxoff",
> >> +       "amdgpu_gfxoff_status",
> >>  };
> >>
> >>  /**
> >> --
> >> 2.37.0
> >>
