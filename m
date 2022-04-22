Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B4650B407
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446002AbiDVJaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiDVJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:30:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663AD506D3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 02:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC4B7CE2815
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FA6C385A0;
        Fri, 22 Apr 2022 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650619624;
        bh=4kQlBTX2c22m5x9vXEEkFYxo4lYjFfIQOfY/dINojMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/mEEU9pbSLGDRSGXHU7AsLLnTf53dOKb5N18fM6ocV8ESVDfjW0rxsaHFOqZmf29
         8rliCeg1IYgWKCMjLcHAI8dpKSfwCX3pSZkLmQvVFBcwwdLbJK0UOopVwLbKTkyad+
         zO0TJkVAJQSq0gC4FeVIfwd0HlxFHpdroIvSyG0oDIk3Bj3NVl/3Js2O9FmSODVNUl
         IjkY/JH0YTTPWR2K+u1VpuwJ0lYIaJXmHmwz5z/jPsJfih9fJ52/Go94A1cAv4NdXb
         HXeGXj4Rm8EHpOHnjudE1E7sYEUmEkZJb+yyQWVoLWsXZ35jnSjrogxSYTz5RunShP
         IQQWn9dxS20gA==
Received: by pali.im (Postfix)
        id E92AAA09; Fri, 22 Apr 2022 11:27:00 +0200 (CEST)
Date:   Fri, 22 Apr 2022 11:27:00 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mvebu: Enable MBUS error propagation
Message-ID: <20220422092700.3j7boazeubccdhcr@pali>
References: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
 <8736cqb63d.fsf@FE-laptop>
 <0285a09b2b1b7ae2ccc268a37e4357c95d270ac9.camel@alliedtelesis.co.nz>
 <20210603125525.nkswvixbabkgq5or@pali>
 <e75b74fa-b393-fede-1a19-fd43dbb7aba4@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e75b74fa-b393-fede-1a19-fd43dbb7aba4@alliedtelesis.co.nz>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2021 21:03:55 Chris Packham wrote:
> On 4/06/21 12:55 am, Pali Rohár wrote:
> > On Wednesday 08 January 2020 19:42:12 Chris Packham wrote:
> >> Hi Gregory,
> >>
> >> On Wed, 2020-01-08 at 11:22 +0100, Gregory CLEMENT wrote:
> >>> Hello Chris,
> >>>
> >>>> U-boot disables MBUS error propagation for Armada-385. The effect of
> >>>> this on the kernel is that any access to a mapped but inaccessible
> >>>> address causes the system to hang.
> >>>>
> >>>> By enabling MBUS error propagation the kernel can raise a Bus Error and
> >>>> panic to restart the system.
> >>> Unless I miss it, it seems that nobody comment this patch: sorry for the
> >>> delay.
> >>>
> >> Thanks for the response.
> >>
> >>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>>> ---
> >>>>
> >>>> Notes:
> >>>>      We've encountered an issue where rogue accesses to PCI-e space cause an
> >>>>      Armada-385 system to lockup. We've found that enabling MBUS error
> >>>>      propagation lets us get a bus error which at least gives us a panic to
> >>>>      help identify what was accessed.
> >>>>      
> >>>>      U-boot clears the IO Err Prop Enable Bit[1] but so far no-one seems to
> >>>>      know why.
> >>>>      
> >>>>      I wasn't sure where to put this code. There is similar code for kirwood
> >>>>      in the equivalent dt_init function. On Armada-XP the register is part of
> >>>>      the Core Coherency Fabric block (for A385 it's documented as part of the
> >>>>      CCF block).
> >>> What about adding a new set of register to the mvebu mbus driver?
> >>>
> >> After more testing we found that some previously "good" boards started
> >> throwing up panics with this change. I think that this might require
> >> handling some of the PCI-e interrupts (for correctable errors) via the
> >> EDAC subsystem.
> >>
> >> We're still working with Marvell to track down exactly why this is
> >> happening on our system.
> > Hello Chris! Have you somehow solved this issue? Or do you have some
> > contacts in Marvell for A385 PCIe subsystem?
> 
> The problem seemed to be a specific CPU Erratum for the A385 which I 
> brought into upstream u-boot[1].

Hello Chris, could you point me to this CPU Erratum? What is its number
or some other identifier? Because I'm unable to find any such erratum in
the list for A385 erratums.

