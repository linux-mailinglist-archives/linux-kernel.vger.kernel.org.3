Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38534A3FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345234AbiAaKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:01:31 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36502 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358115AbiAaJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:59:54 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V8xZdc020730;
        Mon, 31 Jan 2022 10:59:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=wzdINB6TXcHoYv1nIdbxUF4R5rhgqfyM3nZV0FfhVpc=;
 b=yaKIGIEbUArqGdA+jcBGWKMgdw8Ar3FvHDd/SX8B0ePI0rmwEL+nMDxqbi2V0vVO82Mm
 JefRg2YOvt3B1d7Kkv7QAoauQMSAyUD609OKxPjO0Tpf+5za2cMkGT8ilHaeg8zZH+mg
 SHU7yjetZVFFaD8nd1q6+BkwEJVqtKH7LaSx4Brs1OTRkzvAu4qYZMJstgXnzSl04pK9
 zCKwEh1npVx66Tbk6yqPHzQpzioeLms96qvBan3c4uvQJuUsxfyJ0bw3EvJwhm0R5qsL
 1RS4Rpm0QFu/8Q+jtUpl5uy/e4PrEJSMdtNQdjkOrFmNeTDrlsdXMo+5RPWIE/jOTUIX 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dx0pya91v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 10:59:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4852C10002A;
        Mon, 31 Jan 2022 10:59:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 319A021230E;
        Mon, 31 Jan 2022 10:59:14 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 31 Jan 2022 10:59:13
 +0100
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH v2 0/4] mtd: rawnand: stm32_fmc2: Add NAND Write Protect support
Date:   Mon, 31 Jan 2022 10:57:51 +0100
Message-ID: <20220131095755.8981-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_02,2022-01-28_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the management of the WP# signal in FMC2 driver.
WP will be disabled in probe/resume callbacks and will be enabled
in remove/suspend callbacks.

This patchset also fixes a conflict on wp-gpios property between
MTD and NVMEN.

Changes in v2:
 - add Rob Acked-by for the bindings part.
 - rework the proposal done to fix a conflict between MTD and NVMEM on
   wp-gpios property.

Christophe Kerello (4):
  dt-binding: mtd: nand: Document the wp-gpios property
  mtd: rawnand: stm32_fmc2: Add NAND Write Protect support
  nvmem: core: Fix a conflict between MTD and NVMEM on wp-gpios property
  mtd: core: Fix a conflict between MTD and NVMEM on wp-gpios property

 .../bindings/mtd/nand-controller.yaml         |  7 ++++
 drivers/mtd/mtdcore.c                         |  2 +
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        | 40 ++++++++++++++++++-
 drivers/nvmem/core.c                          |  2 +-
 include/linux/nvmem-provider.h                |  4 +-
 5 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.25.1

