Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709694F06AD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 01:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiDBXbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 19:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiDBXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 19:31:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B536BE11
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 16:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYuYolyYbXFElM17/xnjAuTkG9sbGjnzQg3FOZMhZ4Tt/x6sqvFqBO32+IiymWic4lMGEFP8zB+mdcUox7aQU8x3XFY9o0SvVNcRXtF6+iVC34ZpnbvMBXW2trLUfYi3QhArNFCY9HX7BexsF/M3g5GFWu0PEjV7sshioMff1PtC/LLZEXO2cUiwcUHOmg6csKg3LZJlI8KDFfUUEekyGSM/WZPFNKIw4rOIvUhqUUa/zhX7pvHO3kynPskuydBdAEET+1KiIblwXyoM8cjfxT3yNoytbafJEP2vfobLnMDENmU9+SyOI/nb+JX3Z0WtB7SW0BT/MYsADV7jD66JVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkhsnTirtCm0yUZ3ug9vOXpEHhf9i4vrcF0QG+qjx9g=;
 b=RGZkTo+KVErrMIyHnl3+C/sKabrdtFoc1cXYZeK+ZXcDX30nBzVB1WO6CrzN8v0E1pwmbNEomRlggq2Zrb5wgYJuKF5dncrWEub2JScfJA64Z23Zk5cpDhmRChAeJ1vfH8rMTznXSdoNu2Ag2wKfsgZc7DKTR7T5YS8CsbXeTg2ldKGXO6SXIpU7jge0uLjDdOHwgj1ciejEMqkwqtnWkIkVhpU/b34LWRFK5kAdbYgDwjJqgVYL5uYsAZzNzdyJGiC6fHcJELPkZed8SOfIN59Di7j0gKYyBDUGa3g9C5vLM8dhasYB6XfetBf2pv1mKM2N+VdvVG3d4UZyTnN3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkhsnTirtCm0yUZ3ug9vOXpEHhf9i4vrcF0QG+qjx9g=;
 b=hBLOC1Jbzal6aRTebmNWlMgbXOfGnJvQ9pgsUtQ5aHLFi2ALfgfAZRCfeV1oKyxbJEoOt7vNnme1HfYWfzb/aoWXI2gUpdAGfvVPPq0k/yxx3GKzcUtALNRldmtJmcxE8588nzFN1zwsIXNJnKWxyf+goF+OgK7Q8zN7+jDUlyHT4G2E+F/EEoYYtmUfTZ4dZ0PwPVJX0scjwgil+lv7s2MDoAag5ERuV2aCmbi7rf186jzG61m0IQ6eceYq1vNPLX6KoFEdBhf3Fln+JPPnTvjp+EcjAQBsZzG5ordSBe85ygmqKzAuloGjHBilZrFBRGW31Z77o7IW3mqHd3laJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 23:29:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 23:29:03 +0000
