Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA244E4A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiCWBOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiCWBOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:14:04 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB47B5BD1E;
        Tue, 22 Mar 2022 18:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647997955; x=1679533955;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vH7XINcncMSOnzEOcEwKUd+K0fo7VZPLqvqSmYr4Oys=;
  b=mN/FScv95jnEaU+bo6rUHwXHICIaqkpDTY4qgELADZjxjRQp0tNGyLL8
   ZeE8SVel5BJ+IpGMQR8uAMeyX+L/1+ErTVDl0bsUA+4q7AzJi/G66rqYQ
   ga6qz6P481E6f1VfamVinkwSx5TdEfEgd2uZFpN0n6e3gshtlATzOZW9l
   E=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Mar 2022 18:12:35 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 18:12:34 -0700
Received: from [10.46.160.247] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 22 Mar
 2022 18:12:34 -0700
Subject: Re: [PATCH v2 0/2] regulator: scmi: add support for registering SCMI
 regulators by name
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>,
        "Cristian Marussi" <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <cover.1647909090.git.quic_collinsd@quicinc.com>
 <Yjm1wpcMZsZJJCuy@bogus>
From:   David Collins <quic_collinsd@quicinc.com>
Message-ID: <eb03037b-e7c2-ea23-0bdb-27924ed54fa7@quicinc.com>
Date:   Tue, 22 Mar 2022 18:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yjm1wpcMZsZJJCuy@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 4:40 AM, Sudeep Holla wrote:
> On Mon, Mar 21, 2022 at 05:47:18PM -0700, David Collins wrote:
>> Name based SCMI regulator registration helps ensure that an SCMI
>> agent doesn't need to be aware of the numbering scheme used for
>> Voltage Domains by the SCMI platform.
> 
> While I understand the regulator framework has a good support for name
> based approach youasdf prefer, I see other frameworks like clock rely on
> numbering scheme and I see quite a few qualcomm platforms upstream use
> the number scheme for clocks. So why is that a problem with regulator ?

I assume that the clocks you are referring to in upstream targets are
explicitly managed as opposed to mediated by SCMI.  In that case,
consumer devices in device tree reference particular clocks using a
tuple consisting of <&phandle_of_clock_controller clock_id>.  The
clock_id value is in a numbering space that is unique to each clock
controller.  The ID numbers are #define'd in header files shared by DT
and the clock drivers.  As far as I know, no Qualcomm targets utilize
SCMI clocks (either as a platform or agent).

Supporting clocks in Linux using SCMI has its own set of challenges.
One is that the there can only be one clk-scmi device on the agent side
(associated with the platform) and thus all of the clocks it exposes
must be in the same numbering space.  In the case where the platform is
another Linux instance, this presents a mismatch as each of its many
clock controllers has its own numbering space.

Another problem is that, as with regulators, ID numbers could
unknowingly get out of sync between the platform and the agent.  Using
clock domain names for referencing fixes both issues.  This can be
accomplished by defining wrapper clock controller devices on the agent
which define all of the clocks and specify their parent by name (which
matches a clock exposed by the clk-scmi driver).

> Another main issue I have is what if the firmware and DT end up with a
> mismatch say with a firmware upgrade or a DT update ? Basically out of sync
> between DT and the SCMI firmware. I see this as duplication of source of
> information and is always cause for the trouble. I don't want to end up with
> the quirks to deal with (totally unnecessary) issues this may create in long
> run.

This patch series is specifically intended to address the issue of
firmware (SCMI platform) configurations getting out of sync with DT
(SCMI agent) configurations where the mapping of regulators to ID
numbers isn't correctly matched.

This change allows the existing 'reg' ID number based identification of
scmi-regulator subnodes to continue without issue.  Systems don't need
to use the proposed 'arm,scmi-domain-name' property if they'd prefer to
stay with 'reg' instead.  Also, both can be specified for added
assurance if desired.

>> It also ensures that the
>> correct Voltage Domain is selected for a given physical regulator.
> 
> How is that done magically if I give wrong regulator name ? Sorry the way
> it is presented sounds like adding name fixes something that numerical
> ID alone will always break.

If an scmi-regulator subnode on the SCMI agent side specifies an
'arm,scmi-domain-name' property value which does not match the name of
any voltage domain exposed by the SCMI platform, then that regulator
will not be registered at runtime.  The only way an scmi-regulator
subnode gets registered as a Linux regulator device is if there is a
positive name match.

The name string for a regulator has an explicit meaning that clearly
maps it to a particular physical regulator without the need for any
additional context.  In a non-trivial system composed of multiple PMICs
each with multiple regulators of different types, there is no single
numbering system that intuitively and unambiguously captures the mapping
of an ID number to a physical regulator.  Such ID numbers have no
explicit meaning in the context of physical regulator identification.
Therefore, some other information is required to map the ID numbers to
physical regulators (e.g. #define constants in a header file).  This
mapping must then somehow be shared across domains (i.e. by the platform
and agent) and always change in lock-step.

>> This cannot be guaranteed with numeric Voltage Domain IDs alone.
>>
> 
> If the IDs are correct like the names, it is guaranteed. I see this
> ID vs name is more for some maintenance convenience because somewhere
> something else needs to changes or moved away from existing way of
> maintenance.

How do you quantify an ID number to physical regulator mapping as
"correct"?  What happens if the mapping must be changed on the SCMI
platform side (e.g. a PMIC was added or removed, or the order that
regulators are listed in needs to change)?  If the SCMI agent is blindly
identifying regulators solely by ID number, then it has no idea that
anything has changed on the platform side.  If instead the agent is
using names for identification of SCMI voltage domains then reordering
IDs or adding new regulators has no impact.  Removing regulators from
the platform side would correctly lead to the regulator not registering
on the agent side.

> That said, if others believe, this is useful, I am happy to consider
> esp. if there are more *real* reasons for doing this.
> 
> Please add clock and other subsystem maintainers who also have numbering
> scheme as main mechanism in the upstream so that we get feedback from them
> too.

Done.

Thanks,
David
