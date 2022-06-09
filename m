Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF05A5458DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 01:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiFIXxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 19:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiFIXxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 19:53:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC18DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 16:53:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms/tXoGPNLcSUSv0S+gW6NjURDGXrVoGYAhcVWrx4iD2Q2UklhOlKBgncURnV2okpBtsKekiDKzwzRL8UXVP6gqDeWkOfUqF0PAL2UF+yLI7QdgZX0mdspJTTklZthi72GFON+3CWySrZ5YKOFz06TEbdTCW8zsfIGg1bF4DVUJZxxArBNxsYTuCW8b2GAEtEnEPoNH0PNqP16UHYVZeetVm/zzhqNDq3y5hkPNXHkFVuBO/C1lVNY+HLbc5MlcHxTX49YqJKFCNBPje+77NvlryeCVTZOEIA/r8lCuVu4pb4eSNwdPKVErHSlNg4JwjSiFGXul87s8uv5Kq2yb5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtC9OsStIWawY6RR0YXmsXy77F0pl4O95w3KwzxGOys=;
 b=Dx+VwfvISCy2R12em3jsFTrYqRJZFHfwjtrI4FH8JAmHp09yCFSHz3prLRv6w+QQd8NTaOWrnAnwitVgcUdXgOKla3EsOaa4+h7kv/j9+4kte3Q+g+yRVwu88CWHB27aphyL4hokIVqcRcSZqlkxVArFiV9c1LVUIeg/Fhrcm/gq8CTbkXICmJ8tItkDIrY5yamuOTh8YJ3X2aoY60tdV5X7WYYfuALJfOdnlMGodItxBowLqYsWrpt1YF+LB33iJhdYfYYBy8UN8POENHgPhVaLF66It8KZxhvqGSFo06x5clh9DnBSMWInaHMHBtHg2hO7ulcz1TuDMqNIe4/iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtC9OsStIWawY6RR0YXmsXy77F0pl4O95w3KwzxGOys=;
 b=H7AOVa7+GadPgpyDkyVXs3A3FVAezVzCV+HiqDAqkpNBQ6UF/LfCP7sS6mlk1mY9sOk7RVnJZ2554ua4dqou9SDD2+2IffxWOi1wqM8tVkDFnIOwhtey1ch06WHG7/8o4bhnpRB7EQN5N6ziGcK0QUohbfb1kNDJVsqnZjURU43AT/aDS37Zz9ylrGJO9YmL/KfFmO1vkftaVvB59qviuLv1yTnccvM3TXObwmIBd2oNbY7CPQCVo/+zg5wrgV6esl0K94s8uel67Tzqy6+e2zJu300UMA0mfyUW+24hFIxpZEi5dcNSmnUU9nkHLq7dfhUHaTAE/E28yk2Y4vFuyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 23:53:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 23:53:04 +0000
Date:   Thu, 9 Jun 2022 20:53:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v8 01/11] iommu: Add max_pasids field in struct
 iommu_device
Message-ID: <20220609235303.GC1343366@nvidia.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-2-baolu.lu@linux.intel.com>
 <20220609172542.GB33363@araj-dh-work>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609172542.GB33363@araj-dh-work>
