Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05A94C6F58
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiB1O1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiB1O06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:26:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECEF873076;
        Mon, 28 Feb 2022 06:26:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A049D6E;
        Mon, 28 Feb 2022 06:26:19 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE7D03F73D;
        Mon, 28 Feb 2022 06:26:16 -0800 (PST)
Message-ID: <6e14bdd4-5924-dd58-41ef-5bdb5561913b@arm.com>
Date:   Mon, 28 Feb 2022 14:26:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] dt-bindings: spi: Update clocks property for ARM
 pl022
Content-Language: en-GB
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
 <20220228124345.99474-2-singh.kuldeep87k@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220228124345.99474-2-singh.kuldeep87k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-28 12:43, Kuldeep Singh wrote:
> Add missing minItems property to clocks in ARM pl022 bindings.
> 
> This also helps in resolving below dtc warnings:
> arch/arm64/boot/dts/amd/amd-overdrive.dt.yaml: spi@e1020000: clocks: [[4]] is too short
>      From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml
> arch/arm64/boot/dts/amd/amd-overdrive.dt.yaml: spi@e1020000: clock-names: ['apb_pclk'] is too short
>      From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml

Who says that minItems is missing? Looking at the PL022 TRM[1] it seems 
clear that SSPCLK is pretty fundamental to useful operation. If that DT 
ever worked, it must be that the same clock is wired to both inputs, and 
the fact that that's how the neighbouring PL011 is described is strongly 
suggestive.

If the point of schema is to find errors in DTs, doesn't it make more 
sense to fix the DTs than to weaken the schema just to shut it up?

Of course in this particular case there's also the question of whether 
the most humane way to "fix" the Seattle DTs is to simply delete them, 
but that's orthogonal.

Robin.

[1] https://developer.arm.com/documentation/ddi0194/h/?lang=en

> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>   Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> index 6d633728fc2b..7d36e15db5b3 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> @@ -34,6 +34,7 @@ properties:
>       maxItems: 1
>   
>     clocks:
> +    minItems: 1
>       maxItems: 2
>   
>     clock-names:
