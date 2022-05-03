Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA87E518583
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbiECNgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiECNgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:36:18 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A963388F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651584766; x=1683120766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KOfK7zf5QeWpOtGSjy9RSCuufoPzv9zOHllZZURoFt8=;
  b=XdF1nshb16ckmN9guVw0NOVrwFuNCiKTkk1mOY819tNjTkCcZZlGYmh0
   4YZjVtW7eQAXiWb/U0YaBkxj8S5RXGSAV6esSVB9A5Vax8t5TBAC1nM36
   9aojdjrjihLDRtxp+t1QLwgksCWlLYVG1xQ9hwUh7LISNQnMPfBDyysao
   tdTS1DA/YXV+xH2TQSXbnN3MQVyHbqovF6ScxDrwtLl8MN/hJJ+BTXpOf
   JAT/VMlxW/OVBkKP3nPWr40RfncAEnLLpxQJ/wFTm/H/PoXZWY0djU/Vo
   hQFxl0JZWtH0WtB+JVJhXdA/D/lBn9IgkZog2yN2Hs0WY9jot5OAkQGTI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="328017527"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="328017527"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 06:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="663976902"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 May 2022 06:32:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlsdv-000AUh-Fv;
        Tue, 03 May 2022 13:32:43 +0000
Date:   Tue, 3 May 2022 21:32:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Schnelle <svens@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] audit: add call argument to socketcall auditing
Message-ID: <202205032108.vBdGwIXf-lkp@intel.com>
References: <20220503090212.1322050-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503090212.1322050-1-svens@linux.ibm.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on pcmoore-audit/next v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/audit-add-call-argument-to-socketcall-auditing/20220503-170442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9050ba3a61a4b5bd84c2cde092a100404f814f31
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220503/202205032108.vBdGwIXf-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/b89caaec1c1bd3382c6cef08d08beadbaf808513
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sven-Schnelle/audit-add-call-argument-to-socketcall-auditing/20220503-170442
        git checkout b89caaec1c1bd3382c6cef08d08beadbaf808513
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   net/socket.c: In function '__sys_getsockopt':
   net/socket.c:2206:13: warning: variable 'max_optlen' set but not used [-Wunused-but-set-variable]
    2206 |         int max_optlen;
         |             ^~~~~~~~~~
   net/socket.c: In function '__do_sys_socketcall':
>> net/socket.c:2924:50: warning: passing argument 2 of 'audit_socketcall' makes pointer from integer without a cast [-Wint-conversion]
    2924 |         err = audit_socketcall(call, nargs[call] / sizeof(unsigned long), a);
         |                                      ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~
         |                                                  |
         |                                                  long unsigned int
   In file included from net/socket.c:82:
   include/linux/audit.h:643:62: note: expected 'long unsigned int *' but argument is of type 'long unsigned int'
     643 | static inline int audit_socketcall(int nargs, unsigned long *args)
         |                                               ~~~~~~~~~~~~~~~^~~~
>> net/socket.c:2924:15: error: too many arguments to function 'audit_socketcall'
    2924 |         err = audit_socketcall(call, nargs[call] / sizeof(unsigned long), a);
         |               ^~~~~~~~~~~~~~~~
   In file included from net/socket.c:82:
   include/linux/audit.h:643:19: note: declared here
     643 | static inline int audit_socketcall(int nargs, unsigned long *args)
         |                   ^~~~~~~~~~~~~~~~


