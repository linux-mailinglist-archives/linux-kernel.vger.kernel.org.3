Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86C24F9E58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiDHUuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiDHUum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:50:42 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734281DE6D0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:48:38 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-df22f50e0cso10995452fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+nJ+IeQiG4mgvH4yV2XbF3SFHYdv7cMYexwmastyTY=;
        b=UWj9T0SgeOOrrMmgaYoiY5YEbtQ8lCvdCT1Zd/qLCvtxBpRlVuy0ODEQr6LU82RUx+
         wluGV7lYtv10KzBMhz5JCRgWTfRYVMkQCFecNeJvaCrFgnzHLcZtCJtWRp+Xv964J9R0
         YzZ/7shXdsoyiF/TSSXygZWWgFV+n6eoOycubsbu05zVCPVBIjG89VKFmykHzHmm8ifN
         1wKjUtsIYPQY+gWuBHhBGkCuKyzhpGXkfA0l7d1MJcrhinlCWa90UD/gysKZAB2Gu5LI
         ib4+VX0E8IX2dacXcBrPyRd3hD6M9KGcvo/lq2Q29shlbJZ910amW/jtqzZ//qiJd/rE
         y0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+nJ+IeQiG4mgvH4yV2XbF3SFHYdv7cMYexwmastyTY=;
        b=JVJ7ZCFQ7cO9yhIpxkJIwbQ8ljXfO0RJGwiwEYtiru9+nBEkOiGDNg8EARzQQVDxeh
         JLlyyatYlKL5drI1qwI/8dhPnKn30mQNQdzErU2Xs3qt5QsjbQFRrer1sl/IAl+feMvd
         6Akjoe+5uf80rhRS3t5xNHws7cI00LNQ6jEQNnFP6FCInJCh+rqpzRBak7DEpgnfKJD7
         CRnKzjfKGGY7rep9M76Q++zM08SuEZqbP3H8YrqDB9Hn9vh5HD8IV1rSOXxOmwW6xGjJ
         7WNhugZG5V68zSLH/DLAn3by20pccxRbK6dEKqaTBJTRV5syxOdWbWXWJMYqroWm7EaU
         Hx/Q==
X-Gm-Message-State: AOAM530nAgaaxp+0r3h8EBm6AqMcgAOqM64xs15OnW5RcEankrhRzlge
        l17SiWk4h5eoyR6IXG9Jq4Qw++HsEA4Cv4pRoKI=
X-Google-Smtp-Source: ABdhPJzADDrRgHZh+f5rLZNA7S5V+9Fw+9Ir2J07PL7HHDvDsX2UEx0lC2Ep81o0W4CBSPK3+syb59fvi83xxvw/4Gg=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr8928237oaa.200.1649450917768; Fri, 08
 Apr 2022 13:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407214659.2519967-1-trix@redhat.com>
In-Reply-To: <20220407214659.2519967-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Apr 2022 16:48:26 -0400
Message-ID: <CADnq5_MSrNYWJE0krKTs4SkOqsNtrVyM0PyQanO-YQYV+jSV4g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: change cayman_default_state table from global
 to static
To:     Tom Rix <trix@redhat.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Apr 7, 2022 at 5:47 PM Tom Rix <trix@redhat.com> wrote:
>
> cayman_default_state and cayman_default_size are only
> used in ni.c.  Single file symbols should be static.
> So move their definitions to cayman_blit_shaders.h
> and change their storage-class-specifier to static.
>
> Remove unneeded cayman_blit_shader.c
>
> cayman_ps/vs definitions were removed with
> commit 4f8629675800 ("drm/radeon/kms: remove r6xx+ blit copy routines")
> So their declarations in cayman_blit_shader.h
> are not needed, so remove them.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied.  Thanks!

Alex
