Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9B46A6C6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349705AbhLFUXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:23:05 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39853 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349642AbhLFUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:22:50 -0500
Received: by mail-oi1-f172.google.com with SMTP id bf8so23598108oib.6;
        Mon, 06 Dec 2021 12:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Tqf0IF8fIl+oxxxaQiInxDbNA4xfQa3nl9Y2AxI8zY=;
        b=ZjE3YPQJG0NrlVxIc4G9L+BIXQlgEDChqUNmrCuiqBNqnIDcmlRl+UM+MXvmNbBDIX
         yCZZDw63AYEeWEhVyCXd/Hnq+i5IxheNWPPhvTOD8Do+dTWw07iRkzChcbnU7v2Crihm
         yMxrlCIO6UsLzxZmbHF4MZNeNo2ZF7IRtZWpbqCTQTeTXvG1RRTeQAg5FOD8oMGcFL7m
         gP3GBNuuIYZNa3NwfI2cu0QYz9VK+KYrHjhnyg0XUaYaip41JpcKsiIiLPdd+YtCSVsB
         f1gKvAIJxE+WJGkKN9mxv9OQXCVbBtbEIcKfpcsd8j9CnAL6Eb/etIc7Yyz6QxVuu9C6
         Q9Hg==
X-Gm-Message-State: AOAM531dyYpH32Y+3AZfEoFSJnZx6habsVQoa6EIz6QOafKScAuimY8J
        G9nB03qu+DmDc2r+qgyyTA==
X-Google-Smtp-Source: ABdhPJzWMpEnHhfr7zGyJytVxG58jTwg3k0MPNXP2xd8f6+1bXYrIBj6//1jpgCs7lCTA6RcnkXJ5Q==
X-Received: by 2002:a05:6808:bc3:: with SMTP id o3mr828054oik.151.1638821960508;
        Mon, 06 Dec 2021 12:19:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a12sm2409235otk.35.2021.12.06.12.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:19:19 -0800 (PST)
Received: (nullmailer pid 2516937 invoked by uid 1000);
        Mon, 06 Dec 2021 20:19:19 -0000
Date:   Mon, 6 Dec 2021 14:19:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Virag <virag.david003@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Only show unique unit address warning for
 enabled nodes
Message-ID: <Ya5wRwx9xZX9pQBV@robh.at.kernel.org>
References: <20211203183517.11390-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203183517.11390-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 20:35:17 +0200, Sam Protsenko wrote:
> There are valid cases when two nodes can have the same address. For
> example, in Exynos SoCs there is USI IP-core, which might be configured
> to provide UART, SPI or I2C block, all of which having the same base
> register address. But only one can be enabled at a time. That looks like
> this:
> 
>     usi@138200c0 {
>         serial@13820000 {
>             status = "okay";
>         };
> 
>         i2c@13820000 {
>             status = "disabled";
>         };
>     };
> 
> When running "make dt_binding_check", it reports next warning:
> 
>     Warning (unique_unit_address):
>     /example-0/usi@138200c0/serial@13820000:
>     duplicate unit-address (also used in node
>     /example-0/usi@138200c0/i2c@13820000)
> 
> Disable "unique_unit_address" in DTC_FLAGS to suppress warnings like
> that, but enable "unique_unit_address_if_enabled" warning, so that dtc
> still reports a warning when two enabled nodes are having the same
> address.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reported-by: Rob Herring <robh@kernel.org>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Applied, thanks!
