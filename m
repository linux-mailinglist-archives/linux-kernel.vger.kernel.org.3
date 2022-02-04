Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994044A97E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357876AbiBDKgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:36:08 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:39817 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBDKgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:36:06 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B0319240002;
        Fri,  4 Feb 2022 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643970965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMxcVPsdmhWvTGX23bq2bnDt9bInTpit0TJ0BdWBSkM=;
        b=c9Y0y4t92Y1oTOGSK5FqtxRpMl++eZdypLIHpCg/2bZ0s8R3t7LcSfqWxQnrYEPwzwV8E7
        tZK/tKVyJS7zYGdaxowQjEDI2TEEFfHh0zgHmo9VHB5pQ/9fdV/Xlo323fM3qUsxF9ncrp
        7JcvsthkimsJx99o8ZbvQC+ewNFBHCOT/Hc2BRNcZzuyoYCsuTJMBxYOUaETdtmkcvmctv
        tjipPnty/CQ7/8cH+gAv2PJCA164U1gE/fjPzG5iL4mdc5B7aDZdJ4UZXDPliPeZo9MD16
        7XJp8Qnr/kvb4ZWT1wjC7rkKZMQwxLoPkNAVE8l7Mb3HnG1QIsk4LefDu1V1kg==
Date:   Fri, 4 Feb 2022 11:36:02 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clement.leger@bootlin.com
Subject: Re: [PATCH] dt-bindings: microchip: atmel,at91rm9200-tcb: remove
 mandatory interrupts property
Message-ID: <Yf0Bkh4pXKORmNkG@piout.net>
References: <20220204081446.474991-1-eugen.hristev@microchip.com>
 <Yfz15ta50G5WC158@piout.net>
 <e939a0df-052c-43a6-8be6-51848d3fe5e5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e939a0df-052c-43a6-8be6-51848d3fe5e5@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2022 10:28:43+0000, Eugen.Hristev@microchip.com wrote:
> On 2/4/22 11:46 AM, Alexandre Belloni wrote:
> > On 04/02/2022 10:14:46+0200, Eugen Hristev wrote:
> >> The timer block can be used only to be read and to measure time in a polling
> >> fashion. This can be used by Linux like this for example, or it can be used
> >> by different projects which do not have interrupt controllers, or do not
> >> wish to enable them (e.g. U-boot).
> >> As DT is ABI, the binding should relate to all possible use cases and describe
> >> the hardware and the requirements.
> >> The interrupt is not a hard requirement for the timer to function in a
> >> specific way.
> >> Thus, choose to remove the interrupts property from the mandatory list of
> >> properties.
> >>
> > 
> > The correct hardware description is that the interrupt is present on the
> > IP. Having software behave differently depending on the presence of that
> > property is configuration, not hardware description.
> 
> I agree. The interrupt is present on the IP, thus the property exists 
> and it's described.
> However, the interrupt is not mandatory for IP operations. Thus it 
> should not be in the list of mandatory properties.
> 

If the interrupt is always present, it is mandatory, it doesn't matter
whether is is used or necessary to get the IP to work.



> > 
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >> ---
> >>   .../devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml  | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> >> index 597d67fba92f..27f78459b892 100644
> >> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> >> @@ -134,7 +134,6 @@ allOf:
> >>   required:
> >>     - compatible
> >>     - reg
> >> -  - interrupts
> >>     - clocks
> >>     - clock-names
> >>     - '#address-cells'
> >> --
> >> 2.25.1
> >>
> > 
> > --
> > Alexandre Belloni, co-owner and COO, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com
> > 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
