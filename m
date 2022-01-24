Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DEC498697
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiAXRYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:24:22 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:65457
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244445AbiAXRYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:24:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAOXXWhB/1k9bBf+M2QPgWSla88BEOUdE8OvoKHg0jNeJojCo+HP1Rm+7y7x3B0ooAfI/YZnNvmDbYkA5qorpG/Z+OOtAwIuhD6ZSb7XQ6VmBGHKsSNuECh9DhzJKkOJYqOcic5ny0ZHiqKluQ+el1/uNdio+k7X2dGVvYY17Bg1i6v4bwWlk+snxYvNoJVIjiJ5u43cINiJvhhXm5Cgjr4I9nelmsFGqL8xFqdBeplE3stdKnIDBDbw/cjZDZ/UkiWsUbwwgsdrwHGvkrfmYP/ee88f07s3KQ8E6Yv1LOHWNSb49+JxaTCBtcbWiR+sE0qnSPiPMAuo7isNK/1jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0tU4GzCk5kbbSqU3xo1/7c6IEg+nJIOcbwyD+ZF0jM=;
 b=QjMIbilSeAczSGl3ctlpkDdf0xNu+D/B2Zui42tYFF8sGOyVHfDjlAhumBZBFCzssK05cfvX2buiDnLwJ12F6lrdw2tbrCWEwRIZt1ZXk6LxNzzsTQ5Oohq8vYN0XLENAFhe4F7XLdvvydvBBA8+XNMP4ZatEyOP2R1KRLOYJR6hyZ6fvI6XU56q43vtXA9hnw+/fxec9fupCxGfStMS4+U4U948R/3Fk1lcwkq7e/+PD21+X23r+Qpc7i3o/aQy6XhbGodAOeu1Dptcve7YiCQ+vYS/qcJ56ZAk78jqyyGaUxvwkbYnwMkhNxtqSy2xh45i/81MmEXJhVxSdxvIhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0tU4GzCk5kbbSqU3xo1/7c6IEg+nJIOcbwyD+ZF0jM=;
 b=XHckyeP6x+iX7VmRBkUjn3La+k4xskaZgwmBm719vlnZFmLsToI44jBycxTEknonIgAT/YCSHtJcncEr8sPaUcVxEQElPyMcqdFSzEgmNey6q82mz9HNx91Sjg9uoaIw7VNkq0UVehY9V7myzHdSyIe6giQPuV/FXms/ti83bwGUzP+EQz8GapATBsyZfxvj2XLkyB3wXgrf9ZFgHSp+EhzykNMNpQV9uAe9k8s80365NU+piHU3q7+AJwZqSSji9hOnl4RSrJTj4NirSV3gYnY47L2FU5X34TzTHXoWR0YDJJ5K/YAiItMwlgQquSO/CtHIiiqaYn5Ri3pw3g2dMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 17:24:19 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 17:24:19 +0000
