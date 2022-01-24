Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395D04984E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbiAXQdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:33:09 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:37984
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243770AbiAXQdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:33:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS7ZZfU3j0jCa6erFKaY8uE2P3As/ZZfV/mo60/Exc9hDbhtK1nFVIi2HNNr8keZH4Z1+MAW8Jl9NhF4PlhiTZHQq4VHpswIO9iEXdul2XtYCRzU+JDPcNSz3XkFHcwoPJUWwKk9s44GbmceEcRY+WEpZjpwcVHcJ+4MoCB9bG02Eq5dSxgSJWu6Hehjx1MpF9mjcn5erTZdMfGvFczwzzvdFUUgiU5TuKT3/4q2qkFtzpVCH/OX9aRhJonpFbdMed6G4qD0XJGYXBWOGVgXYH1+VI8341C1WcVSjFx5OVy7LJYWJSgZ4nJGVEja7veXK5KiqZEYQWDwUeCYJg/sKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItvvJ6omrBlYnUmzfAT/rGgLiuZrxZg01TNSfiuxZLo=;
 b=fMxD+Lrj9xk3lKjfaeO/yLUlxuuEekWCNUGAO+PG6rJ+8TtXqAH+tLc3tds7AXFngIx5tX7ldwUW0Ig8M9iS11q0iiuR9kJyvRmr1n5/zaC7ecKTs5MFGnuKyDbgLYMQX0bZrGEjtJZAHZlodo8mdkJ+05OpGFwWYn2xDP6ncNdLdQFWpJgyp0A7AUTjzAbXqBoDYR9/v1x1EjVedsP3EM/TE6F76r9Sd9EBi6DWLdcKrpYk8FiW4peSMBFLMbiWs3RCHXWEgcmAZ3VTGwXOGJ3JtmI5gkghvY3rv+foDwXfXjHhizvC7alDDIqO2vSG7/U50ettwk/tjDa1JRso+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItvvJ6omrBlYnUmzfAT/rGgLiuZrxZg01TNSfiuxZLo=;
 b=rTj7V6t/2I1mYs27nYC13nyw68CCrlc1ULRDtwTkmHwzMDwCqCrgn+H1krUK+P5XAslrbu+CO5FTWTYyb+Ahp+FyiqNYHlVqW5IoLr/OGxD8f/OPe2aIeuRu0DBL9zQAcwbghizpW6XtJQs0xfvcNFSPtaWElDToo/uyXZGaDCKqScQW8svTe+jkwBWpOuqUtV6PaOjl98J14SohYoaScn7HjFm99CFx8axMNJL2fczIE9uvjyUNFtX/O3M8HB5DUuIkgsXWrphEU4ciu/0EfaWSHOTkVeCn9e/uNWiUDMoGowUPEI827hfpA52Dje6jiZiog+/OZ1ZvLpWEde1/lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 16:33:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:33:04 +0000
