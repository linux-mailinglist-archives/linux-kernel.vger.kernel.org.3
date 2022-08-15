Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE47C592E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiHOLTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiHOLTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:19:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B513419C2A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660562375; x=1692098375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u4j+P2AYLf2Rip60t2taFoU+Un2/+pDH3YG4514Qg9A=;
  b=EMkSR+1Ok5SLAwW8+/2WnLii/qpgCX9jIrzCSkGJenB9g6HO9bn+nSJe
   2dhKwkv9XvCj+4QwEHQ6nxbrYmk1i6aJXu4F/Ko2/bNlePUa1k7BI+7HT
   6+mJACV/mpHiMbGzU8VLI6/yTLWL6lumBDca19fOTu3sCoJ7ZjYQIrztq
   GV+Ifupjv8kgNa9oFC/B1dyXgdLadZyOnFPQq7sn//gE5BGwi7+S6Xvas
   t03UlpCbL52mM0ZyELezDM813xhCSh/gVfvMaErfHA6+k9Cj+B6oNnUvx
   ejZer3PPDJRmX8DEWtJVoUVR3zxEzEnzBqrhat5pYKdHdYRlsUXEBqbLQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="291936210"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="291936210"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 04:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="748891002"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2022 04:19:33 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNY84-0000y7-12;
        Mon, 15 Aug 2022 11:19:32 +0000
Date:   Mon, 15 Aug 2022 19:19:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk
Cc:     kbuild-all@lists.01.org, nixiaoming@huawei.com, wangle6@huawei.com,
        yi.zhang@huawei.com, wangbing6@huawei.com, zhongjubin@huawei.com,
        chenjianguo3@huawei.com
Subject: Re: [PATCH 1/2] squashfs: add the mount parameter
 theads=<single|multi|percpu>
Message-ID: <202208151921.Y0vJnA6c-lkp@intel.com>
References: <20220815031100.75243-2-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815031100.75243-2-nixiaoming@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaoming,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v6.0-rc1]
[also build test WARNING on linus/master next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaoming-Ni/squashfs-Add-the-mount-parameter-threads/20220815-111318
base:    568035b01cfb107af8d2e4bd2fb9aea22cf5b868
config: sparc-randconfig-s042-20220814 (https://download.01.org/0day-ci/archive/20220815/202208151921.Y0vJnA6c-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/dcb72eaed7732d884148ce37d23442956296d0d6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiaoming-Ni/squashfs-Add-the-mount-parameter-threads/20220815-111318
        git checkout dcb72eaed7732d884148ce37d23442956296d0d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash fs/squashfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> fs/squashfs/decompressor_multi_percpu.c:85:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got void * @@
   fs/squashfs/decompressor_multi_percpu.c:85:18: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/squashfs/decompressor_multi_percpu.c:85:18: sparse:     got void *
   fs/squashfs/decompressor_multi_percpu.c:86:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t * @@
   fs/squashfs/decompressor_multi_percpu.c:86:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/squashfs/decompressor_multi_percpu.c:86:9: sparse:     got struct local_lock_t *
   fs/squashfs/decompressor_multi_percpu.c:91:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct local_lock_t * @@
   fs/squashfs/decompressor_multi_percpu.c:91:9: sparse:     expected void const [noderef] __percpu *__vpp_verify
   fs/squashfs/decompressor_multi_percpu.c:91:9: sparse:     got struct local_lock_t *

vim +85 fs/squashfs/decompressor_multi_percpu.c

d208383d640727 Phillip Lougher  2013-11-18   77  
dcb72eaed7732d Xiaoming Ni      2022-08-15   78  static int squashfs_decompress_percpu(struct squashfs_sb_info *msblk, struct bio *bio,
93e72b3c612adc Philippe Liard   2020-06-01   79  	int offset, int length, struct squashfs_page_actor *output)
d208383d640727 Phillip Lougher  2013-11-18   80  {
dcb72eaed7732d Xiaoming Ni      2022-08-15   81  	struct squashfs_stream_percpu *stream;
fd56200a16c72c Julia Cartwright 2020-05-27   82  	int res;
fd56200a16c72c Julia Cartwright 2020-05-27   83  
dcb72eaed7732d Xiaoming Ni      2022-08-15   84  	preempt_disable();
fd56200a16c72c Julia Cartwright 2020-05-27  @85  	stream = this_cpu_ptr(msblk->stream);
dcb72eaed7732d Xiaoming Ni      2022-08-15   86  	local_lock(&stream->lock);
fd56200a16c72c Julia Cartwright 2020-05-27   87  
93e72b3c612adc Philippe Liard   2020-06-01   88  	res = msblk->decompressor->decompress(msblk, stream->stream, bio,
846b730e99518a Phillip Lougher  2013-11-18   89  					      offset, length, output);
fd56200a16c72c Julia Cartwright 2020-05-27   90  
dcb72eaed7732d Xiaoming Ni      2022-08-15   91  	local_unlock(&stream->lock);
dcb72eaed7732d Xiaoming Ni      2022-08-15   92  	preempt_enable();
d208383d640727 Phillip Lougher  2013-11-18   93  
d208383d640727 Phillip Lougher  2013-11-18   94  	if (res < 0)
d208383d640727 Phillip Lougher  2013-11-18   95  		ERROR("%s decompression failed, data probably corrupt\n",
d208383d640727 Phillip Lougher  2013-11-18   96  			msblk->decompressor->name);
d208383d640727 Phillip Lougher  2013-11-18   97  
d208383d640727 Phillip Lougher  2013-11-18   98  	return res;
d208383d640727 Phillip Lougher  2013-11-18   99  }
d208383d640727 Phillip Lougher  2013-11-18  100  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
