Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA5E518874
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiECP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiECP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:27:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F158915A0D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctw2YqGJK83wErW1q6R59ZqYa0mpVR+kCbStKTjmIbi942xsvfT5FAt1sRZOWfljlyr5fNXHnEV4z3B5LhTmqO0HyKnGAllEtrvEC38oCyYYk7kkPNp61MTVbRC1O1Q+0vdmca1uZWR1cqlM23ndA+lO9dKpvTIZJneM/tOId53awcLJUY0qCV1klG4p6x5x/bTeQP6xY/ikuh72cQltB2dRKjGwrqnsJUH3pfRwB92LYjktskn0JQTPCF0E3LKwGKI4qKzB911lWcaBfpjHk9HQ1ZeS4YBfJKqE4DgNpMistILx0AYSRdR8LXJ5PPibefOXZb8QjxNLNVmkmdaRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVAG/dRMevZf3+AqrtKZpsHhjOmY69wWJqRZ32vFYbI=;
 b=YHr//f4pZhbkYaz54NWdiw/8CGC33fkFSqIQTUSZ3vi6aPyiHLL0gfhdMF0yQWjOHZxUoDW9EL/JGngc+fK6vTz6yvRucIY83symGUkObTJ0bgRdbs9z8anBHHXS3/QbDabtbSBi0281RB0oH4CKxwVxXw4GJm1mqaxGjJeLPcG9rMil4NwV2Q76XYzX1aYkc6RC9VLfK5nhh57GwIuOYptbIcojJhlNcSz9b6GzyltUkZOC3KZUdcH5nyRDNvhbU6S/T4ruyWSP2/k8rEKS3Glvxatd72dn8rWytrxH7MXNUMOi9VxYeNMycU5192R38qvB0cPxnDY0AYisIsT7aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVAG/dRMevZf3+AqrtKZpsHhjOmY69wWJqRZ32vFYbI=;
 b=VkCOYNpGLCdagJk9gLMQBx2gqJDFWt1batgai/QjoNOgyiRCuBiwmI4YUrGhaHX6gAUaoDcS6u+WoRfKyGTR5QweK9CsAx784yGH9sCeTeaYaP1XutlUtP1lNtEQgdf5Rjl3c3JjY/z5uvwid7vEJtgCIotB5ZTXXif65wxNl+eqBAnWahRk1E8vvtEl5oNhL1IRXmfcxpekBrYSAgZpuZ61RML8HG/9DAOtboHPRhS6xlQpsWD05ECPDRh7DF4yMEbAB9ORA6Yx4dmHFdQwSxlaohb2f2/Yg7SzJmkL3+9hEBzpiJaGc5pKjelyfGKaxuHx59sBmNGzXNQHdHOG7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 3 May
 2022 15:23:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 15:23:43 +0000
Date:   Tue, 3 May 2022 12:23:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220503152336.GA3939@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian>
 <20220502164216.GP8364@nvidia.com>
 <8b3d31ef-caf7-da92-fa95-0df378d5b091@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b3d31ef-caf7-da92-fa95-0df378d5b091@arm.com>
