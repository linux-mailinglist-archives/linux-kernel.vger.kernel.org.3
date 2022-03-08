Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A7C4D0EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiCHFR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiCHFRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:17:55 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2436B41
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 21:16:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V6cdbhs_1646716615;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V6cdbhs_1646716615)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 13:16:56 +0800
Date:   Tue, 8 Mar 2022 13:16:55 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     kernel test robot <lkp@intel.com>, kuba@kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [saeed:net-next 154/185] net/smc/smc_sysctl.h:23:16: warning: no
 previous prototype for 'smc_sysctl_net_init'
Message-ID: <20220308051655.GF35207@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <202203081012.KgONXWsS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203081012.KgONXWsS-lkp@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 10:43:56AM +0800, kernel test robot wrote:
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next
>head:   03200f4a126b1a08c0f16dea7f67e6bff9c83c90
>commit: 7de8eb0d9039f16e1122d7aa524a1502a160c4ff [154/185] net/smc: fix compile warning for smc_sysctl
>config: arc-randconfig-r016-20220308 (https://download.01.org/0day-ci/archive/20220308/202203081012.KgONXWsS-lkp@intel.com/config)
>compiler: arceb-elf-gcc (GCC) 11.2.0
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=7de8eb0d9039f16e1122d7aa524a1502a160c4ff
>        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
>        git fetch --no-tags saeed net-next
>        git checkout 7de8eb0d9039f16e1122d7aa524a1502a160c4ff
>        # save the config file to linux build tree
>        mkdir build_dir
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash net/
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All warnings (new ones prefixed by >>):
>
>   In file included from net/smc/af_smc.c:54:
>>> net/smc/smc_sysctl.h:23:16: warning: no previous prototype for 'smc_sysctl_net_init' [-Wmissing-prototypes]
>      23 | int __net_init smc_sysctl_net_init(struct net *net)
>         |                ^~~~~~~~~~~~~~~~~~~
>>> net/smc/smc_sysctl.h:29:17: warning: no previous prototype for 'smc_sysctl_net_exit' [-Wmissing-prototypes]
>      29 | void __net_exit smc_sysctl_net_exit(struct net *net) { }
>         |                 ^~~~~~~~~~~~~~~~~~~

I found this -Wmissing-prototypes is added to the compiler if W=1 is set.
I didn't check W=1 before because I found there are lots of warnings with
the current code.

I will add this W=1 to my checking script and make sure no warnings introduced
by my patch next time.

>
>
>vim +/smc_sysctl_net_init +23 net/smc/smc_sysctl.h
>
>    22	
>  > 23	int __net_init smc_sysctl_net_init(struct net *net)
>    24	{
>    25		net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>    26		return 0;
>    27	}
>    28	
>  > 29	void __net_exit smc_sysctl_net_exit(struct net *net) { }
>    30	

Hi Jakub:

Sorry to bother again on this !
Looks like we still need to add 'static inline' or add an extra
declaration for these 2 functions if we want to get rid of these warnings.
What do you think ?

Thanks

>
>---
>0-DAY CI Kernel Test Service, Intel Corporation
>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