X-ClientProxiedBy: MN2PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:208:23d::9) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a66d0bb-be1b-424d-61d7-08da4a7331ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB4879:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4879B145B721B5A282CCBD67C2A79@DM6PR12MB4879.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASvHYuf/eBfs6HuafYmnTcZ0yffNcDDFCD81sOhcg2vuO004GLzUJb9WttQPtCzN71sli03nyxviW6JnoqBobHC9LwGw5Bokw6Q4E0FS8Q/ZsHjTiADWCAja5ecu25WcZr0TRjuZPmcIdtuck0AZzZvoMcivAsyvzsi6acc7l/FAVszLbYhzhVzcb4BtHQM5tL2MtNTCGi7Ievu47+qXZXEgWvE9H5A8PqYTPjVaTPSqb4yC6n7ofUYI5aA8qPyVJxzm0P0L3bfSbVqgGYH0F2dibj9/ou2obN6EcCFDdd+/ZLdZqxx+I5cSOeSoLSPku2/YvqTJL2o/Z1a6LuY+Z6iB5bFDJIUBu612KNBlOQ42QFyZySaicuEiW5hJC6wynfwMH0usYCOqHsEUzjTb8wOgbvZ/48qKx7rCa5fr4804zUBd1vLacJkekov8Hrl6BwBLGNLwq2fr3Sw1mgZjpZ3mU746tyKduDw+xXUyaUNcghPMTtKtBvLMQqBdzalUrF6IeM+fJpZQF2gPXIZbkM3wS4qhNno0PrchoBFq6ruX+xP0lZxEj0rBJbweFpmCnDZDmMj7Egc07xtrty+r+lNhvjcoCNi6vtxXk27j/amsG/hFY4mBAJr0pCnrdG3UnGYgU8OSAcMi3WkvD+4RIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(4744005)(2906002)(6506007)(83380400001)(8936002)(6486002)(5660300002)(508600001)(6512007)(26005)(8676002)(4326008)(316002)(38100700002)(33656002)(36756003)(1076003)(2616005)(186003)(66476007)(86362001)(66946007)(66556008)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fEKdyyflqKEKMvdszpjjVXJaCluLPJvL0tpukFc0rV2H90QtKwOahGL8EX9M?=
 =?us-ascii?Q?LJUowzax9Z4+waDW03wGVPhponYtB+8cPJA3M5LESCeeEDBNEKKochJGoQEN?=
 =?us-ascii?Q?oJGaaH0z+vbBtf86aE77vU6Xd4xRMmySI7n1gsjCH67eQk7H4eriLL85XxCP?=
 =?us-ascii?Q?2E9WOJYXtyzrFlNuZit+L2oZlMlRec08y/Kz1P9PMuVpLgGgldy7mS9oO2Uj?=
 =?us-ascii?Q?pu9sHBMxdvtn/1eZmKiCyDKxOkmYTR3r365cGFwMRf5THN2kd1Oq2TZCkB70?=
 =?us-ascii?Q?YeiTLdty3vLIVE/LjAiNQhr7xCGIdbF6WWvMzAKZH7DKVkGDTPgkd2m2SlZD?=
 =?us-ascii?Q?X3EpNA2rTlScGD1Z6sjkCHfiWu8uz7OtIcpNTgmCCTD5bWvn8MLDAgchzDn4?=
 =?us-ascii?Q?Rvo385ehixnIHCTgaBy1eMeNgQkcIvmIe65aH6hyKD14qLHlVbCvmachhRNc?=
 =?us-ascii?Q?l9sDblo6PyWMu3qBQ0iraM/Bsdqx1yaFDo0xT0n1P5v+yxG67QdfSqprwGsY?=
 =?us-ascii?Q?dFGnQshgyFmDBErSQtV++Fozra4NzQzKCekxoGsrSHnFJWs8+sDPa367FprP?=
 =?us-ascii?Q?BLuELMcfJXyh78NCP7RDAoG24lFU0nbvY8YR0IoiGqt3z7THS0aGURLotqrX?=
 =?us-ascii?Q?jJUNDuoLjmS7k1H2IqZrTeOknD6cQmiu5zhpKE0TJ3tL9IyMOqsWm3Km68HX?=
 =?us-ascii?Q?2RPnXSAOTX7dAZlihs5InnfdYdny+96UpsfbNax5oMr3y9iOLzjhGsAMizcp?=
 =?us-ascii?Q?3m53x93KvujtALO5ZnjtpkMU5BroJMluIuNGHPxxLTMCeKYlRihE6p8nC4ty?=
 =?us-ascii?Q?v4+j2+Kn78CNzIqVu2iNYl8NWwMFsaRte7dKRmcNv1ZHAQycdNSffFtPXO5c?=
 =?us-ascii?Q?BLDuAkM/OUevOzsQorYgY8dWRz5BM5kjawn2KyuKCUPjUuLFSdKg093kFNok?=
 =?us-ascii?Q?snHv2koxMKcd24pDuoJsUtKV9PxQswSTel8IWdMdh7vlPrrPZcEs4A2abr6z?=
 =?us-ascii?Q?DDgGxhy+kik9EfUZLct4A9CO39rkBY4JQjOp94lgEJFhBCBoeo1mO2e+KnCS?=
 =?us-ascii?Q?GqjM/rPll3oY2y9DbDEwqfUe8bDbYL9LEzmlK/naKZzZDwoEtrRUSdUCH5ti?=
 =?us-ascii?Q?5YPMu1SEo+V3huqjRp5Zaja5mNQKCYOCS4KL9kzCon82GBwokfq0kpbPM2Dx?=
 =?us-ascii?Q?z61i2NHQwrkGMjrSJ1S2nkR/WVy79QceYwKAPDOX3DH2VpyoBgj7AFQQCdVv?=
 =?us-ascii?Q?WN/1XCocsEQRx4Rz6V4jr5n3R5sGzzZtz/MvgJKxM5dhYDbeI/TctkLeziVf?=
 =?us-ascii?Q?6VvNh4S5EE2sYAgtz3/M7FHioraEP1P0PHZmyk0n+IfAap35u6h4C3dTwlH4?=
 =?us-ascii?Q?OOB2h9He4r+lLAzw4Sw7UN+7vx4RjdLRw6AXN1xpIqdK17zgmINvl0qW54zC?=
 =?us-ascii?Q?vKgBqvgJ4XOe7RH+hrPxK6zkWH5dFvmGaBbHnD1lDUnSrUXX7h5i00ZfCWlA?=
 =?us-ascii?Q?CFzDCVhHvu6D9wu8947j2JZTSzWyYJzsZq+zpZrXuO51LgguEW3iY9ztfUI7?=
 =?us-ascii?Q?fd9cVAiMBH102RhM9mJXvDBXYGhotbt5gGm/5Va+6mj0EC7OOumjk8ZL+E36?=
 =?us-ascii?Q?2QD+eahPFts/wbv059sxEzHKwbC9YSwZHK4QnQKofB1JDtSGl0PCViYbJ5mC?=
 =?us-ascii?Q?72MycGNism2YBAkkcd/6wvUayhfIlf7kk17EuhPrm0Oiu90V08gT7y5AMrUX?=
 =?us-ascii?Q?wMDzzetcJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a66d0bb-be1b-424d-61d7-08da4a7331ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 23:53:04.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T23ad8zsvsjuRf68yhLPLGxj90TQDkhbAPqt1JjakY7uBYlVYSv0XskrOjSsmruu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 05:25:42PM +0000, Raj, Ashok wrote:
> 
> On Tue, Jun 07, 2022 at 09:49:32AM +0800, Lu Baolu wrote:
> > Use this field to keep the number of supported PASIDs that an IOMMU
> > hardware is able to support. This is a generic attribute of an IOMMU
> > and lifting it into the per-IOMMU device structure makes it possible
> 
> There is also a per-device attribute that tells what width is supported on
> each device. When a device enables SVM, for simplicity we were proposing to
> disable SVM on devices that don't support the full width, since it adds
> additional complexity on the allocation interface. Is that factored into
> this?

I would like to see the concept of a 'global PASID' and this is the
only place we'd union all the per-device limits together. SVM can
optionally use a global PASID and ENQCMD requires it, but I don't want
to see the core code assuming everything is ENQCMD.

Jason
