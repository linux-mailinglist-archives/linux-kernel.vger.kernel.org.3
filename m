Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30BD4C2CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiBXNFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiBXNFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:05:49 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E262102
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CcDTrpVKELXghdNbDShDU5S3CGnouI4opFLk8YlZmexEDDtfD9VP4BKHBMYp/QPt4GfUSAU7cfeK+U4Fa/VqJ9TB0d2kzxM1SGvT+B4iQmBc7Mk72YxluvIA5w9z3D+erln36cGiNdHC1Vzv6iWvGS7zQcCYDbzCCBy2T2mFFeznBav2g2Ytohnh0PB01dd5dvjrb/IarvgKwD7NWnt15dntFWBT+WCcNq4fsTcEQrM2mqb9/R2KFPcu3nApj3v69KJZE7f9KV3rW/SFZuy5vxiIrDpqXcAnPZhy9YBYV7KFKhIzpBZt96Ee7qV7QJni0czEFqnMm9Fk1YuaklRbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63+k1QgUh5i23gSMnsTc+A/HiO10AS82zKtXonD/yro=;
 b=bcoXwEQ/11brKh4dlXsV0H99u6k7eivPsw7/HIgCRAQ7V+u+OAXuMsSJY5jCdbyoDNAwyrwJR3jHKf1CbqOArS9Orp+OAcrO0OKBCeNU81jGksH9AeIaz+4CV2k8djMEuVBJqM4n2xyjAMwpd0kMZtfbi60SLVrjSfdRu2nQKF9eJ5qhDzxOx+u7LlCnfQx6nCUc6+WHoeuX3s3g+nxq2VdUytBzy5GzZclwJlKzXgc6Izk/3PXcIeL/hr5dSoR0IKNkr3LY3X1osQcFul6zns9On9iyYuSn1su2dBgkAXdDZ3a0yYgpDJUWgTW/6PjOl0cYpe2LJiXnv5L2a2wFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63+k1QgUh5i23gSMnsTc+A/HiO10AS82zKtXonD/yro=;
 b=bG/yrAQlGd+cofoJp5PU+gF2haGdEajOFq52bo4VGaYJJsRG3ZS1UcJ4c1x4dmcE3f4yQC77iyvx7KpeFvF4Rq1i0ety2KGZ7++XEGMAQgffcJqgfozhGpp+H7esp0uns2XbCvAALs0+6R1A8Ph/cc3k8P93kLvWXQkT8IeN4auQSLcCOGjoU0jkalKxApkkmPSYjZgjjJRXy4M74/leD+7rBMRPAusyoHv7rwi+NDjZPfWop2/kBJEyoP2sx7YjDp6E8eHxMn3x0hZI4eFUlAqZQsQXn0wECPA81va3B8JVXC25y4BDHIE51SwiMWgNEdK4FzsuODwvLXGSQY+Smg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by DM5PR12MB1546.namprd12.prod.outlook.com (2603:10b6:4:8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 13:05:17 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::287d:b5f6:ed76:64ba%3]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 13:05:17 +0000
Date:   Thu, 24 Feb 2022 09:05:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] iommu/vt-d: Remove unnecessary prototypes
Message-ID: <20220224130516.GJ6413@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214025704.3184654-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0024.namprd02.prod.outlook.com
 (2603:10b6:207:3c::37) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f105d69-e45b-4d12-ed54-08d9f7964e09
