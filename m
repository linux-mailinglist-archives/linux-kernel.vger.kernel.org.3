Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E714D7AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiCNGKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiCNGKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:10:51 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778C3FDB9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647238182; x=1678774182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z9ake2X2jpG73NBmd8zrDqJ46EtAmbTrrOkXWfn6vJU=;
  b=ipezwAbVL91xqy0rDQBNi4zzC5s8lj+8yE25z3ZIo5HqGYXnQzir+bps
   8U/JobdSIgedsemtkhBMbGNKPUtjmSA3NpPaSNcIKl0iPuuHK2PoFmkOd
   uOGKpH+Rcc3f4BIy3GPmdwPf0ANTOVbXWmeq8GuZLDUgs68pBvzi5nxRf
   g3PU7yS6Hgn+7ch0Wq3HC4/MArzRSqryLSpW7EOkoAEcniSwlmHOnJa97
   CxBauDfaZkGM7yCGuqWxz15KnHUheyuZw0o2nSKYn4qhUfPicH56BYL99
   rtR0dzlSqa4bWSBnlUJ0NUOPKmqaFA8/VgzziUuLoROsjWqo2BfYXqpdQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="316666675"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="316666675"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 23:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="689705358"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2022 23:09:37 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v2 0/3] firmware: stratix10-svc: Add new FCS support
Date:   Mon, 14 Mar 2022 22:09:26 +0800
Message-Id: <20220314140926.2165156-1-tien.sung.ang@intel.com>
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
 include/linux/firmware/intel/stratix10-smc.h  | 138 ++++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  50 +++++-
 3 files changed, 326 insertions(+), 22 deletions(-)

-- 
2.25.1

