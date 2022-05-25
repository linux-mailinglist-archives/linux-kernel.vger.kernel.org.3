Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79845533C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbiEYM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiEYM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:28:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230386D3B5;
        Wed, 25 May 2022 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653481728; x=1685017728;
  h=from:to:cc:subject:date:message-id;
  bh=q+sIWWHvJkiJx9dq972yy+3PK2bE23fEgXN1NW8gC/k=;
  b=Sgyxs23iEfCIzzrw0oVTyoSZFOf1xVFq3EYm1BysROeIS6Z74hM+Cmax
   1FNHK7yKZ9qy8xDlAK6eOWGRX9DB8LQoSgPmGfLlK8iiJqW7Jd0dX1jdR
   mn2O4oIQkiOuT0NC3vK/X9EYXBz+p7lKjyFttTltVsw0jpWiJeFeHaMJ7
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 May 2022 05:28:48 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 May 2022 05:28:46 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 May 2022 17:58:24 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 497DB16F8; Wed, 25 May 2022 17:58:23 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, p.zabel@pengutronix.de,
        chris@printf.net, venkatg@codeaurora.org, gdjakov@mm-sol.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V7 0/4] mmc: add error statistics for eMMC and SD card
Date:   Wed, 25 May 2022 17:58:17 +0530
Message-Id: <1653481701-19642-1-git-send-email-quic_c_sbhanu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since V6:
	- Rebased on Ulf's(Ulf Hansson) next branch as suggested by
	  Adrain Hunter.
	- Replaced debugfs_create_file() with debugfs_create_file_unsafe()
	  as suggested by Adrain Hunter.
	- "[V6,5/5] mmc: cqhci: Capture eMMC and SD card errors" not included
	  in this Patch series as we don't have cqhci changes on Ulf's(Ulf Hansson)
	  next branch.

Changes since V5:
	- Considered all error stats enums to set error state.
	- Added missed tuning error related code changes which was
	  missed in patch set V5 as Adrain Hunter pointed.
	- Replaced DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
	  as suggested by Adrain Hunter.
	  
Changes since V4:
	- Defined new macro to increment err_stats members when error occurred
	  as suggested by Adrain Hunter.
	- Called err_stats members increment function after printing the error
	  as suggested by Adrain Hunter.
	- Considered INDEX and END_BIT errors same as CRC errors as suggested
	  by Adrain Hunter.
	- Removed Null check for host in debug fs functions and Reordered
	  err_stats declarationas suggested by Adrain Hunter.
	- Removed err_state variable stuff and updated err_state debug fs entry
	  based on the err_stats members state as suggested by Adrain Hunter.

Changes since V3:
	- Dropped error stats feature flag as suggested by Adrain Hunter.
	- Separated error state related changes in separate patches as
	  suggested by Adrain Hunter.
	  [PATCH V4 4/7] : error state debug fs
	  [PATCH V4 5/7] : error state enable function
	  [PATCH V4 6/7] : error state enable in error case
	- Note: we are enabling error state before calling sdhci_dumpregs
	  we couldn't add the err state in error stats array as err state
	  is not error type.
	- Corrected Signed-off-by order as suggested by Bjron Andersson.
	- Moved error state enable code from sdhci_dumpregs to error
	  conditions as suggested by Adrain Hunter

Changes since V2:
	- Removed userspace error stats clear debug fs entry as suggested
	  by Adrain Hunter.
	- Split patch into 4 patches
	  [PATCH V3 1/4] : sdhci driver
	  [PATCH V3 2/4] : debug fs entries
	  [PATCH V3 3/4] : core driver
	  [PATCH V3 4/4] : cqhci driver
	- Used for loop to print error messages instead of using printf
	  statements for all error messages as suggested by Adrain Hunter.
	- Introduced one flag to enable error stats feature, if any other
	  client wants to use this feature, they need to enable that flag.
	- Moved reset command timeout error statement to card init flow
	  as suggested by Adrain Hunter.

Changes since V1:
	- Removed sysfs entry for eMMC and SD card error statistics and added
	  debugfs entry as suggested by Adrian Hunter and Ulf Hansson.

Shaik Sajida Bhanu (4):
  mmc: core: Capture eMMC and SD card errors
  mmc: sdhci: Capture eMMC and SD card errors
  mmc: debugfs: Add debug fs entry for mmc driver
  mmc: debugfs: Add debug fs error state entry for mmc driver

 drivers/mmc/core/core.c    | 11 +++++--
 drivers/mmc/core/debugfs.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c   | 33 +++++++++++++++----
 drivers/mmc/host/sdhci.h   |  3 ++
 include/linux/mmc/host.h   | 26 +++++++++++++++
 include/linux/mmc/mmc.h    |  6 ++++
 6 files changed, 151 insertions(+), 9 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

