Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EAA4C38A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiBXWSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiBXWSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:18:02 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10593186BB4;
        Thu, 24 Feb 2022 14:17:31 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nNMQS-0007G8-Vd; Thu, 24 Feb 2022 23:17:29 +0100
Date:   Thu, 24 Feb 2022 23:17:28 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [netfilter-nf:master 47/47] nf_queue.c:undefined reference to
 `sock_gen_put'
Message-ID: <20220224221728.GI28705@breakpoint.cc>
References: <202202250551.bHhoyNSe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202250551.bHhoyNSe-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> wrote:

[ cc nf-devel ]

> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git master
> head:   661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
> commit: 661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd [47/47] netfilter: nf_queue: don't assume sk is full socket
> config: arm-randconfig-c002-20220223 (https://download.01.org/0day-ci/archive/20220225/202202250551.bHhoyNSe-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
>         git remote add netfilter-nf git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git
>         git fetch --no-tags netfilter-nf master
>         git checkout 661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: net/netfilter/nf_queue.o: in function `nf_queue_entry_release_refs':
> >> nf_queue.c:(.text+0x60): undefined reference to `sock_gen_put'

CONFIG_NETFILTER=y
CONFIG_DECNET=y
CONFIG_INET=n

I could add ugly ifdef to use sock_put() like before for !INET case.
OTOH, the entire nfqueue infra is doubtful in this config.

Maybe elide that completely?  Any advice/preferred solution?
