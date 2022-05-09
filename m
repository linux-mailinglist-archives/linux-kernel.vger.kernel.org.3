Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5FD51FD60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbiEIMye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiEIMyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:54:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2F2613A
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652100637; x=1683636637;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MsFiqomf3n4gz5TZpVYt5uVXII7AT1WCc19ufzD2ZNM=;
  b=R/b18o4P0bgNEwH59uOeAowsWSH4WmUfAZN/52/781B3iORUr4I+HK1J
   HfDLsd0mKPMD/rIWAPUW9K99T7UJkZwUQ+klk4K4HIPd13MTZ2av40sTo
   aRLDFJHjaFFMKZn4shtCWoG23657fQG+7tyXbrbeLbL0QIIbyhfmIXCk9
   B+pGplA8ShIetnJo5GcQFFsZPrUHTp+WBEzAhyFrsjBhA5Ymsu9nkBEDz
   krkOZUw0Dnwz/3CMm6V7hR3CLjs8CpVtUqvbhEiuoxI/W70ZXq/fVPLSd
   Sa1+uwb6TXGGBcv5ysXWiwOT46YnnGIN522Qdss6QZtpaAA/uBwX3lwhm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="248939478"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="248939478"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 05:50:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="710511039"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 05:50:36 -0700
Date:   Mon, 9 May 2022 20:48:46 +0800
From:   Philip Li <philip.li@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbuild-all] Re: WARNING: modpost: vmlinux.o(.text+0xa76d36):
 Section mismatch in reference from the function rtc_update_irq() to the
 variable .init.text:.L0
Message-ID: <YnkNrrT9RDpmyGg/@rli9-dbox>
References: <202205090847.j9NvIYxI-lkp@intel.com>
 <YnhrHXHv8tjotmnE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnhrHXHv8tjotmnE@casper.infradead.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 02:15:09AM +0100, Matthew Wilcox wrote:
> On Mon, May 09, 2022 at 08:14:44AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
> > commit: 170f37d6aa6ad4582eefd7459015de79e244536e block: Do not call folio_next() on an unreferenced folio
> > date:   4 days ago
> > config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205090847.j9NvIYxI-lkp@intel.com/config)
> > compiler: riscv32-linux-gcc (GCC) 11.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=170f37d6aa6ad4582eefd7459015de79e244536e
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 170f37d6aa6ad4582eefd7459015de79e244536e
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> WARNING: modpost: vmlinux.o(.text+0xa76d36): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
> > The function rtc_update_irq() references
> > the variable __init .L0 .
> > This is often because rtc_update_irq lacks a __init
> > annotation or the annotation of .L0 is wrong.
> > 
> > Note: the below error/warnings can be found in parent commit:
> > << WARNING: modpost: vmlinux.o(.text+0xa7418e): Section mismatch in reference from the function rtc_month_days() to the variable .init.setup:__setup_root_delay_setup
> > << WARNING: modpost: vmlinux.o(.text+0xb2080e): Section mismatch in reference from the function thermal_zone_device_unregister() to the variable .init.text:.L0
> > << WARNING: modpost: vmlinux.o(.text+0xb34ff0): Section mismatch in reference from the function btintel_enter_mfg() to the variable .init.text:.LBB18955
> > << WARNING: modpost: vmlinux.o(.text+0xb5964e): Section mismatch in reference from the function cpuidle_switch_governor() to the variable .init.text:.L0
> > << WARNING: modpost: vmlinux.o(.text+0xbacbfa): Section mismatch in reference from the function comedi_buf_map_get() to the variable .init.text:.L0
> > << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1100
> 
> I'm going to suggest that my commit is not responsible for anything
> other than moving a warning around.  I do not intend to investigate
> this further unless someone tells me otherwise.

Sorry, kindly ignore this report, which is a false positive. We will
block such report in future to avoid noise.

> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
