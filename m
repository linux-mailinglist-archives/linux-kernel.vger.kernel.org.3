Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038852C2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiERSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiERSqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:46:08 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44164248CF;
        Wed, 18 May 2022 11:46:07 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-f189b07f57so3917271fac.1;
        Wed, 18 May 2022 11:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pKIi5KmcpwiUvvttWh4e21qCKlHTXQLcc0WGZMCMfyo=;
        b=lMpy8WOaer/+IC0gTQTUz+pndHdr7nl3nN8K7If4VmXJuG8J+LfohhW+MIO2MlF9TO
         +eEnjmFpOkfzgk9MkfiDCNqqhANJlUpa8nP0l+NtXoFSKJvlPh6ar3IK+j/wWdXLc9Nx
         NoA1aAyKQ4s7OEHGKPSgjybhtv0SEZraWv0bOoU0f1ocqOl1GW0V6Wa9dSlwRwW5mh+2
         0LdzMghRsJ2CSbLj2kFfDKJv8RR+UBtGxAkGYv+u4uWYL7r1u/3ms/6qyWG5P2d6CINM
         j3sgF4DsNP0eYdPS6m6hvyeQ3wbeEP/elXJbXfotVt+g7FqY8NEbmOitlPdf71Ne+nyG
         XCGQ==
X-Gm-Message-State: AOAM531IQ1zPENyzCyNUun4fYYclcCb8hhThQPewgp5XTPHh+ZjZVnfa
        nxeR+Ynn5F+0Cp8Q9yFl9g==
X-Google-Smtp-Source: ABdhPJzCbZpysYPkJ/ZU+Q27by+oDlv1fIMc02MZVxt6o5neKQP74ZuGayT1T/hdza+xq9Rr6yMpGw==
X-Received: by 2002:a05:6871:69e:b0:f1:cbce:6ac4 with SMTP id l30-20020a056871069e00b000f1cbce6ac4mr889356oao.286.1652899566551;
        Wed, 18 May 2022 11:46:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e21-20020a9d63d5000000b00605da994088sm1030657otl.2.2022.05.18.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 11:46:05 -0700 (PDT)
Received: (nullmailer pid 3673824 invoked by uid 1000);
        Wed, 18 May 2022 18:46:04 -0000
Date:   Wed, 18 May 2022 13:46:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com,
        joro@8bytes.org, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/8] iommu: mtk_iommu: Lookup phandle to retrieve syscon
 to infracfg
Message-ID: <20220518184604.GK3302100-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-3-angelogioacchino.delregno@collabora.com>
 <16fb07d9-28d8-5c73-1eb5-ec13544d22e5@arm.com>
 <b003c37c-0f2d-31f6-6a74-4e1f0f4a1ccb@collabora.com>
 <a063199a-72dd-d2ab-10bb-7130697c5611@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a063199a-72dd-d2ab-10bb-7130697c5611@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:07:58PM +0100, Robin Murphy wrote:
> On 2022-05-18 09:29, AngeloGioacchino Del Regno wrote:
> > Il 17/05/22 16:12, Robin Murphy ha scritto:
> > > On 2022-05-17 14:21, AngeloGioacchino Del Regno wrote:
> > > > This driver will get support for more SoCs and the list of infracfg
> > > > compatibles is expected to grow: in order to prevent getting this
> > > > situation out of control and see a long list of compatible strings,
> > > > add support to retrieve a handle to infracfg's regmap through a
> > > > new "mediatek,infracfg" phandle.
> > > > 
> > > > In order to keep retrocompatibility with older devicetrees, the old
> > > > way is kept in place, but also a dev_warn() was added to advertise
> > > > this change in hope that the user will see it and eventually update
> > > > the devicetree if this is possible.
> > > > 
> > > > Signed-off-by: AngeloGioacchino Del Regno
> > > > <angelogioacchino.delregno@collabora.com>
> > > > ---
> > > >   drivers/iommu/mtk_iommu.c | 40 +++++++++++++++++++++++++--------------
> > > >   1 file changed, 26 insertions(+), 14 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > > index 71b2ace74cd6..cfaaa98d2b50 100644
> > > > --- a/drivers/iommu/mtk_iommu.c
> > > > +++ b/drivers/iommu/mtk_iommu.c
> > > > @@ -1134,22 +1134,34 @@ static int mtk_iommu_probe(struct
> > > > platform_device *pdev)
> > > >       data->protect_base = ALIGN(virt_to_phys(protect),
> > > > MTK_PROTECT_PA_ALIGN);
> > > >       if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
> > > > -        switch (data->plat_data->m4u_plat) {
> > > > -        case M4U_MT2712:
> > > > -            p = "mediatek,mt2712-infracfg";
> > > > -            break;
> > > > -        case M4U_MT8173:
> > > > -            p = "mediatek,mt8173-infracfg";
> > > > -            break;
> > > > -        default:
> > > > -            p = NULL;
> > > > +        infracfg =
> > > > syscon_regmap_lookup_by_phandle(dev->of_node,
> > > > "mediatek,infracfg");
> > > > +        if (IS_ERR(infracfg)) {
> > > > +            dev_warn(dev, "Cannot find phandle to mediatek,infracfg:"
> > > > +                      " Please update your devicetree.\n");
> > > 
> > > Is this really a dev_warn-level problem? There's no functional
> > > impact, given that we can't stop supporting the original binding any
> > > time soon, if ever, so I suspect this is more likely to just annoy
> > > users and CI systems than effect any significant change.
> > > 
> > 
> > The upstream devicetrees were updated to use the new handle and this is
> > a way to
> > warn about having outdated DTs... besides, I believe that CIs will
> > always get the
> > devicetree from the same tree that the kernel was compiled from (hence
> > no message
> > will be thrown).
> > 
> > In any case, if you think that a dev_info would be more appropriate, I
> > can change
> > that no problem.
> 
> If there's some functional impact from using the old binding vs. the new one
> then it's reasonable to inform the user of that (as we do in arm-smmu, for
> example).
> 
> However if you change an established binding for non-functional reasons,
> then you get to support both bindings, and it's not the end user's problem
> at all. There seems to be zero reason to update an existing DTB for this
> difference alone, so TBH I don't think it deserves a message at all.

It's also not the kernel's job to validate the DT. It's horrible at it 
and we have something else now.

Rob
