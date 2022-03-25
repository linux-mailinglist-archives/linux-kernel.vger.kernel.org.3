Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14A74E7162
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358913AbiCYKhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbiCYKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:37:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87CBBB6D33;
        Fri, 25 Mar 2022 03:35:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 382B2D6E;
        Fri, 25 Mar 2022 03:35:36 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3ED3F73D;
        Fri, 25 Mar 2022 03:35:34 -0700 (PDT)
Date:   Fri, 25 Mar 2022 10:35:28 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     David Collins <quic_collinsd@quicinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH v2 0/2] regulator: scmi: add support for registering SCMI
 regulators by name
Message-ID: <Yj2a8OqLxmLYpOGT@e120937-lin>
References: <cover.1647909090.git.quic_collinsd@quicinc.com>
 <Yjm1wpcMZsZJJCuy@bogus>
 <eb03037b-e7c2-ea23-0bdb-27924ed54fa7@quicinc.com>
 <Yjyo+Xk0txZs4T/Z@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjyo+Xk0txZs4T/Z@sirena.org.uk>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 05:23:05PM +0000, Mark Brown wrote:
> On Tue, Mar 22, 2022 at 06:12:33PM -0700, David Collins wrote:
> 
> > Another problem is that, as with regulators, ID numbers could
> > unknowingly get out of sync between the platform and the agent.  Using
> > clock domain names for referencing fixes both issues.  This can be
> 
> This is just saying that the hard coded IDs that the firmware and kernel
> use to communicate can get out of sync which is true no matter if those
> IDs are strings or if they're numerical, either way it's an ABI which
> can be broken.
> 
> > > If the IDs are correct like the names, it is guaranteed. I see this
> > > ID vs name is more for some maintenance convenience because somewhere
> > > something else needs to changes or moved away from existing way of
> > > maintenance.
> 
> > How do you quantify an ID number to physical regulator mapping as
> > "correct"?  What happens if the mapping must be changed on the SCMI
> > platform side (e.g. a PMIC was added or removed, or the order that
> > regulators are listed in needs to change)?  If the SCMI agent is blindly
> 
> The whole point with the numbers being an ABI is that things must never
> be renumbered, just as if names are used the names can't be changed.  If
> the numbering is changing that just sounds like bugs on the platform
> side.  There's an implicit assumption in what you've written above that
> implementation details of the firmware should affect the IDs presented
> through SCMI which simply shouldn't be true, and indeed if the firmware
> can assign fixed strings it can just as well assign fixed numbers.

Could not agree more with Mark here...I think all the problem boils down
really to reduce maintenance burdain on the backend SCMI server as Sudeep
hinted previusly in this thread, which I am not saying is not a valid
concern, but maybe this is not the best way to address it.

My understanding, correct me if I'm wrong, is that the scenario here is one
of a backend SCMI server fw that indeed potentially manages a greater number
of resources (regulators,clocks...etc) than the ones effectively assigned to
a single OSPM agent (real or virtual), so that you have, say, 100 resources
and you are going to assign a different set of, say, 10 resources (maybe
overlapping) to each different OSPM SCMI agent running in a guest: as a
consequence you want to avoid to remap on the backend at build or
run-time this different set of 10 resources into the 0-9 set, but instead
serve these 10 different resources IDentified as they are in the backend
(say Guest1: 0-9 G2:05-14 G3:1,2,20,24-30) and then match by name in
the guest so that, say, "regulator_MAIN" is the well known regulator
for all Guests but really it could be ID 0 or 05 or 20 in the real
physical backend depending on which OSPM is askng (and similar kind of
issues in a non virtualized platform which instead has to share the same
FW between different versions of the HW)

Is my understanding correct ?

Beside these concerns expressed by Sudeep and Mark, talking specifically
about the series, I see that in V2 you introduce a common binding with
a very general 'scmi-domain-name' to be used in the above scenario with
regulators, but then you also talk about the possible need to employ this
scheme with other resources (clocks), so I was wondering, if this is the
case and if this can fly despite the above concerns,  if it was not better
to address this in a more general way at the SCMI core level, introducing
some sort of common method to be able to query a resource by name from
any SCMI driver no matter which protocol is used (perf/voltage/clock),
like as an example:

 void *.get_resource_by_node(struct scmi_protocol_handle *ph,
 			     struct device_node *np);

used in scmi-regulators to retrieve a voltage domain info by number OR
name transparently as:

    vinfo = handle->get_resource_by_node(ph, np)

so that all the logic you added in scmi-regulator to search DT and map
resources can be buried in the core SCMI and shared between all drivers
that can optionally use it.

...this will require a bit of more work in the SCMI core on my side of
course :D ...

Thanks,
Cristian