X-ClientProxiedBy: BLAPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:208:329::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ca92f86-2cd1-4828-bd67-08da2d18e8a1
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB26184321C03FCBC4B87A85DFC2C09@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XD1vbqLFIp9fF2TXXnCu8AqXaCTBn7RS58o4+fiPLLofKqZiET5SQ1muDFJc214gp14OwhCVpMCXUkGVHB+1TbFZJ8GB9xqtW2px2lNftdCXZW3iitbEUjPJVFgt7M3YYnhm3DGcRO/V7aTRRrYw9Y3Y8cBrh6bUaI8bZmHs6p3VDVoW2FFBIKCp/cYQaDRgpCoW/Yf3d8nKSxk+uJrJkT//UYwlFLgn4o9Bi1HOTrCNQw65Xj2raXi8xS1FzK1+y3uUCwguo/BQzMvsOY9aOa4CEmNQYYESQT1QIf1KQwjcU/HBkqYLvLaMXtj5XROUQuI1cUX++WLdXtg+FijVikN9syWH/II9axls7gDRPK/bsjtD+U0EqDdD+DXtsf/8WSWh7cM+tbVrImbmCy2NKqZ2Y16yoCkvcS6KLetIpfeSq0pdYQm37MrE5dTW1LpYr/LIY5Ml+CfUjIGHbv5D7R2f4nmo2sCq6JoUoOFNYzgY87Cth4meD7amzd4eiaFyaB374hYeypOEoZTSv80wd91NRR6o+4HQv9Kh1IqOhljt3FyyUetl/GaArescjMRL5RA3kzsmptlRjz7nh03zlCrbO0lwsxeX4etOnvJTV1jeAUHe3wqEHFynj6USKYIqX5mh7+uO0P53ezWLuG0M2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(5660300002)(8936002)(508600001)(86362001)(2616005)(6512007)(26005)(6666004)(2906002)(186003)(1076003)(33656002)(4326008)(38100700002)(8676002)(6506007)(66556008)(66946007)(66476007)(54906003)(6916009)(316002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xkm5AxQyMmPh4uy85yXXaHLwUhDo+QztFEw8vvrHZIaTfp0K4rm6NT4EEDEs?=
 =?us-ascii?Q?VbJi0oMhNZjQ/ZZAbaWQkSsbwhYif1xRyn8quRWUWJxoMiudg90n29AnlArP?=
 =?us-ascii?Q?4+RbTcbyAwBsbKkb5dVngWz1jolPStU58FOrs/ixz2HPSZNU+EOnH4HRCm5E?=
 =?us-ascii?Q?M/BS3rtxRNYKDlpIi4BilULjFBQyFhr9XF1/PHABgiJ9dIjDF2VJLlLALgVO?=
 =?us-ascii?Q?m/l27hqWFuEUKZHn9XxePPwSe4amPmG7h/G5qqBKHCt6HuNpYhhVwFKEatwX?=
 =?us-ascii?Q?Xgal/D0L1SRj1xACjSEnoWyLOHSUpuub4sya9V5JjEIp+4SFbh2ZFtve+9HQ?=
 =?us-ascii?Q?qLl/2uY/QMfIPdb6QkxfQFJIcwO9E+CPCoPY002p05yNVL59FFW7790OodpK?=
 =?us-ascii?Q?SjAUCtFo+xjTkeoYAYk4TiYFVt1VtZ9pJW2nIC1EYYdVKn35JjeNNkazPtTo?=
 =?us-ascii?Q?GX6FnIyWQR7x6Xd4Fq/akaNgJxmkgpnSZPvZC6RsHeSqt00CuV5duXpq4KQs?=
 =?us-ascii?Q?ET+b1PTwLDZYXKS42rUwFv8Vu89MW7CfR7DbdQ3i+t1IW7TF96yzfryIPoEF?=
 =?us-ascii?Q?Kl2PuYlvV1izGSJyTJp06YGHMZMQWMlFFsC9sNzgArlxb5F+GPZ1e9NeBDt7?=
 =?us-ascii?Q?M5XiSdAjoMTHm91FMcn0EVlrsYfsYc0QX/iId7lWmnrbRBC/iozbTqETVaGa?=
 =?us-ascii?Q?zFrH5wvlSwH+a3QSLg2lW1leltMrsiJO9Z0L9vvtQ/Yy9qqj4wDNN5AI+Xv0?=
 =?us-ascii?Q?HaaB0KzrbvyhTzW5M+vzeufDkArradspvhgm83F4s7pnX4CqBSTRwKeDjj59?=
 =?us-ascii?Q?j+ACRrKp9IJNHPYqRxmbkpZx7Jkd4uIGvNPtXISFm/zlSZ7ovnnJD/hLkpGI?=
 =?us-ascii?Q?FYZnQVZ+CA5VdTTE7LzkQC7qfyinCUR1m5B6zEZC/P9BuN5GPxwtRY7KSPPR?=
 =?us-ascii?Q?c01WrscAGkmw+kVuGbLz14v2jmlDaqlWkWO2icRy/7oNZXEmwWLZJ6RMC2S3?=
 =?us-ascii?Q?eijz5+S77OykGldIoPW8m+auqwYPK/X8QaZt25v+iu+AG5mxnLtaLJFftVrz?=
 =?us-ascii?Q?v9ZOsqxCMCAOnVnE3crKkN1x60zKikvqf8xHsg0kw8D7YeHidDwQh2L017Fu?=
 =?us-ascii?Q?RZZO0Qabt6HcBzTvLZUL6bcAGOcrgPUUFuxlN/uAD9gOKhJyU67byt5QeeAO?=
 =?us-ascii?Q?RfD5tI1JKtcc765oU/RiBV13RbPwvCG33LGfgYecSUhkyCoRkuYShlWlJz8y?=
 =?us-ascii?Q?1taerPnFM2HuyxF4trDvKB7dInDGoc10edDFJYrAhE/nlni8DuvC5x0nKD8P?=
 =?us-ascii?Q?Sa/7f/qACzCxQHJmMhDiY0ZC0GwUHpg/f+747jwFhHVcFNBisNfnw7EVDt22?=
 =?us-ascii?Q?Xxyf64y/GieXc1ovgB0L2whYnxicw2Y3Ek95sn0qIPWonwk24AQFrSNYEWid?=
 =?us-ascii?Q?Y4dNF32eHvjQtG2K19i3Wm9nZV8vZsA3GTHWVYuMvTQm8QxCMpU+a+VsTNiN?=
 =?us-ascii?Q?Dbe5ppIQkCQCi/XaAHMAnuRJ6AF18kCowI2CfL3iPnjL60lm6sywrRIpz6Y5?=
 =?us-ascii?Q?gcBpyTFeG5/pnjty72Hm4ctS6qMPrNoedvtbF98WW42HkzC/YB8qH5lN9ksZ?=
 =?us-ascii?Q?1kTrknB2lPRBpKp7Vo01DBUMkXSvO55ImrS/X20SVu4Txl9fBlbr9UlclcG+?=
 =?us-ascii?Q?F/nETt4xopzcO5rhtVDhw9NDzegVtv4YZ3YJ/R2RXE7/ooYOkuqzl4DJ5uvV?=
 =?us-ascii?Q?VL1Sk5t9MA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca92f86-2cd1-4828-bd67-08da2d18e8a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 15:23:43.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twom0PjHl0PpfSc55Ghn2NEzA3m0BEjuBp6yvsofUZrpJOduwv4QWd0ixuywi6j1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 02:04:37PM +0100, Robin Murphy wrote:

