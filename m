Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6084AB8E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiBGKiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbiBGKdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC031C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I55P15tUVX667J+PxP/EAHxgmvJNJpXBTBtPHYW50hlc4fvX9kN9o2Jwp+yHPeIXs/rc1qz3cTqnTc4OJ5oOzqWDY/lKEDXEJ/8NsBYG2IasxCkBU2CC9j0k5IsAvXTzu5CEpdP115qBOMOa3MPUOCMTr+O05X29jrm1ctWEhBjqNQkfxqbbPHN+m0JDRSFZ/OOMHjmked0XNh4LWGmXr5muDLWxvesIbbtf2tFAeUu/lAbTS24pDXSYV99iHy/TUDRu8ro3qLy61dUubcxnpqsMaBtv9fAzSdDgdNZNqmQ2y/SfTQUllovcOwn6XbpjxzCCFccVUSBjzk/dAs+KeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVUf8vTlnwEpsKJIaJvZ8RIuqty4+Tm+50iTflCcDhg=;
 b=XTn6pvTCnZZcUp7o7zaisWioPMTIhySTpjY1PtrQ22xcqw6GsFeirXmUF9inxIpPRp8sBo6yHsjLmB/QxtVA9mI+AVpW5+kkvfNE7TRygzNgzKdN2V/Xk5AZOPqeAa2xL+hkRpasdlon9/jU9ue5sFwhnAVvLLBPyJnj+OFxu6geXe6N3BkH4Np+DQ65V+4TigJdfFHkIdUL8iCE2bZqyO0uN7ToAtncx86rzkaJLGETiuUfGhqzz8WFDHOrt1Aci8OH9/ID5GAQIyj0ryExhwH0s5Q6dHoSNt2tJzoKUif3/5L71FShSQZp0NljnMODer5aJTY3weSaIHyM30WpGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVUf8vTlnwEpsKJIaJvZ8RIuqty4+Tm+50iTflCcDhg=;
 b=uTsgyKRn5aiMYdFWjPb4KulWRyCbSdeMBQwipfIFIdS9itAeJUIvpTTJMp3Ax1X1+35DqQmLLMqLhTTRqCT0VIySWEW6TDJGUk2dA5JXixVCGDud8v5TP+6iRIxUMIRUVzoQC7tuT53N2GT2LQz1ks4z0fIzQ4bxwEN12bqCC2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:35 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:35 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v3 6/8] VMCI: dma dg: allocate send and receive buffers for DMA datagrams
