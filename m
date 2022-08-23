Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444BD59D2F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbiHWH7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbiHWH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:59:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95042AD1;
        Tue, 23 Aug 2022 00:59:23 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27N71aRl017490;
        Tue, 23 Aug 2022 09:58:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=aTuz4LoVP2rqxcOgWSRXXWx7NUQjy/a02YEBQAhT/hQ=;
 b=I6cWmZaaP33IJk0/I/B82Z072Exs3FvS/D+UD8bMkqCiruRFLpdEOb2ZT+SHdCLXI316
 YkXLA4cBUnt4Vfi4y/ds4BBsy5uCWvYPgP45QqVG2U/Wm7Ewx358cv992mICLWgZZ+Y2
 RP2qGbcv35A/UM/ub756A+TUtjC62LGzO2OSLb6bBlItfPbp3iT6FO4RT+Aj7r5TIHcm
 8ybpiqveG80OvO1XSJxXFF8y4WLwle2WGptWWvJLU/iq6j+/9qUm2Uup7CZR5tptYyWt
 lN7B+0QUi2+J2YHuiwcpuzv7qGkVb6/q+GwTB+3vJ5Xp8RmKV+LR8THH+yRkcFFcN3Ph vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3j2w2pvp6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:58:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C51110002A;
        Tue, 23 Aug 2022 09:58:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4F836216EE8;
        Tue, 23 Aug 2022 09:58:55 +0200 (CEST)
Received: from localhost (10.75.127.118) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 23 Aug
 2022 09:58:55 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH v4 0/2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Date:   Tue, 23 Aug 2022 09:58:48 +0200
Message-ID: <20220823075850.575043-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

The goal of this series is to allow to use QSPI bus as a 8 lines communication 
channel for specific purpose.

The QSPI block offers the possibility to communicate with 2 flashes in 
parrallel using the dual flash mode, 8 data lines are then used.
Usage of cs-gpios populated and spi-tx-bus-width / spi-rx-bus-width both set to 8,
is needed to enable dual flash mode.

The addition of the legacy transfer_one_message() spi callback is also needed
as currently the stm32-qspi driver only supports spi_controller_mem_ops API.


Patrice Chotard (2):
  ARM: dts: stm32: Create separate pinmux for qspi cs pin in
    stm32mp15-pinctrl.dtsi
  spi: stm32_qspi: Add transfer_one_message() spi callback

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |  50 ++++++----
 arch/arm/boot/dts/stm32mp157c-ev1.dts    |  12 ++-
 drivers/spi/spi-stm32-qspi.c             | 118 +++++++++++++++++++++--
 3 files changed, 152 insertions(+), 28 deletions(-)

-- 
2.25.1

