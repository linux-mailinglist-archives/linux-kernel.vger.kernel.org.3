Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60CE4CD33A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiCDLTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiCDLTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:19:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C6B57667B;
        Fri,  4 Mar 2022 03:18:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC6EA143D;
        Fri,  4 Mar 2022 03:18:24 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C19673F70D;
        Fri,  4 Mar 2022 03:18:23 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:18:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <YiH1fcXKBD97syWY@bogus>
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

The fact that we don't need this to be part of SCMI OSPM user bindings,
it is not addressed and can be considered as a gap.

+ The reason I want to keep it xen specific at the moment as we had some
plan to extended the device-id usage in the spec which hasn't progressed
a bit(I must admit that before you ask), and this addition should not be
obstruct that future development. If we align with what we define xen
specific as part of $subject work, we can always define generic binding
in the future and slowly make the other obsolete over the time.

-- 
Regards,
Sudeep
