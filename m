Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514975A381F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiH0Ob5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 10:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiH0Obz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:31:55 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7096CD2B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=1ndYDZJW93HKaviG04UkP42Coc+7wml5OhYUIANXapA=;
  b=KQIodsIKbPp3JBfWZepUFpRWlUUi5n9pSH2yneGpABOyorMB6xeMu+ZV
   ebyedIu/wTi9kE9uV4NnXGEKXo6KwOtYkrhfIVJkfCKCHazamrDbv5j+8
   8Y8GHUiFrBWOi4A4NPO0Dh1C2oeG3ENo3QJPvqTVtnOBQ4sCxi2SY0lKP
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.93,267,1654552800"; 
   d="scan'208";a="22219688"
Received: from 16.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.16])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2022 16:31:50 +0200
Date:   Sat, 27 Aug 2022 16:31:50 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dmitry Safonov <dima@arista.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: Re: [PATCH 10/31] net/tcp: Calculate TCP-AO traffic keys (fwd)
Message-ID: <alpine.DEB.2.22.394.2208271630440.6645@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check the kfree on lie 332.

julia

---------- Forwarded message ----------
Date: Sat, 27 Aug 2022 11:58:33 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 10/31] net/tcp: Calculate TCP-AO traffic keys

BCC: lkp@intel.com
CC: kbuild-all@lists.01.org
In-Reply-To: <20220818170005.747015-11-dima@arista.com>
References: <20220818170005.747015-11-dima@arista.com>
TO: Dmitry Safonov <dima@arista.com>
TO: Eric Dumazet <edumazet@google.com>
TO: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org
TO: linux-kernel@vger.kernel.org
CC: Dmitry Safonov <dima@arista.com>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Ard Biesheuvel <ardb@kernel.org>
CC: Bob Gilligan <gilligan@arista.com>
CC: David Ahern <dsahern@kernel.org>
CC: Eric Biggers <ebiggers@kernel.org>
CC: Francesco Ruggeri <fruggeri@arista.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
CC: Ivan Delalande <colona@arista.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Leonard Crestez <cdleonard@gmail.com>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Salam Noureddine <noureddine@arista.com>
CC: Shuah Khan <skhan@linuxfoundation.org>
CC: linux-crypto@vger.kernel.org

