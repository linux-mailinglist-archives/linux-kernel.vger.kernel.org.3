Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B570C49F8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbiA1MJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:09:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:21158 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234483AbiA1MJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643371761; x=1674907761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aovGcRhqRG1uGJXXes7TMxooAO2apW+D26PTIvucSHc=;
  b=g9CFihgxuzW6UKmKGJC+GOLoHmim55TNG1JA/AVPhB7YpE2FYsSbBkWe
   GCwbhu4UjrMi05mTPu74CBZQvEdfA5UhEeCtrAmxPphNsLMCmBcaVAo5W
   dv+brH+p069Aks/q/vJM3IQz0V/73G97+FqYRS6l0INxfanLRZbabL9dC
   2QDVqFF+p2BNhUYgAl+fxYqT7ee8IHZ1PEoawEg0ZU7HHPFlIn0MP36Fs
   hoGLIiVwWNg+HzIYlczf5YHCGFwyYPtFEZWpff/qXsrQxZ+VZ2v2S5p+D
   XvFOU6k0Q3uZ/8iOi3KCk1ZMQFbV1Jn6XeDq+dB0LybyozXW9irxNyFBg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="230686360"
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="230686360"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 04:09:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,323,1635231600"; 
   d="scan'208";a="697073685"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 28 Jan 2022 04:09:18 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDQ45-000Npq-Ng; Fri, 28 Jan 2022 12:09:17 +0000
Date:   Fri, 28 Jan 2022 20:08:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, stefanr@s5r6.in-berlin.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] drivers/firewire: use struct_size over open coded
 arithmetic
Message-ID: <202201282044.Ye1mhIOd-lkp@intel.com>
References: <20220128080336.1211525-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128080336.1211525-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ieee1394-linux1394/for-next]
[also build test ERROR on v5.17-rc1 next-20220128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/drivers-firewire-use-struct_size-over-open-coded-arithmetic/20220128-160602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git for-next
config: hexagon-randconfig-r015-20220128 (https://download.01.org/0day-ci/archive/20220128/202201282044.Ye1mhIOd-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1567c3f747219c35e83d9c1f4ac3c3d36f447d90
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/drivers-firewire-use-struct_size-over-open-coded-arithmetic/20220128-160602
        git checkout 1567c3f747219c35e83d9c1f4ac3c3d36f447d90
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/firewire/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/firewire/core-transaction.c:780:20: error: member reference type 'struct fw_request' is not a pointer; did you mean to use '.'?
           request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:326:18: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                               ~~~^
>> drivers/firewire/core-transaction.c:780:20: error: indirection requires pointer operand ('u32[]' (aka 'unsigned int[]') invalid)
           request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:326:14: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                              ^~~~~~~~~~~~
>> drivers/firewire/core-transaction.c:780:20: error: member reference type 'struct fw_request' is not a pointer; did you mean to use '.'?
           request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:326:49: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~
   include/linux/compiler.h:240:59: note: expanded from macro '__must_be_array'
   #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/linux/compiler_types.h:264:63: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                 ^
   include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
   #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                                ^
>> drivers/firewire/core-transaction.c:780:20: error: member reference type 'struct fw_request' is not a pointer; did you mean to use '.'?
           request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:326:49: note: expanded from macro 'struct_size'
                       sizeof(*(p)->member) + __must_be_array((p)->member),\
                                              ~~~~~~~~~~~~~~~~~~~^~~~~~~~~
   include/linux/compiler.h:240:65: note: expanded from macro '__must_be_array'
   #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   include/linux/compiler_types.h:264:74: note: expanded from macro '__same_type'
   #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
                                                                            ^
   include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
   #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                                ^
>> drivers/firewire/core-transaction.c:780:20: error: indirection requires pointer operand ('struct fw_request' invalid)
           request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/overflow.h:327:14: note: expanded from macro 'struct_size'
                       sizeof(*(p)))
                              ^~~~
   5 errors generated.


vim +780 drivers/firewire/core-transaction.c

   743	
   744	static struct fw_request *allocate_request(struct fw_card *card,
   745						   struct fw_packet *p)
   746	{
   747		struct fw_request *request;
   748		u32 *data, length;
   749		int request_tcode;
   750	
   751		request_tcode = HEADER_GET_TCODE(p->header[0]);
   752		switch (request_tcode) {
   753		case TCODE_WRITE_QUADLET_REQUEST:
   754			data = &p->header[3];
   755			length = 4;
   756			break;
   757	
   758		case TCODE_WRITE_BLOCK_REQUEST:
   759		case TCODE_LOCK_REQUEST:
   760			data = p->payload;
   761			length = HEADER_GET_DATA_LENGTH(p->header[3]);
   762			break;
   763	
   764		case TCODE_READ_QUADLET_REQUEST:
   765			data = NULL;
   766			length = 4;
   767			break;
   768	
   769		case TCODE_READ_BLOCK_REQUEST:
   770			data = NULL;
   771			length = HEADER_GET_DATA_LENGTH(p->header[3]);
   772			break;
   773	
   774		default:
   775			fw_notice(card, "ERROR - corrupt request received - %08x %08x %08x\n",
   776				 p->header[0], p->header[1], p->header[2]);
   777			return NULL;
   778		}
   779	
 > 780		request = kmalloc(struct_size(*request, data, length), GFP_ATOMIC);
   781		if (request == NULL)
   782			return NULL;
   783	
   784		request->response.speed = p->speed;
   785		request->response.timestamp =
   786				compute_split_timeout_timestamp(card, p->timestamp);
   787		request->response.generation = p->generation;
   788		request->response.ack = 0;
   789		request->response.callback = free_response_callback;
   790		request->ack = p->ack;
   791		request->length = length;
   792		if (data)
   793			memcpy(request->data, data, length);
   794	
   795		memcpy(request->request_header, p->header, sizeof(p->header));
   796	
   797		return request;
   798	}
   799	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
