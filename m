Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBEF5AB762
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiIBRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiIBRV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:21:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D9FB290;
        Fri,  2 Sep 2022 10:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxUBAx1ctZD+/ohrzpNBKnZu6JQRslXQiREag1Zlq28Xh91v1Sdehq3Rm0APx/DbJId9QnziApVlPtSsaeW05mYhOuwGG1pFqlaJ216Fz4l1APqBpMlgDIB9Gb4Vr3iKyHTsGqKaiI3A/sLCbP2GlzCZFi9an1rYykm6TB4N98OCaZxwQEYRvBRbLcZIrWSz1hdCesXvuU1HAxrp9YteOIT/8ouYYkINHX78sm6Lc/nxt4q0tUphLKXfextRdVQgy+SKBaaVwctEgezgOisqrsDn6frToXMs++1ZFqV8+VEAniULDPvUrM6foa7Hsa2JY74MO4d9nRyKI6cQeY812g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe+rL4yj5pw5cL06boe6wXg9VrdDBh0uUxD1frItZ3k=;
 b=IVm8sKUaMbiPCEpmwYtWb4YHVOG9hmldiU/WH3tkXjxgElcJ4sjuiEnbX3wWKpe993/BCO/7d32DsfoyzDKATIp42KSPm1lCJSb0Ibvd2bQKYzYEyube+HVVR6wV4kX507hIS4u2xxGMHDpn+gMoeKCh8xIleBpc+52yz/ixZyQfKoryJK7BNay02tS5yZAxz9zpM/hl4ICDoa/IzEV3VOoP2eJU7wkEemyM8nkrmd93JD5hmR20VcbkLxrHU27nKEoHKUcKo/Xa+liIyg6Xp5naTN0syf0Kupr2FRaAVkubm8tV0tb+kjxfXDTgKY0XlK2tmidObf9WW/v9Bi51hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe+rL4yj5pw5cL06boe6wXg9VrdDBh0uUxD1frItZ3k=;
 b=QJ2sPtlkWNEX1KCHVjvAT0aQTELpA0OYgVENq0C/syDFSz4/qtF52KsvgeeT2WFLKA8xb+Jzu0LaDPJ3jJIBnXzw2ZUZjxlU5t77mEvWVJSQzU6wq0VjGiuKPs7UlumU/+c/TcmnAVSVxsofIhWIiKzd8EIIkAkP3oTaCU3IYx+UfA59STPsQw9/cjwRS6utW2vGssWYaH7lePmPolg4Cj7+guRJwmnD+4Gr1EVO844hjhpF/tFPj70MWY25V2FtGIYPS06c0zk26oYbvz89KunvMEQr50GDE5/RdbG3zw0Uu8XLAFX62Pc1ZTZ2KXgwthjDV50M5VYSH76EX8oiJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 17:21:24 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.016; Fri, 2 Sep 2022
 17:21:24 +0000
