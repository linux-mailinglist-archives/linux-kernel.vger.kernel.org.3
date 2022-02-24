Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D64C2B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiBXL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXL4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:56:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B64254550;
        Thu, 24 Feb 2022 03:55:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72513106F;
        Thu, 24 Feb 2022 03:55:35 -0800 (PST)
Received: from bogus (unknown [10.57.3.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 654C83F66F;
        Thu, 24 Feb 2022 03:55:33 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:54:43 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Message-ID: <20220224115443.fwhczfvm3cfwoim7@bogus>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <20220222110003.GC21915@e120937-lin>
 <20220222160637.yn6pru4nfgwih23j@bogus>
 <20220222171549.GA2194063@EPUAKYIW015D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222171549.GA2194063@EPUAKYIW015D>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 05:15:49PM +0000, Oleksii Moisieiev wrote:
> Hi Sudeep,
> 
> On Tue, Feb 22, 2022 at 04:06:37PM +0000, Sudeep Holla wrote:
> > Hi Oleksii,
> > 
> > My initial feedback on this. And thanks Cristian for making it so easy as
> > you have covered most of the things in depth(which I might have not done
> > myself that well)
> > 
> > On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> > > On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> > > > Introducing new parameter called scmi_devid to the device-tree bindings.
> > > > This parameter should be set for the device nodes, which has
> > > > clocks/power-domains/resets working through SCMI.
> > 
> > I prefer you had given more details on your usage model here instead of
> > pointing to the other Xen thread as it helps for someone without much
> > background on Xen or your use-case to review this.
> > 
> Let me describe the process in few words:
> We implemented a new feature, called SCI-mediator in Xen.
> The proposed implementation allows Guests to communicate with the Firmware using SCMI
> protocol with SMC as a transport. Other implementation are also
> possible, such as SCMI-Mailbox, SCPI-mailbox etc.
> 
> In this feature Xen is the Trusted Agent, which receives the following
> information in Xen device-tree:
> 1) All channels should be described, each channel defined as
> arm,scmi-shmem node;
> 2) Scmi node arm,scmi-smc with protocols description;

Sounds good so far.

> 3) scmi-devid should be set in nodes, which works through SCMI.
>

Why is this needed for Guest OS, you need not populate this if Guest OS
is not required to use it, right ? If it is needed just by Xen hypervisor,
lets talk about that and why it is bad idea to mix that with general
SCMI bindings.

> On start Xen inits itself as trusted agent and requests agent
> configuration by using BASE_DISCOVER_AGENT message. This message is sent
> to each configured channel to get agent_id
> 
> On Domain creation stage Xen will do the following steps:
> 1) Assign channel to the Guest and map channel address to the Domain
> address. For the Domain this address should be the same;
> 2) Generate arm,scmi-shmem and arm,scmi-smc nodes if needed for Guest
> device-tree (the device-tree which should be passed to the Guest);
> 3) Process devices, which are passed through to this Guest and set
> BASE_SET_DEVICE_PERMISSIONS for the scmi-devid, received from the
> device-node;
>

I am confused here. So the Xen knows which devices are assigned to each
Guest OS but doesn't know device ID for them, but relies on the device
tree node ?

> Guest OS will receive non-trusted channel and ignore scmi-devid fields
> in the device-nodes.
>

Then no need to pass it. It keeps the SCMI agent binding clean.

> IMPORTANT: Guest OS is non-trusted Agent. Xen is the only trusted agent
> in the system. Guest OS uses standart scmi drivers without any xen
> related changes. So Guest OS doesn't know it works through mediator.
>

Good.

> The main question is - how Firmware will know what agent sent SMC
> message and what channel_id should be used? I couldn't find clear
> explanation in spec.

1. So the hypervisor forwards all the messages from different guests without
   any marshalling ?
2. If Xen is just acting as pass through, why does firmware care about the
   origin of the message.

> That's why I end up with the following approaches:
> 1) Current implemenation: Guest OS send SMC request, Xen intercept this
> request and set channel ID to SMC Client_ID field (reg7), then resend
> SMC message to Firmware. Firmware parses SMC Client ID to get channel_id
> to work with.

As asked above, why is this information important to the firmware.

> 2) Another approach is to generate unique FuncID for each GuestOS. In
> this case no interception from Xen is needed - Guest OS can work
> directly with Firmware.
>

I think that is the only way today to support multiple channels with
SMC/HVC. The reason for that is since the SMC FID is custom, we can't take
custom parameters and write a generic SCMI smc transport driver. This was
discussed and we decided to go for different FID, otherwise we would have
to standardise parameters to the custom FID which is insane IMO.

