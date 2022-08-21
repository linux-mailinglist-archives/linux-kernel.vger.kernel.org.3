Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555AA59B4E4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiHUPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8D22B0B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661094732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjShao5KS7YTUwj6lZ8lmMaiescGPBNdHzi3GWQbqfo=;
        b=NvSsKVvYIllr9cCDcisNvi9wFgU0ycK+4veV3PKasu2fszFmTlqzG1HakfMtPeB+8m20Cu
        Zqob37vHnbIFvoF4njq84MFkqEjx6l9jWXiB7AE4z/G303xuU8V1O/O/Ze4h3aRZec2Mug
        gdFxcN9l3jhXcEVC+y38u8qXemJAeF0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-ELQudbh9PmGZvfVp1XVCIQ-1; Sun, 21 Aug 2022 11:12:11 -0400
X-MC-Unique: ELQudbh9PmGZvfVp1XVCIQ-1
Received: by mail-qt1-f198.google.com with SMTP id bz20-20020a05622a1e9400b003436a76c6e6so6765269qtb.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=CjShao5KS7YTUwj6lZ8lmMaiescGPBNdHzi3GWQbqfo=;
        b=H9yMtkehpZRFKElb4OEO+NHaSi/AZk2PUAYkmrVny3mXZ3rSlYDAqN3h/Fei/3214R
         knoAOWa8Mlk0xN8ErGFPgM31qVdTc8gJTXjcQc6JiglBsFcSL0nwhimdnw2wqIoTaTkk
         AXua85iy+VBQRcARE+xYVCaCEAZl1bHOHqBkAimymLX5KZjKGdII2s3WC/0OefAICaTS
         tx61GMMSfMfDKSLemkXIZh1QdNrwDn07HDxEwWDo8f0sqxEDBQa9FMKa/uNJX0wZZVJs
         xlAZtD2+FUh4x+rfYJXnGOnC4IpXp/8FWLzMphPvvROybQOvkXkrWgc/kQFmgOVVvQHe
         IYYw==
X-Gm-Message-State: ACgBeo3kIeZgVCvEQVOU4IqJbXzMdVAFqFZknJVNeCDbTLj/UYdzFKO2
        fqak125c4VEhit2lTMC0gtAF8ywISfKUI4hf0Os1dmWh6TqlltOytxQcHaYz1yFuQRG8kHkqJhd
        2UzTn+/sntiK/zFmO6cYqBOFy8OJ7bN6A15btOE01
X-Received: by 2002:a05:622a:110e:b0:343:6f02:99fd with SMTP id e14-20020a05622a110e00b003436f0299fdmr12672438qty.141.1661094731078;
        Sun, 21 Aug 2022 08:12:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Yo0YPKD7li1qO/+8j1V5fDwgE7RtNkUu23EP37Cq0Xx9xBuMRVvP/OGSR+LNvBObUlo8zk28WplryB0x2Lrs=
X-Received: by 2002:a05:622a:110e:b0:343:6f02:99fd with SMTP id
 e14-20020a05622a110e00b003436f0299fdmr12672425qty.141.1661094730890; Sun, 21
 Aug 2022 08:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220821143038.46589-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220821143038.46589-1-wangjianli@cdjrlc.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Sun, 21 Aug 2022 17:12:00 +0200
Message-ID: <CACO55ttLv=RtyLHYdOjbQmNGE_DScd0hfn-_Sxoo5+yavAK9Kw@mail.gmail.com>
Subject: Re: [PATCH] subdev/clk: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     bskeggs@redhat.com, lyude@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

thanks, and I'll push in a moment.

On Sun, Aug 21, 2022 at 4:34 PM wangjianli <wangjianli@cdjrlc.com> wrote:
>
>  Delete the redundant word 'at'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
> index a139dafffe06..7c33542f651b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
> @@ -581,7 +581,7 @@ gm20b_clk_prog(struct nvkm_clk *base)
>
>         /*
>          * Interim step for changing DVFS detection settings: low enough
> -        * frequency to be safe at at DVFS coeff = 0.
> +        * frequency to be safe at DVFS coeff = 0.
>          *
>          * 1. If voltage is increasing:
>          * - safe frequency target matches the lowest - old - frequency
> --
> 2.36.1
>

