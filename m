Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42E24D7955
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiCNC2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiCNC2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:28:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39220BC05
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647224826; x=1678760826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GEyE/4btuBn2qY75wID4c2MfMBzqfeDl8itxIezppds=;
  b=jWw6sqGKetCImTRs3qmmHdR8o27qiOgO2FunjfvJpcVPseLy74/15l9E
   2jQlRGgJmngupYzO22jwxyyYNb2SnIKvtI+WcDHWPjB+7lTDQe9UUNvCi
   K11V5iiQbFGW62LhfirIIk3moofhrRZ3/KJTZ9kMHeh2q037C+VgXTylA
   x7FnRC/r1zSWhN+XbJZPp5VwGtaf5eCHMHNfpJDBOlqZWdg1LtOC1H6t+
   tTIzDM6+stzY9lHydk+UncO1pBWwMpbDGcne/qGSHhb9h94TkdFYagTHe
   nEQvOuA7VdnevMBBEy1C1biMJdWvRXRvO3qKqVakU1dSEJt1dffBZsSe3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236523921"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="236523921"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="645620297"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2022 19:27:04 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 0/3] firmware: stratix10-svc: Add new FCS support
Date:   Mon, 14 Mar 2022 18:26:44 +0800
Message-Id: <20220314102644.1746670-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

Hi,
Beginning with Stratix10 and Agilex, a new fpga crypto services shall be
supported. This is a first of many patches to add new cryto
functionalities in the form of new commands to the firmware svc driver.
The new crytpo services are provided by the Secure device manager(SDM).
The firmware SVC driver receives the commands from the client drivers
and sends this command via SMC calls to the Arm trusted firmware(ATF) or
U-boot firmware at EL3. The firmware interrupt service handlers than,
processes the new commands and send them the SDM's mailbox. 
To support asynchronos commands, we have introduced a
INTEL_SIP_SMP_SERVICE_COMPLETED command to poll the completion of the
crypto operations. This polling commands are essential for the rest of
the FCS commands. All new FCS commands shall have a prefix of
INTEL_SIP_SMC_FCS_XXXXX.
There shall also be a new FCS client device driver called intel_fcs 
that will be added. The SVC firmware driver registers the new FCS client
driver and allocates a new channel for this device driver. This brings
the total supported client drivers to 3 (RSU, FPGA and FCS)
We have tested this functionality by regression testing within Intel's
test framework. 

Ang Tien Sung (3):
  firmware: stratix10-svc: extend svc to support FCS features
  firmware: stratix10-svc: add new polling command for FCS
  firmware: stratix10-svc: add new FCS commands

 drivers/firmware/stratix10-svc.c              | 160 ++++++++++++++++--
 include/linux/firmware/intel/stratix10-smc.h  | 137 ++++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  50 +++++-
 3 files changed, 325 insertions(+), 22 deletions(-)

-- 
2.25.1

