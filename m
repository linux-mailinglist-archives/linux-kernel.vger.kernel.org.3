Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F974BFE42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiBVQQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiBVQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:15:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73E151662D9;
        Tue, 22 Feb 2022 08:15:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3E61063;
        Tue, 22 Feb 2022 08:15:31 -0800 (PST)
Received: from bogus (unknown [10.57.3.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D843B3F70D;
        Tue, 22 Feb 2022 08:15:29 -0800 (PST)
Date:   Tue, 22 Feb 2022 16:14:40 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <20220222161440.xadrgjftdyxenxgo@bogus>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > Hi Krzysztof,
> > 
> > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> >>> Introducing new parameter called scmi_devid to the device-tree bindings.
> >>> This parameter should be set for the device nodes, which has
> >>> clocks/power-domains/resets working through SCMI.
> >>> Given parameter should set the device_id, needed to set device
> >>> permissions in the Firmware. This feature will be extremely useful for
> >>> the virtualized systems, which has more that one Guests running on the
> >>> system at the same time or for the syestems, which require several
> >>> agents with different permissions. Trusted agent will use scmi_devid to
> >>> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> >>> for details).
> >>> Agents concept is described in Section 4.2.1 [0].
> >>>
> >>> scmi_devid in Device-tree node example:
> >>> usb@e6590000
> >>> {
> >>>     scmi_devid = <19>;
> >>>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
> >>>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
> >>>     power-domains = <&scmi_power 0>;
> >>> };
> >>
> >> And how do you prevent DT overlay adding such devid to any other node
> >> thus allowing any other device to send requests with given devid?
> >>
> > Thank you for the quick response.
> > scmi_devid value will be used only by Trusted Agent when the device
> > permissions are set. Non-trusted agents, which in our case are
> > represented as Guest OS are using scmi drivers, already present in linux
> > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
> > nodes to access to SCMI protocol.
> 
> Ah, ok.
> 
> > 
> >> Plus few technicalities:
> >> 1. Hyphen, not underscore in property name, so scmi-devid.
> > 
> > Thanks for the tip, I will change that in v2.
> 
> Few more thoughts:
> 1. This looks specific to ARM SCMI, so you also need vendor prefix, so
> something like:
> arm,scmi-devid
> arm,scmi-device-id
> 

Keeping the other discussion separate, I wanted to comment on this.
I agree with Krzysztof on having vendor specific prefix if we decide to add
this device id thing. However, I prefer not to use "arm,scmi-" here.
It can be "xen,scmi-" as we had plans to introduce some concepts in SCMI
spec that may use looks like this device-id. I would just like to avoid
conflicting with that in the future. It may happen to be same in the future
(i.e. this xen device-id matches 100% with definition of device-id we might
introduce in the spec, but I want to make assumption otherwise and leave
scope for divergence however small/little it can be). No issues even if
they converge and match 100% later in the far future.

-- 
Regards,
Sudeep
