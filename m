Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124BB4B5475
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355750AbiBNPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:19:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355749AbiBNPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:19:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC14A5BD24;
        Mon, 14 Feb 2022 07:19:09 -0800 (PST)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jy7CD6Xbbz6899G;
        Mon, 14 Feb 2022 23:18:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 16:19:07 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Feb
 2022 15:19:06 +0000
Date:   Mon, 14 Feb 2022 15:19:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        <linux-sh@vger.kernel.org>
Subject: Re: drivers/iio/adc/xilinx-ams.c:1195:21: error: unused variable
 'ams'
Message-ID: <20220214151905.00005a27@Huawei.com>
In-Reply-To: <202202142203.4ofqbic9-lkp@intel.com>
References: <202202142203.4ofqbic9-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 22:47:14 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   754e0b0e35608ed5206d6a67a791563c631cec07
> commit: d5c70627a79455154f5f636096abe6fe57510605 iio: adc: Add Xilinx AMS driver
> date:   8 weeks ago
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220214/202202142203.4ofqbic9-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5c70627a79455154f5f636096abe6fe57510605
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout d5c70627a79455154f5f636096abe6fe57510605
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash drivers/iio/adc/ drivers/net/ethernet/freescale/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

I'm very tempted to say won't fix on this at least not in the IIO code.

The issue I think is the stub for iounmap on sh with no MMU not using the argument because it's
defined as a while loop rather than as an empty static inline function which is what we'd
get it it wasn't defined at all (AFAICT).

If anyone wants to take this on, my guess is drop
https://elixir.bootlin.com/linux/latest/source/arch/sh/include/asm/io.h#L274
and see if everything still works and the warning goes away.

+CC linux-sh for inputs.

Thanks,

Jonathan


> 
> All errors (new ones prefixed by >>):
> 
>    drivers/iio/adc/xilinx-ams.c: In function 'ams_iounmap_ps':
> >> drivers/iio/adc/xilinx-ams.c:1195:21: error: unused variable 'ams' [-Werror=unused-variable]  
>     1195 |         struct ams *ams = data;
>          |                     ^~~
>    drivers/iio/adc/xilinx-ams.c: In function 'ams_iounmap_pl':
>    drivers/iio/adc/xilinx-ams.c:1202:21: error: unused variable 'ams' [-Werror=unused-variable]
>     1202 |         struct ams *ams = data;
>          |                     ^~~
>    cc1: all warnings being treated as errors
> 
> 
> vim +/ams +1195 drivers/iio/adc/xilinx-ams.c
> 
>   1192	
>   1193	static void ams_iounmap_ps(void *data)
>   1194	{
> > 1195		struct ams *ams = data;  
>   1196	
>   1197		iounmap(ams->ps_base);
>   1198	}
>   1199	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

