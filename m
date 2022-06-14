Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845AF54A93E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiFNGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238738AbiFNGMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:12:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A7E19F9E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:12:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMdNQ5vHRzjY33;
        Tue, 14 Jun 2022 14:11:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 14:12:31 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 14:12:31 +0800
Message-ID: <85ee296a-b7cd-b4e0-e569-19f35c5519b7@huawei.com>
Date:   Tue, 14 Jun 2022 14:12:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kbuild-all@lists.01.org>, <linux-mm@kvack.org>,
        <hch@infradead.org>, <arnd@arndb.de>, <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
References: <20220607125027.44946-2-wangkefeng.wang@huawei.com>
 <202206141355.p1aTShLo-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202206141355.p1aTShLo-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/14 13:47, kernel test robot wrote:
> Hi Kefeng,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.19-rc2 next-20220610]
> [cannot apply to arm64/for-next/core arnd-asm-generic/master akpm-mm/mm-everything]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220607-204345
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e71e60cd74df9386c3f684c54888f2367050b831
> config: arm-randconfig-s031-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141355.p1aTShLo-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.4-30-g92122700-dirty
>          # https://github.com/intel-lab-lkp/linux/commit/5a6f8121572d1f82b599d118e9070ef4ba16183b
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220607-204345
>          git checkout 5a6f8121572d1f82b599d118e9070ef4ba16183b
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash fs/pstore/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>     fs/pstore/ram_core.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *to @@     got unsigned char * @@
>     fs/pstore/ram_core.c:278:9: sparse:     expected void volatile [noderef] __iomem *to
>     fs/pstore/ram_core.c:278:9: sparse:     got unsigned char *
>     fs/pstore/ram_core.c:311:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
>     fs/pstore/ram_core.c:311:9: sparse:     expected void const volatile [noderef] __iomem *from
>     fs/pstore/ram_core.c:311:9: sparse:     got unsigned char *
>     fs/pstore/ram_core.c:312:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *from @@     got unsigned char * @@
>     fs/pstore/ram_core.c:312:9: sparse:     expected void const volatile [noderef] __iomem *from
>     fs/pstore/ram_core.c:312:9: sparse:     got unsigned char *
>     fs/pstore/ram_core.c:466:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
>     fs/pstore/ram_core.c:466:20: sparse:     expected void *va
>     fs/pstore/ram_core.c:466:20: sparse:     got void [noderef] __iomem *
>     fs/pstore/ram_core.c:468:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
>     fs/pstore/ram_core.c:468:20: sparse:     expected void *va
>     fs/pstore/ram_core.c:468:20: sparse:     got void [noderef] __iomem *
>>> fs/pstore/ram_core.c:556:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *vaddr @@
>     fs/pstore/ram_core.c:556:36: sparse:     expected void volatile [noderef] __iomem *io_addr
>     fs/pstore/ram_core.c:556:36: sparse:     got void *vaddr
>     fs/pstore/ram_core.c:69:17: sparse: sparse: context imbalance in 'buffer_start_add' - unexpected unlock
>     fs/pstore/ram_core.c:95:17: sparse: sparse: context imbalance in 'buffer_size_add' - unexpected unlock
>
> vim +556 fs/pstore/ram_core.c
>
> bb4206f2042d95 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  545
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  546  void persistent_ram_free(struct persistent_ram_zone *prz)
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  547  {
> beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  548  	if (!prz)
> beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  549  		return;
> beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  550
> beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  551  	if (prz->vaddr) {
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  552  		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
> 831b624df1b420 fs/pstore/ram_core.c                     Bin Yang        2018-09-12  553  			/* We must vunmap() at page-granularity. */
> 831b624df1b420 fs/pstore/ram_core.c                     Bin Yang        2018-09-12  554  			vunmap(prz->vaddr - offset_in_page(prz->paddr));
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  555  		} else {
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11 @556  			iounmap(prz->vaddr);

The pstore should be fixed, not this patch,

     iounmap((void __iomem *)prz->vaddr);


> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  557  			release_mem_region(prz->paddr, prz->size);
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  558  		}
> beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  559  		prz->vaddr = NULL;
> beeb94321a7a6d fs/pstore/ram_core.c                     Anton Vorontsov 2012-06-18  560  	}
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  561  	if (prz->rs_decoder) {
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  562  		free_rs(prz->rs_decoder);
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  563  		prz->rs_decoder = NULL;
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  564  	}
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  565  	kfree(prz->ecc_info.par);
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  566  	prz->ecc_info.par = NULL;
> f2531f1976d98a fs/pstore/ram_core.c                     Kees Cook       2018-03-07  567
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  568  	persistent_ram_free_old(prz);
> 1227daa43bce13 fs/pstore/ram_core.c                     Kees Cook       2018-10-17  569  	kfree(prz->label);
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  570  	kfree(prz);
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  571  }
> d3b487695120b5 drivers/staging/android/persistent_ram.c Anton Vorontsov 2012-05-11  572
>
