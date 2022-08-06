Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABF458B60D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiHFOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHFOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:22:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BBF11A24;
        Sat,  6 Aug 2022 07:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6D0BB8069B;
        Sat,  6 Aug 2022 14:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF4BC433C1;
        Sat,  6 Aug 2022 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659795721;
        bh=HkNJnYcSEBuJ4YsCeTCaPqJ4cCK2gNOMXnFH8NjrmH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Qy1WpG6PIF54IANVnlB+23sKM3kIajnUro+RKcUEVUV1gEXILZDV31FoOoCDcXvTc
         tp/AOvvbzBjMt5Rl+WO3nmvS2QyQoEK11FjVAoU5u/LjB9hm1eB2SD/4FD9FFdu9A9
         SOw6I58b3/lSO6Qf9qmdgUI1Q+FCYiTxLtIz8gFc/mgTkoGUrBuZHLK3hGTK2EybY1
         TvU33TpKC105ejP1MXT5mRh/B6QTa3EmTtNdXZz5Ok1eErivLSQ0FaD5JMrrvrEwtM
         G65nAu0r2mPOJKsp89T5+aWtZ71njz/uuclqwTBOxB3w2rju9HFrJxWIASRInsMwzt
         FE6iY6YnZzcrw==
Date:   Sat, 6 Aug 2022 15:32:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: bosch,bmg160: correct
 number of pins
Message-ID: <20220806153221.1a90bd28@jic23-huawei>
In-Reply-To: <20220805075503.16983-1-krzysztof.kozlowski@linaro.org>
References: <20220805075503.16983-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Aug 2022 09:55:03 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> BMG160 has two interrupt pins to which interrupts can be freely mapped.
> Correct the schema to express such case and fix warnings like:
> 
>   qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long
> 
> However the basic issue still persists - the interrupts should come in a
> defined order.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Accept also INT2 as one interrupt (Jonathan).

This doesn't work. If we are going to support either interrupt, at the very least
we need to require interrupt-names if the first one isn't INT1.  So your fix
is right but not enough.

Driver may ignore interrupt-names for now (would be good to have a sanity check in driver
though so the driver explicitly checks for INT2 and doesn't use the interrupt if
it is INT2 - support for that being for a future 'feature' addition).

A hacky solution would be to require the first one to always be INT1 but that
gives us no (backwards compatible) path forwards if someone does have a board
where only INT2 is wired.

So minimum change I think will be to provide interrupt-names allowing any of
INT1 (default if not specified)
INT1, INT2
INT2

and your fix below.

Thanks,

Jonathan



> ---
>  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> index b6bbc312a7cf..1414ba9977c1 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> @@ -24,8 +24,10 @@ properties:
>  
>    interrupts:
>      minItems: 1
> +    maxItems: 2
>      description:
>        Should be configured with type IRQ_TYPE_EDGE_RISING.
> +      If two interrupts are provided, expected order is INT1 and INT2.
>  
>  required:
>    - compatible

