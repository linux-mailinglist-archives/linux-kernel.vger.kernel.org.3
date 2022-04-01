Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD04EE7B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 07:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245057AbiDAFTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 01:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiDAFTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 01:19:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BB1261338
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 22:17:52 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KV7gG2dbkzgYHW;
        Fri,  1 Apr 2022 13:16:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 13:17:50 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 13:17:49 +0800
Message-ID: <52ed7607-a4bb-947e-d76d-00715ad7634e@huawei.com>
Date:   Fri, 1 Apr 2022 13:17:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 resend 2/3] arm64: mm: Don't defer
 reserve_crashkernel() with dma_force_32bit
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kbuild-all@lists.01.org>, <vijayb@linux.microsoft.com>,
        <f.fainelli@gmail.com>
References: <20220331074055.125824-3-wangkefeng.wang@huawei.com>
 <202204010040.RUk6NuNS-lkp@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <202204010040.RUk6NuNS-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/1 0:14, kernel test robot wrote:
> Hi Kefeng,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on next-20220330]
> [cannot apply to arm64/for-next/core v5.17 v5.17-rc8 v5.17-rc7 v5.17]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-mm-Do-not-defer-reserve_crashkernel/20220331-152839
> base:    a67ba3cf9551f8c92d5ec9d7eae1aadbb9127b57
> config: arm64-buildonly-randconfig-r001-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010040.RUk6NuNS-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://github.com/intel-lab-lkp/linux/commit/970ec526bd69287a4eb9838600aaf66c46fde350
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Kefeng-Wang/arm64-mm-Do-not-defer-reserve_crashkernel/20220331-152839
>          git checkout 970ec526bd69287a4eb9838600aaf66c46fde350
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> arch/arm64/mm/init.c:108:13: warning: no previous prototype for 'crashkernel_could_early_reserve' [-Wmissing-prototypes]
>       108 | bool __init crashkernel_could_early_reserve(void)
>           |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Let's wait for some feedback, add <asm/kexec.h> into init.c could 
silence the warning.

thanks.

>
> vim +/crashkernel_could_early_reserve +108 arch/arm64/mm/init.c
>
>     107	
>   > 108	bool __init crashkernel_could_early_reserve(void)
>     109	{
>     110		if (!IS_ENABLED(CONFIG_ZONE_DMA))
>     111			return true;
>     112		if (arm64_dma_force_32bit)
>     113			return true;
>     114		return false;
>     115	}
>     116	
>
