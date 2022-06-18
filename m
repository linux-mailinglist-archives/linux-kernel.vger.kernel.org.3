Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2486F55059C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiFRO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiFRO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 10:57:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8C1A06A;
        Sat, 18 Jun 2022 07:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB76608D4;
        Sat, 18 Jun 2022 14:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987BFC3411A;
        Sat, 18 Jun 2022 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655564219;
        bh=NMcZ+TIlHzsocox4f4AZvLmGtBRqPwvJ9m5NXVjAR0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gRQ0zsfkthzj94J+z8Lb+rmVHFs6nifCsJhsPsvsHk6wNNcku+5RS5y0NAuFMvDf+
         fDFXUvLgkMyBuWunhndbM+3Pe/LBV0cW8zDlDDR/HupXU2z8dhzQa7joUyRZWhSVMl
         0B84j2BWXPrVUw8IRla5NvA6CVd/+B5mgu/wRyKsNG4pGoXeIGD+dBY5FSLFZnTm0B
         oW8RlGVJWnAioFtDs1cwyaPuyBB0GJR2a0EZ2IYBrYwGg5ONNn5+tVWnkUIkMim9lZ
         pKiWjC7ivMKJBL64hQCqARltde+q/Et4MGmg77QHsiFeWdhyPzvKC6wghfKeDJrGxF
         1/9YV8/87ofYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3E0275C03A7; Sat, 18 Jun 2022 07:56:59 -0700 (PDT)
Date:   Sat, 18 Jun 2022 07:56:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Avoid strict QS reporting in NMI context
Message-ID: <20220618145659.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220618022255.1697816-1-qiang1.zhang@intel.com>
 <CAFTL4hybOuURQD6LdxNiSShkvVT=qJ3_5qA59dOJ_47o9WEWYA@mail.gmail.com>
 <PH0PR11MB5880465364ADD3E4637D8077DAAE9@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB5880465364ADD3E4637D8077DAAE9@PH0PR11MB5880.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 12:15:23PM +0000, Zhang, Qiang1 wrote:
> Le sam. 18 juin 2022, 04:23, Zqiang <qiang1.zhang@intel.com<mailto:qiang1.zhang@intel.com>> a écrit :
> Avoid invoke rcu_report_qs_rdp() in NMI handlers, in NMI handlers,
> acquiring raw_spinlocks should be avoided, prevent NMI handlers
> from blocking(spin) unnecessarily.
> 
> This commit make rcu_read_unlock_strict() early return when in
> NMI context.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com<mailto:qiang1.zhang@intel.com>>
> ---
>  kernel/rcu/tree_plugin.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dc78726b993f..e7a36e248a8a 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -821,7 +821,7 @@ void rcu_read_unlock_strict(void)
>  {
>         struct rcu_data *rdp;
> 
> -       if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> +       if (in_nmi() || irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
> 
> >Doesn't preempt_count() imply in_nmi()?
> >
> 
> 
> 
> It looks like this, thanks Frederic
> 
> #define nmi_count()     (preempt_count() & NMI_MASK)
> #define in_nmi()                (nmi_count())
> 
> Hi Paul, sorry it’s my mistake.

Thank you both for catching this!

I clearly should not be reviewing incoming patches late on Friday
evening!

							Thanx, Paul

> >Thanks.
> 
>                 return;
>         rdp = this_cpu_ptr(&rcu_data);
>         rdp->cpu_no_qs.b.norm = false;
> --
> 2.25.1
