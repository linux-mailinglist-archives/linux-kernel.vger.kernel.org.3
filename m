Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093AB52EE8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350527AbiETO4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiETO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:56:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 549DF1737EF
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:56:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0AB51477;
        Fri, 20 May 2022 07:56:47 -0700 (PDT)
Received: from bogus (unknown [10.57.66.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 989AE3F73D;
        Fri, 20 May 2022 07:56:45 -0700 (PDT)
Date:   Fri, 20 May 2022 15:56:39 +0100
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
Subject: Re: [PATCH v2 8/8] arch_topology: Add support to build llc_sibling
 on DT platforms
Message-ID: <20220520145639.xb33e2z5otdu264y@bogus>
References: <20220518093325.2070336-1-sudeep.holla@arm.com>
 <20220518093325.2070336-9-sudeep.holla@arm.com>
 <087176fc-1018-b107-06cc-055d7926b500@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087176fc-1018-b107-06cc-055d7926b500@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:33:46PM +0200, Dietmar Eggemann wrote:
> On 18/05/2022 11:33, Sudeep Holla wrote:
> > ACPI PPTT provides cache identifiers and especially the last level cache
> > identifier is used in obtaining last level cache siblings amongst CPUs.
> > 
> > While we have the cpu map representing all the CPUs sharing last level
> > cache in the cacheinfo driver, it is populated quite late in the boot
> > while the information is needed to build scheduler domains quite early.
> > 
> > On DT platforms we can use the pointer to the last level cache as the
> > firmware identifier for the last level cache and build the cpumap sharing
> > the last level cache based on the same.
> 
> [...]
> 
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index 58cbe18d825c..d8a36b0e27c9 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -69,6 +69,7 @@ struct cpu_topology {
> >  	int cluster_id;
> >  	int package_id;
> >  	int llc_id;
> > +	void *llc_fw_node;
> 
> Would be nicer if you could set llc_id directly to avoid all this
> addition sync `llc_id and llc_fw_node` code. ACPI PPTT has this
> ACPI_PTR_DIFF() macro which IMHO lets it create distinct ids.
> 

Indeed, I initially thought so, but they are 64 bit pointers and choosing
one reference is difficult to take some sort of diff while in ACPI it is in
a static table and we could use the reference to the top of the table.

-- 
Regards,
Sudeep
