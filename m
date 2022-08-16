Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9650F595FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiHPQOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiHPQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:14:27 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4EC474CD;
        Tue, 16 Aug 2022 09:14:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GBKpBO005831;
        Tue, 16 Aug 2022 18:14:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=qP/LM/Dp36sWiV7fPSfYlt7cCniRU3gHuTlVC1r1NOE=;
 b=RTegEcAAzmmoY9zSO5EATPkVE04GpF/UCgUAGO3N750Ac1wp5WRH7tKo6oqGiM7wn+NE
 05e95KYE0f1I0U3mhqvsJMW49nWsh7Nc3if6bCuqYBughVAFwpTYVU29SY9OCCGo5aqQ
 IE4Z3ye61g/uwbjbSgq/He0NkVH1qxDmqBX5ef+tV+pBzXkR3OZ8qpdqzOKGF7/3aS9Z
 VrVgoz2gzNOJzutVzG/ZPc7kUvj7vq/hQGrjG44pEpC4LGQADM/hHJM4T1hfSayh8CFE
 ryNofU47rZLL3QjUZ/BRrqf1yNhzgSalsgqS2u0ZHvRY44bq9ftbinFgqwFhvJ7iqQV5 ng== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hx2uhfpq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 18:14:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F220410002A;
        Tue, 16 Aug 2022 18:14:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 68C1123BE1A;
        Tue, 16 Aug 2022 18:14:02 +0200 (CEST)
Received: from localhost (10.75.127.116) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 16 Aug
 2022 18:14:02 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH v3 0/2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Date:   Tue, 16 Aug 2022 18:13:42 +0200
Message-ID: <20220816161344.2599908-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
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

 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |  50 ++++++---
 arch/arm/boot/dts/stm32mp157c-ev1.dts    |  12 ++-
 drivers/spi/spi-stm32-qspi.c             | 125 +++++++++++++++++++++--
 3 files changed, 159 insertions(+), 28 deletions(-)

-- 
2.25.1

