Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8053CD46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiFCQcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiFCQcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:32:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8CA38DA1;
        Fri,  3 Jun 2022 09:32:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253GIYpt004994;
        Fri, 3 Jun 2022 18:32:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=XYfsgN0Fz1IFWhCX2F/Bh12FPK+Ortq56BmKZ6Jz8Bs=;
 b=7ch4VNH4Y7lUZrcXNyRXs+6zPKADMCtk3xau0A+z5WNye7tIlw6lgqCeHZtOnxClyhFZ
 Sb7JFK74azX4V7ZrreI6AESR2cYhuNtV5ztIAyHl6C7TkbsyWtQtcHhk0FgCk9LzJt8G
 klyD+f1jhDj1Z2fwwCO7zydHJZYlj0Dsvc+hanCH70l4jlRFXQDjeJefDpjqcVU5dgDB
 McMqQAdDn/Aa0ArVPzTmPxNtVu9p3EiWL1OxxeqPQBMx//Zrk0U6Vi1o5z3+uk0sVoEm
 5zs/Jj6CFek/Rl/2l5qEPzXDfEQQWUJT/DGQSbdlUYs/QwLK4ZYbvRICWrI0bfZnJewv 0Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gbc5174sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 18:32:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6585E10002A;
        Fri,  3 Jun 2022 18:32:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D57C0231533;
        Fri,  3 Jun 2022 18:32:01 +0200 (CEST)
Received: from localhost (10.75.127.48) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 3 Jun
 2022 18:32:01 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v6 0/4] remoteproc: restructure the remoteproc VirtIO device
Date:   Fri, 3 Jun 2022 18:31:54 +0200
Message-ID: <20220603163158.612513-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_05,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Update from V5 [1]:

Updates based on Mathieu's comments.
Updates are listed in the commit message of each patch.

[1] https://lkml.org/lkml/2022/4/6/597

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
step 1:  redefine the remoteproc VirtIO device as a platform device
  - migrate rvdev management in remoteproc virtio.c,
  - create a remotproc virtio config ( can be disabled for platform that not use VirtIO IPC.
step 2: add possibility to declare and probe a VirtIO sub node
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

