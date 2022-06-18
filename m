Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6752B5502D1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 06:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiFREmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 00:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFREm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 00:42:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4A767D19;
        Fri, 17 Jun 2022 21:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E513609D0;
        Sat, 18 Jun 2022 04:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA9C3411A;
        Sat, 18 Jun 2022 04:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655527344;
        bh=rQkcFk/R9YGs/ifqBXHIR/cKcHOdVFJfwpY+GprTaHM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E1rSS1cK3qtIb/v+Uem0nXDRd/6Oj9XofVMPkiprN5fh0Zi8SOTbzTumRMXtWGmLc
         /HRl0bjDIqfcQCl50AlSO9DaxhK+CDJ7+qWm+kvWCYQzg3CLcZZlkQXHTLbPTyOKsC
         dO+ufolqNBAV+FWbUlZIxLDMynQvKnfpY/gkPKs6/TvJOoM81umur0MCW9y1uc47fy
         ULFSaab62TJbeZrAgYlv+7QVWlaknOzpHAFFL3bdxeLk68/Xn6X7J3N6UHK5dpsreT
         vE/xY5nysI62LUlD3IGJnOOjqEufyETSjWEjzUWLBSIVbkjOxrM2rnBqxzCHqMW0wU
         SX34IxhPE8P3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA37C5C036C; Fri, 17 Jun 2022 21:42:23 -0700 (PDT)
Date:   Fri, 17 Jun 2022 21:42:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/nocb: Correct output rcuog/rcuop kthreads
 information
Message-ID: <20220618044223.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220617141519.1677119-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617141519.1677119-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 10:15:19PM +0800, Zqiang wrote:
> This commit make rcuog and rcuop thread information output
> in the correct location.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch, queued for review and testing, thank you!

Ditto for the "rcu: Avoid reporting strict QSes from NMI context"
patch.

As always, I wordsmithed both commit logs, so please check to see if
I messed something up.

						Thanx, Paul

> ---
>  v1->v2:
>  Only change commit information, the v1 is
>  [PATCH] rcu: Fix incorrect judgment condition in show_rcu_nocb_state(). 
> 
>  kernel/rcu/tree_nocb.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index a8f574d8850d..f20aec4f4394 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1452,8 +1452,8 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
>  		(long)rdp->nocb_gp_seq,
>  		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
>  		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
> -		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> -		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
> +		rdp->nocb_gp_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> +		show_rcu_should_be_on_cpu(rdp->nocb_gp_kthread));
>  }
>  
>  /* Dump out nocb kthread state for the specified rcu_data structure. */
> @@ -1497,7 +1497,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>  		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
>  		rcu_segcblist_n_cbs(&rdp->cblist),
>  		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
> -		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
> +		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
>  		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
>  
>  	/* It is OK for GP kthreads to have GP state. */
> -- 
> 2.25.1
> 
