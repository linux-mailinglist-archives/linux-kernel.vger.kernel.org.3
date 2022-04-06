Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05264F63A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiDFPti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiDFPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:46:59 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F45D3DC47E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 06:06:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPZRfpGFi3H9SE5H3v3GwxRiqqCoPts7wHiqQWkVnbh2YKzcH4+IixRGP26wRoF9aGK3jfOPt1Nc7M/EgbDw/yYo/B6cRN7YKijatiB9DoWNJvzryljLiszRzGI2lb5PsrfjdkQnwfLnus5F8cu8r/BUckDzZ7N4s39Jj/vUpVKjfyUFu0ltzYsHN5CAXtc7+cJkUMRTLLXS3C7cHTVv9S3COeqHtQ7i2WkVBM0wseih2fU0zmEeq2D9wINDgEDSbxxWnJU9GztvFEEY1WoQ8yb95P1SFJcxDVXKlxn8IB10OmyGDwSa3+/rLLrADX1N5li1WMbwysgNNA3JemZHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iqda9BoOeu9yN6/ELGFJ6kH/6ENNgjpNKq+QRanjDgg=;
 b=cDDEBP8SKKvRhoV/UzgxQPq/KxM26rDqQcU4bs50SUrgctGbznq80MWMmhNhKanc5sVd1Faof9s6rj0NJcyswz+8dOKbfvvhKSYvw87W5NQidXpYTgPIx8WlTcW+A/p+FjRTHiPSVbva3QyO5mVvkB3BBua4NAXLNXZlR3eSiIfn6s5RH8ydoUM01bCkHN1LsfqhkVYAFpMSYD08ulw9kHKYUTEtpj7FhHR88+Y6He/MdgQ+H5nUgbv0V8dLXN1kjBJVxIBczxwvORN0HjQoLCRjvwXQhBdZxxKxaLl4QhCyvAegvbS541Ob34UXBr5FsgUIA3/86P9bQRZnJOgVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqda9BoOeu9yN6/ELGFJ6kH/6ENNgjpNKq+QRanjDgg=;
 b=iWNZuX+zi7c9zRFiKojCiZOdKqb9Z1aZuZd4DLefSfvCsMbBFTgRmj1qOM79lU3hanXHndVK4jlx7fok3QCoNYj9xjczOtdYeMUwS1I9p6yieqAUGfty/sUQ5yPlX2NBFEaALNh7XBUYBZAXaSzVFsWFM6AB9RYBFlgCjgieKJxMv1+pvhdLeFbx/uWUejTr5zLgKPC6s90ML12RkdwcTWKONbDlSHSnn7Ho4tfTXf4JdVlnE2QKIY1hCsNhSlVp5qe8J38L9kdhVzvyCFx5KQFgdUWfpACMBSPPg9MVs9ivntsT/BhCZHkPuSYFdVjsyFBh39CCCj5bn9u2Vcx1hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:06:16 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%6]) with mapi id 15.20.5144.021; Wed, 6 Apr 2022
 13:06:16 +0000