Date:   Mon,  7 Feb 2022 02:27:23 -0800
Message-Id: <20220207102725.2742-7-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: e929a17d-0072-4f0e-7823-08d9ea254b2b
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB3686BF3CEF8AF5E10E4F7281DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rgWGgiWOUBk1CmHoAfTPHXPKgUOSuec4tiHYXkDdbVCXnk+VoH5HNybJz/AeY83SI5yqU9loWX907z2y0j6EGt4NNwCPyrYYShH9s3s5u9DWwPn2P0Jh8qNPB0ELpjueHsSkYipWmkFrjhdebjn553XMQZTj772/3FHUg+UzaZbaOaBgJWLsQlx/E/vyC8EefqwYMmuR3ihIkGYg87mDi2KaZf5dxfETmMoj219NI7tGYQc8Yy2KTe6g8xARBi+9AbGmys7/gA/Vr/0QDq/0g+oKXJ0YjYK4xabR/11b7rUm/0lhe6KtOMZWcn41Y1QWK7vvevES882T4r05ONFu1Pa34yVVgho7XmXBqG+fGy2jJ0gIyToqxfCHbR5aJd6CCDnZ8MfbnEigfI86aKIWDd2M0hrzlREyIcH88I0dMnyzLRquGDLH1AZL/eQpuFYyVVaakGucV3+0h1Tw8ikHU/70IUQp5DynsxjBhxK8TAPkhMfZzLQ02c9/TwWazBPk1PfQJAjkPjM61nd7TBFQZgcHyjjYH9k4N1KlgKAoiPYNMYX+WKpEakM3kbFhh5OdJqTomc3TaGvTdGVInM22uKuSSR1VvxamVkZCbXDtqakGyjRL9NiOM56AepbczMDHu1+FVFkXatr5nJfTJkygnEsenrq7C8/pohZd7qyjT31hTxdRN+RSWgaOwJFziFxio+Zal2xyBWBvpHTDoq2B2T+3RSIOYU8pP412OFCsoFTkHHrDS3qbyNy1aC5eAW4v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AptgWrQdNFYnxcGmTMvlWdZJeYX3gYBEAIbFYTHyNDS2bfEcpXHcf/uZmA7s?=
 =?us-ascii?Q?Zjg63ZipA9+ac7/OeoATXm/cB92KBe+RpjCexIFkRj1IWR/txSayW+xdh8lh?=
 =?us-ascii?Q?Me3w8lAEwoXKZhdHrO3fffVC3Nqed8Afvw4yJg7goQNTOz3cw0TDXl6ilUMK?=
 =?us-ascii?Q?0ZKUJVh6mMsVESz3/+Y1qbHl7Ebr1lojCsfN8/MGZD+O0F/yI+eHg8Aq8DJo?=
 =?us-ascii?Q?IXKpwe/38hszCodyrl9FUUhKbhkZCD3ftu22wtRo1b6dc1QWMqTNSJkHshCZ?=
 =?us-ascii?Q?XljimPrHIEMuO9ZwdpmRG3ncDMWrcFemU14CmlFeZxAK/FzG75mcC1rRkQyH?=
 =?us-ascii?Q?LF0u+/5z/j6v1T5V2WzU//ZuD4pVoivf2dbF2rA/T4npz1vpK04h3wVTewPj?=
 =?us-ascii?Q?kNAEn/Aw/uK1fVNQmc4hqSxinVrm/O6awhXnsxVctBdOKe+oLSUBD04q+6O0?=
 =?us-ascii?Q?evfoWrtQz5decrevnRHxCLa9fZXTenwePde9CePeiRral0EvicPII6CeqA11?=
 =?us-ascii?Q?AYc8eQutH5Np81wZomjnb/Bf6JLgTbPnZpBlLP0JUCZ1wn9dm9wRT08Ghcmx?=
 =?us-ascii?Q?/lTWR05goi8rWlLnJjzKF63tQhmuBNPzZ1dQAmBmlhph704ah5tePewi4sEe?=
 =?us-ascii?Q?YHtkEABInQdFdJtdksQ3VZpjxp4cVgJRAP5JVPmJIgejMipdcLh7bShBaK7a?=
 =?us-ascii?Q?8FYx1JZ2yRFPQEgrijHoZrJCIMaFHXlz1i5Vad2rWYEVceIFVG57y11qUQeD?=
 =?us-ascii?Q?4BlVipI5eVez+DzoVygKvMCuyEDNwrZH0B1KYTD7JTswXzW7Fvm6L5knS+Vk?=
 =?us-ascii?Q?Y2vRFtA9cVb2Q2JpFMECqGsfpFXQ5XHpKnu2gfZFAa1r8RxGLOXhCB4nVDy6?=
 =?us-ascii?Q?+PsuFYnJwzauxCyl4LV7ROaJxH72xD2TuUTcwqVJf1R5K+fT5Rt8TZsyA2J/?=
 =?us-ascii?Q?WWTwxSRcsjKlaW8p628lvzmwd087zXPCrJ4ntfioVRxLfXNuFCGY9XAd+nFt?=
 =?us-ascii?Q?Q2HQ9ehfeXeWHvk7xhPOZ+jWv8Qc9yNihqzYiQFGNmxbNeKtgZhwSPXW5VKL?=
 =?us-ascii?Q?gKFKtg8BgBxoENCWNoQmwQDf9IuzqbrEWdQaHmutfM0vZwdRJm+7XFD7NUce?=
 =?us-ascii?Q?qywaH4NAL30FnFS6o8fhgYvolWyKDMofLu/P0Kcy6qQxOHwwJ4funu1L/5z4?=
 =?us-ascii?Q?whX6XLFrfIEZV33+WPNx6VqCSlVhFwQBZkVDksmh8p/9DSxOipAAPzIld++l?=
 =?us-ascii?Q?TyhMItyU64WiojZdtD7TCtdIRxVUW+eOnxq1z45+yZp+bt/fzZILl+urkTGm?=
 =?us-ascii?Q?tdJP76L4ttrfXzggTZMBgezZk2ViemTdD9THKZEGZXS0wC3r9CfGMWVwyUiC?=
 =?us-ascii?Q?aj5jf/SdA3oFExSBGWUm+9EoBi5O6lVjjKNwxNP2wWi8XYJxjE1OmdFecDjx?=
 =?us-ascii?Q?i6v9ysovcmpP9rB9RdlMOAQD7MhKTnRXmxiNZMWRqNBKVXERezKpyEUqR8Ks?=
 =?us-ascii?Q?V65Vk+UmL+ICdbw4YEHV+fNQn/fDMM9jYjYeiF9m5yQaPLO6zzwp8MaMs7DR?=
 =?us-ascii?Q?JeL1s5gvg0y72AvdNNCFz7EIQMQYEMJPJWk4kpPlPbTQilWL60ltkeQro4Te?=
 =?us-ascii?Q?SnelclO8Q5BztxZduZUPSf8=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e929a17d-0072-4f0e-7823-08d9ea254b2b
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:34.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUSrL1LBMtfykTiX6M4XRV627PEQwDPDLPN8ntHlNvZtawrMEdbMylwX1gEL3q/Gg8xPFU+VSsOLRpPoepEHhg==
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

