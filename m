Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923D050F267
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiDZHbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbiDZHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:31:37 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD8C9B72;
        Tue, 26 Apr 2022 00:28:30 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B6E0A2223A;
        Tue, 26 Apr 2022 09:28:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650958108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mzzsrtLgDhH/mUpZ95LPe7yFWgFVICtJRss1dScu0l4=;
        b=WLsMfwV0KL/FIMULQI396eMh2JgmUNPuLtROTi2Uf6+MI9kKJWGfdOy3upRieZ36tH/mnF
        UaB7LffD+miuwmjsCrhJXFO1MhRqJ9Gm1Uq82AvQIUUNm09Avl31g13lar3POnut6X7d8L
        yJx48P/MaJpQ/trOFQcS6gGsy9TIAJo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Apr 2022 09:28:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: fsl,ls-extirq:
 convert to YAML
In-Reply-To: <c324eec7-79b1-33da-c38e-4a480fe23126@linaro.org>
References: <20220425140214.32448-1-michael@walle.cc>
 <658851ed-33fd-8e2b-7db7-ef1ca9e31c33@linaro.org>
 <83b596d0570c779c61c3c37c6f512679@walle.cc>
 <c324eec7-79b1-33da-c38e-4a480fe23126@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6fec63c911c88a375fc024f6ca0e946d@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-26 08:53, schrieb Krzysztof Kozlowski:
> On 25/04/2022 23:58, Michael Walle wrote:
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      Specifies the Interrupt Polarity Control Register (INTPCR) in
>>>> the
>>>> +      SCFG or the External Interrupt Control Register (IRQCR) in 
>>>> the
>>>> ISC.
>>>> +
>>>> +  interrupt-map:
>> 
>> btw.
>> 
>> minItems: 12
>> maxItems: 12
>> 
>> Isn't working here, is that expected? The validator seem to get the
>> count
>> of the elements of one tuple wrong.
>> 
>> I.e.
>> arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dtb:
>> interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1,
>> 0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5,
>> 0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 
>> 8,
>> 4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is 
>> too
>> short
> 
> 
> Works for me (in different schema)... maybe update your dtschema?

Just updated to the latest one. But I'm still getting the same errors.

$ dt-validate -V
2022.4

/home/mwalle/repos/b-linux-arm64/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: 
interrupt-controller@14: interrupt-map: [[0, 0, 1, 0, 0, 4, 1, 0], [1, 
0, 1, 4, 2, 0, 1, 0], [2, 4, 3, 0, 1, 0, 3, 4], [4, 0, 1, 0, 4, 4, 5, 
0], [1, 0, 5, 4, 6, 0, 1, 0], [6, 4, 7, 0, 1, 0, 7, 4], [8, 0, 1, 0, 8, 
4, 9, 0], [1, 0, 9, 4, 10, 0, 1, 0], [10, 4, 11, 0, 1, 0, 11, 4]] is too 
short
	From schema: 
/home/mwalle/repos/linux-mw/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.yaml

How is the length of one entry calculated?

-michael
