Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4116A56BA85
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiGHNSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:18:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46C71C91A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:18:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s14so25938624ljs.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Yam3y0DcCFqvtPSG9KOweCqxMOCqoZ/tVs5qs0X19I=;
        b=kQj86bjG5zvMHEWhoxQWhFXTOUb15TA7YqDTqLA361xfX3dMGb3sA66mMwl6cGu1Cp
         6Q867H9s0YhApBd6xEXsnrThqvBSoz4fZBP7GLTRSaQ2QnK2HHIHWLF7Bkz+/ibQrGx9
         WmOhWen94YFgjXDgtkMpIKy7LhOV3xpqHo7pF7uXoOeJux9kYLux8b8Da6NFvugnft3J
         7IDixkpvl3CYYIAi1v+2agBHTgmcIGWQ7LyOylWYDH605GAIKDf+ueY84GGCLvQA03zg
         h7ZrE3ctcGYV6khkrm9AlNVaQcIRWiW0Aabx9L/vnPGrhtaV+DOamJDJZOY0RVy/mPqT
         Q1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Yam3y0DcCFqvtPSG9KOweCqxMOCqoZ/tVs5qs0X19I=;
        b=qUnDNWt3Pe+ACJRKf7JXJsVxHUkB8KfgWTP6XvpBlE7KehsT+wCndke0jWqfJn6ZkP
         hqJlLl5Y19E5IULEIaIvbbACslOmu659fxCm9fXoK/dIbCzaXjfUN5Ds2W3k9Nx2PG+d
         I/mqXmPmvO3EaJeyhaWgPaH0MEZQQvR1Uek6PYZUV7a9PLczm8WnhjSK1J1vSQ02InmG
         CVeV8Sv9OCglgpmI58BGWa5dcMsMtn07W6BeIBbFFaCnBxfx0W7dzFEHTn24Sfa8VUlT
         HyQkWNJw4aCyfJIrl7ElNlgfP1mB2a34expwzSjjGZ+l3LxHcAtRZEIdgNXBZJaxGxx7
         ofBQ==
X-Gm-Message-State: AJIora/fFnV5aSTo/HCvptGTlKtUwgmmX+YQz6rKthGYXfJjwHmTPdb3
        yHZs2xeXO3oba2m1hKlUx/9OhMaTx8/oAMR/5z4vLQ==
X-Google-Smtp-Source: AGRyM1uIshwbshScAbeRQz3UVgzvkjmr6Hms69W47MrzRQoRsZF9RKD+toMCTMaHHbdrVf4EyhuKSDLC3CiVAnM6wtg=
X-Received: by 2002:a2e:a413:0:b0:25d:4844:9d65 with SMTP id
 p19-20020a2ea413000000b0025d48449d65mr1997343ljn.169.1657286324182; Fri, 08
 Jul 2022 06:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-2-semen.protsenko@linaro.org> <9afb1e98-706f-ed61-892c-e3cc321364b4@linaro.org>
In-Reply-To: <9afb1e98-706f-ed61-892c-e3cc321364b4@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Fri, 8 Jul 2022 16:18:32 +0300
Message-ID: <CAPLW+4kfrHOb8utzynhB=2KLDQu-NC08UYpAVjpg__NQSeSQyg@mail.gmail.com>
Subject: Re: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
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

On Sun, 3 Jul 2022 at 21:50, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/07/2022 23:37, Sam Protsenko wrote:
> > SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
> > mask to avoid falling back to SWTLBIO usage in dma_map_single() because
> > of failed dma_capable() check.
> >
> > The original code for this fix was suggested by Marek.
> >
> > Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> This is some tip specific tag, I don't think checkpatch allows it.
> Either use suggesgted-by or co-developed-by + SoB.
>

Yes, checkpatch is swearing at that line, though I encountered that
tag mentioning somewhere in Documentation. Will rework it in v2.

> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/iommu/exynos-iommu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> > index 71f2018e23fe..28f8c8d93aa3 100644
> > --- a/drivers/iommu/exynos-iommu.c
> > +++ b/drivers/iommu/exynos-iommu.c
> > @@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     if (MMU_MAJ_VER(data->version) >= 5) {
> > +             ret = dma_set_mask(dev, DMA_BIT_MASK(36));
> > +             if (ret) {
> > +                     dev_err(dev, "Unable to set DMA mask: %d\n", ret);
>
> Missing cleanup: iommu_device_unregister
> and probably also: iommu_device_sysfs_remove
>

Right. Also the correct cleanup should be added for failing
iommu_device_register() case, above of the quoted code. Will do that
in v2, thanks.

Another thing is that "remove" method is missing. But guess I'll get
to it later, when adding modularization support for this driver.

> > +                     return ret;
> > +             }
> > +     }
> > +
> >       /*
> >        * use the first registered sysmmu device for performing
> >        * dma mapping operations on iommu page tables (cpu cache flush)
>
>
> Best regards,
> Krzysztof
