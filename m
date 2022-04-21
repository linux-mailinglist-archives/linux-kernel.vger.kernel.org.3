Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F27C50A590
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiDUQ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390709AbiDUQ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:27:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4CE21E39
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650558251; x=1682094251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BsAoyIOK9GlTC3Y79N4JiJGSfo3WkcUKcBKgOH7/4ZQ=;
  b=l/WOecmqKhDP4OCSIDGFBVFWBx9MsB+xZTzFmCANKgfszw6pV8w4I3VG
   TZRiojcX8wUDnqHZGZKBiZviDCVwkhVp6FFOvQcQaEEkv3RYgTXtHVZ5X
   20eVdRoSF5sVnukTIBSi62/aGrT7lc/sbH8qXHCswPGM0DoOwNHpCqCBk
   F5AS0elTKVnMSbcHpBS7m3gDryRPSxWK/hnzfoF58pW9LLqPyjGaz3aMZ
   8gggSqcKYrJyYwjxfO4yQS2bZTy8hXiZ7YrJUm1GGxXXm85n0w/PzajE4
   tdoY2/p+liofCDjrwSUDo/R2hMJwx/BB05GTz7/ANvCsyfA+klj7+YPAN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="251725108"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="251725108"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 09:24:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="671022532"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 09:24:09 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhZbE-0008Z5-Cc;
        Thu, 21 Apr 2022 16:24:08 +0000
Date:   Fri, 22 Apr 2022 00:23:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:rxrpc-ringless 15/21] net/rxrpc/call_event.c:168:54:
 warning: variable 'ack_id' is uninitialized when used here
Message-ID: <202204220003.YOX3kXiD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git rxrpc-ringless
head:   c388a8388ad238ffbe0cd204c3eacaf200055751
commit: db7ccd62278b9fd5744316e50db696ea69b9dcbc [15/21] rxrpc: Use txbufs for acks
config: i386-randconfig-a006 (https://download.01.org/0day-ci/archive/20220422/202204220003.YOX3kXiD-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=db7ccd62278b9fd5744316e50db696ea69b9dcbc
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs rxrpc-ringless
        git checkout db7ccd62278b9fd5744316e50db696ea69b9dcbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/rxrpc/call_event.c:168:54: warning: variable 'ack_id' is uninitialized when used here [-Wuninitialized]
           trace_rxrpc_send_ack(call, why, ack_reason, serial, ack_id);
                                                               ^~~~~~
   net/rxrpc/call_event.c:130:21: note: initialize the variable 'ack_id' to silence this warning
           unsigned int ack_id;
                              ^
                               = 0
   1 warning generated.


vim +/ack_id +168 net/rxrpc/call_event.c

17926a79320afa net/rxrpc/ar-ack.c     David Howells 2007-04-26  121  
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  122  /*
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  123   * Queue an ACK for immediate transmission.
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  124   */
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  125  void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  126  		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  127  {
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  128  	struct rxrpc_local *local = call->conn->params.local;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  129  	struct rxrpc_txbuf *txb;
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30  130  	unsigned int ack_id;
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30  131  	int c;
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  132  
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  133  	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  134  		return;
e93f9769293b67 net/rxrpc/call_event.c David Howells 2020-01-30  135  	if (ack_reason == RXRPC_ACK_DELAY &&
e93f9769293b67 net/rxrpc/call_event.c David Howells 2020-01-30  136  	    test_and_set_bit(RXRPC_CALL_DELAY_ACK_PENDING, &call->flags)) {
e93f9769293b67 net/rxrpc/call_event.c David Howells 2020-01-30  137  		trace_rxrpc_drop_ack(call, why, ack_reason, serial, false);
e93f9769293b67 net/rxrpc/call_event.c David Howells 2020-01-30  138  		return;
e93f9769293b67 net/rxrpc/call_event.c David Howells 2020-01-30  139  	}
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  140  
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  141  	txb = rxrpc_alloc_txbuf(call, in_softirq() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  142  	if (!txb) {
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  143  		kleave(" = -ENOMEM");
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  144  		return;
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  145  	}
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  146  
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  147  	txb->ack_why		= why;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  148  	txb->wire.seq		= 0;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  149  	txb->wire.type		= RXRPC_PACKET_TYPE_ACK;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  150  	txb->wire.flags		|= RXRPC_SLOW_START_OK;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  151  	txb->ack.bufferSpace	= htons(8);
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  152  	txb->ack.maxSkew	= 0;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  153  	txb->ack.firstPacket	= 0;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  154  	txb->ack.previousPacket	= 0;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  155  	txb->ack.serial		= htonl(serial);
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  156  	txb->ack.reason		= ack_reason;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  157  	txb->ack.nAcks		= 0;
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  158  
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  159  	rxrpc_get_call(call, rxrpc_call_got);
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  160  
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  161  	spin_lock_bh(&local->ack_tx_lock);
db7ccd62278b9f net/rxrpc/call_event.c David Howells 2022-04-05  162  	list_add_tail(&txb->tx_link, &local->ack_tx_queue);
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30  163  	c = atomic_inc_return(&local->ack_tx_count);
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30  164  	if (c > local->ack_tx_max)
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30  165  		local->ack_tx_max = c;
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30  166  	local->ack_tx_send++;
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  167  	spin_unlock_bh(&local->ack_tx_lock);
5ea8a2c868a42d net/rxrpc/call_event.c David Howells 2020-01-30 @168  	trace_rxrpc_send_ack(call, why, ack_reason, serial, ack_id);
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  169  	rxrpc_wake_up_transmitter(local);
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  170  }
78ffd18fe8b510 net/rxrpc/call_event.c David Howells 2020-01-30  171  

:::::: The code at line 168 was first introduced by commit
:::::: 5ea8a2c868a42d3f906c25ce905583b4b4576f74 put ack count in proc

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
