Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A344E25D8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346180AbiCUL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345937AbiCUL7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:59:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C71D0EB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+xqZjtUD2Hkayh3vuAwynzn/bViPYzk88c3n9K6LFPAP+GpGXe6mE0PkRlpXBRlpt7KzGbWfidoi0aGdZDqulIrckvt87c7+4jukGT3jfi60Kj0z34KJFuA2QIy1CkYebF0Gbpj6Tawbh/XxOumaDQodGiuj4bZ4gb4Y38ouQZI9mYCInpuup3vldc7GmPOedXTtmSO2uPhacIcN12tBAua0GFpzR1hMuEEsBQIewTRVBWF3YtCxRaONG0oro7AGrShLf/zbU3ERXVhrSgJ/u0Nqmi277pJi+Ghsohsbxi9pTTJWnVgnlOKWMiVPC7t65rj1kux5Di9Bhjvt6z4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8T7dQq3Ggb4C9I7wBC6scbBeEdjKR1CveuNsmXlcyM=;
 b=jN/2CWDFtAi6+0OdZ1eyaaZJHBhJtOWHHoBnH+va37yNBPLlcfcojcyfa3f6WSFKp6LTfRQP9EB2XNncGgl0d1RXOZbFEEGzvok1v2sDRegB2GvK7R06uI6RtuRSGRo+yWLqfb0hy60hgQh0DArii77wi0dSiaLtRrAlBWcQTGrNJr5pP/bS4FxiSOLR+AZDtNJOY9Uyjuh+Y1iuxKbkjqJc4aB8q9SGkLkfvC2CWyN4cX1M63Yo4MHz8tAIi0/eRL96gCznltakPhz1Vyl9pknIPQllcNcr4Qad9eLyuJ9O0CNy+kgG1E3gE2A3eAfCewpGuPPs2DYsVXM/vWda7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8T7dQq3Ggb4C9I7wBC6scbBeEdjKR1CveuNsmXlcyM=;
 b=cB6ez0dFdnK61Xx7gCHYEdKd2iHN9rkMKq9Fpo7GU+x+WHHz/TYKGI5HBKXobjPzKv5sfFjc70wY6+HWs5TMrLONALV1r8tkfP9uWbqOJbhr3TtK+0H/oYwNFdorv+46yBpNd9g83X2XCd+ip1kG8NsbctYBpRKjhc5kssogG/sNn8OE1TU9E/JXf9t1E4+KT9xmmkhP2f2OHDrQ6LbpzCWs2t9DNvdeU2BRMbeQd2wZ+YRuoQGRgbsU+fhMiOHL1yYwIf1qAMqvZO3TqU9Rd0dnwrTDvREt6uU6NK14GpHIt0TPc5Zvc+zjXoJO0tomKdH1QGs4GNWbo2k2DLN6rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB2933.namprd12.prod.outlook.com (2603:10b6:a03:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 11:58:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 11:58:22 +0000
Date:   Mon, 21 Mar 2022 08:58:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 05/11] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <20220321115821.GL11336@nvidia.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-6-baolu.lu@linux.intel.com>
 <YjhiByacn+WACHCU@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjhiByacn+WACHCU@myrica>