> But even then we had to update our base 
> u-boot version from 2016.11 to 2019.10 so there may have been more going 
> on than just that one change.
> 
> [1] - 
> https://source.denx.de/u-boot/u-boot/-/commit/ad91fdfff0bd6ea471afe838e0f6d58ed898694e
> 
> >>> In this case it will be called even earlier allowing to see bus error
> >>> earlier.
> >>>
> >>> In any case, you should separate the device tree change from the code
> >>> change and at least provide 2 patches.
> >> Agreed. If/when something solid eventuates we'll do it as a proper
> >> series.
> >>
> >>> Gregory
> >>>
> >>>>      
> >>>>      --
> >>>>      [1] - https://scanmail.trustwave.com/?c=20988&d=yNG44EMQR-PfAPR99zig1LzptmqzHo11i7uAj4AGuQ&u=https%3a%2f%2fgitlab%2edenx%2ede%2fu-boot%2fu-boot%2fblob%2fmaster%2farch%2farm%2fmach-mvebu%2fcpu%2ec%23L489
> ^^^ sorry, as a result of a reasonably high profile cyber attack on a 
> local institution URLs in our incoming mail are intercepted.
> >>>>
> >>>>   arch/arm/boot/dts/armada-38x.dtsi |  5 +++++
> >>>>   arch/arm/mach-mvebu/board-v7.c    | 27 +++++++++++++++++++++++++++
> >>>>   2 files changed, 32 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> >>>> index 3f4bb44d85f0..3214c67433eb 100644
> >>>> --- a/arch/arm/boot/dts/armada-38x.dtsi
> >>>> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> >>>> @@ -386,6 +386,11 @@
> >>>>   				      <0x20250 0x8>;
> >>>>   			};
> >>>>   
> >>>> +			ioerrc: io-err-control@20200 {
> >>>> +				compatible = "marvell,io-err-control";
> >>>> +				reg = <0x20200 0x4>;
> >>>> +			};
> >>>> +
> >>>>   			mpic: interrupt-controller@20a00 {
> >>>>   				compatible = "marvell,mpic";
> >>>>   				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
> >>>> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> >>>> index d2df5ef9382b..fb7718386ef9 100644
> >>>> --- a/arch/arm/mach-mvebu/board-v7.c
> >>>> +++ b/arch/arm/mach-mvebu/board-v7.c
> >>>> @@ -138,10 +138,36 @@ static void __init i2c_quirk(void)
> >>>>   	}
> >>>>   }
> >>>>   
> >>>> +#define MBUS_ERR_PROP_EN BIT(8)
> >>>> +
> >>>> +/*
> >>>> + * U-boot disables MBUS error propagation. Re-enable it so we
> >>>> + * can handle them as Bus Errors.
> >>>> + */
> >>>> +static void __init enable_mbus_error_propagation(void)
> >>>> +{
> >>>> +	struct device_node *np =
> >>>> +		of_find_compatible_node(NULL, NULL, "marvell,io-err-control");
> >>>> +
> >>>> +	if (np) {
> >>>> +		void __iomem *reg;
> >>>> +
> >>>> +		reg = of_iomap(np, 0);
> >>>> +		if (reg) {
> >>>> +			u32 val;
> >>>> +
> >>>> +			val = readl_relaxed(reg);
> >>>> +			writel_relaxed(val | MBUS_ERR_PROP_EN, reg);
> >>>> +		}
> >>>> +		of_node_put(np);
> >>>> +	}
> >>>> +}
> >>>> +
> >>>>   static void __init mvebu_dt_init(void)
> >>>>   {
> >>>>   	if (of_machine_is_compatible("marvell,armadaxp"))
> >>>>   		i2c_quirk();
> >>>> +	enable_mbus_error_propagation();
> >>>>   }
> >>>>   
> >>>>   static void __init armada_370_xp_dt_fixup(void)
> >>>> @@ -191,6 +217,7 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
> >>>>   	.l2c_aux_val	= 0,
> >>>>   	.l2c_aux_mask	= ~0,
> >>>>   	.init_irq       = mvebu_init_irq,
> >>>> +	.init_machine	= mvebu_dt_init,
> >>>>   	.restart	= mvebu_restart,
> >>>>   	.dt_compat	= armada_38x_dt_compat,
> >>>>   MACHINE_END
> >>>> -- 
> >>>> 2.24.0
> >>>>
> >>>
