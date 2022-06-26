Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D396D55AED3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiFZERp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiFZERn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:17:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB9312D19;
        Sat, 25 Jun 2022 21:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D194DCE0FC4;
        Sun, 26 Jun 2022 04:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E139DC341CB;
        Sun, 26 Jun 2022 04:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656217059;
        bh=xrxuxGJVnvO6baw9zz/9Hmh1xOdxPxrG0WENvB/Y4Uk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BUNTmssYLmqfJWd92OYhVv2RVAYBB+dnRov3YcHBpPA+4v3bDXT5C9tS/kyY9IkSV
         IuE083QDjKeW1Sg7q1ZDlvbo+WdJW0VaSZb1E2afuE1PszEttY9K/e1DtuKdPVZAYO
         6vjVjr19nYDdyjMR3OYT5LBIWW3k3kz+iMbOCNyNpNMqmrR5aD8Vdupg9NqmGeZsgz
         mIYah2mLlehg00oYVp17GgNjBekoM9AgGe8+eI+tnyXK0hG6DCqS17DmIqOohtjIXO
         Y1H/c63usbFPod7B9MpOV5j9GDV6SYp2OfF8kbjXRU0tyivXQHlPcM+8nBQfI9NXL1
         /pJfw416F8nUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8567D5C0260; Sat, 25 Jun 2022 21:17:38 -0700 (PDT)
Date:   Sat, 25 Jun 2022 21:17:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <20220626041738.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622225102.2112026-10-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 10:51:02PM +0000, Joel Fernandes (Google) wrote:
> As per the comments in include/linux/shrinker.h, .count_objects callback
> should return the number of freeable items, but if there are no objects
> to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> should be when we are unable to determine the number of objects, or the
> cache should be skipped for another reason.

Good catch!

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 711679d10cbb..935788e8d2d7 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  		atomic_set(&krcp->backoff_page_cache_fill, 1);
>  	}
>  
> -	return count;
> +	return count == 0 ? SHRINK_EMPTY : count;
>  }
>  
>  static unsigned long
> -- 
> 2.37.0.rc0.104.g0611611a94-goog
> 
