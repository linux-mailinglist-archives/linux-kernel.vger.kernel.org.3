Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD568577A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 06:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiGREr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 00:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiGREr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 00:47:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D741054F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 21:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658119676; x=1689655676;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JDPwk0kSCEczd4UbvRkxUFpUxwmEplNvEFD6bZa5RFQ=;
  b=Gxo2Pn2ticm+yhXPvaZMe2smNyKZBYxtldRk1CillJCGCqOB4J8Sm1Cn
   o5WYP9q2tYAls3xyN7ng4jd6REFpHkrBnB7jEadXhByxTgtvFknC1jFlJ
   bZ18qUORQc5IwV/Sp7yErJIxZu6AGCu28JXHRf0GLEpCogkU2HwDBZL7G
   gVk/09LMI3glfiYpO7Z6aSI91/zT/k+Tj4tU12iEvsXLcPwUQKig89pzT
   Pu2dByDrEeFfU4PF8N5S+z24kCvUO7mug8Z8XyeMJ9C/7ET2SuslkeEyA
   DFpVC1ijgt/FSc0Fw1xVAmiOVQvXLlwcMMORDKVhW2/Y9unhPH8i/rKcS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347819992"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="347819992"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 21:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="843146584"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2022 21:47:54 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDIfh-00041c-JG;
        Mon, 18 Jul 2022 04:47:53 +0000
Date:   Mon, 18 Jul 2022 12:47:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [linux-stable-rc:queue/5.18 144/146]
 net/netfilter/nf_conntrack_core.o: warning: objtool:
 nf_ct_tuple_equal()+0x21: 'naked' return found in RETPOLINE build
Message-ID: <202207181205.a23PJk7M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.18
head:   3ac33f177b446b34004c8399b7f46b3d239f7457
commit: 7580f57c2b6b1bb230ec1b10a2c6adac8fac6d66 [144/146] objtool: Update Retpoline validation
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220718/202207181205.a23PJk7M-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=7580f57c2b6b1bb230ec1b10a2c6adac8fac6d66
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.18
        git checkout 7580f57c2b6b1bb230ec1b10a2c6adac8fac6d66
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_tuple_equal()+0x21: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_tuple_equal()+0x49: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_conntrack_hash_insert()+0x54: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: kill_all()+0xc: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_lock()+0x15: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_invert_tuple()+0x8a: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_get_id()+0x72: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_port_tuple_to_nlattr()+0x77: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_port_nlattr_tuple_size()+0xa: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_port_nlattr_tuple_size()+0x22: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_ct_unconfirmed_destroy()+0x95: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_alloc_hashtable()+0x63: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_alloc_hashtable()+0x64: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_port_nlattr_to_tuple()+0x2e: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_port_nlattr_to_tuple()+0x34: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: iter_net_only()+0xf: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: hash_conntrack_raw.constprop.0()+0xa1: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_tmpl_alloc()+0x5a: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: __refcount_add.constprop.0()+0x14: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_get_tuple()+0x12e: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: get_l4proto()+0x4e: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_get_tuplepr()+0x75: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_acct_add()+0x30: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_acct_add()+0x31: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_acct_add()+0x32: 'naked' return found in RETPOLINE build
>> net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_ct_refresh_acct()+0x2f: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_alter_reply()+0x5f: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_unconfirmed_destroy()+0x2d: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_free()+0x57: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_key_equal.constprop.0()+0x24: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_key_equal.constprop.0()+0x6f: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_key_equal.constprop.0()+0x7a: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_key_equal.constprop.0()+0x7b: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_attach()+0x46: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_double_lock.constprop.0()+0x61: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_hash_check_insert()+0x1c7: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_put.part.0()+0x12: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_conntrack_confirm()+0x39: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_confirm_cthelper()+0xf7: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_delete()+0x11: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_delete()+0x157: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_gc_expired.part.0()+0x2d: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_tuple_taken()+0x1a3: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: early_drop()+0x17e: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_conntrack_alloc.constprop.0()+0x118: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: init_conntrack.constprop.0()+0x181: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_iterate_cleanup_net()+0x95: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: gc_worker()+0x44b: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_conntrack_find_get.isra.0()+0x213: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_in()+0x26b: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_conntrack_update()+0x1b3: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_update()+0x49: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_get_tuple_skb()+0x165: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_cleanup_start()+0x7: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_cleanup_net_list()+0x89: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_cleanup_net_list()+0xcc: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_cleanup_net()+0x45: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_hash_resize()+0x1c0: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_hash_resize()+0x1e5: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_set_hashsize()+0x5c: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_init_start()+0x159: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_init_start()+0x181: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_init_end()+0xb: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_init_net()+0xd2: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_conntrack_init_net()+0xf1: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: __nf_ct_resolve_clash()+0x13a: 'naked' return found in RETPOLINE build
   net/netfilter/nf_conntrack_core.o: warning: objtool: nf_ct_resolve_clash()+0x15d: 'naked' return found in RETPOLINE build


objdump-func vmlinux.o nf_ct_tuple_equal:
0000 00000000009fb340 <nf_ct_tuple_equal>:
0000   9fb340:	48 8b 06             	mov    (%rsi),%rax
0003   9fb343:	48 8b 57 08          	mov    0x8(%rdi),%rdx
0007   9fb347:	45 31 c0             	xor    %r8d,%r8d
000a   9fb34a:	48 33 07             	xor    (%rdi),%rax
000d   9fb34d:	48 33 56 08          	xor    0x8(%rsi),%rdx
0011   9fb351:	48 09 d0             	or     %rdx,%rax
0014   9fb354:	75 08                	jne    9fb35e <nf_ct_tuple_equal+0x1e>
0016   9fb356:	8b 46 10             	mov    0x10(%rsi),%eax
0019   9fb359:	39 47 10             	cmp    %eax,0x10(%rdi)
001c   9fb35c:	74 04                	je     9fb362 <nf_ct_tuple_equal+0x22>
001e   9fb35e:	44 89 c0             	mov    %r8d,%eax
0021   9fb361:	c3                   	ret    
0022   9fb362:	48 8b 47 14          	mov    0x14(%rdi),%rax
0026   9fb366:	48 8b 57 1c          	mov    0x1c(%rdi),%rdx
002a   9fb36a:	48 33 46 14          	xor    0x14(%rsi),%rax
002e   9fb36e:	48 33 56 1c          	xor    0x1c(%rsi),%rdx
0032   9fb372:	48 09 d0             	or     %rdx,%rax
0035   9fb375:	75 e7                	jne    9fb35e <nf_ct_tuple_equal+0x1e>
0037   9fb377:	8b 47 24             	mov    0x24(%rdi),%eax
003a   9fb37a:	33 46 24             	xor    0x24(%rsi),%eax
003d   9fb37d:	a9 ff ff ff 00       	test   $0xffffff,%eax
0042   9fb382:	41 0f 94 c0          	sete   %r8b
0046   9fb386:	44 89 c0             	mov    %r8d,%eax
0049   9fb389:	c3                   	ret    
004a   9fb38a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
