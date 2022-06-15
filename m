Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B287E54CFFD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349265AbiFORdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiFORcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:32:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C5E7627B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:32:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B736C153B;
        Wed, 15 Jun 2022 10:32:42 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 661013F73B;
        Wed, 15 Jun 2022 10:32:41 -0700 (PDT)
Date:   Wed, 15 Jun 2022 18:32:31 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
Subject: Re: [PATCH 11/22] firmware: arm_scmi: Add SCMIv3.1 extended names
 protocols support
Message-ID: <YqoXgsbg6t46rZeI@e120937-lin>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
 <20220330150551.2573938-12-cristian.marussi@arm.com>
 <6f865d7f-fde8-d923-3c7e-d12bfbc370a6@gmail.com>
 <YqmVsMGgxKuIT5rx@e120937-lin>
 <Yqmo/BiIR4gku0Y+@e120937-lin>
 <c787dfe6-9639-8797-d07a-048c5ec69ddf@gmail.com>
 <YqoI5hYa97nZwUjl@e120937-lin>
 <f194f9b6-578d-ae08-16c3-6d464da10452@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f194f9b6-578d-ae08-16c3-6d464da10452@gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 10:19:53AM -0700, Florian Fainelli wrote:
> On 6/15/22 09:29, Cristian Marussi wrote:
> > On Wed, Jun 15, 2022 at 09:10:03AM -0700, Florian Fainelli wrote:
> > > On 6/15/22 02:40, Cristian Marussi wrote:
> > > > On Wed, Jun 15, 2022 at 09:18:03AM +0100, Cristian Marussi wrote:
> > > > > On Wed, Jun 15, 2022 at 05:45:11AM +0200, Florian Fainelli wrote:
> > > > > > 
> > > > > > 
> > > > > > On 3/30/2022 5:05 PM, Cristian Marussi wrote:
> > > > > > > Using the common protocol helper implementation add support for all new
> > > > > > > SCMIv3.1 extended names commands related to all protocols with the
> > > > > > > exception of SENSOR_AXIS_GET_NAME.
> > > > > > > 
> > > > > > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > > > > 
> > > > > > This causes the following splat on a platform where regulators fail to
> > > > > > initialize:
> > > > > > 
> > > > > 
> > > > > Hi Florian,
> > > > > 
> > > > > thanks for the report.
> > > > > 
> > > > > It seems a memory error while allocating so it was not meant to be
> > > > > solved by the fixes, anyway, I've never seen this splat in my testing
> > > > > and at first sight I cannot see anything wrong in the devm_k* calls
> > > > > inside scmi_voltage_protocol_init...is there any particular config in
> > > > > your setup ?
> > > > > 
> > > > > Moreover, the WARNING line 5402 seems to match v5.19-rc1 and it has
> > > > > slightly changed with -rc-1, so I'll try rebasing on that at first and
> > > > > see if I can reproduce the issue locally.
> > > > > 
> > > > 
> > > > I just re-tested the series rebased on v519-rc1 plus fixes and I cannot
> > > > reproduce in my setup with a few (~9) good and bad voltage domains.
> > > > 
> > > > How many voltage domains are advertised by the platform in your setup ?
> > > 
> > > There are 11 voltage regulators on this platform, and of course, now that I
> > > am trying to reproduce the splat I reported I just cannot anymore... I will
> > > let you know if there is anything that needs to be done. Thanks for being
> > > responsive as usual!
> > 
> > ... you're welcome...
> > 
> > I'm trying to figure out where an abnormal mem request could happen...
> 
> I think the problem is/was with the number of voltage domains being reported
> which was way too big and passed directly, without any clamping to
> devm_kcalloc() resulting the splat indicating that the allocation was beyond
> the MAX_ORDER. The specification allows for up to 2^16 domains which would
> still be way too much to allocate using kmalloc() so we could/should
> consider vmalloc() here eventually?
> 

Yes I was suspicious about the same and I was starting to think about vmalloc
in general across all domain enumerations even if this is may not be the case
for your splat...

> In all likelihood though we probably won't find a system with 65k voltage
> domains.
> 
> > 
> > can you try adding this (for brutal debugging) when you try ?
> > (...just to rule out funny fw replies.... :D)
> 
> Sure, nothing weird coming out and it succeeded in enumerating all of the
> regulators, I smell a transient issue with our firmware implementation,
> maybe...
> 
> [    0.560544] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.560617] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.560673] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.560730] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.560881] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.560940] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.560996] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.561054] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.561110] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.561168] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.561225] arm-scmi brcm_scmi@0: num_returned:1  num_remaining:0
> [    0.561652] scmi-regulator scmi_dev.2: Regulator stb_vreg_2 registered
> for domain [2]
> [    0.561858] scmi-regulator scmi_dev.2: Regulator stb_vreg_3 registered
> for domain [3]
> [    0.562030] scmi-regulator scmi_dev.2: Regulator stb_vreg_4 registered
> for domain [4]
> [    0.562190] scmi-regulator scmi_dev.2: Regulator stb_vreg_5 registered
> for domain [5]
> [    0.564427] scmi-regulator scmi_dev.2: Regulator stb_vreg_6 registered
> for domain [6]
> [    0.564638] scmi-regulator scmi_dev.2: Regulator stb_vreg_7 registered
> for domain [7]
> [    0.564817] scmi-regulator scmi_dev.2: Regulator stb_vreg_8 registered
> for domain [8]
> [    0.565030] scmi-regulator scmi_dev.2: Regulator stb_vreg_9 registered
> for domain [9]
> [    0.565191] scmi-regulator scmi_dev.2: Regulator stb_vreg_10 registered
> for domain [10]
> 

Ok, this was another place where a reply carrying a consistent number of
non-segmented entries could trigger an jumbo-request to kmalloc...

..maybe this is where a transient fw issue can reply with a dramatic
numbers of possible (non-segmented) levels (num_returned+num_remaining)

(I filter out replies carrying descriptors for segmented voltage-levels
that does not come in triplets (returned:3  remaining:0) since they are out
of spec...but I just hit today on another fw sending such out of spec
reply for clocks and I will relax such req probably not to break too
many out-of-spec blobs out in the wild :P)

So let me know if got new splats...

Thanks,
Cristian

