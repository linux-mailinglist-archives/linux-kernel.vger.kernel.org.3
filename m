Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDDE46DD16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhLHUd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:33:59 -0500
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:23147
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231801AbhLHUd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:33:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF4Ldyd5avd8rSz1CzQAJZiGJRlLibqDXUjUNCZR6aJdo5vIkPRnlfuARqQi0sw2EI0ivu3qny01jnI+rHYSN3FKhpLyOyyHnuIY8m7Ubis6GNGkdbQoUHv2qssH7IxWaPV7vdl0aIP9Hr57JJPmiD7N8+qK1yjD4ERoqN5OKeu8NaFCD3itwNAOQEcC6ryn3YUWnwssLqUD6P48xnRYu2/GMXyRHRS8M8ZLFVTs5Ml7dPwMRdmKafwjnrzQV4hRj8NIy8sU9f1CzzBiCACDpLRDvlNZhzrN+GlZd7pnBB/DM4SFyxseON1LbyG6yN7/5P9X2rHQf3syqW7oVTd0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ro57GieshXGyt29cyw9FiGrIK8UEqSvfYwza4CFCUp8=;
 b=YsYNu8HzCHTPStlTPYhakUCSu4sAv2qJw5NwB1f+hn6v+29lnpwalbiBTPNUtfYQTp1oYiF5w2E/BNOpRLXntReu1ZT/gd0axRXaigj8Ej7pJIHpXm25Eiw8vLkWdMuMDAw1MFmT+MPpUD2Webtq9aoaJ31I5qXPMGdUUjTwcuFYC2ChZGl6ppY5VdbH4V3M5YqDgBAdv5i4h/P7TnerVQTJEUqr63OBabWGFXkUrQ9C8mUbROir5BB/K3IXyRibmERziMzpvLwwNy6euz2BY0x/DdCM5NKrbfBreWinzes57lSwfO7hgqFVxrW5kkuq20c9BqWOI3OOGwBNcHVq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ro57GieshXGyt29cyw9FiGrIK8UEqSvfYwza4CFCUp8=;
 b=A6Do4H5kQjSvbU5bBGaYesNTzI//VKiaLHJVrbHx4fU9xLWC2hXkRMYAPAz6S7WLmZ6cFaOI5GwNtOsLTFsD65WlvYonAxoLpxwKxEjrhglMnyD8XFlBt95DD4QmRF6eLbfgaABzigaN5fCTRhyHVlhtQ3dFrZu261JLdE7VoSiSDXhgPDIGM2+i7Kfgs6XWcEd7SvFjUCIrJhSuUmOJYfpAeYR5J9E+832OLJvtsAszObZv5Qxky9tI2NLNMNXqCGofchecexCV+hYvCGKvvnyxJgr7zsUWY9ghQYQUKXIvPYZ6PeluM80hHOdBj2iG3mR4MQ4+jj+g90dAPUg3aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5380.namprd12.prod.outlook.com (2603:10b6:208:314::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Wed, 8 Dec
 2021 20:30:24 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 20:30:24 +0000
Date:   Wed, 8 Dec 2021 16:30:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
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
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211208203022.GF6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
 <20211208115516.1d36fed9@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208115516.1d36fed9@jacob-builder>
