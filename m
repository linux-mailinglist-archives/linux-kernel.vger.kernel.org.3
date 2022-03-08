Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC084D2488
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbiCHW6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiCHW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:58:18 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49441659B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 14:57:21 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id r7so648668lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 14:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MuVYFNOaR9sliTT6PtGIJ1tDZacg9KCLiOwg2Rb9wE=;
        b=MXnPx5h0ijIvF7hzm97VrMTqvyic7sV48mwtFM03Cb2ZqYOIpnQ94270DTDJEPiPh9
         5CjRWWSGQtAApqB9y0tEUktv0WoI/5rS06ibAZJRqy6wYLCJ39pyFCAQa5vhGbS7jpt+
         RnHHXgNmhxv8e00HrU5+YGURkZWrbImCONWMl1DHCay8t/iiuqqtVW4ygi+TsCEAnnVe
         skhfJqTsnhWQHOKbDk3yD8UnHCafjqI1RpmaAPDM06Opmlw5WycySR/878Mppq8I00B8
         TSygBNI2YB8hFZCdpc9mwjDF1NaLFy4OrVQEjZ8wkBfIUT3UNgstcg7tJxHFRiikPcEM
         KnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MuVYFNOaR9sliTT6PtGIJ1tDZacg9KCLiOwg2Rb9wE=;
        b=gkrmDEoqsLEQkj3jQHD/8Wxuuczi8bJkVUpmhfaIuCPDTBVLy1jiCvUXP8jZYylDEf
         2jSUSuJ+fHeP6qvB/iKqld4UkGgjST/Ocb97jSn3zgI2QKpgwc0wuNlahhJfzgTB9/4F
         BFtmOcdrG8WQYc4wd5/ggHn3tXwfNTjZfjrwoCHgSoUAZ2AzL41tqkEkiANkvNGuzFPK
         UoK7xkL/6B5sflB9rS6ogIuU8gi6JTtesHXzD1biA+uIMBCMo8wFuKDABS/16u4tKX73
         dDYem4JFJWQ/zxjPFOjRalLFqzav36rl55HU6ga821rr8H7BBlJS1X7j5wG3V+HNutpm
         jg7w==
X-Gm-Message-State: AOAM533QkK2Yk8c35Vb/vyzJyR2mbc+W6413xz2bxVOXLEKaBEbcNZRU
        IrjfHxPMRHSIov0Y418gePAvGN9A6mrg9y37MNdEWQ==
X-Google-Smtp-Source: ABdhPJzdL2oC651g9gnqpZ43uG6CG69kcwxMsKSo599esFmsA3M5zPERun34wywdexJK6V1Ow3rB18oZvOBuem+8a1Q=
X-Received: by 2002:ac2:5223:0:b0:448:5100:e427 with SMTP id
 i3-20020ac25223000000b004485100e427mr176322lfl.87.1646780239304; Tue, 08 Mar
 2022 14:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20220303201943.501746-1-trix@redhat.com>
In-Reply-To: <20220303201943.501746-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Mar 2022 14:57:07 -0800
Message-ID: <CAKwvOdnoV_SsFuWWJd4nOOd1vGG6_-gg-KvdOg4_NHuRp7_WfA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: check the return on anx7625_aux_trans
To:     trix@redhat.com
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, nathan@kernel.org, xji@analogixsemi.com,
        sam@ravnborg.org, tzungbi@google.com, pihsun@chromium.org,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        hsinyi@chromium.org
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

On Thu, Mar 3, 2022 at 12:19 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this issue
> anx7625.c:876:13: warning: The left operand of '&' is
>   a garbage value
>   if (!(bcap & 0xOA01)) {
>         ~~~~ ^
>
> bcap is only set by a successful call to
> anx7625_aux_trans().  So check.
>
> Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")

Is this the correct Fixes tag?

I think it should be

Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid
through aux channel")

instead.

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 633618bafd75d..f02ac079ed2ec 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -872,7 +872,10 @@ static int anx7625_hdcp_enable(struct anx7625_data *ctx)
>         }
>
>         /* Read downstream capability */
> -       anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
> +       ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_READ, 0x68028, 1, &bcap);
> +       if (ret < 0)
> +               return ret;
> +
>         if (!(bcap & 0x01)) {
>                 pr_warn("downstream not support HDCP 1.4, cap(%x).\n", bcap);
>                 return 0;
> --
> 2.26.3
>


-- 
Thanks,
~Nick Desaulniers
