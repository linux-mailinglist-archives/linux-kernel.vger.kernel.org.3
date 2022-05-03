Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D06518BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiECSCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiECSC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:02:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55883E0C1;
        Tue,  3 May 2022 10:58:53 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 21D721F444FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651600732;
        bh=7qeurYzZslyi92N7K5GArfwgsQTF+nE6W05wCQTva6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KE3YCHnds6v61AHs797rcMxewdX/sIbzN30yeH2p3JVFqHeQHknJxi9OKbV6GF2VQ
         rv1NRCEazWRyygqG8BFNQz7eko9yQwa3q4nJCkg63kpOq4MrPu/4h4H71V4eDGLypB
         VSTqFlZE0yhMWQmsq3ZU8HaFB3Mw3SNZ1kLJpYiOl6i1OctOClXfpdyCfQmFvN/pcJ
         /+2v6IA2oOeJ1mXX8CrVN+ok0AIR1YYuOSeFtO5WIXDukZlo8fSvq99hKp/6YzNkXe
         UG1bklTUiYvZLcIvF+6ZX7DDRyts0Q0Frto1rgPA84ma0eSLFdp0uKVCRV6exJxQc5
         ZpaF5oqb4rusA==
Date:   Tue, 3 May 2022 13:58:46 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
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
Message-ID: <20220503175846.pth5px74fzirizep@notapiano>
References: <20220429211111.2214119-1-nfraprado@collabora.com>
 <20220429211111.2214119-2-nfraprado@collabora.com>
 <a95fc4a9-af6b-e2c2-ef41-df9742d393de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a95fc4a9-af6b-e2c2-ef41-df9742d393de@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 02:19:39PM +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 23:11, Nícolas F. R. A. Prado wrote:
> > The SCP has three memory regions: sram, l1tcm and cfg. Only sram is
> > required, the other two are optional. Fix the dt-binding so that the
> > optional regions can be omitted and passed in any order.
> 
> No, cannot be passed in any order.
> 
> > 
> > Also add the missing minItems to the reg property and update the
> > description.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  .../devicetree/bindings/remoteproc/mtk,scp.yaml      | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > index 823a236242de..ec9ddeb6ca2c 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml
> > @@ -24,14 +24,20 @@ properties:
> >    reg:
> >      description:
> >        Should contain the address ranges for memory regions SRAM, CFG, and
> > -      L1TCM.
> > +      L1TCM. Only SRAM is required, while CFG and L1TCM are optional.
> > +    minItems: 1
> >      maxItems: 3
> >  
> >    reg-names:
> > +    minItems: 1
> >      items:
> >        - const: sram
> > -      - const: cfg
> > -      - const: l1tcm
> > +      - enum:
> > +          - l1tcm
> > +          - cfg
> > +      - enum:
> > +          - l1tcm
> > +          - cfg
> 
> This allows them in any combination which is not what we want. If both
> are optional and both can appear, then last should be a const:l1tcm.

Hi Krzysztof,

yes, that's the case. I'll update it in v3 then.

Thanks,
Nícolas

> 
> Best regards,
> Krzysztof