Date:   Wed, 6 Apr 2022 10:06:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Message-ID: <20220406130614.GC2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c21c890e-1a79-4066-5136-08da17ce3be6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3115F9020A5694C15485CBF6C2E79@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7ABsJ7ZqJ1Zag2BfxlLxWlgsTCc3RTmGc5PARAKZ6hc+cU/XofmFSUNGqlZI7BfTSPmMf8mOG6IP5H7Yy3f0PK5igZjO04wcVLreyqVSpJYJ//Ok2xlXMXLKR+8QPvbl2aWd328E2q43I+i6cIcvk+qq/XGRpa+oZschKUCkcMfmZdNzRtIrzdJ0l47+XRiCFQy/6uR/G5wVil67FjSLw0DlAQ/0jrp5XKHgy/EBd9Q0b4q0om+of9VXs796tHinHjAEmKWpiitNMCsQe93T3J90yCkOHz5j2xu4UjWehdSzmnTQzpCYfi788xc+zT1jMxPNt6nR5FfDUpDlFvbpKxdEebw2HOZdswDoHx3aHF+1J5Ygyhc3XoN3EpJOrlAOivZOlqeajmdr2se3I0ndTwk6tAvHqXZCgYw2vQycb9csGF4nlrbUO28H4WigXUCBXKdsVbH+yzfLMDvsVIu7CVapGeMXl4YH7fYAm7DTsgFuFZ95FOEtKPvWcG/uQzHZExeUMW/9IYFldVdLUV3aK240MtUJZ9wvTaFyg+S+Ww55okhMQXpOwZFvMqQ0Z8+4ZJMb8b05Zl5TcE43trDbRIbSWLgJwr4C4LRvzKwd3uW2xqJnayWmHXFViEZyu96tN71f0a5g52zfrs/xYuNsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(54906003)(5660300002)(86362001)(508600001)(66946007)(6916009)(66476007)(66556008)(6486002)(4326008)(8676002)(2906002)(1076003)(33656002)(26005)(38100700002)(8936002)(6512007)(2616005)(316002)(186003)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6mmeYEEUGXEN4rP0QpzFOCBCcxfDqDW7OzCE5NojwUCRcu9fOx5pZQJLhLo?=
 =?us-ascii?Q?yCt5PGTOVLuAxcwKBCTDgsFCui2KB3bfVCoWJ9MbumWVF0xhLrJ+1T07BI0c?=
 =?us-ascii?Q?SQLM1c/sJKu//zo/m6StoCGBGPXROq0kJHUzmN3oEce339pvGarLf6fozhGY?=
 =?us-ascii?Q?dASrBTqFzB7k7S+/dGUtOmeogwQOj5B8uxLojA7BOwnTP0mwo6PuuZ61GGcQ?=
 =?us-ascii?Q?LygP2Kqa/qy41Ugl7D8ay52hDxD7xmyB8ol0kbOLtF+DS6yqcBY7Cxng9/3s?=
 =?us-ascii?Q?ftfShOb410HFxqiSUmTY93T4WWGnfGU7udQupURAlRzKFLBZJ9rUNSovriHg?=
 =?us-ascii?Q?BONBe/0xQvU7UweztQKqyzRi7YkURK1GIiuFD9PpKmit7CGptJVjmJi95SLU?=
 =?us-ascii?Q?QqsuqdLWiRkyBnqW7+ZEwCmAsBEksPNt2z/1X+HKPMMfmx0PDxflzq7I2yvb?=
 =?us-ascii?Q?14rsmwtRuMGkFyp+8DXdoF7k6K0rCsGGrRdQsvCzgjL8pOhlUbLdqzHusLvL?=
 =?us-ascii?Q?YpsGWQYEI5qN/1XpBRjSyQquUvTWcMXS2dUnb1XDh+ixmVQ+eA9+WQNuYCMH?=
 =?us-ascii?Q?LH56C7Ol3SsdIJUNebhuvMITTByfyifDZ0wyw0E7XZJOKQIRwqXnoi1Y7oUB?=
 =?us-ascii?Q?SZYzFiNhA0Hn7Z/iI8q93RBbQY+2m9cEnEb972BnG2lQwlLdvIW6FDPtRQf3?=
 =?us-ascii?Q?IN63eoDVNqv59q3LHxbOG0/L2/SJkLu5GupHq9Rew79qLvPLEvqAWZnwuex2?=
 =?us-ascii?Q?FtQbDhgnxEikkuTOdd6IlbJR2EfOcajaxSxzG532wTkN2+feBC/fKDlTtWjg?=
 =?us-ascii?Q?tYHz+tDOi0VlOLYt1f+NL0ulnvTJOxb5cz1Zq35OVUrvspu3P9Sh7CvRVUDo?=
 =?us-ascii?Q?G4pTZjpiaNpwfVScSmaKcKuEw/g+W5eosO+qf+cX8WE9i2S858QAF8BMQ8ej?=
 =?us-ascii?Q?vjg7rwmlpnO3QEOY+1G756ctJ/L8sfYBmOgowAsTGOc6r90FxTKr5Wn2mT3c?=
 =?us-ascii?Q?99tV9rNLYiDdHP6qL3Ar3fPthozaLmPlOeBGBXDm1eIsc50e8EhUWFEKvnco?=
 =?us-ascii?Q?Il76zAnWAxmYgNW/clJnNm6WdG0hGzzp3OgUaxh1WPXn8atIFEyIId89s3Zo?=
 =?us-ascii?Q?09kqmQDdOaelkOPwpFRcOFy/N761h/fJQu4+IQn4WIxSQM7xgfozUeRzvVt0?=
 =?us-ascii?Q?xF5BZ3uPidDIZctqJLM0Ek6iMIi1lm73ZATrIAN9R1Vz1evbSpVRX3Z1YOBN?=
 =?us-ascii?Q?7ILd0qQPAlh3dhtgVCf+oM+2WZwqIkGMgUyiYmQhBbsFd2Nh2/mN6uwnYM3H?=
 =?us-ascii?Q?q1Yi3eODvGVEwnwkvKkBL6xxqZAkcLsfAvDM+fGXwj/gKe1hdwV1TUvWgaQt?=
 =?us-ascii?Q?4uVaq5o2EERhZ2QzSbyPqU9bQwhZIJNovbeuanDZWlexg09+4c/qyJEPjt2E?=
 =?us-ascii?Q?D3znm0uDWywKT84ExK50FUAMXKPKQD8w3FyHZMR9fnaGA+lTlzbH1w4MqbNd?=
 =?us-ascii?Q?NM9uhvn2XWGMBQWTMAyBAoaT6Ii4x2+DlJjvHC/1BksXjQ0Z+++6Ty7N79AU?=
 =?us-ascii?Q?EsyQcSbfqc4U+dPWlIN0v0i/Amom8CfJJFpd+cpWnNfJKrbzSVXFpSNPT4BV?=
 =?us-ascii?Q?fzaJI9e0UBeQqro9bNHuH6EhtSomEWqihxfOewYncVXBfDgC4xnr0JgBez6A?=
 =?us-ascii?Q?d+esaRaZAn87hn/odkkV2Z6xZBBEjagYby3U8JM+ZW60IiWourL6gTWAdftp?=
 =?us-ascii?Q?Sc6e1Qyc9A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21c890e-1a79-4066-5136-08da17ce3be6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:06:16.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OgJkB9CXCly+dxIjQp81BbFH0/Omhy/Bc0+A52TPxgz0G15otZJo41gACOnTAT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 01:32:07PM +0100, Robin Murphy wrote:
> a particular IOMMU instance, and potentially allocate separate domains for
> separate devices to represent the same address space, much like
> vfio_iommu_type1_attach_group() does.

I think this VFIO code also needs some more work, it currently assumes
that if the domain ops are the same then the domains are compatible,
and that is not true for ARM SMMU drivers.

I've been thinking of adding a domain callback 'can device attach' and
replacing the ops compare with that instead.

> It's not really worth IOMMU drivers trying to support a domain spanning
> potentially-heterogeneous instances internally, since they can't reasonably
> know what matters in any particular situation. 

In the long run I think it will be worth optimizing. If the SMMU
instances can share IOPTE memory then we get two wins - memory
reduction and reduced work to read dirty bits.

The dirty read in particular is very performance sensitive so if real
work loads have many SMMUs per VM it will become a pain point.

Jason
