Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62D46B539
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhLGIMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:12:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42028 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229953AbhLGIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:12:38 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B73n2xh018579;
        Tue, 7 Dec 2021 09:08:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=gjFn/nVZwppaV7/cJByjqjgVSBYzYI5mm14aPOcd/5E=;
 b=PkSr1dkwbvvrtFEcGYEqKAXakUbvVRy3xBvMrhdHKO8q/XBW/5Xv2z9yirTkyZ7aNR6G
 1/k1dv7mAwkR7r/XCgrRuwn5Njg3OPEaTKXIGJvwrXQj8wfQ1MhSvECKCGptat/PzwRa
 n5F8vzQvHeA9gQ0MqlDn1z8BEuFkiO5FmAuF6FM2ztAZY6D382Dle+iMKytKNl5tjW3J
 6Kw3LbE20l1V55WiMzG5xSLT/f1aDowkfZXbZ2GL/OZgo+fih/cPDnFwo/j/g8f8XGNy
 flzG61QggEG479Y8Ww5MXg6K2A7/2WkwRC3EgUa4nSczzHkWA6xrcIQySqTttc/u9yjJ oA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csp32bc8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 09:08:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AFE7510002A;
        Tue,  7 Dec 2021 09:08:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D268E2220AE;
        Tue,  7 Dec 2021 09:08:52 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 7 Dec 2021 09:08:52
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v8 00/13] Restructure the rpmsg_char driver and introduce rpmsg_ctrl driver
Date:   Tue, 7 Dec 2021 09:08:30 +0100
Message-ID: <20211207080843.21222-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_03,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update from V7 [1]:
- miscellaneous fixes based on Bjorn Andersson's comments
- add "arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL"
  for 5.16 compatibility

Patchset description:

The current rpmsg_char module implements a /dev/rpmsg_ctrl interface that provides the ability to
instantiate char devices (/dev/rpmsgX) associated with an rpmsg endpoint for communication with the
remote processor.
This implementation fit with QCOM rpmsg backend but not with themagement by chanel implemented in 
the generic rpmsg virtio backend.
This series restructures the rpmsg_char driver to decorrelate the control part from the data part
in order to improve its compatible with the rpmsg virtio backend.

Objective:
- Expose a /dev/rpmsg_ctrlX interface for the application that is no longer dedicated to the
  rpmsg_char but generalized to all rpmsg services. This offers capability to create and destroy
  rpmsg channels from a user's application initiative (using the new RPMSG_CREATE_DEV_IOCTL and
  RPMSG_DESTROY_DEV_IOCTL controls).
  An application will be able to create/establish an rpmsg communication channel to communicate
  with the remote processor, and not only wait the remote processor initiative.
  This is interesting for example to establish a temporary communication link for diagnosis,
  calibration, debugging... or instantiate  new data flows on some user actions.
- Add capability to probe the rpmsg_char device at the initiative of the remote processor
 (rpmsg service announcement mechanism).
  This allows platforms based on the rpmsg virtio backend to create the /dev/rpmgX interface with
  a rpmsg name service announcement.

Subsets:
  - Extract the control part of the char dev and create the rpmsg_ctrl.c file (patches 1 to 6)
  - Introduce the "rpmsg-raw" channel in rpmsg_char(patches 7 to 11)
  - Introduce the RPMSG_CREATE_DEV_IOCTL IOCTL and RPMSG_DESTROY_DEV_IOCTL to instantiate RPMsg
    devices (patch 12)
    The application can then create or release a channel by specifying:
       - the name service of the device to instantiate.   
       - the source address.
       - the destination address.
  - Send a ns announcement to the remote processor on default endpoint creation (patche 13)

This series has be applied and tested on for-next branch 'c4b39a582b9b)[2].

[1] https://lkml.org/lkml/2021/11/8/501
[2] https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git

Arnaud Pouliquen (10):
  rpmsg: char: Export eptdev create an destroy functions
  rpmsg: Create the rpmsg class in core instead of in rpmsg char
  rpmsg: Move the rpmsg control device from rpmsg_char to rpmsg_ctrl
  arm: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
  RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL
  arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL
  rpmsg: Update rpmsg_chrdev_register_device function
  rpmsg: char: Refactor rpmsg_chrdev_eptdev_create function
  rpmsg: Introduce rpmsg_create_default_ept function
  rpmsg: char: Add possibility to use default endpoint of the rpmsg
    device.
  rpmsg: char: Introduce the "rpmsg-raw" channel
  rpmsg: ctrl: Introduce new RPMSG_CREATE/RELEASE_DEV_IOCTL controls
  rpmsg: core: Send a ns announcement when a default endpoint is created

 arch/arm/configs/qcom_defconfig   |   1 +
 arch/arm64/configs/defconfig      |   1 +
 arch/riscv/configs/defconfig      |   1 +
 arch/riscv/configs/rv32_defconfig |   1 +
 drivers/rpmsg/Kconfig             |   8 +
 drivers/rpmsg/Makefile            |   1 +
 drivers/rpmsg/qcom_glink_native.c |   2 +-
 drivers/rpmsg/qcom_smd.c          |   2 +-
 drivers/rpmsg/rpmsg_char.c        | 246 +++++++++++------------------
 drivers/rpmsg/rpmsg_char.h        |  46 ++++++
 drivers/rpmsg/rpmsg_core.c        |  84 +++++++++-
 drivers/rpmsg/rpmsg_ctrl.c        | 250 ++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h    |  14 +-
 drivers/rpmsg/virtio_rpmsg_bus.c  |   2 +-
 include/uapi/linux/rpmsg.h        |  10 ++
 15 files changed, 505 insertions(+), 164 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_char.h
 create mode 100644 drivers/rpmsg/rpmsg_ctrl.c

-- 
2.17.1

