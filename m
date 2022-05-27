Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DDA536478
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353553AbiE0PBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245311AbiE0PBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:01:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5F3289
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAWafa0aoVuOOd++VTRVjwMcY6HOlC7LHuyyh9XGaAh81qXGBG9sCpimdYDaEDWdDn++QYcwNCoMbUYGIiDPL+N3ZwShbcLtrqylPjq7CmlqBWvf2N3EbFRKyMyNkYGkiO5QnPQKSFgWRxgXAPgHfVaPPg7N76dBVlsc36eOvW4pES78aOiT7o3iQI3lOh1lJ+T7ALeSFHhLlRADSuaS/ATwlYN4incw6wPpKpsALUTjOzPRKNwVTM9oEwGqvtQA7YBugtOS7zM51JSZRfz/2qLlV/8LPEU67EcTPsBwtVGpfPfu8enoHAdFO/U0yBHj+K/6i5jqVvfWdC/b05nRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0gru9Xh6e4eoDGxWCetUYLaDmzC9T3OesrQm/ofQZw=;
 b=C6hkQzlK2Bj8v4PVaND10nOjwS7ZFtxdjldcVqocqUbBI9/Lt31PvcAjF2blnWl4HU6Xq0yRTRjOwaadl1ww6BS951Q8xwNvewDDzNTy3i0G9AXLh56VcDjEatnIFlpA9D/wy/N1kbOu7tttCeWJzrMzpmVLf4VdoZkuUUwhKJTmsSoy8TbJvaEQW/6PFUysuuv0hkJCJn0/vyYhpHKKSUq4NchrWiDrh0/9Sa4LBHunqRdDAUi2C1INxH/Qc8L8JgxNfwrB+JXE0LvLE0SKLT+f2W9G+vkhv2TA8Pv7KFyTCOKZCUleT4w0uv+oHQS3gzFzff6+WuIoCqa24t2jKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0gru9Xh6e4eoDGxWCetUYLaDmzC9T3OesrQm/ofQZw=;
 b=kVIYiotwlwWWNC1/ZaF+5iAG7Cc3fcVP1UjeS14uInF0hn/M6UA1g/GNmYtWScvxctPcdCSO+HcplcZrNPKHxPcPRPZLzs5nRoR7QldtkhZFOOwlcc+hYlvOAXPBA2eG4r1c+8xGbSuzlNC22KHpGzIPht89PaeLW49sw7G4IXuSpXpo+5De+YcyNqne2j03PCSYATM4x4HVJJ7o0y7JKH0vt8G7zHjEAFzIDgJrKYYCWEOrxPbUBT9IyrGsL4oaarhvDyhbvs7IwIOsA4AEWpxkxOMmYTIrzp7yJTFYJ77chaj1FBOk36UkBte6vxwAuOYPquLiplOt11nRVjReUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 15:01:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::2484:51da:d56f:f1a5%7]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 15:01:10 +0000
