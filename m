Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386F54A8510
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350794AbiBCNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:32 -0500
Received: from mail-bn1nam07on2040.outbound.protection.outlook.com ([40.107.212.40]:28852
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350730AbiBCNSU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxNSlvZnsly9u6Q+2ytbiiDB0FBViZj2xx3muBFGG9cyBnW87cDJ910NA0f7r9+RpN8HKFemAu+upZ6GDGVylmCJImhy0b4ylKD2bOpQ02JG5Iq5FaUmLY7vRyHAR+04lwBZ+xTDKhXw5EftWVZIKFPevF2jasoCv+EQwEPD8WlEhhN8gXJx4WX1Z8T7Sztgbi6Ax8lzIDuhzSGWCUhTLV4aCUS+HgLSyf21DiIaM5TLdXknCmwJJi8k/QA0uSAfOvtyGPstzlI1QQUuMV7qGGcpHyfECHu3ImKiCpdNrKVDjtkgfsYMo4AzP18I+ym+v+HQnCNFNxhXIlvFPB4DZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUQ+unZDvZGklvySQJULeyhXYtNBLrF+Oz271pXI3VY=;
 b=Dju1s/IR8Qf0bNRdVpuiBSSjouZe9QNrqSaGlnFGaL1sA9p8DnjMbtdja8UbBds0hFjOd5ilFuwC3s4thBJcowmITcEG5M12wkzpjXu9JFfm1tiLcS8AYtYGaM3E3VBgle6hkJ9tIHRYpkKVnmqjLxJv+xet0WsKT5ji9PqFud6JGpU9f72Ra5ARO3jSOHPzlTSp8iChr6vU9qGvnRGFIsCaQB4CK6RxmLV+F3U8f2UMGpA64dJrXUPoHidFiOOHGGZlx0ekPLSqFeG/JuTbLvx8gkDeFmXsx5MQ1ZWTieBFhGwpu9nCtrwtFWt44YlT1BqUeOCZWENXc8oBZlGhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUQ+unZDvZGklvySQJULeyhXYtNBLrF+Oz271pXI3VY=;
 b=B4eryD+P8PjzAsoFn1HBdjdSjQBKl3uOkI2la+M3rLNbBASrb+NH7RUu3YsnJVEFPKlE88mcMpvfixDMInAkL0CPvEysFST1nMH9gxk/qYqWoHo0+JzvzFI998LcS1oAqTH8D/Lum75H/s+r2+00Ngii5itDT97oT4ztnQXREN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:17 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:17 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v2 4/8] VMCI: dma dg: set OS page size
