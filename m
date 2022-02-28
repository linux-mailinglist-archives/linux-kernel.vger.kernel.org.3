Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F4A4C6FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiB1OhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiB1OhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:37:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BB137ED9C;
        Mon, 28 Feb 2022 06:36:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30E99D6E;
        Mon, 28 Feb 2022 06:36:25 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8653F73D;
        Mon, 28 Feb 2022 06:36:23 -0800 (PST)
Message-ID: <f22e9ddc-3103-2785-5504-fcc95d08cc8b@arm.com>
Date:   Mon, 28 Feb 2022 14:36:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/3] dt-bindings: spi: Add spiclk to clock-names property
 in pl022
Content-Language: en-GB
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20220228124345.99474-1-singh.kuldeep87k@gmail.com>
 <20220228124345.99474-4-singh.kuldeep87k@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220228124345.99474-4-singh.kuldeep87k@gmail.com>
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
> Fix below dtc warning by making necessary addition of "spiclk" in
> clock-names property.
> 
> arch/arm64/boot/dts/broadcom/stingray/bcm958742t.dt.yaml: spi@190000:
> clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
>      From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml
> arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dt.yaml: spi@66190000:
> clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
>      From schema: Documentation/devicetree/bindings/spi/spi-pl022.yaml

As before, what makes the binding at fault rather than that DT? The 
PL022's actual input is named SSPCLK, not SPICLK, so why should a driver 
which wants to look up that clock by name expect to look for "spiclk"?

Robin.

> Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> ---
>   Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> index 5f6926a58b15..fb3075a0c7fd 100644
> --- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
> @@ -45,6 +45,7 @@ properties:
>             - enum:
>                 - sspclk
>                 - SSPCLK
> +              - spiclk
>             - const: apb_pclk
>   
>     pl022,autosuspend-delay:
