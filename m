Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746705AA0FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiIAUha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiIAUh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:37:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DB7FF91;
        Thu,  1 Sep 2022 13:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdlB+ZG4fClKWtJ5PMPb31MWBsYJu8VbaOHnioY25NCNenVHF6LMUoNtppIvgv923t/BEFjtbxyfzEq0sron3b/rXIbWzQDntSpSMv9GwN7cyy6UtRYKTem9MEFR/0PujmCaeAuC5DvXj3ToQGdTWm6HR6tnAVc+s09CwvFp3HTOhLAw3SCEO0ULa9O+rb0vaIq7NFrEtyYa0XNePA4P/2BWLrl/pJQxsK07V4SviBaYHRbm3Nr2PMWRgyhx1uZX79nTudCqv7XwTf7HI3/Nf6vZyuhxXUVjUV0v7bVDzJ/e2qWJmIUqqBF87bPaZPU5tp3GGdLsLli5NQl4+nK/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeoEHJJvDecThXHR/aChRI2OJgnrgqFY7IkmcMTDiPI=;
 b=TrkYEFtJku7V+pqK6Ip4VKIe3tiIVjbNerWgEVRoA+QeFDh5S6quM9ao2V5JugKgPXqMtEDJvpPYTNBAXIBWMXb3qaksQviY/E7sCUjReZTCGZCIfyUYoZVX89ffYysGV+9c4g4xyxITlFQBTCMuG0axox4lrnoDE6yVmPxFkUj9G+qWtiVUpBm5VEXVtlx11x46x1o8oXHlr/Nx7HVdTizC9dfH8oR/NT59RNDVhQsmDhmQTUmID/fPrfXLTUOfWWcoHOqCofUSWoFGC1NuQQIHPxxxYp1IDJMbcqLdX9598Uwl/pwDpybERoII8hsRr6Q5pe1yP2JBxpMa2fZ+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeoEHJJvDecThXHR/aChRI2OJgnrgqFY7IkmcMTDiPI=;
 b=JH+jPFSHJKg9GIdz7I7ZSXSbtk4DaNayXNF069eZjPzGIzE2Mb55trKbY2RVltAo4Eh7heNBSI0JTrE5dXdMCkfwlz7RpCEhtOCImczGBffT6gFxlqCUDUXcqfeG+t/Fw6AT/yj6rKpZFrUD0scR/LJGUx75Q/IaH1XPUp1FDmkS9bqnUOt5NI3P//nB0YMW2L2MuMMpsF7bZ8uvHH5mrIC2RcYizFdJ8TF6TDGYBhI5WFAeET5CFqts+ZDp1OCjaSKO9gB6OV7zL+crivQGkrUO+OhG9RRlUM9dXg6lIuVafZFzw91HUZXSTqcIUY0ToTwXAct8CmNzC3+g8BbNCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 20:37:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 20:37:21 +0000
Date:   Thu, 1 Sep 2022 17:37:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Message-ID: <YxEYAcFK0EdahXzJ@nvidia.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
 <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
