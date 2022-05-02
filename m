Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD55516FFC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385043AbiEBNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiEBNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:09:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CBE1209B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 06:05:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye0DIp67rxs/FL21ldASwNb8MneffTo4ChzkQ9jr4I3tuJYwDaCZjSMLB/m1/Km1AuNAP/hOaUlJLwFEl2P0WjAcnSC6hlXMMuO4BtQtHTE2d9fxjoWQq/Ugrl289MrmiGppZpdkeygeheAsYxlZIEXFaQ2C+g2heZ8xAfnYr2VsDwng30mMPwJ/edg6hA0peuXen53mtQGtRL9BWs+RWJtcT5eaW9+IWkejpLAmn+kj+3BAQMlGl4Yz0J/3Yin0PCCNzZ34838+k61vQIF/4dTy5DkmcYN/zpGTSur3WA5grsmvrDgH4pZ5zTfcDmRqruE/GwQlvKxs7yIC/ZZs8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SP70ppLd0cWGnz5b4fmTjjMalFNv8Z51PvIKOjdQN4c=;
 b=QyUBCzmsXfAmFNrxcg/ptY6aVO76Frw2h3zZcBhf5zFAn7myj7/iJVKloGJcIgTHjZsGEqrOCq6Beo28lKpaCaBL3ARjjmxC2pEPyMp7uyrBKWs2eq/8S3iul/H8Xj9blVVkqnZtRWZtx6FOAveqnqpqt1wlB4jwrLiIZ/4CjGb5LETwQxxTSHCSB69L0rjviz5cqTQ7gyVwVr9VR+WH5fStANkouzgR/kAMqA/fXwJPrIpjpghrrVehRajfoa2K3N4XyhP0LEFMM+zJTNg64YneQNOWqB1wbWwJhcr+/6xg/lLscyV6DBgyTGPKgjPZHiu9D3ZR2uYQovg/1GWsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SP70ppLd0cWGnz5b4fmTjjMalFNv8Z51PvIKOjdQN4c=;
 b=bRPeR0mwealb1NmboztUiPl6gabXim78Lm5g5cz/CiS09c3ys8m4E31rA1ikY/q7NGPhutRjnQIyId/sAuIzxUR4ijS7AKkZwRCwICPo/Yd9iGNnxS2UJJlAyPz1l9Df4mNTiXJ+Epg/1+Tlq4NU5P1d8aLSM6uEpAt+dtKzTswAvAPBX2mQ8hMfcpt5JNjLM7h0zgtyT/G97kcZqlYdjOxKwpbGLem3V/aTHwTY9A6GqucRG4de+sNThEAoQ77UAE5nTEwlI7Q52YNfghXQKekRtN05iJsG3AuvJvMCc7+DZ4dbTkhLbP/o0KTNliA+8vkvqZ/Erbwa5PjA+hlelQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Mon, 2 May
 2022 13:05:48 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 13:05:48 +0000
Date:   Mon, 2 May 2022 10:05:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Set SNP bit only in second-level page
 table entries
