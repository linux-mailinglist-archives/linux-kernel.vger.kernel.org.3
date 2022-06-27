Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9027855C47F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbiF0U7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiF0U7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:59:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D125FC7;
        Mon, 27 Jun 2022 13:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4FD9617B9;
        Mon, 27 Jun 2022 20:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17655C34115;
        Mon, 27 Jun 2022 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656363549;
        bh=IwJ0CC/Vj6OL7cqtOj68jFfnXHtLikaHxffslXL7QKM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NEZbbKPdh/+XjDaRuZHmG3M8+RTApW/KGSSyd/1S2bnKgYHwAZBMlPEzM1dfuvvy3
         jX+Az+0lNPLv/1bf9wiwk2Ti/WleKjJ6+Q8T32/b6oy928BhhhNmb5FIbQqLq99kmq
         k9F13ldNorsGovIr6dbFfGIEP8Q0JrctxA1Hpv0O5QVP0rXi1tzXQ9xk8oKi+GJKe1
         SVQcbXKPPUORPzYhJAeSW8z/IEbwDoGSHgpcll3+Y2V2aixliajikPc6mbdajsWfZK
         /4Wag6ZtKGPO20VGucK24r5W785YnE7BK6L2Bkwx+dS1d72vNaD5sdenHuAAH35dPz
         IBswkBlGs0ahA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB8475C04B1; Mon, 27 Jun 2022 13:59:07 -0700 (PDT)
Date:   Mon, 27 Jun 2022 13:59:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org
Subject: Re: [PATCH v2 8/8] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <20220627205907.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-10-joel@joelfernandes.org>
 <Yrn9a5pOvhvL/eZj@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrn9a5pOvhvL/eZj@pc638.lan>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 08:56:43PM +0200, Uladzislau Rezki wrote:
> > As per the comments in include/linux/shrinker.h, .count_objects callback
> > should return the number of freeable items, but if there are no objects
> > to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> > should be when we are unable to determine the number of objects, or the
> > cache should be skipped for another reason.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 711679d10cbb..935788e8d2d7 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3722,7 +3722,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >  		atomic_set(&krcp->backoff_page_cache_fill, 1);
> >  	}
> >  
> > -	return count;
> > +	return count == 0 ? SHRINK_EMPTY : count;
> >  }
> >  
> >  static unsigned long
> > -- 
> > 2.37.0.rc0.104.g0611611a94-goog
> > 
> Looks good to me!
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Now that you mention it, this does look independent of the rest of
the series.  I have pulled it in with Uladzislau's Reviewed-by.

							Thanx, Paul
