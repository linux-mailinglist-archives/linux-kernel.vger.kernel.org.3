Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D984B52ED55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 15:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349541AbiETNjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349898AbiETNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 09:39:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA57169E3B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653053989; x=1684589989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tEsNkD67VlMRMMbJpoolW2AuTZVamWWhFYXi0Uoe5Js=;
  b=ROaTiu4dGndqNw9TQ06QbwwWYMvS9fK5zOvMYfJ0JwtLycRxyOlLWG8y
   olOyHJE6NAZQet4SiipT69Rv8b4j2rZEMJ1zVk9GAOT7ycTcEeQIDIdfY
   fYBqRH8nQM39+08TuWTdav4O8hxrSEhEWqUL7jZc/zSCoUj4jz3+plcjL
   vmwD82O7pcruMtuOtxKrP7BCG3Qr19lxa/9R5Y54HKLKMc3mWd6APVfjR
   QBpZwYHHQHFKZd5wm8Pyurs14s+k4aFsP9+TkiCvMsGNxW1Bc+VG6zCXB
   i95khF3dHJQonYlpGURWNT1tf6DgxZRz+4KWFto+B+XiWhR30atYelzuE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253123435"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="253123435"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 06:39:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="818556999"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 May 2022 06:39:46 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ns2r3-0004k5-Eb;
        Fri, 20 May 2022 13:39:45 +0000
Date:   Fri, 20 May 2022 21:39:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com, mst@redhat.com, david@redhat.com
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org, pbonzini@redhat.com,
        peterx@redhat.com, qemu-devel@nongnu.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 3/3] virtio_balloon: Introduce memory recover
Message-ID: <202205202151.7T3K7Szf-lkp@intel.com>
References: <20220520070648.1794132-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520070648.1794132-4-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhenwei,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20220519]
[cannot apply to linux/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: nios2-randconfig-r002-20220519 (https://download.01.org/0day-ci/archive/20220520/202205202151.7T3K7Szf-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a42127073dd4adb6354649c8235c5cde033d01f2
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review zhenwei-pi/recover-hardware-corrupted-page-by-virtio-balloon/20220520-151328
        git checkout a42127073dd4adb6354649c8235c5cde033d01f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/virtio/virtio_balloon.o: in function `unpoison_memory_func':
>> drivers/virtio/virtio_balloon.c:679: undefined reference to `unpoison_memory'
   drivers/virtio/virtio_balloon.c:679:(.text+0xc00): relocation truncated to fit: R_NIOS2_CALL26 against `unpoison_memory'
   nios2-linux-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_probe':
>> drivers/virtio/virtio_balloon.c:1247: undefined reference to `register_memory_failure_notifier'
   drivers/virtio/virtio_balloon.c:1247:(.text+0x1940): relocation truncated to fit: R_NIOS2_CALL26 against `register_memory_failure_notifier'
   nios2-linux-ld: drivers/virtio/virtio_balloon.o: in function `virtballoon_remove':
>> drivers/virtio/virtio_balloon.c:1323: undefined reference to `unregister_memory_failure_notifier'
   drivers/virtio/virtio_balloon.c:1323:(.text+0x1bcc): relocation truncated to fit: R_NIOS2_CALL26 against `unregister_memory_failure_notifier'


vim +679 drivers/virtio/virtio_balloon.c

   661	
   662	static void unpoison_memory_func(struct work_struct *work)
   663	{
   664		struct virtio_balloon *vb;
   665		struct page *page;
   666	
   667		vb = container_of(work, struct virtio_balloon, unpoison_memory_work);
   668	
   669		do {
   670			spin_lock(&vb->recover_page_list_lock);
   671			page = list_first_entry_or_null(&vb->recovered_page_list,
   672							struct page, lru);
   673			if (page)
   674				list_del(&page->lru);
   675			spin_unlock(&vb->recover_page_list_lock);
   676	
   677			if (page) {
   678				put_page(page);
 > 679				unpoison_memory(page_to_pfn(page), true, "virtio-balloon");
   680			}
   681		} while (page);
   682	}
   683	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
