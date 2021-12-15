Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3747596E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhLONKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:10:46 -0500
Received: from mail-sh0chn02lp2020.outbound.protection.partner.outlook.cn ([139.219.146.20]:38502
        "EHLO CHN02-SH0-obe.outbound.protection.partner.outlook.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231842AbhLONKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:10:45 -0500
X-Greylist: delayed 3645 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Dec 2021 08:10:43 EST
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeKrvkkn0cpd7RJuZDBWxcZwD/UmeC2QHfHwo/CHWUYf+zaZqlPs1FwMBZAxkvbGZa50g0c4NWSzaZql1YxiymCfWWzCKNeyXvgC1iN0At5hZhZmzfw8dolSMozuFwB19XEAb1OYaGBhoj4qrXBRwy/Bv3ww6O+cQkUBEzZmLm8HaBzXUOIJ/DnwfiMWduBLCBqeTj0aZFjvNBQKhuAlbxhTnRm3xyO2fsyEoQyNU+vEj0H1NZ6QzM0rhTr4YZ6kv5FsCEZz50ajj56PlXyZjp+lG4tuxY6xQgaG18Mq38xlSbF/XMMEXP6IcdT3UAEZ2pkluVPhTttvDA30OAKKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK0+C3AkFt+eB84wTFfjDHoDf/zWZWQSDivvA6Uahy0=;
 b=l3blMV3wzIVSd0cP4wj8eu7HsE9EjZWs9vaF3OjU9QpiNsk2ubfoceNE5l4EjeCYMz1ot5wLbbvaf2cCZJQ4lOtyDNnOD3kJCFYEorZ3SpbWtmlqgCLVKob1jwTu38oMin3yNyGUgVh0WnbgIjG1qqLBeuRXIWwEZNLHgsNux4lploEPhH0DwMuSbIOfF7FEUni6A/+qzt947jhg7pGYVP4Z/IAUXr5jvTVNXoxfA+/A/UgnmSSwD8LecUWRhm9WfTS+Nv9qi/S7gtKXYeIM3IwJc8a5l5xsdFqk7FME84PHTOvbT35DVrUh5tE3Anh+1/vX/uubzse7zXZO/4Xr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=armchina.com; dmarc=pass action=none header.from=armchina.com;
 dkim=pass header.d=armchina.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=armchina.partner.onmschina.cn; s=selector1-armchina-partner-onmschina-cn;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK0+C3AkFt+eB84wTFfjDHoDf/zWZWQSDivvA6Uahy0=;
 b=zmkQWXYsieKNfBxJI1+cifWuzGet2cqypeVdyjiV4d6TTdqht2RGl72oJIgiCLwWugBAEWHH+blhOwgqCdAr+4CgN5yUswUmkVJEkZCcpDTwWYclytXNMHMEzMmj8pUc6vKHfvFK1+WotwMij4YbP/WQxZLjaBG0gCP9mTslUS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=armchina.com;
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn (10.43.108.74) by
 SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn (10.43.106.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.13; Wed, 15 Dec 2021 10:36:21 +0000
Received: from SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74])
 by SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn ([10.43.108.74]) with mapi
 id 15.20.4778.018; Wed, 15 Dec 2021 10:36:20 +0000
From:   Dejia Shang <dejia.shang@armchina.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     dejia.shang@armchina.com, toby.shang@armchina.com
Subject: [PATCH 1/4] misc: add ArmChina Zhouyi NPU driver
Date:   Wed, 15 Dec 2021 18:36:06 +0800
Message-Id: <20211215103609.9268-2-dejia.shang@armchina.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215103609.9268-1-dejia.shang@armchina.com>
References: <20211215103609.9268-1-dejia.shang@armchina.com>
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (10.43.110.222) To SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
 (10.43.108.74)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce822d9-9b9e-40e2-c3d2-08d9bfb6bb6e
X-MS-TrafficTypeDiagnostic: SH0PR01MB0827:
X-Microsoft-Antispam-PRVS: <SH0PR01MB08276557DD2C6EE8BEFD310598769@SH0PR01MB0827.CHNPR01.prod.partner.outlook.cn>
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaTlccOOY9vilWqgNrqnOcZQZYE+4pvAaRYQzWw68el2qCbwCfdqB54ggPweYypnznFsGAyUYgKNC4o4JS+fivVt7O/z/9EdoYDVtJ2vFmd9RAENKMUNCsO0AUlQqvr1tY5SRxEjPAgQBVhMKv8BX9pXQAuRgCMakt1RcvyBK8dKj2eBnw7K/xYwwAKwoVz+ioCsE9zjm8cGSrNRRnAW4GSW28OYf9N8BpPgBsjrs7lTHmPyXep2PWHgzZ5KE5hUHSe2JBte+gF+7uclDAYryq6AGoRm+fBklpsMSsyeEjgipsuasEpGuR11BjmLeUV5gmRpE9ZZGH8ENR6cjGU04XoDs5Vf7YI5Fwpk1xgmeigBdyqc0sWgmt+Uko+hDckyQdM7svG4RTTlMGaYhoB5F8grkDEx8EIByL0pDnzZRXYpt3bIh6yuGdBtW+xYvGwK9T/gxbtc075wR2Mm1SjCQqvd+yNMoQk7wKkzTPVs6jhiXFw9ZuakVKVXttZllL08i9QcYyrqzIC9VQzWYGmK1JWfIPPuDU1obU1iTbIuBfFDNt2hQ+0O8diRA7ngej0xIirb5DJiNQ9DYoKbye/HjaAKptgr51GSaEyIjCHQw8z1kJ7Z4j0BtRi5TFNF1HJIj1AMB8dqlSIisWcQXW/ePrOeAQxVHmWoLmX13e0w+5lBBOUIoJQ3WkemP0karjfT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(6666004)(508600001)(66476007)(186003)(86362001)(52116002)(2616005)(26005)(8676002)(40180700001)(107886003)(4326008)(38350700002)(38100700002)(8936002)(44832011)(40160700002)(36756003)(30864003)(66556008)(5660300002)(2906002)(66946007)(83380400001)(559001)(579004)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aXmdUoXs1WzNfkoEr44uLh9TC0iwLTQDDguD3thINVt5AHqokv3cIrT9X5YN?=
 =?us-ascii?Q?Qx9EFiAuUclCSxn89gi7INRLN4ZYXnPWGDM3GSYE75cgMx7+Q4Bk2k/nJ2BP?=
 =?us-ascii?Q?Ye/okPPn/m9fztSHUaSl6wDEaFCEAXW84ThEQj5P7/CShTNF8TGGUNa+XUZf?=
 =?us-ascii?Q?071jI5lRdSzjXMbXBM5G4o1GZfO0frcCMDpHH51vA4G5SCr0YVN+EqYYjwAj?=
 =?us-ascii?Q?OFOjUllHH4AzFkp/HUeJMX4LRvxVMm+HHXf/AK3WC5Ri9UthRUmsxUwx3FZ7?=
 =?us-ascii?Q?QDRyMH/gfkRxTmme75MTPZIH51/NAqjeXpWYaSG8ClwKVU6XFgjGNQ139F+a?=
 =?us-ascii?Q?+MY66jH6cgEcoKhVoq886K51NbjU9H2JSAgthcUO74HdI11e5af7ot3VPV4g?=
 =?us-ascii?Q?TsmqFfXmesVaa7yIeUwrkOV6sQQMdM0uVO3/XsR/n1eMVfAmtoMzeINcr9be?=
 =?us-ascii?Q?FYureZpqYBfgM+1s/WIJ53FP/Jt/OkHB+Y6/oVuzUgePeLy8I5XkJw/5HMRN?=
 =?us-ascii?Q?IqSbaVIBjv0Ie8799Sth8VQKP4+hly0IQfB82Xl0enQUTV5OZW1uf4kgowQf?=
 =?us-ascii?Q?wFRKaoDK+8ALUBSfRaJg98jtygzd6bl8KPEP8zcfShvleex/rRNxSohP35JJ?=
 =?us-ascii?Q?O5WTFJ+ccT8BFO6h+lXFP2ULVy71s8rlvTdbyIIOUZhN5Q/LJv5TB2olMvGH?=
 =?us-ascii?Q?Zs2+CP6PvRxAFo62E81jWvPrnefKjdCaHzmNmnpFSXY/yYU5ym+gOLdgkNbP?=
 =?us-ascii?Q?YCrnHsNl6kLzoB8GwSKN6lXP1TLIG+kqJKW5/m2ETn/MgzMaBLtlyRDBqZ9X?=
 =?us-ascii?Q?BV/qB/jGGkEwu4PAl0yTI8HAlJWLV5kB7f9fYaQqmoYQlWscpjdYPrn7USz7?=
 =?us-ascii?Q?yiz7Om2WMYLc436air3Z/iNw+znhIEdDyQ9gaj/XLnTLhx2dAabtJCCLJOqA?=
 =?us-ascii?Q?tqm28b+F1duqvN4JePGz0skABcD1m0Ek5O3uG5aunpLBDQglBF1JAYgAGR/0?=
 =?us-ascii?Q?5sJwkH9koNUh0+riAiTshmk3Ppsdv7cQjM635THyqe4lDOMJ3s6v1ilJ756V?=
 =?us-ascii?Q?Gqpa9XtuSdEUDJDAx+EyJBK1WQkVUgrq9ZxCwETxPrUCsHvZdzq0ijNfvEXv?=
 =?us-ascii?Q?GunIO77J4KKMGpeuF+wYfiAJXiS0Yy/PnIPViVpRqZ7p6eHoUlBON8NQqwQU?=
 =?us-ascii?Q?/e8AmqkS4qPYZYzD8fDIN4375iIlFJlGzDs5XOLyZlyPBFYfALGjS1aN1m9r?=
 =?us-ascii?Q?W5jJcaQw0sKXGfD6sRRqszqu5GCcXw/LQaO/tSUjom7pHrcWGHtL1KwkRsoV?=
 =?us-ascii?Q?DEaLCyeCNeUlx9da4ys2Tr8Gn2z/ylJ07gsn02jRdS7OQhTQVRaypJcwnsg6?=
 =?us-ascii?Q?RHT3dy/0bAXrQ1sLz6oGJ/zXko3mDGL6wUgpQrap649q99WP05zaxejTU+fZ?=
 =?us-ascii?Q?2VtdG/ygz00Hrs7Gxd55kWe/nkk5l1wfkl65VqDV0uiFfIODW10qjR/LIEF7?=
 =?us-ascii?Q?eI0VtnWMxZL/mhh7aGJkgCC5dayedD5NBowBPbp/XLGkhvt2te77H7om1YnC?=
 =?us-ascii?Q?Y1YCw81BFBwPXmCLdSQUc/rDYNrhly7TdcCLEKaILJjbIfAwiGDkubGcPCsY?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: armchina.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce822d9-9b9e-40e2-c3d2-08d9bfb6bb6e
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0634.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 10:36:20.3406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 58b271af-432f-4dad-9dee-571f404bc6a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTDsEsWjGI0bGkK9xHIaysuOZIXbfcbLYMHDHZ04aGihSxDEdetf6fpy5ft26cZnY9Nuhg9T2p6FsFXc/IA8n4wyEiJbueZWi51q5hrx9DE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0827
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This kernel driver provides basic supports to Zhouyi Z1 and Z2 NPU IP.
It works with the Zhouyi user mode driver together to schedule AI inference
tasks on Zhouyi NPUs.

Vendors of the SoC chips with Zhouyi NPU inside should implement
their SoC level operations and replace the aipu_soc_default.c,
if their chips have specific clock or other settings.

Signed-off-by: Dejia Shang <dejia.shang@armchina.com>
---
 drivers/misc/Kconfig                          |   1 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/armchina-npu/Kconfig             |  15 +
 drivers/misc/armchina-npu/Makefile            |  11 +
 drivers/misc/armchina-npu/aipu.c              | 312 ++++++++
 drivers/misc/armchina-npu/aipu_core.c         | 418 ++++++++++
 drivers/misc/armchina-npu/aipu_core.h         | 100 +++
 drivers/misc/armchina-npu/aipu_io.c           |  74 ++
 drivers/misc/armchina-npu/aipu_io.h           |  27 +
 drivers/misc/armchina-npu/aipu_irq.c          | 113 +++
 drivers/misc/armchina-npu/aipu_irq.h          |  36 +
 drivers/misc/armchina-npu/aipu_job_manager.c  | 689 ++++++++++++++++
 drivers/misc/armchina-npu/aipu_job_manager.h  | 110 +++
 drivers/misc/armchina-npu/aipu_mm.c           | 740 ++++++++++++++++++
 drivers/misc/armchina-npu/aipu_mm.h           | 127 +++
 drivers/misc/armchina-npu/aipu_priv.c         | 280 +++++++
 drivers/misc/armchina-npu/aipu_priv.h         |  58 ++
 drivers/misc/armchina-npu/aipu_soc_default.c  |  82 ++
 drivers/misc/armchina-npu/config.h            |  12 +
 .../armchina-npu/include/armchina_aipu_soc.h  |  52 ++
 drivers/misc/armchina-npu/zhouyi/Makefile     |   4 +
 drivers/misc/armchina-npu/zhouyi/z1.c         | 244 ++++++
 drivers/misc/armchina-npu/zhouyi/z1.h         |  33 +
 drivers/misc/armchina-npu/zhouyi/z2.c         | 311 ++++++++
 drivers/misc/armchina-npu/zhouyi/z2.h         |  47 ++
 drivers/misc/armchina-npu/zhouyi/zhouyi.c     | 142 ++++
 drivers/misc/armchina-npu/zhouyi/zhouyi.h     |  73 ++
 include/uapi/misc/armchina_aipu.h             | 335 ++++++++
 28 files changed, 4447 insertions(+)
 create mode 100644 drivers/misc/armchina-npu/Kconfig
 create mode 100644 drivers/misc/armchina-npu/Makefile
 create mode 100644 drivers/misc/armchina-npu/aipu.c
 create mode 100644 drivers/misc/armchina-npu/aipu_core.c
 create mode 100644 drivers/misc/armchina-npu/aipu_core.h
 create mode 100644 drivers/misc/armchina-npu/aipu_io.c
 create mode 100644 drivers/misc/armchina-npu/aipu_io.h
 create mode 100644 drivers/misc/armchina-npu/aipu_irq.c
 create mode 100644 drivers/misc/armchina-npu/aipu_irq.h
 create mode 100644 drivers/misc/armchina-npu/aipu_job_manager.c
 create mode 100644 drivers/misc/armchina-npu/aipu_job_manager.h
 create mode 100644 drivers/misc/armchina-npu/aipu_mm.c
 create mode 100644 drivers/misc/armchina-npu/aipu_mm.h
 create mode 100644 drivers/misc/armchina-npu/aipu_priv.c
 create mode 100644 drivers/misc/armchina-npu/aipu_priv.h
 create mode 100644 drivers/misc/armchina-npu/aipu_soc_default.c
 create mode 100644 drivers/misc/armchina-npu/config.h
 create mode 100644 drivers/misc/armchina-npu/include/armchina_aipu_soc.h
 create mode 100644 drivers/misc/armchina-npu/zhouyi/Makefile
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z1.c
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z1.h
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z2.c
 create mode 100644 drivers/misc/armchina-npu/zhouyi/z2.h
 create mode 100644 drivers/misc/armchina-npu/zhouyi/zhouyi.c
 create mode 100644 drivers/misc/armchina-npu/zhouyi/zhouyi.h
 create mode 100644 include/uapi/misc/armchina_aipu.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..a27fec2891d6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -487,4 +487,5 @@ source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
 source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
+source "drivers/misc/armchina-npu/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197af544..cc18c3eaefc2 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_UACCE)           +=3D uacce/
 obj-$(CONFIG_XILINX_SDFEC)     +=3D xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)   +=3D hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)   +=3D hi6421v600-irq.o
