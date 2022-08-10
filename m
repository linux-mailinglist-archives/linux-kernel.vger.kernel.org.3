Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F7C58F4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiHJXgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiHJXgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:36:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BDF6CF60;
        Wed, 10 Aug 2022 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660174573; x=1691710573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=avoT62DPeQ/dr+QXuZA1N2j3eBjV0qPlXy2MkTcCQno=;
  b=BQgzrfOZoPUsgSZ9h99F3MnfLcctDm7UegVu63C4wc5w91p5IBJuGtJv
   Ctr0XKVYGQ9SIYsXYLpPA/ttnjftnuXG2PfYfXZdkXAMwiOaNxvBOgIfi
   CnlAMaE92ErJYyedKaZj+oyVb8QfVMpAm+Ggq7Ouj7rIZEzKnzOca4Rqz
   //HuhNv+Xki/hWk8Pluyfky2F/iay5vFaCd0LhL94jqnxFgZj1e38hyS/
   6gp0yM6ttgqkwx5HzIHJ8MUKTPiWiPCH1O6VVu7b60DBGPlm9IwLio4h9
   GAmuWmHP4eCeOuQ2hEjvNuoB2aGA4XaAASrVUK1H+pssjXSWCWODlwZ38
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="292009750"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="292009750"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 16:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="665123415"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Aug 2022 16:36:10 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLvFC-0000py-0M;
        Wed, 10 Aug 2022 23:36:10 +0000
Date:   Thu, 11 Aug 2022 07:35:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] capabilities: new kernel.ns_modules_allowed sysctl
Message-ID: <202208110734.tH4Z51iL-lkp@intel.com>
References: <20220809185229.28417-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809185229.28417-1-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vegard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on v5.19]
[cannot apply to linus/master next-20220810]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vegard-Nossum/capabilities-new-kernel-ns_modules_allowed-sysctl/20220810-031142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: alpha-randconfig-r032-20220810 (https://download.01.org/0day-ci/archive/20220811/202208110734.tH4Z51iL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bd78b69455d4b3cac70812bf23a27de310e813cd
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vegard-Nossum/capabilities-new-kernel-ns_modules_allowed-sysctl/20220810-031142
        git checkout bd78b69455d4b3cac70812bf23a27de310e813cd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/kmod.c: In function 'kmod_sysctl_init':
>> kernel/kmod.c:213:9: error: implicit declaration of function 'register_sysctl_init'; did you mean 'register_sysctl_base'? [-Werror=implicit-function-declaration]
     213 |         register_sysctl_init("kernel", kmod_sysctl_table);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         register_sysctl_base
   cc1: some warnings being treated as errors


vim +213 kernel/kmod.c

   210	
   211	static int __init kmod_sysctl_init(void)
   212	{
 > 213		register_sysctl_init("kernel", kmod_sysctl_table);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
