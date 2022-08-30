Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE85A6441
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiH3NAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiH3NAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:00:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766C275ED
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661864422; x=1693400422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VJbUViv/fpcb8U0S1EuGwTwpX/YsYkFt89M/WPBl20A=;
  b=S1qgfiqmUZxMmbl/fIBoHw7B86gnkpn6WTM5QKmHuUknGk9RmhJ9acks
   U2gCl+c+kbtT94m2uQHQKbgbYOD2TLPhuff+PcC+wnsNC8yVd3FKU17pG
   ugjcuirYiviFP6Aat/RyppIVLA9JiUxou0egkIkeImmWCrSY/ECvlqxGE
   84o/CsssSn+Z5mxUY1pYiWafM8kkDN0OcLITM6O8u0XiInWKXbG4etDNg
   mdNKw1GjwX/4FT5KTQudcZsy3nQdLV4S7uigp/1uytU995Mz9Eoqsz/Ig
   7f3T7K+PZXMNzSqq65MWamfY2uVpnSmgk6oVErRtwxFKbdqyHNSd87FbJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381463565"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="381463565"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 06:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="562634564"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 06:00:19 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT0qo-0000Hb-1l;
        Tue, 30 Aug 2022 13:00:18 +0000
Date:   Tue, 30 Aug 2022 20:59:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v7 4/5] LoongArch: Support PC-relative relocations in
 modules
