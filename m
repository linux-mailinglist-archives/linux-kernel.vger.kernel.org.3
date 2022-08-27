Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D685A3992
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiH0SmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiH0SmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:42:06 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F78B2666;
        Sat, 27 Aug 2022 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=3Ti0t5W7laQ1yjP95FI+9j22q4zm/p9DmlBYb1A7/2g=; b=CM
        BcyoL5ZQWWkvC3ubN8x8Xt7Rk2wQvNlMETx4shXIKb0R9mRl6cYMwqvDUYh48QEeRgmdVqEets16Q
        rupibFX4LACnmY5f3Ny2CaEiBqeE7CxWaBhpqkhz8ANqtb38U19/HzoNNxbKMD4CzCCp+W6mry35o
        za9s5+tqjK50jkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oS0kp-00EnQE-Vx; Sat, 27 Aug 2022 20:41:59 +0200
Date:   Sat, 27 Aug 2022 20:41:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add switch port 6 node
Message-ID: <YwpldyOI5x1xgMoM@lunn.ch>
References: <20220825122102.18634-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825122102.18634-1-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 02:21:02PM +0200, Pali Rohár wrote:
> Switch port 6 is connected to eth0, so add appropriate device tree node for it.
> 
> Fixes: 26ca8b52d6e1 ("ARM: dts: add support for Turris Omnia")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  arch/arm/boot/dts/armada-385-turris-omnia.dts | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> index f655e9229d68..8215ffb6a795 100644
> --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> @@ -463,7 +463,17 @@
>  				};
>  			};
>  
> -			/* port 6 is connected to eth0 */
> +			ports@6 {
> +				reg = <6>;
> +				label = "cpu";
> +				ethernet = <&eth0>;
> +				phy-mode = "rgmii-id";
> +
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};

Hi Pali

I've not been following Vladimirs work on multiple CPU ports. Is it
clearly defined, both for old and new kernels, what happens where
there are multiple CPU ports defined?

      Andrew
