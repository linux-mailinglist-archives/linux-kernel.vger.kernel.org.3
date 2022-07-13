Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82995735A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbiGMLhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbiGMLgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:36:54 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851381034D5;
        Wed, 13 Jul 2022 04:36:45 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D8r3Gq023581;
        Wed, 13 Jul 2022 13:36:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=u78HHDZ8gsijyl+0izTnhI2s/F/qPUzdVKZRzNXsq0Y=;
 b=bmLIdYrZClWz2YZX6qj0uN7Y2wBjGnGaYWoQew+9i2kHNfRX3/GzhEdOZBfdm59eyKY9
 t5VMXp7DbAmOliXHUZW/ed3gZ/vGhXFZAROjvyRLUsh+dUNh8++Ew+E229jW8O/sneK1
 xgki4krJODbXtpJpkelFwfeUb6gBdoAftkktOfjGobHBOoDRru9b+9D3EActHFBg+reg
 V9KJ5m+xDQhx0npM6NM6GrZy3NA9HK8cLTLK3oW53Zh2cgLqfUt4Y1bFSJoEr3RCcczr
 zkqhpuerKLf0VIn5IX1e6yZJxd64RtkvpLZi1n8yF+JIDwmUAuyH9Zpa8zloyaM2PnMX gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h94gugp7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 13:36:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B1059100038;
        Wed, 13 Jul 2022 13:36:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA18721D388;
        Wed, 13 Jul 2022 13:36:29 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 13 Jul
 2022 13:36:27 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v7 0/4] remoteproc: restructure the remoteproc VirtIO device
Date:   Wed, 13 Jul 2022 13:36:08 +0200
Message-ID: <20220713113612.2117279-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Update from V6 [1]:

Updates based on Mathieu's comments.
Updates are listed in the commit message of each patch.

[1] https://lkml.org/lkml/2022/6/3/558

2) Patchset description:

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

In term of device tree this would result in such hierarchy (stm32mp1 example with 2 virtio RPMSG):

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
step 1: Redefine the remoteproc VirtIO device as a platform device
  - migrate rvdev management in remoteproc virtio.c,
  - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
step 2: Add possibility to declare and probe a VirtIO sub node
  - VirtIO bindings declaration,
  - multi DT VirtIO devices support,
  - introduction of a remote proc virtio bind device mechanism ,
=> https://github.com/arnopo/linux/commits/step2-virtio-in-DT
step 3: Add memory declaration in VirtIO subnode
=> https://github.com/arnopo/linux/commits/step3-virtio-memories
step 4: Add mailbox declaration in VirtIO subnode
=> https://github.com/arnopo/linux/commits/step4-virtio-mailboxes

Arnaud Pouliquen (4):
  remoteproc: core: Introduce rproc_rvdev_add_device function
  remoteproc: core: Introduce rproc_add_rvdev function
  remoteproc: Move rproc_vdev management to remoteproc_virtio.c
  remoteproc: virtio: Create platform device for the remoteproc_virtio

 drivers/remoteproc/remoteproc_core.c     | 153 +++---------------
 drivers/remoteproc/remoteproc_internal.h |  23 ++-
 drivers/remoteproc/remoteproc_virtio.c   | 188 ++++++++++++++++++++---
 include/linux/remoteproc.h               |   6 +-
 4 files changed, 209 insertions(+), 161 deletions(-)

-- 
2.24.3

