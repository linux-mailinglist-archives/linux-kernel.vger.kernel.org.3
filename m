Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8F4DC778
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiCQNYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiCQNY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:24:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B768654BC2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 06:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZrZihcJ8bIEW9vt924i4k1RRfeDt0gnktgULTHurI+Bc9ovkDMMZy7vcpZ0t0mpweuXVZMSSunAPNesPK9PM5FY9vihoIAL4Q1ssI7oLpwWetIZjdJL2KvWb2KgDpWQCRcQ5OqGnT9gx9djc58EGanaAw7OudNlPOfHTjL9C8yO2LoXUTDtKK6RWN6+GwCMTlmsZmwePk6ShobkQWf5YuZoSI6jLABfEKZu3HWlF/AxGpb/4VphAG+vWGS+yiDdqUn9fRQuXGp3MHQwMXi6i99hkGZM/TbrpSJFI/uaiCxVkYN98U0XdxDa8EbM/pCeSgcJTsoVX8smwBo/YshbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7tLdFKIxoWsS7zTO6RgILjd8FFootdwR9yyqPfkNzE=;
 b=O4A7VCXdGc2xZT+3qRmZ/WaILGLMlmg3PMa8+fqd6DtWrwlFPGHtAjzhDFAhrtp8+cDzYr0UdjNik6R1ROBFcMm6z9aiYm2Hk5993OfSWOhFg6lhC1GbuQ9jgWh4QNSQw6OiA4IGba1KW+2oeuWDoA9UHmwmke+P8nDd7YPfM3u9ytDGW2hcUOeA4k4vw7ILToATCTlLZrw/KrWnGy29MNGjkh2sypSsgLY8N8vjYxwYWfPNHWNSet7+pN5uJN+yU7L+4i9bEy8f3STHf4nkV1hw8Wh6PI7NyYeIaDsFWEWbQ6kx2bj4/k3uwqnDbOGy50ExHOLt7DpPBjsqY2RB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7tLdFKIxoWsS7zTO6RgILjd8FFootdwR9yyqPfkNzE=;
 b=nnohJWU6Q6DPkGcb4G7Qd09SdxXFbZq/M6MkzE5Gt11IAz+yt++crOfCs88oM/9sBaMN8Y4uO2zMfeXgp/0/DpRiukODFPZPk1hMm59Fgcapuwm+ZNGrBsHb7YkuANIA5G/tkt2umolB9pxKNMXJ6BSi3lS4pu/zdRLnWUOsxvDfvBQ41bqajNWzKdJCmg/mpIrP1wqQlLIVY8V0H8PJVHxvK9enjI2yglfWapxi4HJXOEP/0AAM4i7praWQ+c3Upan6cvZVx0YtDWV+b4vmgKXPAzyJ7Wb49wnEDjokNul0Fmt282M9dhxyd+pjl3e34BcazEj+owudev8JErmz/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB3665.namprd12.prod.outlook.com (2603:10b6:a03:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 13:23:09 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%5]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 13:23:09 +0000
Date:   Thu, 17 Mar 2022 10:23:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/8] iommu/vt-d: Implement device_pasid domain attach
 ops
Message-ID: <20220317132308.GV11336@nvidia.com>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-4-jacob.jun.pan@linux.intel.com>
 <20220315143322.GW11336@nvidia.com>
 <20220315153620.710a30fa@jacob-builder>
 <20220315230457.GO11336@nvidia.com>
 <20220316135004.61ae1611@jacob-builder>
 <20220316221550.GS11336@nvidia.com>
 <20220316174959.08040193@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316174959.08040193@jacob-builder>
