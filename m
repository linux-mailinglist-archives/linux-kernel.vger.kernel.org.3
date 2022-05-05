Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85151B5D8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiEEC2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238814AbiEEC2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:28:08 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E184C787
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:24:30 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id y22-20020a4acb96000000b0035eb01f5b65so506831ooq.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1b0HeUhFBeNKN2FYsIQkaN3rxaQMWP2KFVM4rsp4jc=;
        b=UZ0DrSh8fY2ykyDbM3LBeIwSBJ9QEY3Kgh7jT+0AADbpCXCf2WJxAxNfPXedRrbY3d
         XpibHEhpyIk1HyqalJ5MvHjYDejYiDn+T0nabIGwcCDckEEmWoWlWRV31Tk0P3eM4pSa
         0pfKhKWMAPSSaHkdeX7yX+1vOKWw8jvvWTjQThmO01WHVT77x4L0mKv8qJ8s2f1l5W37
         U5BlcO0OvQMGPaG6zrL/dr4pUIqOKmJHyHQ8w6fSgfeQy/wus68WWhUwYmRDA1y4tSFT
         eeEQaYOliZjS12LRzktPizxhlS8/mVvDOu4nY3/7VWQ9uA+gFvw4+f0C1EvGbmObs8qu
         uKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1b0HeUhFBeNKN2FYsIQkaN3rxaQMWP2KFVM4rsp4jc=;
        b=KZiYe6eV6yKTFGzIZiDwntjX+XggZ9KOuI+/FTeYJoKtRpLLvR1Fzpc+nNVlzpU7+s
         WkPpdbhjOdHpB3iI6Z2ZpuUT9iiOBp49p5TRUFgjwQ+ocph8/h/SBCVW3QBV0as2W8Qc
         G7dJVkjyf2OyZqOLefczJVlqjlwNeHZAjxJNP/ml3nKs0C9WOVd7AfGhKr/neSlYlsb/
         65c99F+002/iUdDgEjRJYXCw9tZmmclu596T3HDzp5hK5fMnA/0mPcCBSjZ612KCehGT
         mWuaFsxTxKVJzojUyHsTrZoavObkpyucq3eX3ZhsuJal6xV5ONCYHUUpXejEN3xCsIhF
         KCZQ==
X-Gm-Message-State: AOAM53163sAX8CGtJIbugObPJeZv3Ai4z2PcYBeBOHvFGB3u9OhLtOnS
        50ZgGBfOe77aekesIZyKpWb2eKoYlYGhqxiU6M4=
X-Google-Smtp-Source: ABdhPJwc1+OUJ0Ez3LmYL0k1WAFwiwBeLHeltqdtrVuvvYg7f9LzA2gXJvus9VH4s/4b1m8U6AfEDSHe0AlMr82SHR4=
X-Received: by 2002:a4a:e2ca:0:b0:35e:b623:8799 with SMTP id
 l10-20020a4ae2ca000000b0035eb6238799mr8437220oot.68.1651717470097; Wed, 04
 May 2022 19:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220505022239.58334-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220505022239.58334-1-chi.minghao@zte.com.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 4 May 2022 22:24:18 -0400
Message-ID: <CADnq5_N1yG+Jpg-+0R=Xo4DL0pgnwb_bGEY+TUBXTv1v94-_KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify the return expression of vega10_ih_hw_init()
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zeal Robot <zealci@zte.com.cn>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Minghao Chi <chi.minghao@zte.com.cn>
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

On Wed, May 4, 2022 at 10:22 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Simplify the return expression.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> index 3070466f54e1..cdd599a08125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> @@ -521,14 +521,9 @@ static int vega10_ih_sw_fini(void *handle)
>
>  static int vega10_ih_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
> -       r = vega10_ih_irq_init(adev);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return vega10_ih_irq_init(adev);
>  }
>
>  static int vega10_ih_hw_fini(void *handle)
> --
> 2.25.1
>
>
