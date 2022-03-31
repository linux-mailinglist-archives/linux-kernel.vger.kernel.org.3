Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B464ED455
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiCaHEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiCaHEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:04:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A21EF5C3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648710163; x=1680246163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sFeWHlxR+ad+qgVIyzwn7tj+dBlVUeqnPjVJwq02U1o=;
  b=P3TwloK+T3fg7orr1K9HYWucHbT3VvnwgRngtCOGP7KsJfanbq7MKBOi
   Wxz1L5plnnMWcJHQfwFo7va0gC0Ce8HKGHoAAvcwj7NT+t9V6XTrrInrZ
   hCFqZQTkhlVszwCPDpbhXGIFqjf52VlGDN/FSpaMd10oP2mHhdiVKeykx
   +QrpHCfa3dWBS19cIgv9cbiIENWg0rdEbp2x3H0PS2bXMtFzo1P+jwE/O
   2IMyqcOxKxsMHDbWshrVunHbQx2i16shoSJN6dVV7cE56ylFyEXokdXOi
   kXXwZCJHpUHBxcRMmQgQkPIOvHha5C9oXVhVH7/EvxLpUfh54y0OS46tg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322919156"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="322919156"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 00:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="503617667"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 00:02:40 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZopL-00002B-Ah;
        Thu, 31 Mar 2022 07:02:39 +0000
Date:   Thu, 31 Mar 2022 15:01:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, vijayb@linux.microsoft.com,
        f.fainelli@gmail.com, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 2/3] arm64: mm: Don't defer reserve_crashkernel() with
 dma_force_32bit
