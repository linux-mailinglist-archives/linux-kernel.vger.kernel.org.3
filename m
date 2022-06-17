Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0C54FCE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiFQSYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiFQSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:24:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3557E19FB9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0966B82815
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F62AC3411B;
        Fri, 17 Jun 2022 18:24:39 +0000 (UTC)
Date:   Fri, 17 Jun 2022 19:24:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: errata: add detection for AMEVCNTR01 incrementing
 incorrectly
Message-ID: <YqzG47X3oQYSEJmn@arm.com>
References: <20220607125340.13635-1-ionela.voinescu@arm.com>
 <YqN1kJlIkhNAEl/K@arm.com>
 <YqiQYikYTFVPE8GG@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqiQYikYTFVPE8GG@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:42:58PM +0100, Ionela Voinescu wrote:
> On Friday 10 Jun 2022 at 17:47:12 (+0100), Catalin Marinas wrote:
> > On Tue, Jun 07, 2022 at 01:53:40PM +0100, Ionela Voinescu wrote:
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 42ea2bd856c6..b9e4b2bd2c63 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -1791,6 +1791,19 @@ int get_cpu_with_amu_feat(void)
> > >  	return cpumask_any(&amu_cpus);
> > >  }
> > >  
> > > +bool cpu_has_broken_amu_constcnt(void)
> > > +{
> > > +	/* List of CPUs which have broken AMEVCNTR01 (constant counter) */
> > > +	static const struct midr_range cpus[] = {
> > > +#ifdef CONFIG_ARM64_ERRATUM_2457168
> > > +		MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
> > > +#endif
> > > +		{},
> > > +	};
> > > +
> > > +	return is_midr_in_range(read_cpuid_id(), cpus);
> > > +}
> > 
> > I'd rather not have this in cpufeature.c as it's not really a feature.
> > We have some precedent with checking errata in cpufeature.c but IIRC we
> > did that only to check whether to enable a feature or not in that file
> > (DBM).
> 
> If it's okay with you I can move this to cpu_errata.c:arm64_errata[], but
> the type of the capability would have to be
> ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE. I see there are other workarounds
> like this so I hope it's not a problem.

I think this should work. If you want to make a per-CPU decision,
instead of checking cpus_have_const_cap(), use this_cpu_has_cap(). It
would read the actual CPU regs pretty much like your
cpu_has_broken_amu_constcnt() but at least is more unified with the
errata framework.

-- 
Catalin
