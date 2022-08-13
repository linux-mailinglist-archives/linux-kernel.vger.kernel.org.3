Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434F95918E7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 07:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHMFcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMFcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 01:32:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38453DF9E;
        Fri, 12 Aug 2022 22:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660368767; x=1691904767;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tmicp3+kpfzbTsvkNaEOyBuVCc8qYON6duVW3+Q/kzI=;
  b=h7tAnusI/x/PffFpQcSt+5kzmY5N0Aa9rTG/9LDZKxyKHMPllJBxOk9k
   +UCqgzerEcFEOVhU4CayCsOtf1CgpBA6qGFEkOOyoy9x/PF0lXhT67GVI
   J4YsBcrW8cxF04xoI/UzUpZrXh1YSpelQOq/fShPoC9Ttl5rWDohSA7LU
   ES7BWBOdMCKvZ3Fvft6K+w71L0Sw9XwTxluJCJ2LIzrclrX8+OXNghaHL
   6ERANUIjrSJN9Afvt3kFBpZCbPW/4IMcgg2WfYkaiq4GHz+T4ZTWfxcIk
   OucvFgfdE/ezoImaiHtLV3XWOc/3X0COpE4lq7sLM2R/yTWnMBd9IgAjs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292999041"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292999041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="851775408"
Received: from jchen8-mobl.amr.corp.intel.com (HELO localhost) ([10.212.10.85])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 22:32:45 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [RFC PATCH 0/9] CXL: Read and clear event logs
Date:   Fri, 12 Aug 2022 22:32:34 -0700
Message-Id: <20220813053243.757363-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Event records inform the OS of various device events.  Events are not needed
for any kernel operation but various user level software will want to track
events.

Add event reporting through the trace event mechanism.  On driver load read and
clear all device events.

Normally interrupts will trigger new events to be reported as they occur.
Because the interrupt code is still being worked on this series provides a
cxl-test mechanism to create a series of events and trigger the reporting of
those events.

This series is submitted as an RFC for a few reasons:

	1) Interrupt support is still missing
	2) I'd like to get comments on the format of the trace events
	3) Some of the event formats are badly aligned and I would like to see
	   if there is any clarification on how the data will be formatted
	   (See individual patches for details)

Ira Weiny (9):
  cxl/mem: Implement Get Event Records command
  cxl/mem: Implement Clear Event Records command
  cxl/mem: Clear events on driver load
  cxl/mem: Trace General Media Event Record
  cxl/mem: Trace DRAM Event Record
  cxl/mem: Trace Memory Module Event Record
  cxl/test: Add generic mock events
  cxl/test: Add specific events
  cxl/test: Simulate event log overflow

 MAINTAINERS                       |   1 +
 drivers/cxl/core/mbox.c           | 143 ++++++++
 drivers/cxl/cxlmem.h              | 149 +++++++++
 drivers/cxl/pci.c                 |   2 +
 include/trace/events/cxl-events.h | 521 ++++++++++++++++++++++++++++++
 include/uapi/linux/cxl_mem.h      |   2 +
 tools/testing/cxl/test/mem.c      | 399 +++++++++++++++++++++++
 7 files changed, 1217 insertions(+)
 create mode 100644 include/trace/events/cxl-events.h


base-commit: 1cd8a2537eb07751d405ab7e2223f20338a90506
-- 
2.35.3

