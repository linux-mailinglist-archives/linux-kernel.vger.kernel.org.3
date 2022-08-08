Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6080A58C44D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 09:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiHHHlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241909AbiHHHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 03:41:27 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D412D1C;
        Mon,  8 Aug 2022 00:41:23 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2787Iv8L007741;
        Mon, 8 Aug 2022 09:41:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=AP3c4vCG+hy28xwUF/P0YX2tPnnN/Gf/cJsN6OS+P7k=;
 b=vX3ebXFWNTAarsJUuG2imn4UrPchQug4OCcvkB8UFjkZUbDc6RTv/2O9UkvKbduKT6uJ
 +waxhpaRSwohiDrD0j34h9HRsi4zoyE2bfgHFXrfeK1OaunfL6XpbzGSMkyg8lGHom+8
 EW0Zr47aPKZuIZoT1NlNuVktU/fbk/ztSybmm9NCj5rzGgQQYasiDCVBUrVBaaamV0Xs
 NE6fvMLprFsa/hNEcti4m7RBfzHCE1r8YRncn5ZoOuOSvU7y5TP068BbdguGFXPTBwYD
 eEkSbN8Cz5i9JB80bDjP6SS1j5s5mfxlLybdFlTWYioMD5BbzAe3FqchhiUEDJPvlsZ+ yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hsdqkg8ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:41:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1070C100038;
        Mon,  8 Aug 2022 09:41:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7AA672171DD;
        Mon,  8 Aug 2022 09:41:00 +0200 (CEST)
Received: from localhost (10.75.127.117) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 8 Aug
 2022 09:40:58 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Date:   Mon, 8 Aug 2022 09:40:48 +0200
Message-ID: <20220808074051.44736-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE5.st.com (10.75.127.69) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
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
A new ST specific property need to be created to enable this dual flash mode.

The addition of the legacy transfer_one_message() spi callback is also needed
as currently the stm32-qspi driver only supports spi_controller_mem_ops API.


Patrice Chotard (3):
  dt-bindings: spi: stm32: Add st,dual-flash property in
    st,stm32-qspi.yaml
  spi: stm32_qspi: Add transfer_one_message() spi callback
  ARM: dts: stm32: Create separate pinmux for qspi cs pin in
    stm32mp15-pinctrl.dtsi

 .../bindings/spi/st,stm32-qspi.yaml           |   8 ++
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  50 +++++---
 arch/arm/boot/dts/stm32mp157c-ev1.dts         |  12 +-
 drivers/spi/spi-stm32-qspi.c                  | 111 ++++++++++++++++--
 4 files changed, 155 insertions(+), 26 deletions(-)

-- 
2.25.1

