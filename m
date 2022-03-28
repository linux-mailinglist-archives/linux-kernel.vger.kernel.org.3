Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42A4E9D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbiC1RS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiC1RS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:18:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187164BE0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 891FCB8117D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3505C340F0;
        Mon, 28 Mar 2022 17:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487833;
        bh=tsHOIB8dmpEnEigOmeEzDX7+3UaF+f5tQDsXH8gievU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R+dhNRJ3fJh94YsiEAPa1fz1v7bIvyALQBN7pfBRthhbjgJBB/MVXl5gZBOQsiMlV
         VwO+I5g9NbgOzKZh0i+HOw+qKjeDKND6BAodGwsbLoQEqH98Syj8UynG/+rr6US8Uu
         j4FSxhaE/h0BO8fghQhNfSv+5SKpiq9r3JuHUTvcu+oF+f1kztqR4CznJQWopZFJ7L
         O3auhUsc+FUZoUaKW+2xQSjLd4e1yRCzmxz5S+odM3LswUuClzU2xXNxcTmUTuNKh/
         C4v+QgKdbNiA73tkI5Sqk9Z6vuknKXg36V2QT79anPX7LTPEgSBeB780JEjCX6kCDg
         dRqiMKebjRkcQ==
Date:   Mon, 28 Mar 2022 10:17:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Eric Dumazet <edumazet@google.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Brian Vazquez <brianvv@google.com>,
        linux-riscv@lists.infradead.org
Subject: Re: net/core/dev.c:10290:18: sparse: sparse: cast removes address
 space '__percpu' of expression
Message-ID: <20220328101711.111e1dd5@kernel.org>
In-Reply-To: <202203281436.hsNgYWWu-lkp@intel.com>
References: <202203281436.hsNgYWWu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: riscv, is there something special about cmpxchg() on that arch?
We don't see it on x86, and I don't see anything special in the code
for riscv, at least on 5.17.

On Mon, 28 Mar 2022 14:28:34 +0800 kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ae085d7f9365de7da27ab5c0d16b12d51ea7fca9
> commit: 625788b5844511cf4c30cffa7fa0bc3a69cebc82 net: add per-cpu storage and net->core_stats
> date:   2 weeks ago
> config: riscv-randconfig-s032-20220328 (https://download.01.org/0day-ci/archive/20220328/202203281436.hsNgYWWu-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=625788b5844511cf4c30cffa7fa0bc3a69cebc82
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 625788b5844511cf4c30cffa7fa0bc3a69cebc82
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash net/core/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    net/core/dev.c:3254:23: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned int @@
>    net/core/dev.c:3254:23: sparse:     expected restricted __wsum [usertype] csum
>    net/core/dev.c:3254:23: sparse:     got unsigned int
>    net/core/dev.c:3254:23: sparse: sparse: cast from restricted __wsum
> >> net/core/dev.c:10290:18: sparse: sparse: cast removes address space '__percpu' of expression  
>    net/core/dev.c:3759:17: sparse: sparse: context imbalance in '__dev_queue_xmit' - different lock contexts for basic block
>    net/core/dev.c:4961:17: sparse: sparse: context imbalance in 'net_tx_action' - different lock contexts for basic block
> 
> vim +/__percpu +10290 net/core/dev.c
> 
>  10282	
>  10283	struct net_device_core_stats *netdev_core_stats_alloc(struct net_device *dev)
>  10284	{
>  10285		struct net_device_core_stats __percpu *p;
>  10286	
>  10287		p = alloc_percpu_gfp(struct net_device_core_stats,
>  10288				     GFP_ATOMIC | __GFP_NOWARN);
>  10289	
>  10290		if (p && cmpxchg(&dev->core_stats, NULL, p))
>  10291			free_percpu(p);
>  10292	
>  10293		/* This READ_ONCE() pairs with the cmpxchg() above */
>  10294		p = READ_ONCE(dev->core_stats);
>  10295		if (!p)
>  10296			return NULL;
>  10297	
>  10298		return this_cpu_ptr(p);
>  10299	}
>  10300	EXPORT_SYMBOL(netdev_core_stats_alloc);
>  10301	
> 

