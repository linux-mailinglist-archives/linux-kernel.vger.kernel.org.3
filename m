Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A944C01E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiBVTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbiBVTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:16:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46AE115E6FE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 11:15:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11B871042;
        Tue, 22 Feb 2022 11:15:38 -0800 (PST)
Received: from bogus (unknown [10.57.3.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A833C3F66F;
        Tue, 22 Feb 2022 11:15:36 -0800 (PST)
Date:   Tue, 22 Feb 2022 19:14:47 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Szymon Balcerak <sbalcerak@marvell.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
Subject: Re: Using SCMI driver to prepare data for controlling cores via ACPI
 CPPC (_CPC) and PCCT.
Message-ID: <20220222191447.sol3wkdamaxlvm43@bogus>
References: <MN2PR18MB3358B61B4B5777FB35B42733BA3A9@MN2PR18MB3358.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR18MB3358B61B4B5777FB35B42733BA3A9@MN2PR18MB3358.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc linux-acpi too for ACPI related topics next time)

On Mon, Feb 21, 2022 at 01:39:56PM +0000, Szymon Balcerak wrote:
> Hi Folks,
>
> This is a continuation of previously discussed topics:
> 1. "Mixing SCMI and ACPI" topic discussed here
> https://lore.kernel.org/linux-arm-kernel/20220207101024.rpcbbhtd6y6g7ykc@bogus/T/
> 2. "ACPI support for System Control and Management Interface (SCMI)"
> discussed here https://www.spinics.net/lists/arm-kernel/msg798464.html.
>

Thanks for the reference, helps to refresh the memory quicker.

> We did further research in regards to ACPI specification, SCMI specification
> and ARM requirements.
> Considering above, in ACPI we defined PCCT table together with PCC subspace
> type 3, according to SCMI specification ("The SCMI transport is represented
> as a standard ACPI Platform Communications Channel (PCC) of Type 3").

Correct the transport compatibility is present but be aware not the protocol
itself. It doesn't matter as the protocol specific details are abstracted/
hidden in the firmware but I must admit CPPC diverges here.

> This PCCT table describes "mailbox" between System Control Processor (SCP)
> and the Application Processors (AP) on our system (i.e. shared memory area,
> doorbell register, etc.).
> As a result PCC kernel driver (drivers/mailbox/pcc.c) was able to gather all
> required information out of ACPI PCCT table and thus was successfully
> probed.
>

Good.

> We also defined some sample ACPI _CPC objects for each processor core, so
> that CPPC kernel driver (drivers/cpufreq/cppc_cpufreq.c) could use those
> information.
> Within _CPC object we added specific registers offsets of PCC subspace
> defined in PCCT (ONLY example: ResourceTemplate(){Register(PCC, 32, 0,
> 0x124, 0) -> Desired Performance Register})
>

Hold on for a minute here. The CPPC(via direct PCC) is quite a different
protocol compared the SCMI performance protocol. The latter follows the
standard SCMI protocol header and payload structure used across several
other SCMI protocols. However the former(CPPC via PCC) has a simple protocol.
It maps the specific offset in the Communication subspace within the PCC
Subspace Shared Memory Region as registers to obtain the CPPC information.
There are 2 commands(one for read(0) and one for write(1)) to get/set the
updated values in the PCC subspace.

This simply doesn't align with SCMI performance protocol and we are aware
of that. You can implement the CPPC protocol as it is quite simple if you
have SCMI performance protocol implemented already.

However, being aware of this difference, and also for other valid requirements
we introduced the concept of Fastchannels in SCMI for performance protocol
mainly to bypass the PCC/mailbox overhead. It also aligns well with CPPC.
You just need to implement fastchannels in SCMI and specify those as
system memory GAS instead of PCC GAS in CPPC tables. Hope that helps, happy
to provide more details once you get familiarised with SCMI Fastchannels.

> Having above setup, execution flow for getting desired core performance
> (drivers/cpufreq/cppc_cpufreq.c -> cppc_get_desired_perf()) would look like:
> 1. ring the doorbell register (defined in PCCT)
> 2. wait for command completion indicated within PCC status field (status is
> part of shared memory defined within PCCT);
> 3. read the desired performance register (defined in _CPC object as specific
> PCC register).
>
> Now comes the problem: without preparing valid frame according to SCMI spec
> we will not get any valid response from SCP, even if we will ring a
> doorbell.

Expected and I have provided details above.

> Considering above, we came to conclusion that existing SCMI kernel driver
> (drivers/cpufreq/scmi-cpufreq.c) could be used to "prepare" valid SCMI frame
> and write it to shared memory before ringing the doorbell.

No, definitely not a good idea.

> This way SCP could "understand" SCPI request (e.g. get desired performance)
> and return valid data back within shared memory (within specific offset of
> PCC subspace).
> Do you think it might be a good direction to achieve the goal (monitoring
> and controlling cores)?
>

No. You can either add CPPC protocol on top of your current SCMI perf
implementation or you could add support for fast channels and use them in
CPPC.

> Main problem we currently see is that SCMI kernel driver will never be
> probed on ACPI systems as first of all arm_scmi (.compatible = "arm,scmi")
> will never be probed successfully. There is no DT on ACPI system at all.
> Do you plan to add ACPI support for arm-scmi, so that it's properly probed
> on ACPI systems and thus scmi-cpufreq is also probed?

As mentioned earlier, no we don't have plans and I don't think it is needed
for CPPC/cpufreq requirements atleast.
>
> Finally, assuming arm-scmi  and scmi-cpufreq are probed: how could we
> accomplish preparing SCMI frame before ringing a doorbell?
>

Not applicable.

--
Regards,
Sudeep
