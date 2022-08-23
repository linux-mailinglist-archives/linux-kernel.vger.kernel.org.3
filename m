Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E54159CD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiHWBAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238899AbiHWBA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:00:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEA24D14F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xyw+8FqCNUlaJX4i2d5thO5soz+1gR2xHKiYKgGjIxILqgPnJABQI6+i9vf26wwXhWnHvhyh+5Yj43rGDHhsG5FEd3l4R7PqlasAmCE5Cjxe2wdo4DB8O5xUUKjcus1dFuoEcSDAD6YWC/vJVQDwbNpJqjIXVwZewfQeOE7mI6EvjTR/tiaSAchn/YmOw6GWgfjPDwL6YHzn7k2POCTNFDv4BXq+v9x9AIov4zHUdYpxC1pef8qZo2CQk4wqCBR1PVHpJwn0lmF61SCDhH+9h1ESrvXpUrnJtX8heMx5bb+0ERE84CPFlwCJcoTFbnNjx3KxICPoJYfXHbjEE8j1gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amDe/rF6jS0EZUlKzZPc+/3iNrHylzVUJqNExQE22OU=;
 b=IoyAJ2gLqZ+iGuyUZkLqNsX/YSk/634zOI6DlZhgi0X3M7EX0xSYtMLWTQmz2qwJy9KFWzBeijX8R52OnKGIom8ZnFEnUKyg4YkZxBy2xj3xgHEvsofxyhNshrLErvKmh+hQEm32646n+M77GIXypjmF/v8mHw42I3At/f924r3YfT3IciHnI51tnEP+lXXOmkV464VWxnS9Xfa7Im9B9aHXdqhlYiIScmFYRNG7xheGzxFafBc171rTNPYwS7Hi3HzaygqpVQ/t4zebdZvF2VQKQLY4RKIR+dP9pzieGdScoMpiBN3ZT8kUDdPovR+KmhywO3UvhxkIwdHWZNXvUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amDe/rF6jS0EZUlKzZPc+/3iNrHylzVUJqNExQE22OU=;
 b=RRe+0taJzh9W+KALahXf5FBIswQzQnVanO7XBW1zhuY+2f0M4cS1OzVlx7OVzopkgF8k/CyMBVmtivmbYwVjbTOVWmVlzBB/+ss1XrchsrmClx8cJenPc5ZEM0P5PPiTQf/j1/ye4GBpNA+SMx6ZiDcDG1VgFPGang/zMs0dOAzVQsbVpiXbcOD1NHO7bc6k4aMteMwWiGzKalrfHxZqw3UI0WtaGD/BrxDSfei5/zbr3uUtKR7IvU8xqWDPyTgrXRbUvZkdmGvPq7cgeMU/LeKflq/3iMsIyCofjk8u/UuhuvXTyH+1kJNgwNG1SMwviaQQzAMk5fScbuToyK0Iqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 01:00:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 01:00:23 +0000
