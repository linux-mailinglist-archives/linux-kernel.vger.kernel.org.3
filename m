Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4149532C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiATR2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:28:14 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38887 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiATR0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642699613; x=1674235613;
  h=from:to:cc:subject:date:message-id;
  bh=yoXWUpciytUxGVmD3OIc8Emx9Q31wdTLP4aBGRalkQQ=;
  b=cyUzi8aE1TY06MjKLuJpBCgDnucVRwapDIXdfzOW+donpzG3TWb9Teaa
   sZT3+Ekpn1wpcjojETtVfnB7vffXlOGmbKnS5waryY5/AVIf0nmfNsZYt
   d/fV8iXlQuyLWnQC0g7p5e6/T0+q8VIinmweOYoQGJpXpS3rAJjJHS+0I
   Y=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 20 Jan 2022 09:26:53 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 20 Jan 2022 09:26:51 -0800
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 20 Jan 2022 22:56:28 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 27115538E; Thu, 20 Jan 2022 22:56:27 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, quic_asutoshd@quicinc.com,
        ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stummala@codeaurora.org, vbadigan@codeaurora.org,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        sartgarg@codeaurora.org, nitirawa@codeaurora.org,
        sayalil@codeaurora.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V3 0/4] mmc: add error statistics for eMMC and SD card
Date:   Thu, 20 Jan 2022 22:56:18 +0530
Message-Id: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V2:
	-Removed userspace error stats clear debug fs entry as suggested by Adrain Hunter.
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
	 debugfs entry as suggested by Adrian Hunter and Ulf Hansson.

Shaik Sajida Bhanu (4):
  mmc: sdhci: Capture eMMC and SD card errors
  mmc: debugfs: Add debug fs entry for mmc driver
  mmc: core: Capture eMMC and SD card errors
  mmc: cqhci: Capture eMMC and SD card errors

 drivers/mmc/core/core.c       |  8 +++++
 drivers/mmc/core/debugfs.c    | 81 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/queue.c      |  3 ++
 drivers/mmc/host/cqhci-core.c |  9 ++++-
 drivers/mmc/host/sdhci-msm.c  |  3 ++
 drivers/mmc/host/sdhci.c      | 72 +++++++++++++++++++++++++++++++-------
 include/linux/mmc/host.h      | 31 +++++++++++++++++
 7 files changed, 194 insertions(+), 13 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

