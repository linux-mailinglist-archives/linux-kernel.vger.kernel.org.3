Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB3574ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiGNNPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiGNNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:15:48 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363A1545F1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:15:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o7so2731709lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y48E6PDFxhOGhAYVKqWlob2V1GffQky6+hara5tcdLo=;
        b=x9Hqw1BTgXzHKBiG2OLYcS2qRp7Sz3flmFvjdYEncU8GDBZQGFzRHDqWvl2GZEQzWs
         FsmPaPtuFGaiqKXQ0rgYuY1IJvGT9XHaKIiGie3uBqCYb5yZUxsGKCGerqVb/EDy2MQy
         BrkIPlpMjIIODx0OZIpPfuVTK/CPTmssfDzD87fRsv5/iF7Rkgzt3wvFTahxaqIGZ+wF
         b0LxvmpRxROYRG7PvrgPGM3wSIagrIcIKwRXmd8quwYVM2XgRpqq7+pGhei6aj5AEZ1a
         ZxtNyfAEF5Qg5TkVb401bU9vk1vAqt7Jy4UkztS6JIJpbx4jaxv5mhURfqXHgOZyi+xk
         gVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y48E6PDFxhOGhAYVKqWlob2V1GffQky6+hara5tcdLo=;
        b=ldaLjWBVlmGo/OQWY22vF/X3BmAyNQyVIvf8ZMxnG2YiSW/FncRg+km6q7kk9xnHJB
         8tpS64PYChQaemnrFcBJ2Arq3hqJIMGRXEM5gP6op+Fz4ahBGFvprykHBdSRWl1+nYq4
         3gYsVNSL1vsdAdcD9I+gFA7HjuNZd84GBOFTI3eLyg7I15bj6xLFcf8H7leOUNueaJIj
         ULjlecLs+Ll4uhiq6KtNjLvTPjphu8Q/GzwKzcJtDm0xcktYanNo8WQr19vIIf5rBNKe
         gNaV6WFtQMQWh0A4DcJuuOY4isCpyxtJTUG3Z9yJLJ+Q7wxeiKk4IzxA2GvhddxeaYdL
         UZVA==
X-Gm-Message-State: AJIora/4kHP4fH+F5oktqhZxb1FKjMsiCpc9EsJ1qPGk1/73OvWdnkcQ
        pPYktOMA5v9R0k79XYczAZez9tPpLro+2EWcqoHGCQ==
X-Google-Smtp-Source: AGRyM1umM56+JO1HV8nicFnjzJ1pyPk04eb7pywiBmEsbAuvhiuDTIjoJzE4r2MPwg7ysTsXe877jrrGJ/WnekYwUVQ=
X-Received: by 2002:a05:6512:139a:b0:48a:1a73:8adc with SMTP id
 p26-20020a056512139a00b0048a1a738adcmr1218415lfa.226.1657804544526; Thu, 14
 Jul 2022 06:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-5-semen.protsenko@linaro.org> <4d198463-fedc-a5d9-6804-63c134da76e7@linaro.org>
In-Reply-To: <4d198463-fedc-a5d9-6804-63c134da76e7@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Jul 2022 16:15:33 +0300
Message-ID: <CAPLW+4ktP0_W_OgjAoK3BXOFaEiXvP1qNGCc-iQyr2fNL1srug@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iommu/exynos: Use lookup based approach to access registers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 12 Jul 2022 at 19:52, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

[snip]

> > +static void sysmmu_write(struct sysmmu_drvdata *data, size_t idx, u32 val)
> > +{
> > +     writel(val, data->sfrbase + data->regs[idx]);
>
> Beside what Robin wrote, I also don't think these wrappers actually
> help, because you reverse arguments comparing to writel.
>
> How about having a per-variant structure with offsets and using it like:
>
> #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
> writel(CTRL_ENABLE, SYSMMU_REG(data, mmu_ctrl_reg))
>
> Would that be more readable?
>

Yes, this looks better for my taste too. I tend to get a tunnel vision
when working with downstream code for a while. But I noticed that that
approach is used sometimes as well, e.g. in
drivers/pinctrl/samsung/pinctrl-exynos-arm64.c (in struct
samsung_pin_bank_type). Anyway, I've reworked it exactly as you
suggested, will send v2 soon. Thanks!

>
> Best regards,
> Krzysztof
