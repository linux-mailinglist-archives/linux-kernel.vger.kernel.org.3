Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF95AE2E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiIFIhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbiIFIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:36:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3DA7755B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662453334; x=1693989334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTZ2w94RQp2R7AkcYI0Ec8o3HuGSc4e7kZ/lmVxt/v8=;
  b=MLW+E5Xi7Ed/d9e1mKuzoFXt/2s72lzm8H5O2zti6v1twqUx6Cdi3ui/
   mOUFYP53dQ8ucIApnWyHSbYFRU8/gF+C1JtMi+MdL9WTyt7GVidrUkjC5
   V+VLma5d/oSWAlZG7QhxEh5uhWDklnpij5wsfJ9NS8zJnU68vmBaww803
   X0vk0pk5WpPZOZh+27gbdWu3z7ixcaf2rStdJQexwDWxJLMmx4RtCsyKw
   D0CTngrc1q49xXBKLgo41RkMxr6pmGDAO06RUGFFB63BjCEXjBjCwfVei
   03Q/oqFciey3uPIrsdXHkDo3JfyJtOFJr0Gp9xu80SY3JVObt+BM0Czu5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295273469"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="295273469"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 01:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="675597073"
Received: from linux-pnp-server-13.sh.intel.com ([10.239.176.176])
  by fmsmga008.fm.intel.com with ESMTP; 06 Sep 2022 01:35:24 -0700
From:   Jiebin Sun <jiebin.sun@intel.com>
To:     akpm@linux-foundation.org, vasily.averin@linux.dev,
        shakeelb@google.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, ebiederm@xmission.com, legion@kernel.org,
        manfred@colorfullife.com, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com, jiebin.sun@intel.com
Subject: [PATCH v3 0/2] ipc/msg: mitigate the lock contention in ipc/msg 
Date:   Wed,  7 Sep 2022 00:54:28 +0800
Message-Id: <20220906165430.851424-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902152243.479592-1-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here are two patches to mitigate the lock contention in ipc/msg.

The 1st patch is to add the new function percpu_counter_add_local if only update the local counter without aggregating to global counter. This function could be used with percpu_counter_sum together if you need high accurate counter. The combination could bring obvious performance improvement than percpu_counter_add_batch if percpu_counter_add is frequently called and percpu_counter_sum is not in the critical path.

The 2nd patch is to use percpu_counter instead of atomic update in ipc/msg.
The msg_bytes and msg_hdrs atomic counters are frequently updated when IPC msg queue is in heavy use, causing heavy cache bounce and overhead. Change them to percpu_counter greatly improve the performance. Since there is one percpu struct per namespace, additional memory cost is minimal. Reading of the count done in msgctl call, which is infrequent. So the need to sum up the counts in each CPU is infrequent.

Changes in v3:
1. Add comment and change log for the new function percpu_counter_add_local.
Who should use it and who shouldn't.

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

