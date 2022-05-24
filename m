Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E21C5332A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiEXUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbiEXUvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446211C93E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C70316171F
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D2CC34100;
        Tue, 24 May 2022 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653425485;
        bh=3eQ2hBlWGUpOpUNaEJFu6V++Da8u1SCVIXJFCtpyb9A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ifSN5L5tItZR9IYTJIwvgBDiIsbIVjNt9LHLdLyNwrBBbmTU4DstIJI9sWZaGlM+r
         KRRKs2ghOQoL5VnXpiDZJN1+MxG6qt3R6ypZCwGT7rOhJ4yIOBkyVOhCzUX2XKZ7zu
         XNKBLM7rRmfyB4P9sFnNAFZ4EgmffPAdUZmpANAft6HyYC9gprauHjYs45wOlUiLmw
         AGEOD4H0QRwXXKQbduXJWfhj6CEW0hxAEUTNfoGr9/l9z42s13KM3NpXdQ3sjD929I
         19Oo/5O78W1MPB62pqFWN8bzioDfCDvTE/AvmH2DXogw9Qm0CJc49S0yN1BQCzN0+/
         nrHsePNFDQVxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CF6BE5C0A31; Tue, 24 May 2022 13:51:24 -0700 (PDT)
Date:   Tue, 24 May 2022 13:51:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes
 address space '__rcu' of expression
Message-ID: <20220524205124.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202205222029.xpW3PM1y-lkp@intel.com>
 <87y1yspmmh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1yspmmh.fsf@toke.dk>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 12:30:14PM +0200, Toke Høiland-Jørgensen wrote:
> kernel test robot <lkp@intel.com> writes:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
> > commit: 782347b6bcad07ddb574422e01e22c92e05928c8 xdp: Add proper __rcu annotations to redirect map entries
> > date:   11 months ago
> > config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205222029.xpW3PM1y-lkp@intel.com/config)
> > compiler: ia64-linux-gcc (GCC) 11.3.0
> 
> Hmm, so this is ia64-only? Some kind of macro breakage? Paul, any ideas?

Line 1030 looks to me like it is doing everything correctly.  I am not
sure why sparse would care about the architecture, but perhaps it does.
The unrcu_pointer() macro has not changed since March of 2020.

All I can suggest is to break that line up to make it easier to figure
out exactly what sparse is upset about.

							Thanx, Paul

> -Toke
> 
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-dirty
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=782347b6bcad07ddb574422e01e22c92e05928c8
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 782347b6bcad07ddb574422e01e22c92e05928c8
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/bpf/
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >    kernel/bpf/devmap.c:561:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_dtab_netdev *dst @@     got struct bpf_dtab_netdev [noderef] __rcu * @@
> >    kernel/bpf/devmap.c:561:29: sparse:     expected struct bpf_dtab_netdev *dst
> >    kernel/bpf/devmap.c:561:29: sparse:     got struct bpf_dtab_netdev [noderef] __rcu *
> >    kernel/bpf/devmap.c:657:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_dtab_netdev *dst @@     got struct bpf_dtab_netdev [noderef] __rcu * @@
> >    kernel/bpf/devmap.c:657:29: sparse:     expected struct bpf_dtab_netdev *dst
> >    kernel/bpf/devmap.c:657:29: sparse:     got struct bpf_dtab_netdev [noderef] __rcu *
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
> >
> > vim +/__rcu +1030 kernel/bpf/devmap.c
> >
> >    990	
> >    991	static int dev_map_notification(struct notifier_block *notifier,
> >    992					ulong event, void *ptr)
> >    993	{
> >    994		struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> >    995		struct bpf_dtab *dtab;
> >    996		int i, cpu;
> >    997	
> >    998		switch (event) {
> >    999		case NETDEV_REGISTER:
> >   1000			if (!netdev->netdev_ops->ndo_xdp_xmit || netdev->xdp_bulkq)
> >   1001				break;
> >   1002	
> >   1003			/* will be freed in free_netdev() */
> >   1004			netdev->xdp_bulkq = alloc_percpu(struct xdp_dev_bulk_queue);
> >   1005			if (!netdev->xdp_bulkq)
> >   1006				return NOTIFY_BAD;
> >   1007	
> >   1008			for_each_possible_cpu(cpu)
> >   1009				per_cpu_ptr(netdev->xdp_bulkq, cpu)->dev = netdev;
> >   1010			break;
> >   1011		case NETDEV_UNREGISTER:
> >   1012			/* This rcu_read_lock/unlock pair is needed because
> >   1013			 * dev_map_list is an RCU list AND to ensure a delete
> >   1014			 * operation does not free a netdev_map entry while we
> >   1015			 * are comparing it against the netdev being unregistered.
> >   1016			 */
> >   1017			rcu_read_lock();
> >   1018			list_for_each_entry_rcu(dtab, &dev_map_list, list) {
> >   1019				if (dtab->map.map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
> >   1020					dev_map_hash_remove_netdev(dtab, netdev);
> >   1021					continue;
> >   1022				}
> >   1023	
> >   1024				for (i = 0; i < dtab->map.max_entries; i++) {
> >   1025					struct bpf_dtab_netdev *dev, *odev;
> >   1026	
> >   1027					dev = rcu_dereference(dtab->netdev_map[i]);
> >   1028					if (!dev || netdev != dev->dev)
> >   1029						continue;
> >> 1030					odev = unrcu_pointer(cmpxchg(&dtab->netdev_map[i], RCU_INITIALIZER(dev), NULL));
> >   1031					if (dev == odev)
> >   1032						call_rcu(&dev->rcu,
> >   1033							 __dev_map_entry_free);
> >   1034				}
> >   1035			}
> >   1036			rcu_read_unlock();
> >   1037			break;
> >   1038		default:
> >   1039			break;
> >   1040		}
> >   1041		return NOTIFY_OK;
> >   1042	}
> >   1043	
> >
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
> 
