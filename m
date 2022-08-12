Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB85912AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiHLPMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiHLPMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:12:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10233A3D4B;
        Fri, 12 Aug 2022 08:12:18 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M46XN2bS6z6872P;
        Fri, 12 Aug 2022 23:09:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 17:12:15 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 16:12:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 0/4] CXL 3.0 Performance Monitoring Unit support
Date:   Fri, 12 Aug 2022 16:12:10 +0100
Message-ID: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CXL rev 3.0 specification introduces a CXL Performance Monitoring
Unit definition. CXL components may have any number of these blocks. The
definition is highly flexible, but that does bring complexity in the
driver.

Initially posted as an RFC for a number of reasons.
1) The QEMU model against which this was developed needs tidying up and
   review for correctness. I'll reply with a link to that thread once
   the QEMU code has been posted for review.
2) There are quite a lot of corner cases that will need working through
   with variants of the model, or I'll have to design a pathological
   set of CPMUs to hit all the corner cases in one go.
3) I'm not sure it makes sense to hang this of the cxl/pci driver but
   couldn't really figure out where else in the current structure we could
   make it fit cleanly.
4) The interrupt initialization code is something we talked about for DOE
   but in the end DOE interrupt support was dropped (for now). It requires
   the cxl/pci driver to do a small amount of parsing of registers otherwise
   only relevant to the CPMU driver in order to establish what interrupt
   vector the CPMU is using and hence ensure the cxl/pci driver requests
   sufficient vectors. Given this effects how other interrupts will be
   handled in cxl/pci, we need to confirm the handle in general enough
   to not need a complete rewrite when we add another interrupt use case.
5) I'm not sure how to expose to user space the sets of events that may
   be summed (given by a mask in the Counter Event Capabilities registers).
   For now the driver advertises the individual events. Each individual
   event may form part of multiple overlapping groups for example.
   It may be a case of these allowed combinations only being discoverable
   by requesting a combination and checking for errors on start.
6) Driver location. In past perf maintainers have requested perf drivers
   for PCI etc be under drivers/perf. That would require moving some
   CXL headers to be more generally visible, but is certainly possible
   if there is agreement between CXL and perf maintainers on the correct
   location.
7) Documentation needs improving, but I didn't want to spend too much
   time on that whilst we have so many open questions.  I'll separately
   raise the question about pmu->dev parenting which is mentioned in the
   Docs patch introduction.

CXL rev 3.0 specification available from https://www.computeexpresslink.org

Jonathan Cameron (4):
  cxl: Add function to count regblocks of a given type.
  cxl/pci: Find and register CXL PMU devices
  cxl: CXL Performance Monitoring Unit driver
  docs: perf: Minimal introduction the the CXL PMU device and driver.

 Documentation/admin-guide/perf/cxl.rst   |  60 ++
 Documentation/admin-guide/perf/index.rst |   1 +
 drivers/cxl/Kconfig                      |  12 +
 drivers/cxl/Makefile                     |   1 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/core.h                  |   3 +
 drivers/cxl/core/cpmu.c                  |  67 ++
 drivers/cxl/core/pci.c                   |   2 +-
 drivers/cxl/core/port.c                  |   4 +-
 drivers/cxl/core/regs.c                  |  64 +-
 drivers/cxl/cpmu.c                       | 942 +++++++++++++++++++++++
 drivers/cxl/cpmu.h                       |  54 ++
 drivers/cxl/cxl.h                        |  16 +
 drivers/cxl/cxlpci.h                     |   1 +
 drivers/cxl/pci.c                        |  78 +-
 15 files changed, 1299 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/cxl.rst
 create mode 100644 drivers/cxl/core/cpmu.c
 create mode 100644 drivers/cxl/cpmu.c
 create mode 100644 drivers/cxl/cpmu.h

-- 
2.32.0