+obj-$(CONFIG_ARMCHINA_NPU)     +=3D armchina-npu/
diff --git a/drivers/misc/armchina-npu/Kconfig b/drivers/misc/armchina-npu/=
Kconfig
new file mode 100644
index 000000000000..9c1b67d88d66
--- /dev/null
+++ b/drivers/misc/armchina-npu/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ArmChina NPU driver
+#
+
+config ARMCHINA_NPU
+       tristate "ArmChina NPU"
+       help
+         Enables driver for ArmChina's AI Accelerator which is designed fo=
r
+         the acceleration of AI inference tasks on Arm SoC.
+
+         The driver manages the NPU char device and provides IOCTL interfa=
ce for
+         the user to submit workloads to the NPU cores.
+
+         If unsure, say N.
diff --git a/drivers/misc/armchina-npu/Makefile b/drivers/misc/armchina-npu=
/Makefile
new file mode 100644
index 000000000000..935ead214a27
--- /dev/null
+++ b/drivers/misc/armchina-npu/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-ccflags-y +=3D -I$(src)/include
+subdir-ccflags-y +=3D -I$(src)/zhouyi
+
+obj-$(CONFIG_ARMCHINA_NPU)  +=3D armchina_npu.o
+armchina_npu-y       :=3D aipu.o aipu_core.o aipu_io.o aipu_irq.o  \
+                       aipu_job_manager.o aipu_mm.o aipu_priv.o \
+                       aipu_soc_default.o
+
+include $(src)/zhouyi/Makefile
+armchina_npu-y       +=3D $(ZHOUYI_FILES)
diff --git a/drivers/misc/armchina-npu/aipu.c b/drivers/misc/armchina-npu/a=
ipu.c
new file mode 100644
index 000000000000..6add10b00b98
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/mm_types.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+#include <linux/compat.h>
+#include <uapi/misc/armchina_aipu.h>
+#include "include/armchina_aipu_soc.h"
+#include "aipu_mm.h"
+#include "aipu_job_manager.h"
+#include "aipu_priv.h"
+#include "zhouyi.h"
+#include "config.h"
+
+static struct aipu_priv *aipu;
+
+static int aipu_open(struct inode *inode, struct file *filp)
+{
+       filp->private_data =3D aipu;
+       return aipu_priv_check_status(aipu);
+}
+
+static int aipu_release(struct inode *inode, struct file *filp)
+{
+       int ret =3D 0;
+       struct aipu_priv *aipu =3D filp->private_data;
+
+       ret =3D aipu_job_manager_cancel_jobs(&aipu->job_manager, filp);
+       if (ret)
+               return ret;
+
+       aipu_mm_free_buffers(&aipu->mm, filp);
+       return 0;
+}
+
+static long aipu_ioctl(struct file *filp, unsigned int cmd, unsigned long =
arg)
+{
+       int ret =3D 0;
+       struct aipu_priv *aipu =3D filp->private_data;
+
+       u32 core_cnt =3D 0;
+       struct aipu_core_cap *core_cap =3D NULL;
+       struct aipu_cap cap;
+       struct aipu_buf_request buf_req;
+       struct aipu_job_desc user_job;
+       struct aipu_buf_desc desc;
+       struct aipu_io_req io_req;
+       struct aipu_job_status_query status;
+       u32 job_id;
+
+       switch (cmd) {
+       case AIPU_IOCTL_QUERY_CAP:
+               ret =3D aipu_priv_query_capability(aipu, &cap);
+               if (!ret && copy_to_user((struct aipu_cap __user *)arg, &ca=
p, sizeof(cap)))
+                       ret =3D -EINVAL;
+               break;
+       case AIPU_IOCTL_QUERY_CORE_CAP:
+               core_cnt =3D aipu_priv_get_core_cnt(aipu);
+               core_cap =3D kcalloc(core_cnt, sizeof(*core_cap), GFP_KERNE=
L);
+               if (core_cap) {
+                       ret =3D aipu_priv_query_core_capability(aipu, core_=
cap);
+                       if (!ret &&
+                           copy_to_user((struct aipu_core_cap __user *)arg=
, core_cap,
+                                        core_cnt * sizeof(*core_cap)))
+                               ret =3D -EINVAL;
+                       kfree(core_cap);
+                       core_cap =3D NULL;
+               } else {
+                       ret =3D -ENOMEM;
+               }
+               break;
+       case AIPU_IOCTL_REQ_BUF:
+               if (!copy_from_user(&buf_req, (struct aipu_buf_request __us=
er *)arg,
+                                   sizeof(buf_req))) {
+                       ret =3D aipu_mm_alloc(&aipu->mm, &buf_req, filp);
+                       if (!ret &&
+                           copy_to_user((struct aipu_buf_request __user *)=
arg, &buf_req,
+                                        sizeof(buf_req)))
+                               ret =3D -EINVAL;
+               } else {
+                       ret =3D -EINVAL;
+               }
+               break;
+       case AIPU_IOCTL_FREE_BUF:
+               if (!copy_from_user(&desc, (struct buf_desc __user *)arg, s=
izeof(desc)))
+                       ret =3D aipu_mm_free(&aipu->mm, &desc, filp);
+               else
+                       ret =3D -EINVAL;
+               break;
+       case AIPU_IOCTL_DISABLE_SRAM:
+               ret =3D aipu_mm_disable_sram_allocation(&aipu->mm, filp);
+               break;
+       case AIPU_IOCTL_ENABLE_SRAM:
+               ret =3D aipu_mm_enable_sram_allocation(&aipu->mm, filp);
+               break;
+       case AIPU_IOCTL_SCHEDULE_JOB:
+               if (!copy_from_user(&user_job, (struct user_job_desc __user=
 *)arg,
+                                   sizeof(user_job)))
+                       ret =3D aipu_job_manager_scheduler(&aipu->job_manag=
er, &user_job, filp);
+               else
+                       ret =3D -EINVAL;
+               break;
+       case AIPU_IOCTL_QUERY_STATUS:
+               if (!copy_from_user(&status, (struct job_status_query __use=
r *)arg,
+                                   sizeof(status))) {
+                       ret =3D aipu_job_manager_get_job_status(&aipu->job_=
manager, &status, filp);
+                       if (!ret &&
+                           copy_to_user((struct job_status_query __user *)=
arg, &status,
+                                        sizeof(status)))
+                               ret =3D -EINVAL;
+               }
+               break;
+       case AIPU_IOCTL_KILL_TIMEOUT_JOB:
+               if (!copy_from_user(&job_id, (u32 __user *)arg, sizeof(job_=
id)))
+                       ret =3D aipu_job_manager_invalidate_timeout_job(&ai=
pu->job_manager, job_id);
+               else
+                       ret =3D -EINVAL;
+               break;
+       case AIPU_IOCTL_REQ_IO:
+               if (!copy_from_user(&io_req, (struct aipu_io_req __user *)a=
rg, sizeof(io_req))) {
+                       ret =3D aipu_priv_io_rw(aipu, &io_req);
+                       if (!ret &&
+                           copy_to_user((struct aipu_io_req __user *)arg, =
&io_req,
+                                        sizeof(io_req)))
+                               ret =3D -EINVAL;
+               } else {
+                       ret =3D -EINVAL;
+               }
+               break;
+       default:
+               ret =3D -ENOTTY;
+               break;
+       }
+
+       return ret;
+}
+
+#ifdef CONFIG_COMPAT
+static long aipu_compat_ioctl(struct file *filp, unsigned int cmd, unsigne=
d long arg)
+{
+       arg =3D (unsigned long)compat_ptr(arg);
+
+       return aipu_ioctl(filp, cmd, arg);
+}
+#endif
+
+static int aipu_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+       struct aipu_priv *aipu =3D filp->private_data;
+
+       return aipu_mm_mmap_buf(&aipu->mm, vma, filp);
+}
+
+static unsigned int aipu_poll(struct file *filp, struct poll_table_struct =
*wait)
+{
+       unsigned int mask =3D 0;
+       struct aipu_priv *aipu =3D filp->private_data;
+
+       if (aipu_job_manager_has_end_job(&aipu->job_manager, filp, wait, ta=
sk_pid_nr(current)))
+               mask |=3D POLLIN | POLLRDNORM;
+
+       return mask;
+}
+
+static const struct file_operations aipu_fops =3D {
+       .owner =3D THIS_MODULE,
+       .open =3D aipu_open,
+       .poll =3D aipu_poll,
+       .unlocked_ioctl =3D aipu_ioctl,
+#ifdef CONFIG_COMPAT
+       .compat_ioctl =3D aipu_compat_ioctl,
+#endif
+       .mmap =3D aipu_mmap,
+       .release =3D aipu_release,
+};
+
+/**
+ * @armchina_aipu_probe() - probe operation for platfom driver provided by=
 ArmChina
+ * @p_dev: pointer to the AIPU platform device struct.
+ * @soc:   pointer to aipu SoC struct contains soc specific data.
+ *         this argument can be NULL if SoC vendor has no AIPU related soc=
 data structure.
+ * @ops:   pointer to aipu SoC operation struct.
+ *         this argument can be NULL if SoC vendor does not provide any so=
c operation. In
+ *         this case the SoC related operations in AIPU driver are unavail=
able.
+ *
+ * This function should be called in a SoC vendor provided xx_aipu_probe()=
 function,
+ * which is registered to the platfom_driver struct; if no such xx_aipu_pr=
obe() is provided,
+ * SoC vendor should directly register this function to the platfom_driver=
 struct.
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int armchina_aipu_probe(struct platform_device *p_dev, struct aipu_soc *so=
c,
+                       struct aipu_soc_operations *ops)
+{
+       int ret =3D 0;
+       struct device *dev =3D &p_dev->dev;
+       struct aipu_core *core =3D NULL;
+       int version =3D 0;
+       int config =3D 0;
+       int id =3D 0;
+
+       /* create & init aipu priv struct shared by all cores */
+       if (!aipu) {
+               aipu =3D devm_kzalloc(dev, sizeof(*aipu), GFP_KERNEL);
+               if (!aipu)
+                       return -ENOMEM;
+
+               dev_info(dev, "AIPU KMD probe start...\n");
+               ret =3D init_aipu_priv(aipu, p_dev, &aipu_fops, soc, ops);
+               if (ret)
+                       return ret;
+       }
+
+       zhouyi_detect_aipu_version(p_dev, &version, &config);
+       of_property_read_u32(dev->of_node, "core-id", &id);
+       if (version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V1 ||
+           version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V2 ||
+           version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V3) {
+               dev_info(dev, "AIPU core #%d detected: zhouyi-v%d-%04d\n", =
id, version, config);
+       } else {
+               dev_err(dev, "unsupported AIPU core detected (id %d, versio=
n 0x%x)\n",
+                       id, version);
+               ret =3D -EINVAL;
+               goto out_clean;
+       }
+
+       core =3D devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
+       if (!core) {
+               ret =3D -ENOMEM;
+               goto out_clean;
+       }
+
+       ret =3D aipu_priv_add_core(aipu, core, version, id, p_dev);
+       if (ret)
+               goto out_clean;
+
+       dev_info(dev, "initialize AIPU core #%d done\n", id);
+       platform_set_drvdata(p_dev, core);
+       goto finish;
+
+out_clean:
+       armchina_aipu_remove(p_dev);
+
+finish:
+       return ret;
+}
+EXPORT_SYMBOL(armchina_aipu_probe);
+
+/**
+ * @armchina_aipu_remove() - remove operation for platfom driver provided =
by ArmChina
+ * @p_dev: pointer to the AIPU platform device struct
+ *
+ * This function should be called in a SoC vendor provided xx_aipu_remove(=
) function,
+ * which is registered to the platfom_driver struct; if no such xx_aipu_re=
move() is provided,
+ * this function should be directly registered to the platfom_driver struc=
t.
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int armchina_aipu_remove(struct platform_device *p_dev)
+{
+       if (!aipu || !aipu->is_init)
+               return 0;
+       return deinit_aipu_priv(aipu);
+}
+EXPORT_SYMBOL(armchina_aipu_remove);
+
+/**
+ * @armchina_aipu_suspend() - suspend operation for platfom driver provide=
d by ArmChina
+ * @p_dev: pointer to the AIPU platform device struct.
+ * @state: power state device is entering.
+ *
+ * This function disables the AIPU clock from SoC level with the disable_c=
lk method
+ * registered in SoC probing. SoC vendor can directly register this functi=
on to the
+ * platfom_driver struct or implements its private xx_aipu_suspend() as a =
replacement.
+ */
+int armchina_aipu_suspend(struct platform_device *p_dev, pm_message_t stat=
e)
+{
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if (aipu && aipu->soc_ops && aipu->soc_ops->disable_clk)
+               aipu->soc_ops->disable_clk(core->dev, aipu->soc);
+       return 0;
+}
+EXPORT_SYMBOL(armchina_aipu_suspend);
+
+/**
+ * @armchina_aipu_resume() - resume operation for platfom driver provided =
by ArmChina
+ * @p_dev: pointer to the AIPU platform device struct.
+ *
+ * This function enables the AIPU clock from SoC level with the enable_clk=
 method
+ * registered in SoC probing, and enable AIPU interrupts. SoC vendor shoul=
d directly
+ * register this function to the platfom_driver struct, or implements its =
private
+ * xx_aipu_resume() calls this function.
+ */
+int armchina_aipu_resume(struct platform_device *p_dev)
+{
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if (aipu && aipu->soc_ops && aipu->soc_ops->enable_clk)
+               aipu->soc_ops->enable_clk(core->dev, aipu->soc);
+
+       core->ops->enable_interrupt(core);
+       return 0;
+}
+EXPORT_SYMBOL(armchina_aipu_resume);
diff --git a/drivers/misc/armchina-npu/aipu_core.c b/drivers/misc/armchina-=
npu/aipu_core.c
new file mode 100644
index 000000000000..3ed989801f7b
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_core.c
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/slab.h>
+#include <linux/string.h>
+#include "aipu_priv.h"
+#include "config.h"
+#include "z1.h"
+#include "z2.h"
+
+#define MAX_CHAR_SYSFS 4096
+
+inline struct aipu_soc *get_soc(struct aipu_core *core)
+{
+       if (core && core->priv)
+               return core->priv->soc;
+       return NULL;
+}
+
+inline struct aipu_soc_operations *get_soc_ops(struct aipu_core *core)
+{
+       if (core && core->priv)
+               return core->priv->soc_ops;
+       return NULL;
+}
+
+inline struct aipu_job_manager *get_job_manager(struct aipu_core *core)
+{
+       if (core && core->priv)
+               return &core->priv->job_manager;
+       return NULL;
+}
+
+#ifdef CONFIG_SYSFS
+static ssize_t aipu_core_ext_register_sysfs_show(struct device *dev,
+                                                struct device_attribute *a=
ttr,
+                                                char *buf)
+{
+       int ret =3D 0;
+       char tmp[512];
+       struct platform_device *p_dev =3D container_of(dev, struct platform=
_device, dev);
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if (unlikely(!core))
+               return 0;
+
+       if (get_soc_ops(core) &&
+           get_soc_ops(core)->is_clk_enabled &&
+           !get_soc_ops(core)->is_clk_enabled(dev, get_soc(core))) {
+               return snprintf(buf, MAX_CHAR_SYSFS,
+                   "AIPU is suspended and external registers cannot be rea=
d!\n");
+       }
+
+       ret +=3D snprintf(tmp, 1024, "-------------------------------------=
---\n");
+       strcat(buf, tmp);
+       ret +=3D snprintf(tmp, 1024, "   AIPU Core%d External Register Valu=
es\n", core->id);
+       strcat(buf, tmp);
+       ret +=3D snprintf(tmp, 1024, "-------------------------------------=
---\n");
+       strcat(buf, tmp);
+       ret +=3D snprintf(tmp, 1024, "%-*s%-*s%-*s\n", 8, "Offset", 22, "Na=
me", 10, "Value");
+       strcat(buf, tmp);
+       ret +=3D snprintf(tmp, 1024, "-------------------------------------=
---\n");
+       strcat(buf, tmp);
+       ret +=3D core->ops->sysfs_show(core, buf);
+       ret +=3D snprintf(tmp, 1024, "-------------------------------------=
---\n");
+       strcat(buf, tmp);
+
+       return ret;
+}
+
+static ssize_t aipu_core_ext_register_sysfs_store(struct device *dev,
+                                                 struct device_attribute *=
attr,
+                                                 const char *buf, size_t c=
ount)
+{
+       int i =3D 0;
+       int ret =3D 0;
+       char *token =3D NULL;
+       char *buf_dup =3D NULL;
+       int value[3] =3D { 0 };
+       struct aipu_io_req io_req;
+       struct platform_device *p_dev =3D container_of(dev, struct platform=
_device, dev);
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if (get_soc_ops(core) &&
+           get_soc_ops(core)->is_clk_enabled &&
+           !get_soc_ops(core)->is_clk_enabled(dev, get_soc(core)))
+               return 0;
+
+       buf_dup =3D kzalloc(1024, GFP_KERNEL);
+       if (!buf_dup)
+               return -ENOMEM;
+       snprintf(buf_dup, 1024, buf);
+
+       for (i =3D 0; i < 3; i++) {
+               token =3D strsep(&buf_dup, "-");
+               if (!token) {
+                       dev_err(dev, "[SYSFS] please echo as this format: <=
reg_offset>-<write time>-<write value>");
+                       goto out_free_buffer;
+               }
+
+               dev_dbg(dev, "[SYSFS] to convert str: %s", token);
+
+               ret =3D kstrtouint(token, 0, &value[i]);
+               if (ret) {
+                       dev_err(dev, "[SYSFS] convert str to int failed (%d=
): %s", ret, token);
+                       goto out_free_buffer;
+               }
+       }
+
+       dev_dbg(dev, "[SYSFS] offset 0x%x, time 0x%x, value 0x%x",
+               value[0], value[1], value[2]);
+
+       io_req.rw =3D AIPU_IO_WRITE;
+       io_req.offset =3D value[0];
+       io_req.value =3D value[2];
+       for (i =3D 0; i < value[1]; i++) {
+               dev_dbg(dev, "[SYSFS] writing register 0x%x with value 0x%x=
", value[0], value[2]);
+               core->ops->io_rw(core, &io_req);
+       }
+
+out_free_buffer:
+       kfree(buf_dup);
+       return count;
+}
+
+static ssize_t aipu_core_clock_sysfs_show(struct device *dev,
+                                         struct device_attribute *attr,
+                                         char *buf)
+{
+       struct platform_device *p_dev =3D container_of(dev, struct platform=
_device, dev);
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       /*
+        * If SoC level provides no clock operations,
+        * the state of AIPU is by default treated as normal.
+        */
+       if (get_soc_ops(core) &&
+           get_soc_ops(core)->is_clk_enabled &&
+           !get_soc_ops(core)->is_clk_enabled(dev, get_soc(core)))
+               return snprintf(buf, MAX_CHAR_SYSFS,
+                               "AIPU is in clock gating state and suspende=
d.\n");
+       else
+               return snprintf(buf, MAX_CHAR_SYSFS, "AIPU is in normal wor=
king state.\n");
+}
+
+static ssize_t aipu_core_clock_sysfs_store(struct device *dev,
+                                          struct device_attribute *attr,
+                                          const char *buf, size_t count)
+{
+       int do_suspend =3D 0;
+       int do_resume =3D 0;
+       struct platform_device *p_dev =3D container_of(dev, struct platform=
_device, dev);
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if (unlikely(!core))
+               return count;
+
+       if (!get_soc_ops(core) ||
+           !get_soc_ops(core)->enable_clk ||
+           !get_soc_ops(core)->disable_clk ||
+           !get_soc_ops(core)->is_clk_enabled) {
+               dev_info(dev, "operation is not supported.\n");
+               return count;
+       }
+
+       if ((strncmp(buf, "1", 1) =3D=3D 0))
+               do_suspend =3D 1;
+       else if ((strncmp(buf, "0", 1) =3D=3D 0))
+               do_resume =3D 1;
+
+       if (get_soc_ops(core)->is_clk_enabled(dev, get_soc(core)) &&
+           core->ops->is_idle(core) && do_suspend) {
+               dev_info(dev, "disable clock\n");
+               get_soc_ops(core)->disable_clk(core->dev, get_soc(core));
+       } else if (!get_soc_ops(core)->is_clk_enabled(dev, get_soc(core)) &=
& do_resume) {
+               dev_info(dev, "enable clock\n");
+               get_soc_ops(core)->enable_clk(core->dev, get_soc(core));
+       } else {
+               dev_err(dev, "operation cannot be completed!\n");
+       }
+
+       return count;
+}
+
+static ssize_t aipu_core_disable_sysfs_show(struct device *dev, struct dev=
ice_attribute *attr,
+                                           char *buf)
+{
+       struct platform_device *p_dev =3D container_of(dev, struct platform=
_device, dev);
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if (atomic_read(&core->disable)) {
+               return snprintf(buf, MAX_CHAR_SYSFS,
+                   "AIPU core #%d is disabled (echo 0 > /sys/devices/platf=
orm/[dev]/disable to enable it).\n",
+                   core->id);
+       } else {
+               return snprintf(buf, MAX_CHAR_SYSFS,
+                   "AIPU core #%d is enabled (echo 1 > /sys/devices/platfo=
rm/[dev]/disable to disable it).\n",
+                   core->id);
+       }
+}
+
+static ssize_t aipu_core_disable_sysfs_store(struct device *dev, struct de=
vice_attribute *attr,
+                                            const char *buf, size_t count)
+{
+       int do_disable =3D 0;
+       struct platform_device *p_dev =3D container_of(dev, struct platform=
_device, dev);
+       struct aipu_core *core =3D platform_get_drvdata(p_dev);
+
+       if ((strncmp(buf, "1", 1) =3D=3D 0))
+               do_disable =3D 1;
+       else if ((strncmp(buf, "0", 1) =3D=3D 0))
+               do_disable =3D 0;
+       else
+               do_disable =3D -1;
+
+       if (atomic_read(&core->disable) && !do_disable) {
+               dev_info(dev, "enable core...\n");
+               atomic_set(&core->disable, 0);
+       } else if (!atomic_read(&core->disable) && do_disable) {
+               dev_info(dev, "disable core...\n");
+               atomic_set(&core->disable, 1);
+       }
+
+       return count;
+}
+
+typedef ssize_t (*sysfs_show_t)(struct device *dev, struct device_attribut=
e *attr, char *buf);
+typedef ssize_t (*sysfs_store_t)(struct device *dev, struct device_attribu=
te *attr,
+                                const char *buf, size_t count);
+
+static struct device_attribute *aipu_core_create_attr(struct device *dev,
+                                                     struct device_attribu=
te **attr,
+                                                     const char *name, int=
 mode,
+                                                     sysfs_show_t show, sy=
sfs_store_t store)
+{
+       if (!dev || !attr || !name)
+               return ERR_PTR(-EINVAL);
+
+       *attr =3D kzalloc(sizeof(*attr), GFP_KERNEL);
+       if (!*attr)
+               return ERR_PTR(-ENOMEM);
+
+       (*attr)->attr.name =3D name;
+       (*attr)->attr.mode =3D mode;
+       (*attr)->show =3D show;
+       (*attr)->store =3D store;
+       device_create_file(dev, *attr);
+
+       return *attr;
+}
+
+static void aipu_core_destroy_attr(struct device *dev, struct device_attri=
bute **attr)
+{
+       if (!dev || !attr || !*attr)
+               return;
+
+       device_remove_file(dev, *attr);
+       kfree(*attr);
+       *attr =3D NULL;
+}
+#endif
+
+/**
+ * @init_aipu_core() - init an AIPU core struct in driver probe phase
+ * @core:     AIPU hardware core created in a calling function
+ * @version:  AIPU core hardware version
+ * @id:       AIPU core ID
+ * @priv:     pointer to aipu_private struct
+ * @p_dev:    platform device struct pointer
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int init_aipu_core(struct aipu_core *core, int version, int id, struct aip=
u_priv *priv,
+                  struct platform_device *p_dev)
+{
+       int ret =3D 0;
+       struct resource *res =3D NULL;
+       u64 base =3D 0;
+       u64 size =3D 0;
+
+       if (!core || !p_dev || !priv)
+               return -EINVAL;
+
+       WARN_ON(core->is_init);
+       WARN_ON(version !=3D AIPU_ISA_VERSION_ZHOUYI_V1 &&
+               version !=3D AIPU_ISA_VERSION_ZHOUYI_V2 &&
+               version !=3D AIPU_ISA_VERSION_ZHOUYI_V3);
+
+       core->version =3D version;
+       core->id =3D id;
+       core->dev =3D &p_dev->dev;
+       core->priv =3D priv;
+       atomic_set(&core->disable, 0);
+       snprintf(core->core_name, sizeof(core->core_name), "aipu%d", id);
+
+       if (version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V1) {
+               core->max_sched_num =3D ZHOUYI_V1_MAX_SCHED_JOB_NUM;
+               core->ops =3D get_zhouyi_v1_ops();
+       } else if (version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V2 ||
+                  version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V3) {
+               core->max_sched_num =3D ZHOUYI_V2_MAX_SCHED_JOB_NUM;
+               core->ops =3D get_zhouyi_v2_ops();
+       }
+
+       res =3D platform_get_resource(p_dev, IORESOURCE_MEM, 0);
+       if (!res) {
+               dev_err(core->dev, "get aipu core #%d IO region failed\n", =
id);
+               ret =3D -EINVAL;
+               goto init_reg_fail;
+       }
+       base =3D res->start;
+       size =3D res->end - res->start + 1;
+       dev_dbg(core->dev, "get aipu core #%d IO region: [0x%llx, 0x%llx]\n=
",
+               id, base, res->end);
+
+       ret =3D init_aipu_ioregion(&core->reg, base, size);
+       if (ret) {
+               dev_err(core->dev,
+                       "create aipu core #%d IO region failed: base 0x%llx=
, size 0x%llx\n",
+                       id, base, size);
+               goto init_reg_fail;
+       }
+       dev_dbg(core->dev, "init aipu core #%d IO region done: [0x%llx, 0x%=
llx]\n",
+               id, base, res->end);
+
+       res =3D platform_get_resource(p_dev, IORESOURCE_IRQ, 0);
+       if (!res) {
+               dev_err(core->dev, "get aipu core #%d IRQ number failed\n",=
 id);
+               ret =3D -EINVAL;
+               goto init_irq_fail;
+       }
+       dev_dbg(core->dev, "get aipu core #%d IRQ number: 0x%x\n", id, (int=
)res->start);
+
+       core->irq_obj =3D aipu_create_irq_object(res->start, core, core->co=
re_name);
+       if (!core->irq_obj) {
+               dev_err(core->dev, "create IRQ object for core #%d failed: =
IRQ 0x%x\n",
+                       id, (int)res->start);
+               ret =3D -EFAULT;
+               goto init_irq_fail;
+       }
+       dev_dbg(core->dev, "init aipu core #%d IRQ done\n", id);
+
+#ifdef CONFIG_SYSFS
+       if (IS_ERR(aipu_core_create_attr(core->dev, &core->reg_attr, "ext_r=
egisters", 0644,
+                                        aipu_core_ext_register_sysfs_show,
+                                        aipu_core_ext_register_sysfs_store=
))) {
+               ret =3D -EFAULT;
+               goto init_sysfs_fail;
+       }
+
+       if (priv->soc_ops &&
+           priv->soc_ops->enable_clk && priv->soc_ops->disable_clk &&
+           IS_ERR(aipu_core_create_attr(core->dev, &core->clk_attr, "soc_c=
lock", 0644,
+                                        aipu_core_clock_sysfs_show,
+                                        aipu_core_clock_sysfs_store))) {
+               ret =3D -EFAULT;
+               goto init_sysfs_fail;
+       }
+
+       if (IS_ERR(aipu_core_create_attr(core->dev, &core->disable_attr, "d=
isable", 0644,
+                                        aipu_core_disable_sysfs_show,
+                                        aipu_core_disable_sysfs_store))) {
+               ret =3D -EFAULT;
+               goto init_sysfs_fail;
+       }
+#else
+       core->reg_attr =3D NULL;
+       core->clk_attr =3D NULL;
+       core->disable_attr =3D NULL;
+#endif
+
+       core->arch =3D AIPU_ARCH_ZHOUYI;
+       core->config =3D core->ops->get_config(core);
+       core->ops->enable_interrupt(core);
+       core->ops->print_hw_id_info(core);
+
+       core->is_init =3D 1;
+       goto finish;
+
+#ifdef CONFIG_SYSFS
+init_sysfs_fail:
+       aipu_core_destroy_attr(core->dev, &core->reg_attr);
+       aipu_core_destroy_attr(core->dev, &core->clk_attr);
+       aipu_core_destroy_attr(core->dev, &core->disable_attr);
+#endif
+       aipu_destroy_irq_object(core->irq_obj);
+init_irq_fail:
+init_reg_fail:
+       deinit_aipu_ioregion(&core->reg);
+
+finish:
+       return ret;
+}
+
+/**
+ * @deinit_aipu_core() - deinit a created aipu_core struct
+ * @core: pointer to struct aipu_core initialized in init_aipu_core()
+ */
+void deinit_aipu_core(struct aipu_core *core)
+{
+       if (!core)
+               return;
+
+       core->ops->disable_interrupt(core);
+       deinit_aipu_ioregion(&core->reg);
+
+       if (core->irq_obj) {
+               aipu_destroy_irq_object(core->irq_obj);
+               core->irq_obj =3D NULL;
+       }
+
+#ifdef CONFIG_SYSFS
+       aipu_core_destroy_attr(core->dev, &core->reg_attr);
+       aipu_core_destroy_attr(core->dev, &core->clk_attr);
+       aipu_core_destroy_attr(core->dev, &core->disable_attr);
+#endif
+       core->is_init =3D 0;
+}
diff --git a/drivers/misc/armchina-npu/aipu_core.h b/drivers/misc/armchina-=
npu/aipu_core.h
new file mode 100644
index 000000000000..306253a4b841
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_core.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_CORE_H__
+#define __AIPU_CORE_H__
+
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/atomic.h>
+#include <uapi/misc/armchina_aipu.h>
+#include "aipu_irq.h"
+#include "aipu_io.h"
+#include "zhouyi/zhouyi.h"
+#include "config.h"
+
+struct aipu_core;
+struct aipu_priv;
+
+/**
+ * struct aipu_core_operations - a struct contains AIPU hardware operation=
 methods
+ * @get_version:        get hardware version number
+ * @get_config:         get hardware configuration number
+ * @enable_interrupt:   enable all AIPU interrupts
+ * @disable_interrupt:  disable all AIPU interrupts
+ * @trigger:            trigger a deferred-job to run on a reserved core
+ * @reserve:            reserve AIPU core for a job/deferred-job
+ * @is_idle:            is AIPU hardware idle or not
+ * @read_status_reg:    read status register value
+ * @print_hw_id_info:   print AIPU version ID registers information
+ * @io_rw:              direct IO read/write operations
+ * @upper_half:         interrupt upper half handler
+ * @bottom_half:        interrupt bottom half handler
+ * @sysfs_show:         show core external register values
+ */
+struct aipu_core_operations {
+       int (*get_version)(struct aipu_core *core);
+       int (*get_config)(struct aipu_core *core);
+       void (*enable_interrupt)(struct aipu_core *core);
+       void (*disable_interrupt)(struct aipu_core *core);
+       void (*trigger)(struct aipu_core *core);
+       int (*reserve)(struct aipu_core *core, struct aipu_job_desc *udesc,
+                      int do_trigger);
+       bool (*is_idle)(struct aipu_core *core);
+       int (*read_status_reg)(struct aipu_core *core);
+       void (*print_hw_id_info)(struct aipu_core *core);
+       int (*io_rw)(struct aipu_core *core, struct aipu_io_req *io_req);
+       int (*upper_half)(void *data);
+       void (*bottom_half)(void *data);
+#ifdef CONFIG_SYSFS
+       int (*sysfs_show)(struct aipu_core *core, char *buf);
+#endif
+};
+
+/**
+ * struct aipu_core - a general struct describe a hardware AIPU core
+ * @id:              AIPU core ID
+ * @arch:            AIPU architecture number
+ * @version:         AIPU hardware version number
+ * @config:          AIPU hardware configuration number
+ * @core_name:       AIPU core name string
+ * @max_sched_num:   maximum number of jobs can be scheduled in pipeline
+ * @dev:             device struct pointer
+ * @reg:             IO region array of this AIPU core
+ * @ops:             operations of this core
+ * @irq_obj:         interrupt object of this core
+ * @priv:            pointer to aipu private struct
+ * @reg_attr:        external register attribute
+ * @clk_attr:        clock attribute
+ * @disable_attr:    disable core attribute
+ * @disable:         core disable flag (for debug usage)
+ * @is_init:         init flag
+ */
+struct aipu_core {
+       int id;
+       int arch;
+       int version;
+       int config;
+       char core_name[10];
+       int max_sched_num;
+       struct device *dev;
+       struct io_region reg;
+       struct aipu_core_operations *ops;
+       struct aipu_irq_object *irq_obj;
+       struct aipu_priv *priv;
+       struct device_attribute *reg_attr;
+       struct device_attribute *clk_attr;
+       struct device_attribute *disable_attr;
+       atomic_t disable;
+       int is_init;
+};
+
+int init_aipu_core(struct aipu_core *core, int version, int id, struct aip=
u_priv *priv,
+                  struct platform_device *p_dev);
+void deinit_aipu_core(struct aipu_core *core);
+struct aipu_soc *get_soc(struct aipu_core *core);
+struct aipu_soc_operations *get_soc_ops(struct aipu_core *core);
+struct aipu_job_manager *get_job_manager(struct aipu_core *core);
+
+#endif /* __AIPU_CORE_H__ */
diff --git a/drivers/misc/armchina-npu/aipu_io.c b/drivers/misc/armchina-np=
u/aipu_io.c
new file mode 100644
index 000000000000..df95fc0a4cf9
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_io.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/ioport.h>
+#include "aipu_io.h"
+
+/**
+ * @init_aipu_ioregion() - initialize struct io_region using physical base=
 address
+ * @region:    pointer to struct io_region to be initialized
+ * @phys_base: base address of this region
+ * @size:      size of this region
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int init_aipu_ioregion(struct io_region *region, u64 phys_base, u32 size)
+{
+       int ret =3D 0;
+
+       if (!region || !size)
+               return -EINVAL;
+
+       if (!request_mem_region(phys_base, size, "aipu"))
+               return -ENOMEM;
+
+       region->kern =3D ioremap(phys_base, size);
+       if (!region->kern) {
+               release_mem_region(phys_base, size);
+               return -ENOMEM;
+       }
+
+       region->phys =3D phys_base;
+       region->size =3D size;
+       return ret;
+}
+
+/**
+ * @deinit_aipu_ioregion() - destroy an AIPU IO region
+ * @region: pointer to struct io_region initialized in init_aipu_ioregion(=
)
+ */
+void deinit_aipu_ioregion(struct io_region *region)
+{
+       if (region && region->kern) {
+               iounmap(region->kern);
+               release_mem_region(region->phys, region->size);
+               region->kern =3D NULL;
+               region->phys =3D 0;
+               region->size =3D 0;
+       }
+}
+
+/**
+ * @aipu_read32() - read AIPU register in word
+ * @region: pointer to struct io_region initialized in init_aipu_ioregion(=
)
+ * @offset: AIPU register offset
+ * Return: u32 value in the register or error code
+ */
+int aipu_read32(struct io_region *region, int offset)
+{
+       if (region && region->kern && offset < region->size)
+               return readl((void __iomem *)((unsigned long)(region->kern)=
 + offset));
+       return -EINVAL;
+}
+
+/**
+ * @aipu_write32() - write AIPU register in word
+ * @region: pointer to struct io_region initialized in init_aipu_ioregion(=
)
+ * @offset: AIPU register offset
+ * @data:   u32 data to be writen
+ */
+void aipu_write32(struct io_region *region, int offset, unsigned int data)
+{
+       if (region && region->kern && offset < region->size)
+               writel((u32)data, (void __iomem *)((unsigned long)(region->=
kern) + offset));
+}
diff --git a/drivers/misc/armchina-npu/aipu_io.h b/drivers/misc/armchina-np=
u/aipu_io.h
new file mode 100644
index 000000000000..8d5e8102f93d
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_io.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_IO_H__
+#define __AIPU_IO_H__
+
+#include <linux/io.h>
+#include <asm/types.h>
+
+/**
+ * struct io_region - a general struct describe IO region
+ * @phys: physical address base of an IO region
+ * @kern: kernel virtual address base remapped from phys
+ * @size: size of an IO region in byte
+ */
+struct io_region {
+       u64  phys;
+       void *kern;
+       u32  size;
+};
+
+int init_aipu_ioregion(struct io_region *region, u64 phys_base, u32 size);
+void deinit_aipu_ioregion(struct io_region *region);
+int aipu_read32(struct io_region *region, int offset);
+void aipu_write32(struct io_region *region, int offset, unsigned int data)=
;
+
+#endif /* __AIPU_IO_H__ */
diff --git a/drivers/misc/armchina-npu/aipu_irq.c b/drivers/misc/armchina-n=
pu/aipu_irq.c
new file mode 100644
index 000000000000..efa0569fdb97
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_irq.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include "aipu_irq.h"
+#include "aipu_core.h"
+
+static irqreturn_t aipu_irq_handler_upper_half(int irq, void *dev_id)
+{
+       struct aipu_core *core =3D (struct aipu_core *)(((struct device *)d=
ev_id)->driver_data);
+
+       return core->ops->upper_half(core);
+}
+
+static void aipu_irq_handler_bottom_half(struct work_struct *work)
+{
+       struct aipu_irq_object *irq_obj =3D NULL;
+       struct aipu_core *core =3D NULL;
+
+       if (work) {
+               irq_obj =3D container_of(work, struct aipu_irq_object, work=
);
+               core =3D irq_obj->core;
+               core->ops->bottom_half(core);
+       }
+}
+
+/**
+ * @aipu_create_irq_object() - initialize an AIPU IRQ object
+ * @irqnum:      interrupt number
+ * @core:        aipu core struct pointer
+ * @description: irq object description string
+ *
+ * Return: pointer to the created irq_object on success and NULL otherwise=
.
+ */
+struct aipu_irq_object *aipu_create_irq_object(u32 irqnum, void *core, cha=
r *description)
+{
+       int ret =3D 0;
+       struct aipu_irq_object *irq_obj =3D NULL;
+
+       if (!core || !description)
+               return NULL;
+
+       irq_obj =3D kzalloc(sizeof(*irq_obj), GFP_KERNEL);
+       if (!irq_obj)
+               return NULL;
+
+       irq_obj->aipu_wq =3D NULL;
+       irq_obj->irqnum =3D 0;
+       irq_obj->dev =3D ((struct aipu_core *)core)->dev;
+
+       irq_obj->aipu_wq =3D create_singlethread_workqueue(description);
+       if (!irq_obj->aipu_wq)
+               goto err_handle;
+
+       INIT_WORK(&irq_obj->work, aipu_irq_handler_bottom_half);
+
+       ret =3D request_irq(irqnum, aipu_irq_handler_upper_half, IRQF_SHARE=
D,
+                         description, irq_obj->dev);
+       if (ret)
+               goto err_handle;
+
+       irq_obj->irqnum =3D irqnum;
+       irq_obj->core =3D core;
+
+       goto finish;
+
+err_handle:
+       aipu_destroy_irq_object(irq_obj);
+       irq_obj =3D NULL;
+
+finish:
+       return irq_obj;
+}
+
+/**
+ * @aipu_destroy_irq_object() - destroy a created aipu_irq_object
+ * @irq_obj: interrupt object created in aipu_create_irq_object()
+ */
+void aipu_destroy_irq_object(struct aipu_irq_object *irq_obj)
+{
+       if (irq_obj) {
+               if (irq_obj->aipu_wq) {
+                       flush_workqueue(irq_obj->aipu_wq);
+                       destroy_workqueue(irq_obj->aipu_wq);
+                       irq_obj->aipu_wq =3D NULL;
+               }
+               if (irq_obj->irqnum)
+                       free_irq(irq_obj->irqnum, irq_obj->dev);
+               kfree(irq_obj);
+               flush_scheduled_work();
+       }
+}
+
+/**
+ * @aipu_irq_schedulework() - workqueue schedule API
+ * @irq_obj: interrupt object created in aipu_create_irq_object()
+ */
+void aipu_irq_schedulework(struct aipu_irq_object *irq_obj)
+{
+       if (irq_obj)
+               queue_work(irq_obj->aipu_wq, &irq_obj->work);
+}
+
+/**
+ * @aipu_irq_flush_workqueue() - workqueue flush API
+ * @irq_obj: interrupt object created in aipu_create_irq_object()
+ */
+void aipu_irq_flush_workqueue(struct aipu_irq_object *irq_obj)
+{
+       flush_workqueue(irq_obj->aipu_wq);
+}
diff --git a/drivers/misc/armchina-npu/aipu_irq.h b/drivers/misc/armchina-n=
pu/aipu_irq.h
new file mode 100644
index 000000000000..25a426810d8c
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_irq.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_IRQ_H__
+#define __AIPU_IRQ_H__
+
+#include <linux/device.h>
+#include <linux/workqueue.h>
+
+typedef int  (*aipu_irq_uhandler_t) (void *arg);
+typedef void (*aipu_irq_bhandler_t) (void *arg);
+typedef void (*aipu_irq_trigger_t) (void *arg);
+typedef void (*aipu_irq_ack_t) (void *arg);
+
+/**
+ * struct aipu_irq_object - interrupt object for every single AIPU core
+ * @irqnum:  interrupt number used to request IRQ
+ * @core:    aipu core struct pointer
+ * @work:    work struct
+ * @dev:     device pointer
+ * @aipu_wq: workqueue struct pointer
+ */
+struct aipu_irq_object {
+       u32 irqnum;
+       void *core;
+       struct work_struct  work;
+       struct device *dev;
+       struct workqueue_struct *aipu_wq;
+};
+
+struct aipu_irq_object *aipu_create_irq_object(u32 irqnum, void *core, cha=
r *description);
+void aipu_irq_schedulework(struct aipu_irq_object *irq_obj);
+void aipu_irq_flush_workqueue(struct aipu_irq_object *irq_obj);
+void aipu_destroy_irq_object(struct aipu_irq_object *irq_obj);
+
+#endif /* __AIPU_IRQ_H__ */
diff --git a/drivers/misc/armchina-npu/aipu_job_manager.c b/drivers/misc/ar=
mchina-npu/aipu_job_manager.c
new file mode 100644
index 000000000000..d6b11b73af29
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_job_manager.c
@@ -0,0 +1,689 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+#include "aipu_job_manager.h"
+#include "aipu_priv.h"
+
+static struct aipu_thread_wait_queue *do_create_thread_wait_queue(int uthr=
ead_id, struct file *filp)
+{
+       struct aipu_thread_wait_queue *new_wait_queue =3D
+               kzalloc(sizeof(*new_wait_queue), GFP_KERNEL);
+
+       if (unlikely(!new_wait_queue))
+               return ERR_PTR(-ENOMEM);
+       new_wait_queue->ref_cnt =3D 0;
+       new_wait_queue->uthread_id =3D uthread_id;
+       new_wait_queue->filp =3D filp;
+       init_waitqueue_head(&new_wait_queue->p_wait);
+       INIT_LIST_HEAD(&new_wait_queue->node);
+       return new_wait_queue;
+}
+
+static struct aipu_thread_wait_queue *get_thread_wait_queue(struct aipu_th=
read_wait_queue *head,
+                                                           int uthread_id,=
 struct file *filp)
+{
+       struct aipu_thread_wait_queue *curr =3D NULL;
+
+       if (unlikely(!head))
+               return ERR_PTR(-EINVAL);
+
+       list_for_each_entry(curr, &head->node, node) {
+               if ((curr->uthread_id =3D=3D uthread_id && uthread_id) ||
+                   (curr->filp =3D=3D filp && filp))
+                       return curr;
+       }
+       return ERR_PTR(-EINVAL);
+}
+
+static struct aipu_thread_wait_queue *create_thread_wait_queue(struct aipu=
_thread_wait_queue *head,
+                                                              int uthread_=
id, struct file *filp)
+{
+       struct aipu_thread_wait_queue *queue =3D get_thread_wait_queue(head=
, uthread_id, filp);
+
+       if (IS_ERR(queue)) {
+               queue =3D do_create_thread_wait_queue(uthread_id, filp);
+               if (!IS_ERR(queue) && head)
+                       list_add_tail(&queue->node, &head->node);
+               else
+                       return queue;
+       }
+
+       queue->ref_cnt++;
+       return queue;
+}
+
+static void delete_wait_queue(struct aipu_thread_wait_queue **wait_queue_h=
ead)
+{
+       struct aipu_thread_wait_queue *curr =3D NULL;
+       struct aipu_thread_wait_queue *next =3D NULL;
+
+       if (wait_queue_head && *wait_queue_head) {
+               list_for_each_entry_safe(curr, next, &(*wait_queue_head)->n=
ode, node) {
+                       list_del(&curr->node);
+                       kfree(curr);
+               }
+               kfree(*wait_queue_head);
+               *wait_queue_head =3D NULL;
+       }
+}
+
+static int init_aipu_job(struct aipu_job *job, struct aipu_job_desc *desc,
+                        struct aipu_thread_wait_queue *queue, struct file =
*filp)
+{
+       if (unlikely(!job))
+               return -EINVAL;
+
+       job->uthread_id =3D task_pid_nr(current);
+       job->filp =3D filp;
+       if (likely(desc))
+               job->desc =3D *desc;
+       else
+               memset(&job->desc, 0, sizeof(job->desc));
+       job->core_id =3D -1;
+       job->thread_queue =3D &queue->p_wait;
+       job->state =3D AIPU_JOB_STATE_IDLE;
+       INIT_LIST_HEAD(&job->node);
+       job->sched_time =3D ns_to_ktime(0);
+       job->done_time =3D ns_to_ktime(0);
+       job->wake_up =3D 0;
+
+       return 0;
+}
+
+static void destroy_aipu_job(struct aipu_job_manager *manager, struct aipu=
_job *job)
+{
+       struct aipu_thread_wait_queue *job_aipu_wait_queue =3D NULL;
+
+       WARN_ON(!job);
+
+       if (likely(job->thread_queue)) {
+               job_aipu_wait_queue =3D
+                       container_of(job->thread_queue, struct aipu_thread_=
wait_queue, p_wait);
+               job_aipu_wait_queue->ref_cnt--;
+       }
+       kmem_cache_free(manager->job_cache, job);
+}
+
+static struct aipu_job *create_aipu_job(struct aipu_job_manager *manager,
+                                       struct aipu_job_desc *desc,
+                                       struct aipu_thread_wait_queue *queu=
e, struct file *filp)
+{
+       int ret =3D 0;
+       struct aipu_job *new_aipu_job =3D NULL;
+
+       new_aipu_job =3D kmem_cache_alloc(manager->job_cache, GFP_KERNEL);
+       if (unlikely(!new_aipu_job))
+               return ERR_PTR(-ENOMEM);
+
+       ret =3D init_aipu_job(new_aipu_job, desc, queue, filp);
+       if (unlikely(ret)) {
+               destroy_aipu_job(manager, new_aipu_job);
+               new_aipu_job =3D NULL;
+               return ERR_PTR(ret);
+       }
+
+       return new_aipu_job;
+}
+
+static void remove_aipu_job(struct aipu_job_manager *manager, struct aipu_=
job *job)
+{
+       WARN_ON(!job);
+       list_del(&job->node);
+       destroy_aipu_job(manager, job);
+}
+
+static void delete_job_queue(struct aipu_job_manager *manager, struct aipu=
_job **head)
+{
+       struct aipu_job *curr =3D NULL;
+       struct aipu_job *next =3D NULL;
+
+       if (head && *head) {
+               list_for_each_entry_safe(curr, next, &(*head)->node, node) =
{
+                       remove_aipu_job(manager, curr);
+               }
+               kmem_cache_free(manager->job_cache, *head);
+               *head =3D NULL;
+       }
+}
+
+inline bool is_job_version_match(struct aipu_core *core, struct aipu_job_d=
esc *user_job)
+{
+       if (core->arch =3D=3D user_job->aipu_arch && user_job->version_comp=
atible)
+               return true;
+
+       return (core->arch =3D=3D user_job->aipu_arch) &&
+               (core->version =3D=3D user_job->aipu_version) &&
+               (core->config =3D=3D user_job->aipu_config);
+}
+
+static bool is_user_job_valid(struct aipu_job_manager *manager, struct aip=
u_job_desc *user_job)
+{
+       int id =3D 0;
+       struct aipu_core *core =3D NULL;
+
+       if (unlikely(!manager || !user_job))
+               return false;
+
+       if (user_job->is_defer_run) {
+               id =3D user_job->core_id;
+               if (id < manager->core_cnt)
+                       return is_job_version_match(manager->cores[id], use=
r_job);
+               return false;
+       }
+
+       for (id =3D 0; id < manager->core_cnt; id++) {
+               core =3D manager->cores[id];
+               if (is_job_version_match(core, user_job))
+                       return true;
+       }
+
+       return false;
+}
+
+static int get_available_core_no_lock(struct aipu_job_manager *manager, st=
ruct aipu_job *job)
+{
+       int id =3D 0;
+       struct aipu_core *core =3D NULL;
+
+       if (unlikely(!manager))
+               return -1;
+
+       for (id =3D 0; id < manager->core_cnt; id++) {
+               core =3D manager->cores[id];
+               if (!atomic_read(&core->disable) && manager->idle_bmap[id] =
&&
+                   is_job_version_match(core, &job->desc))
+                       return id;
+       }
+
+       return -1;
+}
+
+static void reserve_core_for_job_no_lock(struct aipu_job_manager *manager,=
 struct aipu_job *job,
+                                        int do_trigger)
+{
+       struct aipu_core *sched_core =3D NULL;
+
+       WARN_ON(job->core_id < 0);
+       WARN_ON(job->core_id >=3D manager->core_cnt);
+
+       sched_core =3D manager->cores[job->core_id];
+       manager->idle_bmap[job->core_id] =3D 0;
+       if (job->desc.enable_prof) {
+               get_soc_ops(sched_core)->start_bw_profiling(sched_core->dev=
, get_soc(sched_core));
+               job->sched_time =3D ktime_get();
+       }
+
+       if (do_trigger)
+               job->state =3D AIPU_JOB_STATE_RUNNING;
+
+       sched_core->ops->reserve(sched_core, &job->desc, do_trigger);
+
+       if (do_trigger)
+               dev_dbg(sched_core->dev, "[Job %d of Thread %d] trigger job=
 running done\n",
+                       job->desc.job_id, job->uthread_id);
+       else
+               dev_dbg(sched_core->dev, "[Job %d of Thread %d] reserve for=
 deferred job done\n",
+                       job->desc.job_id, job->uthread_id);
+}
+
+static int schedule_new_job(struct aipu_job_manager *manager, struct aipu_=
job_desc *user_job,
+                           struct file *filp, int do_trigger)
+{
+       int ret =3D 0;
+       struct aipu_job *kern_job =3D NULL;
+       struct aipu_thread_wait_queue *queue =3D NULL;
+       unsigned long flags;
+
+       mutex_lock(&manager->wq_lock);
+       if (user_job->enable_poll_opt)
+               queue =3D create_thread_wait_queue(manager->wait_queue_head=
, 0, filp);
+       else
+               queue =3D create_thread_wait_queue(manager->wait_queue_head=
,
+                                                task_pid_nr(current), NULL=
);
+       mutex_unlock(&manager->wq_lock);
+
+       WARN_ON(IS_ERR(queue));
+
+       kern_job =3D create_aipu_job(manager, user_job, queue, filp);
+       if (IS_ERR(kern_job))
+               return PTR_ERR(kern_job);
+
+       spin_lock_irqsave(&manager->lock, flags);
+       if (do_trigger) {
+               kern_job->state =3D AIPU_JOB_STATE_PENDING;
+               list_add_tail(&kern_job->node, &manager->scheduled_head->no=
de);
+
+               /*
+                * For a job using SRAM managed by AIPU Gbuilder, it should=
 be
+                * executed exclusively in serial with other Gbuilder-manag=
ed-SRAM ones,
+                * and parallel scheduling is not allowed.
+                *
+                * Pending it if there has been a Gbuilder-managed-SRAM job=
 running;
+                * otherwise mark the flag and reserve a core for running.
+                */
+               if (kern_job->desc.exec_flag & AIPU_JOB_EXEC_FLAG_SRAM_MUTE=
X) {
+                       if (manager->exec_flag & AIPU_JOB_EXEC_FLAG_SRAM_MU=
TEX)
+                               goto unlock;
+                       else
+                               manager->exec_flag |=3D AIPU_JOB_EXEC_FLAG_=
SRAM_MUTEX;
+               }
+               kern_job->core_id =3D get_available_core_no_lock(manager, k=
ern_job);
+               if (kern_job->core_id >=3D 0)
+                       reserve_core_for_job_no_lock(manager, kern_job, do_=
trigger);
+       } else {
+               if (user_job->core_id >=3D manager->core_cnt ||
+                   !manager->idle_bmap[user_job->core_id]) {
+                       ret =3D -EINVAL;
+                       goto unlock;
+               }
+               kern_job->state =3D AIPU_JOB_STATE_DEFERRED;
+               kern_job->core_id =3D user_job->core_id;
+               list_add_tail(&kern_job->node, &manager->scheduled_head->no=
de);
+               reserve_core_for_job_no_lock(manager, kern_job, do_trigger)=
;
+       }
+unlock:
+       spin_unlock_irqrestore(&manager->lock, flags);
+
+       return ret;
+}
+
+static int trigger_deferred_job_run(struct aipu_job_manager *manager,
+                                   struct aipu_job_desc *user_job)
+{
+       unsigned long flags;
+       struct aipu_job *curr =3D NULL;
+       struct aipu_core *sched_core =3D NULL;
+       int triggered =3D 0;
+
+       spin_lock_irqsave(&manager->lock, flags);
+       list_for_each_entry(curr, &manager->scheduled_head->node, node) {
+               if (curr->uthread_id =3D=3D task_pid_nr(current) &&
+                   curr->desc.job_id =3D=3D user_job->job_id &&
+                   curr->state =3D=3D AIPU_JOB_STATE_DEFERRED) {
+                       curr->state =3D AIPU_JOB_STATE_RUNNING;
+                       sched_core =3D manager->cores[curr->core_id];
+                       sched_core->ops->trigger(sched_core);
+                       triggered =3D 1;
+                       break;
+               }
+       }
+       spin_unlock_irqrestore(&manager->lock, flags);
+
+       if (!triggered)
+               return -EINVAL;
+
+       dev_dbg(sched_core->dev, "[Job %d of Thread %d] trigger deferred jo=
b running done\n",
+               user_job->job_id, task_pid_nr(current));
+       return 0;
+}
+
+/**
+ * @init_aipu_job_manager() - initialize an existing job manager struct du=
ring driver probe phase
+ * @manager: pointer to the struct job_manager struct to be initialized
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int init_aipu_job_manager(struct aipu_job_manager *manager)
+{
+       if (!manager)
+               return -EINVAL;
+
+       manager->is_init =3D 0;
+       manager->core_cnt =3D 0;
+       manager->cores =3D NULL;
+       manager->idle_bmap =3D NULL;
+       manager->job_cache =3D
+               kmem_cache_create("aipu_job_cache", sizeof(struct aipu_job)=
, 0, SLAB_PANIC, NULL);
+       manager->scheduled_head =3D create_aipu_job(manager, NULL, NULL, NU=
LL);
+       INIT_LIST_HEAD(&manager->scheduled_head->node);
+       spin_lock_init(&manager->lock);
+       manager->wait_queue_head =3D create_thread_wait_queue(NULL, 0, NULL=
);
+       mutex_init(&manager->wq_lock);
+       manager->exec_flag =3D 0;
+
+       WARN_ON(IS_ERR(manager->scheduled_head));
+       WARN_ON(IS_ERR(manager->wait_queue_head));
+
+       manager->is_init =3D 1;
+       return 0;
+}
+
+/**
+ * @deinit_aipu_job_manager() - de-init the job manager
+ * @manager: pointer to the struct job_manager initialized in init_aipu_jo=
b_manager()
+ */
+void deinit_aipu_job_manager(struct aipu_job_manager *manager)
+{
+       if (!manager || !manager->is_init)
+               return;
+
+       kfree(manager->idle_bmap);
+       manager->idle_bmap =3D NULL;
+       delete_job_queue(manager, &manager->scheduled_head);
+       delete_wait_queue(&manager->wait_queue_head);
+       mutex_destroy(&manager->wq_lock);
+       kmem_cache_destroy(manager->job_cache);
+       manager->job_cache =3D NULL;
+       manager->is_init =3D 0;
+}
+
+/**
+ * @aipu_job_manager_set_cores_info() - set multicore info. while probing
+ * @manager:  pointer to the struct job_manager initialized in init_aipu_j=
ob_manager()
+ * @core_cnt: AIPU core count
+ * @cores:    pointer to AIPU core struct array
+ */
+void aipu_job_manager_set_cores_info(struct aipu_job_manager *manager, int=
 core_cnt,
+                                    struct aipu_core **cores)
+{
+       WARN_ON(!manager || !core_cnt || !cores);
+       manager->core_cnt =3D core_cnt;
+       manager->cores =3D cores;
+       kfree(manager->idle_bmap);
+       manager->idle_bmap =3D kmalloc_array(core_cnt, sizeof(bool), GFP_KE=
RNEL);
+       memset(manager->idle_bmap, 1, core_cnt);
+}
+
+/**
+ * @aipu_job_manager_scheduler() - schedule a job flushed from userland
+ * @manager:  pointer to the struct job_manager initialized in init_aipu_j=
ob_manager()
+ * @user_job: pointer to the userspace job descriptor
+ * @filp:     pointer to the device char file
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_job_manager_scheduler(struct aipu_job_manager *manager, struct ai=
pu_job_desc *user_job,
+                              struct file *filp)
+{
+       int ret =3D 0;
+
+       if (unlikely(!manager || !user_job || !filp))
+               return -EINVAL;
+
+       if (unlikely(!is_user_job_valid(manager, user_job)))
+               return -EINVAL;
+
+       if (!user_job->is_defer_run)
+               ret =3D schedule_new_job(manager, user_job, filp, 1);
+       else if (!user_job->do_trigger)
+               ret =3D schedule_new_job(manager, user_job, filp, 0);
+       else
+               ret =3D trigger_deferred_job_run(manager, user_job);
+
+       return ret;
+}
+
+/**
+ * @aipu_job_manager_irq_upper_half() - aipu interrupt upper half handler
+ * @core:           pointer to the aipu core struct
+ * @exception_flag: exception flag
+ */
+void aipu_job_manager_irq_upper_half(struct aipu_core *core, int exception=
_flag)
+{
+       struct aipu_job *curr =3D NULL;
+       struct aipu_job_manager *manager =3D NULL;
+       int handled =3D 0;
+       int triggered =3D 0;
+
+       if (unlikely(!core))
+               return;
+
+       manager =3D get_job_manager(core);
+
+       spin_lock(&manager->lock);
+       list_for_each_entry(curr, &manager->scheduled_head->node, node) {
+               if (curr->core_id =3D=3D core->id && curr->state =3D=3D AIP=
U_JOB_STATE_RUNNING) {
+                       if (unlikely(exception_flag))
+                               curr->state =3D AIPU_JOB_STATE_EXCEP;
+                       else
+                               curr->state =3D AIPU_JOB_STATE_SUCCESS;
+
+                       if (curr->desc.enable_prof) {
+                               curr->done_time =3D ktime_get();
+                               get_soc_ops(core)->stop_bw_profiling(core->=
dev, get_soc(core));
+                               get_soc_ops(core)->read_profiling_reg(core-=
>dev,
+                                                                     get_s=
oc(core), &curr->pdata);
+                       }
+
+                       if (curr->desc.exec_flag & AIPU_JOB_EXEC_FLAG_SRAM_=
MUTEX)
+                               manager->exec_flag &=3D ~AIPU_JOB_EXEC_FLAG=
_SRAM_MUTEX;
+
+                       handled =3D 1;
+                       break;
+               }
+       }
+
+       /* handled =3D=3D false means a job was invalidated before done */
+
+       if (!atomic_read(&core->disable)) {
+               list_for_each_entry(curr, &manager->scheduled_head->node, n=
ode) {
+                       if (curr->state =3D=3D AIPU_JOB_STATE_PENDING &&
+                           is_job_version_match(core, &curr->desc)) {
+                               if (curr->desc.exec_flag & AIPU_JOB_EXEC_FL=
AG_SRAM_MUTEX) {
+                                       if (manager->exec_flag & AIPU_JOB_E=
XEC_FLAG_SRAM_MUTEX)
+                                               continue;
+                                       else
+                                               manager->exec_flag |=3D AIP=
U_JOB_EXEC_FLAG_SRAM_MUTEX;
+                               }
+                               curr->core_id =3D core->id;
+                               reserve_core_for_job_no_lock(manager, curr,=
 1);
+                               triggered =3D 1;
+                               break;
+                       }
+               }
+       }
+
+       if (!triggered)
+               manager->idle_bmap[core->id] =3D 1;
+       spin_unlock(&manager->lock);
+}
+
+/**
+ * @aipu_job_manager_irq_bottom_half() - aipu interrupt bottom half handle=
r
+ * @core: pointer to the aipu core struct
+ */
+void aipu_job_manager_irq_bottom_half(struct aipu_core *core)
+{
+       struct aipu_job *curr =3D NULL;
+       struct aipu_job *next =3D NULL;
+       struct aipu_job_manager *manager =3D NULL;
+       unsigned long flags;
+
+       if (unlikely(!core))
+               return;
+
+       manager =3D get_job_manager(core);
+
+       spin_lock_irqsave(&manager->lock, flags);
+       list_for_each_entry_safe(curr, next, &manager->scheduled_head->node=
, node) {
+               if (curr->state >=3D AIPU_JOB_STATE_EXCEP && !curr->wake_up=
 &&
+                   curr->core_id =3D=3D core->id) {
+                       if (curr->desc.enable_prof)
+                               curr->pdata.execution_time_ns =3D
+                                 (long)ktime_to_ns(ktime_sub(curr->done_ti=
me, curr->sched_time));
+                       wake_up_interruptible(curr->thread_queue);
+                       curr->wake_up =3D 1;
+               }
+       }
+       spin_unlock_irqrestore(&manager->lock, flags);
+}
+
+/**
+ * @aipu_job_manager_cancel_jobs() - cancel all jobs flushed for certain u=
ser closing fd
+ * @param manager: pointer to the struct job_manager initialized in init_a=
ipu_job_manager()
+ * @param filp: file struct pointer
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_job_manager_cancel_jobs(struct aipu_job_manager *manager, struct =
file *filp)
+{
+       unsigned long flags;
+       struct aipu_job *curr =3D NULL;
+       struct aipu_job *next =3D NULL;
+       struct aipu_thread_wait_queue *curr_wq =3D NULL;
+       struct aipu_thread_wait_queue *next_wq =3D NULL;
+
+       if (!manager || !filp)
+               return -EINVAL;
+
+       /* jobs should be cleaned first */
+       spin_lock_irqsave(&manager->lock, flags);
+       list_for_each_entry_safe(curr, next, &manager->scheduled_head->node=
, node) {
+               if (curr->filp =3D=3D filp) {
+                       if (curr->state =3D=3D AIPU_JOB_STATE_DEFERRED)
+                               manager->idle_bmap[curr->core_id] =3D 1;
+                       remove_aipu_job(manager, curr);
+               }
+       }
+       spin_unlock_irqrestore(&manager->lock, flags);
+
+       mutex_lock(&manager->wq_lock);
+       list_for_each_entry_safe(curr_wq, next_wq, &manager->wait_queue_hea=
d->node, node) {
+               if (!curr_wq->ref_cnt) {
+                       list_del(&curr_wq->node);
+                       kfree(curr_wq);
+               }
+       }
+       mutex_unlock(&manager->wq_lock);
+
+       return 0;
+}
+
+/**
+ * @aipu_job_manager_invalidate_timeout_job() - invalidate/kill a timeout =
job
+ * @manager: pointer to the struct job_manager initialized in init_aipu_jo=
b_manager()
+ * @job_id:  job ID
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_job_manager_invalidate_timeout_job(struct aipu_job_manager *manag=
er, int job_id)
+{
+       int ret =3D 0;
+       struct aipu_job *curr =3D NULL;
+       struct aipu_job *next =3D NULL;
+       unsigned long flags;
+
+       if (!manager)
+               return -EINVAL;
+
+       spin_lock_irqsave(&manager->lock, flags);
+       list_for_each_entry_safe(curr, next, &manager->scheduled_head->node=
, node) {
+               if (curr->uthread_id =3D=3D task_pid_nr(current) &&
+                   curr->desc.job_id =3D=3D job_id) {
+                       remove_aipu_job(manager, curr);
+                       break;
+               }
+       }
+       spin_unlock_irqrestore(&manager->lock, flags);
+
+       return ret;
+}
+
+/**
+ * @aipu_job_manager_get_job_status() - get AIPU jobs' statuses after a po=
lling event returns
+ * @manager: pointer to the struct job_manager initialized in init_aipu_jo=
b_manager()
+ * @job_status: job status array stores statuys info filled by this API
+ * @filp: file struct pointer
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_job_manager_get_job_status(struct aipu_job_manager *manager,
+                                   struct aipu_job_status_query *job_statu=
s, struct file *filp)
+{
+       int ret =3D 0;
+       struct aipu_job_status_desc *status =3D NULL;
+       struct aipu_job *curr =3D NULL;
+       struct aipu_job *next =3D NULL;
+       int poll_iter =3D 0;
+       unsigned long flags;
+
+       if (unlikely(!manager || !job_status || job_status->max_cnt < 1))
+               return -EINVAL;
+
+       status =3D kcalloc(job_status->max_cnt, sizeof(*status), GFP_KERNEL=
);
+       if (!status)
+               return -ENOMEM;
+
+       job_status->poll_cnt =3D 0;
+       spin_lock_irqsave(&manager->lock, flags);
+       list_for_each_entry_safe(curr, next, &manager->scheduled_head->node=
, node) {
+               if (job_status->poll_cnt =3D=3D job_status->max_cnt)
+                       break;
+
+               if (curr->state < AIPU_JOB_STATE_EXCEP)
+                       continue;
+
+               if (curr->filp !=3D filp)
+                       continue;
+
+               if ((job_status->of_this_thread && curr->uthread_id =3D=3D =
task_pid_nr(current)) ||
+                   !job_status->of_this_thread) {
+                       status[poll_iter].job_id =3D curr->desc.job_id;
+                       status[poll_iter].thread_id =3D curr->uthread_id;
+                       status[poll_iter].state =3D (curr->state =3D=3D AIP=
U_JOB_STATE_SUCCESS) ?
+                           AIPU_JOB_STATE_DONE : AIPU_JOB_STATE_EXCEPTION;
+                       if (curr->desc.enable_prof)
+                               status[poll_iter].pdata =3D curr->pdata;
+
+                       remove_aipu_job(manager, curr);
+                       curr =3D NULL;
+
+                       job_status->poll_cnt++;
+                       poll_iter++;
+               }
+       }
+       spin_unlock_irqrestore(&manager->lock, flags);
+
+       ret =3D copy_to_user((struct job_status_desc __user *)job_status->s=
tatus, status,
+                          job_status->poll_cnt * sizeof(*status));
+
+       kfree(status);
+       return ret;
+}
+
+/**
+ * @aipu_job_manager_has_end_job() - check if a user thread has end job(s)=
 to query
+ * @manager: pointer to the struct job_manager initialized in init_aipu_jo=
b_manager()
+ * @filp: file struct pointer
+ * @wait: wait table struct from kernel
+ * @uthread_id: thread ID
+ *
+ * Return: true if there is/are AIPU job(s) done and false otherwise.
+ */
+bool aipu_job_manager_has_end_job(struct aipu_job_manager *manager, struct=
 file *filp,
+                                 struct poll_table_struct *wait, int uthre=
ad_id)
+{
+       bool ret =3D false;
+       struct aipu_job *curr =3D NULL;
+       struct aipu_thread_wait_queue *wq =3D NULL;
+       unsigned long flags;
+
+       if (unlikely(!manager || !filp))
+               return -EINVAL;
+
+       mutex_lock(&manager->wq_lock);
+       list_for_each_entry(wq, &manager->wait_queue_head->node, node) {
+               if (wq->uthread_id =3D=3D uthread_id || wq->filp =3D=3D fil=
p) {
+                       poll_wait(filp, &wq->p_wait, wait);
+                       break;
+               }
+       }
+       mutex_unlock(&manager->wq_lock);
+
+       spin_lock_irqsave(&manager->lock, flags);
+       list_for_each_entry(curr, &manager->scheduled_head->node, node) {
+               if (curr->filp =3D=3D filp &&
+                   curr->state >=3D AIPU_JOB_STATE_EXCEP &&
+                   (curr->desc.enable_poll_opt || curr->uthread_id =3D=3D =
uthread_id)) {
+                       ret =3D true;
+                       break;
+               }
+       }
+       spin_unlock_irqrestore(&manager->lock, flags);
+
+       return ret;
+}
diff --git a/drivers/misc/armchina-npu/aipu_job_manager.h b/drivers/misc/ar=
mchina-npu/aipu_job_manager.h
new file mode 100644
index 000000000000..7a36464986e5
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_job_manager.h
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_JOB_MANAGER_H__
+#define __AIPU_JOB_MANAGER_H__
+
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <uapi/misc/armchina_aipu.h>
+#include "aipu_core.h"
+
+enum aipu_state_kern {
+       AIPU_JOB_STATE_IDLE,
+       AIPU_JOB_STATE_PENDING,
+       AIPU_JOB_STATE_DEFERRED,
+       AIPU_JOB_STATE_RUNNING,
+       AIPU_JOB_STATE_EXCEP,
+       AIPU_JOB_STATE_SUCCESS
+};
+
+/**
+ * struct waitqueue - maintain the waitqueue for a user thread
+ * @uthread_id: user thread owns this waitqueue
+ * @filp: file struct pointer
+ * @ref_cnt: struct reference count
+ * @p_wait: wait queue head for polling
+ * @node: list head struct
+ */
+struct aipu_thread_wait_queue {
+       int uthread_id;
+       struct file *filp;
+       int ref_cnt;
+       wait_queue_head_t p_wait;
+       struct list_head node;
+};
+
+/**
+ * struct aipu_job - job struct describing a job under scheduling in job m=
anager
+ *        Job status will be tracked as soon as interrupt or user evenets =
come in.
+ * @uthread_id: ID of user thread scheduled this job
+ * @filp: file struct pointer used when scheduling this job
+ * @desc: job descriptor from userland
+ * @core_id: ID of an aipu core this job scheduled on
+ * @thread_queue: wait queue of this job to be waken up
+ * @state: job state
+ * @node: list node
+ * @sched_time: job scheduled time (enabled by profiling flag in desc)
+ * @done_time: job termination time (enabled by profiling flag in desc)
+ * @pdata: profiling data (enabled by profiling flag in desc)
+ * @wake_up: wake up flag
+ */
+struct aipu_job {
+       int uthread_id;
+       struct file *filp;
+       struct aipu_job_desc desc;
+       int core_id;
+       wait_queue_head_t *thread_queue;
+       int state;
+       struct list_head node;
+       ktime_t sched_time;
+       ktime_t done_time;
+       struct aipu_ext_profiling_data pdata;
+       int wake_up;
+};
+
+/**
+ * struct aipu_job_manager - job manager
+ *        Maintain all jobs and update their statuses
+ * @core_cnt: aipu core count
+ * @cores: aipu core struct pointer array
+ * @idle_bmap: idle flag bitmap for every core
+ * @scheduled_head: scheduled job list head
+ * @lock: spinlock
+ * @wait_queue_head: wait queue list head
+ * @wq_lock: waitqueue lock
+ * @job_cache: slab cache of aipu_job
+ * @is_init: init flag
+ * @exec_flag: execution flags propagated to all jobs
+ */
+struct aipu_job_manager {
+       int core_cnt;
+       struct aipu_core **cores;
+       bool *idle_bmap;
+       struct aipu_job *scheduled_head;
+       spinlock_t lock; /* Protect cores and jobs status */
+       struct aipu_thread_wait_queue *wait_queue_head;
+       struct mutex wq_lock; /* Protect thread wait queue */
+       struct kmem_cache *job_cache;
+       int is_init;
+       int exec_flag;
+};
+
+int init_aipu_job_manager(struct aipu_job_manager *manager);
+void deinit_aipu_job_manager(struct aipu_job_manager *manager);
+void aipu_job_manager_set_cores_info(struct aipu_job_manager *manager, int=
 core_cnt,
+                                    struct aipu_core **cores);
+int aipu_job_manager_scheduler(struct aipu_job_manager *manager, struct ai=
pu_job_desc *user_job,
+                              struct file *filp);
+void aipu_job_manager_irq_upper_half(struct aipu_core *core, int exception=
_flag);
+void aipu_job_manager_irq_bottom_half(struct aipu_core *core);
+int aipu_job_manager_cancel_jobs(struct aipu_job_manager *manager, struct =
file *filp);
+int aipu_job_manager_invalidate_timeout_job(struct aipu_job_manager *manag=
er, int job_id);
+int aipu_job_manager_get_job_status(struct aipu_job_manager *manager,
+                                   struct aipu_job_status_query *job_statu=
s, struct file *filp);
+bool aipu_job_manager_has_end_job(struct aipu_job_manager *manager, struct=
 file *filp,
+                                 struct poll_table_struct *wait, int uthre=
ad_id);
+
+#endif /* __AIPU_JOB_MANAGER_H__ */
diff --git a/drivers/misc/armchina-npu/aipu_mm.c b/drivers/misc/armchina-np=
u/aipu_mm.c
new file mode 100644
index 000000000000..ce6e31b95107
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_mm.c
@@ -0,0 +1,740 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/mm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/of_iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/iommu.h>
+#include <linux/bitmap.h>
+#include <linux/version.h>
+#include "config.h"
+#include "aipu_priv.h"
+#include "aipu_mm.h"
+
+static struct device *aipu_mm_create_child_sramdev(struct device *dev)
+{
+       struct device *child =3D NULL;
+
+       child =3D devm_kzalloc(dev, sizeof(*child), GFP_KERNEL);
+       if (!child)
+               return NULL;
+
+       device_initialize(child);
+       dev_set_name(child, "%s:%s", dev_name(dev), "sram-child");
+       child->parent =3D dev;
+       child->coherent_dma_mask =3D dev->coherent_dma_mask;
+       child->dma_mask =3D dev->dma_mask;
+       child->dma_parms =3D devm_kzalloc(dev, sizeof(*child->dma_parms),
+                                       GFP_KERNEL);
+       child->bus =3D dev->bus;
+       if (!child->dma_parms)
+               goto err;
+
+       if (!device_add(child))
+               return child;
+       device_del(child);
+
+err:
+       put_device(child);
+       return NULL;
+}
+
+static int aipu_mm_init_pages(struct aipu_memory_manager *mm, int id)
+{
+       struct aipu_mem_region *reg =3D NULL;
+
+       if (!mm || id >=3D AIPU_MEM_REGION_MAX_ID)
+               return -EINVAL;
+
+       reg =3D &mm->reg[id];
+
+       reg->count =3D reg->bytes >> PAGE_SHIFT;
+       reg->bitmap =3D devm_kzalloc(reg->dev,
+                                  BITS_TO_LONGS(reg->count) * sizeof(long)=
, GFP_KERNEL);
+       if (!reg->bitmap)
+               return -ENOMEM;
+
+       reg->pages =3D vzalloc(reg->count * sizeof(struct aipu_virt_page *)=
);
+       if (!reg->pages)
+               return -ENOMEM;
+
+       return 0;
+}
+
+static int aipu_mm_init_mem_region(struct aipu_memory_manager *mm, int id)
+{
+       int ret =3D 0;
+       void *va =3D NULL;
+       struct aipu_mem_region *reg =3D NULL;
+       bool enable_iommu =3D false;
+
+       if (!mm || id >=3D AIPU_MEM_REGION_MAX_ID)
+               return -EINVAL;
+
+       reg =3D &mm->reg[id];
+
+       if (!reg->bytes &&
+           reg->type !=3D AIPU_MEM_TYPE_CMA_DEFAULT &&
+           reg->type !=3D AIPU_MEM_TYPE_KERNEL)
+               return 0;
+
+       if (id =3D=3D AIPU_MEM_REGION_DRAM_ID)
+               reg->dev =3D mm->dev;
+       else
+               reg->dev =3D aipu_mm_create_child_sramdev(mm->dev);
+
+       if (!reg->dev)
+               return -ENODEV;
+
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DEV_RESERVED ||
+           reg->type =3D=3D AIPU_MEM_TYPE_DMA_RESERVED ||
+           (!mm->has_iommu && reg->type =3D=3D AIPU_MEM_TYPE_CMA_RESERVED)=
) {
+               u64 upper =3D reg->base_pa + reg->bytes - mm->host_aipu_off=
set;
+
+               /*
+                * Z1 only accepts 0~3G region;
+                * Z2/3 has ASE registers therefore accepts 0~3G for lower =
32 bits;
+                */
+               if (mm->version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V2 ||
+                   mm->version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V3)
+                       upper &=3D U32_MAX;
+
+               if (upper > mm->limit) {
+                       dev_err(reg->dev,
+                               "region is beyond valid region used by AIPU=
 (0x%llx > 0x%llx)\n",
+                               upper, mm->limit);
+                       ret =3D -EINVAL;
+                       goto err;
+               }
+       }
+
+       /* allocate iova for userland anyway regardless of with/without IOM=
MU */
+
+       /* Native reserved */
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DEV_RESERVED) {
+               va =3D memremap(reg->base_pa, reg->bytes, MEMREMAP_WT);
+               if (!va) {
+                       ret =3D -EINVAL;
+                       goto err;
+               }
+
+               reg->base_va =3D va;
+               reg->base_iova =3D reg->base_pa;
+               goto init_page;
+       }
+
+       /* DMA/CMA reserved */
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DMA_RESERVED || reg->type =3D=3D=
 AIPU_MEM_TYPE_CMA_RESERVED) {
+               ret =3D of_reserved_mem_device_init_by_idx(reg->dev, mm->de=
v->of_node, id);
+               if (ret) {
+                       dev_err(mm->dev, "init reserved mem failed: idx %d,=
 ret %d\n",
+                               id, ret);
+                       goto err;
+               }
+       }
+
+       if (mm->has_iommu &&
+           (reg->type =3D=3D AIPU_MEM_TYPE_CMA_RESERVED || reg->type =3D=
=3D AIPU_MEM_TYPE_KERNEL)) {
+               ret =3D dma_set_coherent_mask(reg->dev, DMA_BIT_MASK(31));
+               if (ret) {
+                       dev_err(mm->dev, "DMA set coherent mask failed: %d!=
\n", ret);
+                       goto err;
+               }
+               enable_iommu =3D true;
+       }
+
+       if (mm->has_iommu && reg->type =3D=3D AIPU_MEM_TYPE_CMA_RESERVED)
+               reg->attrs =3D DMA_ATTR_FORCE_CONTIGUOUS;
+       else
+               reg->attrs =3D 0;
+
+       if (reg->type =3D=3D AIPU_MEM_TYPE_KERNEL ||
+           reg->type =3D=3D AIPU_MEM_TYPE_CMA_DEFAULT ||
+           AIPU_CONFIG_USE_DRAM_DEFAULT_SIZE =3D=3D 1)
+               reg->bytes =3D AIPU_CONFIG_DRAM_DEFAULT_SIZE;
+
+       va =3D dma_alloc_attrs(reg->dev, reg->bytes, &reg->base_iova, GFP_K=
ERNEL, reg->attrs);
+       if (!va) {
+               dev_err(reg->dev, "dma_alloc_attrs failed (bytes: 0x%llx, a=
ttrs %ld)\n",
+                       reg->bytes, reg->attrs);
+               ret =3D -EINVAL;
+               goto err;
+       }
+       reg->base_va =3D va;
+
+init_page:
+       ret =3D aipu_mm_init_pages(mm, id);
+       if (ret)
+               goto err;
+
+       reg->base_pfn =3D PFN_DOWN(reg->base_iova);
+
+       dev_info(reg->dev, "init %s region done: %s [0x%llx, 0x%llx]\n",
+                id ? "SRAM" : "DRAM",
+                enable_iommu ? "iova" : "pa",
+                reg->base_iova, reg->base_iova + reg->bytes - 1);
+       goto finish;
+
+err:
+       if (reg->base_va) {
+               if (reg->type =3D=3D AIPU_MEM_TYPE_DEV_RESERVED)
+                       memunmap(reg->base_va);
+               else
+                       dma_free_attrs(reg->dev, reg->bytes, reg->base_va, =
reg->base_iova,
+                                      reg->attrs);
+               reg->base_va =3D NULL;
+       }
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DMA_RESERVED || reg->type =3D=3D=
 AIPU_MEM_TYPE_CMA_RESERVED)
+               of_reserved_mem_device_release(reg->dev);
+       if (reg->dev && reg->dev !=3D mm->dev) {
+               device_del(reg->dev);
+               reg->dev =3D NULL;
+       }
+
+finish:
+       return ret;
+}
+
+static void aipu_mm_deinit_mem_region(struct aipu_memory_manager *mm, int =
id)
+{
+       struct aipu_mem_region *reg =3D &mm->reg[id];
+
+       if (!reg->bytes || !reg->base_va)
+               return;
+
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DEV_RESERVED)
+               memunmap(reg->base_va);
+       else
+               dma_free_attrs(reg->dev, reg->bytes, reg->base_va, reg->bas=
e_iova, reg->attrs);
+
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DMA_RESERVED || reg->type =3D=3D=
 AIPU_MEM_TYPE_CMA_RESERVED)
+               of_reserved_mem_device_release(reg->dev);
+
+       vfree(reg->pages);
+
+       reg->bytes =3D 0;
+       reg->base_va =3D NULL;
+
+       if (reg->dev && reg->dev !=3D mm->dev) {
+               device_del(reg->dev);
+               reg->dev =3D NULL;
+       }
+}
+
+static int aipu_mm_alloc_in_region_no_lock(struct aipu_memory_manager *mm,
+                                          struct aipu_buf_request *buf_req=
,
+                                          struct aipu_mem_region *reg, str=
uct file *filp)
+{
+       unsigned long align_order =3D 0;
+       unsigned long mask =3D 0;
+       unsigned long offset =3D 0;
+       unsigned long bitmap_no =3D 0;
+       unsigned long alloc_nr =3D 0;
+
+       if (!mm || !buf_req || !reg || !filp)
+               return -EINVAL;
+
+       alloc_nr =3D ALIGN(buf_req->bytes, PAGE_SIZE) >> PAGE_SHIFT;
+       align_order =3D order_base_2(buf_req->align_in_page);
+       mask =3D (1UL << align_order) - 1;
+       offset =3D reg->base_pfn & ((1UL << align_order) - 1);
+       bitmap_no =3D
+               bitmap_find_next_zero_area_off(reg->bitmap, reg->count, 0, =
alloc_nr, mask, offset);
+       if (bitmap_no >=3D reg->count)
+               return -ENOMEM;
+
+       bitmap_set(reg->bitmap, bitmap_no, alloc_nr);
+       if (!reg->pages[bitmap_no]) {
+               reg->pages[bitmap_no] =3D
+                       devm_kzalloc(reg->dev, sizeof(struct aipu_virt_page=
), GFP_KERNEL);
+               if (!reg->pages[bitmap_no])
+                       return -ENOMEM;
+       }
+       reg->pages[bitmap_no]->contiguous_alloc_len =3D alloc_nr;
+       reg->pages[bitmap_no]->filp =3D filp;
+       reg->pages[bitmap_no]->tid =3D task_pid_nr(current);
+
+       buf_req->desc.dev_offset =3D reg->base_iova + (bitmap_no << PAGE_SH=
IFT);
+       buf_req->desc.pa =3D buf_req->desc.dev_offset - mm->host_aipu_offse=
t;
+       buf_req->desc.bytes =3D alloc_nr * PAGE_SIZE;
+
+       dev_dbg(reg->dev,
+               "[MM] allocation done: iova 0x%llx, bytes 0x%llx, align_pag=
es %lu, map_num =3D %d\n",
+               buf_req->desc.pa, buf_req->desc.bytes, align_order,
+               reg->pages[bitmap_no]->map_num);
+
+       return 0;
+}
+
+static int aipu_mm_free_in_region_no_lock(struct aipu_memory_manager *mm,
+                                         struct aipu_buf_desc *buf, struct=
 aipu_mem_region *reg,
+                                         struct file *filp)
+{
+       unsigned long bitmap_no =3D 0;
+       unsigned long alloc_nr =3D 0;
+       struct aipu_virt_page *page =3D NULL;
+
+       if (!mm || !buf || !reg || !filp)
+               return -EINVAL;
+
+       bitmap_no =3D (buf->pa + mm->host_aipu_offset - reg->base_iova) >> =
PAGE_SHIFT;
+       if (bitmap_no >=3D reg->count)
+               return -EINVAL;
+
+       page =3D reg->pages[bitmap_no];
+       if (!page)
+               return -EINVAL;
+
+       alloc_nr =3D page->contiguous_alloc_len;
+       if (page->filp !=3D filp || !alloc_nr)
+               return -EINVAL;
+
+       bitmap_clear(reg->bitmap, bitmap_no, alloc_nr);
+       memset(page, 0, sizeof(struct aipu_virt_page));
+
+       dev_dbg(reg->dev, "[MM] free done: iova 0x%llx, bytes 0x%llx\n", bu=
f->pa, buf->bytes);
+
+       return 0;
+}
+
+static struct aipu_mem_region *aipu_mm_find_region(struct aipu_memory_mana=
ger *mm, u64 iova)
+{
+       int i =3D 0;
+
+       for (i =3D AIPU_MEM_REGION_DRAM_ID; i < AIPU_MEM_REGION_MAX_ID; i++=
) {
+               if (iova >=3D mm->reg[i].base_iova &&
+                   (iova < mm->reg[i].base_iova + mm->reg[i].bytes))
+                       return &mm->reg[i];
+       }
+
+       return NULL;
+}
+
+static void aipu_mm_free_filp_in_region(struct aipu_memory_manager *mm,
+                                       struct aipu_mem_region *reg, struct=
 file *filp)
+{
+       unsigned long i =3D 0;
+       unsigned long offset =3D 0;
+
+       if (!mm || !reg || !reg->bitmap || !filp)
+               return;
+
+       mutex_lock(&mm->lock);
+       while ((i =3D find_next_bit(reg->bitmap, reg->count, offset)) !=3D =
reg->count) {
+               offset =3D i + reg->pages[i]->contiguous_alloc_len;
+               if (reg->pages[i] && reg->pages[i]->filp =3D=3D filp) {
+                       bitmap_clear(reg->bitmap, i, reg->pages[i]->contigu=
ous_alloc_len);
+                       memset(reg->pages[i], 0, sizeof(struct aipu_virt_pa=
ge));
+               }
+       }
+       mutex_unlock(&mm->lock);
+}
+
+static struct aipu_virt_page *aipu_mm_find_page(struct aipu_memory_manager=
 *mm,
+                                               struct aipu_mem_region *reg=
,
+                                               struct file *filp, u64 iova=
)
+{
+       unsigned long page_no =3D 0;
+       struct aipu_virt_page *page =3D NULL;
+
+       if (!mm || !reg || !filp || (iova % PAGE_SIZE))
+               return NULL;
+
+       page_no =3D (iova - reg->base_iova) >> PAGE_SHIFT;
+       if (page_no >=3D reg->count)
+               return NULL;
+
+       page =3D reg->pages[page_no];
+       if (!page || page->map_num || page->filp !=3D filp)
+               return NULL;
+
+       return page;
+}
+
+/**
+ * @aipu_init_mm() - initialize mm module during driver probe phase
+ * @mm:      pointer to memory manager struct to be initialized
+ * @p_dev:   pointer to the platform device struct
+ * @version: AIPU ISA version
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_init_mm(struct aipu_memory_manager *mm, struct platform_device *p=
_dev, int version)
+{
+       int ret =3D 0;
+       int reg_id =3D 0;
+       struct iommu_group *group =3D NULL;
+       struct device_node *np =3D NULL;
+       struct resource res;
+       bool bypass_iommu =3D false;
+
+       if (!mm || !p_dev)
+               return -EINVAL;
+
+       memset(mm, 0, sizeof(*mm));
+       mm->version =3D version;
+       mm->limit =3D 0xC0000000;
+       mm->dev =3D &p_dev->dev;
+       mutex_init(&mm->lock);
+       mm->sram_dft_dtype =3D AIPU_MM_DATA_TYPE_NONE;
+       mm->sram_disable =3D false;
+       mm->sram_disable_head =3D devm_kzalloc(mm->dev, sizeof(*mm->sram_di=
sable_head), GFP_KERNEL);
+       if (!mm->sram_disable_head)
+               return -ENOMEM;
+       INIT_LIST_HEAD(&mm->sram_disable_head->list);
+
+       if (of_property_read_u64(mm->dev->of_node, "host-aipu-offset", &mm-=
>host_aipu_offset))
+               mm->host_aipu_offset =3D 0;
+
+       group =3D iommu_group_get(mm->dev);
+       if (group)
+               mm->has_iommu =3D true;
+       iommu_group_put(group);
+       dev_info(mm->dev, "AIPU is%s behind an IOMMU\n", mm->has_iommu ? ""=
 : " not");
+
+       /*
+        * If AIPU is behind an IOMMU, in devicetree, memory-region attribu=
te of DRAM is optional;
+        * otherwise DRAM must be specified;
+        *
+        * SRAM is always optional and should be specified after DRAM if an=
y;
+        *
+        * KMD accepts at maximum one DRAM memory-region and one SRAM regio=
n;
+        */
+       for (reg_id =3D 0; reg_id < AIPU_MEM_REGION_MAX_ID; reg_id++) {
+               np =3D of_parse_phandle(mm->dev->of_node, "memory-region", =
reg_id);
+               if (!np)
+                       continue;
+
+               if (of_device_is_compatible(np, "shared-dma-pool")) {
+                       if (IS_ENABLED(CONFIG_CMA) && of_property_read_bool=
(np, "reusable")) {
+                               mm->reg[reg_id].type =3D AIPU_MEM_TYPE_CMA_=
RESERVED;
+                               dev_info(mm->dev, "AIPU %s mem type is [CMA=
 reserved]\n",
+                                        reg_id ? "SRAM" : "DRAM");
+                       } else if (of_property_read_bool(np, "no-map")) {
+                               mm->reg[reg_id].type =3D AIPU_MEM_TYPE_DMA_=
RESERVED;
+                               dev_info(mm->dev, "AIPU %s mem type is [DMA=
 reserved]\n",
+                                        reg_id ? "SRAM" : "DRAM");
+                       }
+               } else {
+                       mm->reg[reg_id].type =3D AIPU_MEM_TYPE_DEV_RESERVED=
;
+                       dev_info(mm->dev, "AIPU %s mem type is [Reserved]\n=
",
+                                reg_id ? "SRAM" : "DRAM");
+               }
+
+               if (of_address_to_resource(np, 0, &res)) {
+                       of_node_put(np);
+                       return -EINVAL;
+               }
+
+               mm->reg[reg_id].base_pa =3D res.start;
+               mm->reg[reg_id].bytes =3D res.end - res.start + 1;
+               of_node_put(np);
+       }
+
+       if (!mm->reg[AIPU_MEM_REGION_DRAM_ID].bytes) {
+               if (mm->has_iommu) {
+                       mm->reg[AIPU_MEM_REGION_DRAM_ID].type =3D AIPU_MEM_=
TYPE_KERNEL;
+                       dev_info(mm->dev, "AIPU DRAM mem type is [Kernel]\n=
");
+               } else {
+                       mm->reg[AIPU_MEM_REGION_DRAM_ID].type =3D AIPU_MEM_=
TYPE_CMA_DEFAULT;
+                       dev_info(mm->dev, "AIPU DRAM mem type is [CMA defau=
lt]\n");
+               }
+       }
+
+       if (mm->has_iommu &&
+           mm->reg[AIPU_MEM_REGION_DRAM_ID].type =3D=3D AIPU_MEM_TYPE_CMA_=
RESERVED &&
+           (mm->reg[AIPU_MEM_REGION_SRAM_ID].type =3D=3D AIPU_MEM_TYPE_DEV=
_RESERVED ||
+            mm->reg[AIPU_MEM_REGION_SRAM_ID].type =3D=3D AIPU_MEM_TYPE_DMA=
_RESERVED)) {
+               dev_err(mm->dev, "AIPU is behind an IOMMU and cannot issue =
SRAM PA\n");
+               return -EINVAL;
+       }
+
+       bypass_iommu =3D mm->has_iommu &&
+               (mm->reg[AIPU_MEM_REGION_DRAM_ID].type =3D=3D AIPU_MEM_TYPE=
_DEV_RESERVED ||
+                mm->reg[AIPU_MEM_REGION_DRAM_ID].type =3D=3D AIPU_MEM_TYPE=
_DMA_RESERVED);
+       if (bypass_iommu) {
+               dev_info(mm->dev, "%s reserved memory is used and IOMMU wil=
l be bypassed\n",
+                        (mm->reg[AIPU_MEM_REGION_DRAM_ID].type =3D=3D AIPU=
_MEM_TYPE_DEV_RESERVED) ?
+                        "Native" : "DMA");
+       }
+
+       if ((!mm->has_iommu || bypass_iommu) && mm->reg[AIPU_MEM_REGION_SRA=
M_ID].bytes &&
+           ((mm->reg[AIPU_MEM_REGION_SRAM_ID].base_pa >> 32) !=3D
+            (mm->reg[AIPU_MEM_REGION_DRAM_ID].base_pa >> 32))) {
+               mm->reg[AIPU_MEM_REGION_SRAM_ID].bytes =3D 0;
+               mm->reg[AIPU_MEM_REGION_SRAM_ID].base_pa =3D 0;
+               dev_err(mm->dev, "SRAM is not in the same 4GB region with D=
RAM and cannot be used\n");
+       }
+
+       ret =3D aipu_mm_init_mem_region(mm, AIPU_MEM_REGION_DRAM_ID);
+       if (ret)
+               return ret;
+
+       ret =3D aipu_mm_init_mem_region(mm, AIPU_MEM_REGION_SRAM_ID);
+       if (ret)
+               goto err;
+
+       goto finish;
+
+err:
+       aipu_mm_deinit_mem_region(mm, AIPU_MEM_REGION_DRAM_ID);
+
+finish:
+       return ret;
+}
+
+/**
+ * @aipu_deinit_mm() - de-initialize mm module while kernel module unloadi=
ng
+ * @mm: pointer to memory manager struct initialized in aipu_init_mm()
+ */
+void aipu_deinit_mm(struct aipu_memory_manager *mm)
+{
+       aipu_mm_deinit_mem_region(mm, AIPU_MEM_REGION_SRAM_ID);
+       aipu_mm_deinit_mem_region(mm, AIPU_MEM_REGION_DRAM_ID);
+}
+
+/**
+ * @aipu_mm_alloc() - alloc memory buffer for user request
+ * @mm:      pointer to memory manager struct initialized in aipu_init_mm(=
)
+ * @buf_req: pointer to buffer request struct from userland
+ * @filp:    pointer to the file struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_mm_alloc(struct aipu_memory_manager *mm, struct aipu_buf_request =
*buf_req,
+                 struct file *filp)
+{
+       int ret =3D 0;
+
+       if (!mm || !buf_req || !filp)
+               return -EINVAL;
+
+       if (!buf_req->bytes || !is_power_of_2(buf_req->align_in_page))
+               return -EINVAL;
+
+       WARN_ON(!mm->reg[AIPU_MEM_REGION_DRAM_ID].bytes &&
+               !mm->reg[AIPU_MEM_REGION_SRAM_ID].bytes);
+
+       mutex_lock(&mm->lock);
+       /*
+        * Try to allocate from SRAM first if and only if:
+        * 1. System has SRAM region;
+        * 2. SRAM is in enable state;
+        * 3. The data types are matched;
+        */
+       if (mm->reg[AIPU_MEM_REGION_SRAM_ID].bytes && !mm->sram_disable &&
+           mm->sram_dft_dtype =3D=3D buf_req->data_type) {
+               ret =3D aipu_mm_alloc_in_region_no_lock(mm, buf_req,
+                                                     &mm->reg[AIPU_MEM_REG=
ION_SRAM_ID], filp);
+               if (!ret)
+                       goto unlock;
+       }
+
+       ret =3D aipu_mm_alloc_in_region_no_lock(mm, buf_req,
+                                             &mm->reg[AIPU_MEM_REGION_DRAM=
_ID], filp);
+       if (ret) {
+               dev_err(mm->dev,
+                       "[MM] buffer allocation failed for: bytes 0x%llx, p=
age align %d\n",
+                       buf_req->bytes, buf_req->align_in_page);
+               goto unlock;
+       }
+
+       WARN_ON(buf_req->desc.pa % (buf_req->align_in_page << PAGE_SHIFT));
+
+unlock:
+       mutex_unlock(&mm->lock);
+       return ret;
+}
+
+/**
+ * @aipu_mm_free() - free buffer allocated by aipu_mm_alloc()
+ * @mm:   pointer to memory manager struct initialized in aipu_init_mm()
+ * @buf:  pointer to the buffer descriptor to be released
+ * @filp: pointer to the file struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_mm_free(struct aipu_memory_manager *mm, struct aipu_buf_desc *buf=
, struct file *filp)
+{
+       int ret =3D 0;
+       struct aipu_mem_region *reg =3D NULL;
+
+       if (!mm || !buf || !filp)
+               return -EINVAL;
+
+       reg =3D aipu_mm_find_region(mm, buf->pa);
+       if (!reg)
+               return -EINVAL;
+
+       mutex_lock(&mm->lock);
+       ret =3D aipu_mm_free_in_region_no_lock(mm, buf, reg, filp);
+       mutex_unlock(&mm->lock);
+
+       return ret;
+}
+
+/**
+ * @aipu_mm_free_buffers() - free all the buffers allocated from one fd
+ * @mm:   pointer to memory manager struct initialized in aipu_init_mm()
+ * @filp: pointer to the file struct
+ */
+void aipu_mm_free_buffers(struct aipu_memory_manager *mm, struct file *fil=
p)
+{
+       aipu_mm_free_filp_in_region(mm, &mm->reg[AIPU_MEM_REGION_DRAM_ID], =
filp);
+       aipu_mm_free_filp_in_region(mm, &mm->reg[AIPU_MEM_REGION_SRAM_ID], =
filp);
+}
+
+/**
+ * @aipu_mm_mmap_buf() - mmap an allocated buffer for user thread
+ * @mm: pointer to memory manager struct initialized in aipu_init_mm()
+ * @vma: pointer to the vm_area_struct
+ * @filp: pointer to the file struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_mm_mmap_buf(struct aipu_memory_manager *mm, struct vm_area_struct=
 *vma,
+                    struct file *filp)
+{
+       int ret =3D 0;
+       u64 offset =3D 0;
+       int len =3D 0;
+       size_t mmap_size =3D 0;
+       unsigned long vm_pgoff =3D 0;
+       struct aipu_mem_region *reg =3D NULL;
+       struct aipu_virt_page *first_page =3D NULL;
+
+       if (!mm || !vma)
+               return -EINVAL;
+
+       offset =3D vma->vm_pgoff * PAGE_SIZE;
+       len =3D vma->vm_end - vma->vm_start;
+
+       reg =3D aipu_mm_find_region(mm, offset);
+       if (!reg)
+               return -EINVAL;
+
+       first_page =3D aipu_mm_find_page(mm, reg, filp, offset);
+       if (!first_page)
+               return -EINVAL;
+
+       vm_pgoff =3D vma->vm_pgoff;
+       vma->vm_pgoff =3D 0;
+       vma->vm_flags |=3D VM_IO;
+       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
+
+       if (reg->type =3D=3D AIPU_MEM_TYPE_DEV_RESERVED) {
+               ret =3D remap_pfn_range(vma, vma->vm_start, offset >> PAGE_=
SHIFT,
+                                     vma->vm_end - vma->vm_start, vma->vm_=
page_prot);
+       } else {
+               if (reg->type =3D=3D AIPU_MEM_TYPE_KERNEL) {
+                       vma->vm_pgoff =3D (offset - reg->base_iova) >> PAGE=
_SHIFT;
+                       mmap_size =3D reg->bytes;
+               } else {
+                       mmap_size =3D first_page->contiguous_alloc_len << P=
AGE_SHIFT;
+               }
+               ret =3D dma_mmap_attrs(reg->dev, vma,
+                                    (void *)((u64)reg->base_va + offset - =
reg->base_iova),
+                                    (dma_addr_t)offset, mmap_size, reg->at=
trs);
+       }
+
+       vma->vm_pgoff =3D vm_pgoff;
+       if (!ret)
+               first_page->map_num++;
+
+       return ret;
+}
+
+/**
+ * @aipu_mm_disable_sram_allocation() - disable buffer allocations from so=
c sram
+ * @mm: pointer to memory manager struct initialized in aipu_init_mm()
+ * @filp: pointer to the file struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_mm_disable_sram_allocation(struct aipu_memory_manager *mm, struct=
 file *filp)
+{
+       int ret =3D 0;
+       struct aipu_sram_disable_per_fd *sram_disable_per_fd =3D NULL;
+
+       if (!mm)
+               return -EINVAL;
+
+       /* If there is no SRAM in this system, it cannot be disabled. */
+       if (!mm->reg[AIPU_MEM_REGION_SRAM_ID].bytes)
+               return -EPERM;
+
+       mutex_lock(&mm->lock);
+       /* If SRAM is under using by driver & AIPU, it cannot be disabled. =
*/
+       if (!bitmap_empty(mm->reg[AIPU_MEM_REGION_SRAM_ID].bitmap,
+                         mm->reg[AIPU_MEM_REGION_SRAM_ID].count))
+               ret =3D -EPERM;
+
+       if (!ret) {
+               int found =3D 0;
+
+               list_for_each_entry(sram_disable_per_fd, &mm->sram_disable_=
head->list, list) {
+                       if (sram_disable_per_fd->filp =3D=3D filp) {
+                               sram_disable_per_fd->cnt++;
+                               found =3D 1;
+                               break;
+                       }
+               }
+               if (!found) {
+                       sram_disable_per_fd =3D kzalloc(sizeof(*sram_disabl=
e_per_fd), GFP_KERNEL);
+                       if (!sram_disable_per_fd) {
+                               ret =3D -ENOMEM;
+                               goto unlock;
+                       }
+                       sram_disable_per_fd->cnt++;
+                       sram_disable_per_fd->filp =3D filp;
+                       list_add(&sram_disable_per_fd->list, &mm->sram_disa=
ble_head->list);
+               }
+               mm->sram_disable++;
+       }
+unlock:
+       mutex_unlock(&mm->lock);
+       return ret;
+}
+
+/**
+ * @aipu_mm_enable_sram_allocation() - enable buffer allocations from soc =
sram (disabled before)
+ * @mm:   pointer to memory manager struct initialized in aipu_init_mm()
+ * @filp: pointer to the file struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_mm_enable_sram_allocation(struct aipu_memory_manager *mm, struct =
file *filp)
+{
+       int ret =3D 0;
+       struct aipu_sram_disable_per_fd *sram_disable_per_fd =3D NULL;
+
+       if (!mm)
+               return -EINVAL;
+
+       if (!mm->reg[AIPU_MEM_REGION_SRAM_ID].bytes)
+               return -EPERM;
+
+       mutex_lock(&mm->lock);
+       if (mm->sram_disable =3D=3D 0) {
+               ret =3D -EPERM;
+               goto unlock;
+       }
+
+       list_for_each_entry(sram_disable_per_fd, &mm->sram_disable_head->li=
st, list) {
+               if (sram_disable_per_fd->filp =3D=3D filp) {
+                       if (sram_disable_per_fd->cnt)
+                               sram_disable_per_fd->cnt--;
+                       break;
+               }
+       }
+       mm->sram_disable--;
+unlock:
+       mutex_unlock(&mm->lock);
+       return ret;
+}
diff --git a/drivers/misc/armchina-npu/aipu_mm.h b/drivers/misc/armchina-np=
u/aipu_mm.h
new file mode 100644
index 000000000000..f7e0018a5cec
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_mm.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_MM_H__
+#define __AIPU_MM_H__
+
+#include <linux/platform_device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <uapi/misc/armchina_aipu.h>
+
+/**
+ * enum aipu_mem_type - AIPU memory type (used for both DRAM & SRAM)
+ * @AIPU_MEM_TYPE_NONE: no type
+ * @AIPU_MEM_TYPE_DEV_RESERVED: device specific native reservation
+ * @AIPU_MEM_TYPE_DMA_RESERVED: device specific DMA reservation
+ * @AIPU_MEM_TYPE_CMA_RESERVED: device specific CMA reservation
+ * @AIPU_MEM_TYPE_CMA_DEFAULT: default CMA pool
+ * @AIPU_MEM_TYPE_KERNEL: kernel mapped memory
+ */
+enum aipu_mem_type {
+       AIPU_MEM_TYPE_NONE         =3D 0,
+       AIPU_MEM_TYPE_DEV_RESERVED =3D 1,
+       AIPU_MEM_TYPE_DMA_RESERVED =3D 2,
+       AIPU_MEM_TYPE_CMA_RESERVED =3D 3,
+       AIPU_MEM_TYPE_CMA_DEFAULT  =3D 4,
+       AIPU_MEM_TYPE_KERNEL =3D 5,
+};
+
+enum aipu_mem_region_id {
+       AIPU_MEM_REGION_DRAM_ID =3D 0,
+       AIPU_MEM_REGION_SRAM_ID =3D 1,
+       AIPU_MEM_REGION_MAX_ID =3D 2,
+};
+
+/**
+ * struct aipu_virt_page - virtual page
+ * @tid: ID of thread requested this page (and the following pages)
+ * @filp: filp requested this page
+ * @map_num: number of mmap to userspace
+ * @contiguous_alloc_len: count of immediately following pages allocated i=
n together
+ */
+struct aipu_virt_page {
+       int tid;
+       struct file *filp;
+       int map_num;
+       unsigned long contiguous_alloc_len;
+};
+
+/**
+ * struct aipu_mem_region - AIPU memory region
+ * @base_iova: region base iova (bus address)
+ * @base_pa: region base physical address
+ * @base_va: region base virtual address
+ * @bytes: total bytes of this region
+ * @base_pfn: region base page frame number
+ * @type: region type (aipu_mem_type)
+ * @pages: page array
+ * @bitmap: region bitmap
+ * @count: bitmap bit count/page count
+ * @dev: region specific device (for multiple DMA/CMA regions)
+ * @attrs: attributes for DMA API
+ */
+struct aipu_mem_region {
+       dma_addr_t base_iova;
+       dma_addr_t base_pa;
+       void *base_va;
+       u64 bytes;
+       unsigned long base_pfn;
+       enum aipu_mem_type type;
+       struct aipu_virt_page **pages;
+       unsigned long *bitmap;
+       unsigned long count;
+       struct device *dev;
+       unsigned long attrs;
+};
+
+/**
+ * struct aipu_sram_disable_per_fd - SRAM disable list records disable ope=
rations
+ * @cnt: current total disable operation count
+ * @filp: file opinter
+ * @list: file pointer list
+ */
+struct aipu_sram_disable_per_fd {
+       int cnt;
+       struct file *filp;
+       struct list_head list;
+};
+
+/**
+ * struct aipu_memory_manager - AIPU memory management struct (MM)
+ * @version: AIPU ISA version number
+ * @limit: AIPU device address space upper bound
+ * @has_iommu: system has an IOMMU for AIPU to use or not
+ * @host_aipu_offset: offset between CPU address space and AIPU device add=
ress space
+ * @dev: device struct pointer (AIPU core 0)
+ * @lock: lock for reg and sram_disable_head
+ * @reg: memory region, contains DRAM and/or SRAM
+ * @sram_dft_dtype: default data type allocated from SRAM
+ * @sram_disable: is SRAM in disable state or not
+ * @sram_disable_head: sram disable list
+ */
+struct aipu_memory_manager {
+       int version;
+       u64 limit;
+       bool has_iommu;
+       u64 host_aipu_offset;
+       struct device *dev;
+       struct mutex lock; /* Protect sram disabled head struct */
+       struct aipu_mem_region reg[AIPU_MEM_REGION_MAX_ID];
+       int sram_dft_dtype;
+       int sram_disable;
+       struct aipu_sram_disable_per_fd *sram_disable_head;
+};
+
+int aipu_init_mm(struct aipu_memory_manager *mm, struct platform_device *p=
_dev, int version);
+void aipu_deinit_mm(struct aipu_memory_manager *mm);
+int aipu_mm_alloc(struct aipu_memory_manager *mm, struct aipu_buf_request =
*buf_req,
+                 struct file *filp);
+int aipu_mm_free(struct aipu_memory_manager *mm, struct aipu_buf_desc *buf=
, struct file *filp);
+void aipu_mm_free_buffers(struct aipu_memory_manager *mm, struct file *fil=
p);
+int aipu_mm_mmap_buf(struct aipu_memory_manager *mm, struct vm_area_struct=
 *vma,
+                    struct file *filp);
+int aipu_mm_disable_sram_allocation(struct aipu_memory_manager *mm, struct=
 file *filp);
