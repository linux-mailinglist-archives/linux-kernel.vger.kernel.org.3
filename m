Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453D5568B26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiGFOZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiGFOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:24:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE191AF00
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:24:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y16so26173514lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0+hemKCm9KoLcdJVlDwowemoYH5rpN+Hagnel9ijRQ=;
        b=omXZrna0gxIYOazn7dGSQ7WvQGEYaiftOCQUxfDqPa5w+1/OLqJq8uvIyGgBHkh8zG
         9StaSLqmtiC++EBHnpfHQg4he4T37Hj1jxHflwWnMXc3gqIUe9gPq3WCAcdsp+s+2A3k
         VrH2kCLpJsCMT7K6KTLi//AB2RG+tSx0/Kt51DWW1YXgTGeB+LdeM7Yubl1VaevlPI6W
         wF7AKTUrmEaEU8dwOESUd3SQGKWBP/ipS3jCHfC0y8aIWEEQuBS4EgPw9kiZxRFXCwcS
         YtyGi6h+7/VfY39HZmzZ6fMF3Mf3AV3oUgt4z9v5BCBRR3hYosw9wyz7yWCEfjyAfLEG
         JuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0+hemKCm9KoLcdJVlDwowemoYH5rpN+Hagnel9ijRQ=;
        b=7ayKGw+rlB2LPPrFI6CvaRdtYdME6fqHPNeO/bXzlt3XXgkyzN60Mm0n9mvGUPJRQ9
         OQPQgN7Zqss6AI4dhm6rRvG8y4evH1Lw92jJo7Dn3oz0LqWHZ9sGVSYQUCMSwlOexXOd
         0KjRaii1hkJQdGnzg4I+9ekp+al3vgQ9Vk9bUV/a+OAecBEtn/IVm/4xAfg2PTSk3qY4
         wCIKc1+1+WeJpHUphhUMFI6OPO4AhH/51jh1Ork/84fiTD6GXKy2Tz/hR5nOLe5GbJIx
         yjbkmJYMdvCd048SWE+kYBYZRJMiTIVoEaoMzprp9H62eFOWmew6bDPIyn37MGOd26vK
         Xogw==
X-Gm-Message-State: AJIora+ekiiUtK+WaoNibfDiJFrrw52KTAPGFtXDClSUrmqvSCZNN5/8
        zhHC6UXO7louCNANCFBOyZfT3/MLiueSAC7p+YQOgA==
X-Google-Smtp-Source: AGRyM1uDeNrP78kQbE4GCyT6VGpyQpPl0h+HaGsEaZJSOZN/gnHdPOD4IO3m6JYnJJttm/k1+C81vMOjQAuEaHVjx1g=
X-Received: by 2002:a05:6512:2205:b0:484:e296:62fa with SMTP id
 h5-20020a056512220500b00484e29662famr4062867lfu.142.1657117494567; Wed, 06
 Jul 2022 07:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <CAPLW+4kYbG7PRYo_L6N5xMa+F9DFBpyph4B+zb2R4kBbE3EKHg@mail.gmail.com> <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
In-Reply-To: <67943ec4dcfe85d6d616a5507437d99f6c5638a2.camel@gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 6 Jul 2022 17:24:43 +0300
Message-ID: <CAPLW+4k9DBbX6PupEk-J_KFbLmwgbfuDrfuVgyapT=d4WMG7yQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] iommu/exynos: Add basic support for SysMMU v7
To:     Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Virag <virag.david003@gmail.com>,
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

On Sun, 3 Jul 2022 at 13:47, David Virag <virag.david003@gmail.com> wrote:
>
> On Sun, 2022-07-03 at 00:48 +0300, Sam Protsenko wrote:
> [...]
> > Hi Marek,
> >
> > As I understand, you have some board with SysMMU v7, which is not VM
> > capable (judging from the patches you shared earlier). Could you
> > please somehow verify if this series works fine for you? For example,
> > this testing driver [1] can be helpful.
> >
> > Thanks!
> >
> > [1]
> > https://github.com/joe-skb7/linux/commit/bbadd46fa525fe1fef2ccbdfff81f7d29caf0506
>
> Hi Sam,
>
> Not Marek here, but I wanted to try this on my jackpotlte (Exynos
> 7885). The driver reports it's DPU sysmmu as version 7.2, and manually
> reading the capabilities registers it looks like it has the 2nd
> capability register but not the VM capability.
>
> After applying your patches, adding your test driver (with SYSMMU_BASE
> corrected to 7885 value), and adding the sysmmu to dt, I tried to cat
> the test file that it creates in debugfs and I got an SError kernel
> panic.
>
> I tried tracing where the SError happens and it looks like it's this
> line:
>         /* Preload for emulation */
>         iowrite32(rw | vpn, obj->reg_base + MMU_EMU_PRELOAD);
>
> Trying to read the EMU registers using devmem results in a "Bus error".
>
> Could these emulation registers be missing from my SysMMU? Do you have
> any info on what version should have it? Or maybe some capability bit?
> I'll try testing it with DECON/DPP later and see if it works that way.
>

Hi Janghyuck,

Do you have by chance any info on SysMMU v7.2, which is present e.g.
on Exynos7885? David is trying to use emulation registers there with
no luck, so it would be nice if you can provide some details on
questions above.

Thanks!

> Best regards,
> David
