Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085A5112FC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359111AbiD0H4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiD0H4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1401D1430EB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F25E61B65
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F62AC385A7;
        Wed, 27 Apr 2022 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651046020;
        bh=Pf/ktYQkgNM+uaXNezoX9w8WrXd6LBiq7f1qb15s0GQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KHvuXD8keHWpilaJU04TnwGM0uWd1DPeBjGyyvHiujcG1viU8rZJnF+cJ3syskEnY
         59rI7xyfD0Oj/ndm0/oTmbIeYB562F097hBYfrCw7dzzZM41tYKi83jCCozdooki13
         SqNSnYyJK2J12lQi7+NxVBqnJ6kLwtc3/xmNbBAo=
Date:   Wed, 27 Apr 2022 09:53:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Imran Khan <imran.f.khan@oracle.com>, devel@driverdev.osuosl.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [driver-core:driver-core-testing 30/34] fs/kernfs/file.c:160:46:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <Ymj2gOGJzb4xMHol@kroah.com>
References: <202204270438.Uex7Kt3b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204270438.Uex7Kt3b-lkp@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 04:17:29AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> head:   26360a8c9732cff2ee5bc2f180e9716b63e9f650
> commit: 07b42a72474e4ab59d6acb451f7816664095d7c0 [30/34] kernfs: make ->attr.open RCU protected.
> config: alpha-randconfig-s032-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270438.Uex7Kt3b-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=07b42a72474e4ab59d6acb451f7816664095d7c0
>         git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
>         git fetch --no-tags driver-core driver-core-testing
>         git checkout 07b42a72474e4ab59d6acb451f7816664095d7c0
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash fs/kernfs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> >> fs/kernfs/file.c:160:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t [noderef] __rcu * @@
>    fs/kernfs/file.c:160:46: sparse:     expected struct atomic_t const [usertype] *v
>    fs/kernfs/file.c:160:46: sparse:     got struct atomic_t [noderef] __rcu *
>    fs/kernfs/file.c:204:46: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct atomic_t const [usertype] *v @@     got struct atomic_t [noderef] __rcu * @@
>    fs/kernfs/file.c:204:46: sparse:     expected struct atomic_t const [usertype] *v
>    fs/kernfs/file.c:204:46: sparse:     got struct atomic_t [noderef] __rcu *
> 
> vim +160 fs/kernfs/file.c
> 
> 414985ae23c031e Tejun Heo 2013-11-28  155  
> 414985ae23c031e Tejun Heo 2013-11-28  156  static int kernfs_seq_show(struct seq_file *sf, void *v)
> 414985ae23c031e Tejun Heo 2013-11-28  157  {
> c525aaddc366df2 Tejun Heo 2013-12-11  158  	struct kernfs_open_file *of = sf->private;
> 414985ae23c031e Tejun Heo 2013-11-28  159  
> adc5e8b58f4886d Tejun Heo 2013-12-11 @160  	of->event = atomic_read(&of->kn->attr.open->event);
> 414985ae23c031e Tejun Heo 2013-11-28  161  
> adc5e8b58f4886d Tejun Heo 2013-12-11  162  	return of->kn->attr.ops->seq_show(sf, v);
> 414985ae23c031e Tejun Heo 2013-11-28  163  }
> 414985ae23c031e Tejun Heo 2013-11-28  164  
> 
> :::::: The code at line 160 was first introduced by commit
> :::::: adc5e8b58f4886d45f79f4ff41a09001a76a6b12 kernfs: drop s_ prefix from kernfs_node members
> 
> :::::: TO: Tejun Heo <tj@kernel.org>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Imran, I'm going to go drop this change from my tree and let you
resubmit it after it's been fixed up (you need to grab the rcu reference
on attr.open here.)

thanks,

greg k-h
