Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA1492CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbiARR5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:57:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:60602 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230117AbiARR5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642528653; x=1674064653;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MT2bpEDo71y0JbtFkriqZ5NFOIJaFEPn/7VIqFW3+cE=;
  b=Jyia4IuH/7ybrcg2Nj/i0OF72e5G1fFwhqSwoiPg6UlmhNxDqPpyngv9
   LNqXweOuzVHYwJUVtFVAMiHwns7hrpJWeb0a9443rRMabF5ssKTXr3r9I
   se38+7X5nd9kaaVhyFOXH7x0crjNIb/TlpzzrMNzuEJSnIgmtROhA14dm
   p5Apv91gzFm1oGG1jagk7vrloHu7qU/E5vADt2z7JSKHSYw/Hgar+FRr6
   bMy/H6g3jFKR6vwDzJDaUOqFaxRaKHXYydvmYVLVvOy/Hm+/JZ31orzli
   3autM0ReG5pqbgMQ2Tu2Og+99ocBDUkMRTfKcVa4GO+ToNVWBmfv+IZey
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="243700426"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="243700426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:57:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="625587998"
Received: from bjann-mobl2.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.251.29.174])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 09:57:32 -0800
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH v3 0/2] x86/sgx: Limit EPC overcommit
Date:   Tue, 18 Jan 2022 09:57:15 -0800
Message-Id: <20220118175717.6922-1-kristen@linux.intel.com>
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

Changes from v2
---------------
* whitespace change
* use reverse christmas tree format for variable
* modify commit message to add information about user impact

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


Kristen Carlson Accardi (2):
  x86/sgx: Add accounting for tracking overcommit
  x86/sgx: account backing pages

 arch/x86/kernel/cpu/sgx/encl.c | 76 ++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/encl.h |  6 ++-
 arch/x86/kernel/cpu/sgx/main.c | 51 +++++++++++++++++++++--
 arch/x86/kernel/cpu/sgx/sgx.h  |  2 +
 4 files changed, 127 insertions(+), 8 deletions(-)

-- 
2.20.1

