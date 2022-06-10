Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5954638A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbiFJK2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbiFJK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:28:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07A21DFB7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:27:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2B6E12FC;
        Fri, 10 Jun 2022 03:27:58 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5DFF3F766;
        Fri, 10 Jun 2022 03:27:56 -0700 (PDT)
Date:   Fri, 10 Jun 2022 11:27:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 15/16] arch_topology: Set cluster identifier in each
 core/thread from /cpu-map
Message-ID: <20220610102753.virkx47uyfsojol6@bogus>
References: <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com>
 <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com>
 <20220525081416.3306043-14-sudeep.holla@arm.com>
 <20220525081416.3306043-15-sudeep.holla@arm.com>
 <20220525081416.3306043-16-sudeep.holla@arm.com>
 <947470ba-35fc-3c72-d01b-c0a7337216a2@arm.com>
 <20220606102159.dduxmvq4m2fm6gks@bogus>
 <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB8iPzEXipsJqNtd9-aJMKx-FAaiGMzOg58HgRQuo39iA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 12:08:44PM +0200, Vincent Guittot wrote:
> On Mon, 6 Jun 2022 at 12:22, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >

[...]

> > Why ? Are you suggesting that we shouldn't present the hardware cluster
> > to the topology because of the above reason ? If so, sorry that is not a
> > valid reason. We could add login to return NULL or appropriate value
> > needed in cpu_clustergroup_mask id it matches MC level mask if we can't
> > deal that in generic scheduler code. But the topology code can't be
> > compromised for that reason as it is user visible.
> 
> I tend to agree with Dietmar. The legacy use of cluster node in DT
> refers to the dynamiQ or legacy b.L cluster which is also aligned to
> the LLC and the MC scheduling level. The new cluster level that has
> been introduced recently does not target this level but some
> intermediate levels either inside like for the kupeng920 or the v9
> complex or outside like for the ampere altra. So I would say that
> there is one cluster node level in DT that refers to the same MC/LLC
> level and only an additional child/parent cluster node should be used
> to fill the clustergroup_mask.
>

Again I completely disagree. Let us look at the problems separately.
The hardware topology that some of the tools like lscpu and lstopo expects
what the hardware looks like and not the scheduler's view of the hardware.
So the topology masks that gets exposed to the user-space needs fixing
even today. I have reports from various tooling people about the same.
E.g. Juno getting exposed as dual socket system is utter non-sense.

Yes scheduler uses most of the topology masks as is but that is not a must.
There are these *group_mask functions that can implement what scheduler
needs to be fed.

I am not sure why the 2 issues are getting mixed up and that is the main
reason why I jumped into this to make sure the topology masks are
not tampered based on the way it needs to be used for scheduler.

Both ACPI and DT on a platform must present exact same hardware topology
to the user-space, there is no space for argument there.

> IIUC, we don't describe the dynamiQ level in ACPI which  uses cache
> topology instead to define cpu_coregroup_mask whereas DT described the
> dynamiQ instead of using cache topology. If you use cache topology
> now, then you should skip the dynamiQ
>

Yes, unless someone can work out a binding to represent that and convince
DT maintainers ;).

> Finally, even if CLS and MC have the same scheduling behavior for now,
> they might ends up with different scheduling properties which would
> mean that replacing MC level by CLS one for current SoC would become
> wrong
>

Again as I mentioned to Dietmar, that is something we can and must deal with
in those *group_mask and not expect topology mask to be altered to meet
CLS/MC or whatever sched domains needs. Sorry, that is my strong opinion
as the topology is already user-space visible and (tooling) people are
complaining that DT systems are broken and doesn't match ACPI systems.

So unless someone gives me non-scheduler and topology specific reasons
to change that, sorry but my opinion on this matter is not going to change ;).

You will get this view of topology, find a way to manage with all those
*group_mask functions. By the way it is already handled for ACPI systems,
so if you are not happy with that, then that needs fixing as this change
set just aligns the behaviour on similar ACPI system. So the Juno example
is incorrect for the reason that the behaviour of scheduler there is different
with DT and ACPI.

--
Regards,
Sudeep
