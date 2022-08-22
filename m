Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432B59C357
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbiHVPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbiHVPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:47:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D772E1C903
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nwi2FCCOJBDaSG2HI+eKTd2JuhwUe8xdxx17o/4Vv98=; b=NMcNa6TdgYpD2Q+tcki4aeCOXH
        wV5WLk81+Lxv6MovXCT58SKMfLwnkmeYRfu11FHc1jIGTJgNdw8gxHoi9Srwh1LlJ8zRb6u/IuB5I
        h8GcXN3kz3DwSW319gutaKmP9SyTd4LYXnOQ5UEd8RFrMzAdpeZb6oO1bVXyxQFfvSudPDdSHEYEP
        uCSft+MKng1IxRpVFUREZtN2ulejSfFXW4fMkCAceQWnjTaz2xTdswdjrbiVv/jcjT5pOR+lUoOgj
        bKa5Z7MtU477UsJ5nNS8+4fJ2UgYHUFmPk/wyfwu/je5Z1m7CmjXMflvjvjLwSB5kidJS5nfVmexf
        56N6yCHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ9dn-0057CN-Fp; Mon, 22 Aug 2022 15:47:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1369E9804A3; Mon, 22 Aug 2022 17:47:03 +0200 (CEST)
Date:   Mon, 22 Aug 2022 17:47:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        Jianfeng Gao <jianfeng.gao@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: Re: [RESEND PATCH] perf/x86/intel: Fix unchecked MSR access error
 for Alder Lake N
Message-ID: <YwOk991q0iBgcQWC@worktop.programming.kicks-ass.net>
References: <20220818181530.2355034-1-kan.liang@linux.intel.com>
 <Yv+ggf6PRjL8Eio1@worktop.programming.kicks-ass.net>
 <80eea4f7-bb1e-ebb9-37db-9317b8d9c28f@linux.intel.com>
 <YwOVJO05Ge8V9y5i@worktop.programming.kicks-ass.net>
 <c09ba37c-f685-15a3-3042-8cb3a0f91282@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09ba37c-f685-15a3-3042-8cb3a0f91282@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 05:08:55PM +0200, Andi Kleen wrote:
> 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 2db93498ff71..232e24324fd7 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4473,6 +4473,11 @@ static bool init_hybrid_pmu(int cpu)
> >   	struct x86_hybrid_pmu *pmu = NULL;
> >   	int i;
> > +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > +		pr_warn_once("hybrid PMU and virt are incompatible\n");
> > +		return false;
> > +	}
> 
> It's totally possible to virtualize hybrid correctly, so I don't think this
> is justified

With a magic incantation and a sacrificial chicken sure, but the typical
guest will not have it set up right and we'll get the kernel doing
*splat*.

So I'm going to keep this and then some virt person can provide us a new
flag for when they think the hypervisor did the right thing and exclude
themselves from this ban.
