Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B9585ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbiGaMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiGaMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F22262A;
        Sun, 31 Jul 2022 05:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E321B60D14;
        Sun, 31 Jul 2022 12:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D96C433C1;
        Sun, 31 Jul 2022 12:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659270023;
        bh=qqBUdT0ndApF5SxwPM8tKLaDalw/gd4HkR2N2VLe8A0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o1HYkYrJ5mAuM/HSQd0kcsy1W7IKHhbYgvB57p5+FV0UnYoNdMbW2xzqVBBw+fBX+
         R8BnDDA9+7mQFk5ZFVdgEl9UAHg78n8hDvfh6sUvUXslzvM+TQdURThQ+S2+YdlHM1
         M/pY1fvJwFYMEGjFpjkAzNgoO0Ptf6oqx+siVpqCcnPUaAqFHD4p+cG0zTOY/hRPDS
         EOP+t/A4oWcJYMNNSn24mS8nwXhlxKpyJyi4SdL/1+QwngRuvBm51IDrwo5Yx3u/pr
         wqLBlmgwR9iG8bMafXzUFZvXH6tAeWZmpUomkxGFT/W0C1DitUd2nPlwHACRqxize+
         bbUlb6ZyaeFgg==
Date:   Sun, 31 Jul 2022 13:30:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: correct
 number of pins
Message-ID: <20220731133034.034dced1@jic23-huawei>
In-Reply-To: <20220727140148.223508-1-krzysztof.kozlowski@linaro.org>
References: <20220727140148.223508-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 16:01:48 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> BMG160 has two interrupt pins to which interrupts can be freely mapped.
> Correct the schema to express such case and fix warnings like:
> 
>   qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

We may need more than this.  What if only INT2 is wired?  I'd expect such
a device's binding to include interrupt-names to cover that case.
We'd also need a bunch of driver code to route the resulting interrupts.

I think the snag is that adding such support will break existing bindings using the
below.

> ---
>  .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> index b6bbc312a7cf..ebf98bc2eb7f 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> @@ -24,6 +24,9 @@ properties:
>  
>    interrupts:
>      minItems: 1
> +    items:
> +      - description: INT1 pin
> +      - description: INT2 pin
>      description:
>        Should be configured with type IRQ_TYPE_EDGE_RISING.
>  

