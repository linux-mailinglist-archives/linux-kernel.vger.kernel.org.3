Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400874ACDA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbiBHBI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiBHA2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:28:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37A3C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:28:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60C9E60C81
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46A3C004E1;
        Tue,  8 Feb 2022 00:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644280086;
        bh=NUX/W0BW1/5gPfD/6xGafoiQopd/QpzHJNHSOktk44w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o7VOPFdocxEFjeVipVRlj5W3Mu7abDq+fOfucIX9RxNG9cRKVxAKAM0VsPVzz+X+4
         c8ju1lW6w/MB3bKP2+uW+LHGpIr0t6eFvzMikc7D4L8ver5qMwboxy9Koon30xS6xl
         ENXe2rGvOJd15CBRRwJVKVQs6TnJW6plizH7eHWfWLirfJW43plfnrVjgCLuE/oeOi
         33TdCdBaG9Drd7j/6S9vYtWi2cKHfRJA+Dc15W7uKvLpChmg7OQDTaOuB3KVx5zOU8
         C5k7Yig3F2+3yvBJd/dv2o9l56Vx8vhgmZlTNB2wYherc7WV3No67ZrzjRuqG2hcTN
         /CZARcLczoPUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B1A35C0348; Mon,  7 Feb 2022 16:28:06 -0800 (PST)
Date:   Mon, 7 Feb 2022 16:28:06 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/dev 18/18]
 mm/slab_common.c:336:23: sparse: sparse: restricted slab_flags_t degrades to
 integer
Message-ID: <20220208002806.GJ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202202070951.I9Vhb0aQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202070951.I9Vhb0aQ-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:23:47AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/dev
> head:   e6e0d15aa1c5117dda15eb266e8b862627af7608
> commit: e6e0d15aa1c5117dda15eb266e8b862627af7608 [18/18] mm: Check for SLAB_TYPESAFE_BY_RCU and __GFP_ZERO slab creation
> config: m68k-randconfig-s032-20220206 (https://download.01.org/0day-ci/archive/20220207/202202070951.I9Vhb0aQ-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://github.com/ammarfaizi2/linux-block/commit/e6e0d15aa1c5117dda15eb266e8b862627af7608
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/dev
>         git checkout e6e0d15aa1c5117dda15eb266e8b862627af7608
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> mm/slab_common.c:336:23: sparse: sparse: restricted slab_flags_t degrades to integer
> >> mm/slab_common.c:336:46: sparse: sparse: restricted gfp_t degrades to integer

Good catch!  I really did get the various flags confused.  :-/

Will fix with attribution.

							Thanx, Paul

>    mm/slab_common.c:336:14: sparse: sparse: restricted slab_flags_t degrades to integer
>    mm/slab_common.c:336:63: sparse: sparse: restricted slab_flags_t degrades to integer
>    mm/slab_common.c:336:86: sparse: sparse: restricted gfp_t degrades to integer
> 
> vim +336 mm/slab_common.c
> 
>    321	
>    322		mutex_lock(&slab_mutex);
>    323	
>    324		err = kmem_cache_sanity_check(name, size);
>    325		if (err) {
>    326			goto out_unlock;
>    327		}
>    328	
>    329		/* Refuse requests with allocator specific flags */
>    330		if (flags & ~SLAB_FLAGS_PERMITTED) {
>    331			err = -EINVAL;
>    332			goto out_unlock;
>    333		}
>    334	
>    335		/* References to typesafe memory survives free/alloc. */
>  > 336		if ((flags & (SLAB_TYPESAFE_BY_RCU | __GFP_ZERO)) == (SLAB_TYPESAFE_BY_RCU | __GFP_ZERO)) {
>    337			err = -EINVAL;
>    338			goto out_unlock;
>    339		}
>    340	
>    341		/*
>    342		 * Some allocators will constraint the set of valid flags to a subset
>    343		 * of all flags. We expect them to define CACHE_CREATE_MASK in this
>    344		 * case, and we'll just provide them with a sanitized version of the
>    345		 * passed flags.
>    346		 */
>    347		flags &= CACHE_CREATE_MASK;
>    348	
>    349		/* Fail closed on bad usersize of useroffset values. */
>    350		if (WARN_ON(!usersize && useroffset) ||
>    351		    WARN_ON(size < usersize || size - usersize < useroffset))
>    352			usersize = useroffset = 0;
>    353	
>    354		if (!usersize)
>    355			s = __kmem_cache_alias(name, size, align, flags, ctor);
>    356		if (s)
>    357			goto out_unlock;
>    358	
>    359		cache_name = kstrdup_const(name, GFP_KERNEL);
>    360		if (!cache_name) {
>    361			err = -ENOMEM;
>    362			goto out_unlock;
>    363		}
>    364	
>    365		s = create_cache(cache_name, size,
>    366				 calculate_alignment(flags, align, size),
>    367				 flags, useroffset, usersize, ctor, NULL);
>    368		if (IS_ERR(s)) {
>    369			err = PTR_ERR(s);
>    370			kfree_const(cache_name);
>    371		}
>    372	
>    373	out_unlock:
>    374		mutex_unlock(&slab_mutex);
>    375	
>    376		if (err) {
>    377			if (flags & SLAB_PANIC)
>    378				panic("%s: Failed to create slab '%s'. Error %d\n",
>    379					__func__, name, err);
>    380			else {
>    381				pr_warn("%s(%s) failed with error %d\n",
>    382					__func__, name, err);
>    383				dump_stack();
>    384			}
>    385			return NULL;
>    386		}
>    387		return s;
>    388	}
>    389	EXPORT_SYMBOL(kmem_cache_create_usercopy);
>    390	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
