Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BC550A21C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389155AbiDUOZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377277AbiDUOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:25:04 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFAD3CA61
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:22:13 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-e5c42b6e31so5491477fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZA1nLvyjkEKFlKU13Ct8Zcggn9No1V/TQja+nO/faEQ=;
        b=ktL17Cj6uxm1d8rlfHQmBEZKLnaSLLe5PpUY2ZqhnghpGiiTh+2K1s49i0J27IO6OP
         bNH73ajK8s32WdPHv4rQDkve1ZTTzunyr07WVpeunELbQajFXtZKjUOMh0vQeKogJV3X
         QmRE0CBsSIy1krXFTtFDOwJIYX9tqBmJYnEISGPOaj98kJz1AGPtWL8pHLx7nxKmTAXE
         StOoQZhEeq1h4Cir209U0ekOW81ntYRvcd3+kcQvhVOrnKsm+fqhG8VqVzsFal0syjzG
         kCtPnwa7aa7Rxoq672eRyaC7lYMRhDoN1XoZeMkua/VPICh3BB3iC/ea5qFG492kuzgF
         a7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZA1nLvyjkEKFlKU13Ct8Zcggn9No1V/TQja+nO/faEQ=;
        b=mxVvAohRUPsjnDYAA2A0yHq9oPawygw1Nuj5ZtcF7YJcKX2SaOpmYmklj0CmHtC1Tm
         d3T6o3J2AJV4FcqWlGtXypYviYRyCRDPXW4hK7zoeL/E6lqepcDKd5MKcpuunz7yylNg
         +KZw7VoM0BCPlQZXFJvpSxbRB17gB4rLjqzQAJ5GGL2e8bakPb7vJSwxz8Zm2A1j9xzl
         fe/6LA+gjvSykHqGa7TLdOu79PikchCMYYcXM/+x1NuTPnJooMUfhQQd+XUoR1/0sQ+8
         nljgHbtlIhBjpb59ty+D3U4m5S5qZ0s7N6lAdl5biI0OSwW4ySWuSOLBonu59pY7nxs7
         ieNw==
X-Gm-Message-State: AOAM532lwOApHchhr8fQwKJRoNWjVWDXp1Ogw04ve1mb2frg59BoIUpg
        trxNGO06pR6CSCLKZIDHCxTpClr7ROFBIPPO6Hg=
X-Google-Smtp-Source: ABdhPJwdcFUTy302SbkU43iy2JjACHiNzRqpLMiYsjwPQr1h9uPJjSSl4frEETdF6Ei3oxMo+vV1SrEPpLOJHi9L4ao=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr3772925oaa.200.1650550933142; Thu, 21
 Apr 2022 07:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220421090313.24864-1-linmq006@gmail.com>
In-Reply-To: <20220421090313.24864-1-linmq006@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Apr 2022 10:22:02 -0400
Message-ID: <CADnq5_PawNQThkhwMW4=GY4TOn1DLsvG_zUONYwf0WtGx0i8GA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix memory leak in dcn21_clock_source_create
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laktyushkin Dmytro <dmytro.laktyushkin@amd.com>,
        Solomon Chiu <solomon.chiu@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Victor Lu <victorchengchi.lu@amd.com>,
        Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
        Melissa Wen <mwen@igalia.com>, Angus Wang <angus.wang@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Apr 21, 2022 at 5:03 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> When dcn20_clk_src_construct() fails, we need to release clk_src.
>
> Fixes: 6f4e6361c3ff ("drm/amd/display: Add Renoir resource (v2)")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> index 3fe4bfbb98a0..faab59508d82 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
> @@ -997,6 +997,7 @@ static struct clock_source *dcn21_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> --
> 2.17.1
>
