Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B6B55AE95
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiFZEG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiFZEGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7511A20;
        Sat, 25 Jun 2022 21:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733E560FD4;
        Sun, 26 Jun 2022 04:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF4FC34114;
        Sun, 26 Jun 2022 04:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656216382;
        bh=zSlSSgtBgP8umBf1sFSKAJX5fkcYhgmW4IhmjkBOekI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JzWdlEqOBirdY5uD9VaXPv98zBxADzo99N15XagU3fLdrXKz2KAphYazs6z3HqnSF
         dk+xo8KHIov4MAuWj606xmFrIe8pg5UKTflfG1RFnY3hDVuE5Yi31PGO2lLraqaEjx
         IbAmaKNIenD5XSi/Mqm8uN1uHRhK0BbYZoCyZat7iLSFUQh5q6TwpEmMs7nDkNPKCU
         LgzF+9qE0tAExEQYFbqMvGReE5FWLgH/l/d146Ltz6CzN6WSNfJsSKZHztIQkw40M+
         XHomsp58QYKMOcqZLyfuJXV3kDQJ+aDIt5JLGQlg6yj2wUPjq+4UamZ+cu/mXrhfxt
         6BfRRTwyHm2EA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B2475C0260; Sat, 25 Jun 2022 21:06:22 -0700 (PDT)
Date:   Sat, 25 Jun 2022 21:06:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 5/8] rcu/nocb: Wake up gp thread when flushing
Message-ID: <20220626040622.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-7-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:50:59PM +0000, Joel Fernandes (Google) wrote:
> We notice that rcu_barrier() can take a really long time. It appears
> that this can happen when all CBs are lazy and the timer does not fire
> yet. So after flushing, nothing wakes up GP thread. This patch forces
> GP thread to wake when bypass flushing happens, this fixes the
> rcu_barrier() delays with lazy CBs.

I am wondering if there is a bug in non-rcu_barrier() lazy callback
processing hiding here as well?

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree_nocb.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 2f5da12811a5..b481f1ea57c0 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -325,6 +325,8 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
>  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
>  	WRITE_ONCE(rdp->nocb_bypass_first, j);
>  	rcu_nocb_bypass_unlock(rdp);
> +
> +	wake_nocb_gp(rdp, true);
>  	return true;
>  }
>  
> -- 
> 2.37.0.rc0.104.g0611611a94-goog
> 
