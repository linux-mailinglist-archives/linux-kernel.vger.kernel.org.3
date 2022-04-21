Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB0D50A45C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390198AbiDUPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377040AbiDUPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:39:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8DD47068;
        Thu, 21 Apr 2022 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555396; x=1682091396;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HRjWqKMI48PJpBkmXwqNCKGbFsNs0ocG1yVkfojUm7A=;
  b=MP27JmYeuZWV0D/98q/TdozNiRDz+olBh5OH27YcnQy3zyiGRBJoWKuL
   iOpGyoTiO82+x4/hUXedCdIxVJ5DrA/7HV0y2u4k0gZe9fgcLCNSdAAhG
   oGuf88H/Zk0G3L8rCLhTfvaY0+0oTHGQGNT4B/sfkJZQ23IYBn0UuRNiT
   OkDaKnKJM1JFCA/9+cc8ZsG+LICU/lJtqW3U45HlWdWmXfOgvFIwvUu5r
   y2mksjxdH1QCavzknawXSyX1A5//LqysDYgLqFA4M9lECnboa9uDMM+fY
   Nd5N5FsD5sBKN2aR5qH+ssJue26i11Pvr6WcxPw392Jx/CCu+9YZQEnb1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264159909"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="264159909"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="593708723"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:33:08 -0700
Subject: [PATCH v3 0/8] device-core: Enable device_lock() lockdep validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 Apr 2022 08:33:08 -0700
Message-ID: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]
- Use lockdep_set_class(), lockdep_set_class_and_subclass(), and
  lock_set_class() instead of a 'lockdep_mutex' in 'struct device'.
  (Peter and Waiman)
- Include a fix identifed by this new infrastructure

[1]: https://lore.kernel.org/r/164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com

The device_lock() uses lockdep_set_novalidate_class() because it is
taken in too many contexts that cannot be described by a single mutex
lock class. The lack of lockdep coverage leads to deadlock scenarios
landing upstream. To mitigate that problem the lockdep_mutex was added
[2].

The lockdep_mutex, however, is an unscalable hack that overlooks
advancements in the lockdep API to change a given lock's lock class [3].
With lockdep_set_class() a device subsystem can initialize a dedicated
lock class per device type at device creation time, with
lock_set_class() a device-driver can temporarily override a lockdep
class after-the-fact. Use lockdep class assignment APIs to replace the
usage of lockdep_mutex in the CXL and NVDIMM subsystems, and delete
lockdep_mutex.

[2]: commit 87a30e1f05d7 ("driver-core, libnvdimm: Let device subsystems add local lockdep coverage")
[3]: https://lore.kernel.org/r/Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net

---

Dan Williams (8):
      cxl: Replace lockdep_mutex with local lock classes
      cxl/acpi: Add root device lockdep validation
      cxl: Drop cxl_device_lock()
      nvdimm: Replace lockdep_mutex with local lock classes
      ACPI: NFIT: Drop nfit_device_lock()
      nvdimm: Drop nd_device_lock()
      device-core: Kill the lockdep_mutex
      nvdimm: Fix firmware activation deadlock scenarios


 drivers/acpi/nfit/core.c        |   30 ++++++++-------
 drivers/acpi/nfit/nfit.h        |   24 ------------
 drivers/base/core.c             |    3 --
 drivers/cxl/acpi.c              |   15 ++++++++
 drivers/cxl/core/memdev.c       |    3 ++
 drivers/cxl/core/pmem.c         |   10 ++++-
 drivers/cxl/core/port.c         |   68 ++++++++++++++++------------------
 drivers/cxl/cxl.h               |   78 ---------------------------------------
 drivers/cxl/mem.c               |    4 +-
 drivers/cxl/pmem.c              |   12 +++---
 drivers/nvdimm/btt_devs.c       |   23 +++++++-----
 drivers/nvdimm/bus.c            |   38 ++++++++-----------
 drivers/nvdimm/core.c           |   14 +++----
 drivers/nvdimm/dax_devs.c       |    4 +-
 drivers/nvdimm/dimm_devs.c      |   12 ++++--
 drivers/nvdimm/namespace_devs.c |   46 ++++++++++++++---------
 drivers/nvdimm/nd-core.h        |   68 +---------------------------------
 drivers/nvdimm/pfn_devs.c       |   31 +++++++++-------
 drivers/nvdimm/pmem.c           |    2 +
 drivers/nvdimm/region.c         |    2 +
 drivers/nvdimm/region_devs.c    |   20 ++++++----
 include/linux/device.h          |   30 +++++++++++++--
 lib/Kconfig.debug               |   23 ------------
 23 files changed, 209 insertions(+), 351 deletions(-)

base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
