Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FF34A73F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbiBBOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:55:27 -0500
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:1824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345207AbiBBOzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgAb1c5NJleAHT/6sQ7imVJhqljmYqpNkOTgcI5IuEvJKpobVjoVHhWhPDozwtP5W85LjRzTt1iuI9lIrpB5z4FG+fpxuNeBDiAogl7NlScfkTT1wnznA+pOmDV1rMwfjVG/Xegyi39AImpjclS11UdSyUl10iduV20c/o87BO29tGF/hg217Dxd14grgnZBouiaAQlI/41pAdA50q+5lMP/we7xVZ33xTm/mQDefJtIqtm6aOrwuCuuLiZsKlRv92buMtzH2HosM6WQRWJpKza9SizVQS/NjKkPJuquzj1z2UoK1sa6K0mt/LaS8Dlyk5u0GMQoVZWUNsVnLaw/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QvjxuDGjlrUjQ1bBMB/reSzLifwvi9HcpfcsmsAvlc=;
 b=ASzJunho/6xtOqdfNO6GiHPBnSXLq2uO26LYzkLslox+EYefqjFvN84T0CGhbQnweth6bcfM9u54V76Qs3IuognoicSJLctgGHhk7MHES7T3NNUyIUfqGCqG43YYVSvTbd9yfj0JslUQGp+KAzEycUQe+1cG8lB1CYcgEe6mazeytwvO9sMzouTc+UDjgFtKnqliu2ykdyhhWdGWY7D8mrEg4ypaG43+LkVWn/Oanrn6NuIt1YQWokb2xfrx2A5LRcFq0L/di72Gixi3tnzDfyQS5hQrRQqpMT5qciEkLA5zg14NwQqpV7AyENBUpZZGAIcwDNhFRPD1BDESSlNB4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QvjxuDGjlrUjQ1bBMB/reSzLifwvi9HcpfcsmsAvlc=;
 b=F0AJyEjMklWHV4LYQNUHl39vWHR7bNAiVfHQoEiD3uxmzUbntWbC6heWDJ/tuuVRMSCKpMuLWopZFrx/kQpKoaMEG2eY2dUTAtVX07GCltMpPBxL1kI0NTmhXve+bXzrbzLiSEn6flQPUSetjjwqyffAXopKBlr5LsTr2CRPKgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BN6PR05MB2803.namprd05.prod.outlook.com (2603:10b6:404:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 14:55:15 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:55:15 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH 4/8] VMCI: dma dg: set OS page size