Date:   Mon, 22 Aug 2022 22:00:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
Message-ID: <20220823010021.GA5967@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jy4cqok.wl-tiwai@suse.de>
X-ClientProxiedBy: YQBPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::26) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37d93364-c153-4504-44d0-08da84a2dbab
X-MS-TrafficTypeDiagnostic: MN0PR12MB6175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIM889uwlWrlfLcasoUPtk5Hyeyl6uojidg7JLodmd2bwNmYoKB2HuScg2dFCDE7bTKVjoume4yNLMaS1OPU/b/X6eZ3428lT9S94jhRvXafLsjrO1CnRDQ4FniCC1XsyudVR0/F3YyMpedvmyiy3RqOxQgymIcB9hCZeg3vOZhiGMlBBoXDHlyzeU1vn/gIlXoKII8dDDFKko39IT2RLAEJAGWRTSsd5sICbosicRq8R2EPpBV5WV4H88ceUrXPijBE0CmHEaG7JZikfWsVU9Mi6rZvILI8RD/4/ReI9IOhPiNhb1FLWsenJgzDgjLylrIRmJNvFxXZ9FxyDZh4JqWeCrGmEuN9l4PqSPD9DW3KTsEaNMP8rUMf4fobxxQ740aQn9DaEJf9Fuwt6a9o84XYysuVs7lNB7heytPKlhVbXstB1a1OH9wwYbblpSJQtZHD/FrVcEo/NVU0SZtt8yg9J4c86tl4sdtxtb8EC/6yevrHDDtbYAUEDANEBmc9OljgNJbixTehDQRdViRiXSaFfOUuuflHkDLSSmb3MYwihNX2r7hoh2Iy8WXwhvDQWwMVvlk/vfp8zFkpVzLJRi175Lrak6IgUHDQe5iefkiMpYsKUS6GXJIe39JB7ZkhC8lV/38HE6LQsvRh34Z/yNopbFbmqW9ks/rL7d1bi/TGSQQski4UjnXK/fZBFnzlPpKKlSjPZl9kIL29az7IKSObf1mNbaIvrwoTx80a6P1qZAFKuDwICdre4YX7MzsO96eoqQRCF2uOdaxJ6AsnU1YEbfozdKYuqj7hSDczS2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(83380400001)(8936002)(66476007)(66946007)(8676002)(66556008)(4326008)(5660300002)(6512007)(6506007)(41300700001)(26005)(33656002)(36756003)(1076003)(186003)(2616005)(966005)(6486002)(2906002)(478600001)(86362001)(316002)(6916009)(54906003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JM7oThrkAlzKRs5yLzMfloRjyD6NqDmaj2GuwXckrMeLglM6FIn9eQVKd/ce?=
 =?us-ascii?Q?b+RBhpXJRL2N/gwAPaeIpjXFYL4VRCzLQV0oN9Let1HcHXq+opEww6GbVq7D?=
 =?us-ascii?Q?jAtmrWIN7tU8yJqo0tiD3ZFieveydbnfCPW9A+rGQTTX1t0e/0EdzEqtg58d?=
 =?us-ascii?Q?ZagLF9itt60SxeCCtJ/gzndpqt79kISLx/KybIhRIo+PE0zne9mJ/fX2iRU3?=
 =?us-ascii?Q?Dc4vJpkAC/2eQcfUIzKaKsodbDOJ/iiZM5XEXHzdvof2Roa3rdK0SvG3SU2L?=
 =?us-ascii?Q?sgPF8Et/mhkoHZ50Sep7vseNpkwUMtBGvYTXplKlflg05pkAa2tUjwTGEfMU?=
 =?us-ascii?Q?WKQQyx4CuxY3mU+RsUQpr59SrjoqlscZYHgQ61lYCkRAH3vbOAZIoQQ3ct+6?=
 =?us-ascii?Q?8j9uQGkl35dGYeZEpZdR1ml+Md3TsCgGflnNJ7Yimg4kcmXEMYV6Ik19V5xg?=
 =?us-ascii?Q?j6LECu9FEKrPc9MTHbnm8OxfBsjPPGQ/V0+Mi0F6MlD++vf+12cxwF7iASUV?=
 =?us-ascii?Q?jBSr7k2prNgGhXekvXd1HaBYmPgtKWcKXGcAWHUiv3iNGy+FhZOHnA9LBdi7?=
 =?us-ascii?Q?A0ZXKPh3VUZDqBL1Qh/P3Ojdvdr7s93W4G3NCDcw8GCTn4TvsRRP+k4zrF4p?=
 =?us-ascii?Q?T+zPhPWFcv5tTyJQdbtDX5N0XrNbtcj4C2vGnXLfaV1wkhJ6YLJ6n8MutAam?=
 =?us-ascii?Q?tbqakIOfHZZaM9cYtMAWLWy7ZgUb86vxEMVDM8DteGpqzQ/N7bYfHelP//iD?=
 =?us-ascii?Q?ZImP13VWTQIUF0XpejmvsRw/fpByY+YhjooeF0e9gDTfElb0aOFTErkaD2zP?=
 =?us-ascii?Q?Eh0xDEUh0TDBMTRUJyekodaNCRBTetCT65feUP8dyIRIsyOEeeX4+fPM3gH3?=
 =?us-ascii?Q?iCwzQ74Cy8GjD21iQQzrw74BsTVZdaEvEW4mL5f17FG/0lBxnxYW8twzMc0/?=
 =?us-ascii?Q?97exLOXJulzxPH3Sabv5/s+V5AFTPpnjQbKMU5hslCpfOl3EqvWWIdTcaAgK?=
 =?us-ascii?Q?Mb427XPgTnYt8m/tMyrZUTVr2BN5+mnig+c5r+YJdsYIgVihkRP36iDcvB6I?=
 =?us-ascii?Q?T/CxYFIkHpD/YcZQ9oGa9SSoJN6i3DRTwBdSoT5rCve8ffGC0aX8r6GDl2vD?=
 =?us-ascii?Q?/58Th60wuJNfK0rWZB1ZSRgIUXQ5EpSYT0HwY3rym2Xf3JHdtS2fC1qvgPLn?=
 =?us-ascii?Q?JHZIIjaj6Fced+iq2ZmwxFPSi3PMLoUwRxeYZDI5h84ZU9h/VKGXvJiltWK0?=
 =?us-ascii?Q?1bEAdg++lfclswWECi9dWXhBRqFuNqWqwMSCs1ACOpiQSFjrchgvVOz7Oxlg?=
 =?us-ascii?Q?A9V3Vyw9VyLYa69tYbn4/+ifW2nhuMyzLS7khPhmtzZkFhz8B6QJJ1huW4Aq?=
 =?us-ascii?Q?YgNmd7xCtlK64Il4y/iHgA6JriqoinaZn4I0TGKbX6NU+QEk62AJnGGqSVEq?=
 =?us-ascii?Q?OpQE2WgKrQ35O88Vuu31qeZItkO+KiQx8zhYHZZCbGjPzSiIRqCwWPD4diZh?=
 =?us-ascii?Q?/Pv2xUvfoqn2XgtzxcGNtJUBxwN9ub+geY/zksWS3EEmrFxc1i2F0NjFDGuS?=
 =?us-ascii?Q?HQ9A91N1zStxc66iDdGmQ27FGKJGAkiM6jAIeOPx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d93364-c153-4504-44d0-08da84a2dbab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 01:00:23.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 012HsOw+CiOx7i3YPL9ZjhAbcIFbisf6/qXGeDwxj6QPkSONC5x26nxxYcztC7mZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 04:12:59PM +0200, Takashi Iwai wrote:
> Hi,
> 
> we've received regression reports about the missing HD-audio devices
> on AMD platforms, and this turned out to be caused by the commit
> 512881eacfa72c2136b27b9934b7b27504a9efc2
>     bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
> 
> The details are found in openSUSE bugzilla:
>   https://bugzilla.suse.com/show_bug.cgi?id=1202492
> 
> The problem seems to be that HD-audio (both onboard analog and HDMI)
> PCI devices are assigned to the same IOMMU group as AMD graphics PCI
> device, and once after the AMDGPU is initialized beforehand, those
> audio devices can't be probed since iommu_device_use_default_domain()
> returns -EBUSY.

Can you describe exactly what drivers are involved in this? If it is
the above commit then several devices are sharing an iommu group and
one of them (well, the only one already attached, I suppose) has made
the group unsharable.

With grep I don't see an obvious place where the AMDGPU driver would
mess with the iommu configuration, so I have no guess.

It would be good to have some debugging to confirm if it is
group->owner (should be impossible, suggests memory corruption if it
is) or group->domain != group->default_domain.

Most likely it is the later, but I can't see how that could happen on
a system like this.. There is no obvious manipulation in AMDGPU, for
instance.

So debugging to find the backtrace for exactly when 
 group->domain != group->default_domain
Occurs for the troubled group would be necessary.

If you know the group name it would be easy enough to cook a patch to
throw a warn on when group->domain changes

> domain assignment.  In anyway, disabling IOMMU works around the
> problem, and passing driver_managed_dma flag to the HD-audio driver
> was also confirmed to work around it, too.

Disabling iommu removes the groups entirely, this disables the check.

driver_managed_dma disables the check entirely - which raises the
question how the driver is even able to work..

If the domain is not the default_domain it is very surprising that DMA
can work at all. Since it does, something really odd has happened.

Jason
