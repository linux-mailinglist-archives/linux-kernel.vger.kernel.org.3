Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B050817D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358824AbiDTGzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiDTGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:55:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DA31DCD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:52:34 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KjrvX71XnzhY0x;
        Wed, 20 Apr 2022 14:52:24 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 14:52:31 +0800
Subject: Re: [kbuild-all] Re: [PATCH] mm/swap: Fix lost swap bits in
 unuse_pte()
To:     Philip Li <philip.li@intel.com>
CC:     kernel test robot <lkp@intel.com>, Peter Xu <peterx@redhat.com>,
        <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <david@redhat.com>, <apopple@nvidia.com>, <surenb@google.com>,
        <minchan@kernel.org>, <sfr@canb.auug.org.au>,
        <rcampbell@nvidia.com>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <Yl8rZkhU/B0iE2ob@xz-m1.local>
 <202204201313.QYiDBRbL-lkp@intel.com>
 <c14c0865-867c-ca14-8b2c-7e6e94ee7c85@huawei.com>
 <Yl+qqmH19VxwgK4C@rli9-dbox>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <43b526a9-7ab8-fea7-8cd3-9aa7a444ffae@huawei.com>
Date:   Wed, 20 Apr 2022 14:52:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Yl+qqmH19VxwgK4C@rli9-dbox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/20 14:39, Philip Li wrote:
> On Wed, Apr 20, 2022 at 02:23:27PM +0800, Miaohe Lin wrote:
>> On 2022/4/20 13:56, kernel test robot wrote:
>>> Hi Peter,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on hnaz-mm/master]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Xu/mm-swap-Fix-lost-swap-bits-in-unuse_pte/20220420-053845
>>> base:   https://github.com/hnaz/linux-mm master
>>> config: s390-randconfig-r023-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201313.QYiDBRbL-lkp@intel.com/config)
>>> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
>>> reproduce (this is a W=1 build):
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # install s390 cross compiling tool for clang build
>>>         # apt-get install binutils-s390x-linux-gnu
>>>         # https://github.com/intel-lab-lkp/linux/commit/355ac3eb45402f7aab25b76af029d4390af05238
>>>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>>>         git fetch --no-tags linux-review Peter-Xu/mm-swap-Fix-lost-swap-bits-in-unuse_pte/20220420-053845
>>>         git checkout 355ac3eb45402f7aab25b76af029d4390af05238
>>>         # save the config file
>>>         mkdir build_dir && cp config build_dir/.config
>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>
>> The variable name is newpte. But it's written as new_pte latter. Many thanks for report!
>>
>> BTW: Since this is not a formal patch (no compile tested). Is Reported-by tag still needed?
> 
> thanks, this is not needed. It mostly needed for already upstreamed one
> and actually not mandatory from 0-day ci perspective.

I see. Many thanks for your clarifying and meaningful work! :)

> 

