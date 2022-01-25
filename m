Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A649B72C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352337AbiAYPDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:03:39 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:48563
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1580930AbiAYPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:00:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQYB/O6Ld9AtIzXz1zK0XCaz9szpG+BqB6vcOQDvOf/sb7nyOQmhO7Kfk7qUM0U0iXoBPUXAYy9C80fL0Lh1CnHtKjUCGe+yJFikIZkAxgi3qzzq1mcu6f6vCENnDHMehfLC7k4DV5HIam64+Mur2BaZ+jtFrhI6fJ/XDYtOGCP50OpF8lOY3s6OPuXv5ECt48mAwTP0Xw1bmyXk85GIMLVGkcLZStcwhR98Wm/88PB/wGbaR/1V+INDvFP4nLiFVhSYWyrPpkDPvjo/CT6hPsgPfl7jY5d6dvJN/bNLI2tiyo5+nqJQrAfP1YwGO9PtMEuY7l5u+Ide7ccQPrw3DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD3pd7HlRaHA5NhpzbYzMfTO5M//PKZKQh8HRBhmZT8=;
 b=aoNj6M/6dGP/Teko8FCNT5QLWu0gjxhdLYQjwQd4YQIoWfVdbuKLqNqNNbAMgANkvgE0kKA7ZaP7f2Tt/mifey4lTWfw7rW2cTP1AQaSfYIDPDbKtymHdrwOVtvYSIx7U94gmiaUL05RAxU3lq8hyl1eOZ5yev5RHvrvYLADjGYCK8MSHzTAkr/JqUQaq2/qfhFfyoPHXkl7pU8Pj0WSwl/qj6l5FoKBq2fRzhEedkf/nxFro5FDmbacdzM93pCAEpr4aRyqQEVcHH7bcrdRk6svdEeq2vGpmTeA2vE0wgKL+9zIbmz9Tglc9jD8lf6UOI9H4w9z1gyR4ooU+nYphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD3pd7HlRaHA5NhpzbYzMfTO5M//PKZKQh8HRBhmZT8=;
 b=N+IdyyxxXIjpHqd+ltwaAFnoNuadEXRH10EWgdDZp0llqwMUmSQTXHOl/hLIvu8qAxH3tXJGlHIGl9XlHpElzpxcOyeYEG4lZkEm1XoDozXKsuAuMkAzcS1hNkoqVQcFn8YrmkNv3PUpvTJftkWRJxHUTcbxdUwdneZnxcojicatIgjTUrzEbMld2x9eoamH+uGTH/V4hzlmnlgHubTRSOYyD3fKvmt/AH5Od6FtLowlSMnYyn+bNePDsM/5VwFzJm+R1qQ5PonZ9ZgeEQtGbe8c8jtySBHPAwHtTmXS9b21ipLhOw+ckFeJPTHvvOlQvg0AzKUtp0ssKsNa2y/zSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3793.namprd12.prod.outlook.com (2603:10b6:a03:1ad::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 15:00:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 15:00:47 +0000
Date:   Tue, 25 Jan 2022 11:00:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <20220125150046.GK84788@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <99023cd7-f037-282f-3f25-629a14a1578b@arm.com>
 <82c5db53-088f-a51f-6fbc-c977ef871d8f@linux.intel.com>
 <ab09f75c-08cc-1845-9aa7-81fed779d636@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab09f75c-08cc-1845-9aa7-81fed779d636@arm.com>
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a519a13-9f36-4b42-d54f-08d9e0137829
X-MS-TrafficTypeDiagnostic: BY5PR12MB3793:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37935598080ADA6A20B6E97DC25F9@BY5PR12MB3793.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fiRPstVSOKRR6qmNAMVmktDtphqcDQj0PPDiZUubwg1GBn+9o8k09/V8LQ3BobvOdmolvjQ+rGn5sGbt0h3MENdENOg4C+dyjAmOTjMCBdj21VbFCQkLEeAl6r4xpG8H62R5psu3Wf0/xhfMn8XnknuilRaDel41uLB80De4OpCY8Xxb+KZU4IOkM8EwvMxR3xsW75OkJv+x1+lBX8XqgZ2Bx6cEj/mmZZS1OV4/EWxoIcg3EgZBM8Sx4HfmkVwFpOmpen6/zFv0vt1KcAeocBj0Wk9VdXDNmDOlUDd7liHGC5FcDfEz4z7aXcauIi/PJ8I9+2IHH6ZXuFjcm3C6mx2zfdnApGsHrDWtDcOiw+FrNyzrixtFPXqs7KBC4KOMhAf+9R8JJebF4WvwFVAwHfl7pU0dNBboBoz32ig9Xs+G2+4yUWSt9CjeobP4f+/jAl8losdb0ryi9KsHn7NEFiHNR3zANKj7SQdJfqSY9mNkN8jaI/5nhL32YAsNrj0iw78GeWKALDh0j9HZwHjqaYIiGLhSb4HFAbrWdfENK/QkE9ruK4bCfGAuna6viLX7ZAYIgF2oejJBZ60vmdzblDxJocn+bx/46gHdQL3LLC/X3D/XpDeBL2mA5GeqRs+l6Jec7vs7yBJrJ+/Svu5vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(36756003)(6512007)(66946007)(38100700002)(2906002)(83380400001)(8676002)(6486002)(8936002)(1076003)(26005)(6916009)(5660300002)(4326008)(2616005)(6506007)(53546011)(7416002)(316002)(186003)(54906003)(33656002)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Aj2Pud9hQD1/3lU1M2qUQ6Z2ST0q57ARnUEJzxviwud87is8GHNb2nVvXG7X?=
 =?us-ascii?Q?AuWX+MvYO/XDPVX6YWL9Cs/EDe0N4rzap40hAW5AdaFo5EFbw5p7p+o8GGAT?=
 =?us-ascii?Q?JWZ1rS7Extl1D8biDG3Q82lc50GcCyMSisEponKtoRAqOusW6kD/IBdb5MJ9?=
 =?us-ascii?Q?kDIhMBbudVkZeApFTiFQP54WFnJXTryU9OqJ3M7RBf19XExtDynunSMBNkA+?=
 =?us-ascii?Q?DAb4n8JEiCd4HBMH/RiH51p5gWEF6Bw1aGp7+1e0rdcrx24S+mv8SolnhT4c?=
 =?us-ascii?Q?/yZTmZHeUwbo8wBXnbLBsM7Q/n/qYXEdyvItLCu2Z5v+w5ZSSQeVI0AUYtyT?=
 =?us-ascii?Q?q8vjmVX81RFbnu9Rq81ie3JfDNr/BLzOhMvVYgZakC/8pBb+r8BOt1LpxYpS?=
 =?us-ascii?Q?gQJSWi2xISOidZ8PM1un2YWIs1ysABeXWxGf80JXwYCD4wuL3Yo5X0Ymb2OP?=
 =?us-ascii?Q?Re/gdXoCdzGJOMDbAqQsYXmIgYRuqF9OJSCB2pd/cFG9OVtmcLyEp8KVTz+u?=
 =?us-ascii?Q?auhPvLyClnBtVEZieKSLVmqzwlHuFddAxZZd3Ow+TGiNldS8+rGXFWaTkxIT?=
 =?us-ascii?Q?S6coFndfPWN2ibZGy2UxFjoqgZnTDKwWixk961/B6Yi3AKp6446ll6IPtU1J?=
 =?us-ascii?Q?1xYx26KuHP6L66Goh8J1JIgNvcGnRoZU2Omx+JBAN27qPi5CSmhhswDPbwKY?=
 =?us-ascii?Q?VcFonytSgs5pjpYI54yx1HgNU+EWQF3dfZktw6/VRkqb5b3JJCYLKfOFk4EY?=
 =?us-ascii?Q?lwhdTm92YxtHtCycPCfRfxOvFtov2T9BOKulsWVlMPYKpmSdeZ4wUCvoryr9?=
 =?us-ascii?Q?TNL2fG7Dap9pDcS6hJ538Bl0zDPt5GG7j7rGd/29SHh7ZZA6Ky7IUO8ulbo2?=
 =?us-ascii?Q?Z+kkBZOix0rbDBi5cKrjKkryCLPi8Ad72QRBt8meKn6ciBLWYp8dZfH64Nco?=
 =?us-ascii?Q?idiyD/ugBKaiLswtz6Fi5/zDom3i0tBai17NVObFa/rKFg6K81UvsLTmv6M6?=
 =?us-ascii?Q?FGF+xMw9iJZot0qk5xelUBmqbDvnrT+8jX/Ucf55rVr++Ovg2qvC5xqjcOXv?=
 =?us-ascii?Q?PWbJANiyBrTrJE0G1C/pBfnIPDu7BjKL315TIrpGzgKqa7ZhhNcXErHaPhvm?=
 =?us-ascii?Q?lutnfRHwf99rVVNw7c/emzjFHYzS2A6imzE5a1DICksxX904q2oo/xs42j3N?=
 =?us-ascii?Q?KOcTycVU6+n99XcArnWlvIjoiRZlfwBKZWM77di/QKusM5esSN6kFNKDPfZh?=
 =?us-ascii?Q?TL0I7q5R58H3oc14JVQFmLwLtzG7+thCjMHuYnzPgKKTDcZUYFnFLtU2jD78?=
 =?us-ascii?Q?EPdQ+N0GcUcB3oi+SElYH8EyK8jzOuGtXTIVGtcmRQ8PWO3j27ZubtFLbYYt?=
 =?us-ascii?Q?I+/wwA5XwOliwBD1JgsDKOjDi4fQbOMOUT6n0GY2LWrzyd3utgbVomoWGU6U?=
 =?us-ascii?Q?50x3ruTnq3CtJn3fktNiL7GnZZsilY/mTguFm1d54W0D8jTz/nYkI3/T4Wrn?=
 =?us-ascii?Q?7ZlWzrQ5gQwBnbWrg+j4SzYIbTbcjYitFbYYHzKu1eyvMBHfD3XQkVEgVvAX?=
 =?us-ascii?Q?kDFEwY1c4Sf+HUY5bqE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a519a13-9f36-4b42-d54f-08d9e0137829
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:00:47.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtiZPk1aOj5pklzf+I5xCNG/8JLgvSx0u+LX3rhghn8Oov6zVJ0p1oJS3DZZVUaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3793
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:23:52PM +0000, Robin Murphy wrote:
> On 2022-01-25 06:27, Lu Baolu wrote:

> Where it's just about which operations are valid for which domains, it's
> even simpler for the core interface wrappers to validate the domain type,
> rather than forcing drivers to implement multiple ops structures purely for
> the sake of having different callbacks populated. We already have this in
> places, e.g. where iommu_map() checks for __IOMMU_DOMAIN_PAGING.

In my experience it is usually much clearer to directly test the op
for NULL to know if a feature is supported than to invent flags to do
the same test.  eg ops->map/etc == NULL means no paging.

I think we should not be afraid to have multiple ops in drivers for
things that are actually different in the driver. This is usually a
net win vs tying to handle all the cases with different 'if' flows.

eg identity domains and others really would ideally eventually have a
NULL ops for map/unmap too.

The 'type' should conceptually be part of the ops, not the mutable
struct - but we don't have to get there all at once.

> Paging domains are also effectively the baseline level of IOMMU API
> functionality. All drivers support them, and for the majority of drivers
> it's all they will ever support. Those drivers really don't benefit from any
> of the churn and boilerplate in this patch as-is, and it's so easy to
> compromise with a couple of lines of core code to handle the common case by
> default when the driver *isn't* one of the handful which ever actually cares
> to install their own per-domain ops. Consider how much cleaner this patch
> would look if the typical driver diff could be something completely minimal
> like this:

It is clever, but I'm not sure if hoisting a single assignment out of
the driver is worth the small long term complexity of having different
driver flows?

Jason
