Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB390487BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbiAGSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:17:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:1308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240782AbiAGSRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641579420; x=1673115420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XP2h4/KcSrzvOFafy2lvwH7BtxnbJ53o6WMyyJ0YgW4=;
  b=hMnfjgEMRimtGaQnTFsk+A+qmcO2K7tF0gWNeP277ZjVHM1JtOaeZJdA
   w1VsmQLwKPmJrqV5YbTs87aanebHYsdZ63+23EM2fRGFdV3W5GnZBoeOa
   9efzBlaGBnJdyrwwxxYAK8NcGgJfiPTG7wQkmnqzsYQ7FRxDZc2FB34q6
   2IeaDUrxPlEWd/wqSfVRF3LqC2m28ZWqA+6Br1uxKxuZaIRTbkffFOKcN
   l2ONUmA7TCXxTUduW6sYxPofqCO01EyCzRu4A6GkjWp6J82pPBpv6VzJ0
   3ksMPRLTFAuoTpq+duJr/OoxbfUAIld+NcgH3CKpO3R/GfSmhWwcW4lkz
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="267215174"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="267215174"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:17:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="622009663"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.25.179])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 10:16:59 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v2 0/2] x86/sgx: Limit EPC overcommit
Date:   Fri,  7 Jan 2022 10:16:15 -0800
Message-Id: <20220107181618.6597-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX currently allows EPC pages to be overcommitted. If the system is
out of enclave memory, EPC pages are swapped to normal RAM via
a per enclave shared memory area. This shared memory is not charged
to the enclave or the task mapping it, making it hard to account
for using normal methods. Since SGX will allow EPC pages to be
overcommitted without limits, enclaves can consume system memory
for these backing pages without limits.

In order to prevent this, set a cap on the amount of overcommit SGX
allows.  Whenever a backing page is requested by an enclave, track
the total amount of shared memory pages used across all enclaves and
return an error if the overcommit limit has been reached. This will
restrict the total amount of backing pages that all enclaves can
consume to a maximum amount, and prevent enclaves from consuming
all the system RAM for backing pages.

The overcommit percentage has a value of 150, which limits shared
memory page consumption to 1.5x the number of EPC pages in the system.

Changes from v1
----------------
* removed module parameter and disable boolean
* increased over commit percentage to 150% from 100%

Kristen Carlson Accardi (2):
  x86/sgx: Add accounting for tracking overcommit
  x86/sgx: account backing pages

 arch/x86/kernel/cpu/sgx/encl.c | 76 ++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
 arch/x86/kernel/cpu/sgx/main.c | 52 +++++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
 4 files changed, 128 insertions(+), 8 deletions(-)

-- 
2.20.1

