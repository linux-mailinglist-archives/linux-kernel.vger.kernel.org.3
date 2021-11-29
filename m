Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F300460FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhK2IGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:06:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:25941 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242128AbhK2IEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:04:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="233409049"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="233409049"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 00:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="458348054"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 29 Nov 2021 00:01:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrbau-000Bhy-Lt; Mon, 29 Nov 2021 08:01:00 +0000
Date:   Mon, 29 Nov 2021 16:00:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH 2/2] misc: fastrpc: Add dma handle implementation
Message-ID: <202111291504.W1SMyI4E-lkp@intel.com>
References: <1638163720-23123-3-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638163720-23123-3-git-send-email-jeyr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.16-rc3 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeya-R/Add-DMA-handle-implementation/20211129-133228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git cd455ebb748c4e198c8158e5d61b3034bf10f22b
config: hexagon-randconfig-r045-20211129 (https://download.01.org/0day-ci/archive/20211129/202111291504.W1SMyI4E-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project df08b2fe8b35cb63dfb3b49738a3494b9b4e6f8e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d8e9cc594aeafa392d306e883c741b984b5fc89a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/Add-DMA-handle-implementation/20211129-133228
        git checkout d8e9cc594aeafa392d306e883c741b984b5fc89a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/misc/fastrpc.c:721:17: error: use of 'fastrpc_remote_arg' with tag type that does not match previous declaration
           size = (sizeof(struct fastrpc_remote_arg) +
                          ^~~~~~
                          union
   drivers/misc/fastrpc.c:106:7: note: previous use is here
   union fastrpc_remote_arg {
         ^
   drivers/misc/fastrpc.c:925:2: error: use of 'fastrpc_remote_arg' with tag type that does not match previous declaration
           struct fastrpc_remote_arg *rpra = ctx->rpra;
           ^~~~~~
           union
   drivers/misc/fastrpc.c:106:7: note: previous use is here
   union fastrpc_remote_arg {
         ^
>> drivers/misc/fastrpc.c:942:43: error: no member named 'pv' in 'union fastrpc_remote_arg'
                           void *src = (void *)(uintptr_t)rpra[i].pv;
                                                          ~~~~~~~ ^
>> drivers/misc/fastrpc.c:944:22: error: no member named 'len' in 'union fastrpc_remote_arg'
                           u64 len = rpra[i].len;
                                     ~~~~~~~ ^
   drivers/misc/fastrpc.c:958:25: error: use of undeclared identifier 'fl'
                   if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
                                         ^
   5 errors generated.


vim +/fastrpc_remote_arg +721 drivers/misc/fastrpc.c

c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  689  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  690  /*
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  691   * Fastrpc payload buffer with metadata looks like:
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  692   *
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  693   * >>>>>>  START of METADATA <<<<<<<<<
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  694   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  695   * |           Arguments             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  696   * | type:(struct fastrpc_remote_arg)|
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  697   * |             (0 - N)             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  698   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  699   * |         Invoke Buffer list      |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  700   * | type:(struct fastrpc_invoke_buf)|
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  701   * |           (0 - N)               |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  702   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  703   * |         Page info list          |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  704   * | type:(struct fastrpc_phy_page)  |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  705   * |             (0 - N)             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  706   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  707   * |         Optional info           |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  708   * |(can be specific to SoC/Firmware)|
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  709   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  710   * >>>>>>>>  END of METADATA <<<<<<<<<
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  711   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  712   * |         Inline ARGS             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  713   * |            (0-N)                |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  714   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  715   */
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  716  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  717  static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  718  {
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  719  	int size = 0;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  720  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08 @721  	size = (sizeof(struct fastrpc_remote_arg) +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  722  		sizeof(struct fastrpc_invoke_buf) +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  723  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  724  		sizeof(u64) * FASTRPC_MAX_FDLIST +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  725  		sizeof(u32) * FASTRPC_MAX_CRCLIST;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  726  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  727  	return size;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  728  }
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  729  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