X-ClientProxiedBy: BL0PR02CA0140.namprd02.prod.outlook.com
 (2603:10b6:208:35::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7e4f94-0ba8-4b64-b478-08da08194796
X-MS-TrafficTypeDiagnostic: BY5PR12MB3665:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB366523D8BF93B33F76066A1EC2129@BY5PR12MB3665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH8YMetsdXPazWCreisw7QnyPKxno16jK2/rkXHkXJGxqvOHVRCXcqwCdan8+eDjDUNEgZhGpdK1O2zxoj44Z4He6Gs0HzB2esybbssZy5WyYGvrmOL1LZxMkxcOLxov+IHtOMbc4dfUQxVbSRp1dh7QJSywJDNnaA1QpY36g0hebbDoPpKv97QS7YUGO6OhE9hhnXbIxSgK++e0hiziwHbbRMwv9MupH3jv+0DHTN2370thvKuRGLvHxBvEwkHJz7jhC32jPNdlH+6sFc+Khl39ybxhQMPytXnnPUe8+OMPt42uONmBOWSP1rCGhydE8SX6yPooYfo94+AN9qlVFQzerMHSh/HcpnJakhfT6U33J2lhxBIMcbPH6k23tOcoK8h6dmygJ2PzCnrZN09n9aUYC8Gz2Yhn9Jis629qlfTOUCKBw5sI/KXD7XtpX/fmT/2O+nv4UHXVL2ktXKF1nA2d8sZdHoG1ZZCJ8SqowCoBggdQNvDChPHkF2h0+0du6gxNyUWHexfXan08tfhFVnYbK9JPz9SxV6VQgJP+2eK2see4i48dBaJrgfnaQHLpan/7xN3529fPAjm0jS5u49oad7oJGT7235iCOEft11CbpIpOXfyx6sqN0TkHeKZRPDAZ0vVSHNis1MXGWHieBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(2616005)(5660300002)(26005)(36756003)(66946007)(4326008)(8936002)(86362001)(6916009)(316002)(66476007)(66556008)(7416002)(38100700002)(8676002)(54906003)(83380400001)(6506007)(6512007)(2906002)(33656002)(1076003)(6486002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JSNtwfHiQuiW65D5gB85RAP9liPMCg+rsTzHxCRbHfkoJxggAKtnogUfPEBM?=
 =?us-ascii?Q?XigO1W5nDDl61szz3FSIbrvO51GotzujKd8WyGFNR/SyFXeUCX21GGzpqu2D?=
 =?us-ascii?Q?Ar7LJ6q2ddLWe/I5ALvljsqy68UjLb8xMF2eoimmRCEiGAHUigiAYOADipFC?=
 =?us-ascii?Q?92foaEV7Xj8MZKkKKz7hc74MWp5If0ss/pcZtt2DUniLQCyFaXCnxjXFdEDu?=
 =?us-ascii?Q?HqlxygmLyVRUSaZ7JzFoqOUqDQjh8/W4FD+X7bnmQu0zm5YJuqPibg9PNhpb?=
 =?us-ascii?Q?ZWP+K+aWQaeyvL8ZAAqkseTYDLjQ0xCjT7frlwWGH1TURVeYdjdahzRVkTEQ?=
 =?us-ascii?Q?CMB8HXzbidEL2JL5jXZQuEYlJwsIqMfVgFaz4OlOVhrzm7KRgdIbElEXmbzi?=
 =?us-ascii?Q?O7Y2KqdBPNBtvUiBfE5/zjO6bITwnkZHZVoyvh0Phj1zZQU5fbCJEpL1YEAE?=
 =?us-ascii?Q?8BISyQVv2BFQBxyBMWN3IHxB+vfu1yoZOBWVFtpZoyMTQ41P9zJPEVn8yyHE?=
 =?us-ascii?Q?bDlcdcv/43mrrjbLpq/1o+Iu9xC6LXoAF6lngUwuJYTjtZJf44YORGlI71Yn?=
 =?us-ascii?Q?iliZDMdyv3gW1rMwV2qu/lwbgt3yyBTSXY3ErRWvzralDZY3MG1MDmnOO6Vr?=
 =?us-ascii?Q?JpohGgMgrK+V+zXxNh+tkbTMzLhezHAsaEym8ee0wHT7wzvAWEGAsjvETPCD?=
 =?us-ascii?Q?DmgTENSBj9S9F6VbZLb27BLJ7T1x56JG1loRjwl4cpAqEpp7VqeJMEcc7pK+?=
 =?us-ascii?Q?+dZ5lxbbDyyDsDoTFDVgqE+Y6nkZd0eLa0XkH/+PZ2RSttUuZW5ShMFuKVXI?=
 =?us-ascii?Q?rY82GbTEGqROdrVoi+H1/JbW34tATEKjwP3oconEbE13e618a3lKKQwOS6yv?=
 =?us-ascii?Q?GLNEAPsGgedD+u82c70J4DwHVWWJGAgbNlGtkO06N/O6gY5RDLyYUT5WCdoU?=
 =?us-ascii?Q?AAHN57M++9FxfbIgC8ges9O46pbuVGwDpBf9NmM2vV0IDZE1mKb1eKCcCtzS?=
 =?us-ascii?Q?lZhlsg4Z01/oGKOI3LNrVOQBHcsGkoDwb11GrU2KHqSJBqlXmgKTK4TD72cK?=
 =?us-ascii?Q?6YTPPeU+bldZD8dXyEsPvpU3dJjl0l1dThHl8U1fk2vYVQG2zdX9y6GV2TOQ?=
 =?us-ascii?Q?ET1MZ03/dyaYnD/3Vqk109bvO5MPxNF7BcOQjP3ewkj7pkOKlq994Sw2b6B5?=
 =?us-ascii?Q?eZrQusq9EFP/opMkzEwm6DwWCN77nZ26VXQ25osTWHJMSRg1b7bStMdj49Ov?=
 =?us-ascii?Q?koziOOL3jULXKDEEYrOckRNj4VMjkUudvRBVbZu8Tzxff3sW/PW8WabvcdBx?=
 =?us-ascii?Q?GGQ3GZV+q+DDlzijl6XnPiZs52l3SWqcf+5l82ojcCRl/x1RsUVZYef/8bsD?=
 =?us-ascii?Q?EqjLr5ghmt2jVZypgA5b/1VGGngYBQVv12OWcd8sRTn5XvQY5txhWZVS8WJu?=
 =?us-ascii?Q?Ok8q0IQjGgHwE3t6ut3IsdLZRcXzfPDH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7e4f94-0ba8-4b64-b478-08da08194796
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 13:23:09.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00k5kJPunYV78auwPJiaZmFkjcWkcfQpvHtSXWUHcbNGkpKs9p2l+2v7slW2CDw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3665
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 05:49:59PM -0700, Jacob Pan wrote:

> > I would expect real applications will try to use the same PASID for
> > the same IOVA map to optimize IOTLB caching.
> > 
> > Is there a use case for that I'm missing?
> > 
> Yes. it would be more efficient for PASID selective domain TLB flush. But
> on VT-d IOTLB is also tagged by domain ID, domain flush can use DID if
> there are many PASIDs. Not sure about other archs. Agree that optimizing
> PASIDs for TLB flush should be a common goal.

If you sort the list of (device, pasid) tuples can something like VT-d
collapse all the same devices and just issue one DID invalidation:

 list_for_each()
    if (itm->device == last_invalidated_device)
          continue;
    invalidate(itm->device);
    last_invalidated_device = itm->device;

While something that was per-pasid could issue per-pasid invalidations
from the same data structure?

> > Otherwise your explanation is what I was imagining as well.
> > 
> > I would also think about expanding your struct so that the device
> > driver can track per-device per-domain data as well, that seems
> > useful IIRC?
> > 
> yes, at least both VT-d and FSL drivers have struct device_domain_info.
> 
> > ie put a 'sizeof_iommu_dev_pasid_data' in the domain->ops and
> > allocate that much memory so the driver can use the trailer space for
> > its own purpose.
> > 
> That sounds great to have but not sure i understood correctly how to do it.
> 
> Do you mean for each vendor driver's struct device_domain_info (or
> equivalent), we carve out sizeof_iommu_dev_pasid_data as common data, then
> the rest of the space is vendor specific? I don't feel I get your point,
> could you elaborate?

I've seen it done two ways..

With a flex array:

 struct iommu_device_data {
     struct list_head list
     ioasid_t pasid;
     struct device *dev;
     [..]
     u64 device_data[];
 }

 struct intel_device_data {
      [..]
 }
 struct iommu_device_data *dev_data;
 struct intel_device_data *intel_data = (void *)&dev_data->device_data;

Or with container of:

 struct iommu_device_data {
     struct list_head list
     ioasid_t pasid;
     struct device *dev;
     [..]
 }

 struct intel_device_data {
     struct iommu_device_data iommu; // must be first
     [...]
 }
 struct iommu_device_data *dev_data;
 struct intel_device_data *intel_data = container_of(dev_data, struct intel_device_data, iommu);

In either case you'd add a size_t to the domain->ops specifying how
much extra memory for the core code to allocate when it manages the
datastructure. The first case allocates based on struct_size, the
second case allocates what is specified.

Look at INIT_RDMA_OBJ_SIZE() for some more complicated example how the
latter can work. I like it because it has the nice container_of
pattern in drivers, the downside is it requires a BUILD_BUG_ON to
check that the driver ordered its struct properly.

The point is to consolidate all the code for allocating and walking
the data structure without having to force two allocations and extra
pointer indirections on performance paths.

Jason
