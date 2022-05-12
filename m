Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4FD5248FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352088AbiELJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352077AbiELJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:32:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC77E612B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:32:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x18so6462833wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:organization:in-reply-to:content-transfer-encoding;
        bh=VQN/aLux/2RP21RLeqsLxxrhMb3H+/UUp0giAkzj/KY=;
        b=WJZbJ3OILOz44m7dxa/s2kBpGiX7pJmSaVbOIL68jRiSqr9EeJmEipxQbwv+V0NeWH
         LDFrHfyUZfcjCqrG4pddn/y3+5G0c5SgjS9TTM6+PTlCLH4RtR3D+ArkoK6psjEf6TUn
         fFhHpqmqZjO8isUf5vpZOfmIsp2v9Z0HGvAZlf+bLlMtUWvDIgZ2uZ2Bstilfe+qxyDL
         wLuehjGI3xQCoLXdk+xwxtnZ9UQHyzOzbzastcFlEIjBi1G7+jsfaTswBPIhjzIYvaVN
         xiaukeNdk0zHeO4+Xa6a3EGLePNKgLcg1H5E37Yy1321Tq4c9g2iritE1Yf3Fe2q5/Xt
         nRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=VQN/aLux/2RP21RLeqsLxxrhMb3H+/UUp0giAkzj/KY=;
        b=Yaf8hkABN+9PP3F0sNuqm6DgCLKCgK8lWEIX93oYOoodZTJm+M53RDlF409yF5zxh3
         OP5MR7VPBgeWVE6uWFGLH18l+GqiWaGedFgKLUa5VFMgkSFzWHPvMBGK4Wvy3+dgt17p
         EgGuKqgDYPB8RuowlNYV8sykXTU0ZVgiCDZDTXJpCp0C6hVscmTI4NodE7hHZAUy5HQ/
         bTxs2IS7JNQrLm6R2sQZ+BKzPodpPIF1uxk43ZKNSVcKDAqNz+BbqhAR298QaX+iABNo
         fO0YbpKvOe8NYFpoJJQb5R/aLzW4e2Pg7oZ4a10AYKCfiqWbNIpomfu1DPj6PFebllN2
         rgDw==
X-Gm-Message-State: AOAM533j62W8n4CnhMf6qWG1eXUgq5idl/ZxPNi3hzpmdVSuIxmJ/jhO
        E+/U2XgnWrydrGeO0oT4TziIPA==
X-Google-Smtp-Source: ABdhPJw00kG769CryQ6GyYt8QzevXxWsniJdsZ3bDBhdnyNPjJ/q5GSrgrVTkEWWjjGvXIW0MOpg9A==
X-Received: by 2002:adf:d1c2:0:b0:20c:a916:490e with SMTP id b2-20020adfd1c2000000b0020ca916490emr25540965wrd.403.1652347934209;
        Thu, 12 May 2022 02:32:14 -0700 (PDT)
Received: from [10.1.3.188] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u12-20020a7bc04c000000b003942a244ed6sm2203918wmc.27.2022.05.12.02.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 02:32:13 -0700 (PDT)
Message-ID: <a811a26e-ec34-f9ce-589f-82e96a975594@baylibre.com>
Date:   Thu, 12 May 2022 11:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220512092114.38426-1-linmq006@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <20220512092114.38426-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/05/2022 11:21, Miaoqian Lin wrote:
> of_find_device_by_node() takes a reference to the embedded struct device,
> we should use put_device() to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount leak.
> 
> Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

You already sent the same patch yesterday, please avoid this.

Neil

> ---
>   drivers/gpu/drm/meson/meson_encoder_hdmi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> index 5e306de6f485..de87f02cd388 100644
> --- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> +++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
> @@ -435,8 +435,10 @@ int meson_encoder_hdmi_init(struct meson_drm *priv)
>   		cec_fill_conn_info_from_drm(&conn_info, meson_encoder_hdmi->connector);
>   
>   		notifier = cec_notifier_conn_register(&pdev->dev, NULL, &conn_info);
> -		if (!notifier)
> +		if (!notifier) {
> +			put_device(&pdev->dev);
>   			return -ENOMEM;
> +		}
>   
>   		meson_encoder_hdmi->cec_notifier = notifier;
>   	}