Hi Dmitry,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on e34cfee65ec891a319ce79797dda18083af33a76]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov/net-tcp-Add-TCP-AO-support/20220819-010628
base:   e34cfee65ec891a319ce79797dda18083af33a76
:::::: branch date: 8 days ago
:::::: commit date: 8 days ago
config: x86_64-randconfig-c002 (https://download.01.org/0day-ci/archive/20220827/202208271151.00tHdiGE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

cocci warnings: (new ones prefixed by >>)
>> net/ipv4/tcp_ao.c:333:21-32: ERROR: reference preceded by free on line 332

vim +333 net/ipv4/tcp_ao.c

a58f130caaa0601 Dmitry Safonov 2022-08-18  280
a58f130caaa0601 Dmitry Safonov 2022-08-18  281  void tcp_ao_connect_init(struct sock *sk)
a58f130caaa0601 Dmitry Safonov 2022-08-18  282  {
a58f130caaa0601 Dmitry Safonov 2022-08-18  283  	struct tcp_ao_info *ao_info;
a58f130caaa0601 Dmitry Safonov 2022-08-18  284  	struct tcp_ao_key *key;
a58f130caaa0601 Dmitry Safonov 2022-08-18  285  	struct tcp_sock *tp = tcp_sk(sk);
a58f130caaa0601 Dmitry Safonov 2022-08-18  286  	union tcp_ao_addr *addr;
a58f130caaa0601 Dmitry Safonov 2022-08-18  287  	int family;
a58f130caaa0601 Dmitry Safonov 2022-08-18  288
a58f130caaa0601 Dmitry Safonov 2022-08-18  289  	ao_info = rcu_dereference_protected(tp->ao_info,
a58f130caaa0601 Dmitry Safonov 2022-08-18  290  					    lockdep_sock_is_held(sk));
a58f130caaa0601 Dmitry Safonov 2022-08-18  291  	if (!ao_info)
a58f130caaa0601 Dmitry Safonov 2022-08-18  292  		return;
a58f130caaa0601 Dmitry Safonov 2022-08-18  293
a58f130caaa0601 Dmitry Safonov 2022-08-18  294  	/* Remove all keys that don't match the peer */
a58f130caaa0601 Dmitry Safonov 2022-08-18  295  	family = sk->sk_family;
a58f130caaa0601 Dmitry Safonov 2022-08-18  296  	if (family == AF_INET)
a58f130caaa0601 Dmitry Safonov 2022-08-18  297  		addr = (union tcp_ao_addr *)&sk->sk_daddr;
a58f130caaa0601 Dmitry Safonov 2022-08-18  298  	else
a58f130caaa0601 Dmitry Safonov 2022-08-18  299  		addr = (union tcp_ao_addr *)&sk->sk_v6_daddr;
a58f130caaa0601 Dmitry Safonov 2022-08-18  300
a58f130caaa0601 Dmitry Safonov 2022-08-18  301  	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
a58f130caaa0601 Dmitry Safonov 2022-08-18  302  		if (tcp_ao_key_cmp(key, addr, key->prefixlen, family,
a58f130caaa0601 Dmitry Safonov 2022-08-18  303  		    -1, -1, sk->sk_dport) == 0)
a58f130caaa0601 Dmitry Safonov 2022-08-18  304  			continue;
a58f130caaa0601 Dmitry Safonov 2022-08-18  305
a58f130caaa0601 Dmitry Safonov 2022-08-18  306  		if (key == ao_info->current_key)
a58f130caaa0601 Dmitry Safonov 2022-08-18  307  			ao_info->current_key = NULL;
a58f130caaa0601 Dmitry Safonov 2022-08-18  308  		if (key == ao_info->rnext_key)
a58f130caaa0601 Dmitry Safonov 2022-08-18  309  			ao_info->rnext_key = NULL;
a58f130caaa0601 Dmitry Safonov 2022-08-18  310  		hlist_del_rcu(&key->node);
a58f130caaa0601 Dmitry Safonov 2022-08-18  311  		crypto_pool_release(key->crypto_pool_id);
a58f130caaa0601 Dmitry Safonov 2022-08-18  312  		atomic_sub(tcp_ao_sizeof_key(key), &sk->sk_omem_alloc);
a58f130caaa0601 Dmitry Safonov 2022-08-18  313  		kfree_rcu(key, rcu);
a58f130caaa0601 Dmitry Safonov 2022-08-18  314  	}
a58f130caaa0601 Dmitry Safonov 2022-08-18  315
a58f130caaa0601 Dmitry Safonov 2022-08-18  316  	key = tp->af_specific->ao_lookup(sk, sk, -1, -1);
a58f130caaa0601 Dmitry Safonov 2022-08-18  317  	if (key) {
a58f130caaa0601 Dmitry Safonov 2022-08-18  318  		/* if current_key or rnext_key were not provided,
a58f130caaa0601 Dmitry Safonov 2022-08-18  319  		 * use the first key matching the peer
a58f130caaa0601 Dmitry Safonov 2022-08-18  320  		 */
a58f130caaa0601 Dmitry Safonov 2022-08-18  321  		if (!ao_info->current_key)
a58f130caaa0601 Dmitry Safonov 2022-08-18  322  			ao_info->current_key = key;
a58f130caaa0601 Dmitry Safonov 2022-08-18  323  		if (!ao_info->rnext_key)
a58f130caaa0601 Dmitry Safonov 2022-08-18  324  			ao_info->rnext_key = key;
a58f130caaa0601 Dmitry Safonov 2022-08-18  325  		tp->tcp_header_len += tcp_ao_len(key);
a58f130caaa0601 Dmitry Safonov 2022-08-18  326
a58f130caaa0601 Dmitry Safonov 2022-08-18  327  		ao_info->lisn = htonl(tp->write_seq);
a58f130caaa0601 Dmitry Safonov 2022-08-18  328  		ao_info->snd_sne = 0;
a58f130caaa0601 Dmitry Safonov 2022-08-18  329  		ao_info->snd_sne_seq = tp->write_seq;
a58f130caaa0601 Dmitry Safonov 2022-08-18  330  	} else {
a58f130caaa0601 Dmitry Safonov 2022-08-18  331  		WARN_ON_ONCE(1);
a58f130caaa0601 Dmitry Safonov 2022-08-18 @332  		kfree(tp->ao_info);
a58f130caaa0601 Dmitry Safonov 2022-08-18 @333  		rcu_assign_pointer(tp->ao_info, NULL);
a58f130caaa0601 Dmitry Safonov 2022-08-18  334  	}
a58f130caaa0601 Dmitry Safonov 2022-08-18  335  }
a58f130caaa0601 Dmitry Safonov 2022-08-18  336

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
