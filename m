Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEB34BF6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiBVLAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBVLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:00:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFEBB15A21A;
        Tue, 22 Feb 2022 03:00:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EA51139F;
        Tue, 22 Feb 2022 03:00:06 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AA8A3F70D;
        Tue, 22 Feb 2022 03:00:05 -0800 (PST)
Date:   Tue, 22 Feb 2022 11:00:03 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <20220222110003.GC21915@e120937-lin>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645460043.git.oleksii_moisieiev@epam.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> Introducing new parameter called scmi_devid to the device-tree bindings.
> This parameter should be set for the device nodes, which has
> clocks/power-domains/resets working through SCMI.
> Given parameter should set the device_id, needed to set device
> permissions in the Firmware. This feature will be extremely useful for
> the virtualized systems, which has more that one Guests running on the
> system at the same time or for the syestems, which require several
> agents with different permissions. Trusted agent will use scmi_devid to
> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> for details).
> Agents concept is described in Section 4.2.1 [0].
> 

Hi Oleksii,

I had a look at this patch and the related XEN series and I'd have a few
questions/doubts. (adding to the loop in CC Souvik from ATG and Vincent
from Linaro since he's working on similar SCMI virtualization stuff)

> scmi_devid in Device-tree node example:
> usb@e6590000
> {
>     scmi_devid = <19>;
>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
>     power-domains = <&scmi_power 0>;
> };
> 

So this SCMI device ID is meant to identify an SCMI device, viewed as a
grouping of SCMI resources (clock/power/...etc) so that a Trusted Agent
can issue a BASE_SET_DEVICE_PERMISSIONS telling to the SCMI Server
platform backend (SCP sw sitting somewhere) which SCMI agents on the
system can access which (SCMI) devices (in the Normal nonSecure world):
basically, if I got it right from the Xen series, your hypervisor acting
as Trusted Agent (and recognized as trusted agent by by the SCP) tells
the SCMI platform server SCP (via SMC in your case) how to configure the
access to the devices for all the other (non trusted) agents in the system
(other Guest OS/Domains instances).

The SCMI spec does not indeed cover the discovery of such devices and
the related associated resources: it indeed delegates such description
to FDT/ACPI as of now.

AFAIU in this scenario I imagine:

- SCMI Server platform (SCP) knows via its own methods (builtin_config
  FDT...etc) the list of defined SCMI devices and related associated
  resources like:
  
  deviceNNN -->> clock_X / power_Q
  deviceYYY ---> clock_Z / power_W
  ..etc


- Trusted Agent (XEN hypervisor) in turn:

  + is configured/recognized by the SCMI Server as a Trusted Agent (based
    on the channel it uses to talk to the server) and as such it is allowed
    to issue BASE_SET_DEVICE_PERMISSIONS (by the SCMI server)

  + has knowledge of the same set of devices/resources allocations (via
    its own FDT) as the SCMI server

  + can issue a proper set of BASE_SET_DEVICE_PERMISSIONS telling the
    SCMI server backend which devices can be used by which non-trusted
    agents (GuestOS) ... even dynamically I suppose when guests come and
    go.

    Xen:
	    BASE_SET_DEVICE_PERMISSIONS(dev_NNN, agent_3)
	    BASE_SET_DEVICE_PERMISSIONS(dev_YYY, agent_2)
	    BASE_SET_DEVICE_PERMISSIONS(dev_NNN, agent_4)

    and in this scenario the same dev_NNN could be made accessible to
    two different agents, it will be anyway up to the SCMI Server
    backend to armonize or reject such requests from 2 different
    agents around the same shared resources


- Other non-trusted agents on the system (GuestOSes or other non
  virtualized subsystems...e.g. WiFi/Modem...etc), described in their
  DTs (for Linux GuestOS) as using SCMI resources as usual (without SCMI
  device id) just issue SCMI request on the basic resource and those are
  routed to the SCMI Server backend by the Hypervisor UNMODIFIED:

  example for a shared resource:

   - Agent_2 set power_Q ON --->>> SCMI Server - OK - powerQ TURNED ON
    				  (allowed as configured by Trusted Agent,
				   powerQ hw was OFF turn it ON)

   - Agent_3 set power_Q OFF --->>> SCMI Server - DENIED
    				  (disallowed as configured by Trusted Agent)

   - Agent_4 set power_Q ON --->>> SCMI Server - OK - powerQ ALREADY ON
    				  (allowed as configured by Trusted Agent,
				   powerQ hw was ON nothing to be done)

   - Agent_2 set power_Q OFF --->>> SCMI Server - OK - powerQ UNCHANGED (SHARED with Agent_2)
    				  (allowed as configured by Trusted Agent but shared with
				   another agent)

   - Agent_4 set power_Q OFF --->>> SCMI Server - OK - powerQ OFF
    				  (allowed as configured by Trusted Agent but shared with
				   another agent

So in all of this, I don't get why you need this DT definition aggregating SCMI
resources to SCMI device IDs in the Guest OS, which is an SCMI agent that does not
need to now anything about SCMI device IDs (at least with the current spec): this
would make sense only if the Linux Kernel was the TrustedAgent in charge of
configuring the devices permissions via BASE_SET_DEVICE_PERMISSIONS.
(in fact you said you won't provide any code to manage this scmi_devid
in the kernel since those guests are not trusted agents and the won't be
allowed to set device permissions...)

The only tricky part I can see in all of the above is agent identification, since
the agents are assigned an ID by the SCMI platform (which can be queried) and they
have a set of dedicated channels to use, so basically the platform really identifies
the Agents looking at the channel from which a request is coming from and AgentID is
not carried inside the message as a source and cannot be spoofed.

> Given example shows the configuration of the hsusb node, which is using
> scmi to contol clocks, resets and power-domains. scmi_devid is set
> equals to 19, which should match defined id for usb in the Firmware.
> 
> Trusted agent will use scmi_devid to set the device permissions for
> the Agents. Guest OS should not have an access to the permissions
> settings, so no code to process scmi_devid was presented in Linux
> kernel.
> 
> We are currently contributing changes to Xen, which are intended to
> mediate SCMI access from Guests to the Firmware. Xen uses scmi_devid to set
> the permissions for the devices. See [1] thread for details.
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> [1] https://xen.markmail.org/message/mmi4fpb4qr6e3kad

IMHO, but I could be wrong, looking at the current SCMI spec you cannot just
gather messages from a set of GuestOs talking via different SCMI channels and
then pipe/route them through a single channel to the backend server,
attaching/spoofing some sort of Agent source ID to each message like you seem to
be doing in the Xen series

" Also XEN is the mediator which redirects SCMI requests, adding agentID so
  firmware should know the sender."

I may missing something though, not really a Xen expert here, or maybe this
agentID identification trick could be considered something not covered
by the spec and strictly part of the transport layer...not sure... the guys
in CC may have different/opposite opinions so feel free to redirect my
blabbing to /dev/null at the end :D

Thanks,
Cristian

