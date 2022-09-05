Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E45AD15B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiIELQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbiIELQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:16:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C9A564EC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662376576; x=1693912576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hjHj90Fl4LWy3EOn4ZjhEfgpxmdC4JFGcfKzjTLHD3o=;
  b=jCv94hvpiM3WVah+0nes9bby0uu5FCtPXBZBPCLP2hSp3HUXwvmqrMdG
   ziLkctb330A1ZxRwUoX8cm+gLrp5HqFSN8tlAmsS3diYoABW6pCfxDqWc
   flhy/xEc6YYsm2+Upeout73vi5/ZEkwTm/VgInQPwuyvfaJtL7NgSPEWv
   xmw0diGSNUkd7QzGKK5QKPR5rwXjPUe/oYciV/XwV4X7RA12y7rdviTtK
   vdIW4PiTvIVrDgzC6aGAYZBUfAKHue6/4FkvITwSNlQ7qQbXlufp7/JP+
   rEZ3a47g5aNHj5mcmex6xFQtFmeIwPhoWy7hUuVQxdDeIJxGEAbDN/R8J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="296371239"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="296371239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="643774470"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2022 04:16:11 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v2 0/2] ipc/msg: mitigate the lock contention in ipc/msg
Date:   Tue,  6 Sep 2022 03:35:14 +0800
Message-Id: <20220905193516.846647-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902152243.479592-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are two patches to mitigate the lock contention in ipc/msg.

The 1st patch is to add the new function percpu_counter_add_local if
only update the local counter without aggregating to global counter.

The 2nd patch is to use percpu_counter_add_local instead of atomic
updating in do_msgsnd and do_msgrcv every time. It will always do
sum when the syscall msgctl_info. So there is no need to do global
adding in percpu_counter_add_batch. We add percpu_counter_add_local
to resolve the above issue. The sum operation in msgctl_info is
infrequent and the additional cost is much less compared to the
performance gain in do_msgsnd and do_msgrcv.

Changes in v2:
1. Separate the original patch into two patches.
2. Add error handling for percpu_counter_init.

The performance gain increases as the threads of workload become larger.
Performance gain: 3.38x

CPU: ICX 8380 x 2 sockets
Core number: 40 x 2 physical cores
Benchmark: pts/stress-ng-1.4.0
-- system v message passing (160 threads)


Regards
Jiebin

