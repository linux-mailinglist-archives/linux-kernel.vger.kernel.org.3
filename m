Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C8B52EC35
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbiETMd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349362AbiETMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:33:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2D8E163F6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:33:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3916A1477;
        Fri, 20 May 2022 05:33:31 -0700 (PDT)
Received: from [172.29.1.145] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629363F718;
        Fri, 20 May 2022 05:33:28 -0700 (PDT)
Message-ID: <26f39a9d-1a02-b77d-5c89-88a1fb0e4eac@arm.com>
Date:   Fri, 20 May 2022 14:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/8] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-4-sudeep.holla@arm.com> <YoZ2gjjS3rbRaJZm@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <YoZ2gjjS3rbRaJZm@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2022 18:55, Ionela Voinescu wrote:
> Hi,
> 
> As said before, this creates trouble for CONFIG_SCHED_CLUSTER=y.
> The output below is obtained from Juno.
> 
> When cluster_id is populated, a new CLS level is created by the scheduler
> topology code. In this case the clusters in DT determine that the cluster
> siblings and llc siblings are the same so the MC scheduler domain will
> be removed and, for Juno, only CLS and DIE will be kept.

[...]

> To be noted that we also get a new flag SD_PREFER_SIBLING for the CLS
> level that is not appropriate. We usually remove it for the child of a
> SD_ASYM_CPUCAPACITY domain, but we don't currently redo this after some
> levels are degenerated. This is a fixable issue.
> 
> But looking at the bigger picture, a good question is what is the best
> thing to do when cluster domains and llc domains span the same CPUs?
> 
> Possibly it would be best to restrict clusters (which are almost an
> arbitrary concept) to always span a subset of CPUs of the llc domain,
> if llc siblings can be obtained? If those clusters are not properly set
> up in DT to respect this condition, cluster_siblings would need to be
> cleared (or set to the current CPU) so the CLS domain is not created at
> all.
> 
> Additionally, should we use cluster information from DT (cluster_id) to
> create an MC level if we don't have llc information, even if
> CONFIG_SCHED_CLUSTER=n?
> 
> I currently don't have a very clear picture of how cluster domains and
> llc domains would "live" together in a variety of topologies. I'll try
> other DT topologies to see if there are others that can lead to trouble.

This would be an issue. Depending on CONFIG_SCHED_CLUSTER we would get
two different systems from the viewpoint of the scheduler.

To me `cluster_id/_sibling` don't describe a certain level of CPU
grouping (e.g. one level above core or one level below package).

They were introduced to describe one level below LLC (e.g. Kunpeng920 L3
(24 CPUs LLC) -> L3 tag (4 CPUs) or x86 Jacobsville L3 -> L2), (Commit
                 ^^^^^^                                   ^^
c5e22feffdd7 ("topology: Represent clusters of CPUs within a die")).

The Ampere Altra issue already gave us a taste of the possible issues of
this definition, commit db1e59483dfd ("topology: make core_mask include
at least cluster_siblings").

If we link `cluster_id/_sibling` against (1. level) cpu-map cluster
nodes plus using llc and `cluster_sibling >= llc_sibling` we will run
into these issues.