Date:   Wed,  2 Feb 2022 06:49:06 -0800
Message-Id: <20220202144910.10349-5-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202144910.10349-1-jhansen@vmware.com>
References: <20220202144910.10349-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7abfa5ac-2cbc-4f80-d252-08d9e65c04a3
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB280300D614F5C89D607A0764DA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSRKbTucInnVYQ+k5Mj0/nLYMISFg2n1t3Rrjdaw/9Wo1KNFZVSMRU1BmEbSquuvjOrgKdzriROi4Ay0H+SsjebJ6iHGQVnjJo85KP0Li4r24gRM52QqIiFhq5XH8c9NO96twgKRw++aq4xly0PhaweGZZ/iJ99xIR0M+DOGk9NyfsCnhsouKL3Y+X3coVHrv0yt+vF4kMb+20VfyylEt323/WI5Gr5qqWrvPeObkYM8wmsTWyboQvzcoBRcLtpbGPMJpJoCXHtidPo/wcgNISACR7QeyO1zxrAaAfUI3IpUEyKaCr4Ucw2o9gui0t58yJfQNJM1fdRGXFoXSVVvNv0uKPBLDe9UigCazLeps8zsv8AQdzb89hz3hHENROl4VP1PAoCR5FJNnUPqjEYzhysyq7cA2EM9qOG0KAmAbdxU5/CKbVqPBtvi6cSUxFMHmQL81e5FIQ+v1G2Ofyp782rx2gPhySYjzLOpYgYkbLGY42+0D4Us4z3iiZGyttWHod9FJXSkH6HzYO9YKsyIjauD6wssnMm+euLY3CI0M5NBN+Is0/Z5OBsGafZTiI/gKgT29uoD15XjnAgWtS4NwyOQX5a+5a7UbCfkG+RgU7jpWwKyBA6MS3ClCTPKUG0d6flZ3KSKWw7PWfCxxqSHxXCc2X1GM1GNWzgdHMo1/s4VQiS6lbzGGzUpODkAVKPVPGSbYBSMnY+nh3vCM/e/Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6oUUJiwdG9B0WjHt1bq1dvaIjZtqyttZu+GsejQRgG6+UzV+92Vd9wKKX9YV?=
 =?us-ascii?Q?U1Amj4OISxuQntN5dfTtwYEUdszfSesVZUvGseFOVIbfHcCkx4aXZDfkXcdb?=
 =?us-ascii?Q?xWQrwEwmDa8CqcyNZbA0d+GK0AxEOLj3NryuTW+AFQMorfecGJCdXD3cH0U7?=
 =?us-ascii?Q?J8JaZ5lF6Ejbz4Wdkktc00NOWsnJNsjx3HdrHPEQEStq1jIIDxDB8FJkI+Z9?=
 =?us-ascii?Q?0yke5WZEq3o0FJYfm3u8KFKXnq/uviJe/eG5ELWRneYXb8A9jKU44QHaH7hX?=
 =?us-ascii?Q?jwKP4MVq6M+PbetWZ+yTsJnWv0DSSerTAupp+Sxi89Ckqv9p+dyUU0zIXCFU?=
 =?us-ascii?Q?Wn4OSk8BzbjZqHqQOoM8sLDmkOA2eynVmGAyyvCzctvHe+dSy0Ot4l100pdX?=
 =?us-ascii?Q?LpbxQYnm6OLlsxDF/Vc+6UjhxnLx7EK3ByDSrFBg4T5gI2eEj205mfJ4gnI5?=
 =?us-ascii?Q?ePhxDa5CmF4ReiMql/2ZZUTuVFTTTPAqNNLZHe/5BHBZtI/hrQGwUdjwY//Q?=
 =?us-ascii?Q?9E0WmyBO4r/SxQ6VGU71MOfZhmxrTtgH43euVa8p84LFrQiUKeEiEYrlm0rX?=
 =?us-ascii?Q?EjThlpSyB+39qUzF9/iwyFXpSg6WuJ8WEZVIC0ZpqKCAY+9KBUD1dsgi61jY?=
 =?us-ascii?Q?iqU0aJmfG1xCUsvLRwxujUnVSx25BcUA0k+grIplWnqZgza5UK/DEvO6zu81?=
 =?us-ascii?Q?vuB31bYsCcYDjFGdlsB+YJYHuausMrbKOO5eBv0PXAUMYrtf7nUbEbIH9dsb?=
 =?us-ascii?Q?30R+xZJT1080dWSx8bNbBoW6h9TUfG4kRgTjONI3OAGlw1JgqNzBSoVWir3g?=
 =?us-ascii?Q?AoPLLTGMARZmb3/1GhPGDhHLGf4BKsUaCbDXc8BLBtv0s54UKTCYM9oJf9GO?=
 =?us-ascii?Q?RUgZ9IhkikJFqTFhnMAWJ78Wv83PaWpHxkDUEYCNYmx6Zev/G5yKV9F4V7WI?=
 =?us-ascii?Q?mOM6u1npezIctp5hmKo28RE7K8DvwL9pQ/0iezGNAYvfDAFOw89bFiUzBm5C?=
 =?us-ascii?Q?0Y2ESdnkB/yypbXMeAPtbawWR+JUicZo7/0KBHl6pwZzlBwu9sBmxQzMk/oz?=
 =?us-ascii?Q?a+hcHx+mdVemywwhfQLlRP/CcQwDoguRHen590azQCbOCFm6K814Nocl2NsP?=
 =?us-ascii?Q?dyLUT2dXN1sLn0tEmeGJaLJDUR+7Z+yhN8PpZn9hPm+gajKhAZ3gnrAHs2oq?=
 =?us-ascii?Q?n7HwgHxPgrwE+q4cSiBBWpEvA0u5GWNn5uOAiY5T6OPb3kx3aQpQUVfRZlnb?=
 =?us-ascii?Q?KC+oFgY3+nqyPXOYk0LiNU9QI933x1Uw05xC7RXMZn3rsIfdH+jWJzs1+BqV?=
 =?us-ascii?Q?HrNxNOmKu2YdvfQ2ukjTNqHW7V3lVwt3DJH9TYkMgLyAVHhj/ujOPTmnyALd?=
 =?us-ascii?Q?QTlW+TA8ZveNT9N4YB2bFUfn8o88/bFgDvvZX5GOIdynihJqJGN2eLU9MBzC?=
 =?us-ascii?Q?rmKbLfChKmzA51cs+1c/rCY8ixKH9GFj+IIteD7+2m6RHmjo1DHxvoXOdK16?=
 =?us-ascii?Q?d3i/zQ4tPP00ye73MZlRaf+n7r0hPwntJgDrgmlCWl6XRhYpaGrA8YB1yBtb?=
 =?us-ascii?Q?hJPPzBoZa8VDk/8aYoOJaCWJhylgraqsLGjy+k+cvNzuBrtP8gEgJfiNxbJn?=
 =?us-ascii?Q?209cILJcf853XDcmjYtJ5Xw=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abfa5ac-2cbc-4f80-d252-08d9e65c04a3
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:14.2609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycY4Kb9eGCC3Zz/s4/y43K8hhAsF40bt01P3P/Cpjnk9z9GnomSBk1q0Lciyyyu3Ikgksz0z5CBVywEsRbsHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
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
index 4bd5891ff910..ec76661bde7e 100644
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

