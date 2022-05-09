Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27DC520492
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiEIShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiEIShK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:37:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765064B1E3
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SghI7RcHJdTnISBHMMBpCZxbvH41X+gzOh2i1CmSNNATMwuGoMd5peAu6F4Z4ZF8Uw4PLE/M4E7vuwR3szb0LqUgxwWxNkWVb61iSainqRMN1avBTMuAmLh5QSa5hLRUfIlhpP+sjBxmb9xkXQ4Gp7FJsZ4sYWurcu6bRm1OD0Wl/QxdipdskvzLjhAO7pC5tHwbvb3IF4BHmuM8lR4olBAYfHoKeuQDm/Ld7e3Rmqq7X9zzH9XsAVUTkNZRvZgeBkbyEKuCsOcq/tCFusDUw66HXRUmilhLSOQTqw6TjuHAnJ5ZfgPIuurXj3kWlRQEdeJqbAmtUPBD/I7m0a904Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwuYh0u+FGcj9cA4nSzeA+5h+C3emDseAQ2b5sgrH/o=;
 b=ajwiZtUb1wsKLTNEZnDDT+PWZhNVdcGr4eU02eNb+dJviMh9wbJQX1AhejiHtufAqRkqVfnY2FCuEbVUjdwzhUL4WJ+V013TkT4r/KJAQ1pDMnb5RuvaMhYKHPqPgvnWFlonKtWRscKyApQ7YXia+dydbPqXxgCNhjaCP+USSbLMD7Hbft6tYLTtoqVZZSyG7bOC1M2uXRf01Dtz9B3GPVORZzD0Mw0zdqxfONyY2QOyVK/O0lBRTfI1aFRaNMdczR3XdOsYkmY8uK0LB+Eb+mx14kM/ge5neHHnbfMsGD04HwrEsE6c6bIBKpoulu1w9OSXdSgL3f9PzX/48tiB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwuYh0u+FGcj9cA4nSzeA+5h+C3emDseAQ2b5sgrH/o=;
 b=H6l1NokTpKpbvoaQYf0caF0FZV9ubNf4kCmaILG9i6fBVKolxnvWskmbvG7p5Bao3TAeIPay8NKzuStBUEZiHrcI8jJ+3twqTCFTX098/JrW2FudInPO91azBVdB9WBJpRnSx9XlZwnLZ96k51M94LfZnqaOn7Xc+xN+UANBSmnRbX0by+xba6y3ukttru0VK3ob0aelg+S2kiQEP8R3ikd+Iq+kJP/AH7uZFSk5+UZm7GVLu5tqXN4/mcSR2cggBqyegnaQV4xS4XF9MjV7IjKpnktOuqkX5RH0FZnEtWvxC+wyg7Dq+lvkOeyLex6Q4WkK1MpOglfOH8ir8gutYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 18:33:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 18:33:12 +0000
Date:   Mon, 9 May 2022 15:33:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220509183310.GS49344@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
 <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504115135.GA49344@nvidia.com>
 <YnJqER3qbzHucfkx@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnJqER3qbzHucfkx@8bytes.org>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30a86e6-450e-4e2f-6d4e-08da31ea5f4c
