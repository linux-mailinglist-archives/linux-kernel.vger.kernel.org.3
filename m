Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CDB47CE29
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243331AbhLVIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:24:06 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44398 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233783AbhLVIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:23:58 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BM3xrCv020047;
        Wed, 22 Dec 2021 09:23:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=wSw4OsZ/9oSlCwSDDXXk2bZPtciwi0//PjD6f99egiA=;
 b=YtVvvFtvqOluRQxTD0Gmfn+T/nMrwDBbqY53Cecocv/OLpqB8dtIrlvV3qnQLw4GBTYf
 jMDQOgF3UfOlQMWRZiAzXxwm5TMC0qF9ZMbmF/RS7uDcuufMHoq5OyvTNKH64ntII8At
 5AXZWKXiElO2NzzI/NL3XW6av4MFXzEV/7rI2YfLNIm4g+5OrDHUAo6436ovGcIAAveV
 qKEKYhN7u3ea7FFo0sFQ2COeqqtT85O4IJ4DC67tXQfY5yhaF0sqn20cUO2GyuxLw1U0
 GJ/uGKRI/dcb0Fa6aIkjGIeUhXaPOEgtIjnHrjQvtCQOFVcsw3PIjhdNOp7u4Gs1NGkI GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3d3j39b8nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 09:23:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2D1D10002A;
        Wed, 22 Dec 2021 09:23:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A4B6B2221DA;
        Wed, 22 Dec 2021 09:23:53 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 22 Dec 2021 09:23:53
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH v2 0/6] remoteproc: restructure the remoteproc VirtIO device
Date:   Wed, 22 Dec 2021 09:23:43 +0100
Message-ID: <20211222082349.30378-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_04,2021-12-21_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update from V1 [1]:
- miscellaneous fixes based on Bjorn Andersson'and Mathieu Poirier's comments
- add "arm64: defconfig: Config that had RPMSG_CHAR now gets RPMSG_CTRL"
  for 5.16 compatibility
- remove the REMOTEPROC_VIRTIO config.
- kept rproc_register_rvdev() and rproc_unregister_rvdev() but in a separate patch
- miscellaneous typo fixes.

[1] https://lkml.org/lkml/2021/10/1/243

Patchset description:

This series is a part of the work initiated a long time ago in 
the series "remoteproc: Decorelate virtio from core"[2]


Objective of the work:
- Update the remoteproc VirtIO device creation (use platform device)
- Allow to declare remoteproc VirtIO device in DT
    - declare resources associated to a remote proc VirtIO
    - declare a list of VirtIO supported by the platform.
- Prepare the enhancement to more VirtIO devices (e.g I2C, audio, video, ...).
  For instance be able to declare a I2C device in a virtio-i2C node.
- Keep the legacy working!
- Try to improve the picture about concerns reported by Christoph Hellwing [3][4]

[2] https://lkml.org/lkml/2020/4/16/1817
[3] https://lkml.org/lkml/2021/6/23/607
[4] https://patchwork.kernel.org/project/linux-remoteproc/patch/AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch/

In term of device tree this would result in such hiearchy (stm32mp1 example with 2 virtio RPMSG):

	m4_rproc: m4@10000000 {
		compatible = "st,stm32mp1-m4";
		reg = <0x10000000 0x40000>,
		      <0x30000000 0x40000>,
		      <0x38000000 0x10000>;
        memory-region = <&retram>, <&mcuram>,<&mcuram2>;
        mboxes = <&ipcc 2>, <&ipcc 3>;
        mbox-names = "shutdown", "detach";
        status = "okay";

        #address-cells = <1>;
        #size-cells = <0>;
        
        vdev@0 {
		compatible = "rproc-virtio";
		reg = <0>;
		virtio,id = <7>;  /* RPMSG */
		memory-region = <&vdev0vring0>, <&vdev0vring1>, <&vdev0buffer>;
		mboxes = <&ipcc 0>, <&ipcc 1>;
		mbox-names = "vq0", "vq1";
		status = "okay";
        };

        vdev@1 {
		compatible = "rproc-virtio";
		reg = <1>;
		virtio,id = <7>;  /*RPMSG */
		memory-region = <&vdev1vring0>, <&vdev1vring1>, <&vdev1buffer>;
		mboxes = <&ipcc 4>, <&ipcc 5>;
		mbox-names = "vq0", "vq1";
		status = "okay";
        };
};

I have divided the work in 4 steps to simplify the review, This series implements only
the step 1:
step 1:  redefine the remoteproc VirtIO device as a platform device
  - migrate rvdev management in remoteproc virtio.c,
  - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
step 2: add possibility to declare and prob a VirtIO sub node
  - VirtIO bindings declaration,
  - multi DT VirtIO devices support,
  - introduction of a remote proc virtio bind device mechanism ,
=> https://github.com/arnopo/linux/commits/step2-virtio-in-DT
step 3: Add memory declaration in VirtIO subnode
=> https://github.com/arnopo/linux/commits/step3-virtio-memories
step 4: Add mailbox declaration in VirtIO subnode
=> https://github.com/arnopo/linux/commits/step4-virtio-mailboxes

Arnaud Pouliquen (6):
  remoteproc: core: Introduce virtio device add/remove functions
  remoteproc: core: Introduce rproc_register_rvdev function
  remoteproc: Move rproc_vdev management to remoteproc_virtio.c
  remoteproc: virtio: Create platform device for the remoteproc_virtio
  remoteproc: virtio: Add helper to create platform device
  remoteproc: Instantiate the new remoteproc virtio platform device

 drivers/remoteproc/remoteproc_core.c     | 145 ++++-------------
 drivers/remoteproc/remoteproc_internal.h |  26 ++-
 drivers/remoteproc/remoteproc_virtio.c   | 195 +++++++++++++++++++++--
 include/linux/remoteproc.h               |   6 +-
 4 files changed, 233 insertions(+), 139 deletions(-)

-- 
2.17.1

