Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CBE544763
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiFIJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbiFIJ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:26:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8608749F20
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:26:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so5296012wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=doJDwgeNCCpGAVqsr1zYgJtRpwsMml2sELB5t/MLY5M=;
        b=VPq3f0ZdO06SkOgMTlkS3D7YZmul+nXO/J0BjMk+stYpad6L9H5cOp2IBGHQEJn+Sl
         1DMRophNR04WNcXUHOqrs6OdfQB6HANh/JIw0MbdRNMPdyNkUr80U6L24XxRCD+MDAjQ
         b8uHt8YM3EAoR9QEqHA6AWl3jKoB4Qv35ji2cAwqZiUJ19jKK2galnmED0gVBj+49+66
         /qGVkju5ZMhYZOrCdmwHdn/4FpDWyJv/LT9amthGPdsenZoaAJkV3WM4pcG5dhO2/6AC
         O8TCD9uWN5YA+b2+xx6Tzxnp/uPXS1CUQ9z2beYU40E9pslWPHdTUZeMIWzAmccv0CRG
         zrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=doJDwgeNCCpGAVqsr1zYgJtRpwsMml2sELB5t/MLY5M=;
        b=MfAyghMqriqe56iRnz0alL8hWGHRYxcP9dvSZDHBFEzfwesBe0c0WD8e6HmdBBuDEZ
         U/xNXtz/jlN9ajpdUqqM4KLrzkMaAw6qCsmt3ECz6ob2FVOetLP1DKG1e9NMiZSuLQMA
         po9pTUZEb9rwJ71wpJwEKs6/vPIIQ6S3sIlZZg/G/bJ1lz0l+6Xt1GWuH6rBE3cRqlR3
         ssU3QMZxvt0yUVhk+yzrK/YVz5A8TjimdUncEm4OQd9ZwrERqEEO0teVPd4hrJLAbuX/
         t8JXDNlD8g9g9no9inRcrzGOP+HVmZU2DaNmCxaDCnjAVo11cuJvXfnT0a8sigiHy/lr
         vCBA==
X-Gm-Message-State: AOAM530rwF5zSb8jYC/r8KyHwOSakMY/2Ta80GboUWldjJdlV3ipQQ62
        1j1xmIdQeowDn1ow6psOAzBGDQ==
X-Google-Smtp-Source: ABdhPJwHbfMoTUujhvRpFZUQSGO8P5QHWho99EELCVbHKvomYjfYHQdY9sivEWq9/Zf7ddPDSfJWtA==
X-Received: by 2002:adf:f750:0:b0:210:2ef5:7c5c with SMTP id z16-20020adff750000000b002102ef57c5cmr36424281wrp.416.1654766797986;
        Thu, 09 Jun 2022 02:26:37 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b15-20020adfde0f000000b002103136623esm24819171wrm.85.2022.06.09.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 02:26:37 -0700 (PDT)
Date:   Thu, 9 Jun 2022 10:26:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        deller@gmx.de, cy_huang@richtek.com, lucas_tsai@richtek.com,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: rt4831: Add the new ocp
 level property
Message-ID: <20220609092635.ew3wqfi2uv6d3smj@maple.lan>
References: <1654741339-12756-1-git-send-email-u0084500@gmail.com>
 <1654741339-12756-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654741339-12756-2-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:22:18AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add 'richtek,bled-ocp-microamp' property to make it chooseable.
> 
> The wrong backlight ocp level may affect the backlight channel output
> current smaller than configured.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
