Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41C449BBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiAYTSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:18:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:11263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbiAYTRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643138243; x=1674674243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ylfdbxJ90VandEkShGO0dsoOHwpeswFgLhHYpjwgJZw=;
  b=jX/7lRw/1nApuiK9KMCm4dPzAmPjmPvoWSdACgMk5WuHuDV3HWh/bz3k
   Nqu77nAQ2Dpa2V2/f+VjFegLOXVYDJ0ks7EbxQlrAiad42hs2BP1Awc5f
   fZGax0iZbUm0vrBbI5LbkcyqdIW+xcmliqIwOoZC+TQAkA9B0TW+9C5dS
   Jn19fEo8Q6KCdjmJFwdjP+2voS61bOQ9hvdlAIg67EVshYk0Qf4nqmYr+
   cIRj5PoOjbquju8iuPkowcURw+T8RoKbsoRX1iSQNCQ9fCZY4kZ8KAa3q
   q6bRB7W2RWcnqvKMmN6GEwf+DeOg7lwkVyO4j+N2ojrwkrZ6xigbZ1Euc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246612129"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246612129"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 11:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="695956898"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jan 2022 11:17:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCRJb-000KL4-MD; Tue, 25 Jan 2022 19:17:15 +0000
Date:   Wed, 26 Jan 2022 03:16:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: block/blk-mq.c:1071:36: sparse: sparse: cast from restricted
 blk_status_t
Message-ID: <202201260028.1emkcjHZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a08b41ab9e2e468647f78eb17c28e29b93006394
commit: 4054cff92c357813b6861b622122b344990f7e31 block: remove blk-exec.c
date:   8 weeks ago
config: csky-randconfig-s032-20220120 (https://download.01.org/0day-ci/archive/20220126/202201260028.1emkcjHZ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4054cff92c357813b6861b622122b344990f7e31
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4054cff92c357813b6861b622122b344990f7e31
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> block/blk-mq.c:1071:36: sparse: sparse: cast from restricted blk_status_t
>> block/blk-mq.c:1164:17: sparse: sparse: cast to restricted blk_status_t

vim +1071 block/blk-mq.c

  1061	
  1062	/**
  1063	 * blk_end_sync_rq - executes a completion event on a request
  1064	 * @rq: request to complete
  1065	 * @error: end I/O status of the request
  1066	 */
  1067	static void blk_end_sync_rq(struct request *rq, blk_status_t error)
  1068	{
  1069		struct completion *waiting = rq->end_io_data;
  1070	
> 1071		rq->end_io_data = (void *)(uintptr_t)error;
  1072	
  1073		/*
  1074		 * complete last, if this is a stack request the process (and thus
  1075		 * the rq pointer) could be invalid right after this complete()
  1076		 */
  1077		complete(waiting);
  1078	}
  1079	
  1080	/**
  1081	 * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  1082	 * @bd_disk:	matching gendisk
  1083	 * @rq:		request to insert
  1084	 * @at_head:    insert request at head or tail of queue
  1085	 * @done:	I/O completion handler
  1086	 *
  1087	 * Description:
  1088	 *    Insert a fully prepared request at the back of the I/O scheduler queue
  1089	 *    for execution.  Don't wait for completion.
  1090	 *
  1091	 * Note:
  1092	 *    This function will invoke @done directly if the queue is dead.
  1093	 */
  1094	void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
  1095				   int at_head, rq_end_io_fn *done)
  1096	{
  1097		WARN_ON(irqs_disabled());
  1098		WARN_ON(!blk_rq_is_passthrough(rq));
  1099	
  1100		rq->rq_disk = bd_disk;
  1101		rq->end_io = done;
  1102	
  1103		blk_account_io_start(rq);
  1104	
  1105		/*
  1106		 * don't check dying flag for MQ because the request won't
  1107		 * be reused after dying flag is set
  1108		 */
  1109		blk_mq_sched_insert_request(rq, at_head, true, false);
  1110	}
  1111	EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
  1112	
  1113	static bool blk_rq_is_poll(struct request *rq)
  1114	{
  1115		if (!rq->mq_hctx)
  1116			return false;
  1117		if (rq->mq_hctx->type != HCTX_TYPE_POLL)
  1118			return false;
  1119		if (WARN_ON_ONCE(!rq->bio))
  1120			return false;
  1121		return true;
  1122	}
  1123	
  1124	static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
  1125	{
  1126		do {
  1127			bio_poll(rq->bio, NULL, 0);
  1128			cond_resched();
  1129		} while (!completion_done(wait));
  1130	}
  1131	
  1132	/**
  1133	 * blk_execute_rq - insert a request into queue for execution
  1134	 * @bd_disk:	matching gendisk
  1135	 * @rq:		request to insert
  1136	 * @at_head:    insert request at head or tail of queue
  1137	 *
  1138	 * Description:
  1139	 *    Insert a fully prepared request at the back of the I/O scheduler queue
  1140	 *    for execution and wait for completion.
  1141	 * Return: The blk_status_t result provided to blk_mq_end_request().
  1142	 */
  1143	blk_status_t blk_execute_rq(struct gendisk *bd_disk, struct request *rq,
  1144			int at_head)
  1145	{
  1146		DECLARE_COMPLETION_ONSTACK(wait);
  1147		unsigned long hang_check;
  1148	
  1149		rq->end_io_data = &wait;
  1150		blk_execute_rq_nowait(bd_disk, rq, at_head, blk_end_sync_rq);
  1151	
  1152		/* Prevent hang_check timer from firing at us during very long I/O */
  1153		hang_check = sysctl_hung_task_timeout_secs;
  1154	
  1155		if (blk_rq_is_poll(rq))
  1156			blk_rq_poll_completion(rq, &wait);
  1157		else if (hang_check)
  1158			while (!wait_for_completion_io_timeout(&wait,
  1159					hang_check * (HZ/2)))
  1160				;
  1161		else
  1162			wait_for_completion_io(&wait);
  1163	
> 1164		return (blk_status_t)(uintptr_t)rq->end_io_data;
  1165	}
  1166	EXPORT_SYMBOL(blk_execute_rq);
  1167	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