X-MS-TrafficTypeDiagnostic: MN0PR12MB5812:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB581277653D778E02527F6CB0C2C69@MN0PR12MB5812.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/dRIDAu/jZ/YI7Rsv0tnKWWg8pn8oTqlWwSEndya1guw83ZkoCxnLj4dsLZxF3tY7LKYN9AfshLSZ8jWh65hcSibzkhoMbg1Jp02ZQDc3oKn4RIAgH1Md8xiOt9fYjkMQYkA9BlgnmJQoPIg/lhRWloAj1axgRbvQkAGiyNqzvaEvRGBh3QIarWFo0I3VI1KhdjyZK7sc9Z+iwLx1wxMjKSOXR4Je9wSkZefEyiBvxYn1x3/1q7mViA3Gh9CQeuNdRjhB3aX8oZa+wjcqt3NT1JkIa0/Tf8ZlATBEBYbSKobcE0e32pNz3Sq43wvIc+euQ2kavFoS4CMM1yEz4fUf4V9NGScg90At2H/zDcAGSStftckmgnpgIugUsvt/EZ8tBiUnjCj4n22fHK/VOjBJI19I3A48SGfCEKxfbYPzUetoA9AnyzJ/PUD9uQkFp8svuUeUNX+qO+Zwh5zWlNM0G5D4ZIQKQPo7udOEGJc82xeTvqShdtWm2BOyaLnOeZLvdDYPvnGLvJnvSvmyD6dJQNtdlFkaIKuBq+kcIR7Qv+h9B2z6Js74hjgn4NdHGO8Of0b3lXHz8y9E+O92EAZXej3K/PAF9PHbgsJ+6fA08HaQGQniRWvWmx0JAu4SUCvHEU64SgR//ZX4r6BlBjcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(54906003)(33656002)(508600001)(66556008)(66946007)(8676002)(66476007)(86362001)(4326008)(316002)(2616005)(6916009)(26005)(38100700002)(6512007)(5660300002)(6506007)(186003)(2906002)(1076003)(4744005)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5Ums4rr//fQ65z2dRb5m20fsxc4XCTGpNecpdeB55OqLnQBrwqnyhDixQoC?=
 =?us-ascii?Q?tZJI86FjB6/IcAl+LeS4yA6KCPpwuFZcPU+qzZKuJ1eUoLlSx+vzsYcOOGQ6?=
 =?us-ascii?Q?r4OycmN24xvF+6hjxT/uaWJCFCwpllX7j3AoKVwnHEmZsW+Y8a4lXBpsgaMc?=
 =?us-ascii?Q?bAzia8ndtgG/p2nnrk+/ZtNHdr0YVj7jL2x924V/eg0YLH6w+WrpHfRCs6dh?=
 =?us-ascii?Q?gPTmmlbZEcFOrpWNhz2wSYESFh9LDhSoJKWmIJy/wgScm46AaPMtITejVFOV?=
 =?us-ascii?Q?+Lbu8Yl/aNfLQZVEnPJINuxBNWh3w6fez2M9ZeBICMG2Pq6Y7XB6jxH5ujaA?=
 =?us-ascii?Q?20o4LVnGepAL03pkOj1twTAWUQjyLbwdVrLOM6vBatKorplpQrxLqutUrjCX?=
 =?us-ascii?Q?G+13tXcafjhVPOTgIMwuihP2GwmIoYBV4/K6CE1DroOEV2WKZlySAqk3IZRA?=
 =?us-ascii?Q?YqRy0foV4A6xbPKSyQDSz/LPbabkYv9ussKkvyvXoHx4ZZANirQ2LRk8tii4?=
 =?us-ascii?Q?MPHK9pV+1eSmQrcS9dQaZ4C6X0glZQpp7//qY0lmq2dP09lsO/EMoQobkUOo?=
 =?us-ascii?Q?ideKb9UTwXusn20EolRFBYpUGMSpVSpMJDTaTwwiZs+u6O4CMey2twP34zul?=
 =?us-ascii?Q?NpwPAhpeyXpgsQQGuBI8L02Wt+rEz0coq8OaTB9ZK/fmyqi5RQqYN5yUTTl3?=
 =?us-ascii?Q?lmroRSTE8MCzcZi2W2LdWnkHM3QcnayPl8jzNjvnaTCI/mNObn31+GaxJitM?=
 =?us-ascii?Q?e7f4LuZ26dYQOZeeCyANr2G06LzXcIPOuU6WhF/GX0dKpKVTiE+HmG1qoQlO?=
 =?us-ascii?Q?DGubZQMM/gEikmmYDLsycBu4LhojRcu807jjbBa/p8f3Hses1TxjLkwLBPR2?=
 =?us-ascii?Q?43X3BMzdxXMAJ339Gtye+65BSLgOy0xx33cV1q4dZH0RuKU6S1QwoT8Qgz5w?=
 =?us-ascii?Q?QqjpG7MnEBktgOiDsVz162e8K5XWH77pgc0S8HgHUyicDkc6WKL5fnGnKxMY?=
 =?us-ascii?Q?Fm/9ABajiwd0wODJf7zHplts6kpB1VFxj3sHGL3B987MtRx3vPRpU8OBGwKK?=
 =?us-ascii?Q?2trSPt8AAIsriItN8+UpXIatO0sycndCTw5Sx7MsH1p/z00oqgLRFOZ6aI2y?=
 =?us-ascii?Q?p5SinUOAcRDAfwwoXGg/xGhgdYchfRzuvfNWnK5RsjDrivO9zAEwTK7ourYL?=
 =?us-ascii?Q?Xl8UcjMmbRDQ/5oojAS/0ijUv3i9p9ApPqDBA2sdZWfdoO82GPWpfXenMs7f?=
 =?us-ascii?Q?hp2m0MXdhoX2L1S6deqlcWfn5df5LRslSluH1iIolKzdZlT46xpsmnf9TkJP?=
 =?us-ascii?Q?+x2FUHUwbt7fx4uwbJhj/vQkMdt3ONYrC0nevsGaHrNzwOHXd/mHjaDGriXq?=
 =?us-ascii?Q?os6dHbHba98GNiTTnmOuAuWRqWipOczKTnJLgl4WR/DkFQJFplaX79otYdUX?=
 =?us-ascii?Q?R8Tm65RdXdcSTkZomSkae+i3kkW7ijlRcf2/ai03JjXXecjg7pH0pclhv7ek?=
 =?us-ascii?Q?AxcvAMRJZzLosAcwbd3NVt9YO0tbYeBVKuxJrv0gjbRSikGXG0ZkeiI7yyMt?=
 =?us-ascii?Q?IINAnHK1WCTMpGoQeEXkc85NqnqdqDnx7QOCBYNqxYgNLZWLq5GDv28uk16S?=
 =?us-ascii?Q?fS8Fuu882Fzg9AGtin77bY/FjGTLOzaoX11rtKNMifAPHSWu/c6QzSPhjxaK?=
 =?us-ascii?Q?VC7d2SFdetdYlHnP0zzH/zu3ZXTAeAWKhQNXTKbd8B7Mge1ISxOTUtUEP72Y?=
 =?us-ascii?Q?tYd+nCB8Pg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30a86e6-450e-4e2f-6d4e-08da31ea5f4c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 18:33:11.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlYrfGBbUjgQ9waBMXdAMpAZ2T4V6Vzq8/ao98fg/EaaZEPuVEyub9yfQK8gA+zR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:57:05PM +0200, Joerg Roedel wrote:
> On Wed, May 04, 2022 at 08:51:35AM -0300, Jason Gunthorpe wrote:
> > Nicolin and Eric have been testing with this series on ARM for a long
> > time now, it is not like it is completely broken.
> 
> Yeah, I am also optimistic this can be fixed soon. But the rule is that
> the next branch should only contain patches which I would send to Linus.
> And with a known issue in it I wouldn't, so it is excluded at least from
> my next branch for now. The topic branch is still alive and I will merge
> it again when the fix is in.

The fix is out, lets merge it back in so we can have some more time to
discover any additional issues. People seem to test when it is in your
branch.

Thanks,
Jason
