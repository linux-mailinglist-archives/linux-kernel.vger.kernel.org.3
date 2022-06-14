Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2262A54AF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 13:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242588AbiFNLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiFNLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 07:47:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A844738B;
        Tue, 14 Jun 2022 04:47:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id v1so16563497ejg.13;
        Tue, 14 Jun 2022 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4T7FatHUEWyE0/J2q0UksKjdBVt/etQpJFBpvcjCzb4=;
        b=QT0iuhQDlvN3YyjmWFrFiMQmniIBmhz74YIlNADPWNY8MHBAuCO25eBMOU99FifoU2
         KaFzd71X7/iAGw3Fv99oyWSjDTapjGl/mJ43ITiGvFNm2HXFj6HhVIY244dU7IL4vZxi
         xwiYdk2kRWWjOc71NUe/IwKQWFxFbfNRpjU1vwHCS+ZDW1Wguco2iYPXQ1VZp9NIG8iz
         qDbhDtNliMvlwtIEilwU48VzH04NtffUPwXCj/REb1DAGsmzPV2MsPVbJvbQ7Od0uBpd
         X54CaI/+F9wMs7K1XTWxxHxPw+numHyls8gHf/6VAplZoBHmnCNXsaZHyoqFu/1gC9nN
         PXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4T7FatHUEWyE0/J2q0UksKjdBVt/etQpJFBpvcjCzb4=;
        b=ODrFb7ItEg0c64XloxJ1v6k5Ok0oMjSpCDV2sr5QYsd0t4GTF1S1nSAZpnxLtlmxzg
         Fndqpdxw4LJXRpuU+tHSFvtWjAwa1FkEotH4oUWIXUhIi5ofzcAvLi8LUElKcxun361h
         RArWEMNp+MKKObCon5fk67//slIRC5W/mdm7xhxpi+ectSS2JLPagzG4LsEq39cOlTT4
         14DPnKRmoKQNm5lgSy3YYTre/T31t7D8+w178EjFfPUp2Wk50N6JtfrfdBkCkwhW531W
         NB/hb/pOGr2lBPtadd25QlkNb+jRVQpJs8HAnMgoT0zQMu93nUv0Iz1vxMoT3kwmQSTG
         dHKw==
X-Gm-Message-State: AOAM533B5H7SRzbBQWHtagR9938J0k+2lve4ny0ZLfhJ+0Cu4soN+HC7
        xUa/kiE1AWlI35hbavTbdkv/VXKwqAftnmrvruc=
X-Google-Smtp-Source: ABdhPJxdZq2dsz6vvs1wjp4sOAnVfA7wrRHT0ZPd7X7dMxTLo9BCnoRL6nQ1lL2RjN3jeD3LouiP8vDAmOGoPeBGnB0=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr3973476ejh.497.1655207229182; Tue, 14 Jun
 2022 04:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-16-brad@pensando.io>
In-Reply-To: <20220613195658.5607-16-brad@pensando.io>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 13:46:32 +0200
Message-ID: <CAHp75Vfrgw4sf7itQ-RVjNTNOrO95YeU9ugZc9sbBUYrpda5eg@mail.gmail.com>
Subject: Re: [PATCH v5 15/15] reset: elbasr: Add AMD Pensando Elba SR Reset Controller
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, piotrs@cadence.com,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 9:57 PM Brad Larson <brad@pensando.io> wrote:
>
> From: Brad Larson <blarson@amd.com>
>
> This patch adds the reset controller functionality for the
> AMD Pensando Elba System Resource Chip.

...

> +#include <linux/mfd/pensando-elbasr.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/regmap.h>
> +#include <linux/err.h>

> +#include <linux/of.h>

There is no user of this header. But there are missed ones, such as
mod_devicetable.h.

Keep them ordered to easily find such issues.

...

> +       ret = devm_reset_controller_register(&pdev->dev, &elbar->rcdev);
> +
> +       return ret;

It is simply `return devm_...(...);`. Looking through your patches I
can tell that you may easily drop LoCs by 10%. Please do so in the
next version.

...

> +static const struct of_device_id elba_reset_dt_match[] = {
> +       { .compatible = "amd,pensando-elbasr-reset", },
> +       { /* sentinel */ },

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