Date:   Thu,  3 Feb 2022 05:12:33 -0800
Message-Id: <20220203131237.3380-5-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203131237.3380-1-jhansen@vmware.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d95cbdc3-2f1e-465f-6057-08d9e717a300
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB7150090F6B0A90E9D407AC97DA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bj94/aKxErZcQh7QegFCvKiFKWu+1G9dUjgntd4DaATAokDb30Ly/8DpsCIDpvTMaBcauYIhqwd8lRn3tN6B8CPcMjkAbDTxBdLxt3+HjS13B4X3w21vyP0AzYoBonYiuWm/liTbDDfcjRPZzXTr6AmBOdxMqOLkLX83FaRksl5GhTwjariVCNBcpT+NmPRHglkvZtSb8XY6n5xwwjSsLtPSfpSP9wcidfqVpMWtMyuVBa1+AqbM9khTRC/GuDCYsA2yrWZmVGZaHFEeQFo5lo7HqrFwfWRSVw9/hw5H6A4J/gqvR/wuvE5xClRA7tghsDRBumrv9O2SK3aWKSqrEJAr37VGGmfmVKoF/4bhjrxHy39ImA0cCa32yEgWbprNSfsMZaZ0iPCbD6I5hssiWPACIra5mtQhNg3dijrWdc+ROp10bnqerEXOFVnkAynMDPnHsgnT4OdxGJ0Eeu5Hno50UbXpSVJNrWUlTrpBYLQZZd9cuvAWLqyuYlLBeZHyJQuPmTlcYOv8idqd1EORE6Ghu8oLgdfjFgv10eA58R+EIquebaOdm1gwIU/a8vVcHzPedv6ZJIDsKhPlnswKnlicj4g6gupdfE7GkDFF2sot4voYg8ixnQVK0x0Vl45h5Dnmga5KUIsTHdvE0V/GdbmJ+W5gC78sUelGPNJoUswXFyiR+lY62nHiqZHLPSeb4lzCUXoijxM7ibPPf8YO7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yLulj6wanE/4CRxPVmLn80JVkt+B2yT6G3QSPgi7SIW1aCStKvqJqlhB9o9a?=
 =?us-ascii?Q?MRF0nzA/ptrxhkLeSgFc1oK5Yp5UNY7GKm7dEYM4uRrZS+h7108hG2UuHiJ6?=
 =?us-ascii?Q?GSvFOoFHtP8ucKtnxSuSaAjFoUrVkMLFROrHM32bESEICTnsZTCMY5PoseFa?=
 =?us-ascii?Q?Fimk+98xDKcgdtnOHFZ7lShLVT7kzDF7eqVcQBMzG6dhBmlwW3cObBD8Dces?=
 =?us-ascii?Q?my51xvzJhIuv9PF7N7bTsFQ0WrW0r9I81Wn1FkrO1SC8mGAyvgeIrKCtu1h1?=
 =?us-ascii?Q?LCbwpVJfRE4jxEiibzxjb+/KLZE2y7zJkVWXuOYrdwrzs+2dU+rpiob/1Bj3?=
 =?us-ascii?Q?DYlDdrHpH+fu9p8iCjQnIuX+uJPahEztvWzLafJ3PW5WU5b6G/lFihbG2rZr?=
 =?us-ascii?Q?H8W0nY9UVPR73MAxRpd9v9wLpBmSk3kaQa+5TbAn2+JVZhF5qm/FfT28gV5b?=
 =?us-ascii?Q?Hd4NJFWNRPiHdQ6TGVSdSudFdqMyPkbmHYTSKChDtt8v5oAfu12yH0Ci3KST?=
 =?us-ascii?Q?PCGvC7JvpoZVVQh5+FPjxzD9S9WaTQbrm6rcvqS/sywuKoUPPOqcuMDY3bTv?=
 =?us-ascii?Q?3hcY9f3jDNngK+wsnLnZ0hEqt0JWeBnF1MSy+SUgZtdGsy7bJGognuZ7cfIb?=
 =?us-ascii?Q?Ha/B6DSYsW4ia0q8GMlF+nvJO95+EamYn5dYlyV0r2bimfaLYkJma7Pe8klM?=
 =?us-ascii?Q?KVHSkOxQTM7VNDHEWVE66al9vxaPjG8vQwAet4dlMoJQOK93yRkcm+MkvQqs?=
 =?us-ascii?Q?qz7utsBVXQ27L/ooem5DeaNj9Hw/1f9dVJk1nc5tpeMRJ4g/O+yfF+t8lSzU?=
 =?us-ascii?Q?/O+/TEO0mJh3ar3aW/CEzxsGG0+CwpEZuFAuAWQRoUqRFwmhuCs56tw1uTOb?=
 =?us-ascii?Q?l6qM0fELlZVEjCNAWBuK82Q1bUUzkQ5hu0bXq2xy3X1GrA0YzmKNbjAJqi+Q?=
 =?us-ascii?Q?PFCvgOV86Tb26qXV61cIqz8Tb8PfLN0uUY+qaBD+PmLNKWPZR31SxI/gbA6R?=
 =?us-ascii?Q?ENw180coprQveXcnekpYsyDt25H1v9Bwqp80BeEa/uwG6ziG+GzMw5odvpNK?=
 =?us-ascii?Q?OtOZVpXAcYewNaz6HF1fHszyibrUhRwWckJ1ZTGfAoDL6U/Q1O2cyDTBaS3p?=
 =?us-ascii?Q?u6J9kiWcgUJepACCKYFmSoXMBLm9Jv6d2+5YOUmHZjPRVO1/9l6cFq2wCcm/?=
 =?us-ascii?Q?0qTF6ZPagHHsaqunyL+Gg2Q7oAXjm14K9C9ZXIJLAXa8/2+/FqUw2QInciv3?=
 =?us-ascii?Q?xlvn5VQPugQqNLhUyxuyuRbZnlrR6XBmWYucQTvj5sN+4d/iEIsZlYHpzPTS?=
 =?us-ascii?Q?++bTlsLk3WQ7IYAikjZx3FxSYDbVnx7RZ7c3fE8mqjKeEMget2ZRGYgCvGpj?=
 =?us-ascii?Q?pIdnGS6YDdRB7lUH0nDtkWYRka4TerAtIARMeDb2u24+Ib7AIZuEkQWLQvhG?=
 =?us-ascii?Q?HB71o6/yHPu7k5nwbyMLst2R3HvjudWkMtp6YmgAsegBF964c/xTFn0On9eq?=
 =?us-ascii?Q?Jjf2Gvrjqt1c2cgnpGhx+846JwPzbtENNwhlK9nVZtrL0RFyuSaogG+sfqds?=
 =?us-ascii?Q?aUc/guqkMbMiR5CgrKd10HVnNVeiqSpafLm+vchd5Cs0X9zrR8UgeY7EvYHv?=
 =?us-ascii?Q?mbf93WW3/3qe1UdAvfkqvgs=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95cbdc3-2f1e-465f-6057-08d9e717a300
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:15.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVi+/JZILtFphWBgy3YOuRHF10TstVnsqjElsG+Ahj23O2JtBqyJ8RPBLlvsDl8T3NZFAh4YnBxDESnt+6xtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tell the device the page size used by the OS.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++++++
 include/linux/vmw_vmci_defs.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 5a99d8e27873..808680dc0820 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -581,6 +581,15 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	/* Let the host know which capabilities we intend to use. */
 	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
 
+	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM) {
+		uint32_t page_shift;
+
+		/* Let the device know the size for pages passed down. */
+		vmci_write_reg(vmci_dev, PAGE_SHIFT, VMCI_GUEST_PAGE_SHIFT);
+		page_shift = vmci_read_reg(vmci_dev, VMCI_GUEST_PAGE_SHIFT);
+		dev_info(&pdev->dev, "Using page shift %d\n", page_shift);
+	}
+
 	/* Set up global device so that we can start sending datagrams */
 	spin_lock_irq(&vmci_dev_spinlock);
 	vmci_dev_g = vmci_dev;
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 1ce2cffdc3ae..4167779469fd 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -21,6 +21,7 @@
 #define VMCI_CAPS_ADDR          0x18
 #define VMCI_RESULT_LOW_ADDR    0x1c
 #define VMCI_RESULT_HIGH_ADDR   0x20
+#define VMCI_GUEST_PAGE_SHIFT   0x34
 
 /* Max number of devices. */
 #define VMCI_MAX_DEVICES 1
-- 
2.25.1

