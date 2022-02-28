Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE84C65EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiB1Jpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiB1Jp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:45:29 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BC069CC4;
        Mon, 28 Feb 2022 01:44:50 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f21so9834682qke.13;
        Mon, 28 Feb 2022 01:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m42zzm1A/Uk2fszLihUQmA9ldzbK7Fh11mCVbXlmHhY=;
        b=BMCIAstrNglzIjoRryZMWNKrJVUS0F+gf66wVvxk/abudp6l7oRiEV9Go/1Tp2Z5UK
         FZvgp6oJzdOMnvnNWiv4GiobNN5JtxdixkM5HIopzJq4MHyDAUH09wL2Zq8MKRGOY2G3
         OGFe9OjLjCkrljdSbJTS3hg5mDsKWg+CbHqK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m42zzm1A/Uk2fszLihUQmA9ldzbK7Fh11mCVbXlmHhY=;
        b=1nB3lGnVZYzJT4lFFXQqVBJ0UQ1MLGw7hzU1GSnhILSSIaKb3LFBEpNfO6UGl0h8Ay
         GHwX3NsxCfEoNrFbfZeJUvFfNb9eyNM6549bH7NR1xNOrdysu6Uq4tXGZ7MhLea+lZSO
         kaAZskVAEFQxuGIpuNBehrHqHr3Iw2Gi/sIpG/3xLfKmMm9e4AwuPIpMnzNQl0I2N3TO
         PcTxnwFLtaR8yHoOyFZFtFSxnsULXtIKUjcPbDeVNOTpJ9WeU/uuvZDMvb81lf5Z2gfc
         z/dXLKdElKYUhxh7XMwhP9n2XYwqtdnZZaKjFPB6lJMWXM/gRaBSapvWm7o7NI44oi0P
         nlrQ==
X-Gm-Message-State: AOAM531LFkYF3BUzlpiEfDy9EZqB9vo6ZJUVZajbGY2lNC+0iqoRWb2j
        rAjkX68um19Lu0edNLy/kJXHAZp+Wmv5vzxMZVA=
X-Google-Smtp-Source: ABdhPJymavUC7phOQxSAzrnChJkit6X3vSfBJh8VvkrOfuYY39VSMX5xk/p7XeOex4FlAIcndtpkSyXMeeVQYGpGKKo=
X-Received: by 2002:a37:f903:0:b0:648:ca74:b7dc with SMTP id
 l3-20020a37f903000000b00648ca74b7dcmr10471405qkj.666.1646041489765; Mon, 28
 Feb 2022 01:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20211208013337.13806-1-tommy_huang@aspeedtech.com> <20211208013337.13806-5-tommy_huang@aspeedtech.com>
In-Reply-To: <20211208013337.13806-5-tommy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Feb 2022 09:44:37 +0000
Message-ID: <CACPK8XfJH=h_0f2Wp5akLWtdJwd=bmGdhrqJY8qrK9RX=4NtVQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] drm/aspeed: Add AST2600 chip support
To:     Tommy Haung <tommy_huang@aspeedtech.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 at 01:34, Tommy Haung <tommy_huang@aspeedtech.com> wrote:
>
> From: tommy-huang <tommy_huang@aspeedtech.com>
>
> Add AST2600 chip support and setting.
>
> Signed-off-by: tommy-huang <tommy_huang@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index d4b56b3c7597..d10246b1d1c2 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -82,9 +82,18 @@ static const struct aspeed_gfx_config ast2500_config = {
>         .scan_line_max = 128,
>  };
>
> +static const struct aspeed_gfx_config ast2600_config = {
> +       .dac_reg = 0xc0,
> +       .int_clear_reg = 0x68,
> +       .vga_scratch_reg = 0x50,
> +       .throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
> +       .scan_line_max = 128,
> +};
> +
>  static const struct of_device_id aspeed_gfx_match[] = {
>         { .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
>         { .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config },
> +       { .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config },
>         { },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_gfx_match);
> --
> 2.17.1
>
