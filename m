Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9845F4B59D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349691AbiBNS0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:26:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiBNS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:26:15 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99979488B6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:26:06 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so20298784oos.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlSvtvFbST+JRiZy0nw8qsurosZlPyiaBzL4u9A7NPg=;
        b=HXqACW//Zm0115qK79VxKxElAYlr95AzBf3cBr6QuimTb9boq0VaCrFqwmZvXHTKI0
         wKgj5UvN50iY0OiyrcX6/VJPFTxIBdus86P9uDgMpY7COalhtCiMDuUuNkmlHbDOMFVb
         7c/d/mm4z92AXKDl1cngznbb7e/JgfyeqwLfiV4dnWnr9nBwruWYPE1VizPeGLJfYvWI
         7NwGpT7iZsmEYd4jGbrlyV5wgk4jv2b7smJtuJ3GDbWT+eRbKGnewN7kUrlHZD7B1AEI
         Oiq83ESXQFphER2f1zpQGtfPQD7KZuYuCSsMt7OAkw/q8fXEk03RR3RKro0Ww3Cc5fwz
         yx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlSvtvFbST+JRiZy0nw8qsurosZlPyiaBzL4u9A7NPg=;
        b=g+klEM2ZHGeq+Ok0QAlmXuEn7c2kOFfXQ3GcKSw37IqOavMiuxRbn7Z+ivhtEsJQIZ
         0lRmxCd7ff3PyKLZNAPQxlVPnT6b9RTV1g9rYQH310YFAmxP28gRsYiJTeMbygiYuRWx
         E/Qn/SB6DQm+D7DcyHa0HOHPXmYjTLOPlsi+dJ/3oLsktJmx6fUl2pW4DaINstkLZf0P
         DgnOw63ZsiAckPNx3OL3n9uss+DI6YPDv8x94aehnn+DO7njZfI/4na5C+WfxPSDdmyz
         9PIHBr/taJ9D9EfTF/eMlabopg7JiAEcPFvTWxoer7R5m90XoN6HlpmSW8f9uU3rgcLH
         i4CA==
X-Gm-Message-State: AOAM532/CUrGC5lfsH/HeeeTEGFbAFJ9eRF/+o5e/IBMz9XgGa3GPplm
        QWfIzMd22d/sbc1n7e6SYM3bW1dnvLSRTUb8z9g=
X-Google-Smtp-Source: ABdhPJwwkbSacvGQlLKe3Ok3VHnEV3xZS3SoGcqpH7A0COkvlXN8wexYw97Y95QA9d+schJeyBmufa9z8v8pu+r/cg8=
X-Received: by 2002:a4a:d583:: with SMTP id z3mr20564oos.68.1644863166025;
 Mon, 14 Feb 2022 10:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20220214182224.2906060-1-trix@redhat.com>
In-Reply-To: <20220214182224.2906060-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 14 Feb 2022 13:25:55 -0500
Message-ID: <CADnq5_MrrTXmVPv7ukkpq-+WWn7cKbF9CHjhsBnuRzqbriUN1g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check return status before using stable_pstate
To:     Tom Rix <trix@redhat.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        "Nieto, David M" <david.nieto@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>, "Xue, Ken" <Ken.Xue@amd.com>,
        Roy Sun <Roy.Sun@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        llvm@lists.linux.dev,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Mon, Feb 14, 2022 at 1:22 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this problem
> amdgpu_ctx.c:616:26: warning: Assigned value is garbage
>   or undefined
>   args->out.pstate.flags = stable_pstate;
>                          ^ ~~~~~~~~~~~~~
> amdgpu_ctx_stable_pstate can fail without setting
> stable_pstate.  So check.
>
> Fixes: 8cda7a4f96e4 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 1c72f6095f08..f522b52725e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -613,7 +613,8 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
>                 if (args->in.flags)
>                         return -EINVAL;
>                 r = amdgpu_ctx_stable_pstate(adev, fpriv, id, false, &stable_pstate);
> -               args->out.pstate.flags = stable_pstate;
> +               if (!r)
> +                       args->out.pstate.flags = stable_pstate;
>                 break;
>         case AMDGPU_CTX_OP_SET_STABLE_PSTATE:
>                 if (args->in.flags & ~AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK)
> --
> 2.26.3
>
