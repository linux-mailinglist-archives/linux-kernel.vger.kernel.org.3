Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0EE4D1005
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiCHGSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244224AbiCHGSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:18:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D9C3C72A;
        Mon,  7 Mar 2022 22:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646720238; x=1678256238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUoapiglXBZdB+xUrXHwyfLIrHMQEETInYEPrlsdhzg=;
  b=XWpcuEvQYaKqw5NRVUtvPablplxEGDGBOVG8trR6cX4Ym2LZlkaIaG2F
   YpAAPhICGUrjbYP4HqVibFfhNv+YJ/2ms1JNeGnIqd272/WOC07KsVyri
   9zql+N4Az2G40nUAzJL3giTqb81OfvUBYYm+Xx1yiqSDCik2kFjCfeVBa
   nngDXSpodA+9r6PCKDoP03xkBFFN2TnqBurIztUt4oeJQRkkTnvGzDXIk
   REbdYhu+HRkrb5V4JC2g9Xg3SxQ9ngTBO0dTLYvfLRyAKp63pJwbOjg6h
   5vAAN13s1TFLoWVyUYSX13GvnF6xcFyj8g2uA6t1jN1QhnS4pvqI8Hx2z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="341036085"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="341036085"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 22:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="643543418"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 22:17:14 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRT9l-00010a-Jk; Tue, 08 Mar 2022 06:17:13 +0000
Date:   Tue, 8 Mar 2022 14:16:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 2/4] usb: host: add xhci hooks for USB offload
Message-ID: <202203081440.zCZudmlJ-lkp@intel.com>
References: <891095110.61646375404257.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <891095110.61646375404257.JavaMail.epsvc@epcpadp3>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daehwan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on krzk/for-next]
[also build test ERROR on char-misc/char-misc-testing v5.17-rc7]
[cannot apply to usb/usb-testing next-20220307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220304-143406
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
config: hexagon-randconfig-r045-20220304 (https://download.01.org/0day-ci/archive/20220308/202203081440.zCZudmlJ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2b6a5d700c2bbb0a3ccfcd6e83a7f7b2ea049db9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Daehwan-Jung/usb-host-export-symbols-for-xhci-hooks-usage/20220304-143406
        git checkout 2b6a5d700c2bbb0a3ccfcd6e83a7f7b2ea049db9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/host/xhci.c:4361:5: warning: no previous prototype for function 'xhci_address_device' [-Wmissing-prototypes]
   int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
       ^
   drivers/usb/host/xhci.c:4361:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int xhci_address_device(struct usb_hcd *hcd, struct usb_device *udev)
   ^
   static 
>> drivers/usb/host/xhci.c:4459:15: error: no member named 'vendor_ops' in 'struct xhci_hcd'
           return xhci->vendor_ops;
                  ~~~~  ^
   drivers/usb/host/xhci.c:5421:23: warning: shift count >= width of type [-Wshift-count-overflow]
                           !dma_set_mask(dev, DMA_BIT_MASK(64))) {
                           ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:52: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                      ^~~~
   drivers/usb/host/xhci.c:5421:23: warning: shift count >= width of type [-Wshift-count-overflow]
                           !dma_set_mask(dev, DMA_BIT_MASK(64))) {
                           ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:61: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                               ^~~~
   drivers/usb/host/xhci.c:5421:23: warning: shift count >= width of type [-Wshift-count-overflow]
                           !dma_set_mask(dev, DMA_BIT_MASK(64))) {
                           ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^
   include/linux/compiler.h:56:47: note: expanded from macro 'if'
   #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:58:86: note: expanded from macro '__trace_if_var'
   #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
                                                                       ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:69:3: note: expanded from macro '__trace_if_value'
           (cond) ?                                        \
            ^~~~
   drivers/usb/host/xhci.c:5423:30: warning: shift count >= width of type [-Wshift-count-overflow]
                   dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
                                              ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   5 warnings and 1 error generated.
--
>> drivers/usb/host/xhci-plat.c:205:15: error: no member named 'vendor_ops' in 'struct xhci_hcd'
                   ops = xhci->vendor_ops = xhci_plat_vendor_overwrite.vendor_ops;
                         ~~~~  ^
   drivers/usb/host/xhci-plat.c:219:8: error: no member named 'vendor_ops' in 'struct xhci_hcd'
           xhci->vendor_ops = NULL;
           ~~~~  ^
   drivers/usb/host/xhci-plat.c:268:10: warning: shift count >= width of type [-Wshift-count-overflow]
                                                      DMA_BIT_MASK(64));
                                                      ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   drivers/usb/host/xhci-plat.c:270:43: warning: shift count >= width of type [-Wshift-count-overflow]
                   ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
                                                           ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:76:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   2 warnings and 2 errors generated.


vim +4459 drivers/usb/host/xhci.c

  4456	
  4457	struct xhci_vendor_ops *xhci_vendor_get_ops(struct xhci_hcd *xhci)
  4458	{
> 4459		return xhci->vendor_ops;
  4460	}
  4461	EXPORT_SYMBOL_GPL(xhci_vendor_get_ops);
  4462	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
