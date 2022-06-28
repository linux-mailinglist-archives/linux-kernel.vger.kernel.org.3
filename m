Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0985855E1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiF1HBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiF1HBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:01:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619BB86;
        Tue, 28 Jun 2022 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656399707; x=1687935707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aAQLpyuwGe/blCnik+wxyAV++Cqpx2JtHD4cMfZzvcE=;
  b=LyygNF4ISOSE6XaqdJniXVHe4jius5rs74TdPRtLh2vnQu3QEwVNJ7s/
   YuyzRwp/CLsmsNj0C++x9lW3QM8aJaURGGe2LjCzLjl/lQupOJviGkLwT
   e05ml8oPZbCJr7nUNR8nLDql/bpZKCIHPTxvZwP/BRtOF8FGqiWzeh8aC
   hxZ5ceiXwy1glyn9EvaAUFGVNwQxas3RrO48HMilyao2JPEAfWmuu3MZD
   kxnseOYQV1plWVnClAMT2xdToh6nIZ9Ob9s5xXCJ3ofll88yQk4LMdjMj
   kwi5BcrPP1TnNy3QO9rnksYUxSzZoJCkci9rSHGmgmNJ4/xCkbOdGO7WR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280415402"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280415402"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:01:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646782818"
Received: from spr.sh.intel.com ([10.239.53.120])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 00:01:43 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, Chao Gao <chao.gao@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        iommu@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v1 0/3] swiotlb performance optimizations
Date:   Tue, 28 Jun 2022 15:01:31 +0800
Message-Id: <20220628070136.419163-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intent of this post:
 Seek reviews from Intel reviewers and anyone else in the list
 interested in IO performance in confidential VMs. Need some acked-by
 reviewed-by tags before I can add swiotlb maintainers to "to/cc" lists
 and ask for a review from them.

swiotlb is now widely used by confidential VMs. This series optimizes
swiotlb to reduce cache misses and lock contention during bounce buffer
allocation/free and memory bouncing to improve IO workload performance in
confidential VMs.

Here are some FIO tests we did to demonstrate the improvement.

Test setup
----------

A normal VM with 8vCPU and 32G memory, swiotlb is enabled by swiotlb=force.
100 in Host/Guest CPU utilization means 1 logical processor. FIO block size
is 4K and iodepth is 256. Note that a normal VM is used so that others lack
of necessary hardware to host confidential VMs can reproduce results below.

Results
-------

1 FIO job	read/write	Throughput	IOPS	Host CPU	Guest CPU
				(MB/s)		(k)	utilization	utilization
vanilla		read		1037		253	228.48		101.92
		write		1148		280	233.28		100.96
optimized	read		1160		283	232.32		101.12
		write		1195		292	233.28		100.64

1-job FIO sequential read/write perf increase by 12% and 4% respectively.

4 FIO jobs	read/write	Throughput	IOPS	Host CPU	Guest CPU
				(MB/s)		(k)	utilization	utilization
vanilla		read		885		214.9	527.04		401.12
		write		868		212.1	531.84		400.64
optimized	read		2320		567	344.64		202.8
		write		1998		488	312		173.92

4-job FIO sequential read/write perf increase by 164% and 130% respectively.

This series is based on 5.19-rc2.

Andi Kleen (1):
  swiotlb: Split up single swiotlb lock

Chao Gao (2):
  swiotlb: Use bitmap to track free slots
  swiotlb: Allocate memory in a cache-friendly way

 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/kernel/acpi/boot.c                   |   4 +
 include/linux/swiotlb.h                       |  47 +++-
 kernel/dma/swiotlb.c                          | 263 +++++++++++++-----
 4 files changed, 229 insertions(+), 89 deletions(-)

-- 
2.25.1

