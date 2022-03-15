Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7864C4D92C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbiCODFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiCODFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:05:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3C2BEB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 20:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647313470; x=1678849470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RckwowehQyDepnPzN2JE4NAVXRG9oSdLblW6X1cgWCM=;
  b=Xq/Mu3X+kFGYoQbcLEz1pMA07eS9vYRmW4MPJwQ6cgs1EzUVfnwFaSeL
   b0O+8rziVxKSp3EmA0JPea8M4A5EkOGstcx5bT3xLlXIohBDLW0hEAG1/
   +vNXaOtbFLEK/xXYsou64GwaPMst+QCjm0LlIgn8RAvdXGYpF5Iu9JGs9
   A9uzanifFGzfx+x2vmbO/6ldX05RwBWrXixOWwCOcfCX6YHbc8pTS/sHX
   K7xQ0eUEuKC5RUGuYWmc3M6+Rxy94+pMLRJtgza7E/haJ9PmvV+mzCrJE
   DyB9dQnu5ptiZpVwGu+PsmKOyMPRai8M6tVsA8UOXaPgqE4/Ubwiu39bq
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="319420599"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="319420599"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 20:04:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515697945"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.87])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 20:04:28 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v3 0/3] firmware: stratix10-svc: Add new FCS support
Date:   Tue, 15 Mar 2022 19:04:21 +0800
Message-Id: <20220315110421.2871442-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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
To support asynchronous commands, we have introduced a
INTEL_SIP_SMP_SERVICE_COMPLETED command to poll the completion of the
crypto operations. This polling commands are essential for the rest of
the FCS commands. All new FCS commands shall have a prefix of
INTEL_SIP_SMC_FCS_XXXXX. There shall also be a new FCS client device 
driver called intel_fcs that will be added. The SVC firmware driver 
registers the new FCS client driver and allocates a new channel for this 
device driver. This brings the total supported client drivers to 3 
(RSU, FPGA and FCS) We have tested this functionality by regression testing
within Intel's test framework. 

The first patch creates the new FCS client device driver.
The second patch adds the new asynchronous polling command for FCS.
The third patch adds the new FCS commands to support SDOS encryption 
and decryption.

changelog v2:
* Have corrected the missing /** due to accidental removal as 
* reported by Reported-by: kernel test robot <lkp@intel.com>.
* Re-run and compilation is passing. 

changelog v3:
* Resolve the warning warning: variable a3, a4 and a5 set but not used. 
* The fix requires changes to invoke_fn to send all command arguments a0 
* to a7 that is a SMC call to ATF/firmware.
* Had corrected the polling command
* which was a merge of an internal patch as the a0 to a7 
* that was due to be upstreamed to prevent this commit from introducing 
* new bug to the polling command. 
* Modified the patch 1 to 3 subject to fit within 75 columns.

Ang Tien Sung (3):
  firmware: stratix10-svc: Add support for FCS
  firmware: stratix10-svc: add FCS polling command
  firmware: stratix10-svc: add new FCS commands

 drivers/firmware/stratix10-svc.c              | 175 ++++++++++++++++--
 include/linux/firmware/intel/stratix10-smc.h  | 140 +++++++++++++-
 .../firmware/intel/stratix10-svc-client.h     |  50 ++++-
 3 files changed, 340 insertions(+), 25 deletions(-)

-- 
2.25.1

