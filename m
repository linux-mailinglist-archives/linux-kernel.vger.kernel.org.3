Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D352B5366C5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354395AbiE0Rye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354358AbiE0Ry0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:54:26 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84ACFE2D;
        Fri, 27 May 2022 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653674065; x=1685210065;
  h=from:to:cc:subject:date:message-id;
  bh=VslKy+cQh3K5tskcByZ1fkBb+6Z7nd3UgJVRTvIvRGc=;
  b=yBixkUVQByxLg2WlKSGlK9n/JxSzHdoW/8jmVVbVBDW+oUL9W8zaWCtZ
   r5IW5V8VJ0BAcdtUWL3kcUI6ce0+bNyzi0oB4AOoG1LxNkVfieE/ooEWa
   ChuRbbIreeO0/fU2pl0JzD6L+xpOwljjPWlzKvTCLXv7e4XCzwW4KmlqI
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 May 2022 10:54:25 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 May 2022 10:54:23 -0700
X-QCInternal: smtphost
Received: from c-sbhanu-linux.qualcomm.com ([10.242.50.201])
  by ironmsg01-blr.qualcomm.com with ESMTP; 27 May 2022 23:23:59 +0530
Received: by c-sbhanu-linux.qualcomm.com (Postfix, from userid 2344807)
        id 7F51D176D; Fri, 27 May 2022 23:23:58 +0530 (IST)
From:   Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        wsa+renesas@sang-engineering.com, shawn.lin@rock-chips.com,
        yoshihiro.shimoda.uh@renesas.com, digetx@gmail.com,
        quic_asutoshd@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sartgarg@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sayalil@quicinc.com,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH V8 0/5] mmc: add error statistics for eMMC and SD card
Date:   Fri, 27 May 2022 23:23:51 +0530
Message-Id: <1653674036-21829-1-git-send-email-quic_c_sbhanu@quicinc.com>
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

Changes since V7:
	- Patch set V6 rebased on Ulf's(Ulf Hansson) master branch instead
	  of Ulf's (Ulf Hansson) next branch by mistake. So rebased patch
	  set on Ulf's next branch now as suggested by Adrain Hunter.

Changes since V6:
	- Rebased on Ulf's(Ulf Hansson) next branch as suggested by
	  Adrain Hunter.
	- Replaced debugfs_create_file() with debugfs_create_file_unsafe()
	  as suggested by Adrain Hunter.
	- "[V6,5/5] mmc: cqhci: Capture eMMC and SD card errors" not
	  included in this Patch series as we don't have cqhci changes
	  on Ulf's(Ulf Hansson)next branch.

Changes since V5:
	- Considered all error stats enums to set error state.
	- Added missed tuning error related code changes which was
	  missed in patch set V5 as Adrain Hunter pointed.
	- Replaced DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE
	  as suggested by Adrain Hunter.
	  
Changes since V4:
	- Defined new macro to increment err_stats members when error occured
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

Shaik Sajida Bhanu (5):
  mmc: core: Capture eMMC and SD card errors
  mmc: sdhci: Capture eMMC and SD card errors
  mmc: debugfs: Add debug fs entry for mmc driver
  mmc: debugfs: Add debug fs error state entry for mmc driver
  mmc: cqhci: Capture eMMC and SD card errors

 drivers/mmc/core/core.c       | 10 +++++-
 drivers/mmc/core/debugfs.c    | 79 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/cqhci-core.c |  9 ++++-
 drivers/mmc/host/sdhci.c      | 59 ++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h      |  3 ++
 include/linux/mmc/host.h      | 26 ++++++++++++++
 include/linux/mmc/mmc.h       |  6 ++++
 7 files changed, 175 insertions(+), 17 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

