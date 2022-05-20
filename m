Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A13E52ECE6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349708AbiETNN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiETNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:13:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 909A1146745
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:13:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5885B1477;
        Fri, 20 May 2022 06:13:56 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7272A3F73D;
        Fri, 20 May 2022 06:13:53 -0700 (PDT)
Date:   Fri, 20 May 2022 14:13:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/8] arch_topology: Don't set cluster identifier as
 physical package identifier
Message-ID: <20220520131347.cgaevw77yjk523mw@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-2-sudeep.holla@arm.com>
 <d4c7fd09-814a-e57a-fe8f-a3959472991b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4c7fd09-814a-e57a-fe8f-a3959472991b@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:31:24PM +0200, Dietmar Eggemann wrote:
> On 18/05/2022 11:33, Sudeep Holla wrote:
> 
> You say `cluster identifier` which to me refers to
> `cpu_topology[cpu].cluster_id`. But I guess you meant `cluster node`
> from cpu-map DT node?
>

Correct, I am referring to the leaf cluster node identifier in terms
of cpu-map DT node which we now store in cpu_topology[cpu].cluster_id as
part of this series instead of previous cpu_topology[cpu].package_id.

> Otherwise you say we link (1.level) cpu-map cluster nodes to
> `cluster_id\_sibling`? But then (1) we will never support nested
> clusters and (2) why would we need llc support then?
>

(1) Do we have any platforms with nested clusters today ? No phantom
    clusters please as this is info that gets to the userspace and must
    reflect the real hardware. If one exist, then we need to add nested
    cluster if we need to support that hardware. I am not aware of any
    platform in particular DT based one.
(2) LLC was added to support chiplets. IIRC, cpu_coregroup_mask was changed
    to select the smallest of LLC, socket siblings, and NUMA node siblings
    to ensure that the sched domain we build for the MC layer isn't larger
    than the DIE above it or it's shrunk to the socket or NUMA node if LLC
    exist across NUMA node/chiplets.

   But overtime, we have patched cpu_coregroup_mask to workaround things
   which I think is now about to break 🙁.

--
Regards,
Sudeep
