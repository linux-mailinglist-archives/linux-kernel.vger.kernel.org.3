Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1208D4AB8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiBGKjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbiBGKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:37 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58577C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0jZqocVOA6KYbHift0wA1rcWoHbfJmP0GPNRFEw4Jtpsx8Wiuj+CmFCU3Ze9gcaoouY2Wm+tjMUSkVzStBayUYEJnhNIR8L0+zUJPTHBi5F0LXj+w0b9bcEDBegSn8vSXsPHm/m0fzoEWTrPnalyc9eTQ5Jjx5aYTmVQeIv4tZ5zRZb+U2AROh+zFEV3+0KBjr2APVukJCchC38x6ZM2XFW7HBeKS/k6hdjJxYpbAzYoSMkRZUlve+ICPYkBgJQFXJklPNZ8fgxMkp29XA9qbpF6o2avk4Sw2A4RseEZRNgwg0How7VzIuxfz9Hwlfv1eLYi7AKi6j5s6/hz7peXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBZVU08s94mRSNwuZw2bx+ncfD8763kh2Les+YVlm64=;
 b=PtWBIPv6mSrY+qZKsioEgjO8I84IEjbFOTkq0GX6IFt42sH1JelunrODfR7mhRymII+K2Mgtt1bsjT2ZqKzlGUvpJ3waVMh1bxEFtaRAjK80U8zEsfZnB4Aj0uBJy2L94eW4KKSgwBP0SoPzUU37mWSQeTPuRWtOVTMQ+f7Qq5YY1Qb5gN63nigzavL+SQ9BGuEj1+3oulB2ubjcdnBoOBpM7sIn6ZzlzdZhh4cEL02DhxmFE1m906OBs/YAnUDwntw9SNeRXgiRImw0PiztT/n2TKRHLa7zkAttS6gt7tgPrVhPdVxzJlCAuoyX0GQ2wWamhLtz3e0lgCb6XXi8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBZVU08s94mRSNwuZw2bx+ncfD8763kh2Les+YVlm64=;
 b=dOXW7ug0i1KpKe+iapmSpmMMrqvQUHe0lO31iT4vJhaH3XAZ4zGMemxcsjeU80gXKOhKQiG2fxD4xw5l4+PkmkuG4U9jzfDk3Mg22SBfzSuKVHGwZj4kN74eewicVIYSoPmi5/Pmm43w/GM4r0I2YLHMmILI/K8fLp4tdruSU7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:33 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:33 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v3 2/8] VMCI: dma dg: add MMIO access to registers
