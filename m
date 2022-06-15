Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E77754BE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbiFOAK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiFOAKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:10:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391F435276;
        Tue, 14 Jun 2022 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655251846; x=1686787846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n/X8rFnEpipXZVQ1ZlT8qwdqg3AWsb1mk0n1lwQwuKU=;
  b=O/PLlYPgQZlFJeeeLveQx8Lg8S7VSa8DRvMlgU9rl2m9Yc3cRZp6d9uw
   nhREsV36a2Ka5xjWmddreU//F+FnA3NHUldH0U+u4SKu7xuXlStYlmOTZ
   PyaYuvrN35pnnNIbLsiGNysrbqegTQM+H1X6LAB2VaRkFMdF9xLRQTbsi
   JZZqD/AKwgcC/HfEeHg/f76Yk+gBzZE3bUlQqc7jKelCimW6rsiPU1MZD
   crJhScH+LP7/GdZKiPzK4b0Nm/7CO726LCc7jnZBtP7KbyYNrPML1I7eT
   U2TdhfO1sa8nA1USn9F7F0iJTdOWZeL8i5cUzE6Yxlj4lCqF22w+DLFI7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279816290"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="279816290"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640662836"
Received: from alison-desk.jf.intel.com (HELO localhost) ([10.54.74.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 17:10:44 -0700
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] CXL Poison List Retrieval & Tracing
Date:   Tue, 14 Jun 2022 17:10:25 -0700
Message-Id: <cover.1655250669.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

Introducing the first piece of support for CXL Media Errors,
offering the ability to retrieve a devices poison list and
store the returned error records as kernel trace events.

The handling of the poison list is guided by the CXL 2.0 Spec
Section 8.2.9.5.4.1. [1] The usage of Trace Events to store the
Media Error records is a first look at the proposed handling
of CXL ARS events.

Example command line usage:

$ trace-cmd record -e cxl_poison_list
$ echo 1 > /sys/bus/cxl/devices/mem1/get_poison
$ trace-cmd report trace.dat

cxl_poison_list:	memdev: mem3 source EXTERNAL start 0x41 length 0x2
cxl_poison_list:	memdev: mem3 source INTERNAL start 0xc2 length 0x3
cxl_poison_list:	memdev: mem3 source INJECTED start 0x183 length 0x4
cxl_poison_list:	memdev: mem3 source INVALID start 0x284 length 0x5
cxl_poison_list:	memdev: mem3 source VENDOR start 0x707 length 0x8

[1]: https://www.computeexpresslink.org/download-the-specification

Alison Schofield (3):
  trace, cxl: Introduce a TRACE_EVENT for CXL Poison Records
  cxl/mbox: Add GET_POISON_LIST mailbox command support
  cxl/core: Add sysfs attribute get_poison for list retrieval

 Documentation/ABI/testing/sysfs-bus-cxl | 13 +++++
 drivers/cxl/cxlmem.h                    | 43 ++++++++++++++
 include/trace/events/cxl.h              | 60 ++++++++++++++++++++
 drivers/cxl/core/mbox.c                 | 75 +++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 32 +++++++++++
 5 files changed, 223 insertions(+)
 create mode 100644 include/trace/events/cxl.h


base-commit: 2263e9ed65887cc7c6e977f372596199d2c9f4af
-- 
2.31.1

