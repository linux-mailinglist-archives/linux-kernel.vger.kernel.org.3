Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0E48F7FF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiAOQrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:47:40 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51420
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232208AbiAOQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:47:39 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EBC8A3F1F2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642265257;
        bh=UuQGHzFQyjD5NAaAWYOOEzPz/4Y/EXTKf8414g9pUU8=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=u9DzLXCxP861AuO7q2lW5o2YF6Z8VWbwyoG1jGHYQHcppqpTlAXZiOTnrXLHO+Fgj
         q+BiImBiEha9xwBaJFKYVYmKsMqpe5U3SV8KosPF3EL/z5+cZX2YlRX8b1D1yDwS6x
         fn5+zvb1k/d8vhJqVw3xtVqwDhKSmu/qKT7jxWQfKQE4d3T/nEArIdC6H4awk+rysI
         Y8s/Tuv23WpPR5avjfbPqx/Sz4lyh7510/47N5LheRIJjVUiHob6VOB+drrUcuCjZ+
         +/4Iuyod6LxanHmpeRBbwBG7E0dzi9gtpcxX9I1pHJg43EVg3hT2W3caPsvChme6Qc
         ipvOmHuds5BRA==
Received: by mail-ed1-f72.google.com with SMTP id x11-20020aa7d38b000000b004004e4fc8fdso8135146edq.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UuQGHzFQyjD5NAaAWYOOEzPz/4Y/EXTKf8414g9pUU8=;
        b=SXS05ZTT6wT0qeoYL6NcJ1A0qEp726HwYpcEamTranPxTvNYHzxh5c9d09DxGYvxrR
         wT8/99tYxudQDJDP8DUaQwnBW2PxTynPMGkHfvUaKgOZPpmt905/pr1qJHLZiOR0mBub
         jLmlbKYu0upYVTeEqGsvO7y8fPlPmvXlUi2TTRICsu3MRvXW7F3/zopoIXgL6kwR16wd
         Xcq80G3dc2YSIQqt6U95pL8sB4Tay7T78F6QhW0poi/tFokxouvfirsVhetfqhWXMdpn
         7MITBkr0fLfv8XKR14Aen39MyatT2oPUbnp7T3a+a+pNvj4CEgzQtV7TyGwpYwEV1O73
         R+KQ==
X-Gm-Message-State: AOAM530OkpJIAAxLmK2H0E9yuQMngzUkgenkwxV9wMjgEc5TKlwFtf7E
        s4HP1xx6rFaDgUg5urE8McqSrxHPBQ9MZNgYFLh72AV/K4OmgO/h1/IWky4lJ7OFI+ssWSLB3OF
        sKL98TZKuAEMYrA1woISm5A+tG+WmWIFpU7NKsD49gQ==
X-Received: by 2002:a50:d541:: with SMTP id f1mr13426560edj.18.1642265256945;
        Sat, 15 Jan 2022 08:47:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDwb+EUniG7FcTyDyOA4s2o93VYKN49MWn3cGhR9H6XmhKM1fXPDjxM/2AsKbXe+2s7yxGbQ==
X-Received: by 2002:a50:d541:: with SMTP id f1mr13426549edj.18.1642265256836;
        Sat, 15 Jan 2022 08:47:36 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g2sm2723988ejt.43.2022.01.15.08.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:47:36 -0800 (PST)
Message-ID: <95d9a962-3b31-eb19-8297-11e33a3d78cc@canonical.com>
Date:   Sat, 15 Jan 2022 17:47:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 08/11] arm64: defconfig: build r8169 as a module
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220114141507.395271-1-marcel@ziswiler.com>
 <20220114141507.395271-9-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220114141507.395271-9-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2022 15:15, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Build Realtek Gigabit Ethernet driver as a module.
> 
> Network cards based on chipsets this driver supports are ubiquitous both
> in regular PCIe as well as mini-PCIe and nowadays even various M.2
> formats. It is therefore a suitable card to be used for any kind of PCIe
> and/or Gigabit Ethernet testing. As it is not designed in, just enabling
> it as a module seems most suitable.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Explain why enabling it may be a good idea as requested by Krzysztof.
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
