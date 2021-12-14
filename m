Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D38474737
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhLNQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhLNQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:11:39 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D12BC061401
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:11:39 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id s17so12806918vka.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5tq/Pl9ONmAFdCXW/jiSrd1FQJiChNHfeL7wVihFrwg=;
        b=fonIZ6frzwFMeYvOMCzQGYFT049lFCIGlzMaZ+okQO/Qk2RkUkwXgxMgbbG0E1AJ/U
         yqhublnYTzdo9IGa8EXS3kHjwOPiAeWVXDTRtvn8dMycTrCcyNpfuSCr6XzXT2WXkd4N
         beylrCdAxCSGm0j6WD6ISiicdnt2f/4p2Ri3u3+2x8J31JCnwuIivG132TxLXFcmNJmK
         Lfz4qHHQMK+9AZs1gu8pxisfLhItoA3AjgernRLVFTpbIEAZt3Rs3u7y+tjOgp3CLsY/
         24kLjI+fGAN2AX/dWs6jbvcmPw8s1f11iyu6b/ppnILGDIbcKF8XALzkJjco1QduFYLP
         9ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5tq/Pl9ONmAFdCXW/jiSrd1FQJiChNHfeL7wVihFrwg=;
        b=aZA/RyJAJ54vycORENfIuMxS3iGQUkGrop3c9+DDPy6XtcxHwC2YtCUn0Xyt8cgOHx
         Ykq8Yn0U483oeRPVF3Rci5yx/4ydNl+EVPhrb8PEpVNIMZAzmjAI3QJUEaATn9/F7R3M
         IuXq/cpBXkaFWOvO2Kkdv0iSplPfSNh5uCkBc0uWX4bt6bry5Fbg6kc9GMt4a/0BVo2z
         fIvKkFQRsncFrqX099uYWwu3bbYuXlveitnvgnP4f3ErQwGbavEhBc2xrZrOjyNB4oP6
         y1xWdPCU4nvyL83oXj4jvTjHgE7kOIZLruFe4Dk/qvEoFmCHnUk1i/Dwu0C1bhG+aL3J
         nIGg==
X-Gm-Message-State: AOAM532YUexvmvLD2/s89M3lsk3eae82eohyA1djJ+lXPHQ66cRzJA00
        U8nllAF1Dv2D3+0wId/2CtEfaMIn/eecgnqKykAfKQ==
X-Google-Smtp-Source: ABdhPJwKdP12Jr1NoBj6l47hdacd390d2Motm3FzCykJUk4B/mbGJmIKS66lL5aFMtWBWkzbWhuk6pmeDm/l5OaTRuk=
X-Received: by 2002:a05:6122:2158:: with SMTP id m24mr6951873vkd.1.1639498298544;
 Tue, 14 Dec 2021 08:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20211207140334.10461-1-semen.protsenko@linaro.org>
In-Reply-To: <20211207140334.10461-1-semen.protsenko@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 14 Dec 2021 18:11:26 +0200
Message-ID: <CAPLW+4n-BjSHK4gdP=cGvAE+pZDfvYTO4yy09yNRJgSXt2VArg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Report enabled nodes with duplicated address
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 at 16:03, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Duplicated unit address is a normal case, as long as no more than one
> node using that address is enabled. Having duplicated addresses is
> already allowed by '-Wno-unique_unit_address' in DTC_FLAGS. But two
> simultaneously enabled nodes sharing the same address is usually
> incorrect. Add '-Wunique_unit_address_if_enabled' flag to report
> warnings for such case when doing "make dtbs_check".
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reported-by: Rob Herring <robh@kernel.org>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
> NOTE: After applying this patch, a lot of warnings appear on "make
> dtbs_check". I'm not completely sure if it's ok, so feel free to Nack.
>

Hi Rob,

Do you think this patch is feasible? You asked me to send it before,
though I now see it leads to a lot of errors being revealed when doing
"make dtbs" and "make dtbs_check". Please let me know if it's Ack or
Nack -- I'm fine with any resolution, just want to know if I should
continue to carry it in my local branch or drop it.

Thanks!

>  scripts/Makefile.lib | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ce6142238835..2f00c996d2e3 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -315,7 +315,8 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
>         -Wno-alias_paths \
>         -Wno-graph_child_address \
>         -Wno-simple_bus_reg \
> -       -Wno-unique_unit_address
> +       -Wno-unique_unit_address \
> +       -Wunique_unit_address_if_enabled
>  endif
>
>  ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
> --
> 2.30.2
>
