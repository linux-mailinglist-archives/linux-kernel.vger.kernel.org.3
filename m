Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A604C8127
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiCACtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiCACt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99F4615E;
        Mon, 28 Feb 2022 18:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102930; x=1677638930;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9v1Lc6js6J0RC266u9huI1+teYKaYlCTxCY2FduzRBM=;
  b=h2xqxiWUNFh62yEOwHtp2Ysb9KIus8Shs2lSJbllXGti2DF7JvE4lWGq
   8nqYU2dF4KbKY1D4uJsIEl7RpIhRVQWxBCBK3Cn3B9fO5JoUlgSAPUL+h
   6ZBm8qZ+gVBTRzmipsGPLLdCFW6fCNUVz0Z7Hk4VUpxa7Zpo0NMD8yogT
   JnlJ/8UPC+px8vIWvVfx9M28BHqaiYHqNt2YqxHjnBvP3oxNymnYrzfXK
   SkxS5wAueTcZzZR57eM4Xyr85FhLia4ooBbO0QdHMqfYTUN08aYh3lscm
   EToirlzE9eV0mF3iKClJgiLGF042Eh63eV2yC9ahhPzu90JDMV9uik+3Y
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316256470"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316256470"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:48:49 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492947479"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:48:49 -0800
Subject: [PATCH 00/11] device-core: Generic device-lock lockdep validation
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:48:49 -0800
Message-ID: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Rafael,

Here are some extensions to the 'lockdep_mutex' I came up with after
getting tired of alternating debug builds between CXL and NVDIMM
subsystem testing, and worrying about the missing lockdep coverage from
device-lock acquisition in the device-core.

The primary insight is that the existing users of the 'lockdep_mutex'
are just wrapping calls to device_lock() with a subsystem local helper
that can apply the proper lock_class for how those subsystems nest the
device_lock(). Instead of local wrapping just instruct the subsystem to
annotate the lock_class directly in the device and let the device_lock()
common code handle acquiring lockdep_mutex with the proper class.

The final patch in the series extends this further and adds an array of
lockdep_mutex instances, 1 per subsystem, so that multiple subsystems can
be validated in a single kernel image.

This has been useful for identifying scenarios when it is safe to
acquire the device_lock() in a sysfs attribute.

Thoughts?

I know its late in the cycle to be messing with device-core internals,
so feel free to put this off until 5.19. This series is based on the
cxl_device_lock() enabling that is currently in -next.

---

Dan Williams (11):
      device-core: Enable lockdep validation
      cxl/core: Refactor a cxl_lock_class() out of cxl_nested_lock()
      cxl/core: Remove cxl_device_lock()
      cxl/core: Clamp max lock_class
      cxl/core: Introduce cxl_set_lock_class()
      cxl/acpi: Add a lock class for the root platform device
      libnvdimm: Refactor an nvdimm_lock_class() helper
      ACPI: NFIT: Drop nfit_device_lock()
      libnvdimm: Drop nd_device_lock()
      libnvdimm: Enable lockdep validation
      device-core: Introduce a per-subsystem lockdep_mutex


 drivers/acpi/nfit/core.c        |   30 +++++----
 drivers/acpi/nfit/nfit.h        |   24 -------
 drivers/base/core.c             |    5 --
 drivers/cxl/acpi.c              |    1 
 drivers/cxl/core/memdev.c       |    1 
 drivers/cxl/core/pmem.c         |    6 +-
 drivers/cxl/core/port.c         |   52 ++++++++--------
 drivers/cxl/core/region.c       |    1 
 drivers/cxl/cxl.h               |   72 ++++++++--------------
 drivers/cxl/mem.c               |    4 +
 drivers/cxl/pmem.c              |   12 ++--
 drivers/cxl/port.c              |    2 -
 drivers/nvdimm/btt_devs.c       |   16 ++---
 drivers/nvdimm/bus.c            |   26 ++++----
 drivers/nvdimm/core.c           |   10 ++-
 drivers/nvdimm/dimm_devs.c      |    8 +-
 drivers/nvdimm/namespace_devs.c |   36 +++++------
 drivers/nvdimm/nd-core.h        |   51 ++++-----------
 drivers/nvdimm/pfn_devs.c       |   24 ++++---
 drivers/nvdimm/pmem.c           |    2 -
 drivers/nvdimm/region.c         |    2 -
 drivers/nvdimm/region_devs.c    |   16 ++---
 include/linux/device.h          |  130 ++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug               |   23 -------
 24 files changed, 291 insertions(+), 263 deletions(-)

base-commit: 74be98774dfbc5b8b795db726bd772e735d2edd4
