Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00896523E26
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347445AbiEKT61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347401AbiEKT6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:58:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D71FE3CC;
        Wed, 11 May 2022 12:58:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 704CE1F42CF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652299095;
        bh=VybsRpIInZnb23XCmY8eSSZVRgUv+vJS2d+gxTZzyMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8wMtlkCxSaNmzjizBSjnADY75+vjTGMWLc+zi5Fxx6sc4wJjtayy58JkRAs8fT7e
         4Rt8A5tKkEgNPnXQ9Ksr8bCdqHvHp+bRpyIguyfczgcj676e5hA9c6/P//4l69cE7c
         dMAfscqTl5kKnZmPY8QPlGwqtX9jAcLEE/jwH4L3sJQu+SqNpSHccUgNdZa3BDH8E2
         Ui7yrvHs1AaYfAYCQLZF8NObtMGIYZMpqWw0wIb5wiu69upT5wFBK+OZ8zkr2JqmMh
         GoNP6eOXuzOblu7tVaHwB5ztD399ZdVK7hFxI8Uhd6KQ3/4S+I5a4HCChbQJUCVmot
         SZEL6KntEyazg==
Date:   Wed, 11 May 2022 15:58:10 -0400
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
Message-ID: <20220511195810.jgeoukpj7bz3ng2h@notapiano>
References: <20220506213226.257859-1-nfraprado@collabora.com>
 <20220506213226.257859-2-nfraprado@collabora.com>
 <d3e027ca-9ccf-cf91-2414-85d2b9b680f0@linaro.org>
 <20220510165016.r7nyck2abt5m4djp@notapiano>
 <66796853-efe7-f661-9637-ac6cfefc68e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66796853-efe7-f661-9637-ac6cfefc68e5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:12:45AM +0200, Krzysztof Kozlowski wrote:
> On 10/05/2022 18:50, Nícolas F. R. A. Prado wrote:
> >>> Also I had to add a description to the global reg-names, since it
> >>> couldn't be neither missing nor empty.
> >>
> >> It is possible:
> >> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91
> >>
> >> Keep constraints and list of names in properties. Then in allOf:if:then
> >> raise minItems or lower maxItems, depending on the variant.
> > 
> > Hi Krzysztof,
> > 
> > that example only shows setting minItems to override the default value, but the
> > issue here is that it's not possible to override minItems/maxItems (after
> > they're already set, even if implicitly) with a different value in the if.
> 
> No, this example shows exactly what you need in first step - make one
> item on the list optional.
> 
> There are several other examples for the entire picture or different
> aproach:
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/example-schema.yaml#L91
> 
> https://elixir.bootlin.com/linux/v5.18-rc2/source/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml#L53
> 
> > 
> > That is:
> > 
> > 	properties:
> > 	  reg-names:
> > 	    items:
> > 	      - const: sram
> > 	      - const: cfg
> > 	      - const: l1tcm
> 
> You did not use the example I gave you. Where is the minItems?
> 
> > 
> > 	if:
> > 	  properties:
> > 	    compatible:
> > 	      enum:
> > 		- mediatek,mt8183-scp
> > 		- mediatek,mt8186-scp
> > 	then:
> > 	  properties:
> > 	    reg-names:
> > 	      minItems: 2
> > 	      maxItems: 2
> > 
> > Generates the error on dtbs_check:
> > 
> > /home/nfraprado/ext/git/linux/arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtb: scp@10500000: reg-names: ['sram', 'cfg'] is too short
> 
> Missing minItems in first properties.
> 
> > 
> > I believe the tooling is implicitly adding
> > 
> > 	      minItems: 3
> > 	      maxItems: 3
> > 
> > to the common reg-names, and since it's not possible to override them, the
> > override to 2 doesn't work so they are kept at 3, causing the error.
> > 
> > Moving the minItems/maxItems to the common reg-names as a test gives:
> 
> You cannot just. You need it in both places.

OK, now I get it. I sent v5 addressing this.

Thanks,
Nícolas

> 
> > 
> > /home/nfraprado/ext/git/linux/Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml: properties:reg-names: {'minItems': 2, 'maxItems': 2, 'items': [{'const': 'sram'}, {'const': 'cfg'}, {'const': 'l1tcm'}]} should not be valid under {'required': ['maxItems']}
> > 	hint: "maxItems" is not needed with an "items" list
> > 
> > That error, plus looking in the items meta-schema, suggests me that maxItems
> > isn't supposed to be set lower then the length of items. So even if the
> > minItems/maxItems override is fixed, there's still this issue. It seems like
> > defining the reg-names list separetely in each if branch is indeed the right way
> > to go.
> 
> 
> 
> Best regards,
> Krzysztof
