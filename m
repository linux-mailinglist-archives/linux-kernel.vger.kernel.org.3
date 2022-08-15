Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71459335B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiHOQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiHOQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:37:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E615A1F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:37:52 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oNd5l-0000b5-Ic; Mon, 15 Aug 2022 18:37:29 +0200
Message-ID: <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
Date:   Mon, 15 Aug 2022 18:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Content-Language: en-US
In-Reply-To: <cover.1657187536.git.oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleksii,

On 07.07.22 12:25, Oleksii Moisieiev wrote:
> Introducing the domain controller provider/consumenr bindngs which allow to
> divided system on chip into multiple domains that can be used to select
> by who hardware blocks could be accessed.
> A domain could be a cluster of CPUs, a group of hardware blocks or the
> set of devices, passed-through to the Guest in the virtualized systems.
> 
> Device controllers are typically used to set the permissions of the hardware
> block. The contents of the domain configuration properties are defined by the
> binding for the individual domain controller device.
> 
> The device controller conception in the virtualized systems is to set
> the device configuration for SCMI (System Control and Management
> Interface) which controls clocks/power-domains/resets etc from the
> Firmware. This configuratio sets the device_id to set the device permissions
> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).
> There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
> determine device_id is not covered by the specification.
> Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
> Given parameter should set the device_id, needed to set device
> permissions in the Firmware.
> This property is used by trusted Agent (which is hypervisor in our case)
> to set permissions for the devices, passed-through to the non-trusted
> Agents. Trusted Agent will use device-perms to set the Device
> permissions for the Firmware (See Section 4.2.2.10 [0] for details).
> Agents concept is described in Section 4.2.1 [0].
> 
> Domains in Device-tree node example:
> usb@e6590000
> {
>     domain-0 = <&scmi 19>; //Set domain id 19 to usb node
>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
>     power-domains = <&scmi_power 0>;
> };
> 
> &scmi {
>     #domain-cells = <1>;
> }
> 
> All mentioned bindings are going to be processed by XEN SCMI mediator
> feature, which is responsible to redirect SCMI calls from guests to the
> firmware, and not going be passed to the guests.
> 
> Domain-controller provider/consumenr concept was taken from the bus
> controller framework patch series, provided in the following thread:
> [1].

I also was inspired by Benjamin's series to draft up a binding, but for a slightly
different problem: Some SoCs like the i.MX8MP have a great deal of variation
in which IPs are actually available. After factory testing, fuses are burnt
to describe which IPs are available and as the upstream DT only describes
the full featured SoCs, either board DT or bootloader is expected to turn
off the device that are unavailable.

What I came up with as a binding for the bootloader to guide its fixup
looks very similar to what you have:

feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
    feature-controller;
    feature-cells = <1>;
};

&vpu_g1 {
    features-gates = <&feat IMX8MP_VPU>;
};

The OCOTP driver would see that it has a feature-controller property and register
a callback with a feature controller framework that checks whether a device
is available. barebox, that I implemented this binding for, would walk
the kernel device tree on boot looking for the feature-gates property and then
disable/delete nodes as indicated without having to write any SoC specific code
and especially without hardcoding node names and hierarchies, which is quite brittle.

There was a previous attempt at defining a binding for this, but Rob's NAK
mentioned that a solution should cover both cases:

 https://lore.kernel.org/all/20220324042024.26813-1-peng.fan@oss.nxp.com/

Having implemented nearly the same binding as what you describe, I obviously like your
patch. Only thing I think that should be changed is the naming. A domain doesn't
really describe this gated-by-fuses scenario I have. Calling it feature-gates
instead OTOH makes sense for both your and my use case. Same goes for the documentation
that could be worded more generically. I am open to other suggestions of course. :-)

Also a general gpio-controller like property would be nice. It would allow drivers
to easily check whether they are supposed to register a domain/feature controller.
For devices like yours where a dedicated device node represents the domain controller,
it's redundant, but for a fuse bank, it's useful. #feature-cells could be used for
that, but I think a dedicated property may be better.

Let me know what you think and thanks for working on this!

Cheers,
Ahmad


> 
> I think we can cooperate with the bus controller framework developers
> and produce the common binding, which will fit the requirements of both
> features
> 
> Also, I think that binding can also be used for STM32 ETZPC bus
> controller feature, proposed in the following thread: [2].
> 
> Looking forward for your thoughts and ideas.
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> [1] https://lore.kernel.org/all/20190318100605.29120-1-benjamin.gaignard@st.com/
> [2] https://lore.kernel.org/all/20200701132523.32533-1-benjamin.gaignard@st.com/
> 
> ---
> Changes v1 -> V2:
>    - update parameter name, made it xen-specific
>    - add xen vendor bindings
> 
> Changes V2 -> V3:
>    - update parameter name, make it generic
>    - update parameter format, add link to controller
>    - do not include xen vendor bindings as already upstreamed
> 
> Changes V3 -> V4:
>    - introduce domain controller provider/consumer device tree bindings
>    - making scmi node to act as domain controller provider when the
>      device permissions should be configured
> ---
> 
> Oleksii Moisieiev (2):
>   dt-bindings: Document common device controller bindings
>   dt-bindings: Update scmi node description
> 
>  .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++++
>  .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/domains/domain-controller.yaml
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
