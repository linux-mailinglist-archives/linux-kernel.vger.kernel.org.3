Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990E522D99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243118AbiEKHrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiEKHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:47:22 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F046D942;
        Wed, 11 May 2022 00:47:19 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24B3Mrxw017146;
        Wed, 11 May 2022 09:47:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=fshfuSYi2zqO1if2fSxELmD7JNptjzEqSmmJbf+TXfQ=;
 b=qTxraEJQAv+YyToErt2WC6vyh1cWdZY+UfgyUduuh6xb/nm/rvwQtvaRFxzNXPCq1kY5
 2tVU/ErNubXQt/Fc0V3P4ZZaY8L/PA7xwbFjl9obhZyzc3Pz93l0HGxdSx8xpiaYClYg
 KeiaaViv3WFgcPNnqqSBmi02NrJE1Jh1F46D55ML1wMjdDZhBCJBu0+NyIObdhlwZfEF
 oo9hsqhmrAkoWMMIhR2evRpL48z/Rito09vTpzrcqljqUcQ02BAzuKFz0egGwlG7ykx7
 Tx430ljdIj0m3121X8fMInItlPNy831lCtfdw2ndMCyPuqRAo3dD5qim89uHpF38Wvtl SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwdw98kqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 09:47:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1897310002A;
        Wed, 11 May 2022 09:47:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E60C2128DB;
        Wed, 11 May 2022 09:47:02 +0200 (CEST)
Received: from localhost (10.75.127.46) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 11 May
 2022 09:47:01 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] spi: stm32-qspi: flags management fixes
Date:   Wed, 11 May 2022 09:46:41 +0200
Message-ID: <20220511074644.558874-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_02,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series update flags management in the following cases:
  - In APM mode, don't take care of TCF and TEF flags
  - Always check TCF flag in stm32_qspi_wait_cmd()
  - Don't check BUSY flag when sending new command

Patrice Chotard (3):
  spi: stm32-qspi: Fix wait_cmd timeout in APM mode
  spi: stm32-qspi: Always check SR_TCF flags in stm32_qspi_wait_cmd()
  spi: stm32-qspi: Remove SR_BUSY bit check before sending command

 drivers/spi/spi-stm32-qspi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

-- 
2.25.1