+int aipu_mm_enable_sram_allocation(struct aipu_memory_manager *mm, struct =
file *filp);
+
+#endif /* __AIPU_MM_H__ */
diff --git a/drivers/misc/armchina-npu/aipu_priv.c b/drivers/misc/armchina-=
npu/aipu_priv.c
new file mode 100644
index 000000000000..e1ae5b951618
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_priv.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/slab.h>
+#include <linux/of_address.h>
+#include "aipu_priv.h"
+#include "config.h"
+
+static int init_misc_dev(struct aipu_priv *aipu)
+{
+       aipu->misc.minor =3D MISC_DYNAMIC_MINOR;
+       aipu->misc.name =3D "aipu";
+       aipu->misc.fops =3D aipu->aipu_fops;
+       aipu->misc.mode =3D 0666;
+       return misc_register(&aipu->misc);
+}
+
+static void deinit_misc_dev(struct aipu_priv *aipu)
+{
+       if (aipu && aipu->misc.fops) {
+               misc_deregister(&aipu->misc);
+               memset(&aipu->misc, 0, sizeof(aipu->misc));
+       }
+}
+
+/**
+ * @init_aipu_priv() - initialize an input AIPU private data struct
+ * @aipu:  pointer to the aipu private struct to be initialized
+ * @p_dev: pointer to the platform device struct
+ * @fops:  pointer to the file_operations struct
+ * @soc:   pointer to the SoC private data structure
+ * @soc_ops: pointer to the SoC operations struct
+ *
+ * This function should be called while driver probing. It should be calle=
d
+ * only one time.
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int init_aipu_priv(struct aipu_priv *aipu, struct platform_device *p_dev,
+                  const struct file_operations *fops, struct aipu_soc *soc=
,
+                  struct aipu_soc_operations *soc_ops)
+{
+       int ret =3D 0;
+       int version =3D 0;
+       int config =3D 0;
+
+       if (!aipu || !p_dev || !fops)
+               return -EINVAL;
+
+       if (aipu->is_init)
+               return 0;
+
+       aipu->core_cnt =3D 0;
+       aipu->cores =3D NULL;
+       aipu->dev =3D &p_dev->dev;
+       aipu->aipu_fops =3D fops;
+       aipu->soc =3D soc;
+       aipu->soc_ops =3D soc_ops;
+
+       zhouyi_detect_aipu_version(p_dev, &version, &config);
+       dev_dbg(aipu->dev, "AIPU core0 ISA version %d, configuration %d\n",=
 version, config);
+
+       ret =3D init_misc_dev(aipu);
+       if (ret)
+               goto err_handle;
+
+       ret =3D init_aipu_job_manager(&aipu->job_manager);
+       if (ret)
+               goto err_handle;
+
+       ret =3D aipu_init_mm(&aipu->mm, p_dev, version);
+       if (ret)
+               goto err_handle;
+
+       aipu->is_init =3D true;
+       goto finish;
+
+err_handle:
+       deinit_aipu_priv(aipu);
+
+finish:
+       return ret;
+}
+
+/**
+ * @brief deinit an AIPU private data struct
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int deinit_aipu_priv(struct aipu_priv *aipu)
+{
+       int core_iter =3D 0;
+
+       if (!aipu)
+               return 0;
+
+       for (core_iter =3D 0; core_iter < aipu->core_cnt; core_iter++)
+               deinit_aipu_core(aipu->cores[core_iter]);
+
+       kfree(aipu->cores);
+       aipu->core_cnt =3D 0;
+
+       aipu_deinit_mm(&aipu->mm);
+       deinit_aipu_job_manager(&aipu->job_manager);
+       deinit_misc_dev(aipu);
+       aipu->is_init =3D 0;
+
+       return 0;
+}
+
+/**
+ * @aipu_priv_add_core() - add new detected core into aipu_priv struct in =
probe phase
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ * @core:    pointer to an aipu core struct
+ * @version: aipu core hardware version number
+ * @id:      aipu core ID
+ * @p_dev:   pointer to the platform device struct
+ *
+ * This function is called when there is a new AIPU core is probed into dr=
iver.
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_priv_add_core(struct aipu_priv *aipu, struct aipu_core *core,
+                      int version, int id, struct platform_device *p_dev)
+{
+       int ret =3D 0;
+       struct aipu_core **new_core_arr =3D NULL;
+
+       if (!aipu || !core || !p_dev)
+               return -EINVAL;
+
+       WARN_ON(!aipu->is_init);
+
+       ret =3D init_aipu_core(core, version, id, aipu, p_dev);
+       if (ret)
+               return ret;
+
+       new_core_arr =3D kcalloc(aipu->core_cnt + 1, sizeof(*new_core_arr),=
 GFP_KERNEL);
+       if (!new_core_arr)
+               return -ENOMEM;
+
+       if (aipu->core_cnt) {
+               WARN_ON(!aipu->cores);
+               memcpy(new_core_arr, aipu->cores, aipu->core_cnt * sizeof(*=
new_core_arr));
+               kfree(aipu->cores);
+               aipu->cores =3D NULL;
+       }
+
+       new_core_arr[aipu->core_cnt] =3D core;
+       aipu->cores =3D new_core_arr;
+       aipu->core_cnt++;
+
+       aipu_job_manager_set_cores_info(&aipu->job_manager, aipu->core_cnt,=
 aipu->cores);
+       return ret;
+}
+
+/**
+ * @aipu_priv_get_version() - get AIPU hardware version number wrapper
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ *
+ * Return: AIPU ISA version
+ */
+int aipu_priv_get_version(struct aipu_priv *aipu)
+{
+       if (likely(aipu))
+               return aipu->version;
+       return 0;
+}
+
+/**
+ * @aipu_priv_get_core_cnt() - get AIPU core count
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ *
+ * Return AIPU core count
+ */
+int aipu_priv_get_core_cnt(struct aipu_priv *aipu)
+{
+       if (likely(aipu))
+               return aipu->core_cnt;
+       return 0;
+}
+
+/**
+ * @aipu_priv_query_core_capability() - query AIPU capability wrapper (per=
 core capability)
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ * @cap:  pointer to the capability struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_priv_query_core_capability(struct aipu_priv *aipu, struct aipu_co=
re_cap *cap)
+{
+       int id =3D 0;
+       struct aipu_core *core =3D NULL;
+
+       if (unlikely(!aipu && !cap))
+               return -EINVAL;
+
+       for (id =3D 0; id < aipu->core_cnt; id++) {
+               core =3D aipu->cores[id];
+               cap[id].core_id =3D id;
+               cap[id].arch =3D core->arch;
+               cap[id].version =3D core->version;
+               cap[id].config =3D core->config;
+               cap[id].info.reg_base =3D core->reg.phys;
+       }
+
+       return 0;
+}
+
+/**
+ * @aipu_priv_query_capability() - query AIPU capability wrapper (multicor=
e common capability)
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ * @cap:  pointer to the capability struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_priv_query_capability(struct aipu_priv *aipu, struct aipu_cap *ca=
p)
+{
+       int id =3D 0;
+       struct aipu_core_cap *core_cap =3D NULL;
+
+       if (unlikely(!aipu && !cap))
+               return -EINVAL;
+
+       cap->core_cnt =3D aipu->core_cnt;
+       cap->is_homogeneous =3D 1;
+
+       core_cap =3D kcalloc(aipu->core_cnt, sizeof(*core_cap), GFP_KERNEL)=
;
+       if (!core_cap)
+               return -ENOMEM;
+
+       aipu_priv_query_core_capability(aipu, core_cap);
+       for (id =3D 1; id < aipu->core_cnt; id++) {
+               if (core_cap[id].arch !=3D core_cap[id - 1].arch ||
+                   core_cap[id].version !=3D core_cap[id - 1].version ||
+                   core_cap[id].config !=3D core_cap[id - 1].config) {
+                       cap->is_homogeneous =3D 0;
+                       break;
+               }
+       }
+
+       if (cap->is_homogeneous)
+               cap->core_cap =3D core_cap[0];
+
+       kfree(core_cap);
+       return 0;
+}
+
+/**
+ * @aipu_priv_io_rw() - AIPU external register read/write wrapper
+ * @aipu:   pointer to the aipu private struct initialized in init_aipu_pr=
iv()
+ * @io_req: pointer to the io_req struct
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_priv_io_rw(struct aipu_priv *aipu, struct aipu_io_req *io_req)
+{
+       int ret =3D -EINVAL;
+       int id =3D 0;
+
+       if (!aipu || !io_req || io_req->core_id >=3D aipu->core_cnt)
+               return ret;
+
+       id =3D io_req->core_id;
+       return aipu->cores[id]->ops->io_rw(aipu->cores[id], io_req);
+}
+
+/**
+ * @aipu_priv_check_status() - check if aipu status is ready for usage
+ * @aipu: pointer to the aipu private struct initialized in init_aipu_priv=
()
+ *
+ * Return: 0 on success and error code otherwise.
+ */
+int aipu_priv_check_status(struct aipu_priv *aipu)
+{
+       if (aipu && aipu->is_init)
+               return 0;
+       return -EINVAL;
+}
diff --git a/drivers/misc/armchina-npu/aipu_priv.h b/drivers/misc/armchina-=
npu/aipu_priv.h
new file mode 100644
index 000000000000..ae9d596ff84c
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_priv.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_PRIV_H__
+#define __AIPU_PRIV_H__
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/types.h>
+#include "include/armchina_aipu_soc.h"
+#include "aipu_irq.h"
+#include "aipu_io.h"
+#include "aipu_core.h"
+#include "aipu_job_manager.h"
+#include "aipu_mm.h"
+
+/**
+ * struct aipu_priv - AIPU private struct contains all core info and share=
d resources
+ * @version:     AIPU hardware version
+ * @core_cnt:    AIPU core count in system
+ * @cores:       core pointer array
+ * @dev:         device struct pointer of core 0
+ * @soc_ops:     SoC operation pointer
+ * @aipu_fops:   file operation struct
+ * @misc:        misc driver struct
+ * @job_manager: job manager struct
+ * @mm:          memory manager
+ * @is_init:     init flag
+ */
+struct aipu_priv {
+       int version;
+       int core_cnt;
+       struct aipu_core **cores;
+       struct device *dev;
+       struct aipu_soc              *soc;
+       struct aipu_soc_operations   *soc_ops;
+       const struct file_operations *aipu_fops;
+       struct miscdevice            misc;
+       struct aipu_job_manager      job_manager;
+       struct aipu_memory_manager   mm;
+       bool is_init;
+};
+
+int init_aipu_priv(struct aipu_priv *aipu, struct platform_device *p_dev,
+                  const struct file_operations *fops, struct aipu_soc *soc=
,
+                  struct aipu_soc_operations *soc_ops);
+int deinit_aipu_priv(struct aipu_priv *aipu);
+int aipu_priv_add_core(struct aipu_priv *aipu, struct aipu_core *core,
+                      int version, int id, struct platform_device *p_dev);
+int aipu_priv_get_version(struct aipu_priv *aipu);
+int aipu_priv_get_core_cnt(struct aipu_priv *aipu);
+int aipu_priv_query_core_capability(struct aipu_priv *aipu, struct aipu_co=
re_cap *cap);
+int aipu_priv_query_capability(struct aipu_priv *aipu, struct aipu_cap *ca=
p);
+int aipu_priv_io_rw(struct aipu_priv *aipu, struct aipu_io_req *io_req);
+int aipu_priv_check_status(struct aipu_priv *aipu);
+
+#endif /* __AIPU_PRIV_H__ */
diff --git a/drivers/misc/armchina-npu/aipu_soc_default.c b/drivers/misc/ar=
mchina-npu/aipu_soc_default.c
new file mode 100644
index 000000000000..a61f2f5d14c3
--- /dev/null
+++ b/drivers/misc/armchina-npu/aipu_soc_default.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+/*
+ * SoC: default SoC using Armchina platform driver methods
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include "include/armchina_aipu_soc.h"
+
+static struct aipu_soc default_soc =3D {
+       .priv =3D NULL,
+};
+
+static struct aipu_soc_operations default_ops =3D {
+       .start_bw_profiling =3D NULL,
+       .stop_bw_profiling =3D NULL,
+       .read_profiling_reg =3D NULL,
+       .enable_clk =3D NULL,
+       .disable_clk =3D NULL,
+       .is_clk_enabled =3D NULL,
+       .is_aipu_irq =3D NULL,
+};
+
+static int default_probe(struct platform_device *p_dev)
+{
+       return armchina_aipu_probe(p_dev, &default_soc, &default_ops);
+}
+
+static int default_remove(struct platform_device *p_dev)
+{
+       return armchina_aipu_remove(p_dev);
+}
+
+static int default_suspend(struct platform_device *p_dev, pm_message_t sta=
te)
+{
+       return armchina_aipu_suspend(p_dev, state);
+}
+
+static int default_resume(struct platform_device *p_dev)
+{
+       return armchina_aipu_resume(p_dev);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id aipu_of_match[] =3D {
+       {
+               .compatible =3D "armchina,zhouyi-v1",
+       },
+       {
+               .compatible =3D "armchina,zhouyi-v2",
+       },
+       {
+               .compatible =3D "armchina,zhouyi",
+       },
+       { }
+};
+
+MODULE_DEVICE_TABLE(of, aipu_of_match);
+#endif
+
+static struct platform_driver aipu_platform_driver =3D {
+       .probe =3D default_probe,
+       .remove =3D default_remove,
+       .suspend =3D default_suspend,
+       .resume  =3D default_resume,
+       .driver =3D {
+               .name =3D "armchina",
+               .owner =3D THIS_MODULE,
+#ifdef CONFIG_OF
+               .of_match_table =3D of_match_ptr(aipu_of_match),
+#endif
+       },
+};
+
+module_platform_driver(aipu_platform_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Dejia Shang");
+MODULE_AUTHOR("Toby Huang");
+MODULE_DESCRIPTION("ArmChina Zhouyi AI accelerator driver");
diff --git a/drivers/misc/armchina-npu/config.h b/drivers/misc/armchina-npu=
/config.h
new file mode 100644
index 000000000000..68e993ca6e3b
--- /dev/null
+++ b/drivers/misc/armchina-npu/config.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __CONFIG_H__
+#define __CONFIG_H__
+
+#include <linux/sizes.h>
+
+#define AIPU_CONFIG_USE_DRAM_DEFAULT_SIZE   0
+#define AIPU_CONFIG_DRAM_DEFAULT_SIZE       (64 * SZ_1M)
+
+#endif /* __CONFIG_H__ */
diff --git a/drivers/misc/armchina-npu/include/armchina_aipu_soc.h b/driver=
s/misc/armchina-npu/include/armchina_aipu_soc.h
new file mode 100644
index 000000000000..a726a90e0feb
--- /dev/null
+++ b/drivers/misc/armchina-npu/include/armchina_aipu_soc.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_SOC_H__
+#define __AIPU_SOC_H__
+
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <uapi/misc/armchina_aipu.h>
+
+/**
+ * struct aipu_soc - a struct contains AIPU SoC specific information
+ * @priv: SoC private data structure
+ *
+ * This struct contains reference to SoC level private data, which is regi=
stered while probing,
+ * and used as arguments of the corresponding SoC operation methods.
+ */
+struct aipu_soc {
+       void *priv;
+};
+
+/**
+ * struct aipu_soc_operations - a struct contains SoC operation methods
+ * @start_bw_profiling: start bandwidth profiling
+ * @stop_bw_profiling:  stop bandwidth profiling
+ * @read_profiling_reg: read profiling register values
+ * @enable_clk:         enable clock/disable clock gating
+ * @disable_clk:        disable clock/enable clock gating
+ * @is_clk_enabled:     is in clock enabled or disabled
+ * @is_aipu_irq:        is the shared interrupt is for an AIPU core or not
+ *
+ * SoC vendors should register the SoC operations into struct aipu_private=
 while
+ * probing if they would like to implement and use their private SoC opera=
tion methods.
+ */
+struct aipu_soc_operations {
+       void (*start_bw_profiling)(struct device *dev, struct aipu_soc *soc=
);
+       void (*stop_bw_profiling)(struct device *dev, struct aipu_soc *soc)=
;
+       void (*read_profiling_reg)(struct device *dev, struct aipu_soc *soc=
,
+                                  struct aipu_ext_profiling_data *pdata);
+       int (*enable_clk)(struct device *dev, struct aipu_soc *soc);
+       int (*disable_clk)(struct device *dev, struct aipu_soc *soc);
+       bool (*is_clk_enabled)(struct device *dev, struct aipu_soc *soc);
+       bool (*is_aipu_irq)(struct device *dev, struct aipu_soc *soc, int c=
ore_id);
+};
+
+int armchina_aipu_probe(struct platform_device *p_dev, struct aipu_soc *so=
c,
+                       struct aipu_soc_operations *ops);
+int armchina_aipu_remove(struct platform_device *p_dev);
+int armchina_aipu_suspend(struct platform_device *p_dev, pm_message_t stat=
e);
+int armchina_aipu_resume(struct platform_device *p_dev);
+
+#endif /* __AIPU_SOC_H__ */
diff --git a/drivers/misc/armchina-npu/zhouyi/Makefile b/drivers/misc/armch=
ina-npu/zhouyi/Makefile
new file mode 100644
index 000000000000..37975e220769
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+subdir-ccflags-y +=3D -I$(src)
+
+ZHOUYI_FILES :=3D zhouyi/zhouyi.o zhouyi/z1.o zhouyi/z2.o
\ No newline at end of file
diff --git a/drivers/misc/armchina-npu/zhouyi/z1.c b/drivers/misc/armchina-=
npu/zhouyi/z1.c
new file mode 100644
index 000000000000..9abdd88d755e
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/z1.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/irqreturn.h>
+#include <linux/bitops.h>
+#include "aipu_priv.h"
+#include "z1.h"
+#include "aipu_io.h"
+#include "config.h"
+
+static int zhouyi_v1_get_hw_version_number(struct aipu_core *core)
+{
+       if (likely(core))
+               return zhouyi_get_hw_version_number(&core->reg);
+       return 0;
+}
+
+static int zhouyi_v1_get_hw_config_number(struct aipu_core *core)
+{
+       if (likely(core))
+               return zhouyi_get_hw_config_number(&core->reg);
+       return 0;
+}
+
+static void zhouyi_v1_enable_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               aipu_write32(&core->reg, ZHOUYI_CTRL_REG_OFFSET,
+                            ZHOUYIV1_IRQ_ENABLE_FLAG);
+}
+
+static void zhouyi_v1_disable_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               aipu_write32(&core->reg, ZHOUYI_CTRL_REG_OFFSET,
+                            ZHOUYIV1_IRQ_DISABLE_FLAG);
+}
+
+static void zhouyi_v1_clear_qempty_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               zhouyi_clear_qempty_interrupt(&core->reg);
+}
+
+static void zhouyi_v1_clear_done_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               zhouyi_clear_done_interrupt(&core->reg);
+}
+
+static void zhouyi_v1_clear_excep_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               zhouyi_clear_excep_interrupt(&core->reg);
+}
+
+static void zhouyi_v1_trigger(struct aipu_core *core)
+{
+       int start_pc =3D 0;
+
+       if (likely(core)) {
+               start_pc =3D aipu_read32(&core->reg, ZHOUYI_START_PC_REG_OF=
FSET) & 0xFFFFFFF0;
+               aipu_write32(&core->reg, ZHOUYI_START_PC_REG_OFFSET, start_=
pc | 0xD);
+       }
+}
+
+static int zhouyi_v1_reserve(struct aipu_core *core, struct aipu_job_desc =
*udesc, int do_trigger)
+{
+       unsigned int phys_addr =3D 0;
+       unsigned int phys_addr0 =3D 0;
+       unsigned int phys_addr1 =3D 0;
+       unsigned int start_pc =3D 0;
+
+       if (unlikely(!core || !udesc))
+               return -EINVAL;
+
+       /* Load data addr 0 register */
+       phys_addr0 =3D (unsigned int)udesc->data_0_addr;
+       aipu_write32(&core->reg, ZHOUYI_DATA_ADDR_0_REG_OFFSET, phys_addr0)=
;
+
+       /* Load data addr 1 register */
+       phys_addr1 =3D (unsigned int)udesc->data_1_addr;
+       aipu_write32(&core->reg, ZHOUYI_DATA_ADDR_1_REG_OFFSET, phys_addr1)=
;
+
+       /* Load interrupt PC */
+       aipu_write32(&core->reg, ZHOUYI_INTR_PC_REG_OFFSET,
+                    (unsigned int)udesc->intr_handler_addr);
+
+       /* Load start PC register */
+       phys_addr =3D (unsigned int)udesc->start_pc_addr;
+       if (do_trigger)
+               start_pc =3D phys_addr | 0xD;
+       else
+               start_pc =3D phys_addr;
+       aipu_write32(&core->reg, ZHOUYI_START_PC_REG_OFFSET, start_pc);
+
+       dev_dbg(core->dev, "[Job %d] trigger done: start pc =3D 0x%x, dreg0=
 =3D 0x%x, dreg1 =3D 0x%x\n",
+               udesc->job_id, start_pc, phys_addr0, phys_addr1);
+
+       return 0;
+}
+
+static bool zhouyi_v1_is_idle(struct aipu_core *core)
+{
+       unsigned long val =3D 0;
+
+       if (unlikely(!core))
+               return false;
+
+       val =3D aipu_read32(&core->reg, ZHOUYI_STAT_REG_OFFSET);
+       return test_bit(16, &val) && test_bit(17, &val) && test_bit(18, &va=
l);
+}
+
+static int zhouyi_v1_read_status_reg(struct aipu_core *core)
+{
+       return zhouyi_read_status_reg(&core->reg);
+}
+
+static void zhouyi_v1_print_hw_id_info(struct aipu_core *core)
+{
+       if (unlikely(!core))
+               return;
+
+       dev_info(core->dev, "AIPU Initial Status: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_STAT_REG_OFFSET));
+
+       dev_info(core->dev, "########## AIPU CORE %d: ZHOUYI V1 ##########"=
, core->id);
+       dev_info(core->dev, "# ISA Version Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_ISA_VERSION_REG_OFFSET));
+       dev_info(core->dev, "# TPC Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_TPC_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# SPU Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_SPU_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# HWA Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_HWA_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# Revision ID Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_REVISION_ID_REG_OFFSET));
+       dev_info(core->dev, "# Memory Hierarchy Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_MEM_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# Instruction RAM Feature Register:  0x%x",
+                aipu_read32(&core->reg, ZHOUYI_INST_RAM_FEATURE_REG_OFFSET=
));
+       dev_info(core->dev, "# TEC Local SRAM Feature Register:   0x%x",
+                aipu_read32(&core->reg, ZHOUYI_LOCAL_SRAM_FEATURE_REG_OFFS=
ET));
+       dev_info(core->dev, "# Global SRAM Feature Register:      0x%x",
+                aipu_read32(&core->reg, ZHOUYI_GLOBAL_SRAM_FEATURE_REG_OFF=
SET));
+       dev_info(core->dev, "# Instruction Cache Feature Register:0x%x",
+                aipu_read32(&core->reg, ZHOUYI_INST_CACHE_FEATURE_REG_OFFS=
ET));
+       dev_info(core->dev, "# Data Cache Feature Register:       0x%x",
+                aipu_read32(&core->reg, ZHOUYI_DATA_CACHE_FEATURE_REG_OFFS=
ET));
+       dev_info(core->dev, "# L2 Cache Feature Register:         0x%x",
+                aipu_read32(&core->reg, ZHOUYI_L2_CACHE_FEATURE_REG_OFFSET=
));
+       dev_info(core->dev, "############################################")=
;
+}
+
+static int zhouyi_v1_io_rw(struct aipu_core *core, struct aipu_io_req *io_=
req)
+{
+       if (unlikely(!io_req))
+               return -EINVAL;
+
+       if (!core || io_req->offset > ZHOUYI_V1_MAX_REG_OFFSET)
+               return -EINVAL;
+
+       zhouyi_io_rw(&core->reg, io_req);
+       return 0;
+}
+
+static int zhouyi_v1_upper_half(void *data)
+{
+       int ret =3D 0;
+       struct aipu_core *core =3D (struct aipu_core *)data;
+
+       if (get_soc_ops(core) &&
+           get_soc_ops(core)->is_aipu_irq &&
+           !get_soc_ops(core)->is_aipu_irq(core->dev, get_soc(core), core-=
>id))
+               return IRQ_NONE;
+
+       ret =3D zhouyi_v1_read_status_reg(core);
+       if (ret & ZHOUYI_IRQ_QEMPTY)
+               zhouyi_v1_clear_qempty_interrupt(core);
+
+       if (ret & ZHOUYI_IRQ_DONE) {
+               zhouyi_v1_clear_done_interrupt(core);
+               aipu_job_manager_irq_upper_half(core, 0);
+               aipu_irq_schedulework(core->irq_obj);
+       }
+
+       if (ret & ZHOUYI_IRQ_EXCEP) {
+               zhouyi_v1_clear_excep_interrupt(core);
+               aipu_job_manager_irq_upper_half(core,
+                                               aipu_read32(&core->reg,
+                                                           ZHOUYI_INTR_CAU=
SE_REG_OFFSET));
+               aipu_irq_schedulework(core->irq_obj);
+       }
+
+       return IRQ_HANDLED;
+}
+
+static void zhouyi_v1_bottom_half(void *data)
+{
+       aipu_job_manager_irq_bottom_half(data);
+}
+
+#ifdef CONFIG_SYSFS
+static int zhouyi_v1_sysfs_show(struct aipu_core *core, char *buf)
+{
+       int ret =3D 0;
+       char tmp[512];
+
+       if (unlikely(!core || !buf))
+               return -EINVAL;
+
+       ret +=3D zhouyi_sysfs_show(&core->reg, buf);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "Intr Cause Reg",
+                                    ZHOUYI_INTR_CAUSE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "Intr Status Reg",
+           ZHOUYI_INTR_STAT_REG_OFFSET);
+       strcat(buf, tmp);
+       return ret;
+}
+#endif
+
+static struct aipu_core_operations zhouyi_v1_ops =3D {
+       .get_version =3D zhouyi_v1_get_hw_version_number,
+       .get_config =3D zhouyi_v1_get_hw_config_number,
+       .enable_interrupt =3D zhouyi_v1_enable_interrupt,
+       .disable_interrupt =3D zhouyi_v1_disable_interrupt,
+       .trigger =3D zhouyi_v1_trigger,
+       .reserve =3D zhouyi_v1_reserve,
+       .is_idle =3D zhouyi_v1_is_idle,
+       .read_status_reg =3D zhouyi_v1_read_status_reg,
+       .print_hw_id_info =3D zhouyi_v1_print_hw_id_info,
+       .io_rw =3D zhouyi_v1_io_rw,
+       .upper_half =3D zhouyi_v1_upper_half,
+       .bottom_half =3D zhouyi_v1_bottom_half,
+#ifdef CONFIG_SYSFS
+       .sysfs_show =3D zhouyi_v1_sysfs_show,
+#endif
+};
+
+struct aipu_core_operations *get_zhouyi_v1_ops(void)
+{
+       return &zhouyi_v1_ops;
+}
diff --git a/drivers/misc/armchina-npu/zhouyi/z1.h b/drivers/misc/armchina-=
npu/zhouyi/z1.h
new file mode 100644
index 000000000000..63e9c5b2ee7f
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/z1.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __Z1_H__
+#define __Z1_H__
+
+#include "zhouyi.h"
+
+/*
+ * Zhouyi V1 AIPU Interrupts
+ */
+#define ZHOUYIV1_IRQ              (ZHOUYI_IRQ)
+#define ZHOUYIV1_IRQ_ENABLE_FLAG  (ZHOUYIV1_IRQ)
+#define ZHOUYIV1_IRQ_DISABLE_FLAG (ZHOUYI_IRQ_NONE)
+
+#define ZHOUYI_V1_MAX_SCHED_JOB_NUM  1
+
+/*
+ * Zhouyi V1 AIPU Specific Host Control Register Map
+ */
+#define ZHOUYI_INTR_CAUSE_REG_OFFSET          0x20
+#define ZHOUYI_INTR_STAT_REG_OFFSET           0x24
+#define ZHOUYI_INTR_BACKUP_STAT_REG_OFFSET    0x28
+#define ZHOUYI_INTR_BACKUP_PC_REG_OFFSET      0x2C
+#define ZHOUYI_DBG_ERR_CAUSE_REG_OFFSET       0x30
+#define ZHOUYI_DBG_DATA_REG_0_OFFSET          0x34
+#define ZHOUYI_DBG_DATA_REG_1_OFFSET          0x38
+#define ZHOUYI_L2_CACHE_FEATURE_REG_OFFSET    0x6C
+#define ZHOUYI_V1_MAX_REG_OFFSET              0x6C
+
+struct aipu_core_operations *get_zhouyi_v1_ops(void);
+
+#endif /* __Z1_H__ */
diff --git a/drivers/misc/armchina-npu/zhouyi/z2.c b/drivers/misc/armchina-=
npu/zhouyi/z2.c
new file mode 100644
index 000000000000..d9010b639528
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/z2.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/irqreturn.h>
+#include <linux/bitops.h>
+#include "aipu_priv.h"
+#include "z2.h"
+#include "aipu_io.h"
+#include "config.h"
+
+static int zhouyi_v2_get_hw_version_number(struct aipu_core *core)
+{
+       if (likely(core))
+               return zhouyi_get_hw_version_number(&core->reg);
+       return 0;
+}
+
+static int zhouyi_v2_get_hw_config_number(struct aipu_core *core)
+{
+       if (likely(core))
+               return zhouyi_get_hw_config_number(&core->reg);
+       return 0;
+}
+
+static void zhouyi_v2_enable_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               aipu_write32(&core->reg, ZHOUYI_CTRL_REG_OFFSET, ZHOUYIV2_I=
RQ_ENABLE_FLAG);
+}
+
+static void zhouyi_v2_disable_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               aipu_write32(&core->reg, ZHOUYI_CTRL_REG_OFFSET, ZHOUYIV2_I=
RQ_DISABLE_FLAG);
+}
+
+static void zhouyi_v2_clear_qempty_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               zhouyi_clear_qempty_interrupt(&core->reg);
+}
+
+static void zhouyi_v2_clear_done_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               zhouyi_clear_done_interrupt(&core->reg);
+}
+
+static void zhouyi_v2_clear_excep_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               zhouyi_clear_excep_interrupt(&core->reg);
+}
+
+static void zhouyi_v2_clear_fault_interrupt(struct aipu_core *core)
+{
+       if (likely(core))
+               aipu_write32(&core->reg, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ=
_FAULT);
+}
+
+static void zhouyi_v2_trigger(struct aipu_core *core)
+{
+       int start_pc =3D 0;
+
+       if (likely(core)) {
+               start_pc =3D aipu_read32(&core->reg, ZHOUYI_START_PC_REG_OF=
FSET) & 0xFFFFFFF0;
+               aipu_write32(&core->reg, ZHOUYI_START_PC_REG_OFFSET, start_=
pc | 0xD);
+       }
+}
+
+static int zhouyi_v2_reserve(struct aipu_core *core, struct aipu_job_desc =
*udesc, int do_trigger)
+{
+       u32 start_pc =3D 0;
+       u32 ase0_base_high =3D 0;
+
+       if (unlikely(!core || !udesc))
+               return -EINVAL;
+
+       start_pc =3D (u32)udesc->start_pc_addr;
+       ase0_base_high =3D udesc->start_pc_addr >> 32;
+
+       /* Load data addr 0 register */
+       aipu_write32(&core->reg, ZHOUYI_DATA_ADDR_0_REG_OFFSET, (u32)udesc-=
>data_0_addr);
+
+       /* Load data addr 1 register */
+       aipu_write32(&core->reg, ZHOUYI_DATA_ADDR_1_REG_OFFSET, (u32)udesc-=
>data_1_addr);
+
+       /* Load interrupt PC */
+       aipu_write32(&core->reg, ZHOUYI_INTR_PC_REG_OFFSET, (u32)udesc->int=
r_handler_addr);
+
+       /* Load ASE registers */
+       /* ASE 0 */
+       aipu_write32(&core->reg, AIPU_ADDR_EXT0_CTRL_REG_OFFSET, ZHOUYI_V2_=
ASE_RW_ENABLE);
+       aipu_write32(&core->reg, AIPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET, ase0_=
base_high);
+       aipu_write32(&core->reg, AIPU_ADDR_EXT0_LOW_BASE_REG_OFFSET, 0);
+       dev_dbg(core->dev, "ASE 0 Ctrl 0x%x, ASE 0 PA 0x%llx",
+               aipu_read32(&core->reg, AIPU_ADDR_EXT0_CTRL_REG_OFFSET),
+               ((u64)aipu_read32(&core->reg, AIPU_ADDR_EXT0_HIGH_BASE_REG_=
OFFSET) << 32) +
+                aipu_read32(&core->reg, AIPU_ADDR_EXT0_LOW_BASE_REG_OFFSET=
));
+       /* ASE 1 */
+       aipu_write32(&core->reg, AIPU_ADDR_EXT1_CTRL_REG_OFFSET, ZHOUYI_V2_=
ASE_READ_ENABLE);
+       aipu_write32(&core->reg, AIPU_ADDR_EXT1_HIGH_BASE_REG_OFFSET, ase0_=
base_high);
+       aipu_write32(&core->reg, AIPU_ADDR_EXT1_LOW_BASE_REG_OFFSET, 0);
+       dev_dbg(core->dev, "ASE 1 Ctrl 0x%x, ASE 1 PA 0x%llx",
+               aipu_read32(&core->reg, AIPU_ADDR_EXT1_CTRL_REG_OFFSET),
+               ((u64)aipu_read32(&core->reg, AIPU_ADDR_EXT1_HIGH_BASE_REG_=
OFFSET) << 32) +
+                aipu_read32(&core->reg, AIPU_ADDR_EXT1_LOW_BASE_REG_OFFSET=
));
+       /* ASE 2 */
+       if (!udesc->enable_asid) {
+               aipu_write32(&core->reg, AIPU_ADDR_EXT2_CTRL_REG_OFFSET,
+                            ZHOUYI_V2_ASE_RW_ENABLE);
+               aipu_write32(&core->reg, AIPU_ADDR_EXT2_HIGH_BASE_REG_OFFSE=
T, ase0_base_high);
+               aipu_write32(&core->reg, AIPU_ADDR_EXT2_LOW_BASE_REG_OFFSET=
, 0);
+               dev_dbg(core->dev, "Default: ASE 2 Ctrl 0x%x, ASE 0 PA 0x%l=
lx",
+                       aipu_read32(&core->reg, AIPU_ADDR_EXT2_CTRL_REG_OFF=
SET),
+                       ((u64)aipu_read32(&core->reg,
+                                         AIPU_ADDR_EXT2_HIGH_BASE_REG_OFFS=
ET) << 32) +
+                        aipu_read32(&core->reg, AIPU_ADDR_EXT2_LOW_BASE_RE=
G_OFFSET));
+       }
+
+       /* Load start PC register */
+       if (do_trigger)
+               start_pc |=3D 0xD;
+       aipu_write32(&core->reg, ZHOUYI_START_PC_REG_OFFSET, start_pc);
+
+       dev_dbg(core->dev, "[Job %d] trigger done: start pc =3D 0x%x, dreg0=
 =3D 0x%x, dreg1 =3D 0x%x\n",
+               udesc->job_id, start_pc, (u32)udesc->data_0_addr, (u32)udes=
c->data_1_addr);
+
+       return 0;
+}
+
+static bool zhouyi_v2_is_idle(struct aipu_core *core)
+{
+       unsigned long val =3D 0;
+
+       if (unlikely(!core))
+               return false;
+
+       val =3D aipu_read32(&core->reg, ZHOUYI_STAT_REG_OFFSET);
+       return test_bit(16, &val) && test_bit(17, &val) && test_bit(18, &va=
l);
+}
+
+static int zhouyi_v2_read_status_reg(struct aipu_core *core)
+{
+       if (unlikely(!core))
+               return 0;
+       return zhouyi_read_status_reg(&core->reg);
+}
+
+static void zhouyi_v2_print_hw_id_info(struct aipu_core *core)
+{
+       if (unlikely(!core))
+               return;
+
+       dev_info(core->dev, "AIPU Initial Status: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_STAT_REG_OFFSET));
+
+       dev_info(core->dev, "########## AIPU CORE %d: ZHOUYI V%d ##########=
",
+                core->id, core->version);
+       dev_info(core->dev, "# ISA Version Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_ISA_VERSION_REG_OFFSET));
+       dev_info(core->dev, "# TPC Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_TPC_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# SPU Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_SPU_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# HWA Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_HWA_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# Revision ID Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_REVISION_ID_REG_OFFSET));
+       dev_info(core->dev, "# Memory Hierarchy Feature Register: 0x%x",
+                aipu_read32(&core->reg, ZHOUYI_MEM_FEATURE_REG_OFFSET));
+       dev_info(core->dev, "# Instruction RAM Feature Register:  0x%x",
+                aipu_read32(&core->reg, ZHOUYI_INST_RAM_FEATURE_REG_OFFSET=
));
+       dev_info(core->dev, "# TEC Local SRAM Feature Register:   0x%x",
+                aipu_read32(&core->reg, ZHOUYI_LOCAL_SRAM_FEATURE_REG_OFFS=
ET));
+       dev_info(core->dev, "# Global SRAM Feature Register:      0x%x",
+                aipu_read32(&core->reg, ZHOUYI_GLOBAL_SRAM_FEATURE_REG_OFF=
SET));
+       dev_info(core->dev, "# Instruction Cache Feature Register:0x%x",
+                aipu_read32(&core->reg, ZHOUYI_INST_CACHE_FEATURE_REG_OFFS=
ET));
+       dev_info(core->dev, "# Data Cache Feature Register:       0x%x",
+                aipu_read32(&core->reg, ZHOUYI_DATA_CACHE_FEATURE_REG_OFFS=
ET));
+       dev_info(core->dev, "############################################")=
;
+}
+
+static int zhouyi_v2_io_rw(struct aipu_core *core, struct aipu_io_req *io_=
req)
+{
+       if (unlikely(!io_req))
+               return -EINVAL;
+
+       if (!core || io_req->offset > ZHOUYI_V2_MAX_REG_OFFSET)
+               return -EINVAL;
+
+       zhouyi_io_rw(&core->reg, io_req);
+       return 0;
+}
+
+static int zhouyi_v2_upper_half(void *data)
+{
+       int ret =3D 0;
+       struct aipu_core *core =3D (struct aipu_core *)data;
+
+       if (get_soc_ops(core) &&
+           get_soc_ops(core)->is_aipu_irq &&
+           !get_soc_ops(core)->is_aipu_irq(core->dev, get_soc(core), core-=
>id))
+               return IRQ_NONE;
+
+       ret =3D zhouyi_v2_read_status_reg(core);
+       if (ret & ZHOUYI_IRQ_QEMPTY)
+               zhouyi_v2_clear_qempty_interrupt(core);
+
+       if (ret & ZHOUYI_IRQ_DONE) {
+               zhouyi_v2_clear_done_interrupt(core);
+               aipu_job_manager_irq_upper_half(core, 0);
+               aipu_irq_schedulework(core->irq_obj);
+       }
+
+       if (ret & ZHOUYI_IRQ_EXCEP) {
+               zhouyi_v2_clear_excep_interrupt(core);
+               aipu_job_manager_irq_upper_half(core, 1);
+               aipu_irq_schedulework(core->irq_obj);
+       }
+
+       if (ret & ZHOUYI_IRQ_FAULT)
+               zhouyi_v2_clear_fault_interrupt(core);
+
+       return IRQ_HANDLED;
+}
+
+static void zhouyi_v2_bottom_half(void *data)
+{
+       aipu_job_manager_irq_bottom_half(data);
+}
+
+#ifdef CONFIG_SYSFS
+static int zhouyi_v2_sysfs_show(struct aipu_core *core, char *buf)
+{
+       int ret =3D 0;
+       char tmp[512];
+
+       if (unlikely(!core || !buf))
+               return -EINVAL;
+
+       ret +=3D zhouyi_sysfs_show(&core->reg, buf);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "Data Addr 2 Reg",
+           AIPU_DATA_ADDR_2_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "Data Addr 3 Reg",
+           AIPU_DATA_ADDR_3_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE0 Ctrl Reg",
+           AIPU_ADDR_EXT0_CTRL_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE0 High Base Reg=
",
+           AIPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE0 Low Base Reg"=
,
+           AIPU_ADDR_EXT0_LOW_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE1 Ctrl Reg",
+           AIPU_ADDR_EXT1_CTRL_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE1 High Base Reg=
",
+           AIPU_ADDR_EXT1_HIGH_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE1 Low Base Reg"=
,
+           AIPU_ADDR_EXT1_LOW_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE2 Ctrl Reg",
+           AIPU_ADDR_EXT2_CTRL_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE2 High Base Reg=
",
+           AIPU_ADDR_EXT2_HIGH_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE2 Low Base Reg"=
,
+           AIPU_ADDR_EXT2_LOW_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE3 Ctrl Reg",
+           AIPU_ADDR_EXT3_CTRL_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE3 High Base Reg=
",
+           AIPU_ADDR_EXT3_HIGH_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(&core->reg, tmp, "ASE3 Low Base Reg"=
,
+           AIPU_ADDR_EXT3_LOW_BASE_REG_OFFSET);
+       strcat(buf, tmp);
+       return ret;
+}
+#endif
+
+static struct aipu_core_operations zhouyi_v2_ops =3D {
+       .get_version =3D zhouyi_v2_get_hw_version_number,
+       .get_config =3D zhouyi_v2_get_hw_config_number,
+       .enable_interrupt =3D zhouyi_v2_enable_interrupt,
+       .disable_interrupt =3D zhouyi_v2_disable_interrupt,
+       .trigger =3D zhouyi_v2_trigger,
+       .reserve =3D zhouyi_v2_reserve,
+       .is_idle =3D zhouyi_v2_is_idle,
+       .read_status_reg =3D zhouyi_v2_read_status_reg,
+       .print_hw_id_info =3D zhouyi_v2_print_hw_id_info,
+       .io_rw =3D zhouyi_v2_io_rw,
+       .upper_half =3D zhouyi_v2_upper_half,
+       .bottom_half =3D zhouyi_v2_bottom_half,
+#ifdef CONFIG_SYSFS
+       .sysfs_show =3D zhouyi_v2_sysfs_show,
+#endif
+};
+
+struct aipu_core_operations *get_zhouyi_v2_ops(void)
+{
+       return &zhouyi_v2_ops;
+}
diff --git a/drivers/misc/armchina-npu/zhouyi/z2.h b/drivers/misc/armchina-=
npu/zhouyi/z2.h
new file mode 100644
index 000000000000..f303bcd6f8ab
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/z2.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __Z2_H__
+#define __Z2_H__
+
+#include "zhouyi.h"
+
+/*
+ * Zhouyi v2 AIPU Specific Interrupts
+ */
+#define ZHOUYI_IRQ_FAULT  0x8
+
+#define ZHOUYIV2_IRQ  (ZHOUYI_IRQ | ZHOUYI_IRQ_FAULT)
+#define ZHOUYIV2_IRQ_ENABLE_FLAG  (ZHOUYIV2_IRQ)
+#define ZHOUYIV2_IRQ_DISABLE_FLAG (ZHOUYI_IRQ_NONE)
+
+#define ZHOUYI_V2_MAX_SCHED_JOB_NUM  1
+
+#define ZHOUYI_V2_ASE_READ_ENABLE        BIT(31)
+#define ZHOUYI_V2_ASE_WRITE_ENABLE       BIT(30)
+#define ZHOUYI_V2_ASE_RW_ENABLE          (ZHOUYI_V2_ASE_READ_ENABLE | ZHOU=
YI_V2_ASE_WRITE_ENABLE)
+
+/*
+ * Zhouyi v2 AIPU Specific Host Control Register Map
+ */
+#define AIPU_DATA_ADDR_2_REG_OFFSET         0x1C
+#define AIPU_DATA_ADDR_3_REG_OFFSET         0x20
+#define AIPU_SECURE_CONFIG_REG_OFFSET       0x30
+#define AIPU_POWER_CTRL_REG_OFFSET          0x38
+#define AIPU_ADDR_EXT0_CTRL_REG_OFFSET      0xC0
+#define AIPU_ADDR_EXT0_HIGH_BASE_REG_OFFSET 0xC4
+#define AIPU_ADDR_EXT0_LOW_BASE_REG_OFFSET  0xC8
+#define AIPU_ADDR_EXT1_CTRL_REG_OFFSET      0xCC
+#define AIPU_ADDR_EXT1_HIGH_BASE_REG_OFFSET 0xD0
+#define AIPU_ADDR_EXT1_LOW_BASE_REG_OFFSET  0xD4
+#define AIPU_ADDR_EXT2_CTRL_REG_OFFSET      0xD8
+#define AIPU_ADDR_EXT2_HIGH_BASE_REG_OFFSET 0xDC
+#define AIPU_ADDR_EXT2_LOW_BASE_REG_OFFSET  0xE0
+#define AIPU_ADDR_EXT3_CTRL_REG_OFFSET      0xE4
+#define AIPU_ADDR_EXT3_HIGH_BASE_REG_OFFSET 0xE8
+#define AIPU_ADDR_EXT3_LOW_BASE_REG_OFFSET  0xEC
+#define ZHOUYI_V2_MAX_REG_OFFSET            0xEC
+
+struct aipu_core_operations *get_zhouyi_v2_ops(void);
+
+#endif /* __Z2_H__ */
diff --git a/drivers/misc/armchina-npu/zhouyi/zhouyi.c b/drivers/misc/armch=
ina-npu/zhouyi/zhouyi.c
new file mode 100644
index 000000000000..370d497feab5
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/zhouyi.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#include <linux/platform_device.h>
+#include "zhouyi.h"
+
+int zhouyi_read_status_reg(struct io_region *io)
+{
+       return aipu_read32(io, ZHOUYI_STAT_REG_OFFSET);
+}
+
+void zhouyi_clear_qempty_interrupt(struct io_region *io)
+{
+       aipu_write32(io, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_QEMPTY);
+}
+
+void zhouyi_clear_done_interrupt(struct io_region *io)
+{
+       aipu_write32(io, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_DONE);
+}
+
+void zhouyi_clear_excep_interrupt(struct io_region *io)
+{
+       aipu_write32(io, ZHOUYI_STAT_REG_OFFSET, ZHOUYI_IRQ_EXCEP);
+}
+
+void zhouyi_io_rw(struct io_region *io, struct aipu_io_req *io_req)
+{
+       if (unlikely(!io || !io_req))
+               return;
+
+       if (io_req->rw =3D=3D AIPU_IO_READ)
+               io_req->value =3D aipu_read32(io, io_req->offset);
+       else if (io_req->rw =3D=3D AIPU_IO_WRITE)
+               aipu_write32(io, io_req->offset, io_req->value);
+}
+
+int zhouyi_detect_aipu_version(struct platform_device *p_dev, int *version=
, int *config)
+{
+       struct resource *res =3D NULL;
+       struct io_region io;
+
+       if (!p_dev || !version || !config)
+               return -EINVAL;
+
+       res =3D platform_get_resource(p_dev, IORESOURCE_MEM, 0);
+       if (!res)
+               return -EINVAL;
+
+       if (init_aipu_ioregion(&io, res->start, res->end - res->start + 1))
+               return -EINVAL;
+
+       *version =3D zhouyi_get_hw_version_number(&io);
+       *config =3D zhouyi_get_hw_config_number(&io);
+       deinit_aipu_ioregion(&io);
+       return 0;
+}
+
+#ifdef CONFIG_SYSFS
+int zhouyi_print_reg_info(struct io_region *io, char *buf, const char *nam=
e, int offset)
+{
+       if (unlikely(!io || !buf || !name))
+               return -EINVAL;
+
+       return snprintf(buf, 1024, "0x%-*x%-*s0x%08x\n", 6, offset, 22, nam=
e,
+           aipu_read32(io, offset));
+}
+#endif
+
+#ifdef CONFIG_SYSFS
+int zhouyi_sysfs_show(struct io_region *io, char *buf)
+{
+       int ret =3D 0;
+       char tmp[512];
+
+       if (unlikely(!io || !buf))
+               return -EINVAL;
+
+       ret +=3D zhouyi_print_reg_info(io, tmp, "Ctrl Reg", ZHOUYI_CTRL_REG=
_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(io, tmp, "Status Reg", ZHOUYI_STAT_R=
EG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(io, tmp, "Start PC Reg", ZHOUYI_STAR=
T_PC_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(io, tmp, "Intr PC Reg", ZHOUYI_INTR_=
PC_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(io, tmp, "IPI Ctrl Reg", ZHOUYI_IPI_=
CTRL_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(io, tmp, "Data Addr 0 Reg", ZHOUYI_D=
ATA_ADDR_0_REG_OFFSET);
+       strcat(buf, tmp);
+       ret +=3D zhouyi_print_reg_info(io, tmp, "Data Addr 1 Reg", ZHOUYI_D=
ATA_ADDR_1_REG_OFFSET);
+       strcat(buf, tmp);
+       return ret;
+}
+#endif
+
+int zhouyi_get_hw_version_number(struct io_region *io)
+{
+       int isa_version =3D 0;
+       int revision_id =3D 0;
+
+       if (!io)
+               return 0;
+
+       isa_version =3D aipu_read32(io, ZHOUYI_ISA_VERSION_REG_OFFSET);
+       revision_id =3D aipu_read32(io, ZHOUYI_REVISION_ID_REG_OFFSET);
+       if (isa_version =3D=3D ZHOUYI_V1_ISA_VERSION_ID)
+               return AIPU_ISA_VERSION_ZHOUYI_V1;
+       else if ((isa_version =3D=3D ZHOUYI_V2_V3_ISA_VERSION_ID) &&
+                (revision_id =3D=3D ZHOUYI_V2_REVISION_ID))
+               return AIPU_ISA_VERSION_ZHOUYI_V2;
+       else if ((isa_version =3D=3D ZHOUYI_V2_V3_ISA_VERSION_ID) &&
+                (revision_id =3D=3D ZHOUYI_V3_REVISION_ID))
+               return AIPU_ISA_VERSION_ZHOUYI_V3;
+       else
+               return 0;
+}
+
+int zhouyi_get_hw_config_number(struct io_region *io)
+{
+       int high =3D 0;
+       int low =3D 0;
+       int isa_version =3D 0;
+       int aiff_feature =3D 0;
+       int tpc_feature =3D 0;
+
+       if (!io)
+               return 0;
+
+       isa_version =3D aipu_read32(io, ZHOUYI_ISA_VERSION_REG_OFFSET);
+       aiff_feature =3D aipu_read32(io, ZHOUYI_HWA_FEATURE_REG_OFFSET);
+       tpc_feature =3D aipu_read32(io, ZHOUYI_TPC_FEATURE_REG_OFFSET);
+
+       if (isa_version =3D=3D 0)
+               high =3D (aiff_feature & 0xF) + 6;
+       else if (isa_version =3D=3D 1)
+               high =3D (aiff_feature & 0xF) + 8;
+
+       low =3D (tpc_feature) & 0x1F;
+
+       return high * 100 + low;
+}
diff --git a/drivers/misc/armchina-npu/zhouyi/zhouyi.h b/drivers/misc/armch=
ina-npu/zhouyi/zhouyi.h
new file mode 100644
index 000000000000..6c49ca2e7063
--- /dev/null
+++ b/drivers/misc/armchina-npu/zhouyi/zhouyi.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __AIPU_ZHOUYI_H__
+#define __AIPU_ZHOUYI_H__
+
+#include <linux/platform_device.h>
+#include <linux/device.h>
+#include <uapi/misc/armchina_aipu.h>
+#include "aipu_io.h"
+#include "config.h"
+
+/*
+ * Zhouyi AIPU Common Interrupts
+ */
+#define ZHOUYI_IRQ_NONE                       0x0
+#define ZHOUYI_IRQ_QEMPTY                     0x1
+#define ZHOUYI_IRQ_DONE                       0x2
+#define ZHOUYI_IRQ_EXCEP                      0x4
+
+#define ZHOUYI_IRQ  (ZHOUYI_IRQ_QEMPTY | ZHOUYI_IRQ_DONE | ZHOUYI_IRQ_EXCE=
P)
+
+#define ZHOUYI_AIPU_IDLE_STATUS               0x70000
+
+/*
+ * Revision ID for Z1/Z2/Z3
+ */
+#define ZHOUYI_V1_ISA_VERSION_ID              0x0
+#define ZHOUYI_V2_V3_ISA_VERSION_ID           0x1
+
+/*
+ * Revision ID for Z2/Z3
+ */
+#define ZHOUYI_V2_REVISION_ID                 0x100
+#define ZHOUYI_V3_REVISION_ID                 0x200
+
+/*
+ * Zhouyi AIPU Common Host Control Register Map
+ */
+#define ZHOUYI_CTRL_REG_OFFSET                0x0
+#define ZHOUYI_STAT_REG_OFFSET                0x4
+#define ZHOUYI_START_PC_REG_OFFSET            0x8
+#define ZHOUYI_INTR_PC_REG_OFFSET             0xC
+#define ZHOUYI_IPI_CTRL_REG_OFFSET            0x10
+#define ZHOUYI_DATA_ADDR_0_REG_OFFSET         0x14
+#define ZHOUYI_DATA_ADDR_1_REG_OFFSET         0x18
+#define ZHOUYI_CLK_CTRL_REG_OFFSET            0x3C
+#define ZHOUYI_ISA_VERSION_REG_OFFSET         0x40
+#define ZHOUYI_TPC_FEATURE_REG_OFFSET         0x44
+#define ZHOUYI_SPU_FEATURE_REG_OFFSET         0x48
+#define ZHOUYI_HWA_FEATURE_REG_OFFSET         0x4C
+#define ZHOUYI_REVISION_ID_REG_OFFSET         0x50
+#define ZHOUYI_MEM_FEATURE_REG_OFFSET         0x54
+#define ZHOUYI_INST_RAM_FEATURE_REG_OFFSET    0x58
+#define ZHOUYI_LOCAL_SRAM_FEATURE_REG_OFFSET  0x5C
+#define ZHOUYI_GLOBAL_SRAM_FEATURE_REG_OFFSET 0x60
+#define ZHOUYI_INST_CACHE_FEATURE_REG_OFFSET  0x64
+#define ZHOUYI_DATA_CACHE_FEATURE_REG_OFFSET  0x68
+
+int zhouyi_read_status_reg(struct io_region *io);
+void zhouyi_clear_qempty_interrupt(struct io_region *io);
+void zhouyi_clear_done_interrupt(struct io_region *io);
+void zhouyi_clear_excep_interrupt(struct io_region *io);
+void zhouyi_io_rw(struct io_region *io, struct aipu_io_req *io_req);
+int zhouyi_detect_aipu_version(struct platform_device *p_dev, int *version=
, int *config);
+#ifdef CONFIG_SYSFS
+int zhouyi_print_reg_info(struct io_region *io, char *buf, const char *nam=
e, int offset);
+int zhouyi_sysfs_show(struct io_region *io, char *buf);
+#endif
+int zhouyi_get_hw_version_number(struct io_region *io);
+int zhouyi_get_hw_config_number(struct io_region *io);
+
+#endif /* __AIPU_ZHOUYI_H__ */
diff --git a/include/uapi/misc/armchina_aipu.h b/include/uapi/misc/armchina=
_aipu.h
new file mode 100644
index 000000000000..bc314febf194
--- /dev/null
+++ b/include/uapi/misc/armchina_aipu.h
@@ -0,0 +1,335 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (c) 2018-2021 Arm Technology (China) Co., Ltd. All rights res=
erved. */
+
+#ifndef __UAPI_MISC_ARMCHINA_AIPU_H__
+#define __UAPI_MISC_ARMCHINA_AIPU_H__
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * In the following member descriptions,
+ * [must]  mean that the fields must be filled by user mode driver any way=
.
+ * [alloc] mean that the buffer(s) represented by the fields must be alloc=
ated
+ *         by user mode driver before calling IOCTL.
+ * [kmd]   mean that the fields should be filled by kernel mode driver
+ *         if the calls are successful.
+ */
+
+/**
+ * emum aipu_arch - AIPU architecture number
+ * @AIPU_ARCH_ZHOUYI: AIPU architecture is Zhouyi.
+ *
+ * This enum is used to indicate the architecture of an AIPU core in the s=
ystem.
+ */
+enum aipu_arch {
+       AIPU_ARCH_ZHOUYI =3D 0,
+};
+
+/**
+ * emum aipu_isa_version - AIPU ISA version number
+ * @AIPU_ISA_VERSION_ZHOUYI_V1: AIPU ISA version is Zhouyi v1.
+ * @AIPU_ISA_VERSION_ZHOUYI_V2: AIPU ISA version is Zhouyi v2.
+ * @AIPU_ISA_VERSION_ZHOUYI_V3: AIPU ISA version is Zhouyi v3.
+ *
+ * Zhouyi architecture has multiple ISA versions released.
+ * This enum is used to indicate the ISA version of an AIPU core in the sy=
stem.
+ */
+enum aipu_isa_version {
+       AIPU_ISA_VERSION_ZHOUYI_V1 =3D 1,
+       AIPU_ISA_VERSION_ZHOUYI_V2 =3D 2,
+       AIPU_ISA_VERSION_ZHOUYI_V3 =3D 3,
+};
+
+/**
+ * struct aipu_core_cap - Capability of an AIPU core
+ * @core_id: [kmd] Core ID
+ * @arch:    [kmd] Architecture number
+ * @version: [kmd] ISA version number
+ * @config:  [kmd] Configuration number
+ * @info:    [kmd] Debugging information
+ *
+ * For example, Z2-1104:
+ *    arch =3D=3D AIPU_ARCH_ZHOUYI (0)
+ *    version =3D=3D AIPU_ISA_VERSION_ZHOUYI_V2 (2)
+ *    config =3D=3D 1104
+ */
+struct aipu_core_cap {
+       __u32 core_id;
+       __u32 arch;
+       __u32 version;
+       __u32 config;
+       struct aipu_debugger_info {
+               __u64 reg_base; /* External register base address (physical=
) */
+       } info;
+};
+
+/**
+ * struct aipu_cap - Common capability of the AIPU core(s)
+ * @core_cnt:            [kmd] Count of AIPU core(s) in the system
+ * @host_to_aipu_offset: [kmd] Address space offset between host and AIPU
+ * @is_homogeneous:      [kmd] IS homogeneous AIPU system or not (1/0)
+ * @core_cap:            [kmd] Capability of the single AIPU core
+ *
+ * AIPU driver supports the management of multiple AIPU cores in the syste=
m.
+ * This struct is used to indicate the common capability of all AIPU core(=
s).
+ * User mode driver should get this capability via AIPU_IOCTL_QUERYCAP com=
mand.
+ * If the core count is 1, the per-core capability is in the core_cap memb=
er;
+ * otherwise user mode driver should get all the per-core capabilities as =
the
+ * core_cnt indicates via AIPU_IOCTL_QUERYCORECAP command.
+ */
+struct aipu_cap {
+       __u32 core_cnt;
+       __u64 host_to_aipu_offset;
+       __u32 is_homogeneous;
+       struct aipu_core_cap core_cap;
+};
+
+/**
+ * enum aipu_mm_data_type - Data/Buffer type
+ * @AIPU_MM_DATA_TYPE_NONE:   No type
+ * @AIPU_MM_DATA_TYPE_TEXT:   Text (instructions)
+ * @AIPU_MM_DATA_TYPE_RODATA: Read-only data (parameters)
+ * @AIPU_MM_DATA_TYPE_STACK:  Stack
+ * @AIPU_MM_DATA_TYPE_STATIC: Static data (weights)
+ * @AIPU_MM_DATA_TYPE_REUSE:  Reuse data (feature maps)
+ */
+enum aipu_mm_data_type {
+       AIPU_MM_DATA_TYPE_NONE,
+       AIPU_MM_DATA_TYPE_TEXT,
+       AIPU_MM_DATA_TYPE_RODATA,
+       AIPU_MM_DATA_TYPE_STACK,
+       AIPU_MM_DATA_TYPE_STATIC,
+       AIPU_MM_DATA_TYPE_REUSE,
+};
+
+/**
+ * struct aipu_buf_desc - Buffer description.
+ * @pa:         [kmd] Buffer physical base address
+ * @dev_offset: [kmd] Device offset used in mmap
+ * @bytes:      [kmd] Buffer size in bytes
+ */
+struct aipu_buf_desc {
+       __u64 pa;
+       __u64 dev_offset;
+       __u64 bytes;
+};
+
+/**
+ * struct aipu_buf_request - Buffer allocation request structure.
+ * @bytes:         [must] Buffer size to allocate (in bytes)
+ * @align_in_page: [must] Buffer address alignment (must be a power of 2)
+ * @data_type:     [must] Type of data in this buffer/Type of this buffer
+ * @desc:          [kmd]  Descriptor of the successfully allocated buffer
+ */
+struct aipu_buf_request {
+       __u64 bytes;
+       __u32 align_in_page;
+       __u32 data_type;
+       struct aipu_buf_desc desc;
+};
+
+/**
+ * enum aipu_job_execution_flag - Flags for AIPU's executions
+ * @AIPU_JOB_EXEC_FLAG_NONE:       No flag
+ * @AIPU_JOB_EXEC_FLAG_SRAM_MUTEX: The job uses SoC SRAM exclusively.
+ */
+enum aipu_job_execution_flag {
+       AIPU_JOB_EXEC_FLAG_NONE =3D 0x0,
+       AIPU_JOB_EXEC_FLAG_SRAM_MUTEX =3D 0x1,
+};
+
+/**
+ * struct aipu_job_desc - Description of a job to be scheduled.
+ * @is_defer_run:      Reserve an AIPU core for this job and defer the run=
ning of it
+ * @version_compatible:Is this job compatible on AIPUs with different ISA =
version
+ * @core_id:           ID of the core requested to reserve for the deferre=
d job
+ * @do_trigger:        Trigger the previously scheduled deferred job to ru=
n
+ * @aipu_arch:         [must] Target device architecture
+ * @aipu_version:      [must] Target device ISA version
+ * @aipu_config:       [must] Target device configuration
+ * @start_pc_addr:     [must] Address of the start PC
+ * @intr_handler_addr: [must] Address of the AIPU interrupt handler
+ * @data_0_addr:       [must] Address of the 0th data buffer
+ * @data_1_addr:       [must] Address of the 1th data buffer
+ * @job_id:            [must] ID of this job
+ * @enable_prof:       Enable performance profiling counters in SoC (if an=
y)
+ * @enable_asid:       Enable ASID feature
+ * @enable_poll_opt:   Enable optimizations for job status polling
+ * @exec_flag:         Combinations of execution flags
+ *
+ * For fields is_defer_run/do_trigger/enable_prof/enable_asid/enable_poll_=
opt,
+ * set them to be 1/0 to enable/disable the corresponding operations.
+ */
+struct aipu_job_desc {
+       __u32 is_defer_run;
+       __u32 version_compatible;
+       __u32 core_id;
+       __u32 do_trigger;
+       __u32 aipu_arch;
+       __u32 aipu_version;
+       __u32 aipu_config;
+       __u64 start_pc_addr;
+       __u64 intr_handler_addr;
+       __u64 data_0_addr;
+       __u64 data_1_addr;
+       __u32 job_id;
+       __u32 enable_prof;
+       __u32 enable_asid;
+       __u32 enable_poll_opt;
+       __u32 exec_flag;
+};
+
+/**
+ * struct aipu_job_status_desc - Jod execution status.
+ * @job_id:    [kmd] Job ID
+ * @thread_id: [kmd] ID of the thread scheduled this job
+ * @state:     [kmd] Execution state: done or exception
+ * @pdata:     [kmd] External profiling results
+ */
+struct aipu_job_status_desc {
+       __u32 job_id;
+       __u32 thread_id;
+#define AIPU_JOB_STATE_DONE      0x1
+#define AIPU_JOB_STATE_EXCEPTION 0x2
+       __u32 state;
+       struct aipu_ext_profiling_data {
+               __s64 execution_time_ns; /* [kmd] Execution time */
+               __u32 rdata_tot_msb;     /* [kmd] Total read transactions (=
MSB) */
+               __u32 rdata_tot_lsb;     /* [kmd] Total read transactions (=
LSB) */
+               __u32 wdata_tot_msb;     /* [kmd] Total write transactions =
(MSB) */
+               __u32 wdata_tot_lsb;     /* [kmd] Total write transactions =
(LSB) */
+               __u32 tot_cycle_msb;     /* [kmd] Total cycle counts (MSB) =
*/
+               __u32 tot_cycle_lsb;     /* [kmd] Total cycle counts (LSB) =
*/
+       } pdata;
+};
+
+/**
+ * struct aipu_job_status_query - Query status of (a) job(s) scheduled bef=
ore.
+ * @max_cnt:        [must] Maximum number of job status to query
+ * @of_this_thread: [must] Get status of jobs scheduled by this thread/all=
 threads share fd (1/0)
+ * @status:         [alloc] Pointer to an array (length is max_cnt) to sto=
re the status
+ * @poll_cnt:       [kmd] Count of the successfully polled job(s)
+ */
+struct aipu_job_status_query {
+       __u32 max_cnt;
+       __u32 of_this_thread;
+       struct aipu_job_status_desc *status;
+       __u32 poll_cnt;
+};
+
+/**
+ * struct aipu_io_req - AIPU core IO operations request.
+ * @core_id: [must] Core ID
+ * @offset:  [must] Register offset
+ * @rw:      [must] Read or write operation
+ * @value:   [must]/[kmd] Value to be written/value readback
+ */
+struct aipu_io_req {
+       __u32 core_id;
+       __u32 offset;
+       enum aipu_rw_attr {
+               AIPU_IO_READ,
+               AIPU_IO_WRITE
+       } rw;
+       __u32 value;
+};
+
+/*
+ * AIPU IOCTL List
+ */
+#define AIPU_IOCTL_MAGIC 'A'
+/**
+ * DOC: AIPU_IOCTL_QUERY_CAP
+ *
+ * @Description
+ *
+ * ioctl to query the common capability of AIPUs
+ *
+ * User mode driver should call this before calling AIPU_IOCTL_QUERYCORECA=
P.
+ */
+#define AIPU_IOCTL_QUERY_CAP _IOR(AIPU_IOCTL_MAGIC,  0, struct aipu_cap)
+/**
+ * DOC: AIPU_IOCTL_QUERY_CORE_CAP
+ *
+ * @Description
+ *
+ * ioctl to query the capability of an AIPU core
+ *
+ * User mode driver only need to call this when the core count returned by=
 AIPU_IOCTL_QUERYCAP > 1.
+ */
+#define AIPU_IOCTL_QUERY_CORE_CAP _IOR(AIPU_IOCTL_MAGIC,  1, struct aipu_c=
ore_cap)
+/**
+ * DOC: AIPU_IOCTL_REQ_BUF
+ *
+ * @Description
+ *
+ * ioctl to request to allocate a coherent buffer
+ *
+ * This fails if kernel driver cannot find a free buffer meets the size/al=
ignment request.
+ */
+#define AIPU_IOCTL_REQ_BUF _IOWR(AIPU_IOCTL_MAGIC, 2, struct aipu_buf_requ=
est)
+/**
+ * DOC: AIPU_IOCTL_FREE_BUF
+ *
+ * @Description
+ *
+ * ioctl to request to free a coherent buffer allocated by AIPU_IOCTL_REQB=
UF
+ *
+ */
+#define AIPU_IOCTL_FREE_BUF _IOW(AIPU_IOCTL_MAGIC,  3, struct aipu_buf_des=
c)
+/**
+ * DOC: AIPU_IOCTL_DISABLE_SRAM
+ *
+ * @Description
+ *
+ * ioctl to disable the management of SoC SRAM in kernel driver
+ *
+ * This fails if the there is no SRAM in the system or the SRAM has alread=
y been allocated.
+ */
+#define AIPU_IOCTL_DISABLE_SRAM _IO(AIPU_IOCTL_MAGIC,  4)
+/**
+ * DOC: AIPU_IOCTL_ENABLE_SRAM
+ *
+ * @Description
+ *
+ * ioctl to enable the management of SoC SRAM in kernel driver disabled by=
 AIPU_IOCTL_DISABLE_SRAM
+ */
+#define AIPU_IOCTL_ENABLE_SRAM _IO(AIPU_IOCTL_MAGIC,  5)
+/**
+ * DOC: AIPU_IOCTL_SCHEDULE_JOB
+ *
+ * @Description
+ *
+ * ioctl to schedule a user job to kernel mode driver for execution
+ *
+ * This is a non-blocking operation therefore user mode driver should chec=
k the job status
+ * via AIPU_IOCTL_QUERY_STATUS.
+ */
+#define AIPU_IOCTL_SCHEDULE_JOB _IOW(AIPU_IOCTL_MAGIC,  6, struct aipu_job=
_desc)
+/**
+ * DOC: AIPU_IOCTL_QUERY_STATUS
+ *
+ * @Description
+ *
+ * ioctl to query the execution status of one or multiple scheduled job(s)
+ */
+#define AIPU_IOCTL_QUERY_STATUS _IOWR(AIPU_IOCTL_MAGIC, 7, struct aipu_job=
_status_query)
+/**
+ * DOC: AIPU_IOCTL_KILL_TIMEOUT_JOB
+ *
+ * @Description
+ *
+ * ioctl to kill a timeout job and clean it from kernel mode driver.
+ */
+#define AIPU_IOCTL_KILL_TIMEOUT_JOB _IOW(AIPU_IOCTL_MAGIC,  8, __u32)
+/**
+ * DOC: AIPU_IOCTL_REQ_IO
+ *
+ * @Description
+ *
+ * ioctl to read/write an external register of an AIPU core.
+ */
+#define AIPU_IOCTL_REQ_IO _IOWR(AIPU_IOCTL_MAGIC, 9, struct aipu_io_req)
+
+#endif /* __UAPI_MISC_ARMCHINA_AIPU_H__ */
--
2.17.1

IMPORTANT NOTICE: The contents of this email and any attachments may be pri=
vileged and confidential. If you are not the intended recipient, please del=
ete the email immediately. It is strictly prohibited to disclose the conten=
ts to any other person, use it for any purpose, or store or copy the inform=
ation in any medium. Thank you. =C2=A9Arm Technology (China) Co., Ltd copyr=
ight and reserve all rights. =E9=87=8D=E8=A6=81=E6=8F=90=E7=A4=BA=EF=BC=9A=
=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BB=BB=E4=BD=95=E9=
=99=84=E4=BB=B6=EF=BC=89=E5=8F=AF=E8=83=BD=E5=90=AB=E6=9C=89=E4=B8=93=E4=BE=
=9B=E6=98=8E=E7=A1=AE=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=9B=AE=E7=9A=84=
=E4=BD=BF=E7=94=A8=E7=9A=84=E6=9C=BA=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E5=
=B9=B6=E5=8F=97=E6=B3=95=E5=BE=8B=E4=BF=9D=E6=8A=A4=E3=80=82=E5=A6=82=E6=9E=
=9C=E6=82=A8=E5=B9=B6=E9=9D=9E=E8=AF=A5=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=
=E8=AF=B7=E7=AB=8B=E5=8D=B3=E5=88=A0=E9=99=A4=E6=AD=A4=E9=82=AE=E4=BB=B6=E3=
=80=82=E4=B8=A5=E7=A6=81=E9=80=9A=E8=BF=87=E4=BB=BB=E4=BD=95=E6=B8=A0=E9=81=
=93=EF=BC=8C=E4=BB=A5=E4=BB=BB=E4=BD=95=E7=9B=AE=E7=9A=84=EF=BC=8C=E5=90=91=
=E4=BB=BB=E4=BD=95=E4=BA=BA=E6=8A=AB=E9=9C=B2=E3=80=81=E5=82=A8=E5=AD=98=E6=
=88=96=E5=A4=8D=E5=88=B6=E9=82=AE=E4=BB=B6=E4=BF=A1=E6=81=AF=E6=88=96=E8=80=
=85=E6=8D=AE=E6=AD=A4=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=
=E3=80=82=E6=84=9F=E8=B0=A2=E6=82=A8=E7=9A=84=E9=85=8D=E5=90=88=E3=80=82 =
=C2=A9=E5=AE=89=E8=B0=8B=E7=A7=91=E6=8A=80=EF=BC=88=E4=B8=AD=E5=9B=BD=EF=BC=
=89=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8 =E7=89=88=E6=9D=83=E6=89=80=E6=9C=
=89=E5=B9=B6=E4=BF=9D=E7=95=99=E4=B8=80=E5=88=87=E6=9D=83=E5=88=A9=E3=80=82