Date:   Mon, 24 Jan 2022 13:24:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20220124172418.GE966497@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <Ye5zUapC/YcZs7kl@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye5zUapC/YcZs7kl@infradead.org>
X-ClientProxiedBy: MN2PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:208:23d::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30e420db-3d3e-4d41-168b-08d9df5e5aad
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4553B7EEEEFBE52EAFBB661FC25E9@MW3PR12MB4553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THM/hoBXRmxXNt3EoSgooWF3vO2/7UcXqFh5vnM/evFQpUA55WStSJ2A1556r3hD6lA4WnmwP3/QCcjbUiWYCZzGt0qglyOXhSbcahvcTOYT3/R9ONJ4ImNDAGLVpPUSsrvXePTeSIEpexebRvsa7eTWYQTVojoBRpy8R7zeSoyefvcyyI1AYOxWuqOrDJsd8ErANbg3CrtXsHvdshUIk+wG0Loe5fMAHzt1rYDeqQkPTwbJ3GfUQ796JmTkmlF9obBp7mL59a1G5PJ0RSrb3EtxmJ69/fEg7ui/zVI5ClfJwKNiWwChljqTowdkDD8hUhyo+dDNM+oufhK8RWp41+NmatZPi2lU24zp0OhbuwxIHo/C/wHc35UhD8UNj89OSv9h7vaNYkuYerTYT51p5sUBLdgLYEB7VV91AnFawusAWutnYfgM4eaOnKpL9vhmXsiKQDhMW1J/PNdk8bhUduFbwbgnZxcxPr1LbSIvteF48WVS+CzPBykPu2w6JRconcTQ8XdMVZ6Y7TUk7YY+ZKiVkhnPZJ6YFqCZUaicKfF95bW53Kd/ZhCDoXXoM6UM5nE+gCEK+DuCHyKzQsLaXA3h66lRsVPx6EG/sTGCBCGmP2oIN/HherX/9lZdO08R0feEji1s205O0i3k+801MQEEEmwSYyZ5/XvOOqmkO7ye3tLPbtJcf0sgQJWz4hNlSGv3QKgISEbmbom8L0Z/qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8936002)(5660300002)(36756003)(66556008)(2616005)(7416002)(86362001)(6916009)(66946007)(38100700002)(508600001)(1076003)(4744005)(6506007)(2906002)(33656002)(26005)(6486002)(54906003)(186003)(6512007)(4326008)(316002)(8676002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?br1stUBLBkA2qTRq5ldePaan0FKdhfiDz8XV55J64VId9U2MXwV44ExAvFPC?=
 =?us-ascii?Q?tnJbiSdfOa1runOuWZ5/bw+LVSILTtyGLwL7YbgI+e4htPpJzIr5qBCiBapg?=
 =?us-ascii?Q?tbdL33aFtEnK0ZyPxCfc3K/l4CvLkvmHtdelJdKnr5LxDR9FpFc6MtLIZBGI?=
 =?us-ascii?Q?J6yIwF3zWkpJzcy+F6epvE0E/8HV+ugw8u8JGdhCimLOLTj8zvgEQEIqh+kO?=
 =?us-ascii?Q?6kUp56+26wvuwpcKp/e8+xFJgE1/38XJhbMRFl95k1kupXk4WT7RXAnpK3in?=
 =?us-ascii?Q?QVIsxIKDqNpcx+coN1YAW4gZq7uE6aUwxRFIWPrgsnTi79THbEIlVv2/tPeh?=
 =?us-ascii?Q?UwCI89jK7n4SyH2dHdiIv1ZVJksVecSiHPPs21+RkC4qGEmufgnsFBFCddOB?=
 =?us-ascii?Q?37Md8LyYQh1QLoTZ95U83EmhzFzJrbY74ou9aHNjsytV7FpiDr9HW11O1/Ua?=
 =?us-ascii?Q?TdASYXr0fhnRRwBZoNu1N3WocKb10j4cRx8SkV34ymGrC7B8gEvh3qZXm8WG?=
 =?us-ascii?Q?iomt/7NKq54iOly3olbZ52G65DntCMnfTcyGoEc08Hd4laRieVq69i1LbO0E?=
 =?us-ascii?Q?4ixRyouN0RK86um31qbSzZCCGR+b7xHcJhHC5QEXOuyWRPvajMSn+LHxYPtu?=
 =?us-ascii?Q?8mSa1takZueKuhuKHod9/qdW3EjtimdNmUE2ayJ/0ng2F5qGzBWQ+cRLX6UM?=
 =?us-ascii?Q?KSiCH+7rX6S01JhY77ZWkmJ75ndQhdeGpWaKSjLtyV/RQMi8GM3EZgaeRG1o?=
 =?us-ascii?Q?6oCtjyfc+hixBy05iHgUaZE71BXZr1bE6nd2X8ocVS0/nUQ3FdLeP0/TzQdw?=
 =?us-ascii?Q?SXVyRKh/T/zaa7RHaizmgCMAhzUMlHk3m4M8famyKOmvRft7xB2fiy4pbnhR?=
 =?us-ascii?Q?vlW5u1RhdzPN2TKr736xYBrH0A736nkokf9XNyEFyB9m6eabMhDcDQBc7ocS?=
 =?us-ascii?Q?I77L9jXSQZ3MetCDKYKuzFpA8E0up7cvwPUUmrNDNKqUsy9tI1zmIynU9rp3?=
 =?us-ascii?Q?n7y5H5FY5h4of+QLPdsqOZJHDV3XcfTEn0204PKO8cHAwk8hk+EsoSWkKrNR?=
 =?us-ascii?Q?E1Cv37Lw0S6FKWeES/0TrRQ2epIFgvcd9cQ+4zN9t+DM2JThfeMXSTN5IOfo?=
 =?us-ascii?Q?2XmGRbyhS3DgH6LqiQfyUNRjGoTdTMW0acC4YQR6kibN82QmkAOQqdvear01?=
 =?us-ascii?Q?+UHScJ7r5ztnrwGtJhUW8jRbQevFpdufSfdDEvisNtNvTJW3P6UgRrsSWE6F?=
 =?us-ascii?Q?fgoL5U5bYGOa2+Pjj6qyNnIC0GM/Zediz+cFiljmpDQcKstQhJ0U55+etk+J?=
 =?us-ascii?Q?ZcvEo/XTFXt6L1gI2Mwu9ORtGEvteo5tsGGE8iRqYcSxrS1AwpEBe8rMLDkj?=
 =?us-ascii?Q?ngJaKWDIhhmgewxA3Ermef8f53U/A5fmyQaDzjhplRpJzB+6e6Cl7Ubwe7iR?=
 =?us-ascii?Q?naNqqxL0e4ft2HBahXItJJAK2aAAmKQio6DHrk4ZDC0rN32lUWQRqnTZxj9n?=
 =?us-ascii?Q?aucchczvkyfZbKI6q4yVAkJ4q5qwmz7Du12fb75AK0efDAF6OrcA2Fqzc+Qg?=
 =?us-ascii?Q?5R65H3aUNsTSfiKb5jY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e420db-3d3e-4d41-168b-08d9df5e5aad
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 17:24:19.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr4VQ8dJww962FJnJFgQ5IznWfeCOeZZB7fjfRccgx8Ner0Zk56N4WAR6UHAf7pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 01:37:21AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
> > Add a domain specific callback set, domain_ops, for vendor iommu driver
> > to provide domain specific operations. Move domain-specific callbacks
> > from iommu_ops to the domain_ops and hook them when a domain is allocated.
> 
> Ah, that's what I meant earlier.  Perfect!
> 
> Nit:  I don't think vendor is the right term here.

+1 please don't use the confusing 'vendor' in the kernel, if you feel
you want to write 'vendor' writing 'device driver' is usually a good
choice..

This whole series is nice, the few small notes aside, thanks for
making it!

Jason