X-ClientProxiedBy: BL1PR13CA0168.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17de1149-9c7f-4b7e-c30d-08da8c59c555
X-MS-TrafficTypeDiagnostic: MN2PR12MB4301:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBeJ5ZRPHkhrFetXmIb8oX0CpeXgl28ymaj0WHdVZQlaJq7AaCnP2n0vbXfzOm0cdKCqZcOZF5Yc53Bcx+G2RC2IqbBPcjB5p/el+eMqhX/aaovtJGq6gNa6EdC9UtKxD8HYxe7Mv/jdXOF9FlEV34U2xjPnHkYi9E69JhN8yS6giN0ozmdxkbVBlJ6u4DpDRGfHiZPK5MEcKsRrN1oR9AGFM/71TV+F1H7YRm90fthOwmHpUOU97J4hQprPe2xhQ9ZJkk3COc+gpcW+kozAxB4e+qASxfnhJmHG/H7LRxwqA4tz0a3DBTnRBY9ZjeuGMjqBUumaMOUvirsSOlz86AddzrWg8PS1LFe+3A/9f6kiGnigWbmQGAPzUu3mhFxpqeh6Laq/rh/enDE7kRQFIwq6CV4YEHqwlPQSJrXv/GyXtxqw5pmBUom+2mcOXYvV89cmuot63ttZOhVkBzPS0H4G4IL5Oc7SUXGjLdg+h6lZinY8w25cAMFQhHDxAL5Y1Z7ZY1Kd+hCbnTE1fwQabO/hdJ8LYy7yF9L2mp1hkH5rFAYfTYY7gqlLWMrQl91uWw5A8GWG98S2bSnz68euRdJyfWH3Xb5ep+KDLWJEfHIiaR9dr/9FjncaPn7MGvIQywxUo2UpVx1+Kq5ydaf8/CtPJsLSYZ+nIr+q95k0mgXowsaXh76KMmFZbFZGw8i/oC7NNB3caFiCsIt6hwcCoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(8936002)(7416002)(478600001)(6512007)(26005)(4326008)(8676002)(66476007)(41300700001)(6486002)(66556008)(5660300002)(66946007)(53546011)(86362001)(6506007)(2906002)(186003)(36756003)(316002)(54906003)(6916009)(38100700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzJsS3dyRGQwQjVRak02R0ZVcDZwaitEeFQ2L2NnQWZESGcrZEVXeEtDL0dR?=
 =?utf-8?B?NFNEMEJhTG1lMkcrMENnTHlaUEN6aDlPWG9nVHAxTEU4R0w0QWNGUG0vcGV6?=
 =?utf-8?B?VmVCdXBMWDZRY3VQUEVqOU94ZHVvOUZrdllZRG0rQnpmanU1TUZVTWNFekxj?=
 =?utf-8?B?YXdYUTBLa2JENGEvZTVZOW1sNnFsbzU2L2hVNy9RVjR4cDkwUnZvR1c0dlZU?=
 =?utf-8?B?OXdpWnU3aUkzdlRnV2JBcW1NejhlaXlWdFRCU200Q1E3NE1RejdqSzlxOXNr?=
 =?utf-8?B?QnpoTk9uQmV2RGRnZGNiaXN2ak43UlkwSVNWU0RBRGU5UUxWYmZKTHFvOVVO?=
 =?utf-8?B?N0daNTJRRnZCMGZONXNqRHA1Q2REOFBvb1diWTZaRWtpbzFMbjQ2ZzRxM215?=
 =?utf-8?B?alJDdmxQSjNvemM3YnhTcDhqQWdMaWZybmliRlZ3OExpM3NidXhjN0ttYTNV?=
 =?utf-8?B?dHByUTdlbW5oNWN6YkhEQTBEVlFUS3hKc1orZVhXUWdXb29ka1cwUWFxZjhp?=
 =?utf-8?B?QXNhODh0T2JUcGhRRVVLeWpIQkF0MkN1M3dpeCswcWE3VVgwU0ZIUjd5T1k5?=
 =?utf-8?B?ZTJaY3JOc1B0U2MrZDBiZktmbkZuOFBtT3g0ZVJYQ2VuR1ZZaE95SHNIdlpr?=
 =?utf-8?B?V2FpV3YxQWhxYm9IOCtqdUZDd0swNzhybnJTQVN0Zm9KTk1aWGhKNW9SekpU?=
 =?utf-8?B?ZkRYZXN2SG9TTnVnS0k4VHRxRVp5dTF0b2dRZzBRUjVkVUVlckRBN2hWQ3Fv?=
 =?utf-8?B?b0IwUmFmbjNjTnk0VDZtUFdCV284RUFyK1VzNW01WW1hWTN5MFJEMEZzaGYx?=
 =?utf-8?B?b1NJYVpoZ3VianIyMFRsNXNPSTVjSEhwLytBbnQraXlMRUZKMFhJRnBLRjRi?=
 =?utf-8?B?WVhUa3FzNGlLRjhtQXkvK0Z3S1N3ZGNuVWFheE9MS01HWUViWlp5cnVadzYv?=
 =?utf-8?B?ZFlWN2ZmYWI1NWZzbHdtUVFTRURJcFFTL2N4MnQrT0VPWHh1QkNQd1hSdXVU?=
 =?utf-8?B?SEhqbm00OWNJaUl6d3VqNHJOdHViaXFnOGw0R2pJVHZSVzVsdGpITGNvZmlS?=
 =?utf-8?B?VEtmOEZkTjNtcVQ0RDYveWMrbXY1TTk0MGlWYXVFTEhGdUU3MVFKQTZUUTk2?=
 =?utf-8?B?byswRFlTc3BhQmZLcFk4bEhHYUJqNVZ0MGZ0Qm9abFFSN2dTNHgzQ2xVb1Z0?=
 =?utf-8?B?U0V5YTJidzRHdEdPMWxyQjBkQXpDbXZTd0Z1bHp2M1U0cHI4MndEVi9mTm55?=
 =?utf-8?B?bjlqelFlcWlvTGUwY1hHU0VqQ0pueHpFZ0tQL1dpbmVnb3ZZRHFJQlllblFq?=
 =?utf-8?B?VTBvRXJwS1l5UE9qVS9Hcncvc09zcy9xY1VjT2M2ejJLZmU2Q1M4ZzUvODdK?=
 =?utf-8?B?aHVFQzJGVUZZcHpxWENkbndRQWkrTzRIcytUeWN1a2ZSRDM1NHEwWEYwbVVo?=
 =?utf-8?B?M3p2OFFiZ0dDVWFDL1IxWEtoakFZci9RMGQvYVFrMFQ1MGh0eURUSGNXQnBT?=
 =?utf-8?B?VmpMTk5yUHJVWUJFQTlaZElZWHFsOUVnSGpHNGE3YVQ1eFkvRW14aUNsNlly?=
 =?utf-8?B?b3Nvd0hPNktqWlA5d012RlZrb2lhZmYyL3JraklXZ0xHYjExTENpbDVtRUsw?=
 =?utf-8?B?Vy9vbkZ0TWg4cTVMR09VdHlpNm5LVzNXc2d4TThTQnFKbXptRnpScUtRTm5z?=
 =?utf-8?B?NHJrSlZvMkdCM0h3eTlENnlZNDk1Y0krelFJMWRLdW1MU01zcDVoOHlJL1dR?=
 =?utf-8?B?dzM0S2xtY1FqdWhWSWJVNWZOc3NHYjQ0NkZhSGhlOFRLTThoTjNiWGpEUkZu?=
 =?utf-8?B?ck1vNnBrSjZWbHk0VmRqVUlENnVHQXNvbHhvNVBSRTQ5UUF6OXZ2cnQxMlpD?=
 =?utf-8?B?M0lhREdSTEdzb3ViTEJqVWxLK2ZYTFNTbG85akdkRlFCOHozRlZVTmFrL1B4?=
 =?utf-8?B?OVg4MHZTdzhEUmgwY0tKRlU2bUFGc0toVW0zZzA0NjF6cWhsL2g5UVlITEM3?=
 =?utf-8?B?T21vY1pyT0pqajZSQlZFNUJsTzhoYjV6KzRBUkpDNkJRU2ZuRkJ4OTFwZUJx?=
 =?utf-8?B?MjY3TnQ4djJQZDc3R2FWWHhJSnVuRmhDTHlxY3B0eFRXcU54RGhzVmlIQitv?=
 =?utf-8?Q?7UpDpctf4VI2Nl0Suc7SZSapW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17de1149-9c7f-4b7e-c30d-08da8c59c555
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 20:37:21.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eId0/9SOwkPKbILLLIi1LvkPN1N0QQi2fOKyEiV3X1PKN/3xTflCgHuWFeBSaZn4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:14:24PM -0400, Matthew Rosato wrote:
> On 9/1/22 6:25 AM, Robin Murphy wrote:
> > On 2022-08-31 21:12, Matthew Rosato wrote:
> >> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> >> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
> >> domains and the DMA API handling.  However, this commit does not
> >> sufficiently handle the case where the device is released via a call
> >> to the release_device op as it may occur at the same time as an opposing
> >> attach_dev or detach_dev since the group mutex is not held over
> >> release_device.  This was observed if the device is deconfigured during a
> >> small window during vfio-pci initialization and can result in WARNs and
> >> potential kernel panics.
> > 
> > Hmm, the more I think about it, something doesn't sit right about this whole situation... release_device is called via the notifier from device_del() after the device has been removed from its parent bus and largely dismantled; it should definitely not still have a driver bound by that point, so how is VFIO doing things that manage to race at all?
> > 
> > Robin.
> 
> So, I generally have seen the issue manifest as one of the calls
> into the iommu core from __vfio_group_unset_container
> (e.g. iommu_deatch_group via vfio_type1_iommu) failing with a WARN.
> This happens when the vfio group fd is released, which could be
> coming e.g. from a userspace ioctl VFIO_GROUP_UNSET_CONTAINER.
> AFAICT there's nothing serializing the notion of calling into the
> iommu core here against a device that is simultaneously going
> through release_device (because we don't enter release_device with
> the group mutex held), resulting in unpredictable behavior between
> the dueling attach_dev/detach_dev and the release_device for
> s390-iommu at least.

Oh, this is a vfio bug.

dev->iommu_group is only a valid pointer as long as a driver is attach
to the device.

vfio copies the dev->iommu_group into struct vfio_group during probe()
but then lets vfio_group live independently. Particularly the driver
can be removed()'d and the vfio_group keeps on going.

Thus it is possible to UAF the iommu_group by referencing it through
the vfio_group.

We must wait during remove for all the vfio_groups to stop
referencing iommu_group.

Something like this or so:

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index eb714a484662fc..d8f40b22c98ddb 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -65,7 +65,15 @@ struct vfio_container {
 struct vfio_group {
 	struct device 			dev;
 	struct cdev			cdev;
+	/*
+	 * When drivers is non-zero a driver is attached to the struct device
+	 * that provided the iommu_group and thus the iommu_group is a valid
+	 * pointer. When drivers is 0 the driver is being detached. Once users
+	 * reaches 0 then the iommu_group is invalid.
+	 */
+	refcount_t			drivers;
 	refcount_t			users;
+	struct completion		comp;
 	unsigned int			container_users;
 	struct iommu_group		*iommu_group;
 	struct vfio_container		*container;
@@ -276,8 +284,6 @@ void vfio_unregister_iommu_driver(const struct vfio_iommu_driver_ops *ops)
 }
 EXPORT_SYMBOL_GPL(vfio_unregister_iommu_driver);
 
-static void vfio_group_get(struct vfio_group *group);
-
 /*
  * Container objects - containers are created when /dev/vfio/vfio is
  * opened, but their lifecycle extends until the last user is done, so
@@ -305,16 +311,21 @@ static void vfio_container_put(struct vfio_container *container)
 /*
  * Group objects - create, release, get, put, search
  */
+
+ /*
+  * This returns a driver reference. It can only be used in the probe function
+  * of a device_driver, eg as part of the internal implementation of
+  * __vfio_register_dev().
+  */
 static struct vfio_group *
 __vfio_group_get_from_iommu(struct iommu_group *iommu_group)
 {
 	struct vfio_group *group;
 
 	list_for_each_entry(group, &vfio.group_list, vfio_next) {
-		if (group->iommu_group == iommu_group) {
-			vfio_group_get(group);
+		if (group->iommu_group == iommu_group &&
+		    refcount_inc_not_zero(&group->drivers))
 			return group;
-		}
 	}
 	return NULL;
 }
@@ -364,6 +375,8 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
 	group->cdev.owner = THIS_MODULE;
 
 	refcount_set(&group->users, 1);
+	refcount_set(&group->drivers, 1);
+	init_completion(&group->comp);
 	init_rwsem(&group->group_rwsem);
 	INIT_LIST_HEAD(&group->device_list);
 	mutex_init(&group->device_lock);
@@ -422,8 +435,28 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
 
 static void vfio_group_put(struct vfio_group *group)
 {
-	if (!refcount_dec_and_mutex_lock(&group->users, &vfio.group_lock))
-		return;
+	if (refcount_dec_and_test(&group->users))
+		complete(&group->comp);
+}
+
+/*
+ * When the drivers count reaches 0 then the group must be destroyed
+ * immediately. A zero driver group is a zombie awaiting destruction.
+ */
+static void vfio_group_remove(struct vfio_group *group)
+{
+	/* Matches the get from vfio_group_alloc() */
+	vfio_group_put(group);
+
+	cdev_device_del(&group->cdev, &group->dev);
+
+	/*
+	 * Before we allow the last driver in the group to be unplugged the
+	 * group must be sanitized so nothing else is or can reference it. This
+	 * is because the group->iommu_group pointer is only valid so long as a
+	 * VFIO device driver is attached to a device belonging to the group.
+	 */
+	wait_for_completion(&group->comp);
 
 	/*
 	 * These data structures all have paired operations that can only be
@@ -434,19 +467,15 @@ static void vfio_group_put(struct vfio_group *group)
 	WARN_ON(!list_empty(&group->device_list));
 	WARN_ON(group->container || group->container_users);
 	WARN_ON(group->notifier.head);
+	group->iommu_group = NULL;
 
+	mutex_lock(&vfio.group_lock);
 	list_del(&group->vfio_next);
-	cdev_device_del(&group->cdev, &group->dev);
 	mutex_unlock(&vfio.group_lock);
 
 	put_device(&group->dev);
 }
 
-static void vfio_group_get(struct vfio_group *group)
-{
-	refcount_inc(&group->users);
-}
-
 /*
  * Device objects - create, release, get, put, search
  */
@@ -462,22 +491,6 @@ static bool vfio_device_try_get(struct vfio_device *device)
 	return refcount_inc_not_zero(&device->refcount);
 }
 
-static struct vfio_device *vfio_group_get_device(struct vfio_group *group,
-						 struct device *dev)
-{
-	struct vfio_device *device;
-
-	mutex_lock(&group->device_lock);
-	list_for_each_entry(device, &group->device_list, group_next) {
-		if (device->dev == dev && vfio_device_try_get(device)) {
-			mutex_unlock(&group->device_lock);
-			return device;
-		}
-	}
-	mutex_unlock(&group->device_lock);
-	return NULL;
-}
-
 /*
  * VFIO driver API
  */
@@ -576,8 +589,10 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 static int __vfio_register_dev(struct vfio_device *device,
 		struct vfio_group *group)
 {
-	struct vfio_device *existing_device;
-
+	/*
+	 * In all cases group is the output of one of the group allocation functions
+	 * and we have group->drivers incremetned for us
+	 */
 	if (IS_ERR(group))
 		return PTR_ERR(group);
 
@@ -588,18 +603,6 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	existing_device = vfio_group_get_device(group, device->dev);
-	if (existing_device) {
-		dev_WARN(device->dev, "Device already exists on group %d\n",
-			 iommu_group_id(group->iommu_group));
-		vfio_device_put(existing_device);
-		if (group->type == VFIO_NO_IOMMU ||
-		    group->type == VFIO_EMULATED_IOMMU)
-			iommu_group_remove_device(device->dev);
-		vfio_group_put(group);
-		return -EBUSY;
-	}
-
 	/* Our reference on group is moved to the device */
 	device->group = group;
 
@@ -702,8 +705,9 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
 		iommu_group_remove_device(device->dev);
 
-	/* Matches the get in vfio_register_group_dev() */
-	vfio_group_put(group);
+	/* Matches the alloc get in vfio_register_group_dev() */
+	if (refcount_dec_and_test(&group->drivers))
+		vfio_group_remove(group);
 }
 EXPORT_SYMBOL_GPL(vfio_unregister_group_dev);
 
