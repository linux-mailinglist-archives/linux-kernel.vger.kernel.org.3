Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE2574F21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiGNNZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiGNNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:25:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4099C6112D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:25:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t1so2782222lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cI4EPJZvjOmVCwlncQ06krIDHxj26fKpcWTj2anfYmI=;
        b=TDrI4nn1sWi8ehUrOQ9H0Jz+yqcwvUJ7TBjohvG0+BYrKTiz5ZnxUFSOOiBL0uiyZS
         G6a7c2o78hOr1PmYaXtjVLKB38Fs5W9mpgBcOJ2SahEI03CJe7LxUUJ5s1lOxk8SkqRf
         c0Nw6o6L3iIn1uWJFqbEZBgSzK3ZU9MubvknxRu1f4hvuPGaUTP9XvKqeMewefPyCcQk
         fv3c5AFAdWJ+TdKFg+rPq3vcx3tXjayipax1LItn3WFjtB8p7NiW7POvVsplMTse7D6I
         YDEVEKptWa/vzxuRm3mgXAr+Bqy7t26stkLZuYXcD7QYSb49AZpXCKV2v3zhBcBaD0MI
         deXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cI4EPJZvjOmVCwlncQ06krIDHxj26fKpcWTj2anfYmI=;
        b=jSpYFelkpZKwT6JjvtXkZ98iL0HQPrqOe+OeWNwTC63hn4n9raBu7Hh/Peu8VxcyE0
         ifElqBpoqHiVNlhqD91K7SvECF2XR9rcXhAZZvUHH8ZCRYTmHNV6S0Ndv0PFHK/za07L
         G2SHABLpeE0Yw4nelZkq/N8YDPX7gHqfgHBv4sfFGA+LX4gW36WynmsKUiYzM+IiSXrU
         rWtoHAEtr9jSwlsJBHDYMkE00iTlkutvUvvRwlYISvxent5UigOYqfKYJMRGbgvkRm2d
         RulKIi/t9wzTBd12K/R8uHVdBiSfnBSzG7RTCo2zK95hy2kqGIWANt7qfjxFBHfmfG+A
         e3Sg==
X-Gm-Message-State: AJIora8JpmZJBUr/AwLdXBSIhqrZ7uhzLGm7xpAPDG9TZlrKKTuDVKpA
        WbvMrko/fGrADO80OBI6YjU4T7iLDyrwAHo7Njo+Lw==
X-Google-Smtp-Source: AGRyM1tcrTCEOfrbRktfpbwYwNL8Kewo76hUGu+vhbpgDmnZs4CnfFPwH8Ie/NXszeuIdTiIN2vPc0kRFM+JwAusXL0=
X-Received: by 2002:a05:6512:2252:b0:489:dede:1cb3 with SMTP id
 i18-20020a056512225200b00489dede1cb3mr4979227lfu.503.1657805117555; Thu, 14
 Jul 2022 06:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <CGME20220710230617eucas1p2a9ba640ab97b608c6fe94007641012a4@eucas1p2.samsung.com>
 <20220710230603.13526-6-semen.protsenko@linaro.org> <00191759-df90-c020-92e8-37454edba6e1@samsung.com>
In-Reply-To: <00191759-df90-c020-92e8-37454edba6e1@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Jul 2022 16:25:06 +0300
Message-ID: <CAPLW+4kbCfjCqLGhsUUhf3Uzu3xkzoGT76+7LKFVA3Y3ozH6hg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] iommu/exynos: Check if SysMMU v7 has VM registers
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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

On Tue, 12 Jul 2022 at 18:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
>
> On 11.07.2022 01:06, Sam Protsenko wrote:
> > SysMMU v7 can have Virtual Machine registers, which implement multiple
> > translation domains. The driver should know if it's true or not, as VM
> > registers shouldn't be accessed if not present. Read corresponding
> > capabilities register to obtain that info, and store it in driver data.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>
> I would merge this with the next one. Imho this change doesn't make much
> sense on it's own.
>

Will do in v2, thanks!

[snip]

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
