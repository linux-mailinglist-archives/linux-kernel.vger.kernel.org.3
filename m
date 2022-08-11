Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A158FA05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiHKJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiHKJ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 05:26:53 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F0992F40;
        Thu, 11 Aug 2022 02:26:49 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oM4Si-0001SW-H1; Thu, 11 Aug 2022 11:26:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] pinctrl: rockchip: add support for per-pinmux io-domain dependency
Date:   Thu, 11 Aug 2022 11:26:41 +0200
Message-ID: <3152231.AJdgDx1Vlc@diego>
In-Reply-To: <7353767b-0c38-a5a1-d3ac-3d9151140fb8@theobroma-systems.com>
References: <20220802095252.2486591-1-foss+kernel@0leil.net> <9b965d86-9b76-77a1-658e-3675c2138414@wolfvision.net> <7353767b-0c38-a5a1-d3ac-3d9151140fb8@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 11. August 2022, 10:45:07 CEST schrieb Quentin Schulz:
> Hi Michael,
> 
> On 8/11/22 09:52, Michael Riesch wrote:
> > Hi Quentin,
> > 
> > Thank you for your efforts! This will solve several issues that are
> > bound to pop up if a board deviates from the Rockchip reference design.

I find this approach quite nice. io-domains in their core specify pin
voltages, so having the tie in the pinctrl space makes a lot of sense.


> >> There already exists an IO domain driver for Rockchip SoCs[1]. This
> >> driver allows to explicit the relationship between the external power
> > 
> > ...allows to model explicitly...?
> > 
> >> supplies and IO domains[2]. This makes sure the regulators are enabled
> >> by the Linux kernel so the IO domains are supplied with power and
> >> correctly configured as per the supplied voltage.
> >> This driver is a regulator consumer and does not offer any other
> >> interface for device dependency.
> >>
> >> However, IO pins belonging to an IO domain need to have this IO domain
> >> correctly configured before they are being used otherwise they do not
> >> operate correctly (in our case, a pin configured as output clock was
> >> oscillating between 0 and 150mV instead of the expected 1V8).
> >>
> >> In order to make this dependency transparent to the consumer of those
> >> pins and not add Rockchip-specific code to third party drivers (a camera
> >> driver in our case), it is hooked into the pinctrl driver which is
> >> Rockchip-specific obviously.
> > 
> > This approach seems reasonable. But just for my understanding: Does this
> > mean we need to edit e.g. rk3568-pinctrl.dtsi, iterate over all entries,
> > and add rockchip,iodomains = <&corresponding_io_domain>;?
> > 
> 
> That would have been my hope yes, but it is not possible for one of the 
> boards we have based on PX30.
> 
> All pinmux listed in the px30.dtsi today belong to an IO domain. This 
> includes the I2C pins for the bus on which the PMIC is.
> Adding the rockchip,io-domains on each pinctrl will create the following 
> circular dependency:
> pinctrl depends on the io-domain device which depends on
> regulators from a PMIC on i2c which requires the i2c bus pins to be
> muxed from the pinctrl
> 
> Since the PMIC powering the IO domains can virtually be on any I2C bus, 
> we cannot add it to the main SoC.dtsi, it'll need to be added per board 
> sadly.

though you could also add the main props to the dtsi and use a per-board
/delete-property/ to free up the pmic-i2c, same result but less duplicate
dt additions and less clutter.


> >> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> >> index 32e41395fc76..c3c2801237b5 100644
> >> --- a/drivers/pinctrl/pinctrl-rockchip.c
> >> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> >> @@ -24,6 +24,8 @@
> >>   #include <linux/of_address.h>
> >>   #include <linux/of_device.h>
> >>   #include <linux/of_irq.h>
> >> +#include <linux/of_platform.h>
> >> +#include <linux/platform_device.h>
> >>   #include <linux/pinctrl/machine.h>
> >>   #include <linux/pinctrl/pinconf.h>
> >>   #include <linux/pinctrl/pinctrl.h>
> >> @@ -2370,6 +2372,12 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
> >>   	dev_dbg(dev, "enable function %s group %s\n",
> >>   		info->functions[selector].name, info->groups[group].name);
> >>   
> >> +	if (info->groups[group].io_domain &&
> >> +	    !platform_get_drvdata(info->groups[group].io_domain)) {
> >> +		dev_err(info->dev, "IO domain device is required but not probed yet, deferring...");
> > 
> > Probably this has been left in there for debugging, but should be
> > removed to avoid spamming dmesg. IIUC this condition could occur several
> > times.
> > 
> 
> Considering that the deferred probing mechanism is to retry the 
> to-be-deferred device after all other devices have been tried, it is 
> very likely to not spam dmesg.
> 
> We could remove it though, no strong opinion on this.

just move it to use dev_dbg and everybody is happy :-) .


> >> @@ -2684,6 +2693,16 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
> >>   	if (!size || size % 4)
> >>   		return dev_err_probe(dev, -EINVAL, "wrong pins number or pins and configs should be by 4\n");
> >>   
> >> +	node = of_parse_phandle(np, "rockchip,io-domains", 0);
> >> +	if (node) {
> >> +		grp->io_domain = of_find_device_by_node(node);
> >> +		of_node_put(node);
> >> +		if (!grp->io_domain) {
> >> +			dev_err(info->dev, "couldn't find IO domain device\n");
> >> +			return -ENODEV;
> > 
> > Again just for my understanding: The property is optional in order to
> > provide compatibility with older device trees, right?
> > 
> 
> Of course (at least that's the intent). If it is omitted, 
> of_parse_phandle will return NULL and we'll not be executing this part 
> of the code. However, if one phandle is provided and the device does not 
> actually exist (IIUC, the phandle points to a DT-valid node but the 
> device pointed at by the phandle is either disabled or its driver is not 
> built). That being said, I don't know how this would work with an IO 
> domain driver built as a module. That would be a pretty dumb thing to do 
> though.

I think this should work even with io-domain "disabled" or as module
when slightly modified.

I.e. for disabled nodes, no kernel-device should be created
(grp->io_domain will be NULL) and for a module the device itself is created
when the dt is parsed (of_populate...) and will just not have probed yet.

Together with the comment farther above of having the io-domain link always
present we should get rid of the error condition though :-) .



Hmm, while going through this one thought was, do we want more verbosity
in the dt for this?

I.e. with the current approach we'll have

&io_domains {
	status = "okay";

	audio-supply = <&pp1800_audio>;
	bt656-supply = <&pp1800_ap_io>;
	gpio1830-supply = <&pp3000_ap>;
	sdmmc-supply = <&ppvar_sd_card_io>;
};

and pinctrl entries linking to the core <&io_domains> node. This might bite
us down the road again in some form.

Something like doing an optional updated binding like:

&io_domains {
	status = "okay";

	audio-domain {
		domain-supply = <&pp1800_audio>;
	};
	bt656-domain {
		domain-supply = <&pp1800_ap_io>;
	};
	gpio1830-domain {
		domain-supply = <&pp3000_ap>;
	};
	sdmmc-domain {
		domain-supply = <&ppvar_sd_card_io>;
	};
};

       pcie {
               pcie_ep_gpio: pci-ep-gpio {
                       rockchip,pins =
                               <4 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
                       rockchip,io-domains = <&gpio1830_domain>;
               };
       };


I.e. linking the pin-set to a definition of its actual io-domain, instead
of only the general io-domain node. Somewhat similar to power-domains.

The code itself could be the same as now (except needing to get the parent
of the linked node for the io-domains), but would leave us the option of
modifying code behaviour without touching the binding if needed down the
road.


Heiko


