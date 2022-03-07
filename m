Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C74CFE06
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiCGMTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiCGMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:19:07 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04073BA7E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:18:10 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2dbfe58670cso161528877b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kNo3uSHysShLR0FJhmk5oSOi1tMyXHYvJloBJLNHZCg=;
        b=F9pKvRvYdMxTrF6jqw8vUsqcHxvyFAKgh5ws7S3CM2QebpqvTAkwKJO4XRUJMn1a4m
         S02+miqQ7jyunEQuEeulaQyWcId+gR5KG7TutDPcjKuCtEcHBjTG1i4YT/gVLEsoxOOc
         RgbbrBzgB1K4PTYrzpLz6nzuHzEVTWkriR3PiQVn2MAuG3toHMwVrmUOxFC/kojcgKDu
         bgBoWYtsX6xfM/Zfv24MczYLcwpIalwMwZLiNQHIRJuqvHEcmqx9VAtux5Np3YLZEgUW
         WJVbRfRg/Xqrbi0JQoGI8D+wNbjL4FMS/5OVwpAYRkwscIEOmnIwQLw+TVsqay1b09Op
         iaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kNo3uSHysShLR0FJhmk5oSOi1tMyXHYvJloBJLNHZCg=;
        b=Nty4kWVOXQ9URtd/AtXJL6i5U8UdD44eLf71f2kvbpqCMLy/lTKnWEbdDCCwYaZXaQ
         fLGIxxOWPZIAYkGYBXoFJdcD6aR+j5clzEICy0KlAkhWy0LOnEr2WhtZNct1PVpVDXV2
         KRUphw/yYfme3voRqXmO0m7gc4c5zi5FWPpETANabYTRPtL7qZgkMMKgRWerWJOc8i94
         2OHgHlb5roPn82u5FOaQ594h4nN1dH2b22TFaK8GF8JdoodNJRlovNcreKByUcxwYjIX
         g6s5l2y6jYVSz1KbRsBcAuKiDc98BLh5dFU+G6r0CuPAEjMit4pC7hV/PUBRPr4ZFWm7
         g2XA==
X-Gm-Message-State: AOAM532wBiVJmKz3ZdwS48vquOrowgj/Hr6Eza2L4mlao3633IcyUiqS
        6nUp9gJo0WHiB7bLj+76GKHPzOAYbQN6lmAHU6NgMw==
X-Google-Smtp-Source: ABdhPJxAwnlLxiebvOvVJXEOc3iSvoRJ/FztSSfnXBmJMWTvypvCDGrt5qtTbdf4SAXSCTruNN8YCoUGrS6E6lw0PWg=
X-Received: by 2002:a81:6c6:0:b0:2dc:616b:468b with SMTP id
 189-20020a8106c6000000b002dc616b468bmr7855366ywg.472.1646655489767; Mon, 07
 Mar 2022 04:18:09 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
In-Reply-To: <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 7 Mar 2022 14:17:59 +0200
Message-ID: <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 1:14 PM Robin Murphy <robin.murphy@arm.com> wrote:

> The "overlap" is in the sense of having more than one mapping within the
> same cacheline:
>
> [  142.458120] DMA-API: add_dma_entry start P=3Dba79f200 N=3Dba79f
> D=3Dba79f200 L=3D10 DMA_FROM_DEVICE attrs=3D0
> [  142.458156] DMA-API: add_dma_entry start P=3D445dc010 N=3D445dc
> D=3D445dc010 L=3D10 DMA_TO_DEVICE attrs=3D0
> [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=3D16 bi=3D=
0
> [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=3D16 bi=3D=
0
> [  142.458234] DMA-API: add_dma_entry start P=3Dba79f210 N=3Dba79f
> D=3Dba79f210 L=3D10 DMA_FROM_DEVICE attrs=3D0
>
> This actually illustrates exactly the reason why this is unsupportable.
> ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping
> ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range
> ba79f200-ba79f23f to be written back over the top of data that the
> device has already started to write to memory. Hello data corruption.
>
> Separate DMA mappings should be from separate memory allocations,
> respecting ARCH_DMA_MINALIGN.

hmm... I know I'm missing something here, but how does this align with
the following from active_cacheline_insert() in kernel/dma/debug.c ?

        /* If the device is not writing memory then we don't have any
         * concerns about the cpu consuming stale data.  This mitigates
         * legitimate usages of overlapping mappings.
         */
        if (entry->direction =3D=3D DMA_TO_DEVICE)
                return 0;

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
