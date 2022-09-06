Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC85AF404
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIFS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:58:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FE5F99F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:58:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id lz22so4554692ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YhCD2BUnvk+EART+qJYRghEdCBWvNx4ju2rtPfEiOI4=;
        b=y+siq/RM3RjL+a1SK0nGMlaEWNEBEQpvol3sAC7TSLKfqrvgrwE+jUGmQgB/MUNllk
         jnsMr1WTUb1cZLxUcNNORCDaeZfQt3O1dgZahrjHwLFy0N6vd6qrvqlsy4AEpQ/4VXsf
         zWotv3g4A24afILYTS/uVTv4MQrVjjn09OpgSxusqSom94LbqJNvu50DCuu0P9ro/JId
         GkTk05VU3tLi5ADw6VkS0s49SNsT77h2jqjtOZEWVI40YVhpkHSt19Z8JmMq67O9jUmd
         fUm9c2Qa9pCn4G5/mzAkrd7N5g1tRPHblr6ND74ND6KX6C6xDtOakIOOqteQoziPUM4L
         N3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YhCD2BUnvk+EART+qJYRghEdCBWvNx4ju2rtPfEiOI4=;
        b=yuI1gVwAtb0tEqMX8ZMwUpdpK42GHAjyXx1FnXSK/YKMyY5Z5tbNGSMAYeSwdhtI08
         L6vsfXCHgeztPlBb+9hsOn7JYuPhlx7l9yYcKvqZpfHpnrIPK2j2YKbdgyIgaunRrQnz
         9Vh05sYZBj3QUWpuLt35MmonIO2rsOTSYWPZsgVxmz2wVwQwMuy3MS41x4Bav6SbmsXf
         x+EfBEuwDUQ4/1+ELTBNxrl7KiyZPAX1XFQ32RyUZ9+scGaIylkW64lTaJb7MMuyswF0
         xcWUmmqYyrkajODImeKZRk4FrYMN7HrduBmTqqMdrvteG+4dREAPBK2DjwPkCLlYSQ8V
         6z9g==
X-Gm-Message-State: ACgBeo1IYRengc5hibu13DLcAyV5cYibzx4OMI5iNSSVEEsQodw1tNl8
        Cb93D+9fRZDKeeZs66Wg2qyaNSk0wCj2/OgDD1Mk/g==
X-Google-Smtp-Source: AA6agR5AOS8szLUYRUywxgPElU/nyOQWQJSIyBhejwRqUbyMNY9SBFGhCIk8wI4FG9Qv8YfYQiDR8F4+fwjKMWs/ojo=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr41006298ejs.190.1662490731615; Tue, 06
 Sep 2022 11:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <YxeS1BK2OBH1P/kO@google.com>
In-Reply-To: <YxeS1BK2OBH1P/kO@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Sep 2022 20:58:40 +0200
Message-ID: <CACRpkdY1DmywF3UdzBQHSp6N_uwK5MK93Do8TkKExtCVVQHZ2w@mail.gmail.com>
Subject: Re: [PATCH v2] mfd: stmpe: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 8:35 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
>
> We also need to patch relevant DTS files, as the original code relied on
> the fact that of_get_named_gpio_flags() would fetch any data encoded in
> GPIO flags, even if it does not reflect valid flags for a GPIO.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> ---
>
> v1->v2:
>  - add DTS changes, as noticed by Francesco Dolcini.
>
> I guess we could do a dance of changing stmpe to check the flags coming
> from DTS and try to distinguish IRQ flags from proper GPIO flags, then
> have a separate patch changing DTSes, and finally a 2nd patch to stmpe
> to use GPIOD API, but I am hoping we could apply this in one go...

It's a mess, let's just apply it and forget about it. It's one of those
trees falling in the forest and noone is there to hear it fall-type of
things.

Yours,
Linus Walleij
