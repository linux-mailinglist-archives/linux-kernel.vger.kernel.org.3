Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F26B57BF15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiGTULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiGTULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:11:17 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D643138D;
        Wed, 20 Jul 2022 13:11:15 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KJq9ri001534;
        Wed, 20 Jul 2022 20:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=tBXv1RN/QxUEA3fvWqFQRswjLYubC9wBxdrrvuT2QNs=;
 b=dVcce2w28B9/gLrmpvtHfdkEDFnSK7C8l8R5dLacOIZHX/1JZd2D9FLdY4vfckAoU1X3
 rtdMn2x9jBEX7W93XZFULTQIlDQS5ajHLdtfrgaJsgRY758NwWRnlVNsZCMlA4si25qX
 zvMAdoCU6c832e56N1czngBTStiyV9I9AywqapJI6Sw46MR4tKsuCGvFzvTQK+Mpdddp
 Mqgbgox1wJj4qNrmasMquMOe3kU7HxKXeAGOhACib1/TlHnd7wP3wYWaNIQuesMbdekU
 fOT+F4/EUWQMfEhxvg5GyYfS+kHr04H68GMBo0E3AoBPX4vwO8coXxnZ8eRIwT4hqWDD 2A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hen90sn0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 20:10:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id E96BDD2CF;
        Wed, 20 Jul 2022 20:10:47 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 82B5780906E;
        Wed, 20 Jul 2022 20:10:46 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v1 0/5] Add SPI Driver to HPE GXP Architecture
Date:   Wed, 20 Jul 2022 15:11:53 -0500
Message-Id: <20220720201158.78068-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: ofamtHPacx6DKFeTSXTLVx9qnGQtnxcE
X-Proofpoint-ORIG-GUID: ofamtHPacx6DKFeTSXTLVx9qnGQtnxcE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 mlxlogscore=688 clxscore=1011 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200081
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

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
 arch/arm/boot/dts/hpe-bmc-dl360gen10.dts      |  58 +++
 arch/arm/boot/dts/hpe-gxp.dtsi                |  21 +-
 arch/arm/configs/multi_v7_defconfig           |   1 +
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-gxp.c                         | 355 ++++++++++++++++++
 8 files changed, 500 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 create mode 100644 drivers/spi/spi-gxp.c

-- 
2.17.1