If DMA datagrams are used, allocate send and receive buffers
in coherent DMA memory.

This is done in preparation for the send and receive datagram
operations, where the buffers are used for the exchange of data
between driver and device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 71 ++++++++++++++++++++++++++----
 include/linux/vmw_vmci_defs.h      |  4 ++
 2 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index acef19c562b3..36eade15ba87 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -31,6 +31,12 @@
 
 #define VMCI_UTIL_NUM_RESOURCES 1
 
+/*
+ * Datagram buffers for DMA send/receive must accommodate at least
+ * a maximum sized datagram and the header.
+ */
+#define VMCI_DMA_DG_BUFFER_SIZE (VMCI_MAX_DG_SIZE + PAGE_SIZE)
+
 static bool vmci_disable_msi;
 module_param_named(disable_msi, vmci_disable_msi, bool, 0);
 MODULE_PARM_DESC(disable_msi, "Disable MSI use in driver - (default=0)");
@@ -53,6 +59,9 @@ struct vmci_guest_device {
 	struct tasklet_struct bm_tasklet;
 
 	void *data_buffer;
+	dma_addr_t data_buffer_base;
+	void *tx_buffer;
+	dma_addr_t tx_buffer_base;
 	void *notification_bitmap;
 	dma_addr_t notification_base;
 };