Date:   Fri, 2 Sep 2022 14:21:23 -0300
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
Message-ID: <YxI7kzuchcJz8sRX@nvidia.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
 <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
 <YxEYAcFK0EdahXzJ@nvidia.com>
 <273fdd58-549c-30d4-39a9-85fe631162ba@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <273fdd58-549c-30d4-39a9-85fe631162ba@linux.ibm.com>
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c58250-e7aa-4f35-250e-08da8d078f97
X-MS-TrafficTypeDiagnostic: CY5PR12MB6274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWZQy1kfCWfZM0PMFycsCOCve2YUqmPKSREIR/dcubA6Oo1odD8mZLM5AX3JQkUtpqCs2OAXVjdkIEETA6XoBJtXxn6teBFw9EZTEwm3YKAV83L2cJky2o9LkODIV5Ik5xVQD3KH00D2CTBDlU4Cma6Vj/eIoN6THmFNEtSRQLn1PqTFCIOOKsSYmwKYFRVX7vvuKVg3yGNYwXqOqsBWlK6Etuylpg0LSOMasxpbME/P+KPsTRbS/5P5Z9yo7vkJct7K6osTv5DaYTMuJbpUXbGwsqNTz+/W02ZNikw7EDS0asiM4hDoPOEDTMAj3h10AHI5neO7nrgptekstYinGujz7O45JMqT6AxJEJ1ZkYGcq2Zk9DHg2pYSHHmdMiVA0OmFjZ9F0jHdHuvNOqlD7EheflnR5n6DpOR0xcGqiQLX40OVTKEzFvJgT67grJRm4ZpW8bosLBMryvNx7dK06lencYkL2Ho9SLA6fNSmBL/KOQqJ7RkwXPIgw3xXJfytddkttbJ2XLduaE597nkZ4WDa4us/ly2toHdNGDXPdHX4SYJbNPOCckotVRqVk5GbiM4V5xGxTzRsOYSlK2qV0PyCwm+3Ny23v14bjQ1hdVeHSl86THkvM3FCnsYjkDxQ6CbnXtdgfoC8tQu0vNP/GkgJJsam3l27zaaqpLTjiTETP+eWqDr55MxYoBTnCNv1YtczDpmWheINgsm8T9b31A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(26005)(53546011)(2616005)(186003)(7416002)(5660300002)(8936002)(6506007)(6512007)(36756003)(478600001)(41300700001)(6486002)(86362001)(54906003)(316002)(6916009)(2906002)(38100700002)(66946007)(66476007)(66556008)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklQcVRrVFZvMEZOamc1L3ora2dtNm1RNDZEeWpZR2Z6NFAzNzRhdkFBeXN3?=
 =?utf-8?B?T1Z5bSt6ZFlSeExRd0lHZ3NmelVudFdKcGNGWGcxNnRaTm5Sa3ZVRThOV3Ar?=
 =?utf-8?B?NEVOSEY2d29sRjdKaFdHM29JSlJ5dFZ6b0JWNVhMOVozVi9ialdxalBTWW5L?=
 =?utf-8?B?Slc1cVB1RlRza285OGNCNjlkMGlxbnpkR0ZLcUEyK251eTlPYWpJNExYQnFV?=
 =?utf-8?B?cExDdENsZWRqRE9qWFVPQWR6dlNVQ0ZwQ0cxQVo0NVFBbW9FR1plSUsrV1NX?=
 =?utf-8?B?OWJIK2VkYzl6TDIwbWh2ZUUwOXUrcnVWU24vaE9qUmpRS2lyMmdkSUIzb3g0?=
 =?utf-8?B?R2ZKOUlySHNHMkpRSlcxRlNkZmVybW9pWnMxeWZrbVlWS0o4ZVFHWFZnU3Jr?=
 =?utf-8?B?QkgySGJ1UnZMSWtrYkc5S0xaN1d0ZUs4d1NmUjlWeE9hU0llWGI5R1NlN3BT?=
 =?utf-8?B?K1hGUFlFUjlJUFh5eTZjWnNhUGdRRWMvMDM3eUpuMUd2OWhKV28yYzE2VUs1?=
 =?utf-8?B?aG8vSzJPQThUYVlwVW82YVZ0UUV0elpvNlptZlZiTjIySzgyZ0tMbzQ4dGFq?=
 =?utf-8?B?akZHSG4yQmR0Z1VPZnVKQTJiR0ROVlE2anllNVBUeksrS1N2bDBwS0k1VGZj?=
 =?utf-8?B?ZlpWcGY4MkdBN012TDM1c203aXpEdXJPOU42QTQ5MHM0UzVhRm1kS2tEUnNH?=
 =?utf-8?B?VzdHNi84aWs1VldZUGR6Z1c1Y0t0K2thU0o3L2FDY3ZGclJsdUZxWVNVSitz?=
 =?utf-8?B?bE9oK1lPZVliS2o3OVFzbkltYStxQ0FSOGRtakd4ZytpbVJDZ0Nzemd0ZDJm?=
 =?utf-8?B?dWJKVU5tTTdkTThZUDYzS2pRQkNaKy9UZXg4Q2NuMFc1OWQ1YTZIODVORU00?=
 =?utf-8?B?aEZJKytJMVhVNUR2cHNaRjl5VCtkaUp5MzBZQ1Q5aWxqWDVFTTMzM0M5WmlS?=
 =?utf-8?B?K3NwSVJodHM5SVZnbHA5bWgvWWJ0QzQrVmlKYk42bFBBOFpOUHUvTC9jTUgw?=
 =?utf-8?B?WlUxWGgya29IWlFodHNham5zMUg5aE5qQ214bnJFL2ZGdnpSL29kVWQ0cnVl?=
 =?utf-8?B?QjRJbk5kZHlZOUFMWTNKbDZncHFteEFRSGhDR2dwZkVoSnNCZnk3ZWQ4Z3JI?=
 =?utf-8?B?YnYvY0JFY1RBb2hxMTBlb1NmVlI3T3JHbElFdU9rRjV2L2pPQnNvMlhHWSsy?=
 =?utf-8?B?U1p3eFV0ZitVWmUyV2l5TWJDaEN3TVVtRG95UlRWSWZBVW5WMUNLVU5YMTRC?=
 =?utf-8?B?YjJuZzVQbkUzNUNxSEZOYk84eXdndDQ3NzRVcHl2L2pkcDdVN1lib05yR2lh?=
 =?utf-8?B?SVZnand0MWY0UnNhbGFVQjBLQmw2TDhWNldCRitwVTZPQ0hIckYvQUVhaUVy?=
 =?utf-8?B?RWREQ2hUK1pVTi9hVFZYMUltamo5Wng4dW9lamlhNmhKdkVKOUNOd3U1UkhS?=
 =?utf-8?B?VkJjcWZzeXVab25iU21PbE8raEE3Qzc4VENuakN4aFY3dFNqQ0JndGM1RS9S?=
 =?utf-8?B?NkFMZEROblBGcWEwK1Vsb3pidFU0TXgvYUY0ck5veDF3LzVsZXNQOVZyL1BM?=
 =?utf-8?B?UXRLMXRtL0FSSzBocVNsRk1odUhvajNMWXFrODlqTjhKRVNWNHZnZUtzRkFs?=
 =?utf-8?B?aDlzb0dWU3pqU2JzSDlNZjJidjNPUzJoRituNzlDR1hKdzFpeERidzBYVjhi?=
 =?utf-8?B?ajk3aHNoMVk5SmlVNkJwdkMxRzY3UjgrU25PbC9KbGs1c2NXbDMwZVlnK1Jo?=
 =?utf-8?B?cVJoamF6OFR5RjRjZ0tQbmdROEVFMW51azQwU3RCcnVIWGd5c3FSUGQ5MXB4?=
 =?utf-8?B?NzV2SzFLYVNuUWIyL1BpWktwMWp3S2tIR1lLSnF4MWpQTStKdnNmd3dSMndO?=
 =?utf-8?B?UjVZY3BsbHJEeUI1K3RuMVdCWllwT25Vb0t2ekQzSGNmN3Vna2ljS1JOVWFD?=
 =?utf-8?B?enJRUnhIV0VBUGVaOTVVV2QvbGljNGQ2dTk5d0lXYzJsUWo3eUxhOVJDSGdh?=
 =?utf-8?B?aUhBMnFnOFhHU005aiszelgzUzFzU0Q0b3cxeTYyYnFGV25ETXN6a3NFWURK?=
 =?utf-8?B?NHYyTGwveC9MdUFZYkxDcnNMTGsvbDhGUkZScC8rbVEwSEU0aTRjYzFTRzdy?=
 =?utf-8?Q?yHZAF1kH+BvdMBaqhpRLfO9kj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c58250-e7aa-4f35-250e-08da8d078f97
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 17:21:24.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjCW+eRvkBQdHOpovFqdUQgTOLYfpkAqiP91K1XDmpDs9sE1hFViJV8WFXwGkywH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 01:11:09PM -0400, Matthew Rosato wrote:
> On 9/1/22 4:37 PM, Jason Gunthorpe wrote:
> > On Thu, Sep 01, 2022 at 12:14:24PM -0400, Matthew Rosato wrote:
> >> On 9/1/22 6:25 AM, Robin Murphy wrote:
> >>> On 2022-08-31 21:12, Matthew Rosato wrote:
> >>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
> >>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
> >>>> domains and the DMA API handling.  However, this commit does not
> >>>> sufficiently handle the case where the device is released via a call
> >>>> to the release_device op as it may occur at the same time as an opposing
> >>>> attach_dev or detach_dev since the group mutex is not held over
> >>>> release_device.  This was observed if the device is deconfigured during a
> >>>> small window during vfio-pci initialization and can result in WARNs and
> >>>> potential kernel panics.
> >>>
> >>> Hmm, the more I think about it, something doesn't sit right about this whole situation... release_device is called via the notifier from device_del() after the device has been removed from its parent bus and largely dismantled; it should definitely not still have a driver bound by that point, so how is VFIO doing things that manage to race at all?
> >>>
> >>> Robin.
> >>
> >> So, I generally have seen the issue manifest as one of the calls
> >> into the iommu core from __vfio_group_unset_container
> >> (e.g. iommu_deatch_group via vfio_type1_iommu) failing with a WARN.
> >> This happens when the vfio group fd is released, which could be
> >> coming e.g. from a userspace ioctl VFIO_GROUP_UNSET_CONTAINER.
> >> AFAICT there's nothing serializing the notion of calling into the
> >> iommu core here against a device that is simultaneously going
> >> through release_device (because we don't enter release_device with
> >> the group mutex held), resulting in unpredictable behavior between
> >> the dueling attach_dev/detach_dev and the release_device for
> >> s390-iommu at least.
> > 
> > Oh, this is a vfio bug.
> 
> I've been running with your diff applied today on s390 and this
> indeed fixes the issue by preventing the detach-after-release coming
> out of vfio. 

Heh, I'm shocked it worked at all

I've been trying to understand Robin's latest remarks because maybe I
don't really understand your situation right.

IMHO this is definately a VFIO bug, because in a single-device group
we must not allow the domain to remain attached past remove(). Or more
broadly we shouldn't be holding ownership of a group without also
having a driver attached.

But this dicussion with Robin about multi-device groups and hotplug
makes me wonder what your situation is? There is certainly something
interesting there too, and this can't be a solution to that problem.

> Can you send as a patch for review?

After I wrote this I had a better idea, to avoid the completion and
just fully orphan the group fd.

And the patch is kind of messy

Can you forward me the backtrace you hit also?

(Though I'm not sure I can get to this promptly, I have only 4 working
days before LPC and still many things to do)

Thanks,
Jason
