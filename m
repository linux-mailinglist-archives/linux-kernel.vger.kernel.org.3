Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3A5A25F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343809AbiHZKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiHZKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:39:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1731D5E9B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:39:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sd33so2355892ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=bzJZ63DpRxp0H4giW5TfdcdKUfSm90fGiWgc0lZMYZU=;
        b=eWsFPZmGtzjOonK/Zvvk9/JtjnSgTsa1/L3FcArdLXsnsluFQ8TqeOWn785+Nfssvu
         XCDU56DALaxwiRhw7vCLmeNANaSEujTGJfZeiAtb1bv06rLXlxPEY/Ebkeg6cMcSIfNs
         TXpylCg18CJKUMAsCyHD7vV5OfW4FKHuybxJ/HL/a1q0A4SWYA4zglVk3n0K2Rpb9pIw
         yo+n4taQCZcWu3XTRupNEI34hulbYOffayydjLg9YnjvDm5uc5HRh7Kes3GI/BtmT2Ez
         qPP/rMB5dY8RgCK9Hu47N5OPSaKKQ9VHcO2DYxHaJ/ep4jOlGWEdUzOeLum18DV8O9vP
         cZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=bzJZ63DpRxp0H4giW5TfdcdKUfSm90fGiWgc0lZMYZU=;
        b=crg3TZuHSOZULhYbCU998vsOiMBwyO8FUIynPCMYBNn62DCPeHJ7Qz27447vCNZg5n
         DufKrQO2QfA70nhtvFEz8l2GzODZOI0SmLrpF+6cWAgpc5ZOVvBNXqCYsIrQKA/f0LfC
         BaSFN2xphT8hoAn6PLEvQC5f9x7Bv6Ry7eaXnPcjta2dbgNEgyACjp9oXy5CMrwZNg5t
         D/BqZRafqkKVC2sf88VzUF/obmR36mRGLdGty3Rx5+oPvbAOeLWWw2PTw9RcIq9dWoa8
         +vDMvKD3zJCMF7zfE0uc/vXnq8MnaSfb3mKHrybXv7Es23K4lmOJUjaD/ALeYQfS2tLK
         PuJA==
X-Gm-Message-State: ACgBeo1D9yRkEd+sDaO3hLZaRfrlI3CM0/hQQnMftv3mm+7WGtIs23F4
        MJBRaCHQ0iFiIYpWnGDs2IQRM8tE8PterdTY8V2hfY5sGDI=
X-Google-Smtp-Source: AA6agR4NLRVkBHuAxUYqoCkCg3RwFFGuzq/n3YoZioE9ml+5F+osjJQNCBSLi72Hg11NKJq4Juab+cL+8/Hy4zI621w=
X-Received: by 2002:a17:907:6890:b0:73d:a567:568c with SMTP id
 qy16-20020a170907689000b0073da567568cmr5093542ejc.521.1661510375544; Fri, 26
 Aug 2022 03:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220826101523.79502-1-jinpu.wang@ionos.com> <50bfdb3f-f6fe-b0ef-4214-5d533d45e89c@wanadoo.fr>
In-Reply-To: <50bfdb3f-f6fe-b0ef-4214-5d533d45e89c@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 26 Aug 2022 12:39:24 +0200
Message-ID: <CAMGffE=Gg=h5mSAQojhtmp64aT0XZzCJskfR+AbYGh9D4Ob-XA@mail.gmail.com>
Subject: Re: [PATCH] intel_th: Fix dma_map_sg error check
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 12:31 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 26/08/2022 =C3=A0 12:15, Jack Wang a =C3=A9crit :
> > dma_map_sg return 0 on error.
> >
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: linux-kernel@vger.kernel.org
> > Fixes: 4e0eaf239fb3 ("intel_th: msu: Fix single mode with IOMMU")
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > ---
> >   drivers/hwtracing/intel_th/msu.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel=
_th/msu.c
> > index 6c8215a47a60..b49237d56a60 100644
> > --- a/drivers/hwtracing/intel_th/msu.c
> > +++ b/drivers/hwtracing/intel_th/msu.c
> > @@ -931,7 +931,7 @@ static int msc_buffer_contig_alloc(struct msc *msc,=
 unsigned long size)
> >
> >       ret =3D dma_map_sg(msc_dev(msc)->parent->parent, msc->single_sgt.=
sgl, 1,
> >                        DMA_FROM_DEVICE);
> > -     if (ret < 0)
> > +     if (!ret)
>
> Missing ret =3D -EIO?
> like in other patches?
oh, right, thx for catching it.
sent v2 patch.
>
> CJ
>
> >               goto err_free_pages;
> >
> >       msc->nr_pages =3D nr_pages;
>
