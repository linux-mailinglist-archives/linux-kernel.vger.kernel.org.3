Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78644A8F85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiBCVFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:05:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31714 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350895AbiBCVFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643922317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTxNTC4G8tZvfkXYsUOmWJZv2fn/RPNTA7Loz+ScVGk=;
        b=XN6l54G61P8ojRC3rbCiPR2QZY54Qcb3digipnGP7bKz4JZ3dfO8o1wOHCf/l9hI2YxrAQ
        lGYOaI9fGMb5iMZu4X4CakO647eBIf2OEQRUrLy/FsBYTsEeAY+5LCknjodJw+P/BhxGbc
        Nta6c6G3YGXVsD2BJ5VmNLzQ2pb9H18=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-TfgIAPsoPVyuCWd6FYnpww-1; Thu, 03 Feb 2022 16:05:16 -0500
X-MC-Unique: TfgIAPsoPVyuCWd6FYnpww-1
Received: by mail-qv1-f69.google.com with SMTP id t5-20020a056214154500b00428bf2998c1so3577617qvw.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=wTxNTC4G8tZvfkXYsUOmWJZv2fn/RPNTA7Loz+ScVGk=;
        b=1/viv3FwQh2q4zrV0kJx0u87p1SIZ7Z6R/tbWaXLDJMdFJwzhCisNTqjlvvrab8/Iw
         6UAp8NcVo2NCnbQ4IHJ70pqE6vw0uQdS7lAzus15+0cGWY0KcNXkzO4Bqg2tcdh3ej8G
         h1ch1J/ld54MjpwJN40tRImSkm8WPSR8TLorm+eL/3CtUSO97BefMwiDHcdB1mDtOxaP
         4ap3NADOiQcpDNvfmxzFnHiNFSjZcV2GFeyQb+5LYogI6Z0wDGgA8ECM7p0AXZTYCnWh
         S1yhOJGqY3//SayhDd1/Ca4fPiKNdxYat0o5kZBc27MC2l/5xL9Fx9sgvb0f98egbkRj
         Ji+Q==
X-Gm-Message-State: AOAM532uuk/lPciwzZTpWD1aa3ZtHhpZ2Mymakywmk49wXsSD5TdBl2i
        D8ibWFQCiYk5KBU9Xb1vbdzV41OS/1pbprIrJXK134OQOOlEtUIGwoXDQ+HK9MGQ7XGs2peqUs6
        f/XmStGYOPANkzU4DpolpjhcQ
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr28037804qtv.637.1643922316193;
        Thu, 03 Feb 2022 13:05:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeOJe9pNmMZSKwkg3H/lznOtdXYM590bhHQNaVBR0XQtUXcP8pjO6id4B62LZk89cDR0u5Tg==
X-Received: by 2002:ac8:7c4e:: with SMTP id o14mr28037790qtv.637.1643922316027;
        Thu, 03 Feb 2022 13:05:16 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net. [96.230.100.15])
        by smtp.gmail.com with ESMTPSA id f14sm10427270qko.117.2022.02.03.13.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:05:15 -0800 (PST)
Message-ID: <8ab27937391733a9027a41af17a4a8155f78d549.camel@redhat.com>
Subject: Re: [PATCH] drm/panel: Select DRM_DP_HELPER for DRM_PANEL_EDP
From:   Lyude Paul <lyude@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        linus.walleij@linaro.org, dianders@chromium.org, ardb@kernel.org,
        naresh.kamboju@linaro.org
Cc:     rdunlap@infradead.org, arnd@arndb.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Date:   Thu, 03 Feb 2022 16:05:13 -0500
In-Reply-To: <20220203091340.20285-1-tzimmermann@suse.de>
References: <20220203091340.20285-1-tzimmermann@suse.de>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2022-02-03 at 10:13 +0100, Thomas Zimmermann wrote:
> As reported in [1], DRM_PANEL_EDP depends on DRM_DP_HELPER. Select
> the option to fix the build failure. The issue has been reported
> before, when DisplayPort helpers where hidden behind the option
> CONFIG_DRM_KMS_HELPER. [2]
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: adb9d5a2cc77 ("drm/dp: Move DisplayPort helpers into separate helper
> module")
> Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/panel/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> index 434c2861bb40..0aec5a10b064 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -106,6 +106,7 @@ config DRM_PANEL_EDP
>         depends on PM
>         select VIDEOMODE_HELPERS
>         select DRM_DP_AUX_BUS
> +       select DRM_DP_HELPER
>         help
>           DRM panel driver for dumb eDP panels that need at most a regulator
> and
>           a GPIO to be powered up. Optionally a backlight can be attached so

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

