Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C728591FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 15:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiHNNMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 09:12:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F5D10566;
        Sun, 14 Aug 2022 06:12:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so2745118wmb.0;
        Sun, 14 Aug 2022 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N6io3A2B3gOnjaLctJK+AORdD68hnIfgj9pgUADE+0k=;
        b=iDymSYVbtnceEseY6LJGZvvSnhJThnz5nk0Q4aG1XvngKwqALSlMzSHEt5oiOtxMNa
         iykN/V+qXWXlzW8CvsZz8GuslLVxE36eKD8c9lULIGUp4cHAl/JjnUDAfL05J3f3MLgU
         DF9mZNHLDjepLmjxkPedIxjF7VbzQ5WLbujUw78wSS5TLIb2knhl35zxAmb2R3rk6oTw
         7rSCQzcD1UOm456dKHjkSpbCv0Nnrc3JrRThCMEJlqLCsKIqZ845YKqad9BhuVWJ+cij
         S4yq0Ts/sfyqpyhImBFfMHP7X0RMTajYmsK+9ymbPGcb6rwHUiNidokSD4tayAOAJoJF
         jX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N6io3A2B3gOnjaLctJK+AORdD68hnIfgj9pgUADE+0k=;
        b=fSxaD2Y+6VOUCNSsGFW99yqcGVKk5+JXH/jAWqziGGeVPLnA3r0U6ZUkGvrt5faOcd
         pYTJxAZuso5c8TuYiYbYZDMcDhyupcECdZFwHxsL5THD9H607thnWKzRA2rEttq5AoPU
         8phZwkgndOBL+nvoX8UsD1zc1oLpOJu2A9Kh2AW7DAkKNixCzWeCj17//EPzsmuEpgWj
         byQ6OYfaECOtvMHwWdQV9netf2VWrcnhJ1PqAxeM9sBaxGiAEyWwBBPAQzgjGNdfUBPn
         3XmfqMtT57cleMUMy38v3X80/Ornr0q18FRfQGFfWwPR9PnPwiWiHNJJ0vv7TkbH6slK
         0ELA==
X-Gm-Message-State: ACgBeo1dMW2E01LVtuzl4JzvHkTZgwYO17jp7yoahrcLBX0e9sAziz/X
        hR9kT0LjQc7BCCdVUuiUa3cpIczmhdLNsKLKsYA=
X-Google-Smtp-Source: AA6agR7eiE/InuX3RR69EbMuEkyt3nq821a1W/YpUh7GHunF6VnG+PX7iJhl8bbovJIZnnwvZ9/FJJCOFKMKVRLZvzE=
X-Received: by 2002:a05:600c:5114:b0:3a5:cb1f:6bf3 with SMTP id
 o20-20020a05600c511400b003a5cb1f6bf3mr6961219wms.65.1660482760270; Sun, 14
 Aug 2022 06:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220814040806.7523-1-kernel@undef.tools>
In-Reply-To: <20220814040806.7523-1-kernel@undef.tools>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sun, 14 Aug 2022 15:12:28 +0200
Message-ID: <CAMdYzYoD9kM_RNs0t=7qc9Tyt9j-cD0DEQD0sR5cEkkGifFSSA@mail.gmail.com>
Subject: Re: [PATCH] media: rockchip: rga: Fix probe rga_parse_dt bugs
To:     Jarrah Gosbell <kernel@undef.tools>
Cc:     Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
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

On Sun, Aug 14, 2022 at 6:10 AM Jarrah Gosbell <kernel@undef.tools> wrote:
>
> From: Ondrej Jirman <megi@xff.cz>
>
> rga_parse_dt is missing a error return, so if some of the resources
> return DEFER_PROBE, probe will succeed without these resources.
>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
> ---
>  drivers/media/platform/rockchip/rga/rga.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
> index 2f8df74ad0fd..b88dd7ed2036 100644
> --- a/drivers/media/platform/rockchip/rga/rga.c
> +++ b/drivers/media/platform/rockchip/rga/rga.c
> @@ -815,8 +815,10 @@ static int rga_probe(struct platform_device *pdev)
>         mutex_init(&rga->mutex);
>
>         ret = rga_parse_dt(rga);
> -       if (ret)
> +       if (ret) {
>                 dev_err(&pdev->dev, "Unable to parse OF data\n");

If this can return EPROBE_DEFER, shouldn't this be dev_err_probe
instead of dev_err?

> +               return ret;
> +       }
>
>         pm_runtime_enable(rga->dev);
>
> --
> 2.35.1
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
