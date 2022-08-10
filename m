Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793E758E9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiHJJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 05:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiHJJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:32:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2C16DF89;
        Wed, 10 Aug 2022 02:32:44 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A68jdC004798;
        Wed, 10 Aug 2022 11:32:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=JGY5zWrfCCK8U/3zgAroqF0FgJuxZGbZAnLQqoBRrso=;
 b=0j8S3SNqXOkek34mkUPW7uFbheMJ/q/UayZS01EQTvKX2ZCKctNple+tOvUt6NQ3XLgy
 iflhYECKtF1WaeZkpZa7A2PzvLnKvBSfKcYcnyoPUHeMxaIH0o2ttriPdHBOZojroaeW
 +R930MK1dlNNsgsbpbrJDhrc1c9ERT7wW1bTVTYSFBvAErdiYoWKTFnv13DItzFUo7ht
 VOczuZv9+G37EtoMeFnkwukUOC1VQnpWfnrjx2iCkeFgDx/9gbflsMtE/l0ko4Q/eTN2
 Uids09E37dl1rnUjsntBDXd0iw5cv5S/k0aSaZ9l+vVfDaUgshaxn/rocxeYTc9OPDud AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3huwpmbmm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 11:32:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E49A110002A;
        Wed, 10 Aug 2022 11:32:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CF39421B52F;
        Wed, 10 Aug 2022 11:32:20 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 10 Aug
 2022 11:32:20 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] spi: stm32_qspi: use QSPI bus as 8 lines communication channel
Date:   Wed, 10 Aug 2022 11:32:13 +0200
Message-ID: <20220810093215.794977-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
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
Usage of DT parallel-memories property is needed to enable dual flash mode.

The addition of the legacy transfer_one_message() spi callback is also needed
as currently the stm32-qspi driver only supports spi_controller_mem_ops API.


 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |  50 +++++++----
 arch/arm/boot/dts/stm32mp157c-ev1.dts    |  12 ++-
 drivers/spi/spi-stm32-qspi.c             | 103 +++++++++++++++++++++--
 3 files changed, 139 insertions(+), 26 deletions(-)

-- 
2.25.1

