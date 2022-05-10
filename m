Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94635520C98
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbiEJEOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 00:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbiEJEOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 00:14:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41675237BB8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652155836; x=1683691836;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pZI8Srqaj61POAYH9wu17vcSTu4Q3RlLawBWPfJDM24=;
  b=N7vxNNlc+RP0KSzRoTt6D+IQwa+E0U0aqTVwn2U9E+lHJfjWgyvc7Ok8
   o4Ad6m0DvSvMkuKaHJJxznpN5yJnwYwfex/WrEKIhtB6DKYMjhlWIMLcH
   n2zjXM1Fn+zPEWRRlV+D6GdX+fVbg4RzkzdpX2EqpKRONy77fy4ONAmXf
   CZBB2i8SaAHar8XkVfwjcfJHqpJOMd2NaUhLSQd/JNxbVBkGeySemliYC
   98/yUvDxwgJVAaiHvFIjmrCaN1oGPduzoyDDCJNWCuwvlw5XazOwKDM5+
   2zoX+EhgHUBJeU2hmZLrmOtGs+U2Z1PDk5IknVuRqx0qqbq5ASgHPYGZ6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269186943"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="269186943"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 21:10:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="635487894"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 May 2022 21:10:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noHCj-000HHO-Ly;
        Tue, 10 May 2022 04:10:33 +0000
Date:   Tue, 10 May 2022 12:09:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:objtool/core 28/30] vmlinux.o: warning: objtool:
 vmx_vcpu_enter_exit+0x2b: call to context_tracking_enabled_this_cpu() leaves
 .noinstr.text section
Message-ID: <202205101246.lcyxYVIW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
head:   555418d98dd896ec418776a7d1951699eac1e760
commit: a8435730af097b0415673ecb4bed86a577615425 [28/30] jump_label,noinstr: Avoid instrumentation for JUMP_LABEL=n builds
config: x86_64-randconfig-a013-20220509 (https://download.01.org/0day-ci/archive/20220510/202205101246.lcyxYVIW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=a8435730af097b0415673ecb4bed86a577615425
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue objtool/core
        git checkout a8435730af097b0415673ecb4bed86a577615425
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x2b: call to context_tracking_enabled_this_cpu() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode+0x49: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x5a: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0x49: call to on_thread_stack() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0x49: call to on_thread_stack() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
