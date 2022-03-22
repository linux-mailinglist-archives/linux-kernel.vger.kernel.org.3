Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FD4E3D51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbiCVLOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiCVLNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:13:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FC1681671;
        Tue, 22 Mar 2022 04:12:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C29EF153B;
        Tue, 22 Mar 2022 04:12:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD5153F66F;
        Tue, 22 Mar 2022 04:12:23 -0700 (PDT)
Date:   Tue, 22 Mar 2022 11:12:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Message-ID: <YjmvFZOqAcnoBcR+@bogus>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
 <Yie47a4lqXjVzgxI@robh.at.kernel.org>
 <20220316164619.GA3489934@EPUAKYIW015D>
 <YjIzeyNoWhVAY5HK@bogus>
 <alpine.DEB.2.22.394.2203181644560.2910984@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2203181644560.2910984@ubuntu-linux-20-04-desktop>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:53:20PM -0700, Stefano Stabellini wrote:
> On Wed, 16 Mar 2022, Sudeep Holla wrote:
> > On Wed, Mar 16, 2022 at 04:46:20PM +0000, Oleksii Moisieiev wrote:
> > > 
> > > > + The reason I want to keep it xen specific at the moment as we had some
> > > > plan to extended the device-id usage in the spec which hasn't progressed
> > > > a bit(I must admit that before you ask), and this addition should not be
> > > > obstruct that future development. If we align with what we define xen
> > > > specific as part of $subject work, we can always define generic binding
> > > > in the future and slowly make the other obsolete over the time.
> > > 
> > > IIUC you have some plans to provide device_id support to the device-tree
> > > bindings from your side. Maybe we can discuss some of your plans here
> > > and we can come up with the generic device-id binding?
> > > So I will have something to base on in Xen.
> > > 
> > 
> > Sorry if I wasn't clear in earlier emails. What I mentioned was that I would
> > like to reserve the generic namespace(i.e. just device-id) for generic SCMI
> > usage. Since we haven't defined it clearly in the spec, I don't want to
> > introduce the generic definition and binding now.
> > 
> > As mentioned earlier, though Xen definition and generic once may be exactly
> > same, but we won't know until then. So keep the xen usage and namespace
> > separate for now to avoid any future conflicts.
> 
> 
> Hi Sudeep,
> 
> I thought the specification already covered this device id, it simply
> delegated the description of it to Device Tree or ACPI, which is common
> behavior in ARM specs. What is missing in the SCMI spec from your point
> of view?
>

While you can say so, but for me it isn't to an extent that we can support
software around it. I did share my feedback with spec author but as you
know it was needed for virtualisation use-case like Xen and was rushed
into the spec. All it states is "Device identifier" identifies the device
and the enumeration is not part of the spec. It defers to DT/ACPI.

Since I didn't have to use that in OSPM, I hadn't given much thought/review
on that.

>
> Or would you like this scmi-devid Device Tree property (or similar) to
> be described in the SCMI specification itself?
>

Spec doesn't cover that in general but do carry some recommendations
sometimes.

> Typically Device Tree and ACPI descriptions are delegated to Device Tree
> and ACPI respectively. Also specification updates are typically slow
> (for good reason.) We might be waiting for a long time. It is usually
> not a matter of days.

I agree.

As I said, there were thoughts about adding device protocol to make
all the other protocols centered around the device. The idea is as below:

Today a device A is associated with clock domain X, reset domain Y,
voltage domain Z, perf domain P, power domain Q, ...and so on.
Especially this would get complex with lots of devices and for virtual
machines.

Instead let all these different operations use the device identifier A
in the above case to drive clock, reset, perf, power, voltage,...etc.

While this was just initial idea, I am bit wary of the fact that it would
alter the definition of device identifier. Also there is orthogonal topic
of device assignment in various contexts and associated identifiers.
IIRC Rob briefly raised concerns on one of such topics.

With all these in consideration, I preferred to not use the "device-id"
in the standard namespace for anything else until we get clarity on these.

--
Regards,
Sudeep