X-MS-TrafficTypeDiagnostic: DM5PR12MB1546:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1546FD6FBADBD3F15BC2D3DEC23D9@DM5PR12MB1546.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d5o1cNoa0xNGXIKvX5Qtq3PVyvPDdceOANdwJGQ6TRTnzEvb8ySyHwmFLsoM9nsu1XKzs7yLryeEe4zfBlbDgbR3VXn6UGQ9Bqo/nEStgJdWmlXf0WFjwQn2goGeFCIIBjzlqVVQaDaHE3R8VX8e/hbxgY4N4Xyuwa4tMavTdNScNj7OcI0b116jWZC52h46BN/M6j3+eB4Jps6QGHP8a6JAcv64AQ+SSQ0bvsiHOvuuyCHRBSZJHyDqbQWsA/J2Fo7JxUY+E91UO6xhz3EtcLo1Jul4yV0cBw1jfWi//2mWJnJ0i/uYKMtZCvaOh1SoDOv+eDL9+0pwQ3HAN7puTkzYgh+KNiW6fxuwirhrZbS7DPcnR0mKwMtDL1sBmA5ovOfWanVgtgsSWIqxU5g7O8Kj2NP2Uc6H4i8x90+1gUJzlP2y7NznjOcUXGjCrkOp6OdIpRjzd2j3WmFI13sYmW/+lEXwu9pI+7xaRdl+tMqBezxgPtvJ4wzQIcF1IjutRncK8ufVA5mGwxwTBUQqww22u3xJfVioPW3iNMFXYICKeuq2EMeZ4fAPgMIfDCjuFcakEXcl6WGUUI+zitoEcM2fC7gaLSBJUeZt/7RX6XOSg92tNf1Xivorho/YHNxwE6wG1DrUddBjown2qlXlcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(66946007)(2616005)(66556008)(186003)(26005)(66476007)(8676002)(6512007)(6916009)(6486002)(54906003)(1076003)(86362001)(508600001)(316002)(38100700002)(83380400001)(4326008)(5660300002)(36756003)(33656002)(8936002)(2906002)(4744005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X7eg0cfTwBh6MRDtzlnZiTObRQVtJyBwdtTeQaix/dhB/weG/vMYBr4EAXXy?=
 =?us-ascii?Q?hU5OfJ8DcVlPrnrHM3OnmMBu/tC+BFK6UVy6eBJWrs2SOHYAECmr2wbEHjud?=
 =?us-ascii?Q?HM/51e6vIo6TLDfsjEOznUp2QuUn4xXBT0oT20YxYk71mmwQXdROpJKOSo81?=
 =?us-ascii?Q?oLTJYc58UBkHS6Gj27rydvkt6simST/pCu5irX0Ye5vnG8w7xuh2E7SOHDVL?=
 =?us-ascii?Q?InHvibeyBIkNLicuk8acfFqB/psikMU45ifAc8e6u7rs8Q+IAuC6InSjJL7e?=
 =?us-ascii?Q?S/MYwJbcmGiM4e5UnPftl1TtW8VcYw4gpWb0AMWeYjG6vgJvwn61EOPcCtH+?=
 =?us-ascii?Q?AlAlSx9MHoD9HiXAdbG+kIWQ8+6wOGnzr8ktqrY1bs55uvGsW2aXFQKLyqf+?=
 =?us-ascii?Q?xV/Q1AudLGtxVvqu5XV8R5xhdNqKZ8H+CszDLt8HIBIIle0H5EJ0H6UJ9ukZ?=
 =?us-ascii?Q?JMqqjiQDFgkBlTJMbK2wY4HmI5a5rxqv/o4b+bmcunzh0rM4e+FqUNQDyKcN?=
 =?us-ascii?Q?PBs99C1DmrcJU2uWYUSoMt0KgzM/69E9yfzbTJc2BUSME9npVYKU4zTLMS1H?=
 =?us-ascii?Q?9OLPr0ONfIFDNFruOlfIjfCExYA6gleWvya9V7stULKi+hp2Zva8dUgqrmm+?=
 =?us-ascii?Q?UpoKEmgoo7Vlxew6yzI15Dgc8iJ6IucQDUTPriE9fJQbVDKxU0nGOJSHdHFk?=
 =?us-ascii?Q?KiksUJRLzFnhWgY2ErWEAk97f6YMfxZC6ykBwyBp8cG8R6WXhL71/uvZ0FYd?=
 =?us-ascii?Q?P9MIPeoTxSx0OAXzhPS9N41w0wFLaQ/b++FZVVSlnTwjRJCxHFviYaM9kYOh?=
 =?us-ascii?Q?4uBfhOxrRKTThkzuhieN1twugxBY1gQrFkcUuj6bieaxoDO/yYKnbQMYLjO1?=
 =?us-ascii?Q?IMwVfXwlw4ghIiv8LfsaYkhwfjtkjvD59SYBtr6fyJ1hDBfQwB0JkY2N0uF1?=
 =?us-ascii?Q?zTWaKEKisyRf3MgVU4e8kydx3m3mcKirWtpL+3os2GsZlunO+PuryfgYghSv?=
 =?us-ascii?Q?iGWe9m4y/ewMEcBPmDs8KMsifFHwTd2duqKx15du+e037NE1FBm8Hii5fwXx?=
 =?us-ascii?Q?wZIRnBTjch+Gv/FRENM/ZxPLhIFtRycFg+6sav8qO6zI9t8lpEw/BIxRJ2ci?=
 =?us-ascii?Q?N0YLVWK/DMfc5YT84ApGifkO/R/RPSTvPu6O87DWZjC0ERxa+tcLmwE73Pi5?=
 =?us-ascii?Q?nWCopZRwIEKipeuI9eiDdL42vSFP50BQPBBinfAs4tJk05Ha8m3VvE5fwrIB?=
 =?us-ascii?Q?l3C+JiFseNytGrtygDZEdcmd7c1mcJOINAxp37bJ0QN6lMi23OSBy9B9mY0x?=
 =?us-ascii?Q?WaH2ey8I4XPv9TybfScuJCZRYXhKR+z5uB2Z00tGiBk9pLyxPZs31My5pOM/?=
 =?us-ascii?Q?pon2xMozGYCjlN38BvX9I9Ztq+zdx8DMMFytnC9RM82Z4JuDS4SJjQJgivmN?=
 =?us-ascii?Q?N9I+Dc9ns61/y5VqCOKn+MXhiYbdJCi9Oku1XU7gyXuhkpkNYngh096ktlee?=
 =?us-ascii?Q?18N/RO5IEnEJkMdEBt/HFgTuJaMEvjSzP27sgoB/9uorPHU0ABqH8K2JZMKo?=
 =?us-ascii?Q?9aCbhmWfmjwTJO31xuc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f105d69-e45b-4d12-ed54-08d9f7964e09
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 13:05:17.7001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FL7GAqO6oUVWp921GaBmVjXZiZLPATA361MDZrKYC4G9FYWkjD/64VhT9oyFu8jF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:57:00AM +0800, Lu Baolu wrote:
> Some prototypes in iommu.c are unnecessary. Delete them.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
