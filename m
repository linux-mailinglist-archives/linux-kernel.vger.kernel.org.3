Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448745AF014
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiIFQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbiIFQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:14:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1719F1B9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMuojgoftsuj0RYT4Px+DRGL2KJPb6L4Pyqb1wInEobGyi4aDJe8XV5+RoPO+Lp5VGQ9SE5RsPJEMiDfDx9ZFOksltFSLw69KAccdvsgSqDCoLbUEIEe0mZSd4Z2wMZ5LkXgL0/mQ5GqE+qCGDNveyFZqXFMj9Abjb01cSSGCZ9gml1PpYNrGthNA1XfOYdp2Z7HvzQUMQr9uh++OT3A4AMUrEoN9oV4YqqwlcH8Zo81PTNSEAv0VVrK8OHZUb5Ls7p8kIEsqE11wfQMZzVsMK+cXKeE43BhWnx/nr76+bCzV3MLSO5oRryCIH2KERjglB3VgIxtzEwfpT6tq1b4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2lzqpdqLGV9cdtwbnhaIOYYyRh7ANbLkB7fpc/bZAs=;
 b=bWsNyvljnjnGZkQRdqIRtLiw2TjIvtaA6LwMRxChMhaN8CWWO0mKUp/r8QaV5zYUGk7A96PHC8oqAuJ4Q8DUtw/GgWZ0g751Is0N8VT2WsN8sD1oZv394u9LysJ8+HXdRGka5mY25IOvw6D0xv8/QBfdbvgsqZg4AX+KOpbB/uPXA31cAU8QyMt/A7uZWE+UoaTJ5mK6dAKPSJAmTIAq7/9Y4RnUAwqEgE1R+ir4xA2BymsijunVjDLAv65hvwZBj1Keg+45jpX463j+XkeWlhDYP8/jFDeJhUkXOpDepUYV8A+Uj8LYTVKKmHf1aVFgJ6wD2UzYt3qlF0nwbg++dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2lzqpdqLGV9cdtwbnhaIOYYyRh7ANbLkB7fpc/bZAs=;
 b=ShAWoOdrPjPWSCnDJEvzFIfp3Vss8m/IgMd5w1q2zLvTa/MuhRC6xf7iULDGpG7b42OxECmycM7/Eeoj3VmDzLNLWttuWdVdKq3fg7Q2F+cgjxxBORyXnWMsJdMPZZEbbTbT8dad2F5FjCxlMH0kXhdSkHrt4WWpSwynLxnnN72aGXBkRzdpsyhx/4+T582hxCcdIN/hndN4kCoYlWz8tp47MU9lTGcXF/EgfqalA5EOxoIDqZDV9Z8RVHSlIn6z0m59ruj+FTAh19lNKSG1r4GHJb9YpucrpTtG/g8RlpNuNZVTV04OTHmavY+0AQ7/8BwHg6vLhgFCHS6UiJh1Kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 15:41:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 15:41:52 +0000
