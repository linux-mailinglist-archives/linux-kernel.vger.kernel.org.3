Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D21346A6C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349540AbhLFUWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:22:48 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36536 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbhLFUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:22:32 -0500
Received: by mail-ot1-f46.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so15172442otl.3;
        Mon, 06 Dec 2021 12:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVW8zpVhLHzE5XFjWmEUZ+W6XLWFa8cwXoH0Ysa7j5g=;
        b=qMSn7dI2ryWAjsezWDXOHbOmTFJiDCRH+jBd0ysKQ7QfWwrhKKJ1dfXYoqC3fJQa7D
         TTqnmWXyBBAD5kGMh7fZH4sNkxn2EDMoN3mdCXPpOCdPb3+12ZHM97GMWZApayhCrLZ3
         qbcB6HT7wSeEjUtrJoeqEPda1FT27S+0zEZqrP5r5LiMGthC9QHJz4jGbK/N6ESBQB6g
         A0sIwOlNT2CGQf8AjExRvc16WIHE9F7zDIxYdpcaxpiXYkDJqQgpvIzXwJ5afVmk1m4k
         rOWYm8ngSS8fF/tBltyO1c5hgL4Pr3//9mKU9mr/8tTaEMYu52uF6qe/OS3uclESoOsj
         +p9g==
X-Gm-Message-State: AOAM533TXHWvyvK1e42fctGn3axc4FPbAeyif0yqWQS0N/6y8bXltfj7
        vwBdGeoGTpjfiVUwmiD/Eg==
X-Google-Smtp-Source: ABdhPJxv20guxGntftXScTUMofA+uI9MxsKRf3XufpJ2T+JuE0n3hGdob5jyY8JbStEiAmKhxzTDrA==
X-Received: by 2002:a05:6830:453:: with SMTP id d19mr31740183otc.72.1638821942757;
        Mon, 06 Dec 2021 12:19:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r22sm2787324oij.36.2021.12.06.12.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:19:02 -0800 (PST)
Received: (nullmailer pid 2516444 invoked by uid 1000);
        Mon, 06 Dec 2021 20:19:00 -0000
Date:   Mon, 6 Dec 2021 14:19:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Virag <virag.david003@gmail.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Only show unique unit address warning for
 enabled nodes
Message-ID: <Ya5wNM/cAt1rwazv@robh.at.kernel.org>
References: <20211203183517.11390-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203183517.11390-1-semen.protsenko@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 08:35:17PM +0200, Sam Protsenko wrote:
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

Presumably you have a dts file needing the same thing, so I'll be 
expecting a patch for that too. That's in scripts/Makefile.lib BTW.

> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Reported-by: Rob Herring <robh@kernel.org>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index c9abfbe3f0aa..41c555181b6f 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -65,7 +65,9 @@ DT_DOCS = $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
>  override DTC_FLAGS := \
>  	-Wno-avoid_unnecessary_addr_size \
>  	-Wno-graph_child_address \
> -	-Wno-interrupt_provider
> +	-Wno-interrupt_provider \
> +	-Wno-unique_unit_address \
> +	-Wunique_unit_address_if_enabled
>  
>  # Disable undocumented compatible checks until warning free
>  override DT_CHECKER_FLAGS ?=
> -- 
> 2.30.2
> 
> 