Date:   Mon,  7 Feb 2022 02:27:19 -0800
Message-Id: <20220207102725.2742-3-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207102725.2742-1-jhansen@vmware.com>
References: <20220207102725.2742-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4835631f-b7d2-4002-6f31-08d9ea254a14
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB368613CB9A3CBEE9478F76DDDA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YzWQ5PtxS98dfU4jM91roZf+R/zrx+Im2pfo4F+yzgymn6o+y9mZih++/iihT9Qu9CW5EHgGPGobN4K6oOBzHH13rWBR6PuMB3MqxefUf3jSDJhRYhESgZizgSzz9tGl8EAAhs94aj/B4OMTIjxCvJdM2YfjfQ3dA6GF2gi+ofnIQUEmHa/qxFz3O30Gh5r6bn8+fENqqBdEIX4yYzYWEGIOYcO6jQQ7UIDiHbJWG+F0eRmaPYEl/Yp2BBC2y5LC1VETGeNFtMld3RpMC4iD8rsk07dtUURFTJMKpam2F4gF+VGTMeqJxc/dGhmsYxEncDpazRvOkI2Pvpbm4dbUb+lLYNpy1Yi0vXWOiLXIUJN57syJStex3egeH9jQbUTcpha+2C7zbg/2qdldziMIuGhNFhoAo/2UNXzZF7jr/+cUYgWs5ZS6Q1YfKAS9wUlI9Pi4cHcleh6BYBBrlWm4g1+blXCSYneaJp4GcbN71PScvYAkUOzT4uZaTebIejUBRsKwkmdnmyI+ery8DjxCiNpDpHQrJlVgw5Uwz2LkWDCk/9mmCxT3C30eeEE8/DDNMIQkjd4B4vKAGXkJIsFv4DgZK3BusmwFbQghUDjA0Z5UgK6+9HY2UxzVHvqFKKjzhzcxnKpfr0LKDdBJ+1uZ4gl06TGg9gb6KvyokvZrJFsripob7Ql9lBfQiwC7RZY3APjxE6Yat6UW5EpSeNREXN7zW+WGO9CoJImPW8Fq0WK2I8MvI9pJYJUDZlUKlIa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4FxIeZwZ8BDWTIbMGb846xy2NisHIC6+nnfS3YKI1K/YPABLaxgETizv6qi?=
 =?us-ascii?Q?XA+aI/Ex/Ebyt5UkZDpxTGmAv2wBeZH5eP3DFDaSQC8fdMdEssKHg16Wbq/B?=
 =?us-ascii?Q?Wt7RmC722sSDpcsLTevzTjxMLX0Hs+L9g8v61rb1wR3QNFLy6IbLwAUXKCUp?=
 =?us-ascii?Q?yBrpbwYiAKMrRY9D2hSx0U36ZeQbaehPMAwxqmyHso+RC5iyU9LR88AcJ4rF?=
 =?us-ascii?Q?75nRYe9k5V2bGQL+YVsZupqgWf4jMLR85+qydpUZNgAbBbnOvuMUh0Vn1180?=
 =?us-ascii?Q?js2up/1AacqduQHFf5W5/OSK90uWERFIVUb+oQhTPhTAVkz/Gkvp0iZLdkQr?=
 =?us-ascii?Q?zElSDKb69V52V/sT9fquzNUB/Re9jYHzUe/25ro6BzeMnlCFe68rEG9rIoGy?=
 =?us-ascii?Q?6BM8nPlXNlkyQwDxdrZPPBXUazF0bz47RBISn3eUZSJQv9akra+o/w9s+h1y?=
 =?us-ascii?Q?qrJDpjhDp6OUYKMTLpNIOdp8WgpFu6MYP5ct7I4IJEZk6jj6OOgzNBjzU9Qc?=
 =?us-ascii?Q?W+LeeeYt6J4t4Ip7uaPHkSOFW15lSHBhp31GrH7dduCuOeRoydZuAJ38P3IU?=
 =?us-ascii?Q?z1V264JvR5LHXO7runwADPnmkfaXK+WLbRgJRAnz3WfpbhjdPhi59/hzIQrc?=
 =?us-ascii?Q?y4MOjZUmXE5xL2DxHy06qwK2dEqfI2JUdJI+6Jvnsx4Ldqocsb5z6qJN1Sjv?=
 =?us-ascii?Q?8Tw7zRazEtudaCOgJQB5o427UepbzL+uJVWfHfsWM1g21tZ8GfxXNCVxd1wG?=
 =?us-ascii?Q?PzAxea/OocjiKp85h1VnnRSs70MALYq3pZAi+rwBmsW6MHWHbuAx0RYymw36?=
 =?us-ascii?Q?YEooLmHRqfOoldtK0T0BN6NAM4XQYhM7Bbo2TNpQfKdObsrVvWqIlyCU5S3T?=
 =?us-ascii?Q?AkzZsI/aRdco+nPWshLZSfJxBLCp7LHUw994q4PxEHsyE2aRLFw6TniJmCff?=
 =?us-ascii?Q?3Em83EgNbyG/za1KGEN9fR2Vuz28tX0HVHEnKrh6oEN6fYsN8C40mOVVB8k3?=
 =?us-ascii?Q?pnG2a9NLr58tskwR8bVNKITZhFirA/R1N8xMjx3XkRkJvHq5YP2hOd/TaiLO?=
 =?us-ascii?Q?XLQE2wQACJJmJil1fsk4ROQM9RpBo+zCo+ijyD/sYNzWxQwRGG9g/rBdn+tg?=
 =?us-ascii?Q?0mQR1eRojAJWQ0apfU3sz+pzMhj42YWMNfYiaPKUqOhLmRjy7UTzkLieoPUr?=
 =?us-ascii?Q?clR2d/9J5hLCA/n32pNExEG2/YBxwCikJ2ZRUo4GKx6VdBrCvzI3G3K0Dc/6?=
 =?us-ascii?Q?tsAX794lQPD4GsWYVprfUZj5hRMlfdR9gSRF5/8YwoxZd4ydmRa+AFSQkOCz?=
 =?us-ascii?Q?PLaoYl9XHEgehYNxUoxvj/7VuejxBMHbofBFZ2KFlL3xLoEro3o7lP4e03s3?=
 =?us-ascii?Q?dFkX0ziBTmX9KxPGO1E6M//opRti50NEdISJjTvwJ9wuK+e7NfVHCNZayzjo?=
 =?us-ascii?Q?cS30mIZ3eia8ugffsN7oW4xG7xjaiH8xT+EoU69SKbQBt2lDXYzXKlFCmKym?=
 =?us-ascii?Q?rqmQyGAK7Vr+ZbtjpwEylFSJ8C7OKxkPAHa64pd/2ew0hjsqirvWJMG0PACG?=
 =?us-ascii?Q?yuh1NA48mFeSVvIcdY0ZtWl+83wmf9AURCVIifdPRdjsc6k3lhDRwmfxcilQ?=
 =?us-ascii?Q?MX6PrjYWy6yuKMN6bIATh+4=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4835631f-b7d2-4002-6f31-08d9ea254a14
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:33.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5KdDcDkQJYS3O9qYbSZedXO9e03pbAbuPOBSuHj6WiPW9lDuTKkozoiNGdagk3tuPX8JemBBki4HsuMpo3tTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect the support for MMIO access through examination of the length
of the region requested in BAR1. If it is 256KB, the VMCI device
supports MMIO access to registers.

