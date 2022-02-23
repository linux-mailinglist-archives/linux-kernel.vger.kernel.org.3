Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D94C12CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiBWMhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 07:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238035AbiBWMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 07:37:09 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046F02D1CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 04:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645619801; x=1677155801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OdSCkrvWTIGBVhz8S1EekPKKnza/NTZR76i2du7AwlM=;
  b=m3jvOpyRO6OxsNVBoB4O1nNXIq11+OxlqKAJfzLIVXeCfRp3W3eGAYRA
   iaKKls8Mr21SGFZQbVywm2vRaYvwm/MZJL+VhJa2mM7GCkKxzojMuCv38
   7rDPEVje01fqpp0TjOPgexObqS7R7C7jIKVNvNtQw4EgsIBCndNu65Rvh
   EKWIFTH6QFAA6jq/VCgfq06x7rXoRuSage68iT7iJEq/CtiIWPYh/smjK
   SYW8B2Hx+GddKwXqPspZZxAO9LlWyUgqBwRP3gV/+5BzicuKBFd5R00vf
   IW0OydIOyInHvAaDGyCjTvQUNDHxC+FY1jkiSCuw6bXc1nkGd5Rs9q7gS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="239342448"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="239342448"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:36:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="532666200"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 04:36:26 -0800
Date:   Wed, 23 Feb 2022 20:34:05 +0800
From:   Philip Li <philip.li@intel.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, will@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [kbuild-all] Re: [PATCH v2 6/9] KVM: arm64: Detect and handle
 hypervisor stack overflows
Message-ID: <YhYpvfZaSjrAtkZp@rli9-dbox>
References: <20220222165212.2005066-7-kaleshsingh@google.com>
 <202202231727.L621fVgD-lkp@intel.com>
 <875yp63ptg.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yp63ptg.wl-maz@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:16:59AM +0000, Marc Zyngier wrote:
> On Wed, 23 Feb 2022 09:05:18 +0000,
> kernel test robot <lkp@intel.com> wrote:
> > 
> > Hi Kalesh,
> > 
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on cfb92440ee71adcc2105b0890bb01ac3cddb8507]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
> > base:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
> > config: arm64-randconfig-r011-20220221 (https://download.01.org/0day-ci/archive/20220223/202202231727.L621fVgD-lkp@intel.com/config)
> > compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://github.com/0day-ci/linux/commit/7fe99fd40f7c4b2973218045ca5b9c9160524db1
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Kalesh-Singh/KVM-arm64-Hypervisor-stack-enhancements/20220223-010522
> >         git checkout 7fe99fd40f7c4b2973218045ca5b9c9160524db1
> >         # save the config file to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >    #define NULL ((void *)0)
> >                 ^~~~~~~~~~~
> >    arch/arm64/kvm/hyp/nvhe/switch.c:200:27: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
> >            [ESR_ELx_EC_FP_ASIMD]           = kvm_hyp_handle_fpsimd,
> >                                              ^~~~~~~~~~~~~~~~~~~~~
> >    arch/arm64/kvm/hyp/nvhe/switch.c:196:28: note: previous initialization is here
> >            [0 ... ESR_ELx_EC_MAX]          = NULL,
> >                                              ^~~~
> >    include/linux/stddef.h:8:14: note: expanded from macro 'NULL'
> >    #define NULL ((void *)0)
> >                 ^~~~~~~~~~~
> 
> Kalesh, please ignore this nonsense. There may be things to improve,
> but this is *NOT* one of them.
> 
> These reports are pretty useless, and just lead people to ignore real
> bug reports.

Hi Kalesh, sorry there're some irrelevant issues mixed in the report,
kindly ignore them. And the valuable ones are the new ones that
prefixed by >>, as the below one in original report.

>> arch/arm64/kvm/hyp/nvhe/switch.c:372:17: warning: no previous prototype for function 'hyp_panic_bad_stack' [-Wmissing-prototypes]
   void __noreturn hyp_panic_bad_stack(void)
                   ^
Thanks

> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
