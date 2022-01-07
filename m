Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD72487E01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiAGVI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiAGVI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:08:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AEFC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:08:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w80so9901204oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O7pvSOfIkV4dqbPfuv/2HOh0xU+VB9JiCav0R4FD6b4=;
        b=pr418NVHAUExpVkYCuuatPAeH6dxKsAdEKvI0rruXEbnOAk1Lj5AVEaq989nHFeUP8
         xFXlhLn9+/zsAiLiBpNCuk/bu+LDmSXRqEUKrwmXopsHTlWrM/g8pmJFPlTb2UktTcWr
         JqGGSfdJ4qMpZSig3S1uwVD4RBOfLcbRmilmvSlg5EPM6SHY3VdPHEicCzSZm027pzuz
         XLfEmyV48472KMtvVCa6qRclsTAKT4HXpNFmqqkk0eMFXEoA3U3sWRMBSaPFCqAzlujY
         5uNx2OIq8a4bjewwDKJ2rZNWs0eRbtYpB98v/XGOckHWULrSUB+AhAgj0MmZbvmCXgG2
         YXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O7pvSOfIkV4dqbPfuv/2HOh0xU+VB9JiCav0R4FD6b4=;
        b=hT0z/A8p5jzbpcG+aB/B7KW/3XruIw7o5VUZjc0IK2lNxEIZckyXwnC3wcR3AiPVhh
         M6W11Lm5r+DRARxBxq+STGEoBOe7F0LdH5s/9Zwmroo0EF0pt5L1Q/Pq9WjO/QRe0X7z
         SuJTwAR5q0IzmOhnjLqJzW+ny1HgmzYODwtV6kfXRuSs8MTOyMoxlK8u3mohxEMDmHiz
         NfECuO91xX9D72vX20a0I+Lzv5X7VG0ZD+18/+LVIKyO98wGTaoQwHJ9nFXSkpmlaY4Q
         NHkXQFGkk7rwBK5ynOMlre8RAMAhC2h4MxpFVPn9S5O0YrFMesRnBqPX1zf+xZFi52Yb
         FUSg==
X-Gm-Message-State: AOAM533aKa5jDjuKLBwwQNPsQZgZ5oF4i90i4MTGEAtfuRiL0Fuwujb5
        hXFb1aES/KWZ+rCgP6tEdd2c9WHXMmnrCEHS2ns=
X-Google-Smtp-Source: ABdhPJz/BW/3gQ7COMiFX5lVTDRtnXMjaMVu4RoviTgP8z3CUc0YhYzZKKZOXmlZyqFiTsL0pwvkpb21SPSJvzf4f90=
X-Received: by 2002:a05:6808:68f:: with SMTP id k15mr10755798oig.5.1641589736048;
 Fri, 07 Jan 2022 13:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20220106095610.3275631-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220106095610.3275631-1-gregkh@linuxfoundation.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 7 Jan 2022 16:08:45 -0500
Message-ID: <CADnq5_Mwxto+cp3MLmkWchzos8yeXaLqtJPFkZkyvWHR4_e+ug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Kim <jonathan.kim@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        shaoyunl <shaoyun.liu@amd.com>,
        John Clements <john.clements@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:56 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the amdgpu sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jonathan Kim <jonathan.kim@amd.com>
> Cc: Kevin Wang <kevin1.wang@amd.com>
> Cc: shaoyunl <shaoyun.liu@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index 567df2db23ac..94dcb004988d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -208,6 +208,7 @@ static struct attribute *amdgpu_xgmi_hive_attrs[] =3D=
 {
>         &amdgpu_xgmi_hive_id,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(amdgpu_xgmi_hive);
>
>  static ssize_t amdgpu_xgmi_show_attrs(struct kobject *kobj,
>         struct attribute *attr, char *buf)
> @@ -237,7 +238,7 @@ static const struct sysfs_ops amdgpu_xgmi_hive_ops =
=3D {
>  struct kobj_type amdgpu_xgmi_hive_type =3D {
>         .release =3D amdgpu_xgmi_hive_release,
>         .sysfs_ops =3D &amdgpu_xgmi_hive_ops,
> -       .default_attrs =3D amdgpu_xgmi_hive_attrs,
> +       .default_groups =3D amdgpu_xgmi_hive_groups,
>  };
>
>  static ssize_t amdgpu_xgmi_show_device_id(struct device *dev,
> --
> 2.34.1
>