If MMIO access is supported, map the area of the region used for
MMIO access (64KB size at offset 128KB).

Add wrapper functions for accessing 32 bit register accesses through
either MMIO or IO ports based on device configuration.

Sending and receiving datagrams through iowrite8_rep/ioread8_rep is
left unchanged for now, and will be addressed in a later change.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 67 +++++++++++++++++++++---------
 include/linux/vmw_vmci_defs.h      | 12 ++++++
 2 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 1018dc77269d..d30d66258e52 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -45,6 +45,7 @@ static u32 vm_context_id = VMCI_INVALID_ID;
 struct vmci_guest_device {
 	struct device *dev;	/* PCI device we are attached to */
 	void __iomem *iobase;
+	void __iomem *mmio_base;
 
 	bool exclusive_vectors;
 
@@ -89,6 +90,21 @@ u32 vmci_get_vm_context_id(void)
 	return vm_context_id;
 }
 
+static unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
+{
+	if (dev->mmio_base != NULL)
+		return readl(dev->mmio_base + reg);
+	return ioread32(dev->iobase + reg);
+}
+
+static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
+{
+	if (dev->mmio_base != NULL)
+		writel(val, dev->mmio_base + reg);
+	else
+		iowrite32(val, dev->iobase + reg);
+}
+
 /*
  * VM to hypervisor call mechanism. We use the standard VMware naming
  * convention since shared code is calling this function as well.
@@ -116,7 +132,7 @@ int vmci_send_datagram(struct vmci_datagram *dg)
 	if (vmci_dev_g) {
 		iowrite8_rep(vmci_dev_g->iobase + VMCI_DATA_OUT_ADDR,
 			     dg, VMCI_DG_SIZE(dg));
-		result = ioread32(vmci_dev_g->iobase + VMCI_RESULT_LOW_ADDR);
+		result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
 	} else {
 		result = VMCI_ERROR_UNAVAILABLE;
 	}
@@ -384,7 +400,7 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
 		unsigned int icr;
 
 		/* Acknowledge interrupt and determine what needs doing. */
-		icr = ioread32(dev->iobase + VMCI_ICR_ADDR);
+		icr = vmci_read_reg(dev, VMCI_ICR_ADDR);
 		if (icr == 0 || icr == ~0)
 			return IRQ_NONE;
 
@@ -429,7 +445,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	struct vmci_guest_device *vmci_dev;
-	void __iomem *iobase;
+	void __iomem *iobase = NULL;
+	void __iomem *mmio_base = NULL;
 	unsigned int capabilities;
 	unsigned int caps_in_use;
 	unsigned long cmd;
@@ -445,16 +462,29 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		return error;
 	}
 
-	error = pcim_iomap_regions(pdev, 1 << 0, KBUILD_MODNAME);
-	if (error) {
-		dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
-		return error;
-	}
+	/*
+	 * The VMCI device with mmio access to registers requests 256KB
+	 * for BAR1. If present, driver will use new VMCI device
+	 * functionality for register access and datagram send/recv.
+	 */
 
-	iobase = pcim_iomap_table(pdev)[0];
+	if (pci_resource_len(pdev, 1) == VMCI_WITH_MMIO_ACCESS_BAR_SIZE) {
+		dev_info(&pdev->dev, "MMIO register access is available\n");
+		mmio_base = pci_iomap_range(pdev, 1, VMCI_MMIO_ACCESS_OFFSET,
+					    VMCI_MMIO_ACCESS_SIZE);
+		/* If the map fails, we fall back to IOIO access. */
+		if (!mmio_base)
+			dev_warn(&pdev->dev, "Failed to map MMIO register access\n");
+	}
 
