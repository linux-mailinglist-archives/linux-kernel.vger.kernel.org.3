Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355304D1F3C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348667AbiCHRll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238659AbiCHRlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:41:40 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168F4A925
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646761243; x=1678297243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=deRkVfHgngx2Pgi2ZHYhGKjDOt3YM2Gvy+RyWuxgG/o=;
  b=XJ7eqlkph4A8ifsp/dmqTioBvL66tNGHc9EtXKp61s3YNdLS6fHAl3fV
   EUbSNNrCriZF6SRlf/C/ABmPz7xFDY0jmG5z6heGtD8cbscqu3YNu89So
   iKMKCHeyyyl4Z6Jid5Ck1VEbXrW9+eWqYJvlLv7N3sUIiHI44bmtqv4NO
   3+Uog7DUWBuw/jv4bbODkWVD3yBcmvsWc5qnMOw9yu8ew6gh1oMuSrKKg
   mIERewzEBxRtO4MGmfbT/a+wtLCR7Bx1hy1ezv3wphiwDFXQuWxShYvHq
   v+PzHco7hIty/kbpXBUQKIQOsyEosxNbmT0+CZEokmuNGywwRsGsW/CIY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242200971"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242200971"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:32:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="510181095"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2022 09:32:34 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRdhJ-0001lo-Gu; Tue, 08 Mar 2022 17:32:33 +0000
Date:   Wed, 9 Mar 2022 01:32:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: vmlinux.o: warning: objtool: __sev_es_ist_exit()+0x2b: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202203090119.Hj4y6WNM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ea4424be16887a37735d6550cfd0611528dbe5d9
commit: 315562c9af3d583502b35c4b223a08d95ce69864 x86/sev-es: Adjust #VC IST Stack on entering NMI handler
date:   1 year, 6 months ago
config: x86_64-buildonly-randconfig-r004-20220307 (https://download.01.org/0day-ci/archive/20220309/202203090119.Hj4y6WNM-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=315562c9af3d583502b35c4b223a08d95ce69864
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 315562c9af3d583502b35c4b223a08d95ce69864
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x45: call to syscall_enter_from_user_mode_work() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_int80_syscall_32()+0x35: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: idtentry_enter_nmi()+0x4a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: idtentry_exit_nmi()+0x52: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __rdgsbase_inactive()+0x23: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: __wrgsbase_inactive()+0x27: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: fixup_bad_iret()+0x84: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: noist_exc_debug()+0x25: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exc_nmi()+0x179: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: poke_int3_handler()+0x48: call to ftrace_likely_update() leaves .noinstr.text section
>> vmlinux.o: warning: objtool: __sev_es_ist_exit()+0x2b: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x3f: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x39: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_exit_to_user_mode()+0xd5: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x39: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit_to_user_mode()+0x32: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit()+0x2a: call to ftrace_likely_update() leaves .noinstr.text section
   vmlinux.o: warning: objtool: debug_locks_off()+0x21: call to __kasan_check_write() leaves .noinstr.text section

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