vim +/audit_socketcall +2924 net/socket.c

  2896	
  2897	/*
  2898	 *	System call vectors.
  2899	 *
  2900	 *	Argument checking cleaned up. Saved 20% in size.
  2901	 *  This function doesn't need to set the kernel lock because
  2902	 *  it is set by the callees.
  2903	 */
  2904	
  2905	SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
  2906	{
  2907		unsigned long a[AUDITSC_ARGS];
  2908		unsigned long a0, a1;
  2909		int err;
  2910		unsigned int len;
  2911	
  2912		if (call < 1 || call > SYS_SENDMMSG)
  2913			return -EINVAL;
  2914		call = array_index_nospec(call, SYS_SENDMMSG + 1);
  2915	
  2916		len = nargs[call];
  2917		if (len > sizeof(a))
  2918			return -EINVAL;
  2919	
  2920		/* copy_from_user should be SMP safe. */
  2921		if (copy_from_user(a, args, len))
  2922			return -EFAULT;
  2923	
> 2924		err = audit_socketcall(call, nargs[call] / sizeof(unsigned long), a);
  2925		if (err)
  2926			return err;
  2927	
  2928		a0 = a[0];
  2929		a1 = a[1];
  2930	
  2931		switch (call) {
  2932		case SYS_SOCKET:
  2933			err = __sys_socket(a0, a1, a[2]);
  2934			break;
  2935		case SYS_BIND:
  2936			err = __sys_bind(a0, (struct sockaddr __user *)a1, a[2]);
  2937			break;
  2938		case SYS_CONNECT:
  2939			err = __sys_connect(a0, (struct sockaddr __user *)a1, a[2]);
  2940			break;
  2941		case SYS_LISTEN:
  2942			err = __sys_listen(a0, a1);
  2943			break;
  2944		case SYS_ACCEPT:
  2945			err = __sys_accept4(a0, (struct sockaddr __user *)a1,
  2946					    (int __user *)a[2], 0);
  2947			break;
  2948		case SYS_GETSOCKNAME:
  2949			err =
  2950			    __sys_getsockname(a0, (struct sockaddr __user *)a1,
  2951					      (int __user *)a[2]);
  2952			break;
  2953		case SYS_GETPEERNAME:
  2954			err =
  2955			    __sys_getpeername(a0, (struct sockaddr __user *)a1,
  2956					      (int __user *)a[2]);
  2957			break;
  2958		case SYS_SOCKETPAIR:
  2959			err = __sys_socketpair(a0, a1, a[2], (int __user *)a[3]);
  2960			break;
  2961		case SYS_SEND:
  2962			err = __sys_sendto(a0, (void __user *)a1, a[2], a[3],
  2963					   NULL, 0);
  2964			break;
  2965		case SYS_SENDTO:
  2966			err = __sys_sendto(a0, (void __user *)a1, a[2], a[3],
  2967					   (struct sockaddr __user *)a[4], a[5]);
  2968			break;
  2969		case SYS_RECV:
  2970			err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
  2971					     NULL, NULL);
  2972			break;
  2973		case SYS_RECVFROM:
  2974			err = __sys_recvfrom(a0, (void __user *)a1, a[2], a[3],
  2975					     (struct sockaddr __user *)a[4],
  2976					     (int __user *)a[5]);
  2977			break;
  2978		case SYS_SHUTDOWN:
  2979			err = __sys_shutdown(a0, a1);
  2980			break;
  2981		case SYS_SETSOCKOPT:
  2982			err = __sys_setsockopt(a0, a1, a[2], (char __user *)a[3],
  2983					       a[4]);
  2984			break;
  2985		case SYS_GETSOCKOPT:
  2986			err =
  2987			    __sys_getsockopt(a0, a1, a[2], (char __user *)a[3],
  2988					     (int __user *)a[4]);
  2989			break;
  2990		case SYS_SENDMSG:
  2991			err = __sys_sendmsg(a0, (struct user_msghdr __user *)a1,
  2992					    a[2], true);
  2993			break;
  2994		case SYS_SENDMMSG:
  2995			err = __sys_sendmmsg(a0, (struct mmsghdr __user *)a1, a[2],
  2996					     a[3], true);
  2997			break;
  2998		case SYS_RECVMSG:
  2999			err = __sys_recvmsg(a0, (struct user_msghdr __user *)a1,
  3000					    a[2], true);
  3001			break;
  3002		case SYS_RECVMMSG:
  3003			if (IS_ENABLED(CONFIG_64BIT))
  3004				err = __sys_recvmmsg(a0, (struct mmsghdr __user *)a1,
  3005						     a[2], a[3],
  3006						     (struct __kernel_timespec __user *)a[4],
  3007						     NULL);
  3008			else
  3009				err = __sys_recvmmsg(a0, (struct mmsghdr __user *)a1,
  3010						     a[2], a[3], NULL,
  3011						     (struct old_timespec32 __user *)a[4]);
  3012			break;
  3013		case SYS_ACCEPT4:
  3014			err = __sys_accept4(a0, (struct sockaddr __user *)a1,
  3015					    (int __user *)a[2], a[3]);
  3016			break;
  3017		default:
  3018			err = -EINVAL;
  3019			break;
  3020		}
  3021		return err;
  3022	}
  3023	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
