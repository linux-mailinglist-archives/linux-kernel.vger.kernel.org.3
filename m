Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA844DC4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiCQLVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiCQLVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:21:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA481E31AD;
        Thu, 17 Mar 2022 04:20:01 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22H8N5g4001889;
        Thu, 17 Mar 2022 12:19:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=8BsR+v0AbEC0TwAw4dn0LePtwjxQWbrnUyIKeBq/B8g=;
 b=b+Vhuf+CIguDYlpbzIvSQ1h4/T1VWrwTDSt8/TraPpLcbbMI5ZgEgMvgewR8Cd1+Mu03
 bXdAHza+3Iky0ajocwRuYIJAFDrIZQVMPE7TLb/gsemEuaSxVSQlo1E5Wfx2+hsEOk8G
 oTgw8/4hZ578r/g671pOq9/nicWrawnLr16+N89rvht6+vfToxTNXaV/cWF6t75t389Z
 Zi1aQagscLBdJePTedREgC7un67mlK3oQfuuSW1ZT+DGKWF9pohq9JsB2FcNsGt8I80i
 8GIf6cx1qrrjtr0koN8hHja2rlCRiN4K+vIZ41RW0c5OK6lpjRlVLPOd4zqoUQR73xD8 dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ethxu9cfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Mar 2022 12:19:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4EE310002A;
        Thu, 17 Mar 2022 12:19:50 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D0B2217B69;
        Thu, 17 Mar 2022 12:19:50 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 17 Mar 2022 12:19:50
 +0100
From:   Yann Gautier <yann.gautier@foss.st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Yann Gautier <yann.gautier@foss.st.com>
Subject: [PATCH 0/2] mmc: mmci: stm32: manage unaligned DMA req for SDIO
Date:   Thu, 17 Mar 2022 12:19:42 +0100
Message-ID: <20220317111944.116148-1-yann.gautier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-17_04,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch corrects an issue when parsing the sg list to check DMA
constraints.
The second patch manages those DMA alignment by copying from or to a
bounce buffer, the way it is done in meson-gx-mmc.

Yann Gautier (2):
  mmc: mmci: stm32: correctly check all elements of sg list
  mmc: mmci: stm32: use a buffer for unaligned DMA requests

 drivers/mmc/host/mmci_stm32_sdmmc.c | 86 ++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 20 deletions(-)

-- 
2.25.1

