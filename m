Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FB498FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 20:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358588AbiAXTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 14:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349080AbiAXTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 14:41:00 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763AC07A96D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:20:09 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id y23so8784971oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 11:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8UlOKPL4x0I+w9FvmczKZQzjM11WitOpHu1NnDd7hI=;
        b=EIvsCF/shkSJKYfdjXZKNXCsVd70UCSlAARnO6sDbsxiWBHwhD/82BOJnQrXDl9IOz
         PFcMdh5ibyXsaAQcTPODkOpuxlRpW6Ykx3+iaL0mfu3o/5TQuzEDx8ce/CsAPrzpsBH0
         Aq1xw2ZjdD9sgudMll8flbupKTmKPw8pARBNeIt/gt3ZmOXc0U4ez/5KDdbtmSmdJ/cY
         A7Z4/te+96euwxEnd8/NJBr/0001w5zlvvzIJi/j/otI7/zc1nWeoYlU4o4Pp+0rrOEb
         sMg62TePWcfT120HGmcpZPJ+W8BC4DVZ60OxaL1hE3s2BVUOxqLUUgtgRqjyoHlrl8LB
         UFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8UlOKPL4x0I+w9FvmczKZQzjM11WitOpHu1NnDd7hI=;
        b=VFGyM+gedOMfU45UPgkWdCuK45LG3TLpJeTFyrMiCEl0dUKG7SucsG6dVuJ21vshMJ
         Y6eseNs/fyZ9wD57AtUGaDDXbgEj5z8yESQY1J/J5tN6SSxLLCQT6ETLfiV+OqTADgts
         X42O+rUQfeeSFzFnhde/CSH6yJ/vQV/5NdzMBfpZdb7xhSPoQZ4KzK1PxvHcOZP132Nv
         Vk0UCjH7kUa5vFdGtqt4QQYmrN1OqbpkwoWW8HBROfEOxr4vBxRlLvP1NWOb27N8wkul
         uCg1EBJnS5qqYdefY4rfS9S2jDPvyaxTy8uyTLTgbX0BTgIxBbTq1xmYvu+fYAftfhjn
         mH1Q==
X-Gm-Message-State: AOAM533yM20s9Dae1HfIIvOSANHRF/SODuVsp5UgaW/9wAUoWuo/E09O
        7D6jXnm+f0djFCJXET3US+gh2c9+h5yL6/LpKDuWzGQc
X-Google-Smtp-Source: ABdhPJwS85QtnAAmIxiRJFhdMAqQlvW1zcZquOPGUFZLskhO60Qo5Zms8Ge28nzBDwYGw0SYuP/P8X5DerGCwVBWtfo=
X-Received: by 2002:a05:6808:300b:: with SMTP id ay11mr2766540oib.120.1643052008712;
 Mon, 24 Jan 2022 11:20:08 -0800 (PST)
MIME-Version: 1.0
References: <20220124165552.56106-1-zhou1615@umn.edu>
In-Reply-To: <20220124165552.56106-1-zhou1615@umn.edu>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Jan 2022 14:19:57 -0500
Message-ID: <CADnq5_MPvHgnW-Rpv-caNrgg+9XkVFZs2Oes1gKPyj=TesBKXw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display/dc/calcs/dce_calcs: Fix a memleak in calculate_bandwidth()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     Leo Li <sunpeng.li@amd.com>, Kangjie Lu <kjlu@umn.edu>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jan 24, 2022 at 12:05 PM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In calculate_bandwidth(), the tag free_sclk and free_yclk are reversed,
> which could lead to a memory leak of yclk.
>
> Fix this bug by changing the location of free_sclk and free_yclk.
>
> This bug was found by a static analyzer.
>
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: 2be8989d0fc2 ("drm/amd/display/dc/calcs/dce_calcs: Move some large variables from the stack to the heap")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index ff5bb152ef49..e6ef36de0825 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -2033,10 +2033,10 @@ static void calculate_bandwidth(
>         kfree(surface_type);
>  free_tiling_mode:
>         kfree(tiling_mode);
> -free_yclk:
> -       kfree(yclk);
>  free_sclk:
>         kfree(sclk);
> +free_yclk:
> +       kfree(yclk);
>  }
>
>  /*******************************************************************************
> --
> 2.25.1
>
