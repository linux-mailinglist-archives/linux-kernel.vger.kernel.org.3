Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F584CA57D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242036AbiCBNE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbiCBNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:04:52 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF66AC2483;
        Wed,  2 Mar 2022 05:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646226250; x=1677762250;
  h=from:to:cc:subject:date:message-id;
  bh=a4hQ2aAPW5IsY3w8Y0zEVgQ+Gmampycmr+DnS2bxoZw=;
  b=mVqUDCQhKqbehTyosKVVDC0EV41Szv+pfrbxzf+5Yrm3s7ROI3mkKCSq
   eiyoIGpdDPOVaGj65193oupSWKPbPvMFg8U5wK7tAaS1Zev+F69mx2Lt2
   oKRc3ldaMn808akbbYuDEBEaiGPjWtvRwHMKmpEIRcoCFcBdZ2NFET5hn
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Mar 2022 05:04:10 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Mar 2022 05:04:08 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg02-blr.qualcomm.com with ESMTP; 02 Mar 2022 18:33:50 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 37F6C5850; Wed,  2 Mar 2022 18:33:49 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_riteshh@quicinc.com,
        asutoshd@quicinc.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_vbadigan@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V4 0/7] mmc: add error statistics for eMMC and SD card
Date:   Wed,  2 Mar 2022 18:33:40 +0530
Message-Id: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V3:
	-Dropped error stats feature flag as suggested by Adrain Hunter.
	-Separated error state related changes in separate patches as
	 suggested by Adrain Hunter.
	  [PATCH V4 4/7] : error state debug fs
	  [PATCH V4 5/7] : error state enable function
	  [PATCH V4 6/7] : error state enable in error case
	 Note: we are enabling error state before calling sdhci_dumpregs
	 we couldn't add the err state in error stats array as err state
	 is not error type.
	-Corrected Signed-off-by order as suggested by Bjron Andersson.
	-Moved error state enable code from sdhci_dumpregs to error
	 conditions as suggested by Adrain Hunter.

Changes since V2:
	-Removed userspace error stats clear debug fs entry as suggested
	 by Adrain Hunter.
	-Split patch into 4 patches
	  [PATCH V3 1/4] : sdhci driver
	  [PATCH V3 2/4] : debug fs entries
	  [PATCH V3 3/4] : core driver
	  [PATCH V3 4/4] : cqhci driver
	-Used for loop to print error messages instead of using printf
	 statements for all error messages as suggested by Adrain Hunter.
	-Introduced one flag to enable error stats feature, if any other
	 client wants to use this feature, they need to enable that flag.
	-Moved reset command timeout error statement to card init flow
	 as suggested by Adrain Hunter.

Changes since V1:
	-Removed sysfs entry for eMMC and SD card error statistics and added

Shaik Sajida Bhanu (7):
  mmc: core: Capture eMMC and SD card errors
  mmc: sdhci: Capture eMMC and SD card errors
  mmc: debugfs: Add debug fs entry for mmc driver
  mmc: debugfs: Add debug fs error state entry for mmc driver
  mmc: core: Set error state for mmc driver
  mmc: sdhci: Set error state for mmc driver
  mmc: cqhci: Capture eMMC and SD card errors

 drivers/mmc/core/core.c       |  6 ++++
 drivers/mmc/core/debugfs.c    | 75 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci-core.c |  9 +++++-
 drivers/mmc/host/sdhci.c      | 74 +++++++++++++++++++++++++++++++++++-------
 include/linux/mmc/host.h      | 29 +++++++++++++++++
 5 files changed, 180 insertions(+), 13 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

