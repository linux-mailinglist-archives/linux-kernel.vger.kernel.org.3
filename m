Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0940652E78B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiETIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347164AbiETIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:30:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B5D15A744;
        Fri, 20 May 2022 01:30:25 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24K3ZQ3p004615;
        Fri, 20 May 2022 10:29:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=hneNV+UTX/MQsnnJ1NOLYhI1GUf8ZaFIZymZJDulI7Y=;
 b=bVSQ9bpLAesU4gdQU0NY7YC9ypuO98FoqvhNOA2l0Rhf5a3s228zScK5H/gq2trCQuc3
 oqSJPMYWZoRd4EEYCDCMV8rgHfCBZ4lhThMhnF61btFjxfFjBVczQEa726hgc0pmOy1M
 Y84p0AynckK6gqePolG0QuO9NW/TXm7WHmPhgnTFTwWj79PVZIbjbrjEvkz51tlj9CGX
 oDfoDXfZ8/edYsF0cRzfFBHV0C6ps7//j6tyXfCS92a6Ry/gqX8FrFUT93t81GKlhVPM
 LHXXO0JMDnsdgfhhRw/u2vSa5O5Od7/clCS1TbPkhBNkuv3zY8NulMdUilILWY3MvYyv kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g23s22tjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:29:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF853100038;
        Fri, 20 May 2022 10:29:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D8EE1214D2D;
        Fri, 20 May 2022 10:29:56 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 20 May
 2022 10:29:54 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        <arnaud.pouliquen@foss.st.com>
Subject: [RFC PATCH 00/10] Introduction of rpmsg flow control service
Date:   Fri, 20 May 2022 10:29:30 +0200
Message-ID: <20220520082940.2984914-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_03,2022-05-19_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes an implementation for the rpmsg virtio transport
backend, of the signaling API proposed by Deepak Kumar Singh:
"rpmsg and glink signaling API support" [1]

The aim of the series is to offer the possibility for an endpoint to inform
a remote endpoint about its state, based on a software flow control[2].

For this a new rpmsg service( with a fixed address 64) is proposed.
It is responsible for:
- transmitting local endpoint flow control information to the remote side,
- informing a local endpoint about a remote endpoint flow control.

For the rpmsg virtio transport layer the service is negotiated thanks to the 
virtio feature flag: VIRTIO_RPMSG_F_FC

Notice that this pull request introduces new feature in the rpmsg protocol,
So it has to be aligned with OpenAMP implementation.
Pending OpenAMP pull request is available here:
https://github.com/OpenAMP/open-amp/pull/394


[1]https://lkml.org/lkml/2022/1/18/867
[2]https://en.wikipedia.org/wiki/Software_flow_control

Arnaud Pouliquen (8):
  rpmsg: core: Add rpmsg device remote flow control announcement ops
  rpmsg: virtio: Implement the announce_remote_fc ops
  rpmsg: Introduce flow control channel driver
  rpmsg: virtio: Add support of the VIRTIO_RPMSG_F_FC feature
  rpmsg: virtio: Implement the set_flow_control ops
  rpmsg: Add the destination address in rpmsg_set_flow_control
  rpmsg: tty : Add the support of the flow control
  rpmsg: virtio: Set default dst address on flow control

Deepak Kumar Singh (2):
  rpmsg: core: Add signal API support
  rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support

 drivers/rpmsg/Kconfig            |  11 +++
 drivers/rpmsg/Makefile           |   1 +
 drivers/rpmsg/rpmsg_char.c       |  56 +++++++++++++--
 drivers/rpmsg/rpmsg_core.c       |  47 +++++++++++++
 drivers/rpmsg/rpmsg_fc.c         | 113 +++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h   |   9 +++
 drivers/rpmsg/virtio_rpmsg_bus.c | 111 +++++++++++++++++++++++++++++-
 drivers/tty/rpmsg_tty.c          |  50 ++++++++++++++
 include/linux/rpmsg.h            |  15 ++++
 include/linux/rpmsg/fc.h         |  51 ++++++++++++++
 10 files changed, 456 insertions(+), 8 deletions(-)
 create mode 100644 drivers/rpmsg/rpmsg_fc.c
 create mode 100644 include/linux/rpmsg/fc.h

-- 
2.25.1

