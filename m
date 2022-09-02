Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF44C5ABAF0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiIBWvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIBWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:51:34 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E656F0759;
        Fri,  2 Sep 2022 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662159093; x=1693695093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c/19cmV74+lMDRhNQPWjhl5pMjXYVED88nc4t0Rx8I8=;
  b=EosBp1qwiJKW3q66gUE6SacWayrsWWesYaPjv9sjIdi7wLZc4ufcl70N
   cw0YYI1yDs57Kre4xUKS21tioq1oB0XlM1duKQT6pYVMxsWg5/8kp3U/7
   oknjI52lPPvFwXIRNrj19hl3L84qj540L713/sX2yl9q/FzbBha8iSh4q
   oCWKK8p6e2wPXBmGzq9Arcm7YXm+anMsfenBc3Es9GhfZwvDZ5pZ8smHZ
   oTQ55WPsAXviCVBvlqAkzLhVMc/SyfwhOyGtIFek+MPA/RKnND1Inn9bX
   n8dIirdNcRm7kel/6yEGCEnDLqOMo+lM0ZBLp+0OgyXnXoB6966Pesoft
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="360060348"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="360060348"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 15:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="613191709"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Sep 2022 15:51:27 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUFVX-0000gt-0M;
        Fri, 02 Sep 2022 22:51:27 +0000
Date:   Sat, 3 Sep 2022 06:50:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 3/3] fortify: Use SIZE_MAX instead of (size_t)-1
Message-ID: <202209030625.wdoOhjAW-lkp@intel.com>
References: <20220902204351.2521805-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902204351.2521805-4-keescook@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I love your patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master kees/for-next/pstore v6.0-rc3 next-20220901]
[cannot apply to kees/for-next/hardening]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/Fix-FORTIFY-y-UBSAN_LOCAL_BOUNDS-y/20220903-044622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030625.wdoOhjAW-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c991b3511a531e44e856fdf2b64020b70fd7b22
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kees-Cook/Fix-FORTIFY-y-UBSAN_LOCAL_BOUNDS-y/20220903-044622
        git checkout 6c991b3511a531e44e856fdf2b64020b70fd7b22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc prepare

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/string.h:253,
                    from include/linux/uuid.h:12,
                    from include/linux/mod_devicetable.h:13,
                    from scripts/mod/devicetable-offsets.c:3:
   include/linux/fortify-string.h: In function 'strcat':
>> include/linux/fortify-string.h:98:23: error: 'SIZE_MAX' undeclared (first use in this function)
      98 |         if (p_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:6:1: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
       5 | #include <linux/const.h>
     +++ |+#include <stdint.h>
       6 | 
   include/linux/fortify-string.h:98:23: note: each undeclared identifier is reported only once for each function it appears in
      98 |         if (p_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h: In function 'strnlen':
   include/linux/fortify-string.h:20:24: error: 'SIZE_MAX' undeclared (first use in this function)
      20 |         size_t __ret = SIZE_MAX;                                \
         |                        ^~~~~~~~
   include/linux/fortify-string.h:109:24: note: in expansion of macro '__compiletime_strlen'
     109 |         size_t p_len = __compiletime_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h:20:24: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
      20 |         size_t __ret = SIZE_MAX;                                \
         |                        ^~~~~~~~
   include/linux/fortify-string.h:109:24: note: in expansion of macro '__compiletime_strlen'
     109 |         size_t p_len = __compiletime_strlen(p);
         |                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/fortify-string.h: In function '__fortify_strlen':
   include/linux/fortify-string.h:141:23: error: 'SIZE_MAX' undeclared (first use in this function)
     141 |         if (p_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:141:23: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   include/linux/fortify-string.h: In function 'strlcpy':
   include/linux/fortify-string.h:158:23: error: 'SIZE_MAX' undeclared (first use in this function)
     158 |         if (p_size == SIZE_MAX && q_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:158:23: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   include/linux/fortify-string.h: In function 'strscpy':
   include/linux/fortify-string.h:186:23: error: 'SIZE_MAX' undeclared (first use in this function)
     186 |         if (p_size == SIZE_MAX && q_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:186:23: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   include/linux/fortify-string.h: In function 'strncat':
   include/linux/fortify-string.h:231:23: error: 'SIZE_MAX' undeclared (first use in this function)
     231 |         if (p_size == SIZE_MAX && q_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:231:23: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   include/linux/fortify-string.h: In function 'fortify_memset_chk':
   include/linux/fortify-string.h:275:23: error: 'SIZE_MAX' undeclared (first use in this function)
     275 |         if (p_size != SIZE_MAX && p_size < size)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:275:23: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   include/linux/fortify-string.h: In function 'fortify_memcpy_chk':
   include/linux/fortify-string.h:369:24: error: 'SIZE_MAX' undeclared (first use in this function)
     369 |         if ((p_size != SIZE_MAX && p_size < size) ||
         |                        ^~~~~~~~
   include/linux/fortify-string.h:369:24: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   include/linux/fortify-string.h: In function 'strcpy':
   include/linux/fortify-string.h:469:23: error: 'SIZE_MAX' undeclared (first use in this function)
     469 |         if (p_size == SIZE_MAX && q_size == SIZE_MAX)
         |                       ^~~~~~~~
   include/linux/fortify-string.h:469:23: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
   make[2]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1204: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:222: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/SIZE_MAX +98 include/linux/fortify-string.h

    92	
    93	__FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
    94	char *strcat(char * const POS p, const char *q)
    95	{
    96		size_t p_size = __builtin_object_size(p, 1);
    97	
  > 98		if (p_size == SIZE_MAX)
    99			return __underlying_strcat(p, q);
   100		if (strlcat(p, q, p_size) >= p_size)
   101			fortify_panic(__func__);
   102		return p;
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
