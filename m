Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7E4AF2CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiBINby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiBINbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:31:39 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B6AC05CB9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:31:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnlVZJJOZT6Bet2odDMVTPPtRpAeCkkpcrzD4y8ILVc8r9gU9YLzhKwxYlWuQQ+E1oFKfe2C35j/iSeF4fseODHsBg3seADBnrVDvxHHpvcU0HzxKnSHfnKghLGW5BqA8pfuWpHRlhEXHQPnWqQ8SFikiXPyFRVm/FG5+1B+d4RjpECrchFIbFCyuhIxpIGnsovoPVF0F4OJBoO+cyEgUjxbZJHsvMomcGwVZ4RInk8hUpngKVb5ZBZTzDpKF0DlTwjL5/27AoznTMs6RF6sHk4D7Ba/tqcF21uTU0OMPy3xDzwtXXkW9aWcdwepr/1JdpTp5NUf2TBcdSPBuXi1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa/imPM8fMvmv1LnEaCon4kqdE1vvxt1h4rKMidx8Mw=;
 b=QDvotUJEdp430rrkA9jkU21o2Ic/1X1wTbqPzF1fZI4O7K53iJendAymgXME9XpMHTrMKXWjlPNRyNKn7UaTn4Aqc0qG6Y6yoGBx32j8GuBzL2BMGVzKHiUc/yjyQ0SF+osrt8s1xmt4fYsYa8ALfvcS8ypmoUghCi6iW1g2Ihm9OlTYLVaB54WlHYNSF0exR3NYO0JJpBHALa03NCH8rjkY8WLy6m/9kvWyY/nha7FCsiCwULZr1vzpnYdVAGtBseo8q8RDHToDcEhy1g9o9K8yP0mdp+FrO5s4Nl1DUvmFbZCNuxif7IM/zYiJ0VgHWujkZ2YA/Xq0F0Pwym2JSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa/imPM8fMvmv1LnEaCon4kqdE1vvxt1h4rKMidx8Mw=;
 b=RzNz301/9zriYmt6gEYbPKdqUvvojM9FmFxn8BhJRwE6erZbzsBvXs07wseJH/naHAe5WSJh9+7L1CunkiX/Mf/tFe9JDxYIjft0uUVzL4FoxcdYkVEf9Jb8qQOgGO6+r+ZWqFS5WujhX2Zxiucl1GGcoM2mL1fS+xHqV1XcfCouhvaWs6I3yftulb3AWJVp+ZR8zsqK48HxEC+uCYqS9ogSKoz6MlOze+x8heWA9QebchphpJvR8uFWAlb9stwT28HaivKRrLTSuJW2ulW0S2iKLF7TicdgX/2k98gK+ibu0wdxB/Lo3HU+NZBqo75WQHIIEOz+eXrsyWh5drtkpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3551.namprd12.prod.outlook.com (2603:10b6:208:104::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 13:31:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:31:40 +0000
Date:   Wed, 9 Feb 2022 09:31:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 06/10] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
Message-ID: <20220209133139.GX4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-7-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:208:32d::30) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 103b175d-f04e-42a8-a220-08d9ebd0811c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3551:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3551E09D8DFB7435E88F3586C22E9@MN2PR12MB3551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zn2MD5MMfVOLmTC7SwB1yJwg/0or1ly5XmjYRet3jkXvyeClbZhPmhl202vks65sGFQ8Kx/dSZO3hIlh+uphPVEGldzEw7fgXoe0Ht6ux6zGBPX+x5/Kev4r0Iwy3/abJep31n95U74jkogI5k+JHAB++CDNnoN5blQ4IXzu1tahiRYQiDEGNsqw1aFf7kbVM4A1U07K61ZC/YLCWG6sFj65/iDHp7HSpw0CfURc2zvAzEzt1t6VXetwhI3ARtHaJdJfhessnMPDh7KGEwwBZxMNIxrSIejZ5ueuWzQLJx/n/6+gq4KNrzBEMFRd/pnJuWfS8ACAjECB3fAJ5YFCAqECr19TWsPOUcQgvMi570q7tstTmRJLj3fIF6hYeuFcay6VD+7b61EDi6Pg4ILn0W2tIRqMfZAGalq2LTYQZbdLeOqAzo9Kg3DqKw6/pIddTlakoeuK4q7xtR4qQTG7zFdZzDsnsMT1snJlGCckO1//AVPW95JhVaq4BDDbM8WfFcquSYjAyUUYzAlHp3ivZZVBG8ulcqEGE8t2pm/jNEvdOx/0OKhxY46ANj5T48VWLqvEHRQmnDb0r4h9JnKyVr2DEcJkDyLjENrZyXstCfLURfxjKE8qGTXuMh9ZtZ+s2SE8mYvpU3FQT3E6hhx8FYI4VA4nhegNMG9Hb6YzQGfrw4XKUvyWxCPmqdSX5WnaHOcVQFGEXG7aq2063T6QxgavP6PyOM9EiLQuGR3WUZM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(2906002)(86362001)(7416002)(66476007)(4744005)(2616005)(38100700002)(186003)(26005)(5660300002)(1076003)(36756003)(54906003)(66946007)(33656002)(8936002)(6486002)(316002)(66556008)(83380400001)(4326008)(8676002)(508600001)(966005)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gu8LgJry/E7UmqSEmNQ4VwI5Giz9z1PgPJJkh2MOfJFax5z7E6R/rkdbOKBT?=
 =?us-ascii?Q?/nXpBoIjiDWwmPkNrJHg+PdBdnEgj0NL2W90OZborsQ/IutXmf0Axdasyj83?=
 =?us-ascii?Q?1Yn+huCir6SIG+nt/FGMWqa66/eMbQesOyY/11ZFd0X5fiiB0vDgPltj1HKl?=
 =?us-ascii?Q?J8/D6RXe6hut1vNsmnXHCSjSB7ohuCcI+r8uOmaMO71iU5NVoYDXNBJYPd4v?=
 =?us-ascii?Q?rZbrTOy8AJ6kNsKtpkkYjdvmi2XU+HTsHDerwlC5IrgrqnddfIqyw2/wtq6z?=
 =?us-ascii?Q?O5ylOcTas0CtcmDyFtAAGwaoblsVQgoas7nlGHuOxVQZn8zKKEYuIK4pwV++?=
 =?us-ascii?Q?ZAgBkX6qErvQTOLRuOPsvdFMFZwVbRIZpPGWJwOchItfrULhm5qyPzKRSt6W?=
 =?us-ascii?Q?hT57hOAW8jB4BS0vUXkjXkbRYHCpgRmuqTyC/VKkKbcxlnLANFV+qT3pLNaH?=
 =?us-ascii?Q?iTSBrZPyXDZ43Y67uX4sj8qALtDOGB3jwVLsihdaqRHd3csKghWFLqO4QcaI?=
 =?us-ascii?Q?SsRz/Z8uSdr+wKL1tOu7dJBX/2cEUht4cGxFiT4E+gDc+o8Wa5nXnnUnXPtq?=
 =?us-ascii?Q?G4uT9T9kB21lfhfZ0GzZWCRTIJadgGiJBPZauQEcH+VYu/4/a38Cp4WZ2XbX?=
 =?us-ascii?Q?SZCCg2R5Zq4NAiaWXNUWZuxf26C4f9CVAmdsvTWRAQVDYK7jkxg2v1fSWhQi?=
 =?us-ascii?Q?vqN1MChX91zMsET3nvBQH3XtSlJqFvbridxQW62dAXNRoLgBnF8+YQhhwq8j?=
 =?us-ascii?Q?aPcQDA7zCmHNmmGkIoxh2vQOtwtVPd0Gb0xnY2etRLkDag5lJWPeseB7A7hR?=
 =?us-ascii?Q?Oo2oEHiAPda+jbtoi4HEih7bzoHzKa4WyhNOPDVpHwZz2qjqBoWpylj2Z1Ef?=
 =?us-ascii?Q?GwCuHrzbgZL6Ny1o5grGplusZbYPi6tDSp41e9zpXEySGowenDuNVFBVOpej?=
 =?us-ascii?Q?642u8/03QkxbSYLojAWzJ1TFpqEnYBXx8CT5mu77ny2bHMWg9ALo/7nQadR7?=
 =?us-ascii?Q?mVEWHT/mM1NxpD+aDI51XtlRMTbKQr8G4YvI14LnFfcokyRmPyvAsqz1wbST?=
 =?us-ascii?Q?mLQhiNkQFbrgijPZCuuG/rMhsXc7QyzbBDoGi6hD/mlVR7YWICdpx5N1gjY2?=
 =?us-ascii?Q?EKpba6lh81Bh00BTTuiddNIV3xYDoihABnDWTHC5xxH4cabxxF9Rj/TkBRhf?=
 =?us-ascii?Q?N/AVlbaEAkZk1Qy3/7C46S5ed28mONSoagmuduJrfok8RJHz4IDb1yW4QyOC?=
 =?us-ascii?Q?5uldwQGUi6txZLs4lKuy7LlhG2pq2WHZFqwrqFwH+kOtc9/5ayccHof8SH5t?=
 =?us-ascii?Q?dhKW0jTcc5hYLT3nV9reeTo2txMdAjx5Cxh+fvDgXav2FkZ1XaccbpIvLbKJ?=
 =?us-ascii?Q?xztOP1h3HZHT6r2T8XSrnitHwnj34NFRlntFzXCmUnd3noedxZFx96gb9jK1?=
 =?us-ascii?Q?Pa2HOXC8NN5YncCMP/Fw3RvYoP6aCGqjMnhDuLSTUsewmE2MXRuysNlSXHHc?=
 =?us-ascii?Q?w+mAY9U3r/tqNa4dkjPjufFpH5W7dawoj6Wjhf73aM8Uh2cYg3RKGCuqWMbC?=
 =?us-ascii?Q?ts0vn1WApC9rC1J8o6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103b175d-f04e-42a8-a220-08d9ebd0811c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:31:40.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXYtBndoneNwAeRYQ5cd27R+Xa84AHeSNp1ZrszEc3b6hD4zLefMQp3B5UyfeI5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3551
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:55AM +0800, Lu Baolu wrote:
> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
> field. Retrieve the value from the right place.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

IMHO it is weird that the ops have a pgsize_bitmap at all.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
