Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6B2564392
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 03:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiGCBna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 21:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCBn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 21:43:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A6A63B9;
        Sat,  2 Jul 2022 18:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656812607; x=1688348607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OSVk8TVsRlITYlm+qWwWWkByFgjzt7WSCgcujDDdJmQ=;
  b=EKXEIC6d5Pr2akd7b9qQ23dzAIQRmYTGcRC8yoqjNR2RbwxVQvqZg0nT
   M8E9O0Hm4aFkz1Sw1uxfiygW1uj4VtLFWO4aqKUbZ30BxGisbfuRwI3pV
   27XeJc073vdKJXdzegmcUzfv7bLeKGDwYl+15VncTBB3APB19/FsM4rbL
   HwYmlwa7+OUVuEUWPZLw14sfag/68KyHqZzkSSfG7b9quZ95GRLB64NUd
   XPR93zGvvz6aoo4MRc89BhXrN7P4vyKzDXV1/amSJ495KjOfgYyRo67dR
   hIsDDXBTk5Up18+4+aQwjJXqxaxjWB5JAKwX5/D+RVwyKa6N29bBpcFSD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="308419503"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="308419503"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 18:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="542104810"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jul 2022 18:43:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7odv-000Fw7-Lc;
        Sun, 03 Jul 2022 01:43:23 +0000
Date:   Sun, 3 Jul 2022 09:42:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kbuild-all@lists.01.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: gadget: udc: tracing: Do not open code __string()
 with __dynamic_array()
Message-ID: <202207030931.QMgcEvNT-lkp@intel.com>
References: <20220702200127.399d2358@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702200127.399d2358@gandalf.local.home>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on linus/master v5.19-rc4 next-20220701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/USB-gadget-udc-tracing-Do-not-open-code-__string-with-__dynamic_array/20220703-080329
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
config: riscv-buildonly-randconfig-r001-20220703 (https://download.01.org/0day-ci/archive/20220703/202207030931.QMgcEvNT-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/63b33d8f7a24820f05bd2b8330b19c3d78e0c36f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Steven-Rostedt/USB-gadget-udc-tracing-Do-not-open-code-__string-with-__dynamic_array/20220703-080329
        git checkout 63b33d8f7a24820f05bd2b8330b19c3d78e0c36f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/usb/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/usb/gadget/udc/trace.h:289,
                    from drivers/usb/gadget/udc/trace.c:10:
>> drivers/usb/gadget/udc/./trace.h:217:41: error: expected expression before ';' token
     217 |                 __string(name, ep->name);
         |                                         ^
   include/trace/trace_events.h:244:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     244 |         tstruct                                                         \
         |         ^~~~~~~
   drivers/usb/gadget/udc/./trace.h:216:9: note: in expansion of macro 'TP_STRUCT__entry'
     216 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~


vim +217 drivers/usb/gadget/udc/./trace.h

   212	
   213	DECLARE_EVENT_CLASS(udc_log_req,
   214		TP_PROTO(struct usb_ep *ep, struct usb_request *req, int ret),
   215		TP_ARGS(ep, req, ret),
   216		TP_STRUCT__entry(
 > 217			__string(name, ep->name);
   218			__field(unsigned, length)
   219			__field(unsigned, actual)
   220			__field(unsigned, num_sgs)
   221			__field(unsigned, num_mapped_sgs)
   222			__field(unsigned, stream_id)
   223			__field(unsigned, no_interrupt)
   224			__field(unsigned, zero)
   225			__field(unsigned, short_not_ok)
   226			__field(int, status)
   227			__field(int, ret)
   228			__field(struct usb_request *, req)
   229		),
   230		TP_fast_assign(
   231			__assign_str(name, ep->name);
   232			__entry->length = req->length;
   233			__entry->actual = req->actual;
   234			__entry->num_sgs = req->num_sgs;
   235			__entry->num_mapped_sgs = req->num_mapped_sgs;
   236			__entry->stream_id = req->stream_id;
   237			__entry->no_interrupt = req->no_interrupt;
   238			__entry->zero = req->zero;
   239			__entry->short_not_ok = req->short_not_ok;
   240			__entry->status = req->status;
   241			__entry->ret = ret;
   242			__entry->req = req;
   243		),
   244		TP_printk("%s: req %p length %d/%d sgs %d/%d stream %d %s%s%s status %d --> %d",
   245			__get_str(name),__entry->req,  __entry->actual, __entry->length,
   246			__entry->num_mapped_sgs, __entry->num_sgs, __entry->stream_id,
   247			__entry->zero ? "Z" : "z",
   248			__entry->short_not_ok ? "S" : "s",
   249			__entry->no_interrupt ? "i" : "I",
   250			__entry->status, __entry->ret
   251		)
   252	);
   253	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
