Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE7F55026E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 05:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiFRDZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 23:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiFRDZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:25:31 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462DB34BAB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 20:25:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VGi1y7J_1655522722;
Received: from 30.13.184.185(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VGi1y7J_1655522722)
          by smtp.aliyun-inc.com;
          Sat, 18 Jun 2022 11:25:24 +0800
Message-ID: <c9910b68-e10e-46bf-4369-88377cd89f05@linux.alibaba.com>
Date:   Sat, 18 Jun 2022 11:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] arm64/hugetlb: Implement arm64 specific
 hugetlb_mask_last_hp
To:     kernel test robot <lkp@intel.com>, mike.kravetz@oracle.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7256dbe078d7231f45b0f47c2c52a3bd3aa10da7.1655350193.git.baolin.wang@linux.alibaba.com>
 <202206172000.6Fwmo99P-lkp@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <202206172000.6Fwmo99P-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/17/2022 8:17 PM, kernel test robot wrote:
> Hi Baolin,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on linus/master v5.19-rc2 next-20220617]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/arm64-hugetlb-Implement-arm64-specific-hugetlb_mask_last_hp/20220616-113640
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-randconfig-r011-20220616 (https://download.01.org/0day-ci/archive/20220617/202206172000.6Fwmo99P-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install arm64 cross compiling tool for clang build
>          # apt-get install binutils-aarch64-linux-gnu
>          # https://github.com/intel-lab-lkp/linux/commit/f1309dfbc2b70ec5dd72ac38e95a49b7be42b9b6
>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>          git fetch --no-tags linux-review Baolin-Wang/arm64-hugetlb-Implement-arm64-specific-hugetlb_mask_last_hp/20220616-113640
>          git checkout f1309dfbc2b70ec5dd72ac38e95a49b7be42b9b6
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for your reporting. However this patch is based on the Mike's 
series [1] and has been folded into this series. So just skip testing 
this patch separately. Thanks.

https://lore.kernel.org/all/20220616210518.125287-1-mike.kravetz@oracle.com/