Message-ID: <20220502130546.GI8364@nvidia.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501112434.874236-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6af8e9ba-b09b-4f3a-e249-08da2c3c79d5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1469:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1469C5D33334EB526A9458E7C2C19@MWHPR12MB1469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KldXNTj2bTFV16XRVkACNfFf1MWZa/W4CCSQlYfcct0vU6bB18MYqEAmd0ionLRlTcU+VneDeCdkA4RGRg2Fy4M6WNBo3/AuR3s7jp3r/n9YX6I+S5FpNJuXFWSXEpgKNb+yZGPScNDyOP+m0RsefRNM/Ww3xb/uvlpBcOhK6Jni+GRrsds+VkO2GvcBPgkAri2nkkE1+hSkvZC/Q2+3iif1Ut2cyj7mnXE0GpKfLesKBEV6B6hNFtmedpuo06gkUyxxl0GhFz3OvwYwSo66IWKt7uJ51qe9TPrGDhyS9CHGlYI/OdMcpWAdh422YEMe615Eo2QeHX1mEhuloe9Qlb6yoI9KUNEdTmIJMR6LhfEQ6APJextdqe65J5J2MerDiP34XD3b1JNAt9iacRgD7CZ4UHfLM4VdRpvHsD4b6UHwlptmxhDn5RhbfrZoFr2igtkIiVO52BClMWclJLrI0jOImGp1gDs5RG+X06Ywd06Gb5ZKgLWnj6go8bC0E/Su7sOe6Ovc18GT+12NgfAzl+mMlGNweXLKWX2x+Olu5XUhOv2Bh4y3LwH7IFDtwOC+VaMwav/RFMOn8+NFROOEjOeYlNDJpq6tRXFK2nZ0qQFuCu9vlVMLQbJvGfsQmGMVmOZH2zhPhpglcF2iEjtdgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6506007)(6512007)(38100700002)(5660300002)(316002)(86362001)(186003)(4744005)(2616005)(8936002)(1076003)(36756003)(4326008)(33656002)(8676002)(6916009)(66556008)(54906003)(2906002)(508600001)(66946007)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rbKCvoGR7W597EJcL6O0YPuXJd/fxHVnZKjMXJmazjOgsYfNpanD/t3zfcmD?=
 =?us-ascii?Q?x8veDuSYvJzL/AucQa5nHamix2OFe5Hi/0TUNwWrG7EBzzVTnFRmD9GwOVxg?=
 =?us-ascii?Q?QdwSkWKGBHkfQg2bfooxv6iqh/Uzw9ZLIM8FobkYXEgdGLvFDeQNgbH0VoL4?=
 =?us-ascii?Q?1KLxK9jpLipVVjyTfDTQj5vJqY4HNxT1N9Ynw3dEXVFjKqbIfdNiQziDP2zU?=
 =?us-ascii?Q?ueG+ufP4u3/cRXy24RG7m0379Q4es98LQoYu1UKGuvcRfF8iqTT7wLTNJENk?=
 =?us-ascii?Q?1fMDzUnuRmscaBl0PKVX5Cl98Q9vOkwbMQ3IX9ACOMw8yuvoazEISFIda44Q?=
 =?us-ascii?Q?AA0JuehB+epeLnId9TWXJi+CAZYA2BEiGIZfC/pq+iCnnpUdyZl0kUE3fZEr?=
 =?us-ascii?Q?jt1PAwTmnyvRTuZY/TKEAj7C0HY2tIa8GOwoSzlpOxQAQu9Tfv6niK31yaOv?=
 =?us-ascii?Q?sGHOh0WH+wlzQIXImdPgEWD6G8FoJrk9fr9QCEsRGkYT/YOrjI3XGbnxySvM?=
 =?us-ascii?Q?Q6ezWWH9NCQoAasTFSuJM1+RnWZc68W6Nf8w7xMicp6TSSkjIJklqvBJQDMa?=
 =?us-ascii?Q?MlbBe79GqbbazeMRVgvSI9QyUHM+Oi9tkZc4Qhe0ajv4Qf1rdV5SKwj+yE6g?=
 =?us-ascii?Q?N6FG/8JJrCujGVNuSKHMqZp5PFHah9kfJq27Awde+HkHBzo0P8JI6NMG/enV?=
 =?us-ascii?Q?mAVivSuAyvMhTU/qcn5obhPZLybkMdX71tM8/42yHSwsZa2lYY5CcaLzv4gw?=
 =?us-ascii?Q?4UhVsuVsECwmA4Je1TPI4lexX6KTR2bJI97rKM14W1Rvs3tOYBpt78UfIgDq?=
 =?us-ascii?Q?bfze0HmswdGoFaiCqKOKDf0COCNU9ZxjAkUvxSqt9DlFORiv6US7+dwqf5dQ?=
 =?us-ascii?Q?fofKFgXTLP97N/kkgjBfFdZ+UQcv30qso3hJZj0Z6V/3QaySeVM6ex8dvZwj?=
 =?us-ascii?Q?whS0tL+3dcIfmlb6xorlIz4Xq9uandNvwEHWFmbrtdr1nNom9wpMIT7goZpD?=
 =?us-ascii?Q?vAexHHtmUyKKeFf+h1gbLzGHPDU1FKwfgFGbYt2kAE1hPVLgZv6g1KTEGa9m?=
 =?us-ascii?Q?MF4jJHOQH57OzZ/b0i1cWbvvo5sEEkJmTdHVMlt3Q6oQ1AQh2UIa65pP+pLw?=
 =?us-ascii?Q?stX1tLA1Q+ydqX4a1wbifQOL57Ke7uwZB2ypA6qePufW1gYmsizOqT4l14fz?=
 =?us-ascii?Q?G0eTRQmW5HSHTgxY1vBZDxqW3XBKYvXERGiEOzwGiuA0xpnqBvVmpg2s2NWq?=
 =?us-ascii?Q?Td4+p8mm/E6T8uuD20TSk68t/pFRwAUQU6WTlZwn2YaH+l2REi1vEyfjWHvm?=
 =?us-ascii?Q?WawE+MGz1cEUe9WdHJBRC8G9WpabAhFcd5R13WBpdcs/jbbJN+d62+LpPTDM?=
 =?us-ascii?Q?4tD3TeqAEaotLqDWeUkZC6XTFxlDLDDAUdXXE3vlGYzWAFnnUz/Gn9OwOvzi?=
 =?us-ascii?Q?s4ZmjAfAtI5gRrI9kVzy3SpIQB67KQjmlhT37idge78I4JASXtk6kWQKriFd?=
 =?us-ascii?Q?Goc08bifQDOAMPsHbvcyVOyomDCK+4fNoHTNa/exCmVvBL768lnNKtIOOd50?=
 =?us-ascii?Q?sBa80WILV8MQiMseTDfKpYgKV12Ho/Ev9kSeeVMUFzbo7ipNyqtbu6Qa2TAR?=
 =?us-ascii?Q?WQc+EFcdS5vYbXNwhpmuEBClF7HlM6GUt+q2YeOddnUp7dJU04YIOQ5QZjmK?=
 =?us-ascii?Q?yrcYBhJwNPN6WDTfY0eXEbwhDhyIo7WONxdhWI93u/tUYX/5oJLt/CGiGG+t?=
 =?us-ascii?Q?bGQVfOrrTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af8e9ba-b09b-4f3a-e249-08da2c3c79d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 13:05:48.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxqLuN/74RQIWYBPkIPOan7ISJD3bLDR3ET/1OCgpD+KsU72jmEZkxQdqhwF6L1I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 07:24:31PM +0800, Lu Baolu wrote:
> The SNP bit is only valid for second-level PTEs. Setting this bit in the
> first-level PTEs has no functional impact because the Intel IOMMU always
> ignores the same bit in first-level PTEs. Anyway, let's check the page
> table type before setting SNP bit in PTEs to make the code more readable.

Shouldn't this be tested before setting force_snooping and not during
every map?

Jason