> > I'm guessing SMMU3 needs to call it's arm_smmu_detach_dev(master) from
> > the detach_dev op and null it's cached copy of the domain, but I don't
> > know this driver.. Robin?
> 
> The original intent was that .detach_dev is deprecated in favour of default
> domains, and when the latter are in use, a device is always attached
> *somewhere* once probed (i.e. group->domain is never NULL). At face value,
> the neatest fix IMO would probably be for SMMUv3's .domain_free to handle
> smmu_domain->devices being non-empty and detach them at that point. However
> that wouldn't be viable for virtio-iommu or anyone else keeping an internal
> one-way association of devices to their current domains.

Oh wow that is not obvious

Actually, I think it is much worse than this because
iommu_group_claim_dma_owner() does a __iommu_detach_group() with the
expecation that this would actually result in DMA being blocked,
immediately. The idea that __iomuu_detatch_group() is a NOP is kind of
scary.

Leaving the group attached to the kernel DMA domain will allow
userspace to DMA to all kernel memory :\

So one approach could be to block use of iommu_group_claim_dma_owner()
if no detatch_dev op is present and then go through and put them back
or do something else. This could be short-term OK if we add an op to
SMMUv3, but long term everything would have to be fixed

Or we can allocate a dummy empty/blocked domain during
iommu_group_claim_dma_owner() and attach it whenever.

The really ugly trick is that detatch cannot fail, so attach to this
blocking domain must also not fail - IMHO this is a very complicated
API to expect for the driver to implement correctly... I see there is
already a WARN_ON that attaching to the default domain cannot
fail. Maybe this warrants an actual no-fail attach op so the driver
can be more aware of this..

And some of these internal APIs could stand some adjusting if we
really never want a true "detatch" it is always some kind of
replace/swap type operation, either to the default domain or to the
blocking domain.

> We *could* stay true to the original paradigm by introducing some real usage
> of IOMMU_DOMAIN_BLOCKED, such that we could keep one or more of those around
> to actively attach to instead of having groups in this unattached limbo
> state, but that's a bigger job involving adding support to drivers as well;
> too much for a quick fix now...

I suspect for the short term we can get by with an empty mapping
domain - using DOMAIN_BLOCKED is a bit of a refinement.

Thanks,
Jason
