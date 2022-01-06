Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9E486401
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiAFL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiAFL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:57:42 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98404C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 03:57:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r9so2511716wrg.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 03:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENdPYturLMBQCNNgwpLTjTkeuQD5zIfYK76z8GCeMs8=;
        b=QrEzROtO9x8lTVKieSna3jaRQXjuPgDwBLWEhKfh4L8ttXdrTTd7Q9cVxuDtLKtsxB
         Yka7a4cY80IRmxdfxR0pxZbmksiXwn98KVcTgf5RwRolMDrjaVE83Td/1Z3dR3mLx3++
         ccY8ns9EGt8IELLfZifP8ZsLDiXfL0eE9W+Wkb+hjWnVDGZzKO0ZW1vSVK567duYJoso
         cp4DEv3T6GECbzCSzeS4kDVaNbXy+ssOJlda3kFnDwJhOHDmtPhp1fH5jpgtarC6dT8/
         dgknFdtAipFPvLA3gELHhv6WTGiJew+UCLKOTy6dQMIZPHBUJ+b+g0OmeGzH7HHJ1Zjj
         EnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENdPYturLMBQCNNgwpLTjTkeuQD5zIfYK76z8GCeMs8=;
        b=zLJx7rGG8zplmVkscq7WcZ16zqpvpwsHcQLA/hvCu0pmjfTYmTRO0tcM0Jmt7xXH01
         b7gcnLrKW4mEFNPQBqG3gpGuqsVVGe1W/CJsfKueW3ZtxNqRdD+0ohMN/gctftBY8VlB
         B6IpHm+XXdbrF7pZKrvpyLKxCG6NqovIqRi0W9M9DBxTjCRDcflLscqPJVvxPyVn7Xky
         WS2QZn/dkn3kIRYdMTQWFqEj++a+o541Z/7G/C8K9HExUzNdyFSshg/RkJIh2YA9qhFU
         VSrclVcso3Ptwi1wzJTTcWvePVYPP3eNmQL3560Clsg3DLv1VPnswxzN4iYAfxsgI9rc
         PQhA==
X-Gm-Message-State: AOAM533LlAJaEzVNtTJYgqPvyHJ1Scie9TlHJ0EvGFktsW+VrmehnwmD
        JQHolldKrK8JeOY4IPmMwo6xYvMKbTDy+tLjw31A3cdV2fY=
X-Google-Smtp-Source: ABdhPJxZiF9wtSKnHcMfpyfw/zQHz3JTYsQ07e9gVX4ncIx5ryzekJ7/fQULWO53DEaQnfYTWkiDwsODW7Y10guZBSg=
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr51162670wrz.261.1641470260494;
 Thu, 06 Jan 2022 03:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20220105120442.14418-1-linmq006@gmail.com>
In-Reply-To: <20220105120442.14418-1-linmq006@gmail.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 6 Jan 2022 11:57:23 +0000
Message-ID: <CAPY8ntAdknutH=OmV1dWPbez1ZqLgaOj-BoQQkZAu0WbhbE6nQ@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: Fix PM disable depth imbalance in v3d_platform_drm_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch.

On Wed, 5 Jan 2022 at 12:04, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> The pm_runtime_enable will increase power disable depth.
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
>
> Fixes: 57692c9 ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/v3d/v3d_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index bd46396a1ae0..4f293aa733b8 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -300,6 +300,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>         v3d_gem_destroy(drm);
>  dma_free:
>         dma_free_wc(dev, 4096, v3d->mmu_scratch, v3d->mmu_scratch_paddr);
> +pm_disable:
> +       pm_runtime_disable(dev);

The dma_alloc_wc is done before the pm_runtime_enable, so the cleanup
should be in the opposite order.
Functionally it makes minimal difference in this case as
pm_runtime_enable can't fail, but could cause confusion/errors should
any other initialisation step be added between the two.

The pm_disable label is also unused so not necessary, however if
reversing the order then renaming dma_free to pm_disable would be
sensible.

  Dave

>         return ret;
>  }

>
> --
> 2.17.1
>
