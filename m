Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445B34F6477
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiDFP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiDFP4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:56:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FEB24A12A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:20:01 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id e189so2329754oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nR+sDilSKYVfN9qDJ/g98wvIu+WPZhJinVPgYGsVVDE=;
        b=iprevJ6Fyj+Zg9sDtMftRf78BwUL9DqO4cEkI/ScLzlTDexBgwMjru/ra3o0B7l1gu
         OJ20vYFsppHRlvKzZC28kzKR1hMyQwEsq9luV9cffZWeNE3vD+xf2WJv0Ca0dXadfQlj
         953oj+T6OUBOFGr+ot77RkmEcJoYJLsVMzPoMCP3RjNP7dekojnm6Fk8nu37iGq0duT8
         e08lmohwbasaykFFyW0Y/V5gQmgMHRDYdkmMKNwiglGCPR+86ugUxeRMo0SxI3b4z3Wx
         D+4wb3YcZzZLkr6ytY77qTmzkcgBjeoIIkpuRsjLV7h5+4hL294JmkK+1N9vxQ5eNgOf
         joTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nR+sDilSKYVfN9qDJ/g98wvIu+WPZhJinVPgYGsVVDE=;
        b=rCGQlgvVnzUO5PlxpMkStYfk6tmE5W+VJbQ3xGsPEFuKhexSY9rfqexS65EErrJykT
         bFKmSPCOkwuZlg6eTC5Fe+smXhzxSJbhf+dkKbEp+hW852RGsiQgfhQ2vxbpe64iNXPv
         io4sqlosvIQqHVSyMjSMect8haTt6HOZ/Oj6PBY5I1jvSYrGsg5ETBA55zbMgbKObNaF
         7NTAVy0W5Wgz1cHDVqm1O9Bmu1TYjMLhq6PGO2l1mzPwQprqC59ubXaGn5xNiAcb84V2
         MFM6IRyzppABmekl78w3XoI5Raq5Sij6JXyyZ2aOntNTsjOxereVwbiHtPlZ5FFuVBbD
         0z0g==
X-Gm-Message-State: AOAM530ijTQLCpeeBHDwSZxVr1FqA5xj6Qt0/IQhwpDRdO0BGXrEeFQn
        LL4Ne2nEhBL7yEh5ii3BoPcXPKD+N5SsoDHPZtA=
X-Google-Smtp-Source: ABdhPJxyBFYsPElegdy6BaOXxjV6Kp33EHLXtBFktwHpS2gGqYGmZq94oWBFPsv+aCywyMrwUMjhsjcBBwjHvTN7c2g=
X-Received: by 2002:aca:d04:0:b0:2ef:8b45:d235 with SMTP id
 4-20020aca0d04000000b002ef8b45d235mr3630825oin.253.1649251200316; Wed, 06 Apr
 2022 06:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220405213800.90205-1-h0tc0d3@gmail.com>
In-Reply-To: <20220405213800.90205-1-h0tc0d3@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 6 Apr 2022 09:19:49 -0400
Message-ID: <CADnq5_PXDyOXX2p4FswWWyY6sw8nXmajhUzx-=ke+6jiZn3ZPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Unnecessary code in gfx_v7_0.c
To:     Grigory Vasilyev <h0tc0d3@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Joseph Greathouse <Joseph.Greathouse@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 4:00 AM Grigory Vasilyev <h0tc0d3@gmail.com> wrote:
>
> The code is useless and doesn't change the value.
>
> (0 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT) = 0
> gb_addr_config | 0 = gb_addr_config
>
> Perhaps there could be 1 instead of 0, but this does not correspond with
> the logic of the switch.

It doesn't do anything, but it helps the developer to understand how
the driver state maps to hardware state.

Alex

>
> Signed-off-by: Grigory Vasilyev <h0tc0d3@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 1cb5db17d2b9..5ed84a6467ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4409,16 +4409,14 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
>         /* fix up row size */
>         gb_addr_config &= ~GB_ADDR_CONFIG__ROW_SIZE_MASK;
>         switch (adev->gfx.config.mem_row_size_in_kb) {
> -       case 1:
> -       default:
> -               gb_addr_config |= (0 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT);
> -               break;
>         case 2:
>                 gb_addr_config |= (1 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT);
>                 break;
>         case 4:
>                 gb_addr_config |= (2 << GB_ADDR_CONFIG__ROW_SIZE__SHIFT);
>                 break;
> +       default:
> +               break;
>         }
>         adev->gfx.config.gb_addr_config = gb_addr_config;
>  }
> --
> 2.35.1
>
