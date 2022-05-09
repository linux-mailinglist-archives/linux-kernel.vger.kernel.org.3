Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B7F51FF0D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiEIOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbiEIOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:07:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC722655C5
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652105008; x=1683641008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wRg20se85xJotz7rbGkd/WepRqWjswHgMGSblsVcHGk=;
  b=LWsGQIeEJBORs/7SA4tEZR0T4REIBthCO6Kpari96gePCeHj/dMJJzPq
   zxoBoFNfLAqNS6xliw7edCjeFApd97Iy/t5bN0e7JmbZmQc4abHL+MQLj
   kI8ZM0KfRwoaGvJdlgwLM9qDgiikqHqeQgIRTrIrumwpIqJdzxpiRt7qg
   Z3hFpqPlzAOjKPErgg5WG4u8SmF7ZzC/PeOWaSAE/goLESiSa1PuuDnFs
   nToXUSJqXe0qF3OHCCoHoFDLLR4vGqmGdhWdnCdG7UJjlUVFJLZ8Ob5rr
   4H47yisWzfIz7rPi5A0ifvG2Qgtf3uWxXYLsebZyoEYeAvUwQEZcOfd85
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268723237"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="268723237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:03:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="710535731"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 07:03:00 -0700
Date:   Mon, 9 May 2022 22:01:13 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in
 reference from the function rtc_update_irq() to the variable .init.text:.L0
Message-ID: <YnkeqQrMZrqkAZAP@rli9-dbox>
References: <202205090847.j9NvIYxI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205090847.j9NvIYxI-lkp@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 08:14:44AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> commit: 170f37d6aa6ad4582eefd7459015de79e244536e block: Do not call folio_next() on an unreferenced folio
> date:   4 days ago
> config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205090847.j9NvIYxI-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=170f37d6aa6ad4582eefd7459015de79e244536e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 170f37d6aa6ad4582eefd7459015de79e244536e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):

Sorry, kindly ignore this report, which is a false positive. We will
block such report in future.

> 
> >> WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
> The function rtc_update_irq() references
> the variable __init .L0 .
> This is often because rtc_update_irq lacks a __init
> annotation or the annotation of .L0 is wrong.
> 
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0xa7418e): Section mismatch in reference from the function rtc_month_days() to the variable .init.setup:__setup_root_delay_setup
> << WARNING: modpost: vmlinux.o(.text+0xb2080e): Section mismatch in reference from the function thermal_zone_device_unregister() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb34ff0): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB18955
> << WARNING: modpost: vmlinux.o(.text+0xb5964e): Section mismatch in reference from the function cpuidle_switch_governor() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xbacbfa): Section mismatch in reference from the function comedi_buf_map_get() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1100
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
