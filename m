Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3DC5978F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbiHQVdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241533AbiHQVdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:33:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB66474E6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:33:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qn6so26711252ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=94gUzjOftxCMJ+JIYtFblUNLRM88g6BBBVb7IswffX8=;
        b=j3YieT+csCZ4mImqO6w0ux8pucKxvs/DPFIGs6m3BgFPCCPj7OHktLLlz4bHFUDJA0
         pTL5qOouYfsYuOFKo7QLF7qMaEOnJU+0wgI3DBI6bDepzCg6klzsyh8wcQLKmn3NuTs1
         00up9knVQXNsnG1I2M0K6spESqJj2lppIn3Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=94gUzjOftxCMJ+JIYtFblUNLRM88g6BBBVb7IswffX8=;
        b=XGhgB3he48VvNoxEiJPO2P6LZZd+yWEsTFMrUy3CL1wU1n67pZ5qI0yy+c+1M9qt3+
         4I/XJSvDsAHnpfai7j/hArg8/9s8kptRV45k8L0ZtvuzMDVrq7IL78p0uKjTbKYCtfdh
         3nrOBdBkLDVbrIkh2WJ8/Fk6GKA+8MMtEFGdDLaDyNjqLpNXlafKIShAoawvG8D4M6C9
         hPsClrzx9gtmj0y86yD0I0oIaNHhd3S2RJRib377Tp4m54Q9aYu5ycbSRJbRg7LUa46R
         2g4Kv8bf2AIG6Nk98Feif/IusZNLKgygUI9vGqwPouAEltub7QahQY+hTNeO7Ga3V84j
         LUmw==
X-Gm-Message-State: ACgBeo0cqIbNKkG4ctiOeoWW0jve+YkbcwOkXP55UTQuARwzZQKrHj0s
        Pv5LMiuvCVLk+nfQPBIlwUxLhX1e2rhLuW9T
X-Google-Smtp-Source: AA6agR4/NdbvKjbKLscUsIgfyWGEoQNjnZXb0wvlfO+c71sUod+gcy+FxEpScXs+Hpk3HLLEINaDVw==
X-Received: by 2002:a17:907:10d1:b0:730:7c7d:3869 with SMTP id rv17-20020a17090710d100b007307c7d3869mr17140388ejb.356.1660772025850;
        Wed, 17 Aug 2022 14:33:45 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906339400b00730b933410csm7328850eja.145.2022.08.17.14.33.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 14:33:45 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1662417wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:33:45 -0700 (PDT)
X-Received: by 2002:a05:600c:42c3:b0:3a6:431:91bf with SMTP id
 j3-20020a05600c42c300b003a6043191bfmr3065469wme.188.1660772024757; Wed, 17
 Aug 2022 14:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815180429.240518113@linuxfoundation.org> <20220815180442.585574345@linuxfoundation.org>
In-Reply-To: <20220815180442.585574345@linuxfoundation.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Aug 2022 14:33:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK3Oyb9N9TpDqa55VEukhkjL1+GRO8+yLVxdFMuE=Mrw@mail.gmail.com>
Message-ID: <CAD=FV=UK3Oyb9N9TpDqa55VEukhkjL1+GRO8+yLVxdFMuE=Mrw@mail.gmail.com>
Subject: Re: [PATCH 5.18 0309/1095] drm/panel: Fix build error when
 CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>,
        Gao Chao <gaochao49@huawei.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 15, 2022 at 12:09 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Gao Chao <gaochao49@huawei.com>
>
> [ Upstream commit a67664860f7833015a683ea295f7c79ac2901332 ]
>
> If CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20=y && CONFIG_DRM_DISPLAY_HELPER=m,
> bulding fails:
>
> drivers/gpu/drm/panel/panel-samsung-atna33xc20.o: In function `atana33xc20_probe':
> panel-samsung-atna33xc20.c:(.text+0x744): undefined reference to
>  `drm_panel_dp_aux_backlight'
> make: *** [vmlinux] Error 1
>
> Let CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 select DRM_DISPLAY_DP_HELPER and
> CONFIG_DRM_DISPLAY_HELPER to fix this error.
>
> Fixes: 32ce3b320343 ("drm/panel: atna33xc20: Introduce the Samsung ATNA33XC20 panel")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Gao Chao <gaochao49@huawei.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20220524024551.539-1-gaochao49@huawei.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/panel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)

While it doesn't hurt to land this patch as-is on 5.18 and older
kernels, it's not quite right. The symbols that this patch 'select'
don't actually exist on 5.18. ;-) Doing a `git grep` of
`DRM_DISPLAY_DP_HELPER` shows no hits except the one introduced in
this patch...

If you want the equivalent fix for v5.18 and older, I believe you'd want:

select DRM_DP_HELPER
select DRM_KMS_HELPER

See commit 3755d35ee1d2 ("drm/panel: Select DRM_DP_HELPER for
DRM_PANEL_EDP") and commit 3c3384050d68 ("drm: Don't make
DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS") which added those for
the (very similar) panel-edp.

The first of those is what got changed in v5.19 in commit 1e0f66420b13
("drm/display: Introduce a DRM display-helper module")

So I guess the tl;dr:

* If you leave this patch in 5.18 (and 5.15), nothing bad will happen
but the broken "randconfig" won't be fixed.

* If you revert this patch in 5.18 (and 5.15) also nothing bad will
happen but also the broken "randconfig" won't be fixed.

* If someone cares about the randconfig on 5.15 / 5.18, we need a
backport that adapts what's selected to the old symbol names.
