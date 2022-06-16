Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892954E999
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378067AbiFPSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378041AbiFPSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:40:33 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D85544CB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:40:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y196so2214370pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HU/S2rDRdJXSvF2HJYT5MX/Baf9+5cy35uV5UBnDVAE=;
        b=UgAioPDwOol1mtX0moiIbUq+7g/dIGZTQMDu5AExU6sV7xVip/EnXbsCYhrh+WNSuv
         3h3bc+N4mJWEnpIVGGN5FXzozf+7YN/8zTSAkAwZfnleROINqUyL24D1QrqvXWGRhx+K
         OCqAZBEhp4X769KOpgSkUT89EKd/ve/Di6LiAM2REFFYHDOxtaTwUFQoTBWzPX71QHsm
         Yl6jlmv1I6C+WmgoUV0wwSo/7SeDGhP5hOb9SNMtF7Uop4RTkdB7KdgIWoftWnCBY70s
         /Wkm+ijxr+jah2XQshzjkHeeKoAAOWtzKrVhnik94cYstOcvMlmgSuELVNle2JqCOVUh
         Hi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HU/S2rDRdJXSvF2HJYT5MX/Baf9+5cy35uV5UBnDVAE=;
        b=Pl0Xu7sgVbzAphsC2rVhZSWW8AELqAPFBtAcCFWNbfq/mrye9UfDCf6R9IrhMoqa8k
         6fcnbg0obUCz3upSQq5rI7a5sVVPPOx4SjwO8YdP9cL2tkT15IRZzPqz09OIlSRfOvZ4
         1vEdZuQ3i0IwseeMFfnvW4NfYapr6DzpZ5scnuopXg+pykhAbltreJwhi+Rskl5fXXta
         tS1BWY0Qflk7i+PocTMqMvaN4BuTRPSnHnTiDDUr+SXyD/ZH4sz9dnfgbwA2EHIpIUnv
         naD/qNpdzFCRnFpaRr/jf4lAU3o81TABKJ2ZbF6FiY1utV2HsZc4kPgqSKYKbAXkC6vh
         8esA==
X-Gm-Message-State: AJIora9oa7wznAyKlfyHfcin7LQ2NXVYawLIq8aMNViQkVS8Jr6LcT4s
        SpiZGAD0/mlb8ktwhNdUa+BgZg==
X-Google-Smtp-Source: AGRyM1uTOQPUU6gJIf2RfGvYLof4xidypQqv0TIVUTH6ipWOrME4pI+sniIJ6KwXyC6IjQxxeU2/2g==
X-Received: by 2002:a63:441f:0:b0:3fc:8bd2:f828 with SMTP id r31-20020a63441f000000b003fc8bd2f828mr5506549pga.579.1655404832093;
        Thu, 16 Jun 2022 11:40:32 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id o11-20020a63730b000000b003fadfd7be5asm2148272pgc.18.2022.06.16.11.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 11:40:31 -0700 (PDT)
Date:   Thu, 16 Jun 2022 19:40:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: mt6397: Add basic support for MT6331+MT6332 PMIC
Message-ID: <Yqt5HPIXbOab6ik5@google.com>
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <20220520124617.228808-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520124617.228808-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022, AngeloGioacchino Del Regno wrote:
65;6800;1c
> Add support for the MT6331 PMIC with MT6332 Companion PMIC, found
> in MT6795 Helio X10 smartphone platforms.
> 
> This combo has support for multiple devices but, for a start,
> only the following have been implemented:
> - Regulators (two instances, one in MT6331, one in MT6332)
> - RTC (MT6331)
> - Keys (MT6331)
> - Interrupts (MT6331 also dispatches MT6332's interrupts)
> 
> There's more to be implemented, especially for MT6332, which
> will come at a later stage.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/mfd/mt6397-core.c            |  47 ++
>  drivers/mfd/mt6397-irq.c             |   9 +-
>  include/linux/mfd/mt6331/core.h      |  53 +++
>  include/linux/mfd/mt6331/registers.h | 584 ++++++++++++++++++++++++
>  include/linux/mfd/mt6332/core.h      |  53 +++
>  include/linux/mfd/mt6332/registers.h | 642 +++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/core.h      |   2 +
>  7 files changed, 1389 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/mfd/mt6331/core.h
>  create mode 100644 include/linux/mfd/mt6331/registers.h
>  create mode 100644 include/linux/mfd/mt6332/core.h
>  create mode 100644 include/linux/mfd/mt6332/registers.h

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
