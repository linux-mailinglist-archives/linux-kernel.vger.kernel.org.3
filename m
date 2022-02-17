Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3896B4BA5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiBQQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:32:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239801AbiBQQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:31:57 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBCA1A3AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:31:42 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id p15so181264oip.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bElm5YilB/9jblKEU64fD/ESvy8c+wLEV4cgX1XhWn4=;
        b=Eq1tUKgqg59a4QA5ulUqAVWGJmM7UV+1lWzQXL+zegdCS5/d4qsDlC5deH1OCwWstU
         +C+uqqiZW2o3xKjbO23EnJl0d5uDvEe0lBrIH9PC5UwZ/u7Ts/hHBW7kzkx3yt4hxJ2M
         rw3a0q7ng+L5mm+KXKUAhVfwJoa1z3hmwUV7t8JtlBRa9fIOEL68OVNeV4kmYlgnkITW
         EO5lyysg+u3N2lBo8T8NUN78/kNWlDRnW35krNMGCsbBxLBuhxTgjQcvYJZ0rVp2HesJ
         QStSRNSpghG4F6RXqxSrxcLIbzpF0KewldPbmspmkxAT1On4cwLlW2PHhXBBIHEFLBVn
         5PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bElm5YilB/9jblKEU64fD/ESvy8c+wLEV4cgX1XhWn4=;
        b=E2gs3v1A8/8qfoFObOYve2h4kUz8fXNl23L/JbZsrbgvp20s4l7B/nLWCN/aFdtY3M
         Ge8AEzjUVh/5jm+YAxhqg//U0MmXjPgapZIuDoZXU0oieFlxE7BpVQcdEufy9eQxlbfR
         hN/zAg7tgY3fqQoevXLYldvtelSi1jX4plWVe7YV1SZjRCe+MuXFN1NPpOke1J/r92pP
         lN8k4JvvWb0KT3TO+vPw3ZPR4wkXA1xG5pvaTMqxrWhEOp0Kz+zlF354EGDRoG+7ztua
         rSXJJh1nNZLNHgwVgDqja5VCBDMRho5OCg4cHBOEyhA4RWSrNPllAEEMYd/hf7duJwc4
         PC5A==
X-Gm-Message-State: AOAM531DufcP8gVzXfsdIh9tfET2N7gMWnLtVfQjPQNks60YOcsRbIwI
        d9xsUntirHAFIfamQBuNlrtyt4Zd9BgFX6x33ESPMwek
X-Google-Smtp-Source: ABdhPJx6a+RRNxIK4nxCa4AWmBuTIaxNxYd6UitmMWxs/iXH4phTUwHGWoWwQkdU27X2KXRi4tD18lfFTVADnZA347A=
X-Received: by 2002:a05:6808:f8b:b0:2ce:6ee7:2c99 with SMTP id
 o11-20020a0568080f8b00b002ce6ee72c99mr3205163oiw.199.1645115501464; Thu, 17
 Feb 2022 08:31:41 -0800 (PST)
MIME-Version: 1.0
References: <20220217162142.1828990-1-nathan@kernel.org>
In-Reply-To: <20220217162142.1828990-1-nathan@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 17 Feb 2022 11:31:30 -0500
Message-ID: <CADnq5_PmT3aWqGR7fAYxAvgAv7875kGjKo5tAQyGKeYuRrvAZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use proper enum in pm_unmap_queues_v9()
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Jonathan Kim <jonathan.kim@amd.com>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Thu, Feb 17, 2022 at 11:22 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_packet_manager_v9.c:267:3:
>   error: implicit conversion from enumeration type 'enum
>   mes_map_queues_extended_engine_sel_enum' to different enumeration type
>   'enum mes_unmap_queues_extended_engine_sel_enum'
>   [-Werror,-Wenum-conversion]
>                   extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 error generated.
>
> Use 'extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel' to eliminate
> the warning, which is the same numeric value of the proper type.
>
> Fixes: 009e9a158505 ("drm/amdkfd: navi2x requires extended engines to map and unmap sdma queues")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1596
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 806a03566a24..18250845a989 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -264,7 +264,7 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>                                         sizeof(struct pm4_mes_unmap_queues));
>
>         packet->bitfields2.extended_engine_sel = pm_use_ext_eng(pm->dqm->dev) ?
> -               extended_engine_sel__mes_map_queues__sdma0_to_7_sel :
> +               extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel :
>                 extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
>
>         packet->bitfields2.engine_sel =
>
> base-commit: 3c30cf91b5ecc7272b3d2942ae0505dd8320b81c
> --
> 2.35.1
>
