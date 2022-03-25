Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF634E7D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiCYUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiCYUFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:05:13 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8001FE57A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:57:33 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 12so9285141oix.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3WA3uEzU6evsa9NtvKVO86NocKNUHHXu3Zd9/cIBo0=;
        b=N0Z1nffsPkCsDW8eucybePw7nIKmxEn2RQyj+8YGGusGgCI74EUSK6lic+GTjL+AMM
         h47o9i1mNItfS19TuAoAd+64zE1Bdz0V67O4xY+/pyomOSw47HYhKRYT60uCzDKF4wXW
         hAS4d2dEraDZJZLYAJKsVObaxbBm5B4VNFysZ8jG6+vt/2me5u0gRXTRtfBi/j8uIH7z
         Ovrcxp2kQbiW9fytcMTz7nJw78c9p75dw7uK94i0PGnI1fBKyZKPBA6/jYOWZOGyfcUw
         jQbbcRB1NgzYq04XoxE2zLlcl25a+D8HLRI8e7ddGWxsAjQ/dprKa1QkW9njZvA4OELM
         D0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3WA3uEzU6evsa9NtvKVO86NocKNUHHXu3Zd9/cIBo0=;
        b=ITL2bp2CGts2L6PJXQyYjEQt5dFZVmdwrRuvBXyJjgwXQZFp6dAi1G6bzeiakthMV8
         YEq79PpeOVnOuYfd7W6oiHAGUwCF2uPiV67f3KyRh3RBkDZtcLS2puMh4ipuSwKTEI7N
         JuyMT+xUNUCwxJ/+7iAJZ2rj8G1jxPJvMX7CZSPIpUIciavQJaUephiKjfPAX+DaiROQ
         +l+WhI4nhzj0qFYK/qw9FQqgWRFheGZOp8D49qi9pW8lB03zKwze64r5WxU2zSO4HCPZ
         Ub2vOrL6BpVUqJCTlOguZ+e2wK8r0n8W/kjxWPMuVJ6DKc9MrTvG8EkmyyUVMAdGXWcQ
         Knfw==
X-Gm-Message-State: AOAM531TlOwpn2/GetLHTcA/5Yb+RaAPQm8PLj95qau0T9+8rBikznXZ
        IT1Fh8JARNC9a70QX7Y0GRVEakPwymBSnyDYUKg=
X-Google-Smtp-Source: ABdhPJzXavjKXnhlCmjz6tN8Imhv9mBlkcg+2I2nbRoGFnQEQbHu+R1p+2A65WzONNlqdDzXnuos46sQdGiZvzhj/Q8=
X-Received: by 2002:aca:d04:0:b0:2ef:8b45:d235 with SMTP id
 4-20020aca0d04000000b002ef8b45d235mr6347662oin.253.1648238253170; Fri, 25 Mar
 2022 12:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <1648115162-5008-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1648115162-5008-1-git-send-email-baihaowen@meizu.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Mar 2022 15:57:22 -0400
Message-ID: <CADnq5_NyMsQ_NikyA4r=FULB4MwsjroENZGPgGo-tcAQhhxceQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix pointer dereferenced before checking
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

Applied both patches.  Thanks!

Alex

On Thu, Mar 24, 2022 at 9:46 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> The value actual_pix_clk_100Hz is dereferencing pointer pix_clk_params
> before pix_clk_params is being null checked. Fix this by assigning
> pix_clk_params->requested_pix_clk_100hz to actual_pix_clk_100Hz only if
> pix_clk_params is not NULL, otherwise just NULL.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 2c7eb98..4db45bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1162,7 +1162,7 @@ static uint32_t dcn3_get_pix_clk_dividers(
>                 struct pixel_clk_params *pix_clk_params,
>                 struct pll_settings *pll_settings)
>  {
> -       unsigned long long actual_pix_clk_100Hz = pix_clk_params->requested_pix_clk_100hz;
> +       unsigned long long actual_pix_clk_100Hz = pix_clk_params ? pix_clk_params->requested_pix_clk_100hz : 0;
>         struct dce110_clk_src *clk_src;
>
>         clk_src = TO_DCE110_CLK_SRC(cs);
> --
> 2.7.4
>
