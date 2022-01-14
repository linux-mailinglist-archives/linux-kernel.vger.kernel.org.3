Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B184E48E885
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240542AbiANKs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiANKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:48:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC96CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:48:55 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l4so5715375wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qlz+QenUSGnrbdMSn9LpS6HovcDV3W2NPLhMAnwduME=;
        b=yA2QgHtHWFRB5HEMdX9dVKlR62iq8F7Iheb3RsP0e0SfuJgDUV+sKYaMwULSA982T9
         aUxkXMkx1soxmYPPhTBGFesF1oR9YehEDKBe86ssoOf+1K+o5TTqel4fXWPPtJ6Z8cB1
         4UVzGED5Ewp/5/2d3MuSKJ+ePv2XGDMqZKqbmhICre9J+NprJbbsAMRwP5pmgy3YT03q
         mddBt6PamzOOnN6iO6yHzgdFrgOzpDwhsNobEaNPvHP1ouKnMwr44B2RbQdtEYkmNCbw
         mj1H1kA1UvDuAqVsK0RgnTyxgqj+hrC12xlfzzMtAMYg2/xiIgWL0/mRRyM1Gb4Yk4RP
         rumA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qlz+QenUSGnrbdMSn9LpS6HovcDV3W2NPLhMAnwduME=;
        b=vLZrm9T7uaume90VF4JGqdizPXUwnPAKitcyqhF9ocxkOBGTzF7OhcU2q3uf9c9ei7
         rJJ1nFI/EyDG1Tlwg+ivTrGFig4Xd+/1CrjIMNu4bSGJXLRtXoea6/jy+2s51R1QHPg7
         oal+mBNoUYw66fmllc2LIBVoH43UDPqhplj44GblJJnsYm9D12vNcjvKOsgJ6GgHP7io
         NNa0X4jQqKt7vAUHYjpHy4Y5uqfCnZgr9ocNK6s3/YZ1FE63EQfMWW6iQD/pwbpwhIK2
         lvOAVHIHQbzomMma/jLgPL0pD4cPucyEC/cIbQ6L9X3JSRafGKJOX49sw5c42eBo92kW
         17iQ==
X-Gm-Message-State: AOAM530NHGid7OIZnQ21HuEtJi8CnoXfvwjJJHPI5N9KUIZTd8USiol4
        a4bbw7p8HkOgqVlO4ywb4QnbmM3ysZhucA==
X-Google-Smtp-Source: ABdhPJyA9IFvDW+jppi+5LN7HU1pBJhslP+IyomZomx39JMhU94/e9y+T2N1wYW3zeUVjUVXl1CdWQ==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr7640215wme.139.1642157334091;
        Fri, 14 Jan 2022 02:48:54 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:a3fc:c40b:5afc:88ee? ([2001:861:44c0:66c0:a3fc:c40b:5afc:88ee])
        by smtp.gmail.com with ESMTPSA id c8sm6018436wmq.34.2022.01.14.02.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 02:48:53 -0800 (PST)
Subject: Re: [PATCH] drm: bridge: it66121: Remove redundant check
To:     Drew Davenport <ddavenport@chromium.org>, ple@baylibre.com
Cc:     a.hajda@samsung.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220114064012.1670612-1-ddavenport@chromium.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <44f2e610-ab69-2c32-8c1d-a9f40aa607f0@baylibre.com>
Date:   Fri, 14 Jan 2022 11:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220114064012.1670612-1-ddavenport@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 07:40, Drew Davenport wrote:
> ctx->next_bridge is checked for NULL twice in a row. The second
> conditional is redundant, so remove it.
> 
> Signed-off-by: Drew Davenport <ddavenport@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 06b59b422c69..69288cf894b9 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -936,9 +936,6 @@ static int it66121_probe(struct i2c_client *client,
>  		return -EPROBE_DEFER;
>  	}
>  
> -	if (!ctx->next_bridge)
> -		return -EPROBE_DEFER;
> -
>  	i2c_set_clientdata(client, ctx);
>  	mutex_init(&ctx->lock);
>  
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
