Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48CA48A111
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiAJUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:44:00 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43634 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiAJUn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:43:57 -0500
Received: by mail-ot1-f42.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so16327786otu.10;
        Mon, 10 Jan 2022 12:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=35ppYNSAmjaG5G1WU9sJ70GdaIEALpVsBIAt+1Hioso=;
        b=rm7+kKDAsEY1HMxNaXuxFX8Ca8wgDjCiSuw1bURub7Rw+daGP5rxHOKqA1i7GRbv/5
         JcZdrCXGYT81VrSyEVzqbKS/Hbh2GIS/wHI+lDNZ30Emdfe4TybTJP5mdDTl4XYIEbno
         +OqbA/HU1if1mh4fZR2DADpFmUXPy9RcIYntcc7+NzS7WbXUXLhBaMdTE2FAIIJtEj5Y
         XhdIa8H3TfrdfL+HV+3YKumCJEzfgOi1n0U94+U64NKb0vkjd/JIiYf6BJbm+RNRbbk1
         f/d8CK/D/WHbq4CSQkWTaRYcc7w4GSjxSc/YSOodh8guH8WCAf1zlUjLRo7dgkHzDNBH
         FN1g==
X-Gm-Message-State: AOAM531gx+VtbdqTrMiqAT22+C1FMRLw1juP2I2NtbdlOe1o7tBrgYdJ
        xk/0+9iIcjD1u7XxI2XZdw==
X-Google-Smtp-Source: ABdhPJyBvbsbnfquLYElQlWNfNFL9BS8th3+wl64bJOBJNXkRXWAnCwSdEzfhIomEwmml1ZpoFdukg==
X-Received: by 2002:a9d:f63:: with SMTP id 90mr1164831ott.268.1641847437087;
        Mon, 10 Jan 2022 12:43:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o145sm1507049ooo.1.2022.01.10.12.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 12:43:56 -0800 (PST)
Received: (nullmailer pid 1472820 invoked by uid 1000);
        Mon, 10 Jan 2022 20:43:55 -0000
Date:   Mon, 10 Jan 2022 14:43:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 24/24] dt-bindings: pinctrl: samsung: convert to dtschema
Message-ID: <Ydyai46oaXI5+ixU@robh.at.kernel.org>
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
 <20211231162309.257587-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231162309.257587-7-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2021 17:23:09 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC (S3C24xx, S3C64xx, S5Pv210, Exynos) pin
> controller bindings to DT schema format.  Parts of description and DTS
> example was copied from existing sources, so keep the license as
> GPL-2.0-only.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../pinctrl/samsung,pinctrl-gpio-bank.yaml    |  52 +++
>  .../pinctrl/samsung,pinctrl-pins-cfg.yaml     |  81 ++++
>  .../samsung,pinctrl-wakeup-interrupt.yaml     |  76 ++++
>  .../bindings/pinctrl/samsung,pinctrl.yaml     | 381 +++++++++++++++++
>  .../bindings/pinctrl/samsung-pinctrl.txt      | 383 ------------------
>  MAINTAINERS                                   |   2 +-
>  6 files changed, 591 insertions(+), 384 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-gpio-bank.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-pins-cfg.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
