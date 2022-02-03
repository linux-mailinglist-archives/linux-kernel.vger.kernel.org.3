Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5CC4A850F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350780AbiBCNS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:28 -0500
Received: from mail-bn1nam07on2040.outbound.protection.outlook.com ([40.107.212.40]:28852
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229981AbiBCNSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anMLddax3B5esQ3CdJVadooucT+bPXDtek18eCAvpgOVLq4/dBJHtcLUZcNjXUbek0pJCwXVXsz+acVGvYnfXLaocLv1n+OeukGL+DFl8GMk+k1+Pm9TK2bi5MYBUdZj8uvQ606Ds6G6Y5jeYyuQIp5NLbxe79I1AwYOPdPcxyxS+AD8wsQN/Ozesf0aCaRv7jqykX4qWrdNPGD/iOoOfGjD4fdnBYZOSO68EJfAlxTb/Z7k/ESTjqI7hr9zSPapyNW945iyPF28VdeCnwpL2ZQca7GLrzEVIWtGZ5H2BP9saTq4liYhQn35O3XSlmB5vpToWiarMD9T556bpcKm0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86TnlLcg73GHw+H/YO9F+W/sh05nU5vdjRMxx1eswk8=;
 b=euy+NHohPx7B6085IIhDP4pM64R0olK6Nk9dJ2gdi//uD7gcELdxzShyrjmzro1lXQHt067HIlenMb91TPHwt9rrMfIVzUvHCjEcil+9CZ14r6CTpZ2mvFL12duumq1vD7sGetsx5XmYQuHwdbSSpTMl4GhsyEs7Xbyj4NnJVajZVaIHVdO7WbDH87l77bkH7YIi3bVBcsDGJnXmWuh++Jc6ftPTo/FKXgLhaQhf0k3gyMRAuYkxRSnSuRGP8oo5itI6uaIzp1sFiMvECm5ami76MeSLHgZ63dZXLYFL0vxQm5+5ZNEYUIrcTddTQaMhqEtu4d9jhhg5J31zQDRB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86TnlLcg73GHw+H/YO9F+W/sh05nU5vdjRMxx1eswk8=;
 b=E57wzEzIG1iV84VHxSKyKcSmwelIz6ASPHh6JGpOSYakGkLPMAzM2PLiIqBXL0Onique491uqF/2xvBAkVq/BlerRxwS7d+smos8QCODAkBLAkVyVTiUveOk0hAB51z6J8A3BUX8noc/sw/vGlhgibxBAoNPDwGtj8+v9alsLq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:16 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:16 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v2 3/8] VMCI: dma dg: detect DMA datagram capability
