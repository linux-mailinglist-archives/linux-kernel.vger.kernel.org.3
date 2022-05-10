Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F82521CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbiEJOqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbiEJOof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:44:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E956F1CD274
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:02:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8wmbtbpGgw1lY8vcYI3aUg0TgpS2Uvw9qo7b6LmYMgzDcHjwMU07v9a2r562F9fodBHGn2WmsGRtXOtTwVBCjHwYvZ3j+zktP011rtxWY4YfZtFiKbWktow6VrosIyPP4K1yPf+P7QGhz7N3RosVAW5g0tGJV9KeoTqZ/hx6CIMROZOiyZEskKpxQWgTeMy00wrFaTjfp0L4fwEuFLqRDveAgQVRSU9soyoXLW5750Bl8f6N8AcZHozRoT2uBxqyHYMAttzSFHaBdRXa1pMwCvW4iZEdLf931dAxbOh6OtIODabsZafIOJUznsP1UfTdPKFQQk12Lr6MbBqOlDDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93D+rs7ckxAhs5L8wZ67Pp5wUGFsfy4il2IhOR0zGTU=;
 b=S3CePXXuJdncAIiBhQ8w5haV2IxI6Gyr9p1/5Y5XF6nf8qE/Qj1cQ1JxESyAZjrit8caUNZeAqCdCppi8+kAAvPRSdH2LaFvbGASk0AuljE2dIEDNrr3zxhcWN0Ih/9KUiiXoAxsVG54s9ZEmImr23kj5Oetht5mADY7YVmyFoQWYPgzuttfsK8R+akCu7Kd0t3aHkHOf6QXxNQz6KbpgwDSKYArpuhOLohctehhm3XBj7w3GdA3FN/nebC78Yjh4kt9wm8lEQXt7Nlrp8ufkK5p9xYZm2f8CIU1U8ORKMmWZv67UPNTrbLrk45hF1OWwVYsUr1QNxtvdV1v2KJKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93D+rs7ckxAhs5L8wZ67Pp5wUGFsfy4il2IhOR0zGTU=;
 b=ObMr2GvGeBGWBRoKwrrMqO8+CxHNqLrCtLQNWf7AwYFdpzQiY2ETu4X6Jz1qkKMMM8ifeXxfOOTM4Y8TQXIYqiKhKwOXxWkrh37LbXlO/M8AlNTkT1Lajzeqs44bcDjreQDP0yp5aQPMoQmMSzrjZMvpQPUn98ef7xHRIDUu5roNVO2CaodICwwahkl7c48qXoaoTzI4BD1zlwwsGyHAIIpvM2G3iWT8UIn1tlwfbQJ1crXf17ziTITTJBCMTx170OIxeLRAyd62whLqOjGoZ5LBxFNrF2vb9gF2aQeU4s0OdHHsUYdxQ8GxFRkYLi1NorA+ILhCnt4lflWX1WndDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 14:02:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:02:40 +0000
