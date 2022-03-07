Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674B74CFF17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiCGMsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbiCGMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:48:33 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984CB6246
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:47:35 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id h126so30700968ybc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eFuv1CZ1FCJvRh23WLfkSzv/heaOZIC7c/13FaNc3Wo=;
        b=2TAsd6PKCXUlgIYEC6sOsRFGGOkyw4qtPi3sHqqzwqVeNt8xoIqr4ya+hu98UH+oZp
         9nStNtbMrEplhF7ylmE7V8+iGZ0D/g8UktjAXaXEK5Ef7u7l0BW6wUluEX6bcH44IB5a
         QSA8dd5KHnfphZ2xnrUU3qmNHWJDYfdUagRgyUc7WT+Y9+Dl7r6hG+jh5cWBlKcg6VOi
         3zv9gy5eEFkjVnHXKBudMe8eA6JKj7hcc86GrBfVsOIT3NBM94YOoYPRTeLflTLhOIA/
         XAerpQxZdma6VuD/ALzQzgvqOzgEDApXsGzBsxOOXG345TY7QqTC4kNJMdYK69quy70W
         kYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eFuv1CZ1FCJvRh23WLfkSzv/heaOZIC7c/13FaNc3Wo=;
        b=18+R6uT/9nNUHgtj5cNVPGMK9pGQ65rOWTG/J4ar8ybTG2Dees508tCuaCd3mZVPA4
         zrJuy4zp/IgJnZxFoHWOT2FrGuaf2nsv8jNC0O6GwiotLkkDBazVHqz/KMwuvqx/egvD
         IjjYXGdqLMQjCpNpM2EW7IVYgB9JjxZw5pqw/XlIHl+89Ss7QNlByRyrspmP/WSn2vFn
         cXUUa6lLg2bUbpRVHuAvDmglR7lZu/ZAEcElnTfaM/j2IR0jey7nKTYcwEXfKH+mSmll
         0a1npdhPd83+PZDQpto3QW8qjZygOt+j18ApBnnQh93pSv5a6yKYolRG698ER68xN8Ao
         FEwA==
X-Gm-Message-State: AOAM5303fjaAZVvW27bWvI2lgFe5zz6FyEnCTK9iXBut/3qMheBLMDfT
        zMUW+Nkb9BrUVXkYQCQkv0LAtT2N5RqWvR2xIfTo2Q==
X-Google-Smtp-Source: ABdhPJy7A9l6pgeT9iD8kwzothv8rOOmhOR5TCpERcX/K56cv0Decwr3OQIeVGeijmRGnFQO/VzxBFXZqGXRiun68q0=
X-Received: by 2002:a25:5509:0:b0:622:1c12:4230 with SMTP id
 j9-20020a255509000000b006221c124230mr7750645ybb.416.1646657253810; Mon, 07
 Mar 2022 04:47:33 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com> <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
In-Reply-To: <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 7 Mar 2022 14:47:23 +0200
Message-ID: <CAOtvUMedqSNKx9Aah0R_aAyjKO0pn4K75MrCnbh_zX+Zw9vRQA@mail.gmail.com>
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

On Mon, Mar 7, 2022 at 2:36 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-07 12:17, Gilad Ben-Yossef wrote:
> > On Mon, Mar 7, 2022 at 1:14 PM Robin Murphy <robin.murphy@arm.com> wrot=
e:
> >
> >> The "overlap" is in the sense of having more than one mapping within t=
he
> >> same cacheline:
> >>
> >> [  142.458120] DMA-API: add_dma_entry start P=3Dba79f200 N=3Dba79f
> >> D=3Dba79f200 L=3D10 DMA_FROM_DEVICE attrs=3D0
> >> [  142.458156] DMA-API: add_dma_entry start P=3D445dc010 N=3D445dc
> >> D=3D445dc010 L=3D10 DMA_TO_DEVICE attrs=3D0
> >> [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=3D16 bi=
=3D0
> >> [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=3D16 bi=
=3D0
> >> [  142.458234] DMA-API: add_dma_entry start P=3Dba79f210 N=3Dba79f
> >> D=3Dba79f210 L=3D10 DMA_FROM_DEVICE attrs=3D0
> >>
> >> This actually illustrates exactly the reason why this is unsupportable=
.
> >> ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping
> >> ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range
> >> ba79f200-ba79f23f to be written back over the top of data that the
> >> device has already started to write to memory. Hello data corruption.
> >>
> >> Separate DMA mappings should be from separate memory allocations,
> >> respecting ARCH_DMA_MINALIGN.
> >
> > hmm... I know I'm missing something here, but how does this align with
> > the following from active_cacheline_insert() in kernel/dma/debug.c ?
> >
> >          /* If the device is not writing memory then we don't have any
> >           * concerns about the cpu consuming stale data.  This mitigate=
s
> >           * legitimate usages of overlapping mappings.
> >           */
> >          if (entry->direction =3D=3D DMA_TO_DEVICE)
> >                  return 0;
>
> It's OK to have multiple mappings that are *all* DMA_TO_DEVICE, which
> looks to be the case that this check was intended to allow. However I
> think you're right that it should still actually check for conflicting
> directions between the new entry and any existing ones, otherwise it
> ends up a bit too lenient.
>
> Cheers,
> Robin.

I understand what you are saying about why checking for conflicting
directions may be a good thing, but given that the code is as it is
right now, how are we seeing the warning for two mapping that one of
them is DMA_TO_DEVICE?

Gilad


--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
