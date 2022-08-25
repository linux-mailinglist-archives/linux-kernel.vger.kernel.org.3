Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2585A164E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbiHYQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240803AbiHYQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:02:10 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB285AA3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:02:05 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso24286995fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sNFG5s7LnC8XjcoTGJvLHOo5cpf+AMAvCpxCgUj2R30=;
        b=fWZaRka9wUl4/qnh2iE8plD6aPudPrd3NC1h7pM8MDzeR2jm77ODxKAJxd3h0XnE9+
         5xhZi4dp6VjyYk3diQttP5OtSuRn+1qdMGKasRvT1BefIxQ/xW3iI82PCRYV2aYJr822
         l+6zFPnYaEgLoDMG2oWkfPCIb4focwG9dk56oSN2Za0eDsMw78jvZ9oTdoCXnBwUyG3o
         MFLuty8zPbMZQT6fkJGz+DYSh/Pj6vy/6X6XxXNh58SaYe7CiZf7JkXvehq/uGSZjjLY
         wHb0VmfbPjJ616zZYjc5NPYuFeD4bqzbO6T4+IwHdgqP+yajiSGuANzDbID+oTZyJypO
         FfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sNFG5s7LnC8XjcoTGJvLHOo5cpf+AMAvCpxCgUj2R30=;
        b=UyXQsrrznifZrBMGbEQnbr0emB5BRf7FE9LWvIdQdAik803ZLIt1n8g2zvVNoYimAB
         aWVsABCqdFwFYcatNmgD+IJGFKiQvJoy83J/Dp7VFz71XYNmom/ZZ/cCQbIrydDHoNBB
         40VGvtLaONPQ1bzRnWwlswGVfku6yWMcEDmVie4mOEdqzxHbgdvPCmZ/hAxME+wNTn6J
         jXMcLabOl3X9FRCD8MxSbQd64kr5qmWB1Dw42X88yVZSDBMuMKiFGM1zgwXWGl38vCaH
         fKqFUkpVxVa9fPAyf4Rb2TmlGbIVE8QfftZkUl+WtUmiRvLwln0w2aERzT18KAejt+6E
         Fm8g==
X-Gm-Message-State: ACgBeo2MGqMLCDEih9uObx8WjWz+5hCoUbzQi0EJ5L+szyWckwv/ABAB
        FyZnJn+0V0bqB/1+5zzpnFWVXLSLyRgjhGmYiDs=
X-Google-Smtp-Source: AA6agR7kiQ57XUkKXiAkkw2tu36haHCQjPWJKC0f16Gw0lXMggESritHc0IDxS7hh/vyn0Bw/EEhS9xLHMi8uy36klg=
X-Received: by 2002:a05:6870:9a06:b0:11e:3d19:2614 with SMTP id
 fo6-20020a0568709a0600b0011e3d192614mr943043oab.96.1661443325104; Thu, 25 Aug
 2022 09:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220823064137.13726-1-bernard@vivo.com>
In-Reply-To: <20220823064137.13726-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 12:01:53 -0400
Message-ID: <CADnq5_Ojb8U3gPckX3Ox3mkhQGTjusMOdneExcWZp_Zz8PTawQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: remove possible condition with no effect (if == else)
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhaojunkui2008@126.com
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

On Tue, Aug 23, 2022 at 3:30 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch fix cocci warning:
> drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c:1816:6-8:
> WARNING: possible condition with no effect (if == else).
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 85f32206a766..dccc9794e6a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -1813,8 +1813,6 @@ static bool dcn314_resource_construct(
>
>         if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
>                 dc->debug = debug_defaults_drv;
> -       else if (dc->ctx->dce_environment == DCE_ENV_FPGA_MAXIMUS)
> -               dc->debug = debug_defaults_diags;
>         else
>                 dc->debug = debug_defaults_diags;
>         // Init the vm_helper
> --
> 2.33.1
>
