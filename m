Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEAB4CD575
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiCDNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCDNuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:50:35 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A019151C4A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HNYcvu5d6yHupXGxSdG8Lr5gBTdXYlSzilra3zCEZPM=; b=cxoGm8nC+jabu8Ld10yyV0RWmH
        JCCFYkwBvfbWiJhoKBoIZZn03ZJNgNbVC+UlubluJ2gvG5+yWol8ZZ2Jy7yMNnYYiEYpqYmOUb+r+
        OVvgkMiSCDOyuJQRloMv8ZCO8G9+CluXX6yNk/6C+ylMxyykLQ2q6fCfKUJj+fH6EJ21Od9yOLiZI
        PH3ng8dl5r1oAQ0d4YPQkHb4qymDQLc0BPR6ZlsRDUKwwSqnJ25CAoxCsBPu2QThbicbPDl9t4jeI
        ksY3q1oHkEt3H+A+01zl/fGl2RVsg+pB7VMKjaAVCKQpdZcddKzq7PiqwPywC3J++q58h28dUEty3
        PJPYPNcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ8JB-00FCiw-1T; Fri, 04 Mar 2022 13:49:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 029F8300242;
        Fri,  4 Mar 2022 14:49:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E002E2019A5EC; Fri,  4 Mar 2022 14:49:23 +0100 (CET)
Date:   Fri, 4 Mar 2022 14:49:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/topology: Remove redundant variable and fix
 incorrect type in build_sched_domains
Message-ID: <YiIY48HK+DceO5gq@hirez.programming.kicks-ass.net>
References: <20220218162743.1134-1-kprateek.nayak@amd.com>
 <87k0d9510z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0d9510z.mognet@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 12:56:44PM +0000, Valentin Schneider wrote:
> On 18/02/22 21:57, K Prateek Nayak wrote:
> > While investigating the sparse warning reported by the LKP bot [1],
> > observed that we have a redundant variable "top" in the function
> > build_sched_domains that was introduced in the recent commit
> > e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when
> > SD_NUMA spans multiple LLCs")
> >
> > The existing variable "sd" suffices which allows us to remove the
> > redundant variable "top" while annotating the other variable "top_p"
> > with the "__rcu" annotation to silence the sparse warning.
> >
> > [1] https://lore.kernel.org/lkml/202202170853.9vofgC3O-lkp@intel.com/
> >
> > Fixes: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance when SD_NUMA spans multiple LLCs")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> >  kernel/sched/topology.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index e6cd55951304..4b757fb8f661 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2255,7 +2255,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >
> >                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> >                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > -				struct sched_domain *top, *top_p;
> > +				struct sched_domain __rcu *top_p;
> >                               unsigned int nr_llcs;
> >
> >                               /*
> > @@ -2280,11 +2280,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >                               sd->imb_numa_nr = imb;
> >
> >                               /* Set span based on the first NUMA domain. */
> > -				top = sd;
> > -				top_p = top->parent;
> > +				top_p = sd->parent;
> >                               while (top_p && !(top_p->flags & SD_NUMA)) {
> > -					top = top->parent;
> > -					top_p = top->parent;
> > +					top_p = top_p->parent;
> >                               }
> >                               imb_span = top_p ? top_p->span_weight : sd->span_weight;
> 
> 
> So sd starts as the first domain without SD_SHARE_PKG_RESOURCES (but its
> direct child has it), and the loop searches upward for a NUMA domain. This
> indeed shouldn't require two variables.
> 
> I was going to say that while you're at it, you could init top_p to sd
> rather than sd->parent in case someone runs a non-default
> sched_domain_topology[], but NODE should have neither
> SD_SHARE_PKG_RESOURCES nor SD_NUMA, so that doesn't seem required.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!