Message-ID: <202203311421.VENALFHe-lkp@intel.com>
References: <20220331025946.51163-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331025946.51163-3-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220330]
[cannot apply to arm64/for-next/core v5.17 v5.17-rc8 v5.17-rc7 v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-mm-Do-not-defer-reserve_crashkernel/20220331-105429
base:    a67ba3cf9551f8c92d5ec9d7eae1aadbb9127b57
config: arm64-randconfig-r035-20220331 (https://download.01.org/0day-ci/archive/20220331/202203311421.VENALFHe-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/05592b78cd421b988704f52eba353278a3c22ee4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kefeng-Wang/arm64-mm-Do-not-defer-reserve_crashkernel/20220331-105429
        git checkout 05592b78cd421b988704f52eba353278a3c22ee4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/kexec.h:34,
                    from arch/arm64/kernel/asm-offsets.c:12:
>> arch/arm64/include/asm/kexec.h:97:6: warning: no previous prototype for 'crashkernel_could_early_reserve' [-Wmissing-prototypes]
      97 | bool crashkernel_could_early_reserve(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/include/asm/kexec.h: In function 'crashkernel_could_early_reserve':
>> arch/arm64/include/asm/kexec.h:102:1: warning: empty declaration
     102 | struct kimage_arch {
         | ^~~~~~
>> arch/arm64/include/asm/kexec.h:115:36: error: storage class specified for parameter 'kexec_image_ops'
     115 | extern const struct kexec_file_ops kexec_image_ops;
         |                                    ^~~~~~~~~~~~~~~
   arch/arm64/include/asm/kexec.h:117:1: warning: empty declaration
     117 | struct kimage;
         | ^~~~~~
>> arch/arm64/include/asm/kexec.h:119:12: error: storage class specified for parameter 'arch_kimage_file_post_load_cleanup'
     119 | extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/include/asm/kexec.h:120:12: error: storage class specified for parameter 'load_other_segments'
     120 | extern int load_other_segments(struct kimage *image,
         |            ^~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/kernel/asm-offsets.c:12:
>> include/linux/kexec.h:77:23: error: storage class specified for parameter 'kimage_entry_t'
      77 | typedef unsigned long kimage_entry_t;
         |                       ^~~~~~~~~~~~~~
>> include/linux/kexec.h:79:1: warning: empty declaration
      79 | struct kexec_segment {
         | ^~~~~~
   include/linux/kexec.h:107:1: warning: empty declaration
     107 | struct purgatory_info {
         | ^~~~~~
   include/linux/kexec.h:125:1: warning: empty declaration
     125 | struct kimage;
         | ^~~~~~
>> include/linux/kexec.h:127:14: error: storage class specified for parameter 'kexec_probe_t'
     127 | typedef int (kexec_probe_t)(const char *kernel_buf, unsigned long kernel_size);
         |              ^~~~~~~~~~~~~
>> include/linux/kexec.h:128:16: error: storage class specified for parameter 'kexec_load_t'
     128 | typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
         |                ^~~~~~~~~~~~
>> include/linux/kexec.h:132:14: error: storage class specified for parameter 'kexec_cleanup_t'
     132 | typedef int (kexec_cleanup_t)(void *loader_data);
         |              ^~~~~~~~~~~~~~~
>> include/linux/kexec.h:135:14: error: storage class specified for parameter 'kexec_verify_sig_t'
     135 | typedef int (kexec_verify_sig_t)(const char *kernel_buf,
         |              ^~~~~~~~~~~~~~~~~~
>> include/linux/kexec.h:140:9: error: expected specifier-qualifier-list before 'kexec_probe_t'
     140 |         kexec_probe_t *probe;
         |         ^~~~~~~~~~~~~
   include/linux/kexec.h:139:1: warning: empty declaration
     139 | struct kexec_file_ops {
         | ^~~~~~
>> include/linux/kexec.h:148:44: error: storage class specified for parameter 'kexec_file_loaders'
     148 | extern const struct kexec_file_ops * const kexec_file_loaders[];
         |                                            ^~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:174:1: warning: empty declaration
     174 | struct kexec_buf {
         | ^~~~~~
>> include/linux/kexec.h:204:5: error: redefinition of parameter 'arch_kimage_file_post_load_cleanup'
     204 | int arch_kimage_file_post_load_cleanup(struct kimage *image);
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kexec.h:34,
                    from arch/arm64/kernel/asm-offsets.c:12:
   arch/arm64/include/asm/kexec.h:119:12: note: previous definition of 'arch_kimage_file_post_load_cleanup' with type 'int (*)(struct kimage *)'
     119 | extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/kernel/asm-offsets.c:12:
>> include/linux/kexec.h:211:12: error: storage class specified for parameter 'kexec_add_buffer'
     211 | extern int kexec_add_buffer(struct kexec_buf *kbuf);
         |            ^~~~~~~~~~~~~~~~
   include/linux/kexec.h:217:1: warning: empty declaration
     217 | struct crash_mem_range {
         | ^~~~~~
   include/linux/kexec.h:221:1: warning: empty declaration
     221 | struct crash_mem {
         | ^~~~~~
>> include/linux/kexec.h:227:12: error: storage class specified for parameter 'crash_exclude_mem_range'
     227 | extern int crash_exclude_mem_range(struct crash_mem *mem,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/kexec.h:230:12: error: storage class specified for parameter 'crash_prepare_elf64_headers'
     230 | extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/kexec.h:258:9: error: expected specifier-qualifier-list before 'kimage_entry_t'
     258 |         kimage_entry_t head;
         |         ^~~~~~~~~~~~~~
   include/linux/kexec.h:257:1: warning: empty declaration
     257 | struct kimage {
         | ^~~~~~
>> include/linux/kexec.h:325:13: error: storage class specified for parameter 'machine_kexec'
     325 | extern void machine_kexec(struct kimage *image);
         |             ^~~~~~~~~~~~~
>> include/linux/kexec.h:326:12: error: storage class specified for parameter 'machine_kexec_prepare'
     326 | extern int machine_kexec_prepare(struct kimage *image);
         |            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:327:13: error: storage class specified for parameter 'machine_kexec_cleanup'
     327 | extern void machine_kexec_cleanup(struct kimage *image);
         |             ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:328:12: error: storage class specified for parameter 'kernel_kexec'
     328 | extern int kernel_kexec(void);
         |            ^~~~~~~~~~~~
   include/linux/kexec.h:329:21: error: storage class specified for parameter 'kimage_alloc_control_pages'
     329 | extern struct page *kimage_alloc_control_pages(struct kimage *image,
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:333:13: error: storage class specified for parameter '__crash_kexec'
     333 | extern void __crash_kexec(struct pt_regs *);
         |             ^~~~~~~~~~~~~
   include/linux/kexec.h:334:13: error: storage class specified for parameter 'crash_kexec'
     334 | extern void crash_kexec(struct pt_regs *);
         |             ^~~~~~~~~~~
   include/linux/kexec.h:338:12: error: storage class specified for parameter 'kimage_crash_copy_vmcoreinfo'
     338 | extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:340:23: error: storage class specified for parameter 'kexec_image'
     340 | extern struct kimage *kexec_image;
         |                       ^~~~~~~~~~~
   include/linux/kexec.h:341:23: error: storage class specified for parameter 'kexec_crash_image'
     341 | extern struct kimage *kexec_crash_image;
         |                       ^~~~~~~~~~~~~~~~~
   include/linux/kexec.h:342:12: error: storage class specified for parameter 'kexec_load_disabled'
     342 | extern int kexec_load_disabled;
         |            ^~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:360:13: error: storage class specified for parameter 'kexec_in_progress'
     360 | extern bool kexec_in_progress;
         |             ^~~~~~~~~~~~~~~~~
   include/linux/kexec.h:371:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     371 | {
         | ^
   include/linux/kexec.h:378:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     378 | {
         | ^
   include/linux/kexec.h:385:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     385 | {
         | ^
   include/linux/kexec.h:392:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     392 | {
         | ^
   include/linux/kexec.h:398:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     398 | {
         | ^
   include/linux/kexec.h:403:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     403 | {
         | ^
   include/linux/kexec.h:408:91: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     408 | static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp) { return 0; }
         |                                                                                           ^
   include/linux/kexec.h:412:79: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     412 | static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
         |                                                                               ^
   In file included from include/linux/dma-mapping.h:9,
                    from arch/arm64/kernel/asm-offsets.c:14:
   include/linux/dma-direction.h:5:1: warning: empty declaration
       5 | enum dma_data_direction {
         | ^~~~
   include/linux/dma-direction.h:13:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      13 | {
         | ^
   In file included from include/linux/dma-mapping.h:10,
                    from arch/arm64/kernel/asm-offsets.c:14:
   include/linux/scatterlist.h:11:1: warning: empty declaration
      11 | struct scatterlist {
         | ^~~~~~
   include/linux/scatterlist.h:36:1: warning: empty declaration
      36 | struct sg_table {
         | ^~~~~~
   include/linux/scatterlist.h:42:1: warning: empty declaration
      42 | struct sg_append_table {
         | ^~~~~~
   include/linux/scatterlist.h:75:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      75 | {
         | ^
   include/linux/scatterlist.h:80:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      80 | {
         | ^
   include/linux/scatterlist.h:85:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      85 | {
         | ^
   include/linux/scatterlist.h:90:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      90 | {
         | ^
   include/linux/scatterlist.h:105:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     105 | {
         | ^
   include/linux/scatterlist.h:135:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     135 | {
         | ^
   include/linux/scatterlist.h:142:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     142 | {
         | ^
   include/linux/scatterlist.h:158:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     158 | {
         | ^
   include/linux/scatterlist.h:187:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token


vim +/kexec_image_ops +115 arch/arm64/include/asm/kexec.h

254a41c0ba0573 AKASHI Takahiro 2017-04-03   92  
7a2512fa649397 Pasha Tatashin  2021-09-30   93  #if defined(CONFIG_KEXEC_CORE)
7a2512fa649397 Pasha Tatashin  2021-09-30   94  void cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
7a2512fa649397 Pasha Tatashin  2021-09-30   95  		      unsigned long arg0, unsigned long arg1,
7a2512fa649397 Pasha Tatashin  2021-09-30   96  		      unsigned long arg2);
05592b78cd421b Kefeng Wang     2022-03-31  @97  bool crashkernel_could_early_reserve(void)
7a2512fa649397 Pasha Tatashin  2021-09-30   98  #endif
7a2512fa649397 Pasha Tatashin  2021-09-30   99  
52b2a8af743604 AKASHI Takahiro 2018-11-15  100  #define ARCH_HAS_KIMAGE_ARCH
52b2a8af743604 AKASHI Takahiro 2018-11-15  101  
52b2a8af743604 AKASHI Takahiro 2018-11-15 @102  struct kimage_arch {
52b2a8af743604 AKASHI Takahiro 2018-11-15  103  	void *dtb;
117cda9a784728 Pavel Tatashin  2021-01-25  104  	phys_addr_t dtb_mem;
4c3c31230c912d Pavel Tatashin  2021-01-25  105  	phys_addr_t kern_reloc;
08eae0ef618f34 Pasha Tatashin  2021-09-30  106  	phys_addr_t el2_vectors;
efc2d0f20a9dab Pasha Tatashin  2021-09-30  107  	phys_addr_t ttbr0;
3744b5280e67f5 Pasha Tatashin  2021-09-30  108  	phys_addr_t ttbr1;
3744b5280e67f5 Pasha Tatashin  2021-09-30  109  	phys_addr_t zero_page;
efc2d0f20a9dab Pasha Tatashin  2021-09-30  110  	unsigned long phys_offset;
efc2d0f20a9dab Pasha Tatashin  2021-09-30  111  	unsigned long t0sz;
52b2a8af743604 AKASHI Takahiro 2018-11-15  112  };
52b2a8af743604 AKASHI Takahiro 2018-11-15  113  
117cda9a784728 Pavel Tatashin  2021-01-25  114  #ifdef CONFIG_KEXEC_FILE
f3b70e50942960 AKASHI Takahiro 2018-11-15 @115  extern const struct kexec_file_ops kexec_image_ops;
f3b70e50942960 AKASHI Takahiro 2018-11-15  116  
52b2a8af743604 AKASHI Takahiro 2018-11-15  117  struct kimage;
52b2a8af743604 AKASHI Takahiro 2018-11-15  118  
52b2a8af743604 AKASHI Takahiro 2018-11-15 @119  extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
52b2a8af743604 AKASHI Takahiro 2018-11-15 @120  extern int load_other_segments(struct kimage *image,
52b2a8af743604 AKASHI Takahiro 2018-11-15  121  		unsigned long kernel_load_addr, unsigned long kernel_size,
52b2a8af743604 AKASHI Takahiro 2018-11-15  122  		char *initrd, unsigned long initrd_len,
52b2a8af743604 AKASHI Takahiro 2018-11-15  123  		char *cmdline);
52b2a8af743604 AKASHI Takahiro 2018-11-15  124  #endif
52b2a8af743604 AKASHI Takahiro 2018-11-15  125  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
