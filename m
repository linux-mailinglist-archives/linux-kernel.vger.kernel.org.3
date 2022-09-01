Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69995A970C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiIAMm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiIAMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:42:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED6C115E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:42:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oTjWP-0002Jj-Ao; Thu, 01 Sep 2022 14:42:13 +0200
Date:   Thu, 1 Sep 2022 14:42:13 +0200
From:   Florian Westphal <fw@strlen.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Florian Westphal <fw@strlen.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [netfilter-nf-next:testing 1/6]
 net/netfilter/nf_conntrack_proto_tcp.c:592:32: warning: implicit conversion
 from 'enum <anonymous>' to 'enum nf_ct_tcp_action'
Message-ID: <20220901124213.GB7349@breakpoint.cc>
References: <202209012010.OWTXJac6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209012010.OWTXJac6-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
> head:   655d797bf5e11676f7ef9e68af3e9700404f8695
> commit: 83d3b17508cc0f1a53b73080c51e57054ddf3499 [1/6] netfilter: conntrack: prepare tcp_in_window for ternary return value
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220901/202209012010.OWTXJac6-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git/commit/?id=83d3b17508cc0f1a53b73080c51e57054ddf3499
>         git remote add netfilter-nf-next git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git
>         git fetch --no-tags netfilter-nf-next testing
>         git checkout 83d3b17508cc0f1a53b73080c51e57054ddf3499
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash net/netfilter/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    net/netfilter/nf_conntrack_proto_tcp.c: In function 'tcp_in_window':
> >> net/netfilter/nf_conntrack_proto_tcp.c:592:32: warning: implicit conversion from 'enum <anonymous>' to 'enum nf_ct_tcp_action' [-Wenum-conversion]
>      592 |                         return true;
>          |                                ^~~~

I'll squash this fix:

                if (dir == IP_CT_DIR_REPLY && !tcph->ack)
-                       return true;
+                       return NFCT_TCP_ACCEPT;