Message-ID: <202208302041.ANqQ0hQd-lkp@intel.com>
References: <20220830104806.128365-5-xry111@xry111.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830104806.128365-5-xry111@xry111.site>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on kees/for-next/execve]
[also build test WARNING on linus/master v6.0-rc3 next-20220830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xi-Ruoyao/LoongArch-Support-toolchain-with-new-relocation-types/20220830-185350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20220830/202208302041.ANqQ0hQd-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/529c0f36d2dad7dd4bcec3815f821547d9e9643c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xi-Ruoyao/LoongArch-Support-toolchain-with-new-relocation-types/20220830-185350
        git checkout 529c0f36d2dad7dd4bcec3815f821547d9e9643c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash arch/loongarch/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

     366 |         [R_LARCH_NONE]                                       = apply_r_larch_none,
         |                                                                ^~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:366:64: note: (near initialization for 'reloc_rela_handlers[0]')
   arch/loongarch/kernel/module.c:367:64: warning: initialized field overwritten [-Woverride-init]
     367 |         [R_LARCH_32]                                         = apply_r_larch_32,
         |                                                                ^~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:367:64: note: (near initialization for 'reloc_rela_handlers[1]')
   arch/loongarch/kernel/module.c:368:64: warning: initialized field overwritten [-Woverride-init]
     368 |         [R_LARCH_64]                                         = apply_r_larch_64,
         |                                                                ^~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:368:64: note: (near initialization for 'reloc_rela_handlers[2]')
   arch/loongarch/kernel/module.c:369:64: warning: initialized field overwritten [-Woverride-init]
     369 |         [R_LARCH_MARK_LA]                                    = apply_r_larch_none,
         |                                                                ^~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:369:64: note: (near initialization for 'reloc_rela_handlers[20]')
   arch/loongarch/kernel/module.c:370:64: warning: initialized field overwritten [-Woverride-init]
     370 |         [R_LARCH_MARK_PCREL]                                 = apply_r_larch_none,
         |                                                                ^~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:370:64: note: (near initialization for 'reloc_rela_handlers[21]')
   arch/loongarch/kernel/module.c:371:64: warning: initialized field overwritten [-Woverride-init]
     371 |         [R_LARCH_SOP_PUSH_PCREL]                             = apply_r_larch_sop_push_pcrel,
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:371:64: note: (near initialization for 'reloc_rela_handlers[22]')
   arch/loongarch/kernel/module.c:372:64: warning: initialized field overwritten [-Woverride-init]
     372 |         [R_LARCH_SOP_PUSH_ABSOLUTE]                          = apply_r_larch_sop_push_absolute,
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:372:64: note: (near initialization for 'reloc_rela_handlers[23]')
   arch/loongarch/kernel/module.c:373:64: warning: initialized field overwritten [-Woverride-init]
     373 |         [R_LARCH_SOP_PUSH_DUP]                               = apply_r_larch_sop_push_dup,
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:373:64: note: (near initialization for 'reloc_rela_handlers[24]')
   arch/loongarch/kernel/module.c:374:64: warning: initialized field overwritten [-Woverride-init]
     374 |         [R_LARCH_SOP_PUSH_PLT_PCREL]                         = apply_r_larch_sop_push_plt_pcrel,
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:374:64: note: (near initialization for 'reloc_rela_handlers[29]')
   arch/loongarch/kernel/module.c:375:64: warning: initialized field overwritten [-Woverride-init]
     375 |         [R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE]            = apply_r_larch_sop,
         |                                                                ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:375:64: note: (near initialization for 'reloc_rela_handlers[32]')
   arch/loongarch/kernel/module.c:375:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:375:64: note: (near initialization for 'reloc_rela_handlers[33]')
   arch/loongarch/kernel/module.c:375:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:375:64: note: (near initialization for 'reloc_rela_handlers[34]')
   arch/loongarch/kernel/module.c:375:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:375:64: note: (near initialization for 'reloc_rela_handlers[35]')
   arch/loongarch/kernel/module.c:375:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:375:64: note: (near initialization for 'reloc_rela_handlers[36]')
   arch/loongarch/kernel/module.c:375:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:375:64: note: (near initialization for 'reloc_rela_handlers[37]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
     376 |         [R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
         |                                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[38]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[39]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[40]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[41]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[42]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[43]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[44]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[45]')
   arch/loongarch/kernel/module.c:376:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:376:64: note: (near initialization for 'reloc_rela_handlers[46]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
     377 |         [R_LARCH_ADD32 ... R_LARCH_SUB64]                    = apply_r_larch_add_sub,
         |                                                                ^~~~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[50]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[51]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[52]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[53]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[54]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[55]')
   arch/loongarch/kernel/module.c:377:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:377:64: note: (near initialization for 'reloc_rela_handlers[56]')
   arch/loongarch/kernel/module.c:378:64: warning: initialized field overwritten [-Woverride-init]
     378 |         [R_LARCH_B26]                                        = apply_r_larch_b26,
         |                                                                ^~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:378:64: note: (near initialization for 'reloc_rela_handlers[66]')
   arch/loongarch/kernel/module.c:379:64: warning: initialized field overwritten [-Woverride-init]
     379 |         [R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]          = apply_r_larch_pcala,
         |                                                                ^~~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:379:64: note: (near initialization for 'reloc_rela_handlers[71]')
   arch/loongarch/kernel/module.c:379:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:379:64: note: (near initialization for 'reloc_rela_handlers[72]')
   arch/loongarch/kernel/module.c:379:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:379:64: note: (near initialization for 'reloc_rela_handlers[73]')
   arch/loongarch/kernel/module.c:379:64: warning: initialized field overwritten [-Woverride-init]
   arch/loongarch/kernel/module.c:379:64: note: (near initialization for 'reloc_rela_handlers[74]')
   arch/loongarch/kernel/module.c: In function 'apply_r_larch_pcala':
>> arch/loongarch/kernel/module.c:336:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
     336 |                 v = offset_rem >> 52;
         |                 ~~^~~~~~~~~~~~~~~~~~
   arch/loongarch/kernel/module.c:338:9: note: here
     338 |         case R_LARCH_PCALA_LO12:
         |         ^~~~


vim +336 arch/loongarch/kernel/module.c

   315	
   316	static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
   317				s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
   318	{
   319		union loongarch_instruction *insn = (union loongarch_instruction *)location;
   320		/* Use s32 for a sign-extension deliberately. */
   321		s32 offset_hi20 = (void *)((v + 0x800) & ~0xfff) -
   322			(void *)((Elf_Addr)location & ~0xfff);
   323		Elf_Addr anchor = (((Elf_Addr)location) & ~0xfff) + offset_hi20;
   324		ptrdiff_t offset_rem = (void *)v - (void *)anchor;
   325	
   326		switch (type) {
   327		case R_LARCH_PCALA_HI20:
   328			v = offset_hi20 >> 12;
   329			insn->reg1i20_format.immediate = v & 0xfffff;
   330			break;
   331		case R_LARCH_PCALA64_LO20:
   332			v = offset_rem >> 32;
   333			insn->reg1i20_format.immediate = v & 0xfffff;
   334			break;
   335		case R_LARCH_PCALA64_HI12:
 > 336			v = offset_rem >> 52;
   337			/* fall through */
   338		case R_LARCH_PCALA_LO12:
   339			insn->reg2i12_format.immediate = v & 0xfff;
   340			break;
   341		default:
   342			pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
   343			return -EINVAL;
   344		}
   345	
   346		return 0;
   347	}
   348	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
