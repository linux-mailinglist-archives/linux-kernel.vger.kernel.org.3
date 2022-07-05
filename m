Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1426C56722D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiGEPLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiGEPLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:11:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED0CEF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:10:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d2so22228367ejy.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dkpN1b4wP9gTZUtEgRoxQX0uUzfu9gESHo4XVBhNNPA=;
        b=jtX3byuXyfc2mF/rBU1M4/i77Y3tRdz2XH46byqIsfIKKhOLkoBSf+LTlU7hrA6X2j
         8iKu9cxdOL/P9b6KmRtmTaKvprIJ42mVGAdpNqhVtfAnpBOjqNtHWcfnTd9JOfMluq8V
         3t1exD8XY3OfFVfq50fAeo620chL6sdXcvktq3qjgBgPHwRkEFXmlhFtILjfrXZ7fGPo
         9FbxvE388pdW6PVWA7jDHcswPCzy/j0JPDhP/6OeXV7RewR9E/G+8J5C9H0gSaM3GiEl
         K80kZ8LmV8wNAJbNoZM+6zll2pSiw1hlxn0S+ZFqHHULCmt4KZXnUHUeQRnKzYDsKYYQ
         iG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dkpN1b4wP9gTZUtEgRoxQX0uUzfu9gESHo4XVBhNNPA=;
        b=4M6o90b91PcrZWo3AJOTnaCyp7rIgeMBMH9z3Wykc2/aLnVEsYr8hXbErEBG7IdLjT
         AT9T6PXGfZgw3cTwOibBotoexO8mOX9bw5Ow31kQdBMA3b4a9a5Dd+8dAOH+aaPtJvbH
         9buUfZuj7TRJHZCWieNaJn/IoSVX5l3JNcJHCdtasXvoNR8dqoboluin5rTkCIGaS5qu
         8ZEkY5rq0De9ohf8ePbbEQadGj0+q2rcx57rS1ZfRFkE07v8L6r0GCtZ+BAE8BgJo7n3
         n73IesdPOD1kloU+Eli+F68GVWBeV+g+h7o85pUDYE7sPs/sQOldg3PcsDYNC3qn/lMr
         bk3g==
X-Gm-Message-State: AJIora9XzVoqIDbt3/gxT2CvEYVlSLy3rhD590wUy9cBfFuDYDVqQ4S+
        rXQk336Btdb3aju45kfEfefNrBrjFt9Ccfw0GBA=
X-Google-Smtp-Source: AGRyM1t2xhRsfyqVg5935Rq05PnjacmxfFyEeFcbXVcIX7X+PnwWDRi5pnasbbuvQSDhCYj3EMsFY8eF4tcYWyJs1Sc=
X-Received: by 2002:a17:906:5d0b:b0:726:a043:fcb4 with SMTP id
 g11-20020a1709065d0b00b00726a043fcb4mr35047447ejt.508.1657033819797; Tue, 05
 Jul 2022 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220704134532.103876-1-andrealmeid@igalia.com> <db6ab6f5-e3b1-f068-37ac-807e1ff074a8@amd.com>
In-Reply-To: <db6ab6f5-e3b1-f068-37ac-807e1ff074a8@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jul 2022 11:10:07 -0400
Message-ID: <CADnq5_O3i2ciutAFS-uzX8bedOXxeOJUNWGRfsuOqpmL-tW64w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdpgu/debugfs: Simplify some exit paths
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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
        LKML <linux-kernel@vger.kernel.org>, kernel-dev@igalia.com
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