> I hope you'll be able to help me with that.
>

Thanks for details. It definitely provided more information though not yet
complete as you can guess with my questions here.

> > > > Given parameter should set the device_id, needed to set device
> > > > permissions in the Firmware. This feature will be extremely useful for
> > > > the virtualized systems, which has more that one Guests running on the
> > > > system at the same time or for the syestems, which require several
> > > > agents with different permissions. Trusted agent will use scmi_devid to
> > > > set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > > > for details).
> > 
> > I am bit confused here, so you expecting a non-secure/non-trusted entity
> > to supply this device-id to the Trusted agent ? Is that not the breach of
> > trust as any non-trusted entity can supply any agent-id and get the permission
> > to access the associated resource in this way ? Or am I missing something
> > totally here.
> > 
> 
> No, Device-id will be used only by trusted agents, which is Xen in our
> case. Please see above.
>

Understood now, and I will assert guest OS must not have it in its DT.


[...]

> > >
> > > So in all of this, I don't get why you need this DT definition aggregating SCMI
> > > resources to SCMI device IDs in the Guest OS, which is an SCMI agent that does not
> > > need to now anything about SCMI device IDs (at least with the current spec): this
> > > would make sense only if the Linux Kernel was the TrustedAgent in charge of
> > > configuring the devices permissions via BASE_SET_DEVICE_PERMISSIONS.
> > > (in fact you said you won't provide any code to manage this scmi_devid
> > > in the kernel since those guests are not trusted agents and the won't be
> > > allowed to set device permissions...)
> > >
> > 
> > +1 (again)
> > 
> > > The only tricky part I can see in all of the above is agent identification, since
> > > the agents are assigned an ID by the SCMI platform (which can be queried) and they
> > > have a set of dedicated channels to use, so basically the platform really identifies
> > > the Agents looking at the channel from which a request is coming from and AgentID is
> > > not carried inside the message as a source and cannot be spoofed.
> > >
> > 
> > IIUC, the physical/virtual transport and associated transport chosen
> > identifies the agent for the SCMI platform.
> 
> Could you please clarify what do you mean under "physical/virtual
> transport"?

I was speculating some design in Xen on how it present virtual channels to
guests. Ignore that as I now understand you are using SMC.

> For now yes - Firmware should get information for the channel from
> transport.

Indeed, with SMC/HVC, you will need different FID for reasons stated above.

> > 
> > > > Given example shows the configuration of the hsusb node, which is using
> > > > scmi to contol clocks, resets and power-domains. scmi_devid is set
> > > > equals to 19, which should match defined id for usb in the Firmware.
> > > >
> > > > Trusted agent will use scmi_devid to set the device permissions for
> > > > the Agents. Guest OS should not have an access to the permissions
> > > > settings, so no code to process scmi_devid was presented in Linux
> > > > kernel.
> > > >
> > > > We are currently contributing changes to Xen, which are intended to
> > > > mediate SCMI access from Guests to the Firmware. Xen uses scmi_devid to set
> > > > the permissions for the devices. See [1] thread for details.
> > > >
> > > > [0] https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/latest__;!!GF_29dbcQIUBPA!mGggDzmp0B8cSdGJdH4utz6sx7g5PMXq05mXf91dU8XgkJaCuEpHdARZCdl-g1BnrduL$ [developer[.]arm[.]com]
> > > > [1] https://urldefense.com/v3/__https://xen.markmail.org/message/mmi4fpb4qr6e3kad__;!!GF_29dbcQIUBPA!mGggDzmp0B8cSdGJdH4utz6sx7g5PMXq05mXf91dU8XgkJaCuEpHdARZCdl-g-bWzzb5$ [xen[.]markmail[.]org]
> > >
> > > IMHO, but I could be wrong, looking at the current SCMI spec you cannot just
> > > gather messages from a set of GuestOs talking via different SCMI channels and
> > > then pipe/route them through a single channel to the backend server,
> > > attaching/spoofing some sort of Agent source ID to each message like you seem to
> > > be doing in the Xen series
> > >
> > 
> > I haven't looked at the other series, but it is hard to say the spec prohibits
> > this. I don't understand that spoofing part, but Xen hyp can arbitrate the
> > requests across guests I believe. But the devil is in details so I can't
> > comment on what is done. What I can say is this Agent ID is in each message is
> > not compliant to spec.
> > 
> 
> In our implementation XEN do not copy any data from shared memory. The
> only thing it does is letting Firmware know which channel it should use.

OK.

-- 
Regards,
Sudeep