Date:   Thu,  3 Feb 2022 05:12:32 -0800
Message-Id: <20220203131237.3380-4-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: f33a9aa3-73c7-4c50-b395-08d9e717a2d0
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB71503D69743A27B45955B036DA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7Ej0L35IqPX06uCJ1JJfKIpFT4T+zREa74lpvVQq8A/rxmtC4gQ7HAq8UY8ml2ttKNnkNN/JamCSqtboYR08wiBIR50coVtXME3hC9qz6E8IRE2RtGV6GxXHKARuSSpH72U2rhlBp8QFFpC57+0LkVHMDeSpAfaTr190hLJlnKzLLvR6CIQqLThjs6FYRVpt45vZrWsHk5Vh0+2m0c8Br6nY5kE7PWRt1V1/rMNczQRrtt5Bko5wbd0x6mIQVKRMZk2Ie/Gh9e/LeotXTtPlRAiZKSs0Y715MKtC0W1KxgbNf1JWydUxfj11H7fqRHKqXnp/8/GUjMiaJjcDpDBZswyQqTCgVTIt3l6q0y/ukxdGvTeu7WnQ9mfKP7ZSUAUECTXFhHbJKkw94VHRY8yidyd+lP6R4zQaOzO3DVUuX86gTQxMNUOBkY5dCgST4u6hY8Fcct8rdWZUx6zmKvYXgR9x8SbAvCgfOe2QpPV1qTtPyYRNL4xf+789UOS8fvqmGv7hWf5t645gJ7Dvaj0az5w6Su5jZTWxq6yaV8VDoYP22kbkAVZJ/JdmIVjNOFVvQm6rwb9wRoP85ia3oBJBEyeJIS4KXnB5aEOUf5nNnteIJ+gZOkAXpsOs3OOoJNhLOZlDqkOmUXW9WBoQpHVHPSUZq9EZyCbXsIlDD2z4ntFPCp8xG99YYPmVZw0mrwC18lLaeApHY05jTyKouNZ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdNR4E6+P2Xf4gVhyKrubO/McwWT+GiOuA9BD9VC0UwUEUGPi0F3+IJdfg88?=
 =?us-ascii?Q?WWflP4u7g/R5GopoIkeiT2xlH9niaspiaAYb46gkb+RL2JB/LPgp0bp+p4j6?=
 =?us-ascii?Q?ZTWH98f1iO/Nn1SJZkWY6oQMmlVBPuUXkNJWVN6xIaxGPwXf/waIE+jeB50B?=
 =?us-ascii?Q?bNxmUi0ZBZWytWalSPPBeZzrCY6icAleVk2imv/epc8wyryy7QtpCn78+4HC?=
 =?us-ascii?Q?s4pM3S240IFzLbwFoz4UeSb/Mor7mIGL2RIM0874WWiSfmynbg9hVr9pCLyi?=
 =?us-ascii?Q?iUIxX0nkKN6Jh5pxkxIHa6FnhBWclRxE9G8RnuVwBKtBhsotrjvjsfIeyzur?=
 =?us-ascii?Q?HyjuxW0IlU07qab2SYWqu1xzhJ37uw+lGwlsdmlwuvSwpTpiqWeLI8c+fTIx?=
 =?us-ascii?Q?7hENdm+zEPumnnuQqbwqVSKW9q1yjsK//zi+pcz5PHcieFf5KGcqT70pSEQR?=
 =?us-ascii?Q?5SQlZlTVccWmsgM7RTbezm5UYePw8jLJLs88AWMd6vgbNK5cyhQeVEaianuN?=
 =?us-ascii?Q?ERjSPnjU/qKSH05uwMHx1HCgC7jFquIcyRFhal11ZpRCDachZa6PtQ0aT4aS?=
 =?us-ascii?Q?NYWeYgbRKFIWAtyirwLGVgLdQkSs2o6GSyghSCOgiQRJxfFWP2gSuK6G40Cr?=
 =?us-ascii?Q?Z+61YaZ3aBdcA6WYXn24aaoBUGrFLZ6MTRxCyGL68YcVG0h5Ly4tPaCnlVt1?=
 =?us-ascii?Q?LF4gj8Dga9L8dyuUHDdjKQXpcbwr/7eVyYjIrteRiFu6rjnrQMwI5Z4e4ZAF?=
 =?us-ascii?Q?x5sB75CVIg1cEfbri9nC6kGKucaziDvmmQ5fAbCeFqM0cr4PLwO9POhDIhsK?=
 =?us-ascii?Q?yYnwB0/c5RWyLMxL0od+X6gjo03iXx8N2qGBhc49SSWMtV7GXzjrr0SEXSIZ?=
 =?us-ascii?Q?YvH8Uh9HO156pDjiR9FJYxKUTzl9hC4g/Pm/yd5u8SmPj6K45L1VESfZoXkb?=
 =?us-ascii?Q?h37t3cCkOm3fwH6dPQtk54ydQuDtmRuaHu4d0ypD/hqK3OU9tXxp+b95skoj?=
 =?us-ascii?Q?dC5Ot7j1+QhVaTcIeKeMosZa40lHvXb8r0Rxx50b0iB9a3wwLhAIhnh2yQf1?=
 =?us-ascii?Q?4/Qn7LCayE+pO2ChuM6FYpszS7SHHf6UrtOMpT78151mf2Dk/p0E5AwT3AV7?=
 =?us-ascii?Q?c/94FduNyIR2dZ22UMS5G3m6h76iJcs46B1VYoqouBBcmS+pZ/hQMGljPcnu?=
 =?us-ascii?Q?N941QYlAPgQjxmI8X4P6Th5EA8gkom/lHYyClwCoGg6xALV6BnGgxycCdNf1?=
 =?us-ascii?Q?/gjmF0eqxZgZS3a/Fwa79cTjUR4qGAse3eVZdd19g0YBzj3lUtWvJyPPAX0e?=
 =?us-ascii?Q?dtFxQMokRYiH5qBCTk4TbItzk12vyFP9SGPfJfWEuvmV1BW0Ov+/z1lGzLfA?=
 =?us-ascii?Q?76edyAtNi5ExcwkCY3xFSQb2td19dvZdwFi+0FKBZIR9O1qq2bM6T0Zww7Fb?=
 =?us-ascii?Q?aBstw6Auwid4h6zvW+K/N113GgdeKObx2yJqRfzvDPf5uSxSBg3HOt73K3Oy?=
 =?us-ascii?Q?LQ48t+2gf5b2Twy2vX7EXwwlYOgqEysdt9XtE+8JA/vWsFsStBvXlvXcAREi?=
 =?us-ascii?Q?MXwAvy93s1Xd1ec2Y/xuteRWE23eZ1/oIajpOu6RUqtHLeReClCqlCoIr0uq?=
 =?us-ascii?Q?jixRvV3is6TK/myOkBZ7sUw=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33a9aa3-73c7-4c50-b395-08d9e717a2d0
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:15.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T73qqbBCYwhpNV/bSjlXAQaEaUTQNWNOiCx9jqqMhoh+tX+jMfFY7kR1kShFoGJB2YrKH9R5bjeteaRbc6uovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect the VMCI DMA datagram capability, and if present, ack it
to the device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 11 +++++++++++
 include/linux/vmw_vmci_defs.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 38ee7ed32ab9..5a99d8e27873 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -565,6 +565,17 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		}
 	}
 
+	if (mmio_base != NULL) {
+		if (capabilities & VMCI_CAPS_DMA_DATAGRAM) {
+			caps_in_use |= VMCI_CAPS_DMA_DATAGRAM;
+		} else {
+			dev_err(&pdev->dev,
+				"Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
+			error = -ENXIO;
+			goto err_free_data_buffer;
+		}
+	}
+
 	dev_info(&pdev->dev, "Using capabilities 0x%x\n", caps_in_use);
 
 	/* Let the host know which capabilities we intend to use. */
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 8fc00e2685cf..1ce2cffdc3ae 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -39,6 +39,7 @@
 #define VMCI_CAPS_DATAGRAM      BIT(2)
 #define VMCI_CAPS_NOTIFICATIONS BIT(3)
 #define VMCI_CAPS_PPN64         BIT(4)
+#define VMCI_CAPS_DMA_DATAGRAM  BIT(5)
 
 /* Interrupt Cause register bits. */
 #define VMCI_ICR_DATAGRAM      BIT(0)
-- 
2.25.1