Date:   Mon, 24 Jan 2022 12:33:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <20220124163302.GC966497@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Ye58Zxi+F9TQszgQ@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye58Zxi+F9TQszgQ@myrica>
X-ClientProxiedBy: MN2PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:208:fc::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c877fc4-d121-427d-d809-08d9df5731a9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5165:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB516555CE3EB725C699F3CD38C25E9@DM4PR12MB5165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADi5ch5du3ZVv6cwVa1OD+egKhis7+1dT1phzQ4TI4VRFfI/hY0VdMqRwtkt/ExDOPvwBDCtVMbxsCeRJw6uPnStv+lU8c+nDp23GZ/tC+Bm20KJiBr3BBrTkzZk2r1L+L3wr5PhdX2k9QHvIcqQuVRTemxmocJiLw7MMw6Oaj5ULh8H21KVvzDOMg9n3jGjGR6UIjvZ0QOj1FLEFcq0cROPhFbs/I4OyDsLMY3gLlZArjrDBJ/8/KbT+5an0WmZO3cxbPiErIemtNcdjxN8BB9oQIq5ZUk6S3JkWkihgMHcox7earimPZysY2P8AinHvgOwfSMg7F7qAfsquzNIgbJ41uBPrZiyheyoOBP7HjKl6T63s6A1J5Ngl9QCvZFV6tAvzf1HvL9xbaVQBy3V8YJP3bRKkhu5VgaRYknYg4iGdioOAC/qg0TJlyeFOyvnJ96eogz8O0oV8guYR+3aB1ybRNm4F+9iqXkLlRMmZ/4fr7lmuf8au/udoE0nWIwyYz1OBLi444QUvdiXj/D3/I4oujsDr69XNvLg/cVng5BS5GY/4188gPDTZS22PCeiKDEnSWqksLMvAY1X212zQxLEyjDwimdxt1FrSppjPEBqXkC68VX7PvmBDYxQqQy2QFm1JRDxXkxVa3F/vH8XXTCQxmXlmt+qhW0Wt/Gu9uKx1E1mvJunrW5bE1iV1mhrZfn50UY9Yf3UKlFz/DS3Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(6486002)(508600001)(2616005)(2906002)(8676002)(33656002)(8936002)(83380400001)(86362001)(26005)(36756003)(38100700002)(7416002)(5660300002)(6506007)(1076003)(66476007)(66946007)(66556008)(6512007)(6916009)(186003)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kJKN8NBAovl5tzx52ecomveyO+LcqXU5HdRwj0YlxpyrVhoGYuXs9hDblEHq?=
 =?us-ascii?Q?ROCJtEAT5lJX/xgAdZcDSdDR5TuUzYEzT6jrcFAzBWr1k+YCsagfDdJNwSQJ?=
 =?us-ascii?Q?4Pa3715AMRu5v3QYgGKiED06gE0ykoaCT2vU6OkoWdxDWTzS2mbY0J6Xs79X?=
 =?us-ascii?Q?xxK47N/IzkjlJxNdFA3jnHBgKzkcfswi1hMhgJIOO9XbpnRsQxuXmsw7eemr?=
 =?us-ascii?Q?e2823fW83sX9IUPZK8M4IBpvWkC+nxMz9YXTstiITgq3LYa7cNocZM0L2Q7e?=
 =?us-ascii?Q?dGU7AE1dNfrnOjRpAJGgO3c7nurzi/GELQmdqdUwNphXd1WPhkOFRGuby2HC?=
 =?us-ascii?Q?a9OMTbqKvS8S4YyasUgz/ZtoOtdZAJTurg76dKMx3H8AS9o0kI+PmiEKswbO?=
 =?us-ascii?Q?0WeFHXhpdffhgVy4uKyHCI6TDtfizXVBqRzUdXiJ7RA/ZET1DC3BPb9E6z1Z?=
 =?us-ascii?Q?Vx9J0S5Nv9t4J1pcDf6xmJ9tbHxG15AMwdG5sCz6ni7jUAe1js5o3Y0x8N2E?=
 =?us-ascii?Q?Yh53egpPEll//K0jI6kb8RX1aevlzo90u1ioceErrfslAk73ZgbmaWtvvYJ5?=
 =?us-ascii?Q?Iwurcpn1PHvM8BYjMNGwRbMNWieN0U5K1QvgFI92gLHXcF0F5gDEsqEBobSU?=
 =?us-ascii?Q?u7rnqwiFjrdy/H6alwifWDdbdL5pC1uqRbp6dmNFaBo/3HuItjFvymFGh7xq?=
 =?us-ascii?Q?/hygDScssvr7QrOQFmRTfMT9MgSxYoT5CS5jEL8fHVajyzJRhBYgejGMQp6l?=
 =?us-ascii?Q?oT0imM8BwO2TTr9Iv+eWmTRRW1aLZZkozgYT9K5Z/e9xRDAoJyg9vDw+6p1J?=
 =?us-ascii?Q?+QrEbBx2XPb0Pz91YnMc1e1lU8rQja4iUP6CZDXRD73e4o3lARuONgJR68eG?=
 =?us-ascii?Q?YQy4dNhRkF+AFIHDioSa7pFzzAu/LKugAVQrh+g2RkkYNRF8ZE3/EvHjtoCj?=
 =?us-ascii?Q?XOsPr7+3lUKK5SjMwi62+vGkEgt6Lx2YoB4jaaZDOX3g4ST2FtG6yw5n0c4e?=
 =?us-ascii?Q?UES1j+vEVmUSVyxQsVESE+tbvFixl0w1hC9RoJXKp8WRtzluTB1oF1dWMC60?=
 =?us-ascii?Q?rFepOD6ikTvtr588JvXuWoT4H+o8QdtWGbRc2xlxQVEZVLLbhEKdFwawIkqF?=
 =?us-ascii?Q?aIRS2zLV4mTMzFutBwSjiOMkq54ajqZNkPqrW7+Po+G6Hj+z0f0+Zxs73SB+?=
 =?us-ascii?Q?BPSvLvsVmNUpcMwqhR5NvfD6sYKSPXTN7g72vDGTvPPf9T8bpoo5UAgGCLPd?=
 =?us-ascii?Q?W9bw3o+uSVxKC3Yhvi6St3x6ve8KOeffLpMxV+5i6Zo66em7PjnLgWRqSF+L?=
 =?us-ascii?Q?3J1z0o2kjoNaFzVgXvM2+L5DbqjoSgadPO5fpBx2gZ3GNfSc5EkigF9M/g+B?=
 =?us-ascii?Q?ErHdUj9TzxthZksH42Vng5/tvo9h+BA97/dnsw4NhZqDEnrbBczECeo3TeTP?=
 =?us-ascii?Q?L2i3na8K6TcLSn4qZQ8QFdcPXknOx8pfbp9a0p6Fod0rShijZ4JJaAsqVaNQ?=
 =?us-ascii?Q?4JQ7kiH4BcwqLg31apXmqMmx9nSqV/cqToJRuWrQb6e4qCl7nX/yeRhegZvH?=
 =?us-ascii?Q?Kfahn+PivjqZ1DFhbVk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c877fc4-d121-427d-d809-08d9df5731a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:33:04.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1NiqTcWSJlryPMyBrGw/A14Bj3/E5WxDv+/LS7QcTmd/Qbt9HmtDkuZu7HbRdh5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:16:07AM +0000, Jean-Philippe Brucker wrote:
> On Mon, Jan 24, 2022 at 09:58:18AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Monday, January 24, 2022 3:11 PM
> > > +/**
> > > + * struct domain_ops - per-domain ops
> > > + * @attach_dev: attach an iommu domain to a device
> > > + * @detach_dev: detach an iommu domain from a device
> > 
> > What is the criteria about whether an op should be iommu_ops or domain_ops
> > when it requires both domain and device pointers like above two (and future
> > PASID-based attach)?
> > 
> > Other examples include:
> > 	@apply_resv_region
> > 	@is_attach_deferred
> 
> Could attach_dev() be an IOMMU op?  So a driver could set the domain ops
> in attach_dev() rather than domain_alloc(). That would allow to install
> map()/unmap() ops that are tailored for the device's IOMMU, which we don't
> know at domain_alloc() time. 

I think we should be moving toward 'domain_alloc' returning the
correct domain and the way the driver implements the domain shouldn't
change after that.

> I'm thinking about a guest that has both physical and virtual
> endpoints, which would ideally use different kinds of domain ops to
> support both efficiently (caching mode vs page tables)

In this case shouldn't domain_alloc() reached from the struct device
already do the correct thing?

Jason
