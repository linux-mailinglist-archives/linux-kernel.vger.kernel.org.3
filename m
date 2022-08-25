Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1800D5A1666
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiHYQKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242641AbiHYQK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:10:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4921260A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:10:25 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11c5ee9bf43so25475850fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Tg67a5ZgeqhuPMZYg/nl54FzBqCFxXTIGdWfFEYy1EE=;
        b=ROYRuJa9bi5ztQERSMgohHM+Vhzk9oqzNrGtvNhIXEMh+7PPU7qPG2n3Nx6dG8z6Jt
         2CNcvnurCzJd0eukc9iGHE8lP2vk/MqMnrM1OWwvOORN/jhy3OOmcEIt0UlNnaWcaUBA
         jU/+7XIU4prxNBhnAjGR3nAIOzdXOhsu21RtUHpZg7xuHXaVzIr5iBK4zXSHe+I1p92H
         v0TmWj4Zm42PFAF5WnB/CPlk8KdjkStB2gptDoRBo7hIcHLwRQoymoXVjjzhgSqqIbzo
         XH4xYTo/vEUixFebnY2efjBI2ik0QL5lzsf22gOE65iozFN9EutZP1zIwuCaXTl7hKyp
         K4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Tg67a5ZgeqhuPMZYg/nl54FzBqCFxXTIGdWfFEYy1EE=;
        b=Dp6Ko8diC6ZcnHsrqa9aSZ12qdZyGDL8nvLmU9dw84PIO0K04Hs0N8mOqkCW+zC7Yu
         Qr5gplgBQZR1OLERxv5/AhtNBd7Sq8NkRaffpRlyBNc+XQMkgdA0jSGKe/Koq92Gxfbw
         Ddx+LVzqEV616Ysf0qgnXWEjsyGjAfKgIhIK/9oEKI612jH119LHFJGj2T50Q+1EBbDt
         3xo8JpM97aTHvJmQPbsLNm7Or2kcVSQQoxdadQzop0PkyVabdhop0KVjyF1HbY2mU6Wv
         GPdXtlhvoBpHWDoP9xIL9dOKWY21vnBvTA/Lf7V3iCLJB4eM8yiMIx1masAY1ZgcXblm
         ROpA==
X-Gm-Message-State: ACgBeo3Bpylsem1md/VkC/JbmyJCkGb+NcaDo0JiCJk0FgD6Y5nKAsoE
        kJ47KOB2BQ/owZYrkoujc8HggDJ2qgFcfjaDHaw=
X-Google-Smtp-Source: AA6agR6tplrzH6OYDlgo1Ou22r/z1pFuZkIVOBBMLCIJUDZd/kTwZndnKvRk8EC2ZFI/QHXVhK24lfhrMbu1mll1uKc=
X-Received: by 2002:a05:6870:9a06:b0:11e:3d19:2614 with SMTP id
 fo6-20020a0568709a0600b0011e3d192614mr969158oab.96.1661443823611; Thu, 25 Aug
 2022 09:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220823065001.16872-1-bernard@vivo.com>
In-Reply-To: <20220823065001.16872-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 12:10:12 -0400
Message-ID: <CADnq5_MMGW4fxAt1oBxz1JcERjRRZ0YKDVWXfNNP2hE0TT69JQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix potential memory leak
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
        Eric Yang <Eric.Yang2@amd.com>,
        Michael Strauss <michael.strauss@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>, Melissa Wen <mwen@igalia.com>,
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

On Tue, Aug 23, 2022 at 3:29 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch fix potential memory leak (clk_src) when function run
> into last return NULL.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> index 85f32206a766..76f263846c6b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
> @@ -1715,6 +1715,7 @@ static struct clock_source *dcn30_clock_source_create(
>         }
>
>         BREAK_TO_DEBUGGER();
> +       free(clk_src);

This should be kfree().  Fixed up locally.

Alex

>         return NULL;
>  }
>
> --
> 2.33.1
>
