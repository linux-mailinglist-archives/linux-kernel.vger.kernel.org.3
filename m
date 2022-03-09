Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B44D2C96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiCIJza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiCIJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:55:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E56C10DA46;
        Wed,  9 Mar 2022 01:54:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 554C31650;
        Wed,  9 Mar 2022 01:54:28 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 720D43FA4D;
        Wed,  9 Mar 2022 01:54:26 -0800 (PST)
Date:   Wed, 9 Mar 2022 09:54:24 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
Message-ID: <Yih5UCRKdYvlD4Bx@bogus>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
 <20220302180913.13229-3-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302180913.13229-3-ionela.voinescu@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 06:09:12PM +0000, Ionela Voinescu wrote:
> Define topology_init_cpu_capacity_cppc() to use highest performance
> values from _CPC objects to obtain and set maximum capacity information
> for each CPU. acpi_cppc_processor_probe() is a good point at which to
> trigger the initialization of CPU (u-arch) capacity values, as at this
> point the highest performance values can be obtained from each CPU's
> _CPC objects. Architectures can therefore use this functionality
> through arch_init_invariance_cppc().
> 
> The performance scale used by CPPC is a unified scale for all CPUs in
> the system. Therefore, by obtaining the raw highest performance values
> from the _CPC objects, and normalizing them on the [0, 1024] capacity
> scale, used by the task scheduler, we obtain the CPU capacity of each
> CPU.
> 
> While an ACPI Notify(0x85) could alert about a change in the highest
> performance value, which should in turn retrigger the CPU capacity
> computations, this notification is not currently handled by the ACPI
> processor driver. When supported, a call to arch_init_invariance_cppc()
> would perform the update.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Looks good to me. FWIW,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
