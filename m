Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4E4C705D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiB1POS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbiB1POQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:14:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A650349F13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:13:36 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 132so11723981pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGwYcAtA2klfvyrB2PcrP/sabG2d6wgbmrp7H5C/tzI=;
        b=vDnkExEF+F5iAc4BnkmVTIxJmvcumyqPVFatWGgZ2EJVSXd0LHrELbiRT8yRPhlCAc
         KRMEDnZyRk+ibD6GMOxqZ9gUnH2dVJHZ4tvDiK+u9gCjwaa+7NhbS0lzSV6KOYgvHF6T
         Jbb44dmwpT3Zu2jtS50z5UOSWYEei2g67TdgJQz2pLrzBGNBPFbhkQtVCBgSHZKQJOBl
         /do+he/QPu1AtCUACLaYczXgxIqgxLhYcQWccsXl7mdnxMX/c1xUvUTqY9HK/BLgr1Vx
         oScKWP8JpwOMg3WM42nK7fdpy+G9B5mFVZG1q6YXkspCMFR+lTM9YdC8jQWbYsVnZgo0
         rwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGwYcAtA2klfvyrB2PcrP/sabG2d6wgbmrp7H5C/tzI=;
        b=y4bgw0tR82YSoKNmgROFu9reIwmLmg4cg9/RbbOb59xcsq+9n4uM2WDM15fev8Q4zK
         Ixz1iLnLV8ZOVgUzoQoTrxfOIm0Ln8oJ97UJ+XnzHTjThu6EzfTKUNzAFnw3NgL0rNRJ
         TTQnC5LqZ1cBvlNaabANrmOSCFSF5fVMlUGEKj1bKLyOEmX/VtmKDaQds7J8ioGXc8nz
         39kiiudh57/CutYCUrerZDdCjftAEF5SY+aDvcgZy9XLF/PKnLFrMog3xFQVSfqRCeW0
         AYAJSDapTwjDm9LeXcdlJCIYZYaLe4xLmCgwZpvAQAEOoHuVu1gmnXBa/EH2bVxlay6o
         Kluw==
X-Gm-Message-State: AOAM533UWePrEG/5ArW+0hJAapTHbmSPbMLNM7IVJNHYIApRJyN+/W65
        yJB+t4HQgS/2S3Feus6j4qPEjslb0W6NQGqZN2N4Kg==
X-Google-Smtp-Source: ABdhPJzk13pYILJKJ1yE53AETbOo1jfwEnx9hA9QDAQ+gwwwSSsFu6fOzIoUotvsgRS82wZ107CMhRY4mXN1sVpjpqo=
X-Received: by 2002:a63:b257:0:b0:376:7f43:5449 with SMTP id
 t23-20020a63b257000000b003767f435449mr14527357pgo.201.1646061216056; Mon, 28
 Feb 2022 07:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20220228081421.1504213-1-hsinyi@chromium.org>
In-Reply-To: <20220228081421.1504213-1-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 28 Feb 2022 16:13:24 +0100
Message-ID: <CAG3jFysyV8QHO4zEdUYLxt9eBnGsHWrXdWbicmufUPnTB-oRLA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Fix the read buffer array bound
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     David Airlie <airlied@linux.ie>,
        Allen Chen <allen.chen@ite.com.tw>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 at 09:14, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> The size of read_buf is READ_BUFFER_SIZE (200), so we can't access it
> with read_buf + PAGE_SIZE (4096). Extend the READ_BUFFER_SIZE to 400 and
> set the end position to read_buf + READ_BUFFER_SIZE.
>
> Fixes: b5c84a9edcd418 ("drm/bridge: add it6505 driver")
> Reported-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index fb16a176822d81..f2f101220ade94 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -289,7 +289,7 @@
>  #define WORD_LENGTH_20BIT 2
>  #define WORD_LENGTH_24BIT 3
>  #define DEBUGFS_DIR_NAME "it6505-debugfs"
> -#define READ_BUFFER_SIZE 200
> +#define READ_BUFFER_SIZE 400
>
>  /* Vendor option */
>  #define HDCP_DESIRED 1
> @@ -3074,7 +3074,7 @@ static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
>         struct it6505 *it6505 = file->private_data;
>         struct drm_display_mode *vid = &it6505->video_info;
>         u8 read_buf[READ_BUFFER_SIZE];
> -       u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
> +       u8 *str = read_buf, *end = read_buf + READ_BUFFER_SIZE;
>         ssize_t ret, count;
>
>         if (!it6505)
> --
> 2.35.1.574.g5d30c73bfb-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
