Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70B04853F3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiAEN6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:58:50 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240470AbiAEN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:58:49 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 205DZ65G029790;
        Wed, 5 Jan 2022 14:58:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Pi8i2Rh/8xlQj2KiipQSZiBQ+/fK2HKLJA5JcF9t370=;
 b=HGxl099ZZK8Nvm8wXjAhIB70Kt4C5J73BV31mgvx0uhVl9FL2rFpj1ZyKazN0vklfsqe
 ytTyVmc5Ebr5zJo+3s5ptI7d4DQOFasYNI/U015L5VEoF5YfTlVdpdBIOqZmP4J3rckq
 bzqAmJwOomKncapthITx3YH3Dp46YKB0gQzIOUPuinZ09qCzr6hi6SDGLAGQg0SCTq0H
 7EudboXy14wBT8eMchU/tUDp1niMFo/xUOKpWdNdzqc8/+IhCiq5GFv4GLDz3NWlW7KM
 R+zV43xn6lytN2Kae7CWnwm0GXMFO1KwiloSmKgt5FsCDkvVHJZfa0fK9oce+l3MhInk SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dd7k91may-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 14:58:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4436810002A;
        Wed,  5 Jan 2022 14:58:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25BED24D5F0;
        Wed,  5 Jan 2022 14:58:09 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 5 Jan 2022 14:58:08
 +0100
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 0/3] mtd: rawnand: stm32_fmc2: Add NAND Write Protect support
Date:   Wed, 5 Jan 2022 14:57:31 +0100
Message-ID: <20220105135734.271313-1-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_03,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the management of the WP# signal in FMC2 driver.
WP will be disabled in probe/resume callbacks and will be enabled
in remove/suspend callbacks.

This patchset also fixes a conflict on wp-gpios property between
MTD and NVMEN.

Christophe Kerello (3):
  dt-binding: mtd: nand: Document the wp-gpios property
  mtd: rawnand: stm32_fmc2: Add NAND Write Protect support
  nvmem: core: Fix a conflict between MTD and NVMEM on wp-gpios property

 .../bindings/mtd/nand-controller.yaml         |  7 ++++
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        | 40 ++++++++++++++++++-
 drivers/nvmem/core.c                          |  2 +-
 3 files changed, 47 insertions(+), 2 deletions(-)

-- 
2.25.1

