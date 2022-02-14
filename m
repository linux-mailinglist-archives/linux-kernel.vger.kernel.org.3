Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AFF4B51E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354393AbiBNNjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbiBNNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:39:46 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF74C43C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:39:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c192so9667371wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q2xtWcTzY3fGlUDVCwgpXaikGTqqdVJF0/bajHnvT9c=;
        b=LXObhA7CkZldKpmJtEIVyeLqTUnGJJ+OV4THrg0bz4HYxjLuVoytkNE4rj6N2ZGsmx
         z+KkPM7bpnuzFWFnOx5Kq5F1NEA5HIITJDNABELF3rZ6bHYoxb22vk/u8KLV5lCERQF9
         SkPCUHCmgZZkbAj1yX308h9fjCJdnpdqE2VXJpTbOgft5k/eMUXmMf17ya07Q203ZABn
         ggEyEKW/AZ0drKaLAiLhi/6HBgHGhALQdspsRMCBd2ZMhkXpGbIjjtNP+KLOpZvcJQYa
         3CDUYeFLx+C015uvwo4tVLa/VbaJ5npsh/NA3JbCn23fqGSmNWtGNiHDgxdplgX7LzJ0
         QfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q2xtWcTzY3fGlUDVCwgpXaikGTqqdVJF0/bajHnvT9c=;
        b=tbWTpBAi2aNiYd9AyQfqSxIZX9elGWSNox/vOzlXbP8U9Li+2RunNf1XHxDjWEyV/j
         bDATrdfKptkFM25oFDBnOAji13JksabsfToO5Pd/FnSBpc1G3CuGy4cUXhEa/a/tREX3
         bhW0KRuOorrlZagPEV55WdN0bzmgBEDfZh0srlMpVwJof0O+g4rZv9PWRb20tmvPfCTd
         iW00wNxTs080ZiqWHWUKWaLfijwb1HZHnE2lQYCHefMhbdk+YEoevKQi51tIdY7f1w/m
         vb5OQsplt5k9rt8VqOJ0EXJb9Z5EFRFnsWlOHMJb/wxIU2GxZB777lDPE0J1IFeKRDuw
         Ce3Q==
X-Gm-Message-State: AOAM532Z+DqtojjMzQrQT4UDlzqh7Xe+rfpPj+sB0lHQyGfr6MaD2BzH
        qFWh3O6wvHwyuXoIxR+P/uAedVq2uGsk8Q==
X-Google-Smtp-Source: ABdhPJz6XTNaTVeZypQMsL8H4LbZtEGF7tz7EdWyK1/Em9NjbpCUd9iH/ks8ltgR5rz3uSVfJn1YSw==
X-Received: by 2002:a1c:f309:: with SMTP id q9mr11290076wmq.173.1644845977531;
        Mon, 14 Feb 2022 05:39:37 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id az21sm11878848wmb.11.2022.02.14.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:39:37 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:39:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/4] mfd: Add support for the MediaTek MT6366 PMIC
Message-ID: <Ygpbl/pxEVAug6jl@google.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
 <20220106065407.16036-2-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220106065407.16036-2-johnson.wang@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022, Johnson Wang wrote:

> This adds support for the MediaTek MT6366 PMIC. This is a
> multifunction device with the following sub modules:
> 
> - Regulator
> - RTC
> - Codec
> - Interrupt
> 
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6366 MFD is a child device of the pwrap.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  drivers/mfd/mt6358-irq.c             | 1 +
>  include/linux/mfd/mt6358/registers.h | 7 +++++++
>  include/linux/mfd/mt6397/core.h      | 1 +
>  3 files changed, 9 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
