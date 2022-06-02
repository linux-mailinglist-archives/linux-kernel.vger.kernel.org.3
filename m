Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1C53B600
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiFBJ0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiFBJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:26:06 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5549929FE62;
        Thu,  2 Jun 2022 02:26:05 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2528k96S032463;
        Thu, 2 Jun 2022 11:25:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=zVNq45GLp6mScw2QvUD+lacjuXqSDpWYId6ZoABsrf0=;
 b=dWy14ZBSMPjEBt+PiCf/Re1t9RKiZ2Gkv82w1LkcMiO5sLPLqGfFC9Mu4eqqCpmFgHgf
 XDB62uUEfFORvDUekLan17+PoOqoy/qYkApo+0ZlKcqOyrrLAa4T5VGhUVphne882ad8
 yahfK+jSwORFwswSKPB7jNuT6OHXgwDLSh9jizbMz3LWbFHoAdO9F1eWMKwPZlHxz/QH
 +Prj0MkDWAG3o+gdSdFjTyNQdHE+Is3GLrQWt3yYdNB3f/z/YEnj9qMC/CeHRJIqsQy9
 fe0tzZ/MVFAnAQHH1xdvAfGbGiHl9NmTWOoh6c9ZDuPMdlcprA/yNx8yODoW+ieWQE8o AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3get03g97x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 11:25:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB5F8100034;
        Thu,  2 Jun 2022 11:25:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D54A9217B6C;
        Thu,  2 Jun 2022 11:25:55 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 2 Jun
 2022 11:25:55 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH v2 1/3] spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
Date:   Thu, 2 Jun 2022 11:25:38 +0200
Message-ID: <20220602092540.369604-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602092540.369604-1-patrice.chotard@foss.st.com>
References: <20220602092540.369604-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

struct stm32_qspi *qsp is no more used remove it.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index c0239e405c39..2ad43c2f0526 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -349,7 +349,7 @@ static int stm32_qspi_wait_poll_status(struct stm32_qspi *qspi,
 	return 0;
 }
 
-static int stm32_qspi_get_mode(struct stm32_qspi *qspi, u8 buswidth)
+static int stm32_qspi_get_mode(u8 buswidth)
 {
 	if (buswidth == 4)
 		return CCR_BUSWIDTH_4;
@@ -382,11 +382,11 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 	ccr = qspi->fmode;
 	ccr |= FIELD_PREP(CCR_INST_MASK, op->cmd.opcode);
 	ccr |= FIELD_PREP(CCR_IMODE_MASK,
-			  stm32_qspi_get_mode(qspi, op->cmd.buswidth));
+			  stm32_qspi_get_mode(op->cmd.buswidth));
 
 	if (op->addr.nbytes) {
 		ccr |= FIELD_PREP(CCR_ADMODE_MASK,
-				  stm32_qspi_get_mode(qspi, op->addr.buswidth));
+				  stm32_qspi_get_mode(op->addr.buswidth));
 		ccr |= FIELD_PREP(CCR_ADSIZE_MASK, op->addr.nbytes - 1);
 	}
 
@@ -396,7 +396,7 @@ static int stm32_qspi_send(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	if (op->data.nbytes) {
 		ccr |= FIELD_PREP(CCR_DMODE_MASK,
-				  stm32_qspi_get_mode(qspi, op->data.buswidth));
+				  stm32_qspi_get_mode(op->data.buswidth));
 	}
 
 	writel_relaxed(ccr, qspi->io_base + QSPI_CCR);
-- 
2.25.1