Date:   Tue, 6 Sep 2022 12:41:51 -0300
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
Message-ID: <YxdqP9i0bEwUg4VJ@nvidia.com>
References: <874jy4cqok.wl-tiwai@suse.de>
 <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de>
 <87ilmjqj1f.wl-tiwai@suse.de>
 <20220823202824.GA4516@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823202824.GA4516@nvidia.com>
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a07af00-9194-4216-472c-08da901e51ba
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3x1MRweziISalQ8/joRf5OVshK8OVyaJpZKrHKGBDy75AaOWYz0sxwWu2YLVtvP9+9UiOVSI8AQu6j1cHPTOYVplWO1Df80UVaL/T40guME8N5Ycen5hXYHmeDmzG/d7aMXVCKgHgWakeuc5TrFqtvUN7GzL8q1ALMjd7YXNyRv+kgp94zFz2AXdWfbDz4tEJsu8eSw3p/v5SqNpDBtwkuFtLyU1fgAhymUP0zpyT5SvlZaIkWY8x/2320iZNxfEFAOp4ZFlHPyFbtt6dlf7wZWio7AuW9c7BgxV8uYOjpu6EGn/xCT2o0ArQCl6xB/ZuK6CEj1S8XYwFEhD40Lt8W1hn83Dpc7JjGU+utGb6jjuK6ZN3Gj0TmBgJ7aY19H3lQYlVPdz5hfsUREkLEYOJFKNyOt7rVG5PN88zwgr1RK05KUIflMOiQxrq5PPOtlVE/z1y7j8Zhq88trUlKDKXTdHL4hlYYXX1ZiWF5yq+2QQg0scXaKUg2++uQuZLzIbJ2lTITXyizGCYQTVzAzFbPYdEl2czH98xQVue9VidEn0L+kX36NT/62BXjpJDD+yOPg4tomQFxETtgPvurEqxS41nCaZV+0gArM9jeMaQJRH7JUmZUcw5Vv15GieP2rLiMsh1Qtvf0SYDjWCL+jKQzri7Z5m4XT5qrUSvY0J01NDMBGOqXA6Ma4dQPFVp4ummXtxb4S2OSuRqC3HObKS989EsAnG9vc9dejiL99YqXbX5kLXtaaxBnm7rJtNLDDbOrOhJnU+bilGaCQp8UvE8VzaE7Oy9BsjRWVJDlX2SjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(4744005)(6916009)(316002)(54906003)(86362001)(36756003)(2906002)(38100700002)(5660300002)(8936002)(8676002)(66946007)(4326008)(66476007)(83380400001)(6512007)(6486002)(2616005)(966005)(186003)(6506007)(478600001)(66556008)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7zZbsDTKLV7QZpwrGxrkrqzpO1KrHDzjAh+gOykcuZCmxRPaqNREM4R8wAqY?=
 =?us-ascii?Q?TIh6C7BTvQvBGxAMHNGvO6MhXim3Ux1ohtANsQQzq1XpPnq/tM/7n9tfiFzj?=
 =?us-ascii?Q?e6ajwRslYO9EMag+46e42PR3qrCvw4l1iaSofNI+FMjSpe0LHBp1eL6ZG55X?=
 =?us-ascii?Q?mTQqweTXVDQCZ9YHi9qxTt5rR24X+0++GyUHpJKGELsh+V4e3hhzJ+qtHR3u?=
 =?us-ascii?Q?oBkSS2Vs5dcEkQhgdTp/Wj0qsvluXyJuvSpHFxUI7u+QS0ka8tuhS7p1udHe?=
 =?us-ascii?Q?xTNmbxuNiJnatKXdx7oLdlqYglATKB3o3YjAjvOto6NlJzsdossbvV51/u9d?=
 =?us-ascii?Q?c/B/U5GDLf3QQQkVLZ0OZipVBR2R8NPw7kCuEiQ2FK/JpkFeFXqo1eeQW+UU?=
 =?us-ascii?Q?WzfzCYhO7h0LuSp5XrHNu/b0BtK+SrNtgOoPKuREjnwv3PWJdxmAzFzJsmFB?=
 =?us-ascii?Q?iLezwVxw9Rk1U+9j0xIEXfzaTeVvt4SNEnX0RSaocuSLJKPhBHMURWMkXLLo?=
 =?us-ascii?Q?xJkA1ZxyaWkeSTihcjw+xOfIgbWGQj9m0b8ZDpbkJvxd5M5usngse6oC/CAX?=
 =?us-ascii?Q?E0gl8W/OcSbQXbGjQNFMPC9jL885l2j/B0ZGyCS6+Iw0PVfQLmQvMQJlQqPg?=
 =?us-ascii?Q?NNJbgOvHcYpGgicZkHposFaDzCx9aOnAaLA3276GKWvIcKDEPtw5hbyr3emM?=
 =?us-ascii?Q?ybb6DuGb5C+zCcOnM3gG1E2osvUcRl4h6g+okp+p4OscPsGreaAd8bWq7AAl?=
 =?us-ascii?Q?e5eVRP/5f7Ou43k4obGSEjuHmcKzlhP84hL21yb0gNwaBAc0tFvj2VxQlKmk?=
 =?us-ascii?Q?HcgLXRucWQRO/bUCNBD9vOfkBAUUPvGVC3Sdl/AXaRoqZg3WjDkhrLdd4Ro3?=
 =?us-ascii?Q?m4fc+AiyEreL545j1EvBTgOZKy6l0ZcnjQcG6/Fqv1Xq9UG47DIch9dEjRIp?=
 =?us-ascii?Q?uPmCp7lnbspVr93glDgyAUEUeZy39X7zwRsdHVear0WM9aQ0mmoRYkFhnJ3y?=
 =?us-ascii?Q?FKKgnasQgVa30FwxwOMDlugAcxjjo1A8O3V9sr7yIUEttyrk0vApXy26cQyR?=
 =?us-ascii?Q?zBktWfRESMsWFVH3DsnECs+BmCQ3y9e6b6+hle9wxxm/ywG/K9Mow+T6e+aN?=
 =?us-ascii?Q?rxuB+H1IG6F1ZiEkkOvZcR0uFBQDl/Fox3mTfaF6zXIl2tpHP0sl56mhttdB?=
 =?us-ascii?Q?n4epaBHk1qPkoTZFLKZxiodHsuB8kDZyiY3z52aeHO4uddPw6tOzFvwMeGlc?=
 =?us-ascii?Q?0BWjY9xOsYPooplsgoWpm192X9Q2GDT1hv6fLz24kKrqbTPV2woKo+10lsbb?=
 =?us-ascii?Q?BzqsFdxm+3MK1xBFf/dwU87gVH9RnN51f6ZBU3G97GB7jy/076qe3Eo/ow7u?=
 =?us-ascii?Q?o0kPoLEekg4Z3JW414U6fA6RKa3mPzIEi4N5FQPLXyGMV9ETO8O71511Ge2p?=
 =?us-ascii?Q?DvvwamdE1Pr1v6fHKG9U+jhq2ofOhZaSxZil1W+/rGf+DDj96ty3wRokdAoc?=
 =?us-ascii?Q?92NnwXD4+55yI+vtr7DXW+imfuVO52fLgVMYpTZPuwB1/H91v/+9IjD5hISK?=
 =?us-ascii?Q?1Qfy/pTTzeuqSLvmpL9e/qZrv7FEYwBCNFfjAFqJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a07af00-9194-4216-472c-08da901e51ba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 15:41:52.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxfXlt7RqgX+vjpL+rqbq8A8Q8RV2GqOA/5nYFXVZYwr1Rmt1XvgRDpOxDHuu5QY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:28:24PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 23, 2022 at 01:46:36PM +0200, Takashi Iwai wrote:
> > It was tested now and confirmed that the call path is via AMDGPU, as
> > expected:
> >   amdgpu_pci_probe ->
> >   amdgpu_driver_load_kms ->
> >   amdgpu_device_init ->
> >   amdgpu_amdkfd_device_init ->
> >   kgd2kfd_device_init ->
> >   kgd2kfd_resume_iommu ->
> >   kfd_iommu_resume ->
> >   amd_iommu_init_device ->
> >   iommu_attach_group ->
> >   __iommu_attach_group
> 
> Oh, when you said sound intel I thought this was an Intel CPU..
> 
> Yes, there is this hacky private path from the amdgpu to
> the amd iommu driver that makes a mess of it here. We discussed it in
> this thread:
> 
> https://lore.kernel.org/linux-iommu/YgtuJQhY8SNlv9%2F6@8bytes.org/
> 
> But nobody put it together that it would be a problem with this.
> 
> Something like this, perhaps, but I didn't check if overriding the
> type would cause other problems.

Takashi, do we want to do this patch?

Thanks,
Jason
