Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677194A8501
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350715AbiBCNSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:17 -0500
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62]:43141
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229981AbiBCNSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr99EfavHJadNSrpQi2Ua0mO/w1yK2sBORrUpZP8LH2Ta1TXG56QUYftrTonbzrmCbTKxLPsgTMCFaozr5K5EdsWfqfiKwGCRPWmltya2Z1aSLWXjJMTX0x4iw0ybP2r56m9AiTOOcr+JvJMfNfnRHnq9ahl86WtN0CMqbWLSLdjF9x8180nGIkJVvHIKtk6g7VU1bLyYA6fh2vztjut98uFVFOSCUTJnzzhqdkX87Y4BofgQ4EcMg8jaP76as7uPqyEyOysUrst5F71Vbdm34Hv9kOSNAb7d3gXBs0kBofW3vNnm4IDauiM21rg3fmeXJU18cgaLS6xsSVPbrOPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3509nvrSZyaSQKjqlhWIIctN4J2qBjuYuNRCFGVucFM=;
 b=FzqQ+q3JaqrjpcCterqWZHdqZtLct2maBbGtDRXS5WyGYH4vGJ0NHo7O/PbfVgzBqr7JCyq4xAxA6HITOETJgvVouRCnCPBZbQHUuQCNvvHXRokyJ+exOsQbcNrk9X68YIOyLBNgu53PyErKS1jEX5HP16OvhludvjeLyGd5LM7ibSJHG33GcVyXvg4Pkywp27UJB9l2QpBb8jxtyJ2XBK95ASrvNdGdn/oS7GbFL/x57Rm7w01rlJXqZDd+YIr8rHNm0/dMPPSp8tG9Kwtvjo0zIloE5b+AfweVmhIN7Q/U0dnMdDeGN9opKiEeuXKLALbg+NPKo7eIQxDzPHgAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3509nvrSZyaSQKjqlhWIIctN4J2qBjuYuNRCFGVucFM=;
 b=HkGZENEp9RNA7FrDILaIcBe4acX+srDxSwxXrBaeGO3WBA0Kg98pxIIBCgWpiWs+HLs4KYFhYl5rslHvdfVyvdIv+GP96AKs93+g0mh+NTN6qvufXgaoKQf9MKcwR9wmhRjtytevjv98fAfPVEApZ6rM+LCricCi9pO3QYcPAEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:13 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:13 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH v2 0/8] VMCI: dma dg: Add support for DMA datagrams
