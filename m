Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BD64700B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhLJMex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:34:53 -0500
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:58080
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241001AbhLJMes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:34:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGzzt1Zfp0kAlqLtWexvB7LFPx/0HexbTjcz1R4IM5frTyBb4VpP7weZZ34ddtJESwLw6oT1LJulH3Gmz6CWHTtXKH2hc9mcx5ds2Xe4pcdSJHUPdDoLDYlFw6n+PBnSt5es7L1r7H52fykUJRdHdQhW3BpS28zBCXjN+tt2n4hzqxU3JcF2HceBA5pJx+gECHnUV/pAaX8HXRtn6J80uH5Altob8++SNKuBq8rKZ4zWwOegtmywbqus+zwdye1ErMTbHpQ+ZA6tzHi63D9oFsHd8TPTi/fWoD924gbSNZ0u3NwJKtI1G/lxIruhZ+J+kSi7cvLL5PPCOtXUVzLc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CRkiSNW5sNxrbqYKp9r6n1SMm9DB4WjJoJsD/LbvIs=;
 b=culYv9eIVlXXi8RjcaO1tnwPNYoNvuhzy6A6k2YratSoLp7049fgeFV9Rgue/pg7F5wpFjkdG6LtDEdnBa7GVMO+EGG425v0LVHbrkeGy/+Dt6aYh/uhWGHZKDCLuC1H2X9bGkLeKqywtW7kPGoQTOaSAMNEdH2mxmJzplCgTo6IrkqRH5yHjN00hn2dU7UqN0pAWtervsjM5JhMoGZ3hTOfIcNbcw4BOtnq9L/ApEbJazQnFl0d1QqogeUpyUCABp7gvyAgo5OctinzvE2TQ5fkUukZdoAmJjerIpwF332KpC4QJaY93CTFV5AIN7CEg4P/OsOBCc3Ab7UYYxmUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CRkiSNW5sNxrbqYKp9r6n1SMm9DB4WjJoJsD/LbvIs=;
 b=Bmr42IxPgAa4kOpHQe2zRfQYR+8D+FrjKSOfruaIOXFlad7j42o/cd4NheLaxdllkdD9QNtwpHnLV0MffqmYta22udO2srgd6IYqV4VzgIksik1PZMHX4ef9y5H7HgKcG9bWiwAgGOjvDQM35CojV+RKa3L2EONF9YJdErXVJioQM4hKGrZ/Ml6Zis3IAp5tDikP2gLBbDyOUote/T0ULvG/4XH8lCAVGL3Ox7OlB7BYCjK6krX0XJmgRtFZyHm5JWbm35BU5H/p9Ee3cG8q2Vh7m4OotL5w2vIC91gpiRWswXvqdHFQFqgdRbRH7V2L4bVKWcxvz10RnlFHA5MHeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Fri, 10 Dec
 2021 12:31:11 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 12:31:11 +0000