@@ -451,6 +460,24 @@ static irqreturn_t vmci_interrupt_dma_datagram(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
 
+static void vmci_free_dg_buffers(struct vmci_guest_device *vmci_dev)
+{
+	if (vmci_dev->mmio_base != NULL) {
+		if (vmci_dev->tx_buffer != NULL)
+			dma_free_coherent(vmci_dev->dev,
+					  VMCI_DMA_DG_BUFFER_SIZE,
+					  vmci_dev->tx_buffer,
+					  vmci_dev->tx_buffer_base);
+		if (vmci_dev->data_buffer != NULL)
+			dma_free_coherent(vmci_dev->dev,
+					  VMCI_DMA_DG_BUFFER_SIZE,
+					  vmci_dev->data_buffer,
+					  vmci_dev->data_buffer_base);
+	} else {
+		vfree(vmci_dev->data_buffer);
+	}
+}
+
 /*
  * Most of the initialization at module load time is done here.
  */
@@ -517,11 +544,27 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	tasklet_init(&vmci_dev->bm_tasklet,
 		     vmci_process_bitmap, (unsigned long)vmci_dev);
 
-	vmci_dev->data_buffer = vmalloc(VMCI_MAX_DG_SIZE);
+	if (mmio_base != NULL) {
+		vmci_dev->tx_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
+							 &vmci_dev->tx_buffer_base,
+							 GFP_KERNEL);
+		if (!vmci_dev->tx_buffer) {
+			dev_err(&pdev->dev,
+				"Can't allocate memory for datagram tx buffer\n");
+			return -ENOMEM;
+		}
+
+		vmci_dev->data_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
+							   &vmci_dev->data_buffer_base,
+							   GFP_KERNEL);
+	} else {
+		vmci_dev->data_buffer = vmalloc(VMCI_MAX_DG_SIZE);
+	}
 	if (!vmci_dev->data_buffer) {
 		dev_err(&pdev->dev,
 			"Can't allocate memory for datagram buffer\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_free_data_buffers;
 	}
 
 	pci_set_master(pdev);	/* To enable queue_pair functionality. */
@@ -539,7 +582,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	if (!(capabilities & VMCI_CAPS_DATAGRAM)) {
 		dev_err(&pdev->dev, "Device does not support datagrams\n");
 		error = -ENXIO;
-		goto err_free_data_buffer;
+		goto err_free_data_buffers;
 	}
 	caps_in_use = VMCI_CAPS_DATAGRAM;
 
@@ -583,7 +626,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 			dev_err(&pdev->dev,
 				"Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
 			error = -ENXIO;
-			goto err_free_data_buffer;
+			goto err_free_data_buffers;
 		}
 	}
 
@@ -592,10 +635,17 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	/* Let the host know which capabilities we intend to use. */
 	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
 
-	/* Let the device know the size for pages passed down. */
-	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM)
+	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM) {
+		/* Let the device know the size for pages passed down. */
 		vmci_write_reg(vmci_dev, PAGE_SHIFT, VMCI_GUEST_PAGE_SHIFT);
 
+		/* Configure the high order parts of the data in/out buffers. */
+		vmci_write_reg(vmci_dev, upper_32_bits(vmci_dev->data_buffer_base),
+			       VMCI_DATA_IN_HIGH_ADDR);
+		vmci_write_reg(vmci_dev, upper_32_bits(vmci_dev->tx_buffer_base),
+			       VMCI_DATA_OUT_HIGH_ADDR);
+	}
+
 	/* Set up global device so that we can start sending datagrams */
 	spin_lock_irq(&vmci_dev_spinlock);
 	vmci_dev_g = vmci_dev;
@@ -747,8 +797,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_dev_g = NULL;
 	spin_unlock_irq(&vmci_dev_spinlock);
 
-err_free_data_buffer:
-	vfree(vmci_dev->data_buffer);
+err_free_data_buffers:
+	vmci_free_dg_buffers(vmci_dev);
 
 	/* The rest are managed resources and will be freed by PCI core */
 	return error;
@@ -806,7 +856,10 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 				  vmci_dev->notification_base);
 	}
 
-	vfree(vmci_dev->data_buffer);
+	vmci_free_dg_buffers(vmci_dev);
+
+	if (vmci_dev->mmio_base != NULL)
+		pci_iounmap(pdev, vmci_dev->mmio_base);
 
 	/* The rest are managed resources and will be freed by PCI core */
 }
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 2b70c024dacb..8bc37d8244a8 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -21,6 +21,10 @@
 #define VMCI_CAPS_ADDR          0x18
 #define VMCI_RESULT_LOW_ADDR    0x1c
 #define VMCI_RESULT_HIGH_ADDR   0x20
+#define VMCI_DATA_OUT_LOW_ADDR  0x24
+#define VMCI_DATA_OUT_HIGH_ADDR 0x28
+#define VMCI_DATA_IN_LOW_ADDR   0x2c
+#define VMCI_DATA_IN_HIGH_ADDR  0x30
 #define VMCI_GUEST_PAGE_SHIFT   0x34
 
 /* Max number of devices. */
-- 
2.25.1