Date:   Tue, 10 May 2022 11:02:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 03/12] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <20220510140238.GD49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510061738.2761430-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:208:134::39) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62765dc3-be9c-4453-794d-08da328dbed4
X-MS-TrafficTypeDiagnostic: DM4PR12MB6352:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB63526429270661AF0B33297EC2C99@DM4PR12MB6352.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4F5QIyKt1k1y7MoPDgsFKlwyB9mw3Jg3jdgpsra5OZynpZy58oSzk/TJKsZHWzah7GvtE8MUdYpEKBxEh30pivnmmEZHuS5dEXDH5z+xEj1Qc8k2Of02TurO8pG77KYEeGidFgMeyQ2mJkJgmQuGkLlVDZaBzAKFJzKZQmO783LGknOO54dGV/io7ntPJkhIfEWC6cPbUlg4tGeM4Zo6wTebhLIcV8CNzFL1zfztIdoJd6rwPrTGO5m67XRuRKejlkrM0XpDCoP7eJeQzXk2CvSAQSI7tinRnlvV6ZehYdeYWkZIBjAmccsg1ehih9CvduxgrZZyM6UBG4CZ4I+ILFziwKSqEltc+QPh35EQJenKh57u1wCdhJx/xyxFwFdRqRMYw/eMljYRIkqayo+fbmjEdsHQCuRxIJv/AP+l+yB9tI1SkKMCGxuKFVOqoLArhVfPiEXbe1d5qTeRR2IYSetNZ+z2msNvHHSDxN8zKU0pPsQfRD8huxsNfIv6CaN5yF/wJ8SSHHdEf3AWghEBJ2xw4oIhmkZIi3wLcQDfTE2YYcL4p9MOVHcEj04zxIeuT9KM5H4iNtwdUcmiw55e3B7goIeD/yWwkq+Xb8gft4f7+b5wA7UKBE1QUWwEo4+wD2Q41noHMpYOjjl+mCs6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(66946007)(186003)(54906003)(6486002)(36756003)(8676002)(4326008)(33656002)(508600001)(6916009)(316002)(86362001)(38100700002)(2906002)(26005)(1076003)(6512007)(83380400001)(4744005)(8936002)(6506007)(2616005)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPqHi9M100gXCaoF6dv2KcDDxSs6/t/5Gr6xK0b/PFSZK8PHuwkv+J0c7xd9?=
 =?us-ascii?Q?FakM1xjalBTWE1sFyBCAQdp8aT/bhkI3K3S3v5ar84CNifujAex8J+QARgWN?=
 =?us-ascii?Q?UH2yKSEYsgJsnpuWOT4P6D23F2X9AJkjeAwTnClnJHzpOwcx2DpbZvyGYDnB?=
 =?us-ascii?Q?lFy2XO1I2RvyFWAX1Fawn3bQKw3amS1V9BQQ5oShckIj0tXK9lFueuN2tBzo?=
 =?us-ascii?Q?AHLE5ZNHD14c0TJ/Ao9XyJ75LevygqIf0Mi+DChyOsUrPhCfpK6Q0yj6DBMW?=
 =?us-ascii?Q?xoP1KsrVH2l2oK7lqTTNVGhhMmZk/l012jRECu0hmWWDOn722Jr0ETGwTLKX?=
 =?us-ascii?Q?jp9m2gzjlwlpDbyp5COC+Xc/1B04uDQuIwJu3gBPi81+KAgEDG/JsXWgfKmH?=
 =?us-ascii?Q?p0SyUXBsFGKEeat70GsDQTnJ0Faa2vCBkqR+MVW3ls6sjaVy2b5VlFNdMNs7?=
 =?us-ascii?Q?Q0EZCQqZQ1CZgHA57rEcoz5dJ6ITqiSKVWr36WCoEzAcs+gT1ut5QJVQM3Bz?=
 =?us-ascii?Q?xf/LoO1JocVuAzZ3f1Pd8LIHmpM9yyPRLljJGvga1OqYnS+YeLW+37szEomy?=
 =?us-ascii?Q?PfAREoOfOTiMPV7rIjmuFL5bdLvID8T+/O940lhehiGsmd0xmSIUqmEmDHjf?=
 =?us-ascii?Q?meHwUQe3nGiirALjRgUlpytIUs54ffETarApxtUwo1C/OxyVi2gqUSjAyttk?=
 =?us-ascii?Q?4qvNPODcWqcG2QnNPYsU21Lvrg+YDcWYt0LZLNMibiv8LfjS9zQlzPgWICpP?=
 =?us-ascii?Q?vKeWwMt+26IHt2K4O5tddUi80DJGf6kZ+cQAuIPvtZuPPpMWFCRkNhfJFW7Q?=
 =?us-ascii?Q?PVya3lHT6JjFT9f3PRWMk7SL+mnCKvGgsmybJxyGn/yb7+n+f155oNYc0VzL?=
 =?us-ascii?Q?lyiGJeql+XF/3Xe4txVMZVMHllfbgBPqbKHkk2/HTqg0Gmfe9tPS1Tp3cPkx?=
 =?us-ascii?Q?L4VDivSr1XqBTE+Y32fzWvSI41FGWm5s4xHwmMuuRRBE+t5scnJ9nRzNw9Oq?=
 =?us-ascii?Q?IzOaPeEjI3polNSz0BRaUt2anI2CdCnrNvaL6dRATx9ligpQLTci/xUDPi/7?=
 =?us-ascii?Q?ATJFnMamFqXPX1ueRiK/mHQBo7wWrLbOTiLMXlKeNn83zS7kpxwqNQsoQL1n?=
 =?us-ascii?Q?muC7K4IXYPDmH5+59K4R1B6GD2MnRrCuzATMZoinxS9fycmcDQH936uZYd1r?=
 =?us-ascii?Q?H6T8LzYGYoqb+EWHQ+OBbPrJ1CKiHsFkJjfwo0qo6x+YQ1FVtSGoN0WQ87Uf?=
 =?us-ascii?Q?5WmczLNVLeTxDiM21ZkNR6qCG2PNy+fmjWb7q8aHLsaMavSlg8GLoU8rp5ur?=
 =?us-ascii?Q?vTF1+68whoBdl2Hvi1EUZpp1gzubF5kRXgYRBSuxrdWNQqt4/kPSuJApZJN2?=
 =?us-ascii?Q?R20HIdnTUCWIunsU6BsQ7yhTkVwwoGi2SO02fFe5q7+0dBluwult8FDBDZXM?=
 =?us-ascii?Q?nng3zovs6JkXXiZxKoNwc+zXwAOAfkk1UR8NboDzh5SyyEPuF4vIn4k+emO2?=
 =?us-ascii?Q?IgzBoIR2nTgFbrX+4RfhWZ6uatpz+Bu8Z3OsHyNPg3i1/KL2TfTmihnhNIAA?=
 =?us-ascii?Q?1F3W8TEbCBioCEs2aQuhQHPBBuJ9wvgaClBZ0m4RTvWWjb5GcgxdMoHg4Mki?=
 =?us-ascii?Q?nqHJDLcc7hyZzBYvbtrJ/tSdXzse+jwzB1hQElZgcO8/6ed+8ndptNOEPcOf?=
 =?us-ascii?Q?aUjSb8TgluJyT4aGV3ONF2HfB3BKastQVFZ0k2i5Yn8Qn6xScnZFNfMdux3i?=
 =?us-ascii?Q?FtqI+OvtJw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62765dc3-be9c-4453-794d-08da328dbed4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:02:40.1125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqqstA+MnV1EItHcoOz//U0yP2bQPb0vSfj5J+6V0pz2Gcfm0mRB57GgS+DGhE+4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:17:29PM +0800, Lu Baolu wrote:

> This adds a pair of common domain ops for this purpose and adds helpers
> to attach/detach a domain to/from a {device, PASID}. 

I wonder if this should not have a detach op - after discussing with
Robin we can see that detach_dev is not used in updated
drivers. Instead attach_dev acts as 'set_domain'

So, it would be more symmetrical if attaching a blocking_domain to the
PASID was the way to 'detach'.

This could be made straightforward by following the sketch I showed to
have a static, global blocing_domain and providing a pointer to it in
struct iommu_ops

Then 'detach pasid' is:

iommu_ops->blocking_domain->ops->attach_dev_pasid(domain, dev, pasid);

And we move away from the notion of 'detach' and in the direction that
everything continuously has a domain set. PASID would logically
default to blocking_domain, though we wouldn't track this anywhere.

Jason
