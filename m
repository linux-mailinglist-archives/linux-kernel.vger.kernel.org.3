Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1B573028
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiGMILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiGMILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:11:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C81E95E9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:11:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bu1so13181250wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w3mh7mSgOdwjOte1AQXmDns6aE0VntldMF/fOySoyz0=;
        b=uCrAA+uzPAWxLWCGb4PkG9dXnQy25fjY2FJphWgJuLK+++V+mJWdRDrLrB1pwl6tn+
         mBscwpHrjnFK+uWfxkYUL9hLFrjJBhB3C9cZSKxWhTt+Kw8mUt/oXnDJiyseGQ8Sa9o3
         a96/37rjL4yt31+2z3ewqsOk2x5din6PCBQA2Ywc8OAsVIVJ7lufUsvdSnYv5zE1NCMU
         zEd72FWpbLn14QkBP7gfXjuLZZRoJwm4yNSNg3ERqPVh3U9+M3rlxGwgv3+XzM3SpBRl
         tRxhq6fDewKvNFqThx36ZjEIp6lKDT0+QO9ekStVMJsBY9UO45wYN85ZTfLoZ7Yy6kuz
         1iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w3mh7mSgOdwjOte1AQXmDns6aE0VntldMF/fOySoyz0=;
        b=pjP+y9OZq1fT3VvjBgiUpBYFwUkFWfMDYWZAbD9Nvuxnb+rvLXiSqXi9GqYxIdTsON
         FOH/KnOuCyFgTipQcrNNFez4AIeIWF39fWan1abLBznQmpnIPODN3cA+FrK6h3l+QNOX
         ljiVgGBxrIY9G8IGg7IzYXNmyB+Wb2L6fOEkaPSA7zbDTgxWyzhVuVuXP/eKXQXLtLGo
         CFDC64roejhGeUIEI7HH12BvpYkfPKBsGBD5ViTGYCJnSEkHRt8W7x8DQvIWsymhT23u
         l77ytAvyO15r+zbD3hjNCXQVwBgNAmoPvstAPL9IN6mthhWwtIhpJLe0TK/Mzjvrwi0j
         ZHOA==
X-Gm-Message-State: AJIora9cc0XyENix4tkSPKyi30p9DX25cYlzymGnQrD4m3yTrjoZ91aw
        WMBmmnOIYhKKjXfg2zpqYeWxIA==
X-Google-Smtp-Source: AGRyM1vXUPhWcRP/h8EOhUrcVZT9zzgiwiQSjeNfCyeXP8a0q8IfaM81cuydW1W8bgSk4nlqDVWyWw==
X-Received: by 2002:a5d:5683:0:b0:21d:8013:cdc7 with SMTP id f3-20020a5d5683000000b0021d8013cdc7mr2029245wrv.618.1657699902753;
        Wed, 13 Jul 2022 01:11:42 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u13-20020a7bcb0d000000b0039c54bb28f2sm1311516wmj.36.2022.07.13.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 01:11:42 -0700 (PDT)
Date:   Wed, 13 Jul 2022 09:11:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Jingoo Han <jg1.han@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "drivers/video/backlight/platform_lcd.c: add
 support for device tree based probe"
Message-ID: <Ys5+PH4ig049cavb@google.com>
References: <20220629210024.815761-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629210024.815761-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022, Rob Herring wrote:

> This reverts commit 52e842432f36d5b15227d0ee0d2aa3d2bc3cc0b2.
> 
> The DT support never would have worked because there's no platform_data
> providing ops. There's not any documented binding for it either.
> 
> Cc: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/video/backlight/platform_lcd.c | 10 ----------
>  1 file changed, 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