Date:   Sat, 2 Apr 2022 20:29:00 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Message-ID: <20220402232900.GL2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9895d20c-971f-412e-adda-08da15009282
X-MS-TrafficTypeDiagnostic: MN2PR12MB4270:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB427012C073DA8A4CB08BF4FFC2E39@MN2PR12MB4270.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSLtt6bGYQ31dJT0/l/yEJ4/3TpOgPg5B85BRajzeF/GJWmKjljdpMOvQEvO5QkN9s6Hr8/obdVLd31Ec+/0RT9TfCgo49NpdB5U0SEuv/1TiDaKI9jUDgGlBEt/oAvoPcIU67wh2/q8Ru/Zq1dRTkqjjzxwbjHh4cK6cWnQ1CSyQariLoOTJygNwRtjtu6Lpie3ANzp35Zyq0POpQLE/CMyUST85BzxuHuk1d3qzF3dfqjrDj+eij/1tuTrrN1HsOCmBoAFOGN+ebi6XvG23Fyi4DyMTJ65tV/BzzjZ35M/2JXjeIl9zdOtV6Xacoe6EwPbZ19lhUMq3CEqXCuWHd1ZD7tidbV8ZV8QotbUQuk2A/U83nQ3Fb2tH+YKLviAJRYVMoM83wjmQxt846QrOFm3H20Sd7he1C3YAcqj8hiHd6UHBNr8U2+VplH06dU8XpRMh5q2plCyRGNY4rrVpElHdfKl4fUoKzSLCDCNh35KkTI78aw2a1zF4AREsUQ8SEaBySVWESdkBfeSdmV283Itg3AKK0RHzmKFeZhH6ClGlbQXvtMNxO0vUJIZKpnvSrvF+FyLXUtg+4ZKAyFD/0DqkMmoX6nXs4GJIhVE4ZWS4BCNgFKVL9Eo1lQX5nLdrId+j+LTOVYjjJcw5nCZ9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(36756003)(186003)(26005)(2616005)(1076003)(83380400001)(33656002)(38100700002)(6486002)(6512007)(6506007)(5660300002)(8676002)(86362001)(2906002)(316002)(6916009)(66476007)(54906003)(66556008)(7416002)(8936002)(66946007)(4744005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g5m0zTzAsUqpQ+VgkQb1TT8eILbJv378EXC2Y3wi2PF7dgKGun7ZD38Q4mdW?=
 =?us-ascii?Q?/FzE9OoSV4Bkr+7W8mXnsFbiQPJYidZ+ojbzK41OsBUguXcjK09SQxUEGxVA?=
 =?us-ascii?Q?xGs8QaCInvpL5MGYdUYaeRBA2Wj/i6wFmw737mn8+uxgWgGNuapWe/iVAD2z?=
 =?us-ascii?Q?p448F37dMSJdGVh2PGZFLh/I63nUSVYfZ7E+/2H8IQEDDDt+k9SqOsajZJ9Y?=
 =?us-ascii?Q?gzkPjlzn4aZh8AQyJAyugEd8AZ7MvTAP0iAUNo0tQoAaZifm0TFwl/lKhFu9?=
 =?us-ascii?Q?28OCAfZmH4Tuu1B1MffcBGbcPgt/9+YDHq4xDeRqFjAkQH+Sv4TSohKgQM+1?=
 =?us-ascii?Q?q5mkS+Lxs29CZGPjPwjpcFwOnjKmutBIwlUmGJ0+9sGwMZfgLfAZ6F8PwSEF?=
 =?us-ascii?Q?pHFBVrNeOM9b0zPzAZ9+4zWwNnus9nxX7fdpvqAAwIvTTzVo1H+KgZOuWud0?=
 =?us-ascii?Q?qq6J93B1FebYWvRFmriUJrjHP24BBe4c0YjhqBkWFfMwnRJBRcoJJqtt22Pl?=
 =?us-ascii?Q?keGhwGbuJ6QolaiCDIgRHkNoMWwQUarGk0bEK7nn1HJGP6OwKbl0or46bx0T?=
 =?us-ascii?Q?OZYGFQUJHIETUJ6ZWiNFaG7chWnK1tH8EShbL3XJRh+uhyAItSXwypmWNqd5?=
 =?us-ascii?Q?xbOtJcdvfYwfbBPkRxpAzAc58XwYx666/KtejcmWNzlhVQiHiTa2U8Piup0K?=
 =?us-ascii?Q?JSUNEGzT2vtfbpr798OQsj3+DGgdeFxxojqs0ze19B1KyKbIWIQze1JARMVm?=
 =?us-ascii?Q?tKMV/c993IO40JLq1WwsQ3h6FrUWsUWblm9DEcnfwP5E9p1Q/uTVeQGUlsUy?=
 =?us-ascii?Q?B7gubyPtVi9hsbNE+Ak44cms9u9+xA5iMstJl+50qBf0CmBvhSmTeTxEYZ60?=
 =?us-ascii?Q?gWPzPGg/ay2aoXd6PWr2K4bt1zYq9wi8pmQ1qIbhrsHO/HnYNhJghHerCuD/?=
 =?us-ascii?Q?zIppzQNwEWGoHnA9T2HIOe91U9Gx/mMLmqNPpvI+hJEBVuNTywcv6CLk9Uk2?=
 =?us-ascii?Q?5ITC/WmvKAjZPjqpaAm0UY9pMFD+NyZe5+sh/hJA8tjLZWcAJg9lRkGXyRmG?=
 =?us-ascii?Q?RoU2uK6MM2aVsIVa1MhPx3Y+5I+y7yWtWn3wr+WFqlmSvcm9kkCHvHsOveIQ?=
 =?us-ascii?Q?UqAlizlQNF7mVgx5aq2psUC33D9T/kZQ4G1p7rDkC7a8ne9bJBZva6XL4KZc?=
 =?us-ascii?Q?q9KQY1JEzujs8Izo+1eP4PcTKD9Fqgx9Wkoku6rcxOQVT3sk2HEuREd6qcwP?=
 =?us-ascii?Q?xmiyqNrsb4ZFvtBOs7H3myv5xqWVPo0SDRQ/k87X6K8d1ZC8VvUVlvezJOYH?=
 =?us-ascii?Q?wOZ4ZVqfnhUH1/qDTRMdKmrnYRKBy6Xr2AJ6UhzVhk2wRH9Rvm2u63It5acM?=
 =?us-ascii?Q?MsztEM6w6c2ve92pkI1dueSdbQEP/e++/Ar9nPA096lrEej20q2wnDXC/rQH?=
 =?us-ascii?Q?qujFMU+BNHeLcbtQJV4be/m7Zgfys6Pq7qFBeExL2JEIURuxwfEpHYzXb7fR?=
 =?us-ascii?Q?7XLO89lvELD8SNJ+roAQ2EAVn0azmH5P/bpgeyL4sArTkrEtHpdHTzeHsu1F?=
 =?us-ascii?Q?xQGnZyrGKgKY3OEElvjAWipHrQOTUjdCXz5j5Z0223uP9Y5VdasufQgPSelH?=
 =?us-ascii?Q?xs9FfzZZaVhqMyqNegfMzmYY/CvCOlKmmGy8ggHr1xTGKU+siEFStl1Y7Xed?=
 =?us-ascii?Q?qGHac6mG3irpCfUUiIuh5mHV1B54W1vd+Q09vAk+uHzn8/s90AZ3dJns7uuS?=
 =?us-ascii?Q?ETfUEFQQzA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9895d20c-971f-412e-adda-08da15009282
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2022 23:29:03.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb3Qa7K9yxauneqzWHR2qNXLFCfkZwqmqQXIRA6T41P9jauB/Io+F/DoNW1M9r0W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2022 at 07:12:12AM +0000, Tian, Kevin wrote:

> That is one scenario of dma aliasing. Another is like Alex replied where
> one device has an alias requestor ID due to PCI quirks. The alias RID
> may or may not map to a real device but probably what we really care
> here regarding to p2p are struct devices listed in the group.

Those devices are just broken and not spec complaint. IMHO we can
treat them as disabling ACS for their segment as well.

> We may check following conditions to set the immutable flag when
> a new group is created for a device in pci_device_group():
> 
> 1) ACS is enabled in the upstream path of the device;
> 2) the device is single function or ACS is enabled on a multi-function device;
> 3) the device type is PCI_EXP_TYPE_ENDPOINT (thus no hotplug);
> 4) no 'dma aliasing' on this device;

It makes sense to me

Jason
