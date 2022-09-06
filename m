Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB15AEA73
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiIFNo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiIFNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:42:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCCE7E817;
        Tue,  6 Sep 2022 06:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/+vl6EOAYN4zOEo5ho1Jid3O1jfBmKfJt8/r2rBfBni0rF5dhu1GLAxGi3tt0YKi3s7tofmjo//REAXm5s39BQn7NKQuKIvM9gNF7ZVt+3mvXwO7JUBZKgJ1OTpxgYsA/BZOqVBBVeaRxZH20nxgT74SADB6MavRoyGIOxLH/IdGgJOhsxqwcqPBF1+TJ7w6YgnfWxUUcdim6Us0j5c7Rx3QUwuoHW+BAF6ASP520GifhVKFgUBb+47r1Y45ek0qnzDC1zZpR8yzkaEB3R0GJsW0FOnMcntPcq52sD/vsk9cIdC+TEI4Ui+UvOipRYwDlW+LWglUU7i1vX/NiTQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCzWVssRSULZoWfektUvK9x7zXbZ13or+Q/SsoUxBBg=;
 b=oYKFJBF9q9vd7qP4tOScGmIqv+kBzBx4oZyw9yWgcrHVAMNslGyoiMvSxcUWheEkTCGaRIfQGuDJqTpl++QcrOZ/qjx4Gg7WIBQC8Mv9KaMXG/7/jiViAsAm/Omq/31hb7zghl2XJ6cDrZ11yzeObOS3wqrq1gX2hczuObTwbC3iCpbQN93R9hXBlsL94gf2h6sURR5dOgUSSg0KzYXo8B5vX5sqAvarpM1XdgqaypAs1mrllvzADVani3j7jDC5tjjiKLQInjLGpQA2cpRbU1w38vHxz4NdP5fLqCz0kumDVT1+dRguc5klbl5ZzyM1kk3/Xmv0GCSYU4El59HK7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCzWVssRSULZoWfektUvK9x7zXbZ13or+Q/SsoUxBBg=;
 b=CuLMycfwp3mCEwDqIo0Xjcg6xjVm/waDMYVqiBQ6q6BjXVDQryzMBAC3Lw3QgGiMcDNDE5YG+7LD97BXsKYdXeCBYvJKSVxogGnotWv67QIbSpixpjTdI9R+VNgXnVtdtTvQm9at3E7JYjAnhobIIqsuc79thnKEfzlCxFzx8+SpIi3itdtE60GnpDY05aUJ2/61azphuPV9Ks0Rjp05XeinMFafK1qEQ0KOq1eL54dxiRx0fU0XBMwhl4NIBFT8RJ+f77pBb4yF/yuiPmlz0/T9+UZmPjHwe99JDarv1cwy7J4bQWXzNOzZA9XgQGn/6l5odQ3FwDJi8aFFbfSTOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 13:36:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 13:36:03 +0000
Date:   Tue, 6 Sep 2022 10:36:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Message-ID: <YxdMwoC+58NvydY3@nvidia.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
 <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
 <YxEYAcFK0EdahXzJ@nvidia.com>
 <273fdd58-549c-30d4-39a9-85fe631162ba@linux.ibm.com>
 <YxI7kzuchcJz8sRX@nvidia.com>
 <ca1ba9d8-8d68-5869-9905-fce431ca14f8@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1ba9d8-8d68-5869-9905-fce431ca14f8@arm.com>
