Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6B56B40A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiGHIFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiGHIFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:05:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC3DD80488
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:05:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9CE1063;
        Fri,  8 Jul 2022 01:05:38 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 989E93F792;
        Fri,  8 Jul 2022 01:05:35 -0700 (PDT)
Date:   Fri, 8 Jul 2022 09:04:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v6 17/21] arch_topology: Limit span of
 cpu_clustergroup_mask()
Message-ID: <20220708080424.22x2bgcbggb6skua@bogus>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
 <20220704101605.1318280-18-sudeep.holla@arm.com>
 <Ysd160PQdWoDIdRC@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysd160PQdWoDIdRC@fedora>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

I will let Ionela or Dietmar cover some of the scheduler aspects as
I don't have much knowledge in that area.

On Thu, Jul 07, 2022 at 05:10:19PM -0700, Darren Hart wrote:
> On Mon, Jul 04, 2022 at 11:16:01AM +0100, Sudeep Holla wrote:
> > From: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> Hi Sudeep and Ionela,
> 
> > 
> > Currently the cluster identifier is not set on DT based platforms.
> > The reset or default value is -1 for all the CPUs. Once we assign the
> > cluster identifier values correctly, the cluster_sibling mask will be
> > populated and returned by cpu_clustergroup_mask() to contribute in the
> > creation of the CLS scheduling domain level, if SCHED_CLUSTER is
> > enabled.
> > 
> > To avoid topologies that will result in questionable or incorrect
> > scheduling domains, impose restrictions regarding the span of clusters,
> 
> Can you provide a specific example of a valid topology that results in
> the wrong thing currently?
>

As a simple example, Juno with 2 clusters and L2 for each cluster. IIUC
MC is preferred instead of CLS and both MC and CLS domains are exact
match.

> > 
> > While previously the scheduling domain builder code would have removed MC
> > as redundant and kept CLS if SCHED_CLUSTER was enabled and the
> > cpu_coregroup_mask() and cpu_clustergroup_mask() spanned the same CPUs,
> > now CLS will be removed and MC kept.
> > 
> 
> This is not desireable for all systems, particular those which don't
> have an L3 but do share other resources - such as the snoop filter in
> the case of the Ampere Altra.
> 
> While not universally supported, we agreed in the discussion on the
> above patch to allow systems to define clusters independently from the
> L3 as an LLC since this is also independently defined in PPTT.
>
> Going back to my first comment - does this fix an existing system with a
> valid topology? 

Yes as mentioned above Juno.

> It's not clear to me what that would look like. The Ampere Altra presents
> a cluster level in PPTT because that is the desireable topology for the
> system.

Absolutely wrong reason. It should present because the hardware is so,
not because some OSPM desires something in someway. Sorry that's not how
DT/ACPI is designed for. If 2 different OSPM desires different things, then
one ACPI will not be sufficient.

> If it's not desirable for another system to have the cluster topology -
> shouldn't it not present that layer to the kernel in the first place?

Absolutely 100% yes, it must present it if the hardware is designed so.
No if or but.

-- 
Regards,
Sudeep
