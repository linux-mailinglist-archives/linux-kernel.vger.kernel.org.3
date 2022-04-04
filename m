Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BB4F1C88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379982AbiDDV1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379536AbiDDR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:26:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348DE30547
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXrJ2Xv4voUTn0SqL8FbHzA2pYs6q8NkhzXR0S6+LWynh/9LGSq1DkTbfktmmYVXZtjHUkTSr0J/9gEETE4Jj1501cAb0QA9jhdzg07LFiXkSHcGX5cghZW7V26i48kQR7CzPKZO+8J66fwTlPFjc6hU3rJgOxtw75g2sf9wuIWwu6+slYDjdMvPA9zd+X35sz1vxJvpialqbS+Dtu5nHOpvD3t5ndhzL4+JVzOcYNG4B3bbwnhmXJ3omlKYUFokXWqwjyLQcPigHLqr3BsBligLJbjB+QBlkqlRl1HDZduk54Pm49Ve/EOiz/z2hV7WnUWOGtzPIybVH36rMr6ZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6nXZsRpMcIPNBE67HK0hAYnsq8Azr0r83ONj99ZO0s=;
 b=M4buIQS2cI5Jv6IevJS2M/27EAmOCq5242A8EHs74Og3/zqVWSl5slvgAwRJgZ0y6X56cbvTlthJ/3yZfhuZJ73XVH3EZupvipmquGqDhMXqUjis0WfYRjm/4QX5b8nwRRX2pfmHC/ia1DtOHzcrr8mQiIdIZ+u72/tCMrD6VNR2EAmPFXl5ecRDf1ClMVoWoxXp2Q19GE/reYbCHwoilhNsJOfbHMmLvJ8q9ZTbyUx5Tl5JNUte7ZPxOU0mMkhynfWv+5VnKX2yv6CPU6LQ/opHngi+BAAWC4Umq0Rci7yvJe8KtMVB45DqxE3+99QyVILUxKz50rFbgi2JWVtj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6nXZsRpMcIPNBE67HK0hAYnsq8Azr0r83ONj99ZO0s=;
 b=tewdc6cs6aswG4oQuuJmxjo3TSTBVF4tcrnN9FZtnNt8/9FA8iRo37nFmVqjklhoeYPq3N9/xjYV+WPobt/u8wFafoXtt8YH7CmDDnYeqnfxjAkqCc0bGT0atGTgyHgGhKMxUBUaP+DNlfGoCUc2kgbqEpoDHn46YecABeFCkAAC0jb81pP887Kr4CO82Yy87XD1+IKupYTQtdKPuWPeqHhhSDTIl8U34ry/5Coi4DcBklZjd5jSF4c8d0Rrum1QLjYH/cYigbOjspTXP03yNCLJ0K3P7p9Fb16ORH7X4fEfWMSIDSDpcniPn4MU0ASAv5yEfkUbqm2xy5gAp4Vh7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB0066.namprd12.prod.outlook.com (2603:10b6:405:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 17:24:05 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 17:24:05 +0000
Date:   Mon, 4 Apr 2022 14:24:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220404172403.GO2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <6ebd4f9b-5824-9489-43c3-7810963ec918@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ebd4f9b-5824-9489-43c3-7810963ec918@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ee14c9e-1125-4801-ba5c-08da165feb21
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0066:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0066558048C87A9A5389A163C2E59@BN6PR1201MB0066.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owqaQwvM92KRAwf1JlgmltE5KxXJikG0WbtzLjhu2r0Kz/j3/Mg3Rvsuk4pYDTpQ/tHnWtew++iH0tJi2s9TjbCW7qxUct8i0+3P45SgFs88duGmUjI4Rd7cWzxKm+jsjaVnxGnKMvBi+T0/2wligypMufS9vSqF0VPxMWD3MMFXn4WQ00AXRKRW96U+ZS9zHL0U4/MVWwG96wA/mdc37uVw8SM845q3t7PiJp/5buNBId1iXAJF5cwblYP7CTOxBgXiGh6r2FkD9cn+veMs+gqLL+XS87eyYogsoX462N6iAKYI+wf0ip7460y1/uD/R7wRqrKdgTe8Bf79N3F/zw7xs5/atnWhgjQSreMpWiZTd8KwpsMPFd5cBWWFAz286+hEgbY7ujBYfTCBWPbPKIsvbssyM9iBM9G+hJHkDUfyK84k4j0c2zHqpJdG2N3r/rMkDR/nuUSRipZ0cFEZKyH2KTcmETx4NHRVNRN+p5Tc4A665DmZjhAqqUIV8gv4c0v5yA0mJq32j3FoUtdNWwc1I6Ce2zQq/5O4pROGtnDEzIHyN2+XJkJqsM5Yq+aeY5NYvkhfb8VjNSNoK1yRnQtxT9lNuA6p7/pn0wh5ATOrlzmfGJYO7MN2RrKv9bJrBJabKyU1MyZoSG8tSdW1EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(6916009)(1076003)(6512007)(33656002)(186003)(8676002)(6486002)(36756003)(2616005)(508600001)(66946007)(66556008)(66476007)(4326008)(7416002)(26005)(4744005)(83380400001)(8936002)(5660300002)(316002)(38100700002)(6506007)(53546011)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?53l09IMDJNrKYCOMRVJcPBsKv7cstjrPgsv1bgJqfrsVXc1ukfsYWmhbIDLo?=
 =?us-ascii?Q?UsePtRgcysPMKZYVCdgWmTDfctgvdUMtpHKX6wlAc12+qn3uriXHWZpJsLDI?=
 =?us-ascii?Q?uXw0NnEhNAK6/iHUWOrZg4z1HGJ+0r2demT0qCBxDSLvarDkzTKoOeyQzlXh?=
 =?us-ascii?Q?1Oge9cL6uRB/tN6LkszVMSiybUmHezGWsnQiKsRFT3VotvBH3I76U9kjMfp5?=
 =?us-ascii?Q?p8V3Kp/Pp6P4MCn4k3YImRSYi4BO0iK7PQQTC2jp1iG6Cl/dgPxkMYuYKYGu?=
 =?us-ascii?Q?tF6rgiSFy42k3BM1as+bhXpQM4WSJpqg7I6adpdCAEkcCfyCuJH4nZ8jjjxM?=
 =?us-ascii?Q?NHu2pLlHxWAfpDF6LwJLBy4O0Dbf5+9NMdgjs1vls0eKhfzuHOKNhmnnme80?=
 =?us-ascii?Q?gnSOUQK+I5AUnseU86KXciPytpw25KlqLu4pNgKubCEfZ7/GkLkgRqKYqiku?=
 =?us-ascii?Q?2yuRnvTGonnZJDZGMCiEyhhOkrd0WB4flKmYOHGVZYkIbortidXCcfSzyLKC?=
 =?us-ascii?Q?Akz5ezn+eivIPqdmvgHrbTPGg7Fxi9JTEvVcoDgfBnGXXHEEk31yrVSs9B2T?=
 =?us-ascii?Q?xMKc9bT/FsCbcWz9pBW8e9ljUwrTusouusAydTNBqsRcjym1XwoLW3E+u9q0?=
 =?us-ascii?Q?oPkwbayJw8Z9EyNZvlQSyIQJyCIEYBbec63BJl3TabAoKgxzJTMH6c8z2fI8?=
 =?us-ascii?Q?nde8E+n3cwN87ucbXMqQy48yMLiNKBUJ3qeD+RwsbZLsFypPux9BjRgl5UWw?=
 =?us-ascii?Q?B4C/Pscuk45gF4Ve0q8MjmyscnOuLll6i7ZTUZxfKd5TC7Cmt4/LCcJe/98x?=
 =?us-ascii?Q?/yQ4nZUnqauAXCefFQS2gxOhdeLqrdzYP3enIpCiK+xIv50lcJRaNXBVpCr9?=
 =?us-ascii?Q?8IsDeT/xlNwK9eMrilqWcZKwiga1V4oQnTGKvZ5RFBzKg7dBSoD/NEvbC7vI?=
 =?us-ascii?Q?5zvGkfQrEJGmtlHdtyAVJOtBmfUDvyjF10v2vWTbrlZ9YzINYnSyo1TKLWIo?=
 =?us-ascii?Q?T1NHuGeOemJ7/zR7XaEhhi4IYu4+Kp0xzyFzP/S4DJ6Ji6iYx9W1kBYJKXSd?=
 =?us-ascii?Q?An7Ju3Bju+vKfmfP9pBYVmQ/QsCG4+dn4EbMzvkN5PRuUuyOCG7JxokzxFKR?=
 =?us-ascii?Q?dk/VSZxCQbIo3iVTfW0U3hZdBBbwe93IzWv0/54BJEBPQtDZccmCAoCBedt0?=
 =?us-ascii?Q?54keLwAdD3LdlwONj4bH4kRBkOX9DjYI3lLMWNh+YuqoqhmnFX1tyW2BTk1L?=
 =?us-ascii?Q?61nuuoJJIdVfwzoZiOhGG8peKLJGxeOktublDUwe+lhOxo/Vf7rzlvAutFmM?=
 =?us-ascii?Q?dINOZ9WTvfcS3e9Z+tn9yZvUNRHJDcSw/IAlRgshkKt0CuKhceiagh0WsCtP?=
 =?us-ascii?Q?iaBCAO+Ug49G6mfTtuSULccp4KaGcECs7jRXR/R06cf9b5MRfgh0ip0CLvH9?=
 =?us-ascii?Q?Y/IiecR4GBQcEtFwSMKiEGfj2k+L8FgmmmIN7NYdbtfb1M6omSUu3+Ge8FW8?=
 =?us-ascii?Q?YuDT7D9XEzdsRT9DPuTMmVF4YzOW4+tzKH+QBDLoBwI8Z2OMDitTbmon6+5r?=
 =?us-ascii?Q?QuyGc7UBsT7jv9s7Mm3TcugzF7/Zi9glK+rbp6mjGZigTSn0AqbXJ1debWG0?=
 =?us-ascii?Q?if9ydsfOjCJ5etFVlWHWaX6h9zWXhM4rhMpI/sUPktEshrE7iLgIlxk8s7ZO?=
 =?us-ascii?Q?im0EtAyY9IADPGbSrrQsxeu5tZ0BeFQeDS1K+y5TGgrx3Qm6szNqXaK9GD0c?=
 =?us-ascii?Q?dr2g7eo0eQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee14c9e-1125-4801-ba5c-08da165feb21
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 17:24:05.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j92MkwaDdg+lmpjb+K2vBVYtoPL2xFApK++y9uGcMyZQbgk09+n7lFdGNbgZ7Aza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 01:43:49PM +0800, Lu Baolu wrote:
> On 2022/3/30 19:58, Jason Gunthorpe wrote:
> > > > Testing the group size is inherently the wrong test to make.
> > > What is your suggestion then?
> > Add a flag to the group that positively indicates the group can never
> > have more than one member, even after hot plug. eg because it is
> > impossible due to ACS, or lack of bridges, and so on.
> 
> The check method seems to be bus specific. For platform devices, perhaps
> this kind of information should be retrieved from firmware interfaces
> like APCI or DT.
> 
> From this point of view, would it be simpler and more reasonable for the
> device driver to do such check? After all, it is the device driver that
> decides whether to provide SVA services to the application via uacce.

The check has to do with the interconnect, not the device - I don't
see how a device driver would know any better.

Why do you bring up uacce? Nothing should need uacce to access SVA.

Jason
