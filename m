Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4E53B5C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiFBJKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiFBJKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:10:41 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E82AA007;
        Thu,  2 Jun 2022 02:10:36 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2527sS2D005071;
        Thu, 2 Jun 2022 11:10:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=VWQ7tzWGog3nAEbIjFtGWXl2yPJ82VtZopPyXWeTyP0=;
 b=3/wjKDMJo8/cKibkYsADL2XjFchNSGQabCLOzCCKoPEa3oqxgRXI19Xzs8tyNC8s7YbB
 wyWKAaEoxFsVu2u6/pBTgnSsMynHMFfTxEgsHuiZf3qROUh/IVyiAHZns9AoN+jqJGSV
 GdoTDCVWBDGVou3NfmdkOpg4/SAEm9FnCPhsXe04kp6RUzIPJJJoKO81sBFgFB2JCWwQ
 TK1jJyVEWIYu91PyInAQ1d+fSFx8zytPPqQfJBae3v/wl6XT0n/QASdtX7Gn7RX3cZik
 XMmlTr0THvhMgVo2fqgbrypWYyCjzzQYX+9u31yZxv4uJAwizdhZgWYqbhPBN7TQVzud 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gbc50xgqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 11:10:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C9B8510002A;
        Thu,  2 Jun 2022 11:10:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BF8A02171D3;
        Thu,  2 Jun 2022 11:10:27 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 2 Jun
 2022 11:10:27 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 1/1] spi: spi-mem: Fix spi_mem_poll_status()
Date:   Thu, 2 Jun 2022 11:10:22 +0200
Message-ID: <20220602091022.358127-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
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

In spi_mem_exec_op(), in case cs_gpiod descriptor is set, exec_op()
callback can't be used.
The same must be applied in spi_mem_poll_status(), poll_status()
callback can't be used, we must use the legacy path using
read_poll_timeout().

Tested on STM32mp257c-ev1 specific evaluation board on which a
spi-nand was mounted instead of a spi-nor.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e8de4f5017cd..0c79193d9697 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -808,7 +808,7 @@ int spi_mem_poll_status(struct spi_mem *mem,
 	    op->data.dir != SPI_MEM_DATA_IN)
 		return -EINVAL;
 
-	if (ctlr->mem_ops && ctlr->mem_ops->poll_status) {
+	if (ctlr->mem_ops && ctlr->mem_ops->poll_status && !mem->spi->cs_gpiod) {
 		ret = spi_mem_access_start(mem);
 		if (ret)
 			return ret;
-- 
2.25.1

