Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804105ABC5C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 04:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiICChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiICChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 22:37:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FC4E97C6;
        Fri,  2 Sep 2022 19:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662172662; x=1693708662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uZjszkbsmhce7t/ileXAuZqNCiVsozNNHJWKPtgsoeY=;
  b=dCbHuhnO+nO5CbfjlxMNU3xgVKh9pgpQQNSLU7Irj/FncX6JIjWKGOpx
   2+IwxFHkx8l0L9xw9dgenPUu3hL7B8RPk8v4YyzWjaCNU146hjeQTAb9/
   rxcGg3h/uRQZ8j7iB4Vyo28/AzN9yQdWM2kZKa4nDm5B0A0aPs4PvjYne
   /UDPUzKg/rA9FMQRGqkLHvsyrPLal/lai+JzyvEF5jRREp9e6jDLmmLWA
   VDqzG8i4j0PD6ToYLX0l4ny3qrwMMiXQrCyheua+Z6BLckm2ibxpSv0xu
   U+Gq7sWWyq6coEXNeibqfULdOjruqAoi0ObvO89Jk5evurGVxSYthy1iW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="360080006"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="360080006"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 19:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="609165471"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2022 19:37:40 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUJ2R-0000uT-1B;
        Sat, 03 Sep 2022 02:37:39 +0000
Date:   Sat, 3 Sep 2022 10:36:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: use objtool-args-y to clean up objtool arguments
Message-ID: <202209031000.bJCDq6zH-lkp@intel.com>
References: <20220902130846.654526-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220902130846.654526-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on masahiroy-kbuild/for-next]
[also build test ERROR on linux/master linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/kbui=
ld-use-objtool-args-y-to-clean-up-objtool-arguments/20220902-221441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbu=
ild.git for-next
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/202=
20903/202209031000.bJCDq6zH-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=3D1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9cb92b4715f74a8869c=
a8ec50a8dcdc4fb5b384e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/kbuild-use-objtool=
-args-y-to-clean-up-objtool-arguments/20220902-221441
        git checkout 9cb92b4715f74a8869ca8ec50a8dcdc4fb5b384e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> /bin/bash: -c: line 1: syntax error near unexpected token `)'
   /bin/bash: -c: line 1: `set -e;  echo '  LD      vmlinux.o';  ld -m elf_=
x86_64 -z noexecstack --no-warn-rwx-segments -r -o vmlinux.o  --whole-archi=
ve arch/x86/kernel/head_64.o arch/x86/kernel/head64.o arch/x86/kernel/ebda.=
o arch/x86/kernel/platform-quirks.o init/built-in.a usr/built-in.a arch/x86=
/built-in.a kernel/built-in.a certs/built-in.a mm/built-in.a fs/built-in.a =
ipc/built-in.a security/built-in.a crypto/built-in.a io_uring/built-in.a li=
b/built-in.a arch/x86/lib/built-in.a  lib/lib.a  arch/x86/lib/lib.a drivers=
/built-in.a sound/built-in.a net/built-in.a virt/built-in.a arch/x86/pci/bu=
ilt-in.a arch/x86/power/built-in.a arch/x86/video/built-in.a --no-whole-arc=
hive --start-group  --end-group  ; ./tools/objtool/objtool --hacks=3Djump_l=
abel --hacks=3Dnoinstr --orc --static-call --uaccess --no-unreachable --no-=
unreachable --noinstr ) --link vmlinux.o; printf '%s\n' 'cmd_vmlinux.o :=3D=
 ld -m elf_x86_64 -z noexecstack --no-warn-rwx-segments -r -o vmlinux.o  --=
whole-archive arch/x86/kernel/head_64.o arch/x86/kernel/head64.o arch/x86/k=
ernel/ebda.o arch/x86/kernel/platform-quirks.o init/built-in.a usr/built-in=
=2Ea arch/x86/built-in.a kernel/built-in.a certs/built-in.a mm/built-in.a f=
s/built-in.a ipc/built-in.a security/built-in.a crypto/built-in.a io_uring/=
built-in.a lib/built-in.a arch/x86/lib/built-in.a  lib/lib.a  arch/x86/lib/=
lib.a drivers/built-in.a sound/built-in.a net/built-in.a virt/built-in.a ar=
ch/x86/pci/built-in.a arch/x86/power/built-in.a arch/x86/video/built-in.a -=
-no-whole-archive --start-group  --end-group  ; ./tools/objtool/objtool --h=
acks=3Djump_label --hacks=3Dnoinstr --orc --static-call --uaccess --no-unre=
achable --no-unreachable --noinstr ) --link vmlinux.o' > ./.vmlinux.o.cmd'

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
