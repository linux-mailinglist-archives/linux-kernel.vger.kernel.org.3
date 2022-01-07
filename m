Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44B4487E0A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiAGVLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiAGVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:11:17 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D26C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:11:16 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id t23so9954122oiw.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CC7rkV9VPExvEz7sd8V96EKukO7uSQmnri+7pqYA5QU=;
        b=fimEXfjs2yx4VWXNRdfKBYbml4Uz5wUhad0i9v40w16BnjPGZWzn+tTl/ZGITRhzSb
         E6VZdKDd8vjLhndkI8jdAsthwzm0S97yCklMm24l2wD8r5/W4D+60ZEgvXTocekLJ5Uu
         tTyFKb7LVyosR4h7XqHmVQ45zrJSeMLafMxWpLNF7XqbULIDYhSmJ2YVDRhqzKRv/eX6
         EyZDyd2QQLC6qahyrloFUo/cYEMXFMWZ9ZRsGozPMjP1IF5We82NGRGAdFdGeCI2JtcT
         x6/lYT3rw0uE+Wg28gvwHAspNLp319p6SUlw97pB4e+sKDNC3TGVUxzY0PvXFD4GQc9I
         LbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CC7rkV9VPExvEz7sd8V96EKukO7uSQmnri+7pqYA5QU=;
        b=wc7fhS7fl0EGPK6BJ/kyS46BrAO0/faNCnASyLDU8xarroi5Tk9xyfcjkDYiiRmQus
         QRVuDnj3qaT3WDEahttxq6H3GUiLD5iZthKic8ttm3Hpu6fnK1937fxmn+LiJYYuGXLf
         OUt9NqRjNPiRBCtrQWeWP8UJhHvlpyrkUjmWU960h0zTF2Z2dwksIwe0ZGApCquucpx3
         olftZSzRUEIsSw3IFhJOPEhReVZ5yRsPO9sps6Y5zNF+ES6u/tAAiOWvA6EP6zQH9DIH
         P0ONPfqqvTPE36Y46n1r3LeHj2ca9RSGLJS0d0Gr/tWgwOmq8524YiSJBy6p7VCIVaxC
         YQVw==
X-Gm-Message-State: AOAM5300NePhdNN9YHdwE3S/eVquzO2T7VoWqMcn2VB21WDOb9buLA38
        suj70NmSDLDf9UTPwdEX3p1xVM2/e558ODjUKsk=
X-Google-Smtp-Source: ABdhPJzKm+S1E9EjLlqYZmiKF8D3k2idVtuWjR5VDpwCTDmfQHE/WUGGODf03izJ9cCWVRh/RmLlPgrYrYC2BC+hK7U=
X-Received: by 2002:a05:6808:4c3:: with SMTP id a3mr11268120oie.123.1641589876388;
 Fri, 07 Jan 2022 13:11:16 -0800 (PST)
MIME-Version: 1.0
References: <20220106095713.3276112-1-gregkh@linuxfoundation.org>
In-Reply-To: <20220106095713.3276112-1-gregkh@linuxfoundation.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 7 Jan 2022 16:11:05 -0500
Message-ID: <CADnq5_OqOUXHX-1Ri=BfhBwhSwwy=bxP_vPq2ejAF68kOGbLCg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: use default_groups in kobj_type
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:57 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the amdkfd sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index b993011cfa64..1f4a07f984eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -462,6 +462,7 @@ static struct attribute *procfs_queue_attrs[] =3D {
>         &attr_queue_gpuid,
>         NULL
>  };
> +ATTRIBUTE_GROUPS(procfs_queue);
>
>  static const struct sysfs_ops procfs_queue_ops =3D {
>         .show =3D kfd_procfs_queue_show,
> @@ -469,7 +470,7 @@ static const struct sysfs_ops procfs_queue_ops =3D {
>
>  static struct kobj_type procfs_queue_type =3D {
>         .sysfs_ops =3D &procfs_queue_ops,
> -       .default_attrs =3D procfs_queue_attrs,
> +       .default_groups =3D procfs_queue_groups,
>  };
>
>  static const struct sysfs_ops procfs_stats_ops =3D {
> --
> 2.34.1
>
