Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C647A4AC99F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiBGTba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiBGT0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:26:20 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA2C0401E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:26:19 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z20so21178901ljo.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AJag/A5JmvykTiv6EpL4n31ZcZevEf+cXwTOlC0tOkg=;
        b=q1Hb1u5r9+AsViUlf6UZzxNWWr4GQprtIzge2G5bWfH70p3weWpX0FICkMAfCmkQSW
         DxgfdzQE6MACnIaDHskjXVgPZotUPDpBaHrW7ATyVti21B//sFUL8rxetrFLrYvP+b9F
         4o+LGmKu257u9/1LtqMQ+GhZ4MclAaFkmv2BmZ8JEy/LHyw1sb1hB1gUgMg4y5Ld4IM5
         tJ31LDi71OAbJlJwPOZ8x3SIhG9TLn96RRZPV9+jyJD4SVx4VtmZA5hyKpNTsTwCyT+X
         MBzdf/hKqWdwyskNBWuTAbzc/LRz7r8p7GK9DgeuRqvoHUUPsMLbtYzYn516lryInL24
         Sgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AJag/A5JmvykTiv6EpL4n31ZcZevEf+cXwTOlC0tOkg=;
        b=32hr27OUWBqQe3sN9wu0wtyUdfNJzm2YOQd7+D0MRs6rlpfyxbiIVfgaBh4p6tU6n/
         Ae+xZ5VU57GOzeHCCOAf0dSIZQIQAEnvDIB6uw3RBlp91ImYPpZ8ZsenFCinqXI8BrjC
         fyhzRuN6eDnk7SJi4s/Ylfs0Lx7nsEG2/6IjYuwpqYjZPrKccR2LSBt04EU7JT9jbLg/
         I5/MSdIR8PLdHjzdU3b2j+zvUy2leeUNXYjZuCbolPC+9ozAjlqEclGHojQ5bwVOnoEq
         GwRCjHOa5ZUtFaWdiYyRGCWPVYWVaD8jQUzWmJUDrnSejDWMHLp68qCFHdQ9hBUe6is9
         MqMQ==
X-Gm-Message-State: AOAM533xtYupC+Rs59NMK9rNXwJ4lLkd2AjBuhEn8dpH1u+pX09/UvuB
        hqKFuPge6GCfLevFv10xx6aA4icHtuQHO8avDdfyl4P62Y8=
X-Google-Smtp-Source: ABdhPJxiRwBDrZ7qHrwkeYZzKApFxOfBT0kt7xuCw9xbG3ufLrmJ9Sb/VD/Nm0ot8LNlflSABDiDmjBvKBn3HS7qJ1s=
X-Received: by 2002:a2e:980e:: with SMTP id a14mr617655ljj.220.1644261977984;
 Mon, 07 Feb 2022 11:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20220203152305.1846862-1-trix@redhat.com>
In-Reply-To: <20220203152305.1846862-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Feb 2022 11:26:06 -0800
Message-ID: <CAKwvOd=MviBd5iwSnhyt9aSZU+QTsBrBSGPcjsjt2eepfYC3KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ast: fix using freed memory
To:     trix@redhat.com
Cc:     airlied@redhat.com, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 7:23 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this problem
> ast_mode.c:1235:3: warning: Use of memory after it is freed
>   drm_connector_update_edid_property(&ast_connector->base, edid);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The second condition on
>
>   if (!flags && ast_connector->i2c)
>
> Means that the edid is not always set.  If the previous block
> fails the freed edid value will be used.  So set edid to NULL
> after freeing.
>
> Fixes: 55dc449a7c60 ("drm/ast: Handle failed I2C initialization gracefully")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/ast/ast_mode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index ab52efb15670e..9131dc8a1a2fc 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -1224,10 +1224,12 @@ static int ast_get_modes(struct drm_connector *connector)
>                         return -ENOMEM;
>
>                 flags = ast_dp501_read_edid(connector->dev, (u8 *)edid);
> -               if (flags)
> +               if (flags) {
>                         ast->dp501_maxclk = ast_get_dp501_max_clk(connector->dev);
> -               else
> +               } else {
>                         kfree(edid);
> +                       edid = NULL;
> +               }

You probably didn't need to add the {} for the if, but it doesn't really matter.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>         }
>         if (!flags && ast_connector->i2c)
>                 edid = drm_get_edid(connector, &ast_connector->i2c->adapter);
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