Date:   Fri, 10 Dec 2021 08:31:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/4] ioasid: Reserve a global PASID for in-kernel DMA
Message-ID: <20211210123109.GE6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <YbHie/Z4bIXwTInx@myrica>
 <20211209101404.6aefbe1c@jacob-builder>
 <YbMYkKZBktlrB2CR@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbMYkKZBktlrB2CR@myrica>
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b4c6d9d-6f8f-405a-dc0e-08d9bbd8f2c0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5046:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5046FA5F951C384238DB1786C2719@BL1PR12MB5046.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2Ipo9Ngp7/LEwGPyM5rIkndL9NVHPuEYddF6g8aoOf8xGUJLv7kismTbwkneviQqCsO4BVPUydkldjyLQGyZVrM8l0Vw5cN1xJtHDS/jHVHluFCzm+JLl2560YdNJ0o+X6irRmnZIyA9j4nPF7OIFQ2bgHDVxIAGyDAQ7DUGGS/ycyVrmtu7ldSI/Fa/FpZHC/loOjlZ1wS2mCnDXco6VlOheBNIClvpaolxCIov/GjJP7BcW61IhG7qSQYkQdCQRu0kSS6J6rzqwLDceUfT2m3TmnukL8X4U1ZQlZUC4JZFOHcWlbUhAA01MnV5DvP/x8lL4K6xmQnN7CSdJfQ4pK8cgZjRTEH1kFj6tc8rhG/O1O5ZURW+QuPSKpmsgphZRxTVSC/Rjq9vLB4N1/BauiNCMkvaj36jMq2G2GN7V2wBWMxkp+suYUKdz9eMeDY3eLNe8pv9W6ssQT2RN0m0lNcgpQJazkZVcjxBILu2jeR1MRsmSCoQIhBGennqLJkeZvIBdhg2Wr8lBb9OhJvY4x33JIQU8/vLGFuv/jI8F6VMyl8zMiigDwAgs5yZUGxsoXhzG6HJOPW91VpGf4tiGj2F08jE650N3UiPgVBM5O2dfKlEj8omn7r47N37n5TGa0t9/UOzEGDhsU5/TNd0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6486002)(8936002)(316002)(38100700002)(4326008)(26005)(86362001)(2616005)(7416002)(2906002)(186003)(1076003)(36756003)(8676002)(6512007)(33656002)(5660300002)(66556008)(66946007)(66476007)(4744005)(6506007)(508600001)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5TOKNoc7uO1pCI0guVFTbLiqz82+QLMh6elql1eZw0AtRhocNtLPq1RAiAX?=
 =?us-ascii?Q?p1jz4YLvHE9hIuAK5v8vQysX9s5EqOkBblNq+2TR+VQ4827P0lPG2jr5zfdx?=
 =?us-ascii?Q?Hw+pcugKppfQP9f32jxyWFeFK1IfFdPIwAHTwp3NTPpfvg8M3BvFumLUYmlP?=
 =?us-ascii?Q?w9yH1lz94SMJtYa6IOHdDGEi1J/UYvvXAT18G5Dahc+9fvu1r1ZApimmuOBa?=
 =?us-ascii?Q?kHXW3EhK0I01t9Ll4ZVoxzrszWFnxj1wldyXo1MSzNRM6bljQ43r/OqWCxNG?=
 =?us-ascii?Q?0XAEImiHvOalD4VPFLmCrFmKkXEV21MRgCiwng/xYVTQHsDhE7AfjiZRzVt0?=
 =?us-ascii?Q?fwR5ZupM7uRcGmjwTfUI34RqnL9vzgYZmFp5X2G2MAhXmKk2rh3Q1/+IDTMU?=
 =?us-ascii?Q?ki6nplYBLGnlQ8ZCeiIMbMnCZtZ0GRLW177oAAsTJu2fXawRKWy7CZDujJoc?=
 =?us-ascii?Q?E69Ux5Hnb2QpbtopVQh/3sWxWJRn+1gJwquM8CdOCvzc85qJbc+imumNZFrZ?=
 =?us-ascii?Q?P5TjkSMjP9jd+DOSd46t4ISkpg+jSV/Gvl4z7VyEdsQ2sOgUpg5yFoU+GqWJ?=
 =?us-ascii?Q?UXUeaZL54ULCKbofMjHwu7gnm78h/tft7Kb2uqfRThFv9ZEHHNFsSiT982jW?=
 =?us-ascii?Q?3pJdTrmM+0SY76mwbPKuqJ5GIJfsC8aW7XT9L+ArRT4GlXc+6GbctJrFKZ36?=
 =?us-ascii?Q?3wZLoqquxmLoz+1UDhbj7p3nID6DdnYWVd0a0kHuidxMfZDFncFvjf8N9uZ0?=
 =?us-ascii?Q?ViA8V5ldjLf7c0I3FO1K0CBqxZwJ008WnXgvoyX+HCwUH1Mpw140tba6ltkQ?=
 =?us-ascii?Q?ra0ssB+J0EbcfIS2EGzY5jsdGmjHPeCg+z1qD1PP6PdJ+wUs/oQgojkGCL/T?=
 =?us-ascii?Q?49vd7MEbhVcyPa7AI1UgtXzUc+gF4SD5/eZmMxYdN0wMJs2jfBgxbWSBiInW?=
 =?us-ascii?Q?6zmlsAg4HIi7J2AAJt7A/tOy4/bhvGr1fS327Us+F/S6G0qcjRg+y4XHikXI?=
 =?us-ascii?Q?FUIIJ3TGIExTXByCmpge40bTt8ezwf3QZzjAsRj6dijDfxebKNAgGxAkmZtq?=
 =?us-ascii?Q?bPu1GNMvLmp3CdwOrPjV8p+1xIxpf2Iyo0Je6DFGJ2veXTXTOWsb/jsQFFhD?=
 =?us-ascii?Q?kE2wxxoywnafnb+TIhLVTv0cbQ/U4/UJVSNTdf0i2YSpzxpncOfhOgdbD8wL?=
 =?us-ascii?Q?tm/zwR7GSy8WEWTOqNGhfRlL7OP1G1m+Ezs4CwZpI6anIg3o5OfGjhlBQYR8?=
 =?us-ascii?Q?hSDEO4zQ7O2fPorZTUkdewZVnofnQ30kFWXczvvOp4/aLaCv1qsUAjoyReqd?=
 =?us-ascii?Q?EUli4RvrMfFF91Bw3JDWLpJeOR6YOtpBno+e4N0nAnh/reJn5cFwYU2/9Azd?=
 =?us-ascii?Q?5FowE8CgJDSaCR8kiWEgF/LN+hnFF2uBPqDo7roIeYyc4xCicUuRGR9vUZ+o?=
 =?us-ascii?Q?hlmrTJSn3Dx2WDKzxMN3Rb6AIPvScDcVORc19urTBXESGa+SiKK+uAOr+zif?=
 =?us-ascii?Q?EbtY7cNmo/SvXd8L9as8CNiQiVfMoJ9ASZtvIYyotJfcVJE8mMgHpHNcHBIy?=
 =?us-ascii?Q?EX2u7zQ9qUm2vWSBNs4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4c6d9d-6f8f-405a-dc0e-08d9bbd8f2c0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:31:11.1265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gj8FQNzGVf6no+7EY2cnCCpc5shqBGhmw929B9OXslJYxp97BfLQsP8Zb1V0ortx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:06:24AM +0000, Jean-Philippe Brucker wrote:
> On Thu, Dec 09, 2021 at 10:14:04AM -0800, Jacob Pan wrote:
> > > This looks like we're just one step away from device drivers needing
> > > multiple PASIDs for kernel DMA so I'm trying to figure out how to evolve
> > > the API towards that. It's probably as simple as keeping a kernel IOASID
> > > set at first, but then we'll probably want to optimize by having multiple
> > > overlapping sets for each device driver (all separate from the SVA set).
> > Sounds reasonable to start with a kernel set for in-kernel DMA once we need
> > multiple ones. But I am not sure what *overlapping* sets mean here, could
> > you explain?
> 
> Given that each device uses a separate PASID table, we could allocate the
> same set of PASID values for different device drivers. We just need to
> make sure that those values are different from PASIDs allocated for user
> SVA.

Why does user SVA need global values anyhow?

Jason