X-ClientProxiedBy: YT1PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fea34adf-db46-466a-830e-08d9ba899005
X-MS-TrafficTypeDiagnostic: BL1PR12MB5380:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB538017A8D605E6669F3E1648C26F9@BL1PR12MB5380.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3HUhgS1dW1SAPSuESYc2zChmsP47LXeIPz7kGCTauMFBNJVUxBiACAhobtbACi+6soncwTplQiAO3Q/mwj1WTM7FszG/5TdWz3UeoXTBP9wTXG6naUzcRHI36jkgcmFE8DSWkj1MnDUXkU9pLYapjKfFViReJyj1xlKEiKNMEa3U2FY+nIAPlaRPZR2ZvlNKpdzVrORfs9uADB+bxxf3PGxA3Z70MBE1J854o/XXn7MzxcR5D4hZciar55hhqknbkVs0J08izrUrgDv/lGcCoM/+k9FpQY+c64Hfig1iXbXl9dQ2WDzR4Bif8sVFBZtpuDHMCg6zRLR89sSTz/Z775t0bPwP//d18rxuQPp5R8ksh9LKzEh/15or1OrjzgSh/FLfRYBc+vG2++uJfG9Z+ePslspGxyvZ1ylMyO5pEHuvHI7ZK0888uL5/nunnz9bYD4YMa7rphlagJ9oON9ELbmu3JX08yiduMrv5/m9EpVsxMjJzFieMpl1lD4ubw8+H/4HK8ONTURAfXkFn2tAjhyJ+Y2Ytl8e5y90FvOAK/rc1FLW5XKDeANOffEySApaX9tuFgI7tpaL4+ok2/aPtdlMW+jOU5qON2pRmKZxCYW/QuaIRwvsL5jVj3TWs9CsrjiNifNIE8LRqutA3uj2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(33656002)(7416002)(86362001)(2616005)(8676002)(26005)(6486002)(6506007)(508600001)(6916009)(186003)(54906003)(66476007)(36756003)(66556008)(5660300002)(316002)(1076003)(6512007)(4326008)(38100700002)(2906002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6/QwHCQuEO7p4vKYLjWdtyJ4FcbRl4WpYj8NABP86ugCZYXpb2vgsnTNYt40?=
 =?us-ascii?Q?8w2djtyUQkwt55QeVHURBq5tHuYvCpsfh8oVkq2ANtnKwMnJtHyZjXwwHUlo?=
 =?us-ascii?Q?jRf+aaX0nFiubfcJlvf40l3YFd4mHorxxvkKSeTXjQR0r2Tf18KPNQUE/hbk?=
 =?us-ascii?Q?j4I3yOpK7KNEYmWi+X6yMzOXmpqgvWvwkA6FpuLY5fpeMOMtPTAze97XAWDd?=
 =?us-ascii?Q?qr/at7nW0WOuiO5yF7uCEqncpn21c92f/FWK0smJuYAHcZJmhHHNap98mqQk?=
 =?us-ascii?Q?kmd7yGur665i1r6cAFnV1aZyDrGLShMKnRUN9kb2bLR4HNOGhjpgWobf6lkq?=
 =?us-ascii?Q?YZg29h3a/eZeKi+z9BIJwvD7ltVi6WdktojRkPE9zCDvzUSottDJegojKUxZ?=
 =?us-ascii?Q?xZ4QGtL1h/To3blTnR1rTTPwsHDGsvyAUW9e6cIM3eUKupHEApz5F545tFGK?=
 =?us-ascii?Q?JIHuEHkXLo9dyGEcsGesPZPJQAFrhZperp2DVq9x13U4VKa2g+cnMlqyxwpb?=
 =?us-ascii?Q?usIud/CdWlNZQHR8PSB5q1/1JIK4vKKS/ls1NOlEQCaSbjk2/Szc3SULwuQ4?=
 =?us-ascii?Q?D0MfMEwX69mcpeVY8yQ/Yhvv/0UKXanVa+3qTOSwHocy1Uzr0SRjodzIDEJq?=
 =?us-ascii?Q?fMxm96xEnEukdcSMFaucNb66NW04Qd4aPfWaas0rWlfP/ycM2a3Rg/msdFEW?=
 =?us-ascii?Q?LRp5gNAz2NIROfLm2HqprAYt8zD16e+jed6mEZkgchPeqkv+CQ8uBuC4MVj+?=
 =?us-ascii?Q?0XSqFuRjhT/wswR1qYMe4JyVwpvrmXxHZOyblwI74vTqX7Yk3E/jsWOKPXt0?=
 =?us-ascii?Q?zhIFXdK+4072owukazAPBJyav53QqnmM/Nhvq7uanVwjb+GuApQ6aVz6S5Z4?=
 =?us-ascii?Q?eb+qNB8PUBB4esS1K9pKzBC4sf3oWat2IULeRmagCHfi9AmYDG9nZyASMS8u?=
 =?us-ascii?Q?iiw+YEx/xJ7aLlxqJDuPviOPVjPbLdLBTBfUm2sjON9DK53n2YNCrZWGfXlT?=
 =?us-ascii?Q?qGfaMPEkf2v3A24AJ/5p2yFwHGCQQbVLsIBGnwoG9Vn5+23oQaTOrwU1lNJY?=
 =?us-ascii?Q?CgL1qFhK9rcLGqLgfNYrk/+cD+vxysjati2PYK225+O4LxUwTe4xZMziKoYR?=
 =?us-ascii?Q?vuLg1ob7VgSZyXeFGOExrYOKqP+thgXFVUbcakynegTEN8Y5gwe8Z1sc4G9O?=
 =?us-ascii?Q?qXUAbIAGzCRwQWoDbAxO+2Ze2ppYLWApNxjz2y6bxtUAvO+FsZZ4V9f19mHO?=
 =?us-ascii?Q?uKEg/CMtG3HfAYSawjLs4Yy+w1Env/37M6CmK/T0y1rsJZ4PkQvM+NowkzQI?=
 =?us-ascii?Q?bGhbwM+W4sOJ/U29Ip3D0YMGDdaKHUXWQ5HdQuRljNqJ6GVH1Xz0yCsli7Ia?=
 =?us-ascii?Q?j++0gTIGifz5lfSlBBm93m7XdydVFqOARVUhBjuKGviYe/vQRr1KImrJBpAl?=
 =?us-ascii?Q?TE0Wm7B0ljsCcoRaIUSpAUMPbcUZLOa1Xh1VnUsQPwwjLrOu/sarx9RXIGu5?=
 =?us-ascii?Q?8qwzthCVhNfiflfFJHJkYSYJRNgGN8TwFofIpCKigEURmYEXxPmNV5SK6uEm?=
 =?us-ascii?Q?QsQFYNkO9fZjyjc5Zm0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea34adf-db46-466a-830e-08d9ba899005
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:30:24.2029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63MNvlVetje51RRDfmLnjJQSu5aaWGr+ieV5H7j4RFMWLXAkuo5ZGH+N9lh19QAm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5380
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:55:16AM -0800, Jacob Pan wrote:
> Hi Jason,
> 
> On Wed, 8 Dec 2021 09:13:58 -0400, Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform
> > > DMA requests with PASID under the same mapping managed by DMA mapping
> > > API. In addition, SVA-related bits for kernel DMA are removed. As a
> > > result, DSA users shall use DMA mapping API to obtain DMA handles
> > > instead of using kernel virtual addresses.  
> > 
> > Er, shouldn't this be adding dma_map/etc type calls?
> > 
> > You can't really say a driver is using the DMA API without actually
> > calling the DMA API..
> The IDXD driver is not aware of addressing mode, it is up to the user of
> dmaengine API to prepare the buffer mappings. Here we only set up the PASID
> such that it can be picked up during DMA work submission. I tested with
> /drivers/dma/dmatest.c which does dma_map_page(), map_single etc. also
> tested with other pieces under development.

Ignoring the work, doesn't IDXD prepare the DMA queues itself, don't
those need the DMA API?

I'm still very confused how this can radically change from using kSVA
to DMA API and NOT introduce some more changes than this. They are not
the same thing, they do not use the same IOVA's. Did you test this
with bypass mode off?

Jason
