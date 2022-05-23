Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB48530CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiEWKag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiEWKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56A124B858
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653301822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2RFwerL9Sc2DgN6JS/HsUjSPkLJeYeYva+yAfEVyzs=;
        b=RVd9PaZhwJFcnXAvW831ngb12Dy/NUv576im1Y++gBl/4Ul0t19KOknU7Q07bY5a/8AkMR
        1SI8UuA2sN6Pm3TS0P03cEASiWZ6jXpcWACjJAHiogDki74G3h1sMLSodjv6sGh1XqZfmi
        AhHEJ5yMJhtzNqDQZxeSaAXAnEfsWcc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-jA-qrebvNtq--u_lMX5Ibw-1; Mon, 23 May 2022 06:30:21 -0400
X-MC-Unique: jA-qrebvNtq--u_lMX5Ibw-1
Received: by mail-ej1-f70.google.com with SMTP id gs6-20020a170906f18600b006fe7a9ffacbso5729956ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 03:30:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=k2RFwerL9Sc2DgN6JS/HsUjSPkLJeYeYva+yAfEVyzs=;
        b=mFyTL4OMTbEEbQd2z9PV6ajJN5Gn4iFWO5r3brEn2kp6cizqGGloqL5WMz6HdkvTL1
         CRPVnTbO0pmfFIqEEJVtScV18QIK/5Cr0PGPrxHjG72sKM5QD6a1OO3aGgKADkFZ14iJ
         wbF+aSQLtuhfKhgAAHul91iElM3O5PFopv1arv7xHhAwjd0c061Wl63aQgwF48mP3VEw
         PaTdNLV6etpSXWERjsS4WZNPN+RZ5cq0RjBLfji41KIpGmg9XqFiNqbJMejDHEAsYX5d
         gCFUulvonXaHHyrBz7OwrJv4ZGXlQvWZprY18K2Y88hsZdxzqZclu3MgTixgQaDbRqdL
         wPyw==
X-Gm-Message-State: AOAM532D7jaU6YBVnV5uAoAKAsgaNomtDi+Or+dTt72KdVtqMROejYT/
        up8UqZrjAA6QTOroMarXFPHPSVIJvYnKu5RBkkwbx7vqgioEWJximn5KmV4JOJLEQY3eWbkMpoB
        30BIsaCnNJuLra9APACZaJlCd
X-Received: by 2002:aa7:cf83:0:b0:42a:c73e:6d86 with SMTP id z3-20020aa7cf83000000b0042ac73e6d86mr23240095edx.251.1653301818436;
        Mon, 23 May 2022 03:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0JDYYmrlHCAi8CasWxnBDdZQu5GSQ0XkPgpA+67ppp73KwxrfchWk5xCz8oKQGFDp2vbDAw==
X-Received: by 2002:aa7:cf83:0:b0:42a:c73e:6d86 with SMTP id z3-20020aa7cf83000000b0042ac73e6d86mr23239940edx.251.1653301816160;
        Mon, 23 May 2022 03:30:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k24-20020a056402049800b0042aae307407sm8074117edv.21.2022.05.23.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 03:30:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A085D3DE9F1; Mon, 23 May 2022 12:30:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes
 address space '__rcu' of expression
In-Reply-To: <202205222029.xpW3PM1y-lkp@intel.com>
References: <202205222029.xpW3PM1y-lkp@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 23 May 2022 12:30:14 +0200
Message-ID: <87y1yspmmh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
> commit: 782347b6bcad07ddb574422e01e22c92e05928c8 xdp: Add proper __rcu annotations to redirect map entries
> date:   11 months ago
> config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci/archive/20220522/202205222029.xpW3PM1y-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.3.0

Hmm, so this is ia64-only? Some kind of macro breakage? Paul, any ideas?

-Toke

> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=782347b6bcad07ddb574422e01e22c92e05928c8
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 782347b6bcad07ddb574422e01e22c92e05928c8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=ia64 SHELL=/bin/bash kernel/bpf/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>    kernel/bpf/devmap.c:561:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_dtab_netdev *dst @@     got struct bpf_dtab_netdev [noderef] __rcu * @@
>    kernel/bpf/devmap.c:561:29: sparse:     expected struct bpf_dtab_netdev *dst
>    kernel/bpf/devmap.c:561:29: sparse:     got struct bpf_dtab_netdev [noderef] __rcu *
>    kernel/bpf/devmap.c:657:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct bpf_dtab_netdev *dst @@     got struct bpf_dtab_netdev [noderef] __rcu * @@
>    kernel/bpf/devmap.c:657:29: sparse:     expected struct bpf_dtab_netdev *dst
>    kernel/bpf/devmap.c:657:29: sparse:     got struct bpf_dtab_netdev [noderef] __rcu *
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>>> kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes address space '__rcu' of expression
>
> vim +/__rcu +1030 kernel/bpf/devmap.c
>
>    990	
>    991	static int dev_map_notification(struct notifier_block *notifier,
>    992					ulong event, void *ptr)
>    993	{
>    994		struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
>    995		struct bpf_dtab *dtab;
>    996		int i, cpu;
>    997	
>    998		switch (event) {
>    999		case NETDEV_REGISTER:
>   1000			if (!netdev->netdev_ops->ndo_xdp_xmit || netdev->xdp_bulkq)
>   1001				break;
>   1002	
>   1003			/* will be freed in free_netdev() */
>   1004			netdev->xdp_bulkq = alloc_percpu(struct xdp_dev_bulk_queue);
>   1005			if (!netdev->xdp_bulkq)
>   1006				return NOTIFY_BAD;
>   1007	
>   1008			for_each_possible_cpu(cpu)
>   1009				per_cpu_ptr(netdev->xdp_bulkq, cpu)->dev = netdev;
>   1010			break;
>   1011		case NETDEV_UNREGISTER:
>   1012			/* This rcu_read_lock/unlock pair is needed because
>   1013			 * dev_map_list is an RCU list AND to ensure a delete
>   1014			 * operation does not free a netdev_map entry while we
>   1015			 * are comparing it against the netdev being unregistered.
>   1016			 */
>   1017			rcu_read_lock();
>   1018			list_for_each_entry_rcu(dtab, &dev_map_list, list) {
>   1019				if (dtab->map.map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
>   1020					dev_map_hash_remove_netdev(dtab, netdev);
>   1021					continue;
>   1022				}
>   1023	
>   1024				for (i = 0; i < dtab->map.max_entries; i++) {
>   1025					struct bpf_dtab_netdev *dev, *odev;
>   1026	
>   1027					dev = rcu_dereference(dtab->netdev_map[i]);
>   1028					if (!dev || netdev != dev->dev)
>   1029						continue;
>> 1030					odev = unrcu_pointer(cmpxchg(&dtab->netdev_map[i], RCU_INITIALIZER(dev), NULL));
>   1031					if (dev == odev)
>   1032						call_rcu(&dev->rcu,
>   1033							 __dev_map_entry_free);
>   1034				}
>   1035			}
>   1036			rcu_read_unlock();
>   1037			break;
>   1038		default:
>   1039			break;
>   1040		}
>   1041		return NOTIFY_OK;
>   1042	}
>   1043	
>
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