Date:   Thu,  3 Feb 2022 05:12:29 -0800
Message-Id: <20220203131237.3380-1-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af720c1d-3760-4441-c331-08d9e717a1a1
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB7150A380E236E4023A915785DA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZvKy7aCIaszOLb87dgSwHEwiU+oRumLY91MLK7AJ3vTnwDdCVjNnWnFSmpDtJ/xXvVVZwyvSbf/Tp3HLYfu4baefyCu3mmqEPpyzMOlsCqv0Yj1clciS/CqBU0yE5hG77bvlsiMBlMzKIp5sh2Ys67MsS6vjJDvI4r+16KZhjRnmBXrq3Fo5gPVr5eBlMtznIane/KyjdKmKVSl94e+AWi1gH8EqBR1KH73ROZsTHDnDRfRydc5SBjyPobY48riLi3gGV8oosJMsfNoRLr89JFYgO/4bAsPJRTl+o8T5E0VhIiXSRP6+xjFKs0MFMCinNlPWSa5rVTvxuY1Hd1L2KGI1ocBODaZbu9cCz+SeWsb0Z9xvuU5q7Pt0plxjl9QCz0XS2NG14VjZFZr7H4OSunu9WzsWkW88nWswQhj+4mHPK3SjyGWvw27cgCj4wc+CuoFEtYz3OAot+dtkbuRhT5ail3DDC3VRhlSlEnP6EwcZaGlkqJhReAlSwc8cwADedlue5FV6R1pmyFcPxOKDIbDH8cd81+SwVVFOlkQ6vsyrTtFr5YefYwqrsMi1db7EyW592/wx9pvdyJuVyiuzhq0vG+juZfJzimtYP2yvYPL5qQArAU6YJL76M1/E9KcwnTTf1lv7b9PACOzM0Wt80dElsr2v9niSeqAwRyvlOurraj2nL2O3XfYbppi/ivv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sr+IH3ENNg3zbVdhCcXMqvjL0/Av+V9pYjd6llMd9TEXcK3mPekJJfNKvG3Q?=
 =?us-ascii?Q?5smT9AXm6C7TFVvH1ZGi07kfzOWf/APHbBFZhtsSnbwPu5CZjMSNvdGCQmjd?=
 =?us-ascii?Q?PUcqAxj5k7I2407yUSC77QeCFxWeScVYBestrsX34EIU4A7+Nz3AnoIk7TxV?=
 =?us-ascii?Q?yxDZnM2+Kpl52dBdtzP8fHfg7Bd5D18LjrkQNpEXr7k3DkKxTZGVLU3M6jmV?=
 =?us-ascii?Q?cdEX5CV7Sm7pDklMIfmaSYXD3ZN9Pcr2Sksze8BqtrHY176/Fn10nVnp9Y88?=
 =?us-ascii?Q?Gh+voWfldQZgKct1ADjgjIFvS7r4oJ49NZ1kKdVSbx7i4WVvsUH3Q3XZiXNC?=
 =?us-ascii?Q?0N8fK73HaJR/b89gcCCvEGQXjbtRoL2NjbPeOX2Q02+KWaVBjFlbNH7YaldH?=
 =?us-ascii?Q?bfT4rDQaXfTKuWrhViThTrjp5eKUu+6vcDjeKXQx8LMqdtxaVD1qqtjqogK+?=
 =?us-ascii?Q?oGosdRUlKR23p7e1gwFk+ek38dOVDi3KCYln6pDc8HQpO7sQDkNIkgZ5jZVe?=
 =?us-ascii?Q?vspx/kofOjxBZbltZ3joJcuFJ7lus+pvjgQTCZtXaHfFSyLVD0Xi1eZmsW2b?=
 =?us-ascii?Q?l79qWeacxdlwKFqCLj4tTm4elYU3WA6tQcX+vWkctD/16XH0xuxmhwCTtc8m?=
 =?us-ascii?Q?yB8Kp5qoruI3BkVzvnY0t74sL50mho1nJffdPlgnu9gl9OkQ2TEcpJGdUGHp?=
 =?us-ascii?Q?KEpUk8bK5lbNPTwKfOsjV5wWCfcwtQhNAGns1D0o9Lifhko71XBijTMwrLdq?=
 =?us-ascii?Q?YdE+fHPHPkNGEWwspTXPrCLx0Mg/ri8TuBD5EBR2RAo2eRWBK3v9CNwTD/VE?=
 =?us-ascii?Q?fd5XdBc89yv9cqS/28u+fnPB+HOjEaHfXVfYo2FFbikSJV1U98b1MKXnPlc/?=
 =?us-ascii?Q?q9II10fmwDScax9VMoHFVbsQnJltiQ2UNtLpf1shJyZCk6pCzBDIo0P8iSYD?=
 =?us-ascii?Q?LxwuIYU8CipvQoTVMLxtNz3VN70EHX7GXI9WNdRBzFlGssLex1sK3h5vN6l8?=
 =?us-ascii?Q?ta1qxuZo/uz1jK0pnVN0MD0VOdsxBnzDpBRkTqH7LoFiy481QZbFDlqwY5Zj?=
 =?us-ascii?Q?wuBgQs0hi0GADM1nW007bqrmNouJOebrE+nGEmfg/QngZ5i/0nvO05eDVysj?=
 =?us-ascii?Q?MSX/UPdGTPUHl8gmKdFGezJrFbhIDLBBjt+SdgQZsXV+RrJOJPytvoDvg6Cm?=
 =?us-ascii?Q?aR37rt24IEoQ7C3UAu0SbwxXrrZbb7Ia6rXeVFh0FTo7U4kjw87qUrh48KJE?=
 =?us-ascii?Q?oMpolbo6t/KzbCQWOyuaXSGF8rlNpsO3q4dcvNeRuQYyDw39ETEEVpOjsvv5?=
 =?us-ascii?Q?IS2pN/tIdUoCAz5x9nUaYA9zFAbJH6dlZnNw6NnGE/0ifvcqIMAMfGPY9QT6?=
 =?us-ascii?Q?WLC1ouabliEvyNbM3IAnRaL/jTfD87cDErblPIA8ViP+eD+rI4WFy6KmJMus?=
 =?us-ascii?Q?da5Wot8IdjuNqhERCsbn2gSSKqg+ch/dQNdyF7jGjbontgJ/PX72IIzBQI2P?=
 =?us-ascii?Q?VzCNe1S/3S5zgWFcpOQddgq9sddcpB8sGpj6D5SiqHWrIN55qHnMHn+Xpp7g?=
 =?us-ascii?Q?ucCfxdsVFt98koLYhicl0dJ7ux8Cb0JH73G7e3Vv8xFAlDJfNUF5UEhb+6QC?=
 =?us-ascii?Q?VZWzawzNDLob1fio0ywg+hk=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af720c1d-3760-4441-c331-08d9e717a1a1
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:13.5070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5m5wtQzOx15TDlVx7AwIVPyNTrKyU9NSNtLwvutxVRAYvqZct0hjm5yD8EFWiYHX3DdPHY0YJ1beo7XzG8dyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of the VMCI device will introduce two new major changes:
- support MMIO access to device registers
- support send/receive of datagrams using DMA transfers instead of
  ioread8_rep/iowrite8_rep operations
This patch series updates the VMCI driver to support these new
features while maintaining backwards compatibility.

The DMA based datagram operations use a send and a receive buffer
allocated at module load time. The buffer contains a header
describing the layout of the buffer followed by either an SG list or
inline data. The header also contains a flag indicating whether the
buffer is currently owned by the driver or the device. Both for send
and receive, the driver will initialize the buffer, transfer ownership
to the device by writing the buffer address to a register, and then
wait for the ownership to be transferred back. The device will
generate an interrupt when this happens.

v2 (fixes issues flagged by kernel test robot <lkp@intel.com>):
- changed type of mmio_base to void __iomem *
- made vmci_read_reg, vmci_write_reg and vmci_write_data static functions

Jorgen Hansen (8):
  VMCI: dma dg: whitespace formatting change for vmci register defines
  VMCI: dma dg: add MMIO access to registers
  VMCI: dma dg: detect DMA datagram capability
  VMCI: dma dg: set OS page size
  VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
  VMCI: dma dg: allocate send and receive buffers for DMA datagrams
  VMCI: dma dg: add support for DMA datagrams sends
  VMCI: dma dg: add support for DMA datagrams receive

 drivers/misc/vmw_vmci/vmci_guest.c | 340 ++++++++++++++++++++++++-----
 include/linux/vmw_vmci_defs.h      |  84 ++++++-
 2 files changed, 361 insertions(+), 63 deletions(-)

-- 
2.25.1