X-ClientProxiedBy: BL0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:2d::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e82b734-2236-4ce4-f63a-08da900cbe1f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0t5V1fSrMjNK7PrvqgBe/W6N3IAN1hRZ/7r6PCQd+C4FgUUXALL5irTjPj5LdKOrXGB6EJi6J3x+voptsf7SM1hhYkdM60hNFbHdBEe1Zfeh1oHDYOgilhgyOcqXltf9hlZS6fyYay5vRtJljUEZiOsteLRvQFmFynqETxIGh8mfyfsA/pzdvzc3CIDy7oVZgPajwN0+PGryIYkIwVOasJDYf3Qn7iemtzQq/LxVCzEqC48ReHqZblXBl2z3fmXPm9z/cmoJMbwLBprexmqph0C2h9uASOKwj+VqdKkmZjPAjioZFp0iQ+zFjPHZPH7szowyCvkXvfwuOzI+e030PQjmjwv0TeEIxdjXlmvyTwOUVgTDxWFe/J4FsL7+myNdtjF4lg9drafJmQRsJgBp1kZpKwVy1hcPE+/cIgxMVXIg32YSHFg/X7pjndKvIqY+PpjEi0GPOpDv7KeftRMcQFgkcfKFsMT7pzGbvPppezmsc6ToJDa/hlGNWGyrozfAwipF2PgpsjQR9C5E2KGw9gPameZLA6j/oB9l7i/+etJFNUorIrb9u0XmGBB0Hij6Y5TbNjuypUVAH+u0nmHdN8mXnag2UWRLjJ9NwHqrpJMrOU415hN0HJK/AInRzSg9jtdJRrgtQ2SsSnRmPfIJu9lmsVWROWU9/a5gT9SoNMXbS4Sx6w4JXtQ3uGIQ0/n7kTwwF7EvZ33RreV/wSKeOd20fV54WIMeiDWq+nKsXjF7aZbTF6pZGo/ovLarKkV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(8676002)(54906003)(83380400001)(66476007)(478600001)(66946007)(6916009)(36756003)(4326008)(316002)(66556008)(6486002)(41300700001)(2906002)(2616005)(6512007)(86362001)(6506007)(26005)(5660300002)(7416002)(186003)(8936002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSupAg83MF7ITAdU2v3+nebn+/IMlB27jUKd2Lsi38kPw0mL1Iv4C28KDeu9?=
 =?us-ascii?Q?T6NRr8VoTQxWi0xCyPY8r+ABmwGo5Ld6ox4dA4rB3KV8cmOU2d97Dq01J/7B?=
 =?us-ascii?Q?sDaxbvydt16NQh9LYAjOaNPUNB151DMKgda531U98H+oyxItvr80sGJD/kci?=
 =?us-ascii?Q?ddRynxxCJqdFrY4SSJ5ms0SMS/Sf6iHS/+VU9ZI/5a8TCeSIj77cq0jFJsGO?=
 =?us-ascii?Q?eySKgIBDdKksuXVWAJ+QeR3BWwALFR6fp9pwosg36fTS/tPwW7pzajVxnXWa?=
 =?us-ascii?Q?VMedgAeO80o4CnipFwDikp1lL58GANK5tt3EhXKcIsoHtRIqonuiQSlI3awT?=
 =?us-ascii?Q?erIc+2onw0GGsZOPH+tNZC706i74g+7WKl31LmFClz9XjLaYUidi0wYEFs9g?=
 =?us-ascii?Q?47IKjze7lNO8ecfbwsEuu33nZ34FtCWkGIhn4rAKiGv8qYfApENaFUYr3B1J?=
 =?us-ascii?Q?epWTOlE51E1p1NohNc9zZL+m6UinrJTJgYfkw8P/6Vaudm1C7qht9QfOSdhU?=
 =?us-ascii?Q?ZVuscQn50NugOjSdsrrJaJUCC6HTNmPPWJBhY1XkU2xqSZYvL5KizBLylqS3?=
 =?us-ascii?Q?RmS51yDiXFlUhhBq212gdT8670cdNlSDDYY0TJZQrRlcMFxhT2H9FYscbSuZ?=
 =?us-ascii?Q?4rHf13obDQuDx+UJwtSvxgAGkr8VNST+XPUKAcA7P3WQjOu/iCq1DM8F1zuO?=
 =?us-ascii?Q?rE1DfuZPnsd1ErGzDcjiX6/byQANrYcp+XlXfGFjlQkY+bYERyQt+pr+rTMT?=
 =?us-ascii?Q?wdscS/fCUnPhYBLJHSwuXoqMNexHtxig/T1c9Pyb5f++csYYCezkfX2wIJf9?=
 =?us-ascii?Q?k0emKnCRCLEAYKfdlKEb5AqoHYw10IAV+feJPgeFNfPGukZGWicniAOgq//3?=
 =?us-ascii?Q?88gFGHGROUx3nW2o3fXYXyJrdEAJO8Gu4Dzk5ckg0Ef0svzcmMeI9l55Buje?=
 =?us-ascii?Q?lEIIWgIpEj8f82gTK9SKdcUnhkUWQCNZVAgmzdL808BCfbl3E0Co2A69kPAW?=
 =?us-ascii?Q?7O49gEIH77TGAcDlYxY/DL55f/m12twEry1EDOjnicwhtxNcrz/8d/OkhH87?=
 =?us-ascii?Q?/lK8asgMgGnqBBI+tT4iWhuHLN9Sd+HsiqfndKv4hGIgkRYF8tLDNGU1v1yG?=
 =?us-ascii?Q?3+CAgpHqmM2sNQyaeXabPmtQ1sT2bsrmQzlpWswSeU4k06fwtc7EtBp17jjw?=
 =?us-ascii?Q?1pn29FsjptQqf4WnhggYhjCLYfBMv75H0yZ7FQrRJdwBtMRiwa0bYKTF26C5?=
 =?us-ascii?Q?Pnon28KOzxnO+7KQSetpS9uSv8dr1r9cGmdYhSs4JrX7NR+W5msGhVaPwq/k?=
 =?us-ascii?Q?P/wEQJLLVTxp357J+ecuXZdATeDjkYEkqqM6I29HwXozqnJTrTpH4Hl5Ueqs?=
 =?us-ascii?Q?xR0VlU3RksD/oAPXF14HzY/uGa6Cy+YlqEIe5H0At/3tbGgTnRpM6tIY7Nqs?=
 =?us-ascii?Q?SJyMrLbvxLuyxJldiMZ4VBTjW4yQF9P4YKHz6bOTILpwFM/YwH4zuLlqLfJ/?=
 =?us-ascii?Q?TiOZ7diGSdeKUuwSekdE4HGizAFiI2OqmIMF935PSCwXTVFnHLZyDOjalrRB?=
 =?us-ascii?Q?QuPOVaxsUF3Ea0/tnfGmYzPdg4qZDcfGN1jhEjhS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e82b734-2236-4ce4-f63a-08da900cbe1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:36:03.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQpuLiSBs3RdGjzguhSfxkfpfn5k9LSoQ6zfYtQevla/5yDNWbA3zzxc/ifOGJxj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:46:44AM +0100, Robin Murphy wrote:

> > I've been trying to understand Robin's latest remarks because maybe I
> > don't really understand your situation right.
> 
> That was really just me thinking out loud to guess at how it must be
> happening - I wasn't sure whether VFIO is actually intended to allow that or
> not, so if not then by all means let's look at fixing that, but as I say I
> think we're only seeing it provoke a problem at the driver level because of
> 9ac8545199a1, and fixing VFIO doesn't fix that in general. And conversely if
> we *can* fix that properly at the IOMMU API level then the current VFIO
> behaviour should become benign again anyway.

Okay, so there are probably other problems here that highlighted
this..
 
> > IMHO this is definately a VFIO bug, because in a single-device group
> > we must not allow the domain to remain attached past remove(). Or more
> > broadly we shouldn't be holding ownership of a group without also
> > having a driver attached.
> 
> FWIW I was assuming it might be fine for a VFIO user to hold the group open
> if they expect the device to come back again and re-bind (for example,
> perhaps over some reconfiguration that requires turning SR-IOV off and on
> again?)

Once all the devices in the group are removed then something like
pci_device_group() will have no way to discover the group again. eg
in the SRIOV case it will just fall right down to iommu_group_alloc(),
and that gives a new struct iommu_group and new IDR allocation.

So in the general case this doesn't happen, I don't think any VFIO
userspace should attempt to rely on it.

From an API perspective is a much saner API toward iommu using drivers
like VFIO if those drivers only use the iommu api while they have a
device driver attached.

Regards,
Jason
