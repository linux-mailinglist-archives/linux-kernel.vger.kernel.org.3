Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C949D682
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiA0ACQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiA0ACP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:02:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA8CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 16:02:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C23B5B820CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DCC340E3;
        Thu, 27 Jan 2022 00:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643241732;
        bh=cq0DVYygYcFPgwWbVB8dYungBY5KZjqHLmWasHTmGMQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AyHOofCsobnVqX9pVrabkd+9Mmz1yehSislqrb3+RXEsPK48tFz8EVL4MvjIHNmmA
         8BumCLjuJ+vPWJlnN/33dvG/2En2Pk1AHHEdPlJtOPPwyQj76YVSRvtGq19tSomOTw
         qPa+YpvTfW9zOL6RYjBwn3GcFoJeNW2G4ZizXZKwWHGG7IX/yaEca692zh+2okXsPv
         Ez3YlV7tTS6XDdXbasfHlqH3UcJjzfcglJrco/h1mUzqu6oFcufvHoFNIIvgtAj3Cu
         faEaz1Y89Q3i1KJVL15A0agQ+TeRvPWhZo7JXvJA9FzHLUi8+o9n+fzpjDo08TLfdh
         vgpCbiVOzlT1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 309455C043B; Wed, 26 Jan 2022 16:02:12 -0800 (PST)
Date:   Wed, 26 Jan 2022 16:02:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild] [ammarfaizi2-block:paulmck/linux-rcu/dev 80/83]
 kernel/rcu/srcutree.c:1426 srcu_torture_stats_print() error: buffer overflow
 'srcu_size_state_name' 10 <= 10
Message-ID: <20220127000212.GA4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202201261439.SqXHa4LN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201261439.SqXHa4LN-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 10:35:36AM +0300, Dan Carpenter wrote:
> tree:   https://github.com/ammarfaizi2/linux-block  paulmck/linux-rcu/dev
> head:   1063f4620dd3242633b35487e08e159b803f717b
> commit: 6d5d02daa5c0173da1c5430352dca9ab3f4fd8b5 [80/83] srcu: Make rcutorture dump the SRCU size state
> config: x86_64-randconfig-m001-20220124 (https://download.01.org/0day-ci/archive/20220126/202201261439.SqXHa4LN-lkp@intel.com/config )
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> kernel/rcu/srcutree.c:1426 srcu_torture_stats_print() error: buffer overflow 'srcu_size_state_name' 10 <= 10
> 
> vim +/srcu_size_state_name +1426 kernel/rcu/srcutree.c
> 
> aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1415  void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
> 115a1a5285664f Paul E. McKenney 2017-05-22  1416  {
> 115a1a5285664f Paul E. McKenney 2017-05-22  1417  	int cpu;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1418  	int idx;
> ac3748c6042660 Paul E. McKenney 2017-05-22  1419  	unsigned long s0 = 0, s1 = 0;
> 6d5d02daa5c017 Paul E. McKenney 2022-01-24  1420  	int ss_state = READ_ONCE(ssp->srcu_size_state);
> 6d5d02daa5c017 Paul E. McKenney 2022-01-24  1421  	int ss_state_idx = ss_state;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1422  
> aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1423  	idx = ssp->srcu_idx & 0x1;
> 6d5d02daa5c017 Paul E. McKenney 2022-01-24  1424  	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
> 6d5d02daa5c017 Paul E. McKenney 2022-01-24  1425  		ss_state_idx = ARRAY_SIZE(srcu_size_state_name);
> 
> This was supposed to be ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;

Good catch!  Fixed, and will merge into original commit with
attribution, thank you!

							Thanx, Paul

> 6d5d02daa5c017 Paul E. McKenney 2022-01-24 @1426  	pr_alert("%s%s Tree SRCU g%ld state %d (%s) per-CPU(idx=%d):",
> 6d5d02daa5c017 Paul E. McKenney 2022-01-24  1427  		 tt, tf, rcu_seq_current(&ssp->srcu_gp_seq), ss_state,
> 6d5d02daa5c017 Paul E. McKenney 2022-01-24  1428  		 srcu_size_state_name[ss_state_idx], idx);
> 115a1a5285664f Paul E. McKenney 2017-05-22  1429  	for_each_possible_cpu(cpu) {
> 115a1a5285664f Paul E. McKenney 2017-05-22  1430  		unsigned long l0, l1;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1431  		unsigned long u0, u1;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1432  		long c0, c1;
> 5ab07a8df4d6c9 Paul E. McKenney 2018-05-22  1433  		struct srcu_data *sdp;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1434  
> aacb5d91ab1bfb Paul E. McKenney 2018-10-28  1435  		sdp = per_cpu_ptr(ssp->sda, cpu);
> b68c6146512d92 Paul E. McKenney 2020-01-03  1436  		u0 = data_race(sdp->srcu_unlock_count[!idx]);
> b68c6146512d92 Paul E. McKenney 2020-01-03  1437  		u1 = data_race(sdp->srcu_unlock_count[idx]);
> 115a1a5285664f Paul E. McKenney 2017-05-22  1438  
> 115a1a5285664f Paul E. McKenney 2017-05-22  1439  		/*
> 115a1a5285664f Paul E. McKenney 2017-05-22  1440  		 * Make sure that a lock is always counted if the corresponding
> 115a1a5285664f Paul E. McKenney 2017-05-22  1441  		 * unlock is counted.
> 115a1a5285664f Paul E. McKenney 2017-05-22  1442  		 */
> 115a1a5285664f Paul E. McKenney 2017-05-22  1443  		smp_rmb();
> 115a1a5285664f Paul E. McKenney 2017-05-22  1444  
> b68c6146512d92 Paul E. McKenney 2020-01-03  1445  		l0 = data_race(sdp->srcu_lock_count[!idx]);
> b68c6146512d92 Paul E. McKenney 2020-01-03  1446  		l1 = data_race(sdp->srcu_lock_count[idx]);
> 115a1a5285664f Paul E. McKenney 2017-05-22  1447  
> 115a1a5285664f Paul E. McKenney 2017-05-22  1448  		c0 = l0 - u0;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1449  		c1 = l1 - u1;
> 7e210a653ec944 Paul E. McKenney 2019-06-28  1450  		pr_cont(" %d(%ld,%ld %c)",
> 7e210a653ec944 Paul E. McKenney 2019-06-28  1451  			cpu, c0, c1,
> 7e210a653ec944 Paul E. McKenney 2019-06-28  1452  			"C."[rcu_segcblist_empty(&sdp->srcu_cblist)]);
> ac3748c6042660 Paul E. McKenney 2017-05-22  1453  		s0 += c0;
> ac3748c6042660 Paul E. McKenney 2017-05-22  1454  		s1 += c1;
> 115a1a5285664f Paul E. McKenney 2017-05-22  1455  	}
> ac3748c6042660 Paul E. McKenney 2017-05-22  1456  	pr_cont(" T(%ld,%ld)\n", s0, s1);
> e3ec4a4e8733d5 Paul E. McKenney 2022-01-24  1457  	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC); // @@@
> 115a1a5285664f Paul E. McKenney 2017-05-22  1458  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
> _______________________________________________
> kbuild mailing list -- kbuild@lists.01.org
> To unsubscribe send an email to kbuild-leave@lists.01.org
> 
