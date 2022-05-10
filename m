Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77115221B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347672AbiEJQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347670AbiEJQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:54:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE952A4717;
        Tue, 10 May 2022 09:50:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 5AB901F43174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652201421;
        bh=ZLNmt5sdQew7yKceknoOpRxb0cIfVFzschzGJ6r+zG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nhtj6M/AUwaJD8Ja7FlZFjsiFaIu+2p9Y8N17iQhM04EmemSlHuQtSp8lR+/4GUC0
         CWJEYllptB8/qbDjjto0Pgc1nwfyhkmVcDGy1mhD5zMSnBNb0EYejN7YBX23Jn77Wn
         TnbYfjal0cvdRR1du/7jQqsr/jA2bbPJWEYSmJIOuxHAj7NNpVnrffixXnYSMasmmz
         gGsC0WhZbmPh7RsyqSedZNvXaPp4v3hcNKNPdnUmG+SVhSV5am9JLmtEmD/sWfg/G6
         ob+7yyeog/yNcM2NbUOKZMXvFJW7+gLulAG5RJc6cZNbFNYureITmBWy1qtZxyl6Cq
         MRyAvkHgirvqA==
Date:   Tue, 10 May 2022 12:50:16 -0400
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
        Tzung-Bi Shih <tzungbi@google.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: remoteproc: mediatek: Make l1tcm reg
 exclusive to mt819x
Message-ID: <20220510165016.r7nyck2abt5m4djp@notapiano>
References: <20220506213226.257859-1-nfraprado@collabora.com>
 <20220506213226.257859-2-nfraprado@collabora.com>
 <d3e027ca-9ccf-cf91-2414-85d2b9b680f0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3e027ca-9ccf-cf91-2414-85d2b9b680f0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 06:33:31PM +0200, Krzysztof Kozlowski wrote:
> On 06/05/2022 23:32, Nícolas F. R. A. Prado wrote:
> > Commit ca23ecfdbd44 ("remoteproc/mediatek: support L1TCM") added support
> > for the l1tcm memory region on the MT8192 SCP, adding a new da_to_va
> > callback that handles l1tcm while keeping the old one for
> > back-compatibility with MT8183. However, since the mt8192 compatible was
> > missing from the dt-binding, the accompanying dt-binding commit
> > 503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
> > mistakenly added this reg as if it were for mt8183. And later
> > it became common to all platforms as their compatibles were added.
> > 
> > Fix the dt-binding so that the l1tcm reg can, and must, be present only
> > on the supported platforms: mt8192 and mt8195.
> > 
> > Fixes: 503c64cc42f1 ("dt-bindings: remoteproc: mediatek: add L1TCM memory region")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > The if:then: branches became rather long since it seems that it's not
> > possible to override the properties in them, only add new ones. That is,
> > I couldn't leave the items definition for all three regs in the global
> > reg-names and just decrease minItems and maxItems to 2 for
> > mt8183/mt8186.
> > 
> > Also I had to add a description to the global reg-names, since it
> > couldn't be neither missing nor empty.
> 
> It is possible:
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91
> 
> Keep constraints and list of names in properties. Then in allOf:if:then
> raise minItems or lower maxItems, depending on the variant.

Hi Krzysztof,

that example only shows setting minItems to override the default value, but the
issue here is that it's not possible to override minItems/maxItems (after
they're already set, even if implicitly) with a different value in the if.

That is:

	properties:
	  reg-names:
	    items:
	      - const: sram
	      - const: cfg
	      - const: l1tcm

	if:
	  properties:
	    compatible:
	      enum:
		- mediatek,mt8183-scp
		- mediatek,mt8186-scp
	then:
	  properties:
	    reg-names:
	      minItems: 2
	      maxItems: 2

Generates the error on dtbs_check:

/home/nfraprado/ext/git/linux/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb: scp@10500000: reg-names: ['sram', 'cfg'] is too short

I believe the tooling is implicitly adding

	      minItems: 3
	      maxItems: 3

to the common reg-names, and since it's not possible to override them, the
override to 2 doesn't work so they are kept at 3, causing the error.

Moving the minItems/maxItems to the common reg-names as a test gives:

/home/nfraprado/ext/git/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml: properties:reg-names: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 'sram'}, {'const': 'cfg'}, {'const': 'l1tcm'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list

That error, plus looking in the items meta-schema, suggests me that maxItems
isn't supposed to be set lower then the length of items. So even if the
minItems/maxItems override is fixed, there's still this issue. It seems like
defining the reg-names list separetely in each if branch is indeed the right way
to go.

Thanks,
Nícolas
