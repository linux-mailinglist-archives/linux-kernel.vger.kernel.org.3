Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC152159B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241537AbiEJMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbiEJMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:41:59 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38109252DCF;
        Tue, 10 May 2022 05:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=L6IMO5LGjDZtfxTxahYjYfLwAJox1qHstZ/tNceRD6k=; b=vxIttA9LVr8/mhICmGcN18z2qt
        0nsKNihJNly8ercr0LQDyfPRiNnWlmvxpeO6wZS0fdKfVe8OQeds7xi1iByv5x0VcgJT9pSwjbQrN
        MxmzOMqiaXAsaoyZ6sjuOhU0nGHVlk4bpv3WvVw5Dz1AKLlm/X81+meWvGrhJQg5upNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1noP7X-0028N4-R8; Tue, 10 May 2022 14:37:43 +0200
Date:   Tue, 10 May 2022 14:37:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <Ynpclx4z5z1Emx+b@lunn.ch>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220504044624.951841-2-chris.packham@alliedtelesis.co.nz>
 <dcc80690-c159-99f8-4686-536b9e87eb69@linaro.org>
 <6770d320-b998-0c9d-3824-0d429834b289@alliedtelesis.co.nz>
 <3498643b-cb2e-5685-65e0-7efe1113783f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3498643b-cb2e-5685-65e0-7efe1113783f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 09:08:08AM +0200, Krzysztof Kozlowski wrote:
> On 10/05/2022 06:14, Chris Packham wrote:
> > 
> > Based on the information I have (which isn't much) there is a ref_clk 
> > input that is connected to a 25MHz oscillator and then I'm assuming 
> > these are all generated from that with various dividers. 25MHz is the 
> > only documented option.
> > 
> > There doesn't appear to be any documented register where I can read out 
> > the divider ratios. It might be nice I could have the fixed osc node and 
> > have these 3 clocks derived with fixed divisors but I don't see any what 
> > of achieving that.
> 
> 
> OK, but where are the dividers? The ref_clk is outside of SoC, so should
> be defined in board DTS (at least its rate). If the rest is in the SoC,
> they are usually part of clock controller, because usually they belong
> to some power domain or have some clock gating.

25MHz is a 'magic value' in Ethernet, nearly everything is based
around it. And remember this SoC is basically an Ethernet switch with
a small CPU glued on one side. If you gated clocks derived from the
25MHz reference clock, probably part of your Ethernet switch stops
working, which is the whole point of this SoC. So i doubt there are
gates on the derived clocks. If there is any gating and power domains,
it is generally at a different level. You can power down individual
ports of the Ethernet switch. But generally, there is one bit in a
register somewhere to do that, and you don't have direct control over
clocks and regulators etc.

       Andrew
