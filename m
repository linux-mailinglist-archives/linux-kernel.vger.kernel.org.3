Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846604C2819
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiBXJdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiBXJdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C3A220A953;
        Thu, 24 Feb 2022 01:32:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A8F3ED1;
        Thu, 24 Feb 2022 01:32:39 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F3593F70D;
        Thu, 24 Feb 2022 01:32:38 -0800 (PST)
Date:   Thu, 24 Feb 2022 09:32:32 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <20220224093232.GA12053@e120937-lin>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222161440.xadrgjftdyxenxgo@bogus>
 <20220222173458.GA2310133@EPUAKYIW015D>
 <alpine.DEB.2.22.394.2202231841190.239973@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2202231841190.239973@ubuntu-linux-20-04-desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 06:51:59PM -0800, Stefano Stabellini wrote:
> On Tue, 22 Feb 2022, Oleksii Moisieiev wrote:
> > On Tue, Feb 22, 2022 at 04:14:40PM +0000, Sudeep Holla wrote:
> > > On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wrote:
> > > > On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > > > > Hi Krzysztof,
> > > > > 

Hi Stefano,

> > > > > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> > > > >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> > > > >>> Introducing new parameter called scmi_devid to the device-tree bindings.
> > > > >>> This parameter should be set for the device nodes, which has
> > > > >>> clocks/power-domains/resets working through SCMI.
> > > > >>> Given parameter should set the device_id, needed to set device
> > > > >>> permissions in the Firmware. This feature will be extremely useful for
> > > > >>> the virtualized systems, which has more that one Guests running on the
> > > > >>> system at the same time or for the syestems, which require several
> > > > >>> agents with different permissions. Trusted agent will use scmi_devid to
> > > > >>> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > > > >>> for details).
> > > > >>> Agents concept is described in Section 4.2.1 [0].
> > > > >>>
> > > > >>> scmi_devid in Device-tree node example:
> > > > >>> usb@e6590000
> > > > >>> {
> > > > >>>     scmi_devid = <19>;
> > > > >>>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
> > > > >>>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
> > > > >>>     power-domains = <&scmi_power 0>;
> > > > >>> };
> > > > >>
> > > > >> And how do you prevent DT overlay adding such devid to any other node
> > > > >> thus allowing any other device to send requests with given devid?
> > > > >>
> > > > > Thank you for the quick response.
> > > > > scmi_devid value will be used only by Trusted Agent when the device
> > > > > permissions are set. Non-trusted agents, which in our case are
> > > > > represented as Guest OS are using scmi drivers, already present in linux
> > > > > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
> > > > > nodes to access to SCMI protocol.
> > > > 
> > > > Ah, ok.
> > > > 
> > > > > 
> > > > >> Plus few technicalities:
> > > > >> 1. Hyphen, not underscore in property name, so scmi-devid.
> > > > > 
> > > > > Thanks for the tip, I will change that in v2.
> > > > 
> > > > Few more thoughts:
> > > > 1. This looks specific to ARM SCMI, so you also need vendor prefix, so
> > > > something like:
> > > > arm,scmi-devid
> > > > arm,scmi-device-id
> > > > 
> > > 
> > > Keeping the other discussion separate, I wanted to comment on this.
> > > I agree with Krzysztof on having vendor specific prefix if we decide to add
> > > this device id thing. However, I prefer not to use "arm,scmi-" here.
> > > It can be "xen,scmi-" as we had plans to introduce some concepts in SCMI
> > > spec that may use looks like this device-id. I would just like to avoid
> > > conflicting with that in the future. It may happen to be same in the future
> > > (i.e. this xen device-id matches 100% with definition of device-id we might
> > > introduce in the spec, but I want to make assumption otherwise and leave
> > > scope for divergence however small/little it can be). No issues even if
> > > they converge and match 100% later in the far future.
> > > 
> > 
> > xem,scmi- works for me. What do other thinks?
>   ^ xen,scmi-
> 
> If this problem was Xen specific, then it would be fine to use xen,scmi-
> As Xen developer, it solves my problem and I am fine with it.
> 
> However, from a device tree and SCMI point of view, it looks like this
> problem is generic and it just happens that Xen is the first
> implementation to encounter it.
> 
> Cristian wrote: "The SCMI spec does not indeed cover the discovery of
> such devices and the related associated resources: it indeed delegates
> such description to FDT/ACPI as of now." How is that supposed to happen
> today with the current DT definitions, regardless of Xen? Is it a gap in
> the current device tree binding?

What I meant is that in fact SCMI device IDs are NOT needed in the Linux
Kernel DT, in fact also this series does not add any code using it and
there is no code as of now in Kernel to issue BASE_SET_DEVICE_PERMISSIONS
commands; Linux Guest OS in the above scenario is a Non-Trusted agent and
doesn't need to know SCMI DevIDs and must NOT have access to those IDs for
security reasons too (as Sudeep was saying): the Trusted Agent (XEN here)
and the SCMI platform server are the only ones required to share the
knowledge of such Device IDs (and how the related resources are grouped)
via some HW description scheme as you are doing indeed in XEN.

So, while on one side such device IDs discovery is delegated by the spec
to the HW description mechanisms, it seems just not needed in Kernel DT
given the kind or role it has as an SCMI agent in this context: as said
in fact there won't be any use as of now in Linux of such DT entries as
of now.

Thanks,
Cristian