On Mon, Jul 4, 2022 at 12:23 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 04.07.22 um 15:45 schrieb Andr=C3=A9 Almeida:
> > To avoid code repetition, unify the function exit path when possible. N=
o
> > functional changes.
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 107 ++++++++-----------=
-
> >   1 file changed, 42 insertions(+), 65 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index f3ac7912c29c..f3b3c688e4e7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -383,12 +383,8 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(struc=
t file *f, char __user *buf,
> >
> >               value =3D RREG32_PCIE(*pos);
> >               r =3D put_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     amdgpu_virt_disable_access_debugfs(adev);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               result +=3D 4;
> >               buf +=3D 4;
> > @@ -396,11 +392,12 @@ static ssize_t amdgpu_debugfs_regs_pcie_read(stru=
ct file *f, char __user *buf,
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > -
> >       amdgpu_virt_disable_access_debugfs(adev);
> > -     return result;
> > +     return r;
> >   }
> >
> >   /**
> > @@ -441,12 +438,8 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(stru=
ct file *f, const char __user
> >               uint32_t value;
> >
> >               r =3D get_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     amdgpu_virt_disable_access_debugfs(adev);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               WREG32_PCIE(*pos, value);
> >
> > @@ -456,11 +449,12 @@ static ssize_t amdgpu_debugfs_regs_pcie_write(str=
uct file *f, const char __user
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > -
> >       amdgpu_virt_disable_access_debugfs(adev);
> > -     return result;
> > +     return r;
> >   }
> >
> >   /**
> > @@ -502,12 +496,8 @@ static ssize_t amdgpu_debugfs_regs_didt_read(struc=
t file *f, char __user *buf,
> >
> >               value =3D RREG32_DIDT(*pos >> 2);
> >               r =3D put_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     amdgpu_virt_disable_access_debugfs(adev);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               result +=3D 4;
> >               buf +=3D 4;
> > @@ -515,11 +505,12 @@ static ssize_t amdgpu_debugfs_regs_didt_read(stru=
ct file *f, char __user *buf,
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > -
> >       amdgpu_virt_disable_access_debugfs(adev);
> > -     return result;
> > +     return r;
> >   }
> >
> >   /**
> > @@ -560,12 +551,8 @@ static ssize_t amdgpu_debugfs_regs_didt_write(stru=
ct file *f, const char __user
> >               uint32_t value;
> >
> >               r =3D get_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     amdgpu_virt_disable_access_debugfs(adev);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               WREG32_DIDT(*pos >> 2, value);
> >
> > @@ -575,11 +562,12 @@ static ssize_t amdgpu_debugfs_regs_didt_write(str=
uct file *f, const char __user
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > -
> >       amdgpu_virt_disable_access_debugfs(adev);
> > -     return result;
> > +     return r;
> >   }
> >
> >   /**
> > @@ -621,12 +609,8 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct=
 file *f, char __user *buf,
> >
> >               value =3D RREG32_SMC(*pos);
> >               r =3D put_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     amdgpu_virt_disable_access_debugfs(adev);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               result +=3D 4;
> >               buf +=3D 4;
> > @@ -634,11 +618,12 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struc=
t file *f, char __user *buf,
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > -
> >       amdgpu_virt_disable_access_debugfs(adev);
> > -     return result;
> > +     return r;
> >   }
> >
> >   /**
> > @@ -679,12 +664,8 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struc=
t file *f, const char __user *
> >               uint32_t value;
> >
> >               r =3D get_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     amdgpu_virt_disable_access_debugfs(adev);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               WREG32_SMC(*pos, value);
> >
> > @@ -694,11 +675,12 @@ static ssize_t amdgpu_debugfs_regs_smc_write(stru=
ct file *f, const char __user *
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> > -
> >       amdgpu_virt_disable_access_debugfs(adev);
> > -     return result;
> > +     return r;
> >   }
> >
> >   /**
> > @@ -1090,11 +1072,8 @@ static ssize_t amdgpu_debugfs_gfxoff_write(struc=
t file *f, const char __user *bu
> >               uint32_t value;
> >
> >               r =3D get_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               amdgpu_gfx_off_ctrl(adev, value ? true : false);
> >
> > @@ -1104,10 +1083,12 @@ static ssize_t amdgpu_debugfs_gfxoff_write(stru=
ct file *f, const char __user *bu
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >
> > -     return result;
> > +     return r;
> >   }
> >
> >
> > @@ -1139,18 +1120,12 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struc=
t file *f, char __user *buf,
> >               uint32_t value;
> >
> >               r =3D amdgpu_get_gfx_off_status(adev, &value);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               r =3D put_user(value, (uint32_t *)buf);
> > -             if (r) {
> > -                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev)=
;
> > -                     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev=
);
> > -                     return r;
> > -             }
> > +             if (r)
> > +                     goto out;
> >
> >               result +=3D 4;
> >               buf +=3D 4;
> > @@ -1158,10 +1133,12 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struc=
t file *f, char __user *buf,
> >               size -=3D 4;
> >       }
> >
> > +     r =3D result;
> > +out:
> >       pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> >       pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> >
> > -     return result;
> > +     return r;
> >   }
> >
> >   static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>
