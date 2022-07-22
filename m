Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4BB57E56B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiGVRXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiGVRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:22:54 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6DE6716A;
        Fri, 22 Jul 2022 10:22:52 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MGVtvE022983;
        Fri, 22 Jul 2022 17:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=oXRW8hD74lU/IWWM5ZJT6FERYDCHxkb6M5KB/I1oOkM=;
 b=SDVyL2O7CszHGVdV4llLqZ+ET56BM60JqjZz4FgslnuTnvQKzTkM/nRLlUUFRSB5yNeA
 BXKnyCQqZxTkfNSypiKL41YCkPpdAVFJGtVZRDe0b8/apC92NOJWVwjNCKCCm9tlQnxb
 d/BGPvWL2yiqC7qA5oDEMDke59kAJZGMzsoJaoLvn/lLdkjtMAtACzcHGp3L/aHVsf1k
 cFy7/GimtYNP+NQXMUeENxjH9YW44d55CB+WFBkB7gsIGkaxkzwIw+9QfE4JZSVy68Pu
 Wlgctnxg660nr/ztP8TSDJHijpnAm8zJrFf+M1xdh2FcH5X5DLLR713HanTI7h+jwjLd vg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hfx9cgyx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 17:22:26 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5C0BC132D6;
        Fri, 22 Jul 2022 17:22:25 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id EF9FA807916;
        Fri, 22 Jul 2022 17:22:23 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v2 0/5] Add SPI Driver to HPE GXP Architecture
Date:   Fri, 22 Jul 2022 12:23:30 -0500
Message-Id: <20220722172335.33404-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: mlqQN_WzmYUDZveRQAQsaIu1-vm_Oe7V
X-Proofpoint-GUID: mlqQN_WzmYUDZveRQAQsaIu1-vm_Oe7V
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=435 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220073
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Changes since v2:
 *Changed the CONFIG_SPI_GXP from y to m in defconfig
 *Removed extra space around < > for reg in hpe,gxp-spifi.yaml
 *Changed interrupt-parrent to interrupt-parent in hpe,gxp-spifi.yaml
 *Removed repeated include file in spi-gxp.c
 *Removed unnecessary initialization of ret variable in spi-gxp.c
 *Removed conditional variable checks where failure is not possible in
  spi-gxp.c
 *Removed unecessary variable cs in spi-gxp.c
 *Removed blank gxp-spifi-remove function in spi-gxp.c
 *Fixed error messages so they are not repetitive

The GXP supports 3 separate SPI interfaces to accommodate the system
flash, core flash, and other functions. The SPI engine supports variable
clock frequency, selectable 3-byte or 4-byte addressing and a
configurable x1, x2, and x4 command/address/data modes. The memory
buffer for reading and writing ranges between 256 bytes and 8KB. This
driver supports access to the core flash and bios part.

Nick Hawkins (5):
  spi: spi-gxp: Add support for HPE GXP SoCs
  spi: dt-bindings: add documentation for hpe,gxp-spifi
  ARM: dts: hpe: Add spi driver node
  ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
  MAINTAINERS: add spi support to GXP

 .../bindings/spi/hpe,gxp-spifi.yaml           |  56 +++
 MAINTAINERS                                   |   2 +
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  58 ++++
 arch/arm/boot/dts/hpe-gxp.dtsi                |  21 +-
 arch/arm/configs/multi_v7_defconfig           |   1 +
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-gxp.c                         | 325 ++++++++++++++++++
 8 files changed, 470 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 create mode 100644 drivers/spi/spi-gxp.c

-- 
2.17.1

