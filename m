Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946CF4CD34F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiCDLXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbiCDLWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36B17137754;
        Fri,  4 Mar 2022 03:22:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03CFC143D;
        Fri,  4 Mar 2022 03:22:03 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2F03F70D;
        Fri,  4 Mar 2022 03:22:01 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:21:59 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <YiH2V5pJs4vvsdn2@bogus>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222161440.xadrgjftdyxenxgo@bogus>
 <20220222173458.GA2310133@EPUAKYIW015D>
 <alpine.DEB.2.22.394.2202231841190.239973@ubuntu-linux-20-04-desktop>
 <20220224093232.GA12053@e120937-lin>
 <alpine.DEB.2.22.394.2202241415180.239973@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2202241415180.239973@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 02:22:28PM -0800, Stefano Stabellini wrote:
> On Thu, 24 Feb 2022, Cristian Marussi wrote:
> > On Wed, Feb 23, 2022 at 06:51:59PM -0800, Stefano Stabellini wrote:
> > > On Tue, 22 Feb 2022, Oleksii Moisieiev wrote:
> > > > On Tue, Feb 22, 2022 at 04:14:40PM +0000, Sudeep Holla wrote:
> > > > > On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wrote:
> > > > > > On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > > > > > > Hi Krzysztof,
> > > > > > > 
> > 
> > Hi Stefano,
> > 
> > > > > > > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> > > > > > >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> > > > > > >>> Introducing new parameter called scmi_devid to the device-tree bindings.
> > > > > > >>> This parameter should be set for the device nodes, which has
> > > > > > >>> clocks/power-domains/resets working through SCMI.
> > > > > > >>> Given parameter should set the device_id, needed to set device
> > > > > > >>> permissions in the Firmware. This feature will be extremely useful for
> > > > > > >>> the virtualized systems, which has more that one Guests running on the
> > > > > > >>> system at the same time or for the syestems, which require several
> > > > > > >>> agents with different permissions. Trusted agent will use scmi_devid to
> > > > > > >>> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > > > > > >>> for details).
> > > > > > >>> Agents concept is described in Section 4.2.1 [0].
> > > > > > >>>
> > > > > > >>> scmi_devid in Device-tree node example:
> > > > > > >>> usb@e6590000
> > > > > > >>> {
> > > > > > >>>     scmi_devid = <19>;
> > > > > > >>>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
> > > > > > >>>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
> > > > > > >>>     power-domains = <&scmi_power 0>;
> > > > > > >>> };
> > > > > > >>
> > > > > > >> And how do you prevent DT overlay adding such devid to any other node
> > > > > > >> thus allowing any other device to send requests with given devid?
> > > > > > >>
> > > > > > > Thank you for the quick response.
> > > > > > > scmi_devid value will be used only by Trusted Agent when the device
> > > > > > > permissions are set. Non-trusted agents, which in our case are
> > > > > > > represented as Guest OS are using scmi drivers, already present in linux
> > > > > > > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
> > > > > > > nodes to access to SCMI protocol.
> > > > > > 
> > > > > > Ah, ok.
> > > > > > 
> > > > > > > 
> > > > > > >> Plus few technicalities:
> > > > > > >> 1. Hyphen, not underscore in property name, so scmi-devid.
> > > > > > > 
> > > > > > > Thanks for the tip, I will change that in v2.
> > > > > > 
> > > > > > Few more thoughts:
> > > > > > 1. This looks specific to ARM SCMI, so you also need vendor prefix, so
> > > > > > something like:
> > > > > > arm,scmi-devid
> > > > > > arm,scmi-device-id
> > > > > > 
> > > > > 
> > > > > Keeping the other discussion separate, I wanted to comment on this.
> > > > > I agree with Krzysztof on having vendor specific prefix if we decide to add
> > > > > this device id thing. However, I prefer not to use "arm,scmi-" here.
> > > > > It can be "xen,scmi-" as we had plans to introduce some concepts in SCMI
> > > > > spec that may use looks like this device-id. I would just like to avoid
> > > > > conflicting with that in the future. It may happen to be same in the future
> > > > > (i.e. this xen device-id matches 100% with definition of device-id we might
> > > > > introduce in the spec, but I want to make assumption otherwise and leave
> > > > > scope for divergence however small/little it can be). No issues even if
> > > > > they converge and match 100% later in the far future.
> > > > > 
> > > > 
> > > > xem,scmi- works for me. What do other thinks?
> > >   ^ xen,scmi-
> > > 
> > > If this problem was Xen specific, then it would be fine to use xen,scmi-
> > > As Xen developer, it solves my problem and I am fine with it.
> > > 
> > > However, from a device tree and SCMI point of view, it looks like this
> > > problem is generic and it just happens that Xen is the first
> > > implementation to encounter it.
> > > 
> > > Cristian wrote: "The SCMI spec does not indeed cover the discovery of
> > > such devices and the related associated resources: it indeed delegates
> > > such description to FDT/ACPI as of now." How is that supposed to happen
> > > today with the current DT definitions, regardless of Xen? Is it a gap in
> > > the current device tree binding?
> > 
> > What I meant is that in fact SCMI device IDs are NOT needed in the Linux
> > Kernel DT, in fact also this series does not add any code using it and
> > there is no code as of now in Kernel to issue BASE_SET_DEVICE_PERMISSIONS
> > commands; Linux Guest OS in the above scenario is a Non-Trusted agent and
> > doesn't need to know SCMI DevIDs and must NOT have access to those IDs for
> > security reasons too (as Sudeep was saying): the Trusted Agent (XEN here)
> > and the SCMI platform server are the only ones required to share the
> > knowledge of such Device IDs (and how the related resources are grouped)
> > via some HW description scheme as you are doing indeed in XEN.
> > 
> > So, while on one side such device IDs discovery is delegated by the spec
> > to the HW description mechanisms, it seems just not needed in Kernel DT
> > given the kind or role it has as an SCMI agent in this context: as said
> > in fact there won't be any use as of now in Linux of such DT entries as
> > of now.
> 
> I see. This is one of those "difficult" cases where the device tree
> binding is needed but it is not used by the Linux kernel. (We have a few
> cases like this in system device tree and the more device tree gets
> adopted by other projects the more will see instances like this one.)
>

Indeed, I mentioned this in the other email. It clearly falls under the
larger umbrella of system device tree and not the one used by the Linux.

> In that case, I think it is OK to call it "xen,scmi-" if Rob also
> agrees.
>

Thanks.

> After all, we are currently using in Xen a property called
> "linux,pci-domain". We might as well have Linux in the future use a
> property called "xen,scmi-devid" to even things out :-)

Sure or we may add a generic one in the future as mentioned in the other
email for reasons mentioned there.

--
Regards,
Sudeep