Date:   Fri, 27 May 2022 12:01:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Message-ID: <20220527150108.GS1343366@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527063019.3112905-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:208:2d::47) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a663b79b-574c-4e7c-3103-08da3ff1bbe9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4068:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4068BD2E9CDBC0CE9802C23EC2D89@BY5PR12MB4068.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTPceG58H7pqPpuRz1esNfwsgD/GzDlRX12qq1M1w85XNWJWv6SS0DToVvR0ciIGZQ6zF4vldZ+KP6/yPBBRs9dKVwSePUG5rFiPYhrWZfdLlTFuzOrX/SMTpMBy0MFrlnAnJEiwIvIyG44f2nNC9rXm3caxmKOmY9U+osc8+2sW06LxrpYcgxKwprH97474oGvZMqRz22BlcFIOm4raKElaiT9cct0JGfApRjUR+pwdQTy7yKB1cJ9y7wD+BDpAedRdQ9Exe4Tt//AyBnGLEiUfE5G1Pdc/JAm3P68fG/wTPJSViBhclzCc0+N5n4kADYVkUkOP4MkMv1spAGcsVo/H84kNUewDJrsviGLG37NaZzOwkBX4NChDx67u0FrzqnRYjSBQjxO8kipyVmXfIIoaiqyu7snKy84my7QbR5wj0fCsDiKwZg+MsvvGY0thDe7KEj5xtH2oa9m+Pxl71tGNR0/sZrIcZCnSNuLdXfeEdTA85pAGAlun3L7NKb3iNUVzjBpUPaFTmggIEJL2s4+clEMFWw9qNn8Yu7HER92TW5jCwzGqvMFixcF3vomtR0bafopAcs4KuOJjKms4Toi3+rmAyxtbJanB49VxQ+46KI/G5KFlVMxAQfzBrCjWfNnjOtLdGkkx2/CgVexF3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(8676002)(186003)(38100700002)(66476007)(66556008)(66946007)(6512007)(6506007)(36756003)(508600001)(26005)(6486002)(316002)(86362001)(6916009)(54906003)(5660300002)(1076003)(2616005)(8936002)(7416002)(33656002)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tslu2a9YMoL70MzoLzQYj6CvwfGN/Ns/bCeEI3naEje4/j9Oz6KlBFMcHMrk?=
 =?us-ascii?Q?KDvcluCTeDxApgR7gp9zNXhmgYIoWx7pixE88mFDA8vgM+xrjlZoGt0uxX17?=
 =?us-ascii?Q?SgqZAHqv0aOoTLbP7N6HdfOrrBpl7CPVgV9Aqh+cssGeJK+8T2ZZmASvNmra?=
 =?us-ascii?Q?5LeU2U2v3AhBZ0wHAAEWD/u86+OzFu5A6YrJCCDfjLLnqLlemqfJ/HOpVqPx?=
 =?us-ascii?Q?kFc0ZKar9XcMtG4RQpQyw4/FEw1Xr4SKK3606miTU6NV1vGHOd/wQCm5nBrV?=
 =?us-ascii?Q?3uMKVJf4VZEpUxXgKpP87TR+5rbQB7PJi5CM0rzDtQ26e4ns4ylc9VIl//8U?=
 =?us-ascii?Q?MuBx6LP5+5BSN0OdDT6iNTpvUBldD22KElw8rt5BEcdCY16NiUgMM2G/+BbE?=
 =?us-ascii?Q?1FiDfXJEcvswDdvaPf7WdRo1zYrLXaekJ2BF//hIz22cK0H76NLzrmTJGnzN?=
 =?us-ascii?Q?i5Ubh/0coQRkgOLp4CW9j6qI6543BV4bgBZX1z+hrsMu60ZEFdXFgmJyOrTx?=
 =?us-ascii?Q?om8DY7cvT3lsd0epsTn7AuJc7Kgbh/TLDv1ELvS39T8Rl/RXZqKfptMnXTvf?=
 =?us-ascii?Q?TEqVhNINcwU9DR1ODJTjDnMa0oTk+VGbVcql4nxdHMnD/7BCR0VL97ZluGT1?=
 =?us-ascii?Q?WXyQ3n6YQ3Gza7qCzMZXn1ahoprQEmgv/LYo3WEeQVlEfw+qURbCXci08mo6?=
 =?us-ascii?Q?FLjMZkWCvzmvCFUIZM88sFnpd9fhL6lb5sfG+YxRHGEw7zE5HSyv/w6IHNsX?=
 =?us-ascii?Q?BI5CZMBrGR6WLCkHi/b/ocCLi2Jq9J9ZDSqP7amx9nc4yzdXEiw7ADlilcrN?=
 =?us-ascii?Q?cOcycBnduQivtFrvgplJqJL3S8dhgaDS77gP28hs3GKJCRFaYUyPUjTwymcb?=
 =?us-ascii?Q?jtmUOXn1tjRhkQ2Mxupz3ZoAfesL8UpnGE2PwHgirDNCpO9kxE2DmqssEPib?=
 =?us-ascii?Q?ubk7MS5rOPg6CUyNHb3uvWUrCcqgNoCkSeXtQQnkDIZ8aa/nl2mAb0Nw3BhE?=
 =?us-ascii?Q?+KdNQIWlPET/Sl944nC+QG2n6rEdsEDKg2IagITnutHDieTcl7+it2crlUdJ?=
 =?us-ascii?Q?Y81BiSnKZfdjehck0mIOeEcD/SPOtkKF9QFj463u3x+FFCeUP/p/w9HgXzOy?=
 =?us-ascii?Q?xeMt7bseQ5s7D5hE5x2X0yKGRadourba7ToaN8B/xL1Eok1woT6C4Gf2xbAs?=
 =?us-ascii?Q?zdcjP1LbJnXixHwq5l4DblW6r4H5xTrsHFgS3oSOhtD4tvZ7iyI0vz2f0YaB?=
 =?us-ascii?Q?M+bqZ/zpEgzYolkQGuaPz99zDNjBUA5Jmr8CKBGm3z4pIhua0NL07XDBKEp2?=
 =?us-ascii?Q?XPEtIxkuGpWNSMG0+xcd+hWst+bw8gZEEOo2iWVgCNT3A7M8t/PUasrMsODf?=
 =?us-ascii?Q?mYI/QtjVwF1ERe694WonI1p8lGVlvGbF77LX2KYx8XZws3WA4nFJ5rwzisBM?=
 =?us-ascii?Q?qbMSi3nuuP1awd2glvk1cKs53gojcOa5md895Tr7j6Zd2pvUW1IrQORzg9T/?=
 =?us-ascii?Q?Q6bvz8SJVwSQGuQjvABvuK7Iy5I7c8L8QKDyWp6oeaEzfi4Leo2sDGGuVAO6?=
 =?us-ascii?Q?ATKnxyu+FW7eEebO3axRUpVesdXYsmpWcw+H8M3pOsaG1xcokK5YlVFNLirK?=
 =?us-ascii?Q?xzouyG3zbGK7uFVgiq4Ef9zkhecXrtOf9tFEiBo91hizIEMGqMwoO8hjdFN+?=
 =?us-ascii?Q?Bjzx6U5RX1sIe5zDNnYYO826wDleFmTw7ATqREX9KQQr7G8hMvydQtBOriqu?=
 =?us-ascii?Q?SM/MaF0tZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a663b79b-574c-4e7c-3103-08da3ff1bbe9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 15:01:09.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ9Vqu1tY8J2Blg36koaiEPF59c2em9pSqjMtY55LbS31P6qQZKTPIUZzK+tEgJM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 02:30:10PM +0800, Lu Baolu wrote:
> The disable_dmar_iommu() is called when IOMMU initialzation fails or
> the IOMMU is hot-removed from the system. In both cases, there is no
> need to clear the IOMMU translation data structures for devices.
> 
> On the initialization path, the device probing only happens after the
> IOMMU is initialized successfully, hence there're no translation data
> structures.
> 
> On the hot-remove path, there is no real use case where the IOMMU is
> hot-removed, but the devices that it manages are still alive in the
> system. The translation data structures were torn down during device
> release, hence there's no need to repeat it in IOMMU hot-remove path
> either.

Can you leave behind a 1 statement WARN_ON of some kind to check this?

Jason
