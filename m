Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EB3518F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiECUpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiECUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:45:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105B615A08;
        Tue,  3 May 2022 13:41:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 321911F400A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651610490;
        bh=6LlYKh046C6Z3Am//641lVVpWpuYaRN/WaDnK7FKMPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jq2n3gj2aIDxNSouNUQgKaOCvhCEGcMWOhu/x9UZgaU5fCvDTXJL0gIzEF3qN1+J2
         xYBwnPi72TT4R0uA+xJf3yAdRRUbPtKmLa0Be20hULZr/eIqCEa9VELb3/u2ToKL3m
         zeI/AoF3KTOT+3FCOXl16JABfhpRZlBudzc4pr8H2jhK3bCfGfjH5V9OO6SGaStLtZ
         s+C+IchA4wSnLgCbsleanjZ34/go6DvEUruGtSw4DTTpJrCNyKH0jUe1++SCfmSp8J
         Rxp7qbjoG8IujYBSJxxS4kUjsajdyfD09QrFSETDeLN7+B4KCU72ZpvCxq6HOGVeEu
         6DuToMHDjadeA==
Date:   Tue, 3 May 2022 16:41:25 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Fix optional
 reg-names for mtk,scp
Message-ID: <20220503204125.a4xwd7a5e3fxf7et@notapiano>
References: <20220429211111.2214119-1-nfraprado@collabora.com>
 <20220429211111.2214119-2-nfraprado@collabora.com>
 <a95fc4a9-af6b-e2c2-ef41-df9742d393de@linaro.org>
 <4bf2343b-3760-6ebf-7463-0b25fe9d942e@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bf2343b-3760-6ebf-7463-0b25fe9d942e@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 02:26:15PM +0200, AngeloGioacchino Del Regno wrote:
> Il 03/05/22 14:19, Krzysztof Kozlowski ha scritto:
> > On 29/04/2022 23:11, Nícolas F. R. A. Prado wrote:
> > > The SCP has three memory regions: sram, l1tcm and cfg. Only sram is
> > > required, the other two are optional. Fix the dt-binding so that the
> > > optional regions can be omitted and passed in any order.
> > 
> > No, cannot be passed in any order.
> > 
> > > 
> > > Also add the missing minItems to the reg property and update the
> > > description.
> > > 
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > 
> > > ---
> > > 
> > >   .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > index 823a236242de..ec9ddeb6ca2c 100644
> > > --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > > @@ -24,14 +24,20 @@ properties:
> > >     reg:
> > >       description:
> > >         Should contain the address ranges for memory regions SRAM, CFG, and
> > > -      L1TCM.
> > > +      L1TCM. Only SRAM is required, while CFG and L1TCM are optional.
> > > +    minItems: 1
> > >       maxItems: 3
> > >     reg-names:
> > > +    minItems: 1
> > >       items:
> > >         - const: sram
> > > -      - const: cfg
> > > -      - const: l1tcm
> > > +      - enum:
> > > +          - l1tcm
> > > +          - cfg
> > > +      - enum:
> > > +          - l1tcm
> > > +          - cfg
> > 
> > This allows them in any combination which is not what we want. If both
> > are optional and both can appear, then last should be a const:l1tcm.
> > 
> > Best regards,
> > Krzysztof
> 
> Nicolas, I think that you weren't clear about what you're trying to solve with this
> commit in the description.
> 
> I remember you had this kind of instance, but I don't really remember if it was
> about mtk,scp or (and?) something else.... so.... are you trying to fix issues
> with devicetrees declaring
> 
> 	reg-names = "sram", "l1tcm"; ?
> 
> Was this giving dtbs_check errors?

Hi Angelo,

yes, some devicetrees (like mt8183) have

 	reg-names = "sram", "cfg";

I'll include mention of this in the commit description for v3.

This was also supposed to fix the warning for mt8192, where the order is
different: "sram", "l1tcm", "cfg". But since Krzysztof said that we want a fixed
order, then the mt8192 DT will need to be updated. (I also just noticed that
it's just l1tcm that is optional, I was just being blind, so I'll also fix that
in v3)

Thanks,
Nícolas

> 
> Cheers,
> Angelo