X-ClientProxiedBy: MN2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:208:23a::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91430131-0432-493f-510c-08da0b321912
X-MS-TrafficTypeDiagnostic: BYAPR12MB2933:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB293335F0812C4C4664D3DEBDC2169@BYAPR12MB2933.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2geR5muLbI8KjltTDpoPA5ao21ek2p34Zay9Y5gROeRcpJJoK2ieX3fOV3Ry3HrcFGTs0bdss8suLmB3cDQOhJt6qPcyrd04UZi33N9ikFWFJ6ypDm7FhwHgkSkCjJKg5oN1bstU20Tsvc7RHyNwjZ4SHJzdcxXaZWrxtAcQxTado1AiV+cGwlmc5daMd0EVl49GTA3u6LeJRgrPHHE30757pfcfdiCLN8hnfROhmmTqDsZYCNPr1qMPUiWQ34+e1+o0gJJxjIVIi5fMY2+u4AaegqIFyImN4VauQDkkycolYA5cIJk1pr5LW9TWr5yZa8Fq6m1STy1o/f+n9rJNlSH0dK4oszm/Lbsg/8+mCxAzeGNkCBKJTdM8OiGL7fJ8jqiqEa1DAJNtSgCMH4tkY8HjEMD7hIFMHvLwzVBTEKGpSg3epqHcgKIcGcOsyJsq4fghYsGGN7PLmsw31jXYHDzAKTAkJiBy/IccdJRivxNY8b2x3J6u9TCrkxYLL7Zwv7rORBgGBFHqHAe2vMNUk3WeeQ0K6au1qF8NaoJwIyO2nW6lhIKOk+iBpi+TRvnwOzNkWEYBenySiWUVCxWSaGslWhozEot400FHjoI+3hbsb678HfaqomYIif4NNs9Zuhv6N9bOEkJriQ172qJbPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6512007)(1076003)(2616005)(26005)(6486002)(36756003)(2906002)(33656002)(4744005)(86362001)(4326008)(316002)(38100700002)(8676002)(66556008)(66946007)(66476007)(8936002)(7416002)(5660300002)(6916009)(54906003)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzV/sFE8tvnGnp+c4IGYkgyWEtiSg2A4FwkqODN9zTbtvuJdnKiAigKGx2k8?=
 =?us-ascii?Q?DP7P/qTqrcIzWZrc9pgg8OB8PTY5oSAxzLv468UGsBV9leDdhZMxbwmWEVYP?=
 =?us-ascii?Q?3gYyQEi4A1EupLWITE3NcepJQsLj1t43gSmP22r/1qaHpqPx0mlDzN69TIRC?=
 =?us-ascii?Q?JEumT8IXTUcM6Mp4DvNvwIL3SUBihfLlY8FYk4VjgiwIqcvpT0bcFMLZPxWY?=
 =?us-ascii?Q?zzQn9A8jBMjUBYxvWPU4J99Tymr4+32HwqQNRKFI6f3REXAo+76NGhr0/+dZ?=
 =?us-ascii?Q?ZDXS4rEmvvOZY7T58PSNHJSiJiL8dJnq4YfQK53uvbhVfBXIsU5sZYLdoys+?=
 =?us-ascii?Q?j/u/SnxL7oXRD6JPxoRLxK8VtbXl3Vy7fmc/GYwg6KF48wlZpBlLIScmPRW9?=
 =?us-ascii?Q?qwqfUM4zkDi0R8JemLUbpy+OnMJZmjeMlrSlPAUxlfp9ivEqkpdcKLK8VKbj?=
 =?us-ascii?Q?vo4r7NsmbZJcOudKz80g6W/zX0YwbfNlYeLrLoyImqIR+1MmTH3XQI8ZBx2X?=
 =?us-ascii?Q?CH+EKHoxIhvdh+PPYOh1LPINJmhnZcjeDSMONS5SYk0A+gh8KpPKx0Dy2mHT?=
 =?us-ascii?Q?HYwmohY0Idfwph5USG5ZY3S5Vp3D49flHPUlnz24S3YLpfG33eVNIwpFMOKV?=
 =?us-ascii?Q?CJ88Nld+APWzmcMUG0X2NRgh2vDFEIXSoscoYy2DKRKY0r7wOJzkdCmaz+qZ?=
 =?us-ascii?Q?l9Bkpj9N4S39hvYitWhDH6acAdv5RNuyOBi1mgH0WqYsSS7ULERjHo/+9hrP?=
 =?us-ascii?Q?6MeV2+kRBvUKG335NY2XCA7AO1S1plc06cAeJwoE5Gt89TWXAh4akpVFVOVO?=
 =?us-ascii?Q?+MiOoh92TgDmeocX6V2lnhO0ZVWQ7f+Fj2RHCOvOeQFShweomvSS0qDFMI87?=
 =?us-ascii?Q?DAHFv59bS3uDX4Se0GNPQfF34V7eJIqw6qHfw5UfYnV2XJIWMC7TwzEUYj0J?=
 =?us-ascii?Q?UbXrcqsZltmYBQvHUZrLQbwoBja8/vnl9s3f63OTm2k0bx1y2wdK3617nOH5?=
 =?us-ascii?Q?02zemlXwJodmpHmL8YwzhSRghwV3OchMACvWR3+wzcKeiizUc0ZHwC7tn+dy?=
 =?us-ascii?Q?4wCYUZEM9/vvuMDfjrhTcoMGr617BdjFPKBE1+ETTGONZxYJyeSttATLtAdt?=
 =?us-ascii?Q?iOJpF83QlR+WowMIushg1u4+F1YtOFWgqj0Djkr4S7J17gZUwnBaj/f4JYX4?=
 =?us-ascii?Q?sv1RijeUVNUrcwNMv8IgyO+rOgxgLmBGXgLscb5F5OxLGr/+r7ks0mSloSs/?=
 =?us-ascii?Q?SVRALXLNL2yA9jccpePTJRbgb/qX0nm+eBGSzqvtcgUqTFw6IAcLLfVFjXCJ?=
 =?us-ascii?Q?oYjlE5UmJtIgbtdMQy807MA+X2iutVYjEai48/KvleFH9WNoN58vqColFfoV?=
 =?us-ascii?Q?N8sYQ8fe1rCXbsHuIrCelonUaQopCoJoCsiJjND2y5vxYhDI9Wi1Agn+1X0W?=
 =?us-ascii?Q?UqpWwVTnuNUyJhiXseTWbjgBSxxmZ6nc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91430131-0432-493f-510c-08da0b321912
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 11:58:22.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwYqXY3IctYLUt0RpxRXq2XxzpkzEVwMm18VlZPSvi0rHV6jbAAikdY1nDZqQIm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2933
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 11:31:19AM +0000, Jean-Philippe Brucker wrote:
> For now we could just return a naked struct iommu_domain. Sanity checks in
> arm_smmu_attach_dev() would be good too, a SVA domain can't be attached as
> a parent domain.

Now that we have per-domain ops the 'standard' arm_smmu_attach_dev()
cannot be called on a SVA iommu_domain already.

Jason
