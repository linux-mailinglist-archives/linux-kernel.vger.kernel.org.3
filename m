Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC34582FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiG0R3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiG0R1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 13:27:37 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C37F514;
        Wed, 27 Jul 2022 09:47:17 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26RF92ga010128;
        Wed, 27 Jul 2022 16:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=u6ThZNWif3ROUC2POvusj2QQB7jFaQFFapQejsDNY1s=;
 b=dZSO7xuPAQfH/kS55lTkfXmr9NxQklyu0KYM7Yh2j9L+iHoju6Lr5KHi76wTU0RkxcRr
 YOwlC5uyzOE3c7Z2XgL/FGahoOK+aSb4SeA9sPcN8f4n6zh04FMf1XU5Bf96wtNDflp9
 1CsoYYP1nnDsZ5VQ0Y5NmdIkY+kZYLm2mP2R5llNznMvs+1s8znKPJb37mU0VqZ1saxN
 WGa+ZW+f+2efe2unmo3vlMq8y5TqPDmHmQGJNOsATSfauAjXRlA7YMWYMItBJ2Jyjeoc
 oRJdrNwuzAqpquBzxLuCBARuAqwXfrH6t//YrPHCxUH3IFoWsWimsm9dtECZZgunMFjr Pg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hk60psry5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jul 2022 16:46:36 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id F1CB3D2D9;
        Wed, 27 Jul 2022 16:46:35 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 821768052CB;
        Wed, 27 Jul 2022 16:46:31 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v5 0/5] Add SPI Driver to HPE GXP Architecture
Date:   Wed, 27 Jul 2022 11:47:31 -0500
Message-Id: <20220727164736.48619-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: PjWRUazOZ606azE2H-N3DO9o2k7a8ky-
X-Proofpoint-GUID: PjWRUazOZ606azE2H-N3DO9o2k7a8ky-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-27_06,2022-07-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=432 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2207270070
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Changes since v5:
 *Fixed indentation in Kconfig file

Changes since v4:
 *Removed unnecessary quotes in hpe,gxp-spifi.yaml

Changes since v3:
 *Fixed indentations in hpe,gxp-spifi.yaml

Changes since v2:
 *Changed the CONFIG_SPI_GXP from y to m in defconfig
 *Removed extra space around < > for reg in hpe,gxp-spifi.yaml
 *Changed interrupt-parrent to interrupt-parent in hpe,gxp-spifi.yaml
 *Removed repeated include file in spi-gxp.c
 *Removed unnecessary initialization of ret variable in spi-gxp.c
 *Removed conditional variable checks where failure is not possible in
  spi-gxp.c
 *Removed unnecessary variable cs in spi-gxp.c
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