-	dev_info(&pdev->dev, "Found VMCI PCI device at %#lx, irq %u\n",
-		 (unsigned long)iobase, pdev->irq);
+	if (!mmio_base) {
+		error = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
+		if (error) {
+			dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
+			return error;
+		}
+		iobase = pcim_iomap_table(pdev)[0];
+	}
 
 	vmci_dev = devm_kzalloc(&pdev->dev, sizeof(*vmci_dev), GFP_KERNEL);
 	if (!vmci_dev) {
@@ -466,6 +496,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_dev->dev = &pdev->dev;
 	vmci_dev->exclusive_vectors = false;
 	vmci_dev->iobase = iobase;
+	vmci_dev->mmio_base = mmio_base;
 
 	tasklet_init(&vmci_dev->datagram_tasklet,
 		     vmci_dispatch_dgs, (unsigned long)vmci_dev);
@@ -490,7 +521,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	 *
 	 * Right now, we need datagrams. There are no fallbacks.
 	 */
-	capabilities = ioread32(vmci_dev->iobase + VMCI_CAPS_ADDR);
+	capabilities = vmci_read_reg(vmci_dev, VMCI_CAPS_ADDR);
 	if (!(capabilities & VMCI_CAPS_DATAGRAM)) {
 		dev_err(&pdev->dev, "Device does not support datagrams\n");
 		error = -ENXIO;
@@ -534,7 +565,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	dev_info(&pdev->dev, "Using capabilities 0x%x\n", caps_in_use);
 
 	/* Let the host know which capabilities we intend to use. */
-	iowrite32(caps_in_use, vmci_dev->iobase + VMCI_CAPS_ADDR);
+	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
 
 	/* Set up global device so that we can start sending datagrams */
 	spin_lock_irq(&vmci_dev_spinlock);
@@ -630,11 +661,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	cmd = VMCI_IMR_DATAGRAM;
 	if (caps_in_use & VMCI_CAPS_NOTIFICATIONS)
 		cmd |= VMCI_IMR_NOTIFICATION;
-	iowrite32(cmd, vmci_dev->iobase + VMCI_IMR_ADDR);
+	vmci_write_reg(vmci_dev, cmd, VMCI_IMR_ADDR);
 
 	/* Enable interrupts. */
-	iowrite32(VMCI_CONTROL_INT_ENABLE,
-		  vmci_dev->iobase + VMCI_CONTROL_ADDR);
+	vmci_write_reg(vmci_dev, VMCI_CONTROL_INT_ENABLE, VMCI_CONTROL_ADDR);
 
 	pci_set_drvdata(pdev, vmci_dev);
 
@@ -657,8 +687,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 
 err_remove_bitmap:
 	if (vmci_dev->notification_bitmap) {
-		iowrite32(VMCI_CONTROL_RESET,
-			  vmci_dev->iobase + VMCI_CONTROL_ADDR);
+		vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
 		dma_free_coherent(&pdev->dev, PAGE_SIZE,
 				  vmci_dev->notification_bitmap,
 				  vmci_dev->notification_base);
@@ -700,7 +729,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 	spin_unlock_irq(&vmci_dev_spinlock);
 
 	dev_dbg(&pdev->dev, "Resetting vmci device\n");
-	iowrite32(VMCI_CONTROL_RESET, vmci_dev->iobase + VMCI_CONTROL_ADDR);
+	vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
 
 	/*
 	 * Free IRQ and then disable MSI/MSI-X as appropriate.  For
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 9911ecfc18ba..8fc00e2685cf 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -82,6 +82,18 @@ enum {
  */
 #define VMCI_MAX_PINNED_QP_MEMORY ((size_t)(32 * 1024))
 
+/*
+ * The version of the VMCI device that supports MMIO access to registers
+ * requests 256KB for BAR1 whereas the version of VMCI that supports
+ * MSI/MSI-X only requests 8KB. The layout of the larger 256KB region is:
+ * - the first 128KB are used for MSI/MSI-X.
+ * - the following 64KB are used for MMIO register access.
+ * - the remaining 64KB are unused.
+ */
+#define VMCI_WITH_MMIO_ACCESS_BAR_SIZE ((size_t)(256 * 1024))
+#define VMCI_MMIO_ACCESS_OFFSET        ((size_t)(128 * 1024))
+#define VMCI_MMIO_ACCESS_SIZE          ((size_t)(64 * 1024))
+
 /*
  * We have a fixed set of resource IDs available in the VMX.
  * This allows us to have a very simple implementation since we statically
-- 
2.25.1

